USE `movielens`;

CREATE TABLE IF NOT EXISTS `bridge` (
  `movie_key` INT UNSIGNED NOT NULL,
  `genre_key` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`movie_key`, `genre_key`),
  KEY `ix_bridge_genre_key` (`genre_key`),
  CONSTRAINT `fk_bridge_movie`
    FOREIGN KEY (`movie_key`) REFERENCES `dim_movie` (`movie_key`),
  CONSTRAINT `fk_bridge_genre`
    FOREIGN KEY (`genre_key`) REFERENCES `dim_genre` (`genre_key`)
) ENGINE = InnoDB;
