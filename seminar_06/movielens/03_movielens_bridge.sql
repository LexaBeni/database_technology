USE `movielens`;

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
