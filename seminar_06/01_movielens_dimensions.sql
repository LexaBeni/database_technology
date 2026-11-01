USE `movielens`;

CREATE TABLE IF NOT EXISTS `movielens`.`dim_time` (
  `time_key` INT NOT NULL AUTO_INCREMENT,
  `hour` INT NULL,
  `minute` INT NULL,
  `second` INT NULL,
  `part_of_day` CHAR(2) NULL,
  PRIMARY KEY (`time_key`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `movielens`.`dim_movie` (
  `movie_key` INT NOT NULL,
  `movie_id` INT NULL,
  `title` VARCHAR(225) NULL,
  `release_year` CHAR(4) NULL,
  PRIMARY KEY (`movie_key`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `movielens`.`dim_date` (
  `date_key` INT NOT NULL AUTO_INCREMENT,
  `full_date` DATE NULL,
  `day` INT NULL,
  `day_of_week` VARCHAR(15) NULL,
  `week` INT NULL,
  `month` INT NULL,
  `month_name` VARCHAR(15) NULL,
  `year` INT NULL,
  `quarter` INT NULL,
  `is_weekend` TINYINT NULL,
  PRIMARY KEY (`date_key`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `movielens`.`dim_user` (
  `user_key` INT NOT NULL,
  `user_id` INT NULL,
  `gender` CHAR(1) NULL,
  `zip_code` VARCHAR(225) NULL,
  `age_group` VARCHAR(45) NULL,
  `occupation_name` VARCHAR(225) NULL,
  `valid_from` DATE NULL,
  `valid_to` DATE NULL,
  `is_current` TINYINT NULL,
  PRIMARY KEY (`user_key`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `movielens`.`dim_genre` (
  `genre_key` INT NOT NULL,
  `genre_name` VARCHAR(225) NULL,
  PRIMARY KEY (`genre_key`))
ENGINE = InnoDB;
