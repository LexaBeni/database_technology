USE `Northwind`;

CREATE TABLE IF NOT EXISTS `Northwind`.`fact_order_detail` (
  `order_detail_key` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `unit_price` DECIMAL(10,2) NULL,
  `line_amount` DECIMAL(10,2) NULL,
  `customer_key` INT NOT NULL,
  `product_key` INT NOT NULL,
  `employee_key` INT NOT NULL,
  `shipper_key` INT NOT NULL,
  `date_key` INT NOT NULL,
  `time_key` INT NOT NULL,
  PRIMARY KEY (`order_detail_key`),
  INDEX `fk_fact_order_detail_dim_customer1_idx` (`customer_key` ASC) VISIBLE,
  INDEX `fk_fact_order_detail_dim_product1_idx` (`product_key` ASC) VISIBLE,
  INDEX `fk_fact_order_detail_dim_employees1_idx` (`employee_key` ASC) VISIBLE,
  INDEX `fk_fact_order_detail_dim_shipper1_idx` (`shipper_key` ASC) VISIBLE,
  INDEX `fk_fact_order_detail_dim_date1_idx` (`date_key` ASC) VISIBLE,
  INDEX `fk_fact_order_detail_dim_time1_idx` (`time_key` ASC) VISIBLE,
  CONSTRAINT `fk_fact_order_detail_dim_customer1`
    FOREIGN KEY (`customer_key`)
    REFERENCES `Northwind`.`dim_customer` (`customer_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_order_detail_dim_product1`
    FOREIGN KEY (`product_key`)
    REFERENCES `Northwind`.`dim_product` (`product_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_order_detail_dim_employees1`
    FOREIGN KEY (`employee_key`)
    REFERENCES `Northwind`.`dim_employee` (`employee_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_order_detail_dim_shipper1`
    FOREIGN KEY (`shipper_key`)
    REFERENCES `Northwind`.`dim_shipper` (`shipper_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_order_detail_dim_date1`
    FOREIGN KEY (`date_key`)
    REFERENCES `Northwind`.`dim_date` (`date_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_order_detail_dim_time1`
    FOREIGN KEY (`time_key`)
    REFERENCES `Northwind`.`dim_time` (`time_key`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
