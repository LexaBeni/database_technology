CREATE SCHEMA IF NOT EXISTS silver;

CREATE OR REPLACE VIEW silver.stg_users AS
SELECT
    trim(id)::INT AS user_id,
    trim(age)::INT AS age,
    upper(trim(gender)) AS gender,
    trim(occupation_id)::INT AS occupation_id,
    trim(zip_code) AS zip_code
FROM bronze.users;

CREATE OR REPLACE VIEW silver.stg_movies AS
SELECT
    trim(id)::INT AS movie_id,
    trim(title) AS title,
    trim(release_year)::INT AS release_year
FROM bronze.movies;

CREATE OR REPLACE VIEW silver.stg_ratings AS
SELECT
    trim(id)::INT AS rating_id,
    trim(user_id)::INT AS user_id,
    trim(movie_id)::INT AS movie_id,
    trim(rating)::NUMERIC(2, 1) AS rating,
    trim(rated_at)::TIMESTAMP AS rated_at
FROM bronze.ratings;

CREATE OR REPLACE VIEW silver.stg_occupations AS
SELECT
    trim(id)::INT AS occupation_id,
    trim(name) AS occupation_name
FROM bronze.occupations;

CREATE OR REPLACE VIEW silver.stg_age_group AS
SELECT
    trim(id)::INT AS age_group_id,
    trim(name) AS age_group_name
FROM bronze.age_group;

CREATE OR REPLACE VIEW silver.stg_genres AS
SELECT
    trim(id)::INT AS genre_id,
    trim(name) AS genre_name
FROM bronze.genres;

CREATE OR REPLACE VIEW silver.stg_genres_movies AS
SELECT
    trim(id)::INT AS genres_movies_id,
    trim(movie_id)::INT AS movie_id,
    trim(genre_id)::INT AS genre_id
FROM bronze.genres_movies;
