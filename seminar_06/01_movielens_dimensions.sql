USE `movielens`;

CREATE TABLE IF NOT EXISTS `dim_date` (
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

CREATE TABLE IF NOT EXISTS `dim_time` (
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

CREATE TABLE IF NOT EXISTS `dim_movie` (
  `movie_key` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `movie_id` INT UNSIGNED NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `release_year` SMALLINT UNSIGNED NULL,
  PRIMARY KEY (`movie_key`),
  UNIQUE KEY `uq_dim_movie_movie_id` (`movie_id`)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `dim_user` (
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

CREATE TABLE IF NOT EXISTS `dim_genre` (
  `genre_key` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `genre_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`genre_key`),
  UNIQUE KEY `uq_dim_genre_name` (`genre_name`)
) ENGINE = InnoDB;
