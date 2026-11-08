-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pagila
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pagila
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pagila` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pagila` ;

-- -----------------------------------------------------
-- Table `pagila`.`sdim_actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`sdim_actor` (
  `actor_key` INT NOT NULL AUTO_INCREMENT,
  `actor_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`actor_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pagila`.`sdim_language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`sdim_language` (
  `language_key` INT NOT NULL AUTO_INCREMENT,
  `language_id` INT NOT NULL,
  `language_name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`language_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pagila`.`dim_film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`dim_film` (
  `film_key` INT NOT NULL AUTO_INCREMENT,
  `film_id` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `release_year` YEAR NULL DEFAULT NULL,
  `length` SMALLINT NULL DEFAULT NULL,
  `special_features` TEXT NULL DEFAULT NULL,
  `rental_duration` SMALLINT NULL DEFAULT NULL,
  `rating` DOUBLE NULL DEFAULT NULL,
  `replacement_cost` DECIMAL(5,2) NULL DEFAULT NULL,
  `language_key` INT NOT NULL,
  PRIMARY KEY (`film_key`),
  INDEX `fk_film_language` (`language_key` ASC) VISIBLE,
  CONSTRAINT `fk_film_language`
    FOREIGN KEY (`language_key`)
    REFERENCES `pagila`.`sdim_language` (`language_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pagila`.`actor_bridge`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`actor_bridge` (
  `actor_key` INT NOT NULL,
  `film_key` INT NOT NULL,
  PRIMARY KEY (`actor_key`, `film_key`),
  INDEX `fk_bridge_film` (`film_key` ASC) VISIBLE,
  CONSTRAINT `fk_bridge_actor`
    FOREIGN KEY (`actor_key`)
    REFERENCES `pagila`.`sdim_actor` (`actor_key`),
  CONSTRAINT `fk_bridge_film`
    FOREIGN KEY (`film_key`)
    REFERENCES `pagila`.`dim_film` (`film_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pagila`.`sdim_country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`sdim_country` (
  `country_key` INT NOT NULL AUTO_INCREMENT,
  `country_id` INT NOT NULL,
  `country_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`country_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pagila`.`sdim_city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`sdim_city` (
  `city_key` INT NOT NULL AUTO_INCREMENT,
  `city_id` INT NOT NULL,
  `city_name` VARCHAR(45) NOT NULL,
  `country_key` INT NOT NULL,
  PRIMARY KEY (`city_key`),
  INDEX `fk_city_country` (`country_key` ASC) VISIBLE,
  CONSTRAINT `fk_city_country`
    FOREIGN KEY (`country_key`)
    REFERENCES `pagila`.`sdim_country` (`country_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pagila`.`sdim_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`sdim_address` (
  `address_key` INT NOT NULL AUTO_INCREMENT,
  `address_id` INT NOT NULL,
  `address_name` VARCHAR(50) NOT NULL,
  `district` VARCHAR(50) NULL DEFAULT NULL,
  `postal_code` VARCHAR(10) NULL DEFAULT NULL,
  `city_key` INT NOT NULL,
  PRIMARY KEY (`address_key`),
  INDEX `fk_address_city` (`city_key` ASC) VISIBLE,
  CONSTRAINT `fk_address_city`
    FOREIGN KEY (`city_key`)
    REFERENCES `pagila`.`sdim_city` (`city_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pagila`.`dim_staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`dim_staff` (
  `staff_key` INT NOT NULL AUTO_INCREMENT,
  `staff_id` INT NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `address_key` INT NOT NULL,
  PRIMARY KEY (`staff_key`),
  INDEX `fk_staff_address` (`address_key` ASC) VISIBLE,
  CONSTRAINT `fk_staff_address`
    FOREIGN KEY (`address_key`)
    REFERENCES `pagila`.`sdim_address` (`address_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pagila`.`dim_store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`dim_store` (
  `store_key` INT NOT NULL AUTO_INCREMENT,
  `store_id` INT NOT NULL,
  `manager_key` INT NOT NULL,
  `address_key` INT NOT NULL,
  PRIMARY KEY (`store_key`),
  INDEX `fk_store_staff` (`manager_key` ASC) VISIBLE,
  INDEX `fk_store_address` (`address_key` ASC) VISIBLE,
  CONSTRAINT `fk_store_address`
    FOREIGN KEY (`address_key`)
    REFERENCES `pagila`.`sdim_address` (`address_key`),
  CONSTRAINT `fk_store_staff`
    FOREIGN KEY (`manager_key`)
    REFERENCES `pagila`.`dim_staff` (`staff_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pagila`.`dim_customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`dim_customer` (
  `customer_key` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `active` TINYINT NULL DEFAULT '1',
  `created_at` DATE NULL DEFAULT NULL,
  `address_key` INT NOT NULL,
  `store_key` INT NOT NULL,
  PRIMARY KEY (`customer_key`),
  INDEX `fk_customer_address` (`address_key` ASC) VISIBLE,
  INDEX `fk_customer_store` (`store_key` ASC) VISIBLE,
  CONSTRAINT `fk_customer_address`
    FOREIGN KEY (`address_key`)
    REFERENCES `pagila`.`sdim_address` (`address_key`),
  CONSTRAINT `fk_customer_store`
    FOREIGN KEY (`store_key`)
    REFERENCES `pagila`.`dim_store` (`store_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pagila`.`sdim_quarter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`sdim_quarter` (
  `quarter_key` INT NOT NULL AUTO_INCREMENT,
  `quarter` TINYINT NOT NULL,
  `quarter_label` CHAR(2) NOT NULL,
  PRIMARY KEY (`quarter_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pagila`.`sdim_month`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`sdim_month` (
  `month_key` INT NOT NULL AUTO_INCREMENT,
  `month` INT NOT NULL,
  `month_name` VARCHAR(20) NOT NULL,
  `sdim_quarter_quarter_key` INT NOT NULL,
  PRIMARY KEY (`month_key`),
  INDEX `fk_sdim_month_sdim_quarter1_idx` (`sdim_quarter_quarter_key` ASC) VISIBLE,
  CONSTRAINT `fk_sdim_month_sdim_quarter1`
    FOREIGN KEY (`sdim_quarter_quarter_key`)
    REFERENCES `pagila`.`sdim_quarter` (`quarter_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pagila`.`dim_date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`dim_date` (
  `date_key` INT NOT NULL AUTO_INCREMENT,
  `full_date` DATE NOT NULL,
  `day` INT NOT NULL,
  `week` INT NOT NULL,
  `day_of_week` VARCHAR(20) NOT NULL,
  `year` SMALLINT NOT NULL,
  `month_key` INT NOT NULL,
  PRIMARY KEY (`date_key`),
  INDEX `fk_date_month` (`month_key` ASC) VISIBLE,
  CONSTRAINT `fk_date_month`
    FOREIGN KEY (`month_key`)
    REFERENCES `pagila`.`sdim_month` (`month_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pagila`.`dim_inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`dim_inventory` (
  `inventory_key` INT NOT NULL AUTO_INCREMENT,
  `inventory_id` INT NOT NULL,
  `store_key` INT NOT NULL,
  `film_key` INT NOT NULL,
  PRIMARY KEY (`inventory_key`),
  INDEX `fk_inventory_store` (`store_key` ASC) VISIBLE,
  INDEX `fk_inventory_film` (`film_key` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_film`
    FOREIGN KEY (`film_key`)
    REFERENCES `pagila`.`dim_film` (`film_key`),
  CONSTRAINT `fk_inventory_store`
    FOREIGN KEY (`store_key`)
    REFERENCES `pagila`.`dim_store` (`store_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pagila`.`sdim_part_of_day`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`sdim_part_of_day` (
  `part_of_day_key` INT NOT NULL AUTO_INCREMENT,
  `part_of_day` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`part_of_day_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pagila`.`sdim_hour`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`sdim_hour` (
  `hour_key` INT NOT NULL AUTO_INCREMENT,
  `hour` INT NOT NULL,
  `hour_12` INT NOT NULL,
  `am_pm` CHAR(2) NOT NULL,
  `part_of_day_key` INT NOT NULL,
  PRIMARY KEY (`hour_key`),
  INDEX `fk_hour_daypart` (`part_of_day_key` ASC) VISIBLE,
  CONSTRAINT `fk_hour_daypart`
    FOREIGN KEY (`part_of_day_key`)
    REFERENCES `pagila`.`sdim_part_of_day` (`part_of_day_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pagila`.`dim_time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`dim_time` (
  `time_key` INT NOT NULL AUTO_INCREMENT,
  `minute` INT NOT NULL,
  `second` INT NOT NULL,
  `hour_key` INT NOT NULL,
  PRIMARY KEY (`time_key`),
  INDEX `fk_time_hour` (`hour_key` ASC) VISIBLE,
  CONSTRAINT `fk_time_hour`
    FOREIGN KEY (`hour_key`)
    REFERENCES `pagila`.`sdim_hour` (`hour_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pagila`.`fact_rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`fact_rental` (
  `rental_key` INT NOT NULL AUTO_INCREMENT,
  `rental_id` INT NOT NULL,
  `rental_amount` DECIMAL(4,2) NOT NULL,
  `inventory_key` INT NOT NULL,
  `customer_key` INT NOT NULL,
  `staff_key` INT NOT NULL,
  `rental_time_key` INT NOT NULL,
  `rental_date_key` INT NOT NULL,
  `return_time_key` INT NULL DEFAULT NULL,
  `return_date_key` INT NULL DEFAULT NULL,
  PRIMARY KEY (`rental_key`),
  INDEX `fk_fact_inventory` (`inventory_key` ASC) VISIBLE,
  INDEX `fk_fact_customer` (`customer_key` ASC) VISIBLE,
  INDEX `fk_fact_staff` (`staff_key` ASC) VISIBLE,
  INDEX `fk_fact_rental_time` (`rental_time_key` ASC) VISIBLE,
  INDEX `fk_fact_rental_date` (`rental_date_key` ASC) VISIBLE,
  INDEX `fk_fact_return_time` (`return_time_key` ASC) VISIBLE,
  INDEX `fk_fact_return_date` (`return_date_key` ASC) VISIBLE,
  CONSTRAINT `fk_fact_customer`
    FOREIGN KEY (`customer_key`)
    REFERENCES `pagila`.`dim_customer` (`customer_key`),
  CONSTRAINT `fk_fact_inventory`
    FOREIGN KEY (`inventory_key`)
    REFERENCES `pagila`.`dim_inventory` (`inventory_key`),
  CONSTRAINT `fk_fact_rental_date`
    FOREIGN KEY (`rental_date_key`)
    REFERENCES `pagila`.`dim_date` (`date_key`),
  CONSTRAINT `fk_fact_rental_time`
    FOREIGN KEY (`rental_time_key`)
    REFERENCES `pagila`.`dim_time` (`time_key`),
  CONSTRAINT `fk_fact_return_date`
    FOREIGN KEY (`return_date_key`)
    REFERENCES `pagila`.`dim_date` (`date_key`),
  CONSTRAINT `fk_fact_return_time`
    FOREIGN KEY (`return_time_key`)
    REFERENCES `pagila`.`dim_time` (`time_key`),
  CONSTRAINT `fk_fact_staff`
    FOREIGN KEY (`staff_key`)
    REFERENCES `pagila`.`dim_staff` (`staff_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pagila`.`sdim_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`sdim_category` (
  `category_key` INT NOT NULL,
  `category_id` INT NULL,
  `category_name` VARCHAR(25) NULL,
  PRIMARY KEY (`category_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pagila`.`category_bridge`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pagila`.`category_bridge` (
  `film_key` INT NOT NULL,
  `category_key` INT NOT NULL,
  PRIMARY KEY (`film_key`, `category_key`),
  INDEX `fk_dim_film_has_sdim_category_sdim_category1_idx` (`category_key` ASC) VISIBLE,
  INDEX `fk_dim_film_has_sdim_category_dim_film1_idx` (`film_key` ASC) VISIBLE,
  CONSTRAINT `fk_dim_film_has_sdim_category_dim_film1`
    FOREIGN KEY (`film_key`)
    REFERENCES `pagila`.`dim_film` (`film_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dim_film_has_sdim_category_sdim_category1`
    FOREIGN KEY (`category_key`)
    REFERENCES `pagila`.`sdim_category` (`category_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
