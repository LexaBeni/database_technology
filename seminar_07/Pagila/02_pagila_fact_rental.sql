USE `pagila` ;

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

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
