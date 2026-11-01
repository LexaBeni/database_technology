USE `chinook`;

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
