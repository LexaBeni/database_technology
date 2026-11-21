\set ON_ERROR_STOP ON

CREATE SCHEMA IF NOT EXISTS gold;


DROP TABLE IF EXISTS gold.fact_rating CASCADE;
DROP TABLE IF EXISTS gold.dim_user CASCADE;
DROP TABLE IF EXISTS gold.dim_movie CASCADE;
DROP TABLE IF EXISTS gold.dim_date CASCADE;
DROP TABLE IF EXISTS gold.dim_time CASCADE;

CREATE TABLE IF NOT EXISTS gold.dim_user(
    user_id INT NOT NULL UNIQUE,
    gender CHAR(1) not null check(gender in ('F', 'M')),
    zip_code VARCHAR(10),
    age_group VARCHAR(20),
    occupation VARCHAR(50) NOT NULL
);
CREATE TABLE IF NOT EXISTS gold.dim_movie(
    movie_id INT NOT NULL UNIQUE,
    title VARCHAR(200) NOT NULL,
    release_year INT,
    genre_name VARCHAR(150) NOT NULL
);

CREATE TABLE IF NOT EXISTS gold.dim_date(
    date_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rated_at DATE not null UNIQUE,
    day INT NOT NULL,
    month INT NOT NULL,
    year INT NOT NULL,
    day_of_week INT NOT NULL,
    day_name VARCHAR(10) NOT NULL,
    week INT NOT NULL,
    month_name VARCHAR(10) NOT NULL,
    quarter INT NOT NULL
);

CREATE TABLE IF NOT EXISTS gold.dim_time(
    time_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rated_time TIME not null UNIQUE,
    hour INT NOT NULL,
    minute INT NOT NULL,
    second INT NOT NULL,
    time_of_day VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS gold.fact_rating(
    rating_id INT PRIMARY KEY,
    user_id INT NOT NULL REFERENCES gold.dim_user(user_id),
    movie_id INT NOT NULL REFERENCES gold.dim_movie(movie_id),
    date_id INT NOT NULL REFERENCES gold.dim_date(date_id),
    time_id INT NOT NULL REFERENCES gold.dim_time(time_id),
    rating NUMERIC(2, 1) NOT NULL CHECK(RATING BETWEEN 1 AND 5),
    rating_count INT NOT NULL,
    rating_percentage INT NOT NULL
);

begin;
    truncate 
        gold.fact_rating,
        gold.dim_user,
        gold.dim_date,
        gold.dim_time,
        gold.dim_movie RESTART IDENTITY;

    insert into gold.dim_user(user_id, gender, zip_code, age_group, occupation)
    select u.user_id, u.gender, u.zip_code, coalesce(a.age_group_name, 'Unknown'), coalesce(o.occupation_name, 'Unknown')
    from silver.stg_users u left join silver.stg_age_group a on u.age = a.age_group_id
    left join silver.stg_occupations o on u.occupation_id = o.occupation_id order by u.user_id;

    insert into gold.dim_movie(movie_id, title, release_year, genre_name) 
    select m.movie_id, m.title, m.release_year, coalesce(string_agg(g.genre_name, ',' order by g.genre_name), 'Unknown')
    from silver.stg_movies m left join silver.stg_genres_movies gm on m.movie_id = gm.movie_id left join silver.stg_genres g on gm.genre_id = g.genre_id group by m.movie_id, m.title, m.release_year order by m.movie_id;

    with unique_dates as (
        select distinct rated_at::date as d
        from silver.stg_ratings)

    insert into gold.dim_date (rated_at, day, month, year, day_of_week, day_name, week, month_name, quarter)
    select
    d::date as rated_date,
    extract(day from d)::int,
    extract(month from d)::int,
    extract(year from d)::int,
    extract(isodow from d)::int,
    trim(to_char(d, 'Day')),
    extract(week from d)::int,
    trim(to_char(d, 'Month')),
    extract(quarter from d)::int
    from unique_dates order by d;

    with unique_times as(select distinct rated_at::time as t from silver.stg_ratings)
    insert into gold.dim_time (rated_time, hour, minute, second, time_of_day)
    select
    t::time as rated_time,
    extract(hour from t)::int,
    extract(minute from t)::int,
    extract(second from t)::int,
    case
        when extract(hour from t) between 5 and 11 then 'Morning'
        when extract(hour from t) between 12 and 16 then 'Afternoon'
        when extract(hour from t) between 17 and 21 then 'Evening'
        else 'Night'
    end
    from unique_times order by t;

    insert into gold.fact_rating (rating_id, user_id, movie_id, date_id, time_id, rating, rating_count, rating_percentage)
    select r.rating_id, r.user_id, r.movie_id, d.date_id, t.time_id, r.rating, 1 as rating_count, (r.rating / 5.0 * 100)::numeric(5, 2) as rating_percentage
    from silver.stg_ratings r join gold.dim_date d on r.rated_at::date = d.rated_at
    join gold.dim_time t on r.rated_at::time = t.rated_time;
    
    CREATE INDEX ON gold.fact_rating(user_id);
    CREATE INDEX ON gold.fact_rating(movie_id);
    CREATE INDEX ON gold.fact_rating(date_id);
    CREATE INDEX ON gold.fact_rating(time_id);
commit;