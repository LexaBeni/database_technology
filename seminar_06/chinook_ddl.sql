-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema chinook
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema chinook
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `chinook` DEFAULT CHARACTER SET utf8 ;
USE `chinook` ;

-- -----------------------------------------------------
-- Table `chinook`.`dim_date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chinook`.`dim_date` (
  `date_key` INT NOT NULL,
  `full_date` DATE NULL,
  `day` INT NULL,
  `week` INT NULL,
  `month` INT NULL,
  `year` INT NULL,
  `quarter` INT NULL,
  PRIMARY KEY (`date_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chinook`.`dim_track`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chinook`.`dim_track` (
  `track_key` INT NOT NULL,
  `track_id` INT NOT NULL,
  `track_name` VARCHAR(200) NOT NULL,
  `composer_name` VARCHAR(220) NULL,
  `album_name` VARCHAR(200) NULL,
  `media_type` VARCHAR(160) NULL,
  `genre_name` VARCHAR(220) NULL,
  `artist_name` VARCHAR(95) NULL,
  `track_milliseconds` INT NULL,
  `track_bytes` INT NULL,
  PRIMARY KEY (`track_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chinook`.`dim_billing_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chinook`.`dim_billing_address` (
  `address_key` INT NOT NULL,
  `billing_city` VARCHAR(40) NULL,
  `billing_state` VARCHAR(40) NULL,
  `billing_country` VARCHAR(40) NULL,
  `billing_postal_code` VARCHAR(10) NULL,
  PRIMARY KEY (`address_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chinook`.`dim_customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chinook`.`dim_customer` (
  `customer_key` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `first_name` VARCHAR(40) NOT NULL,
  `last_name` VARCHAR(20) NOT NULL,
  `company` VARCHAR(80) NULL,
  `address` VARCHAR(70) NULL,
  `city` VARCHAR(40) NULL,
  `state` VARCHAR(40) NULL,
  `country` VARCHAR(40) NULL,
  `postal_code` VARCHAR(10) NULL,
  PRIMARY KEY (`customer_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chinook`.`dim_employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chinook`.`dim_employee` (
  `employee_key` INT NOT NULL,
  `employee_id` INT NOT NULL,
  `first_name` VARCHAR(20) NULL,
  `last_name` VARCHAR(30) NULL,
  `title` VARCHAR(30) NULL,
  `manager_name` VARCHAR(100) NULL,
  `city` VARCHAR(40) NULL,
  `state` VARCHAR(40) NULL,
  `country` VARCHAR(40) NULL,
  `postal_code` VARCHAR(40) NULL,
  PRIMARY KEY (`employee_key`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chinook`.`fact_invoice_line`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chinook`.`fact_invoice_line` (
  `invoice_line_id` INT NOT NULL,
  `invoice_id` INT NOT NULL,
  `unit_price` DECIMAL(10,2) NULL,
  `total` DECIMAL(10,2) NULL,
  `quantity` INT NOT NULL,
  `date_key` INT NOT NULL,
  `track_key` INT NOT NULL,
  `billing_address_key` INT NOT NULL,
  `customer_key` INT NOT NULL,
  `employee_key` INT NOT NULL,
  PRIMARY KEY (`invoice_line_id`),
  INDEX `fk_fact_sales_dim_date_idx` (`date_key` ASC) VISIBLE,
  INDEX `fk_fact_sales_dim_track1_idx` (`track_key` ASC) VISIBLE,
  INDEX `fk_fact_sales_dim_billing_address1_idx` (`billing_address_key` ASC) VISIBLE,
  INDEX `fk_fact_invoice_line_dim_customer1_idx` (`customer_key` ASC) VISIBLE,
  INDEX `fk_fact_invoice_line_dim_employee1_idx` (`employee_key` ASC) VISIBLE,
  CONSTRAINT `fk_fact_sales_dim_date`
    FOREIGN KEY (`date_key`)
    REFERENCES `chinook`.`dim_date` (`date_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_sales_dim_track1`
    FOREIGN KEY (`track_key`)
    REFERENCES `chinook`.`dim_track` (`track_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_sales_dim_billing_address1`
    FOREIGN KEY (`billing_address_key`)
    REFERENCES `chinook`.`dim_billing_address` (`address_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_invoice_line_dim_customer1`
    FOREIGN KEY (`customer_key`)
    REFERENCES `chinook`.`dim_customer` (`customer_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_invoice_line_dim_employee1`
    FOREIGN KEY (`employee_key`)
    REFERENCES `chinook`.`dim_employee` (`employee_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
