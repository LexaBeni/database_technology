-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema movielens
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema movielens
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `movielens` DEFAULT CHARACTER SET utf8 ;
USE `movielens` ;

-- -----------------------------------------------------
-- Table `movielens`.`dim_time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movielens`.`dim_time` (
  `time_key` INT NOT NULL AUTO_INCREMENT,
  `hour` INT NULL,
  `minute` INT NULL,
  `second` INT NULL,
  `part_of_day` CHAR(2) NULL,
  PRIMARY KEY (`time_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movielens`.`dim_movie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movielens`.`dim_movie` (
  `movie_key` INT NOT NULL,
  `movie_id` INT NULL,
  `title` VARCHAR(225) NULL,
  `release_year` CHAR(4) NULL,
  PRIMARY KEY (`movie_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movielens`.`dim_date`
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `movielens`.`dim_user`
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `movielens`.`fact_ratings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movielens`.`fact_ratings` (
  `rating_key` INT NOT NULL,
  `rating` INT NOT NULL,
  `time_key` INT NOT NULL,
  `movie_key` INT NOT NULL,
  `date_key` INT NOT NULL,
  `user_key` INT NOT NULL,
  PRIMARY KEY (`rating_key`),
  INDEX `fk_fact_ratings_dim_time_idx` (`time_key` ASC) VISIBLE,
  INDEX `fk_fact_ratings_dim_movie1_idx` (`movie_key` ASC) VISIBLE,
  INDEX `fk_fact_ratings_dim_date1_idx` (`date_key` ASC) VISIBLE,
  INDEX `fk_fact_ratings_dim_user1_idx` (`user_key` ASC) VISIBLE,
  CONSTRAINT `fk_fact_ratings_dim_time`
    FOREIGN KEY (`time_key`)
    REFERENCES `movielens`.`dim_time` (`time_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_ratings_dim_movie1`
    FOREIGN KEY (`movie_key`)
    REFERENCES `movielens`.`dim_movie` (`movie_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_ratings_dim_date1`
    FOREIGN KEY (`date_key`)
    REFERENCES `movielens`.`dim_date` (`date_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_ratings_dim_user1`
    FOREIGN KEY (`user_key`)
    REFERENCES `movielens`.`dim_user` (`user_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movielens`.`dim_genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movielens`.`dim_genre` (
  `genre_key` INT NOT NULL,
  `genre_name` VARCHAR(225) NULL,
  PRIMARY KEY (`genre_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movielens`.`bridge`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movielens`.`bridge` (
  `bridge_key` INT NOT NULL AUTO_INCREMENT,
  `genre_key` INT NOT NULL,
  `movie_key` INT NOT NULL,
  INDEX `fk_dim_genre_has_dim_movie_dim_movie1_idx` (`movie_key` ASC) VISIBLE,
  INDEX `fk_dim_genre_has_dim_movie_dim_genre1_idx` (`genre_key` ASC) VISIBLE,
  PRIMARY KEY (`bridge_key`),
  CONSTRAINT `fk_dim_genre_has_dim_movie_dim_genre1`
    FOREIGN KEY (`genre_key`)
    REFERENCES `movielens`.`dim_genre` (`genre_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dim_genre_has_dim_movie_dim_movie1`
    FOREIGN KEY (`movie_key`)
    REFERENCES `movielens`.`dim_movie` (`movie_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
