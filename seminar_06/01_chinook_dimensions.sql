USE `chinook`;

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

CREATE TABLE IF NOT EXISTS `chinook`.`dim_billing_address` (
  `address_key` INT NOT NULL,
  `billing_city` VARCHAR(40) NULL,
  `billing_state` VARCHAR(40) NULL,
  `billing_country` VARCHAR(40) NULL,
  `billing_postal_code` VARCHAR(10) NULL,
  PRIMARY KEY (`address_key`))
ENGINE = InnoDB;

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
