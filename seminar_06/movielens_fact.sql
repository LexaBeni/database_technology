-- MovieLens star schema
-- MySQL 8.0+

CREATE SCHEMA IF NOT EXISTS `movielens`
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE `movielens`;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `bridge`;
DROP TABLE IF EXISTS `fact_ratings`;
DROP TABLE IF EXISTS `dim_genre`;
DROP TABLE IF EXISTS `dim_user`;
DROP TABLE IF EXISTS `dim_movie`;
DROP TABLE IF EXISTS `dim_time`;
DROP TABLE IF EXISTS `dim_date`;

SET FOREIGN_KEY_CHECKS = 1;

-- One row per calendar date. date_key is YYYYMMDD.
CREATE TABLE `dim_date` (
  `date_key` INT UNSIGNED NOT NULL,
  `full_date` DATE NOT NULL,
  `day` TINYINT UNSIGNED NOT NULL,
  `day_of_week` TINYINT UNSIGNED NOT NULL,
  `week` TINYINT UNSIGNED NOT NULL,
  `month` TINYINT UNSIGNED NOT NULL,
  `month_name` VARCHAR(15) NOT NULL,
  `year` SMALLINT UNSIGNED NOT NULL,
  `quarter` TINYINT UNSIGNED NOT NULL,
  `is_weekend` BOOLEAN NOT NULL,
  PRIMARY KEY (`date_key`),
  UNIQUE KEY `uq_dim_date_full_date` (`full_date`)
) ENGINE = InnoDB;

-- One row per time of day used by a rating event.
CREATE TABLE `dim_time` (
  `time_key` SMALLINT UNSIGNED NOT NULL,
  `hour` TINYINT UNSIGNED NOT NULL,
  `minute` TINYINT UNSIGNED NOT NULL,
  `second` TINYINT UNSIGNED NOT NULL,
  `part_of_day` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`time_key`),
  UNIQUE KEY `uq_dim_time_hms` (`hour`, `minute`, `second`),
  CONSTRAINT `ck_dim_time_hour` CHECK (`hour` BETWEEN 0 AND 23),
  CONSTRAINT `ck_dim_time_minute` CHECK (`minute` BETWEEN 0 AND 59),
  CONSTRAINT `ck_dim_time_second` CHECK (`second` BETWEEN 0 AND 59)
) ENGINE = InnoDB;

CREATE TABLE `dim_movie` (
  `movie_key` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `movie_id` INT UNSIGNED NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `release_year` SMALLINT UNSIGNED NULL,
  PRIMARY KEY (`movie_key`),
  UNIQUE KEY `uq_dim_movie_movie_id` (`movie_id`)
) ENGINE = InnoDB;

-- SCD type 2 is supported through the validity columns.
CREATE TABLE `dim_user` (
  `user_key` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL,
  `gender` CHAR(1) NULL,
  `zip_code` VARCHAR(20) NULL,
  `age_group` VARCHAR(20) NULL,
  `occupation_name` VARCHAR(100) NULL,
  `valid_from` DATE NOT NULL,
  `valid_to` DATE NULL,
  `is_current` BOOLEAN NOT NULL DEFAULT TRUE,
  PRIMARY KEY (`user_key`),
  KEY `ix_dim_user_user_id` (`user_id`),
  CONSTRAINT `ck_dim_user_validity`
    CHECK (`valid_to` IS NULL OR `valid_to` >= `valid_from`)
) ENGINE = InnoDB;

CREATE TABLE `dim_genre` (
  `genre_key` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `genre_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`genre_key`),
  UNIQUE KEY `uq_dim_genre_name` (`genre_name`)
) ENGINE = InnoDB;

CREATE TABLE `fact_ratings` (
  `rating_key` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `rating` DECIMAL(2,1) NOT NULL,
  `time_key` SMALLINT UNSIGNED NOT NULL,
  `movie_key` INT UNSIGNED NOT NULL,
  `date_key` INT UNSIGNED NOT NULL,
  `user_key` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`rating_key`),
  KEY `ix_fact_ratings_time_key` (`time_key`),
  KEY `ix_fact_ratings_movie_key` (`movie_key`),
  KEY `ix_fact_ratings_date_key` (`date_key`),
  KEY `ix_fact_ratings_user_key` (`user_key`),
  CONSTRAINT `ck_fact_ratings_value`
    CHECK (`rating` BETWEEN 0.5 AND 5.0),
  CONSTRAINT `fk_fact_ratings_time`
    FOREIGN KEY (`time_key`) REFERENCES `dim_time` (`time_key`),
  CONSTRAINT `fk_fact_ratings_movie`
    FOREIGN KEY (`movie_key`) REFERENCES `dim_movie` (`movie_key`),
  CONSTRAINT `fk_fact_ratings_date`
    FOREIGN KEY (`date_key`) REFERENCES `dim_date` (`date_key`),
  CONSTRAINT `fk_fact_ratings_user`
    FOREIGN KEY (`user_key`) REFERENCES `dim_user` (`user_key`)
) ENGINE = InnoDB;

-- Bridge for the many-to-many MovieLens movie/genre relationship.
CREATE TABLE `bridge` (
  `movie_key` INT UNSIGNED NOT NULL,
  `genre_key` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`movie_key`, `genre_key`),
  KEY `ix_bridge_genre_key` (`genre_key`),
  CONSTRAINT `fk_bridge_movie`
    FOREIGN KEY (`movie_key`) REFERENCES `dim_movie` (`movie_key`),
  CONSTRAINT `fk_bridge_genre`
    FOREIGN KEY (`genre_key`) REFERENCES `dim_genre` (`genre_key`)
) ENGINE = InnoDB;
