USE `Northwind`;

CREATE TABLE IF NOT EXISTS `Northwind`.`sdim_country` (
  `country_key` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(65) NOT NULL,
  PRIMARY KEY (`country_key`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Northwind`.`sdim_city` (
  `city_key` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `country_key` INT NOT NULL,
  PRIMARY KEY (`city_key`),
  INDEX `fk_dim_city_dim_country1_idx` (`country_key` ASC) VISIBLE,
  CONSTRAINT `fk_dim_city_dim_country1`
    FOREIGN KEY (`country_key`)
    REFERENCES `Northwind`.`sdim_country` (`country_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Northwind`.`dim_customer` (
  `customer_key` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `customer_name` VARCHAR(50) NOT NULL,
  `contanct_name` VARCHAR(50) NOT NULL,
  `address` VARCHAR(50) NOT NULL,
  `city_key` INT NOT NULL,
  `psc` VARCHAR(10) NULL,
  PRIMARY KEY (`customer_key`),
  INDEX `fk_dim_customer_dim_city1_idx` (`city_key` ASC) VISIBLE,
  CONSTRAINT `fk_dim_customer_dim_city1`
    FOREIGN KEY (`city_key`)
    REFERENCES `Northwind`.`sdim_city` (`city_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Northwind`.`sdim_category` (
  `category_key` INT NOT NULL,
  `category_name` VARCHAR(25) NULL,
  PRIMARY KEY (`category_key`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Northwind`.`dim_supplier` (
  `supplier_key` INT NOT NULL,
  `supplier_id` INT NOT NULL,
  `supplier_name` VARCHAR(50) NULL,
  `contact_name` VARCHAR(50) NULL,
  `address` VARCHAR(50) NULL,
  `city_key` INT NOT NULL,
  `psc` VARCHAR(10) NULL,
  PRIMARY KEY (`supplier_key`),
  INDEX `fk_dim_supplier_sdim_city1_idx` (`city_key` ASC) VISIBLE,
  CONSTRAINT `fk_dim_supplier_sdim_city1`
    FOREIGN KEY (`city_key`)
    REFERENCES `Northwind`.`sdim_city` (`city_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Northwind`.`dim_product` (
  `product_key` INT NOT NULL,
  `product_id` INT NOT NULL,
  `product_name` VARCHAR(50) NULL,
  `product_unit` VARCHAR(25) NULL,
  `category_key` INT NOT NULL,
  `supplier_key` INT NOT NULL,
  PRIMARY KEY (`product_key`),
  INDEX `fk_dim_product_sdim_category1_idx` (`category_key` ASC) VISIBLE,
  INDEX `fk_dim_product_dim_supplier1_idx` (`supplier_key` ASC) VISIBLE,
  CONSTRAINT `fk_dim_product_sdim_category1`
    FOREIGN KEY (`category_key`)
    REFERENCES `Northwind`.`sdim_category` (`category_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dim_product_dim_supplier1`
    FOREIGN KEY (`supplier_key`)
    REFERENCES `Northwind`.`dim_supplier` (`supplier_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Northwind`.`dim_employee` (
  `employee_key` INT NOT NULL,
  `first_name` VARCHAR(75) NOT NULL,
  `last_name` VARCHAR(75) NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`employee_key`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Northwind`.`dim_shipper` (
  `shipper_key` INT NOT NULL,
  `shipper_id` INT NOT NULL,
  `shipper_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`shipper_key`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Northwind`.`sdim_quarter` (
  `quarter_key` INT NOT NULL,
  `quarter` INT NULL,
  `quarter_label` CHAR(2) NULL,
  PRIMARY KEY (`quarter_key`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Northwind`.`sdim_month` (
  `month_key` INT NOT NULL,
  `month` INT NULL,
  `month_name` VARCHAR(15) NULL,
  `quarter_key` INT NOT NULL,
  PRIMARY KEY (`month_key`),
  INDEX `fk_sdim_month_sdim_quarter1_idx` (`quarter_key` ASC) VISIBLE,
  CONSTRAINT `fk_sdim_month_sdim_quarter1`
    FOREIGN KEY (`quarter_key`)
    REFERENCES `Northwind`.`sdim_quarter` (`quarter_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Northwind`.`dim_date` (
  `date_key` INT NOT NULL,
  `full_date` DATE NOT NULL,
  `day` INT NULL,
  `week` INT NULL,
  `day_of_week` VARCHAR(15) NULL,
  `year` SMALLINT NULL,
  `month_key` INT NOT NULL,
  PRIMARY KEY (`date_key`),
  UNIQUE INDEX `full_date_UNIQUE` (`full_date` ASC) VISIBLE,
  INDEX `fk_dim_date_sdim_month1_idx` (`month_key` ASC) VISIBLE,
  CONSTRAINT `fk_dim_date_sdim_month1`
    FOREIGN KEY (`month_key`)
    REFERENCES `Northwind`.`sdim_month` (`month_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Northwind`.`sdim_part_of_day` (
  `part_of_day_key` INT NOT NULL,
  `part_of_day` VARCHAR(20) NULL,
  PRIMARY KEY (`part_of_day_key`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Northwind`.`sdim_hour` (
  `hour_key` INT NOT NULL,
  `hour` INT NULL,
  `hour_12` INT NULL,
  `am_pm` CHAR(2) NULL,
  `part_of_day_key` INT NOT NULL,
  PRIMARY KEY (`hour_key`),
  INDEX `fk_sdim_hour_sdim_part_of_day1_idx` (`part_of_day_key` ASC) VISIBLE,
  CONSTRAINT `fk_sdim_hour_sdim_part_of_day1`
    FOREIGN KEY (`part_of_day_key`)
    REFERENCES `Northwind`.`sdim_part_of_day` (`part_of_day_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `Northwind`.`dim_time` (
  `time_key` INT NOT NULL,
  `hour_key` INT NOT NULL,
  `minute` INT NULL,
  `second` INT NULL,
  PRIMARY KEY (`time_key`),
  INDEX `fk_dim_time_sdim_hour1_idx` (`hour_key` ASC) VISIBLE,
  CONSTRAINT `fk_dim_time_sdim_hour1`
    FOREIGN KEY (`hour_key`)
    REFERENCES `Northwind`.`sdim_hour` (`hour_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
