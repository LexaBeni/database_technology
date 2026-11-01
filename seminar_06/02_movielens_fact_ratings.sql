USE `movielens`;

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
