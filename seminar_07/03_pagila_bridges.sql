USE `pagila` ;

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
