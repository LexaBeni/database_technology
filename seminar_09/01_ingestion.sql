-- Active: 1790175047279@@127.0.0.1@5432@movielens_elt

--create database movielens_elt;
\set ON_ERROR_STOP on

create schema if not exists bronze;

create table if not exists bronze.ratings(
    id TEXT,
    user_id TEXT,
    movie_id TEXT,
    rating TEXT,
    rated_at TEXT,
    _source_file TEXT DEFAULT 'ratings.csv',
    _loaded_at TIMESTAMP DEFAULT now()
);

create table if not exists bronze.users(
    id TEXT,
    age TEXT,
    gender TEXT,
    occupation_id TEXT,
    zip_code TEXT,
    _source_file TEXT DEFAULT 'users.csv',
    _loaded_at TIMESTAMP DEFAULT now()
);

create table if not exists bronze.movies(
    id TEXT,
    title TEXT,
    release_year TEXT,
    _source_file TEXT DEFAULT 'movies.csv',
    _loaded_at TIMESTAMP DEFAULT now()
);

create table if not exists bronze.occupations(
    id TEXT,
    name TEXT,
    _source_file TEXT DEFAULT 'occupations.csv',
    _loaded_at TIMESTAMP DEFAULT now()
);

create table if not exists bronze.age_group(
    id TEXT,
    name TEXT,
    _source_file TEXT DEFAULT 'age_group.csv',
    _loaded_at TIMESTAMP DEFAULT now()
);

create table if not exists bronze.genres(
    id TEXT,
    name TEXT,
    _source_file TEXT DEFAULT 'genres.csv',
    _loaded_at TIMESTAMP DEFAULT now()
);

create table if not exists bronze.genres_movies(
    id TEXT,
    movie_id TEXT,
    genre_id TEXT,
    _source_file TEXT DEFAULT 'genres_movies.csv',
    _loaded_at TIMESTAMP DEFAULT now()
);

begin;

truncate bronze.ratings,
bronze.users,
bronze.movies,
bronze.occupations,
bronze.age_group,
bronze.genres,
bronze.genres_movies;

\COPY bronze.occupations(id, name) FROM 'data/Movielens/occupations.csv' WITH (FORMAT CSV, HEADER TRUE, ENCODING 'LATIN1');
\COPY bronze.age_group(id, name) FROM 'data/Movielens/age_group.csv' WITH (FORMAT CSV, HEADER TRUE, ENCODING 'LATIN1');
\COPY bronze.genres(id, name) FROM 'data/Movielens/genres.csv' WITH (FORMAT CSV, HEADER TRUE, ENCODING 'LATIN1');
\COPY bronze.genres_movies(id, movie_id, genre_id) FROM 'data/Movielens/genres_movies.csv' WITH (FORMAT CSV, HEADER TRUE, ENCODING 'LATIN1');
\COPY bronze.users(id, age, gender, occupation_id, zip_code) FROM 'data/Movielens/users.csv' WITH (FORMAT CSV, HEADER TRUE, ENCODING 'LATIN1');
\COPY bronze.movies(id, title, release_year) FROM 'data/Movielens/movies.csv' WITH (FORMAT CSV, HEADER TRUE, ENCODING 'LATIN1');
\COPY bronze.ratings(id, user_id, movie_id, rating, rated_at) FROM 'data/Movielens/ratings.csv' WITH (FORMAT CSV, HEADER TRUE, ENCODING 'LATIN1');

commit;
