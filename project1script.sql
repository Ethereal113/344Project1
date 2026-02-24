-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema project1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema project1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `project1` DEFAULT CHARACTER SET utf8 ;
USE `project1` ;

-- -----------------------------------------------------
-- Table `project1`.`Hosts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project1`.`Hosts` (
  `hostID` INT NOT NULL,
  `bio` VARCHAR(45) NULL DEFAULT 'empty',
  `hostName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`hostID`),
  UNIQUE INDEX `hostID_UNIQUE` (`hostID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project1`.`Episodes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project1`.`Episodes` (
  `episodeID` INT NOT NULL,
  `episodeNum` INT NOT NULL,
  `seasonNum` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `dateCreated` DATE NOT NULL,
  `duration` VARCHAR(45) NULL,
  PRIMARY KEY (`episodeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project1`.`Podcasts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project1`.`Podcasts` (
  `podcastID` INT NOT NULL,
  `description` VARCHAR(100) NULL,
  `genre` VARCHAR(45) NULL,
  `title` VARCHAR(45) NOT NULL,
  `language` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`podcastID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project1`.`Listeners`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project1`.`Listeners` (
  `listenerID` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `dateJoined` DATE NULL,
  PRIMARY KEY (`listenerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project1`.`HOST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project1`.`HOST` (
  `hostID` INT NOT NULL,
  `episodeID` INT NOT NULL,
  `podcastID` INT NOT NULL,
  `isVoiceActor` TINYINT NULL,
  INDEX `hostID_idx` (`hostID` ASC) VISIBLE,
  INDEX `episodeID_idx` (`episodeID` ASC) VISIBLE,
  INDEX `podcastID_idx` (`podcastID` ASC) VISIBLE,
  CONSTRAINT `hostID`
    FOREIGN KEY (`hostID`)
    REFERENCES `project1`.`Hosts` (`hostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `episodeID`
    FOREIGN KEY (`episodeID`)
    REFERENCES `project1`.`Episodes` (`episodeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `podcastID`
    FOREIGN KEY (`podcastID`)
    REFERENCES `project1`.`Podcasts` (`podcastID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project1`.`SUBSCRIBE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project1`.`SUBSCRIBE` (
  `listenerID` INT NOT NULL,
  `podcastID` INT NOT NULL,
  `dateSubscribed` DATE NOT NULL,
  INDEX `listenerID_idx` (`listenerID` ASC) VISIBLE,
  INDEX `podcsatID_idx` (`podcastID` ASC) VISIBLE,
  CONSTRAINT `listenerID`
    FOREIGN KEY (`listenerID`)
    REFERENCES `project1`.`Listeners` (`listenerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `podcsatID`
    FOREIGN KEY (`podcastID`)
    REFERENCES `project1`.`Podcasts` (`podcastID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- SQL script for populating and testing the tables
USE project1;

INSERT INTO hosts (hostID, bio, hostName)
VALUES 
	(1, 'The first host on Phoenix Podcasts', 'John Doe'),
    (2, 'A podcaster who likes to podcast', 'Bonny Lang'),
    (3, 'Host of New Yorks #1 podcast!', 'Eric Estevez');
    
INSERT INTO listeners (listenerID, username, email, dateJoined)
VALUES 
	(466, 'avidlistener12', 'jacklistens@gmail.com', '2026-1-1'),
    (467, 'thunderpebble', 'stormy38@gmail.com', '2025-12-27'),
    (468, 'rigbymilkyway', 'hambone3@gmail.com', '2026-2-14');
    
INSERT INTO podcasts (podcastID, description, genre, title, language) 
VALUES
	(888, '#1 podcast in New York City.', 'Arts & Entertainment', 'Bonny Talks', 'ENG'),
    (889, 'True crime podcast stories weekly!', 'True Crime', 'True Crime Podcast', 'ENG'),
    (890, 'Learn spanish with John daily!', 'Educational', 'Espanol con John', 'SPA'),
    (891, 'Nothing but the latest on everything sports.', 'Sports', 'Hardline', 'ENG');

INSERT INTO episodes (episodeID, episodeNum, seasonNum, title, dateCreated, duration)
VALUES 
	(77, 1, 1, 'Pilot', '2025-12-20', '60 min'),
    (78, 1, 1, 'The first case', '2026-1-1', '120 min'),
    (79, 1, 1, 'Lesson 1: Intro and the basics', '2025-12-31', '45 min'),
    (80, 1, 1, 'Pilot', '2026-1-1', '30 min');
    
SELECT episodeNum, seasonNum, title, duration
FROM episodes 
WHERE dateCreated = '2026-1-1';

SELECT hostName
FROM hosts;

SELECT title, description, genre
FROM podcasts
WHERE language = 'ENG';


