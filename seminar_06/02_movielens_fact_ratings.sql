USE `movielens`;

CREATE TABLE IF NOT EXISTS `fact_ratings` (
  `rating_key` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `rating` DECIMAL(2,1) NOT NULL,
  `time_key` SMALLINT UNSIGNED NOT NULL,
  `movie_key` INT UNSIGNED NOT NULL,
  `date_key` INT UNSIGNED NOT NULL,
  `user_key` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`rating_key`),
  KEY `ix_fact_ratings_time_key` (`time_key`),
  KEY `ix_fact_ratings_movie_key` (`movie_key`),
  KEY `ix_fact_ratings_date_key` (`date_key`),
  KEY `ix_fact_ratings_user_key` (`user_key`),
  CONSTRAINT `ck_fact_ratings_value`
    CHECK (`rating` BETWEEN 0.5 AND 5.0),
  CONSTRAINT `fk_fact_ratings_time`
    FOREIGN KEY (`time_key`) REFERENCES `dim_time` (`time_key`),
  CONSTRAINT `fk_fact_ratings_movie`
    FOREIGN KEY (`movie_key`) REFERENCES `dim_movie` (`movie_key`),
  CONSTRAINT `fk_fact_ratings_date`
    FOREIGN KEY (`date_key`) REFERENCES `dim_date` (`date_key`),
  CONSTRAINT `fk_fact_ratings_user`
    FOREIGN KEY (`user_key`) REFERENCES `dim_user` (`user_key`)
) ENGINE = InnoDB;
