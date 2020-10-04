CREATE SCHEMA IF NOT EXISTS MatchMaking;
USE MatchMaking;


-- -----------------------------------------------------
-- Schema MatchMaking
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `MatchMaking`;


-- -----------------------------------------------------
-- Schema MatchMaking
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `MatchMaking` DEFAULT CHARACTER SET utf8;
USE `MatchMaking`;


-- -----------------------------------------------------
-- Table `MatchMaking`.`Server`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MatchMaking`.`Server`;

CREATE TABLE IF NOT EXISTS `MatchMaking`.`Server` (
	`ID` INT NOT NULL AUTO_INCREMENT,
	`Capacity` INT NOT NULL,

	PRIMARY KEY (`ID`)
);


-- -----------------------------------------------------
-- Table `MatchMaking`.`Player`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MatchMaking`.`Player`;

CREATE TABLE IF NOT EXISTS `MatchMaking`.`Player` (
	`ID` INT NOT NULL AUTO_INCREMENT,
	`ExternID` INT NOT NULL,
	`GameRating` INT NOT NULL,
	`ConnectionRating` INT NOT NULL,
	`Status` INT NOT NULL,
	`StatusTimestamp` TIMESTAMP,
	`Status` INT NOT NULL,
	`ServerID` INT NOT NULL,

	PRIMARY KEY (`ID`),

	FOREIGN KEY (`ServerID`)
		REFERENCES `MatchMaking`.`Server`(`ID`)
		ON UPDATE CASCADE ON DELETE RESTRICT,

	INDEX `ArtistId_idx` (`ArtistId` ASC)
);


-- -----------------------------------------------------
-- Table `MatchMaking`.`Match`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MatchMaking`.`Match`;

CREATE TABLE IF NOT EXISTS `MatchMaking`.`Match` (
	`ID` INT NOT NULL AUTO_INCREMENT,

	PRIMARY KEY (`ID`)
);


-- -----------------------------------------------------
-- Table `MatchMaking`.`Match`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MatchMaking`.`Match_Participants`;

CREATE TABLE IF NOT EXISTS `MatchMaking`.`Match_Participants` (
	`PlayerID` INT NOT NULL,
	`MatchID` INT NOT NULL,
	`Score` INT NOT NULL,
	`Score` INT NOT NULL,

	PRIMARY KEY (`PlayerID`, `MatchID`),

	FOREIGN KEY (`PlayerID`)
		REFERENCES `MatchMaking`.`Player`(`ID`)
		ON UPDATE CASCADE ON DELETE RESTRICT,

	FOREIGN KEY (`MatchID`)
		REFERENCES `MatchMaking`.`Match`(`ID`)
		ON UPDATE CASCADE ON DELETE RESTRICT
);


-- -----------------------------------------------------
-- Table `MatchMaking`.`PendingMatch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MatchMaking`.`PendingMatch`;

CREATE TABLE IF NOT EXISTS `MatchMaking`.`PendingMatch` (
	`ID` INT NOT NULL AUTO_INCREMENT,
	`ServerID` INT NOT NULL,
	`Capacity` INT NOT NULL,

	PRIMARY KEY (`ID`),

	FOREIGN KEY (`ServerID`)
		REFERENCES `MatchMaking`.`Server`(`ID`)
		ON UPDATE CASCADE ON DELETE RESTRICT
);


-- -----------------------------------------------------
-- Table `MatchMaking`.`PendingMatch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `MatchMaking`.`PendingMatch_Queue`;

CREATE TABLE IF NOT EXISTS `MatchMaking`.`PendingMatch_Queue` (
	`PlayerID` INT NOT NULL,
	`PendingMatchID` INT NOT NULL,

	PRIMARY KEY (`PlayerID`),

	FOREIGN KEY (`PlayerID`)
		REFERENCES `MatchMaking`.`Player`(`ID`)
		ON UPDATE CASCADE ON DELETE RESTRICT,

	FOREIGN KEY (`PendingMatchID`)
		REFERENCES `MatchMaking`.`PendingMatch`(`ID`)
		ON UPDATE CASCADE ON DELETE RESTRICT
);
