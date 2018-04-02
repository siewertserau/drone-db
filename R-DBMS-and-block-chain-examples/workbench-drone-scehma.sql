-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 ;
-- -----------------------------------------------------
-- Schema dronetracking
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dronetracking
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dronetracking` DEFAULT CHARACTER SET latin1 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Branch` (
  `branchNo` CHAR(5) NOT NULL,
  `street` VARCHAR(35) NULL DEFAULT NULL,
  `area` VARCHAR(10) NULL DEFAULT NULL,
  `city` VARCHAR(10) NULL DEFAULT NULL,
  `pcode` VARCHAR(10) NULL DEFAULT NULL,
  `telNo` CHAR(15) NULL DEFAULT NULL,
  `faxNo` CHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`branchNo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`Clothing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Clothing` (
  `idClothing` INT(11) NOT NULL,
  `Type` VARCHAR(45) NOT NULL,
  `Color` VARCHAR(45) NOT NULL,
  `Gender` VARCHAR(45) NULL DEFAULT NULL,
  `Size` VARCHAR(45) NOT NULL,
  `Material` VARCHAR(45) NULL DEFAULT NULL,
  `Attire` VARCHAR(45) NOT NULL,
  `Style` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idClothing`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`Student Information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Student Information` (
  `StudentID` INT(11) NOT NULL,
  `FirstName` VARCHAR(45) NULL DEFAULT NULL,
  `LastName` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`StudentID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`Check out`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Check out` (
  `Clothing_idClothing` INT(11) NOT NULL,
  `Check Date/Time` DATETIME NOT NULL,
  `Return Date/Time` DATETIME NOT NULL,
  `Student Information_StudentID` INT(11) NOT NULL,
  PRIMARY KEY (`Student Information_StudentID`),
  INDEX `fk_Check out_Clothing2_idx` (`Clothing_idClothing` ASC),
  INDEX `fk_Check out_Student Information1_idx` (`Student Information_StudentID` ASC),
  CONSTRAINT `fk_Check out_Clothing2`
    FOREIGN KEY (`Clothing_idClothing`)
    REFERENCES `mydb`.`Clothing` (`idClothing`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Check out_Student Information1`
    FOREIGN KEY (`Student Information_StudentID`)
    REFERENCES `mydb`.`Student Information` (`StudentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`Client By Incident Count`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client By Incident Count` (
  `clientNo` INT(11) NULL DEFAULT NULL,
  `fName` INT(11) NULL DEFAULT NULL,
  `lName` INT(11) NULL DEFAULT NULL,
  `respID` INT(11) NULL DEFAULT NULL,
  `incidentCount` INT(11) NULL DEFAULT NULL,
  `department` INT(11) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`Responder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Responder` (
  `respID` CHAR(5) NOT NULL,
  `department` VARCHAR(10) NULL DEFAULT NULL,
  `street` VARCHAR(35) NULL DEFAULT NULL,
  `area` VARCHAR(10) NULL DEFAULT NULL,
  `city` VARCHAR(10) NULL DEFAULT NULL,
  `pcode` VARCHAR(10) NULL DEFAULT NULL,
  `telNo` VARCHAR(15) NULL DEFAULT NULL,
  `faxno` VARCHAR(15) NULL DEFAULT NULL,
  `Branch_branchNo` CHAR(5) NOT NULL,
  PRIMARY KEY (`respID`),
  INDEX `fk_Responder_Branch1_idx` (`Branch_branchNo` ASC),
  CONSTRAINT `fk_Responder_Branch1`
    FOREIGN KEY (`Branch_branchNo`)
    REFERENCES `mydb`.`Branch` (`branchNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Staff` (
  `staffNo` CHAR(5) NOT NULL,
  `fName` VARCHAR(10) NULL DEFAULT NULL,
  `lName` VARCHAR(10) NULL DEFAULT NULL,
  `address` VARCHAR(35) NULL DEFAULT NULL,
  `telNo` CHAR(10) NULL DEFAULT NULL,
  `position` VARCHAR(10) NULL DEFAULT NULL,
  `gender` CHAR(1) NULL DEFAULT NULL,
  `dob` CHAR(45) NULL DEFAULT NULL,
  `salary` SMALLINT(6) NULL DEFAULT NULL,
  `Branch_branchNo` CHAR(5) NOT NULL,
  PRIMARY KEY (`staffNo`),
  INDEX `fk_Staff_Branch_idx` (`Branch_branchNo` ASC),
  CONSTRAINT `fk_Staff_Branch`
    FOREIGN KEY (`Branch_branchNo`)
    REFERENCES `mydb`.`Branch` (`branchNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Clients` (
  `clientNo` CHAR(5) NOT NULL,
  `fName` VARCHAR(10) NULL DEFAULT NULL,
  `lName` VARCHAR(10) NULL DEFAULT NULL,
  `address` VARCHAR(45) NULL DEFAULT NULL,
  `telNo` CHAR(15) NULL DEFAULT NULL,
  `subType` VARCHAR(10) NULL DEFAULT NULL,
  `incidentCount` SMALLINT(3) NULL DEFAULT NULL,
  `Responder_respID` CHAR(5) NOT NULL,
  `Staff_staffNo` CHAR(5) NOT NULL,
  PRIMARY KEY (`clientNo`),
  INDEX `fk_Client_Responder1_idx` (`Responder_respID` ASC),
  INDEX `fk_Client_Staff1_idx` (`Staff_staffNo` ASC),
  CONSTRAINT `fk_Client_Responder1`
    FOREIGN KEY (`Responder_respID`)
    REFERENCES `mydb`.`Responder` (`respID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Client_Staff1`
    FOREIGN KEY (`Staff_staffNo`)
    REFERENCES `mydb`.`Staff` (`staffNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`Incident`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Incident` (
  `Client_clientNo` CHAR(5) NOT NULL,
  `timeOf` VARCHAR(5) NULL DEFAULT NULL,
  `dateOf` CHAR(9) NULL DEFAULT NULL,
  `Staff_staffNo` CHAR(5) NOT NULL,
  `Responder_respID` CHAR(5) NOT NULL,
  `description` VARCHAR(35) NULL DEFAULT NULL,
  INDEX `fk_Incident_Client1_idx` (`Client_clientNo` ASC),
  INDEX `fk_Incident_Staff1_idx` (`Staff_staffNo` ASC),
  INDEX `fk_Incident_Responder1_idx` (`Responder_respID` ASC),
  CONSTRAINT `fk_Incident_Client1`
    FOREIGN KEY (`Client_clientNo`)
    REFERENCES `mydb`.`Clients` (`clientNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Incident_Responder1`
    FOREIGN KEY (`Responder_respID`)
    REFERENCES `mydb`.`Responder` (`respID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Incident_Staff1`
    FOREIGN KEY (`Staff_staffNo`)
    REFERENCES `mydb`.`Staff` (`staffNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`Incident Reports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Incident Reports` (
  `clientNo` INT(11) NULL DEFAULT NULL,
  `fName` INT(11) NULL DEFAULT NULL,
  `lName` INT(11) NULL DEFAULT NULL,
  `dateOf` INT(11) NULL DEFAULT NULL,
  `timeOf` INT(11) NULL DEFAULT NULL,
  `staffNo` INT(11) NULL DEFAULT NULL,
  `respID` INT(11) NULL DEFAULT NULL,
  `department` INT(11) NULL DEFAULT NULL,
  `description` INT(11) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`Interview`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Interview` (
  `Student Information_StudentID` INT(11) NOT NULL,
  `InterviewDate/Time` DATETIME NOT NULL,
  `Company` VARCHAR(45) NULL DEFAULT NULL,
  `Location` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Student Information_StudentID`),
  CONSTRAINT `fk_Interview_Student Information1`
    FOREIGN KEY (`Student Information_StudentID`)
    REFERENCES `mydb`.`Student Information` (`StudentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`Manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Manager` (
  `Staff_staffNo` CHAR(5) NOT NULL,
  `Branch_branchNo` CHAR(5) NOT NULL,
  INDEX `fk_Manager_Branch1_idx` (`Branch_branchNo` ASC),
  INDEX `fk_Manager_Staff1_idx` (`Staff_staffNo` ASC),
  CONSTRAINT `fk_Manager_Branch1`
    FOREIGN KEY (`Branch_branchNo`)
    REFERENCES `mydb`.`Branch` (`branchNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Manager_Staff1`
    FOREIGN KEY (`Staff_staffNo`)
    REFERENCES `mydb`.`Staff` (`staffNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Status` (
  `Clothing_idClothing` INT(11) NOT NULL,
  `ClothingStatus` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Clothing_idClothing`),
  INDEX `ClothingStatus.idx` (`Clothing_idClothing` ASC),
  CONSTRAINT `fk_Status_Clothing1`
    FOREIGN KEY (`Clothing_idClothing`)
    REFERENCES `mydb`.`Clothing` (`idClothing`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`Subscription Types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Subscription Types` (
  `subType` CHAR(10) NOT NULL,
  `duration` SMALLINT(5) NULL DEFAULT NULL,
  `cost` SMALLINT(5) NULL DEFAULT NULL,
  PRIMARY KEY (`subType`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`Subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Subscriptions` (
  `SubID` VARCHAR(10) NOT NULL,
  `Client_clientNo` CHAR(5) NOT NULL,
  `SubTypes_subType` CHAR(10) NOT NULL,
  `Staff_staffNo` CHAR(5) NOT NULL,
  `Responder_respID` CHAR(5) NOT NULL,
  PRIMARY KEY (`SubID`),
  INDEX `fk_Subscriptions_Client1_idx` (`Client_clientNo` ASC),
  INDEX `fk_Subscriptions_SubTypes1_idx` (`SubTypes_subType` ASC),
  INDEX `fk_Subscriptions_Staff1_idx` (`Staff_staffNo` ASC),
  INDEX `fk_Subscriptions_Responder1_idx` (`Responder_respID` ASC),
  CONSTRAINT `fk_Subscriptions_Client1`
    FOREIGN KEY (`Client_clientNo`)
    REFERENCES `mydb`.`Clients` (`clientNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Subscriptions_Responder1`
    FOREIGN KEY (`Responder_respID`)
    REFERENCES `mydb`.`Responder` (`respID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Subscriptions_Staff1`
    FOREIGN KEY (`Staff_staffNo`)
    REFERENCES `mydb`.`Staff` (`staffNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Subscriptions_SubTypes1`
    FOREIGN KEY (`SubTypes_subType`)
    REFERENCES `mydb`.`Subscription Types` (`subType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `idUser` INT(11) NOT NULL AUTO_INCREMENT,
  `lName` VARCHAR(45) NOT NULL,
  `fName` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `mydb`.`table1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`table1` (
  `idtable1` INT(11) NOT NULL,
  PRIMARY KEY (`idtable1`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

USE `dronetracking` ;

-- -----------------------------------------------------
-- Table `dronetracking`.`CertifiedOwner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dronetracking`.`CertifiedOwner` (
  `ownerid` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `firsname` VARCHAR(30) NULL DEFAULT NULL,
  `lastname` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`ownerid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dronetracking`.`HobbyRegistration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dronetracking`.`HobbyRegistration` (
  `certnumber` CHAR(10) NOT NULL,
  `issue_date` DATE NULL DEFAULT NULL,
  `expiration_date` DATE NULL DEFAULT NULL,
  `CertifiedOwner_ownerid` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`certnumber`),
  INDEX `fk_HobbyRegistration_CertifiedOwner1_idx` (`CertifiedOwner_ownerid` ASC),
  CONSTRAINT `fk_HobbyRegistration_CertifiedOwner1`
    FOREIGN KEY (`CertifiedOwner_ownerid`)
    REFERENCES `dronetracking`.`CertifiedOwner` (`ownerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dronetracking`.`ADSBlog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dronetracking`.`ADSBlog` (
  `eventid` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ICAO` BIT(24) NOT NULL,
  `type` CHAR(3) NULL DEFAULT NULL,
  `latitude` DOUBLE NULL DEFAULT NULL,
  `longitude` DOUBLE NULL DEFAULT NULL,
  `altitude` DOUBLE NULL DEFAULT NULL,
  `heading` DOUBLE NULL DEFAULT NULL,
  `horizontal_velocity` DOUBLE NULL DEFAULT NULL,
  `vertical_velocity` DOUBLE NULL DEFAULT NULL,
  `time_since_last_contact` INT(6) UNSIGNED NULL DEFAULT NULL,
  `HobbyRegistration_certnumber` CHAR(10) NOT NULL,
  PRIMARY KEY (`eventid`),
  INDEX `fk_ADSBlog_HobbyRegistration1_idx` (`HobbyRegistration_certnumber` ASC),
  CONSTRAINT `fk_ADSBlog_HobbyRegistration1`
    FOREIGN KEY (`HobbyRegistration_certnumber`)
    REFERENCES `dronetracking`.`HobbyRegistration` (`certnumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dronetracking`.`HobbyDrone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dronetracking`.`HobbyDrone` (
  `serialnumber` VARCHAR(30) NOT NULL,
  `make` VARCHAR(30) NULL DEFAULT NULL,
  `model` VARCHAR(30) NULL DEFAULT NULL,
  `HobbyRegistration_certnumber` CHAR(10) NOT NULL,
  PRIMARY KEY (`serialnumber`),
  INDEX `fk_HobbyDrone_HobbyRegistration_idx` (`HobbyRegistration_certnumber` ASC),
  CONSTRAINT `fk_HobbyDrone_HobbyRegistration`
    FOREIGN KEY (`HobbyRegistration_certnumber`)
    REFERENCES `dronetracking`.`HobbyRegistration` (`certnumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dronetracking`.`OwnerAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dronetracking`.`OwnerAddress` (
  `locationid` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(30) NULL DEFAULT NULL,
  `city` VARCHAR(30) NULL DEFAULT NULL,
  `state` CHAR(2) NULL DEFAULT NULL,
  `zipcode` INT(5) NULL DEFAULT NULL,
  `CertifiedOwner_ownerid` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`locationid`),
  INDEX `fk_OwnerAddress_CertifiedOwner1_idx` (`CertifiedOwner_ownerid` ASC),
  CONSTRAINT `fk_OwnerAddress_CertifiedOwner1`
    FOREIGN KEY (`CertifiedOwner_ownerid`)
    REFERENCES `dronetracking`.`CertifiedOwner` (`ownerid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`Client List`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client List` (`clientNo` INT, `fName` INT, `lName` INT, `address` INT, `telNo` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`Client by Subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client by Subscription` (`ClientNo` INT, `fName` INT, `lName` INT, `address` INT, `telNo` INT, `subType` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`Responder By Branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Responder By Branch` (`respID` INT, `department` INT, `branchNo` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`Staff List`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Staff List` (`staffNo` INT, `fName` INT, `lName` INT, `address` INT, `telNo` INT, `position` INT, `Branch_branchNo` INT);

-- -----------------------------------------------------
-- View `mydb`.`Client List`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Client List`;
USE `mydb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`siewerts`@`localhost` SQL SECURITY DEFINER VIEW `mydb`.`Client List` AS select `mydb`.`Clients`.`clientNo` AS `clientNo`,`mydb`.`Clients`.`fName` AS `fName`,`mydb`.`Clients`.`lName` AS `lName`,`mydb`.`Clients`.`address` AS `address`,`mydb`.`Clients`.`telNo` AS `telNo` from `mydb`.`Clients`;

-- -----------------------------------------------------
-- View `mydb`.`Client by Subscription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Client by Subscription`;
USE `mydb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`siewerts`@`localhost` SQL SECURITY DEFINER VIEW `mydb`.`Client by Subscription` AS select `mydb`.`Clients`.`clientNo` AS `ClientNo`,`mydb`.`Clients`.`fName` AS `fName`,`mydb`.`Clients`.`lName` AS `lName`,`mydb`.`Clients`.`address` AS `address`,`mydb`.`Clients`.`telNo` AS `telNo`,`mydb`.`Clients`.`subType` AS `subType` from `mydb`.`Clients` order by `mydb`.`Clients`.`subType`;

-- -----------------------------------------------------
-- View `mydb`.`Responder By Branch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Responder By Branch`;
USE `mydb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`siewerts`@`localhost` SQL SECURITY DEFINER VIEW `mydb`.`Responder By Branch` AS select `mydb`.`Responder`.`respID` AS `respID`,`mydb`.`Responder`.`department` AS `department`,`mydb`.`Branch`.`branchNo` AS `branchNo` from (`mydb`.`Responder` join `mydb`.`Branch` on((`mydb`.`Responder`.`Branch_branchNo` = `mydb`.`Branch`.`branchNo`))) order by `mydb`.`Responder`.`Branch_branchNo`;

-- -----------------------------------------------------
-- View `mydb`.`Staff List`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Staff List`;
USE `mydb`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`siewerts`@`localhost` SQL SECURITY DEFINER VIEW `mydb`.`Staff List` AS select `mydb`.`Staff`.`staffNo` AS `staffNo`,`mydb`.`Staff`.`fName` AS `fName`,`mydb`.`Staff`.`lName` AS `lName`,`mydb`.`Staff`.`address` AS `address`,`mydb`.`Staff`.`telNo` AS `telNo`,`mydb`.`Staff`.`position` AS `position`,`mydb`.`Staff`.`Branch_branchNo` AS `Branch_branchNo` from `mydb`.`Staff`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
