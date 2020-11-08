-- MySQL dump 10.13  Distrib 8.0.22, for macos10.15 (x86_64)
--
-- Host: localhost    Database: motel
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Bird`
--

DROP TABLE IF EXISTS `Bird`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Bird` (
  `petID` int NOT NULL,
  `communication` char(50) DEFAULT NULL,
  `featherRoutine` char(50) DEFAULT NULL,
  `socialization` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`petID`),
  CONSTRAINT `bird_ibfk_1` FOREIGN KEY (`petID`) REFERENCES `Pet` (`petID`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bird`
--

LOCK TABLES `Bird` WRITE;
/*!40000 ALTER TABLE `Bird` DISABLE KEYS */;
INSERT INTO `Bird` VALUES (1,'Vocal','Self-preening',1),(5,'English','Requires assistance',0),(6,'Non-vocal','Self-preening',1),(12,'Non-vocal','Self-preening',1),(15,'Non-vocal','Self-preening',1);
/*!40000 ALTER TABLE `Bird` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BookingDate`
--

DROP TABLE IF EXISTS `BookingDate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BookingDate` (
  `startDate` date NOT NULL,
  `endDate` date NOT NULL,
  `duration` int DEFAULT NULL,
  PRIMARY KEY (`startDate`,`endDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BookingDate`
--

LOCK TABLES `BookingDate` WRITE;
/*!40000 ALTER TABLE `BookingDate` DISABLE KEYS */;
INSERT INTO `BookingDate` VALUES ('2020-01-01','2020-01-16',15),('2020-06-01','2020-06-26',25),('2020-07-01','2020-07-21',20),('2020-10-01','2020-10-06',5),('2020-10-01','2020-10-11',10);
/*!40000 ALTER TABLE `BookingDate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Branch`
--

DROP TABLE IF EXISTS `Branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Branch` (
  `branchID` int NOT NULL,
  `phone` char(10) NOT NULL,
  `postalCode` char(6) NOT NULL,
  `street` char(50) NOT NULL,
  PRIMARY KEY (`branchID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Branch`
--

LOCK TABLES `Branch` WRITE;
/*!40000 ALTER TABLE `Branch` DISABLE KEYS */;
INSERT INTO `Branch` VALUES (1,'7789077930','V3B5R5','2929 Barnet Hwy'),(2,'6048889999','V3A7E9','19705 Fraser Hwy'),(3,'7780068293','V7T2W4','2002 Park Royal South'),(4,'6048820837','V6T2C9','5959 Student Union Boulevard'),(5,'6040254361','V3J1N4','9855 Austin Ave');
/*!40000 ALTER TABLE `Branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CaresFor`
--

DROP TABLE IF EXISTS `CaresFor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CaresFor` (
  `petID` int NOT NULL,
  `staffID` int NOT NULL,
  PRIMARY KEY (`petID`,`staffID`),
  KEY `staffID` (`staffID`),
  CONSTRAINT `caresfor_ibfk_1` FOREIGN KEY (`petID`) REFERENCES `Pet` (`petID`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `caresfor_ibfk_2` FOREIGN KEY (`staffID`) REFERENCES `Staff` (`staffID`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CaresFor`
--

LOCK TABLES `CaresFor` WRITE;
/*!40000 ALTER TABLE `CaresFor` DISABLE KEYS */;
INSERT INTO `CaresFor` VALUES (2,180),(11,240),(8,360),(10,720),(1,747),(3,747),(4,747),(5,747),(6,747),(7,747),(9,747),(12,747),(13,747),(14,747),(15,747);
/*!40000 ALTER TABLE `CaresFor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CarriesMembership`
--

DROP TABLE IF EXISTS `CarriesMembership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CarriesMembership` (
  `custID` int DEFAULT NULL,
  `cardNo` int NOT NULL,
  `points` int DEFAULT NULL,
  PRIMARY KEY (`cardNo`),
  KEY `custID` (`custID`),
  CONSTRAINT `carriesmembership_ibfk_1` FOREIGN KEY (`custID`) REFERENCES `Owner` (`custID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CarriesMembership`
--

LOCK TABLES `CarriesMembership` WRITE;
/*!40000 ALTER TABLE `CarriesMembership` DISABLE KEYS */;
INSERT INTO `CarriesMembership` VALUES (1,11111111,0),(3,11111112,100),(5,11111113,200),(6,11111114,1000),(8,11111115,0);
/*!40000 ALTER TABLE `CarriesMembership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HasLivingSpace`
--

DROP TABLE IF EXISTS `HasLivingSpace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `HasLivingSpace` (
  `roomNo` int NOT NULL,
  `branchID` int NOT NULL,
  PRIMARY KEY (`roomNo`,`branchID`),
  KEY `branchID` (`branchID`),
  CONSTRAINT `haslivingspace_ibfk_1` FOREIGN KEY (`branchID`) REFERENCES `Branch` (`branchID`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HasLivingSpace`
--

LOCK TABLES `HasLivingSpace` WRITE;
/*!40000 ALTER TABLE `HasLivingSpace` DISABLE KEYS */;
INSERT INTO `HasLivingSpace` VALUES (101,1),(201,2),(301,3),(401,4),(501,5);
/*!40000 ALTER TABLE `HasLivingSpace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MakeBooking`
--

DROP TABLE IF EXISTS `MakeBooking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MakeBooking` (
  `confirmationID` int NOT NULL,
  `custID` int DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  PRIMARY KEY (`confirmationID`),
  KEY `custID` (`custID`),
  CONSTRAINT `makebooking_ibfk_1` FOREIGN KEY (`custID`) REFERENCES `Owner` (`custID`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MakeBooking`
--

LOCK TABLES `MakeBooking` WRITE;
/*!40000 ALTER TABLE `MakeBooking` DISABLE KEYS */;
INSERT INTO `MakeBooking` VALUES (100,1,'2020-10-20','2020-10-10'),(101,2,'2020-01-01','2020-01-10'),(102,3,'2020-02-01','2020-02-10'),(103,4,'2020-03-01','2020-03-10'),(104,5,'2020-04-01','2020-04-10');
/*!40000 ALTER TABLE `MakeBooking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Mammal`
--

DROP TABLE IF EXISTS `Mammal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Mammal` (
  `petID` int NOT NULL,
  `personality` char(50) DEFAULT NULL,
  `furRoutine` char(50) DEFAULT NULL,
  `nailRoutine` char(50) DEFAULT NULL,
  PRIMARY KEY (`petID`),
  CONSTRAINT `mammal_ibfk_1` FOREIGN KEY (`petID`) REFERENCES `Pet` (`petID`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Mammal`
--

LOCK TABLES `Mammal` WRITE;
/*!40000 ALTER TABLE `Mammal` DISABLE KEYS */;
INSERT INTO `Mammal` VALUES (2,'Aggressive','Brush','Clip'),(8,'Shy','Brush','Paint'),(10,'Energetic','Bathe',NULL),(11,'Friendly',NULL,'Paint'),(13,'Energetic','Bathe','Clip');
/*!40000 ALTER TABLE `Mammal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Owner`
--

DROP TABLE IF EXISTS `Owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Owner` (
  `custID` int NOT NULL,
  `email` char(50) NOT NULL,
  `phone` char(10) NOT NULL,
  `password` char(20) NOT NULL,
  `postalCode` char(6) NOT NULL,
  `street` char(50) NOT NULL,
  `firstName` char(50) NOT NULL,
  `lastName` char(50) NOT NULL,
  PRIMARY KEY (`custID`),
  UNIQUE KEY `email` (`email`),
  KEY `postalCode` (`postalCode`),
  CONSTRAINT `owner_ibfk_1` FOREIGN KEY (`postalCode`) REFERENCES `PostalCode` (`postalCode`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Owner`
--

LOCK TABLES `Owner` WRITE;
/*!40000 ALTER TABLE `Owner` DISABLE KEYS */;
INSERT INTO `Owner` VALUES (1,'swong@gmail.com','1111','pass123','V6T2C9','5959 Student Union Boulevard','Spencer','Wong'),(2,'jenarnold@gmail.com','6043217654','qwerty','V3B5R5','2929 Barnet Hwy','Jennifer','Arnold'),(3,'dorah32@gmail.com','6049876543','dragon','V7T2W4','2002 Park Royal South','Dora','Hicks'),(4,'phelpsjulio@gmail.com','7781352468','baseball','V3A7E9','19705 Fraser Hwy','Julio','Phelps'),(5,'hamilmichael@gmail.com','7789987765','passw0rd','V3B5R5','2929 Barnet Hwy','Michael','Hamilton'),(6,'kathryn.cohen@gmail.com','6045537098','superman','V3A7E9','19705 Fraser Hwy','Kathryn','Cohen'),(7,'betsyjacobs1@gmail.com','6041345623','football','V3J1N4','9855 Austin Ave','Betsy','Jacobs'),(8,'brian4snyder@gmail.com','7786431234','welcome','V7T2W4','2002 Park Royal South','Brian','Snyder'),(9,'pmedina@gmail.com','6044120897','princess','V3B5R5','2929 Barnet Hwy','Patty','Medina'),(10,'charlter@gmail.com','7786780841','123qwe','V3A7E9','19705 Fraser Hwy','Charlene','Terry'),(11,'josephtang81@gmail.com','7780114675','hello','V3J1N4','9855 Austin Ave','Joseph','Tang'),(12,'linettekahn942@gmail.com','7788899342','whatever','V3J1N4','9855 Austin Ave','Linette','Kahn'),(13,'tomas.rowe@gmail.com','6046653341','trustno1','V3A7E9','19705 Fraser Hwy','Tomas','Rowe'),(14,'lunanoel@gmail.com','6041123344','letmein','V6T2C9','5959 Student Union Boulevard','Noel','Luna');
/*!40000 ALTER TABLE `Owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PerformsService`
--

DROP TABLE IF EXISTS `PerformsService`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PerformsService` (
  `title` char(20) NOT NULL,
  `staffID` int NOT NULL,
  PRIMARY KEY (`title`,`staffID`),
  KEY `staffID` (`staffID`),
  CONSTRAINT `performsservice_ibfk_1` FOREIGN KEY (`staffID`) REFERENCES `Staff` (`staffID`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PerformsService`
--

LOCK TABLES `PerformsService` WRITE;
/*!40000 ALTER TABLE `PerformsService` DISABLE KEYS */;
INSERT INTO `PerformsService` VALUES ('Dog walking',180),('Dog washing',240),('Grooming',360),('Nail cutting',720),('Washing',747);
/*!40000 ALTER TABLE `PerformsService` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pet`
--

DROP TABLE IF EXISTS `Pet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pet` (
  `name` char(50) NOT NULL,
  `photo` char(50) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `species` char(50) DEFAULT NULL,
  `diet` char(50) DEFAULT NULL,
  `petID` int NOT NULL,
  `branchID` int DEFAULT NULL,
  `roomNo` int DEFAULT NULL,
  `ownerID` int DEFAULT NULL,
  PRIMARY KEY (`petID`),
  KEY `branchID` (`branchID`),
  KEY `roomNo` (`roomNo`),
  KEY `ownerID` (`ownerID`),
  CONSTRAINT `pet_ibfk_1` FOREIGN KEY (`branchID`) REFERENCES `Branch` (`branchID`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `pet_ibfk_2` FOREIGN KEY (`roomNo`) REFERENCES `HasLivingSpace` (`roomNo`) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `pet_ibfk_3` FOREIGN KEY (`ownerID`) REFERENCES `Owner` (`custID`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pet`
--

LOCK TABLES `Pet` WRITE;
/*!40000 ALTER TABLE `Pet` DISABLE KEYS */;
INSERT INTO `Pet` VALUES ('Angel','/photos/00000001.jpg',0.26,'F',9,'Dog','Seeds',1,1,101,8),('Bear','/photos/00000002.jpg',30.8,'M',3,'Dog','Dry',2,2,201,6),('Cherry','/photos/00000003.jpg',4.7,'F',2,'Turtle','Dry',3,4,401,9),('Draco','/photos/00000004.jpg',0.53,'M',8,'Bearded Dragon','Fresh',4,4,401,3),('Harley','/photos/00000005.jpg',2,'F',2,'Parrot','Seeds',5,1,401,7),('Mango','/photos/00000006.jpg',1.7,'F',3,'Parrot','Fresh',6,1,401,11),('Michelangelo','/photos/00000007.jpg',7.6,'M',3,'Turtle','Fresh',7,4,401,1),('Nala','/photos/00000008.jpg',4,'F',11,'Cat','Wet',8,3,301,5),('Pip','/photos/00000009.jpg',0.46,'F',4,'Snake','Fresh',9,5,501,12),('Pocket','/photos/00000010.jpg',3.1,'F',5,'Cat','Dry',10,3,301,2),('Rory','/photos/00000011.jpg',35.4,'F',8,'Dog','Dry',11,2,201,13),('Sapphire','/photos/00000012.jpg',0.09,'F',3,'Cockatiel','Seeds',12,1,101,4),('Simba','/photos/00000013.jpg',5.1,'M',2,'Dog','Wet',13,2,201,9),('Squirt','/photos/00000014.jpg',5.2,'M',2,'Turtle','Fresh',14,4,401,14),('Tweety','/photos/00000015.jpg',0.14,'M',5,'Parakeet','Seeds',15,1,101,10);
/*!40000 ALTER TABLE `Pet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PostalCode`
--

DROP TABLE IF EXISTS `PostalCode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PostalCode` (
  `postalCode` char(6) NOT NULL,
  `city` char(50) DEFAULT NULL,
  PRIMARY KEY (`postalCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PostalCode`
--

LOCK TABLES `PostalCode` WRITE;
/*!40000 ALTER TABLE `PostalCode` DISABLE KEYS */;
INSERT INTO `PostalCode` VALUES ('V3A7E9','Langley'),('V3B5R5','Coquitlam'),('V3J1N4','Burnaby'),('V6T2C9','Vancouver'),('V6T3C9','Vancouver'),('V7T2W4','West Vancouver');
/*!40000 ALTER TABLE `PostalCode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Price`
--

DROP TABLE IF EXISTS `Price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Price` (
  `duration` int NOT NULL,
  `price` float DEFAULT NULL,
  PRIMARY KEY (`duration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Price`
--

LOCK TABLES `Price` WRITE;
/*!40000 ALTER TABLE `Price` DISABLE KEYS */;
INSERT INTO `Price` VALUES (5,250),(10,500),(15,750),(20,1000),(25,1250);
/*!40000 ALTER TABLE `Price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reptile`
--

DROP TABLE IF EXISTS `Reptile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reptile` (
  `petID` int NOT NULL,
  `tempRequirement` char(50) DEFAULT NULL,
  `isMoulting` tinyint(1) DEFAULT NULL,
  `lightConditions` char(50) DEFAULT NULL,
  PRIMARY KEY (`petID`),
  CONSTRAINT `reptile_ibfk_1` FOREIGN KEY (`petID`) REFERENCES `Pet` (`petID`) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reptile`
--

LOCK TABLES `Reptile` WRITE;
/*!40000 ALTER TABLE `Reptile` DISABLE KEYS */;
INSERT INTO `Reptile` VALUES (3,'22 - 25',0,'12'),(4,'25 - 30',0,'12'),(7,'22 - 25',0,'12'),(9,'30 - 35',1,'24'),(14,'22 - 25',0,'12');
/*!40000 ALTER TABLE `Reptile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Reserves`
--

DROP TABLE IF EXISTS `Reserves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Reserves` (
  `confirmationID` int NOT NULL,
  `title` char(20) NOT NULL,
  PRIMARY KEY (`confirmationID`,`title`),
  KEY `title` (`title`),
  CONSTRAINT `reserves_ibfk_1` FOREIGN KEY (`confirmationID`) REFERENCES `MakeBooking` (`confirmationID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reserves_ibfk_2` FOREIGN KEY (`title`) REFERENCES `PerformsService` (`title`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Reserves`
--

LOCK TABLES `Reserves` WRITE;
/*!40000 ALTER TABLE `Reserves` DISABLE KEYS */;
INSERT INTO `Reserves` VALUES (102,'Dog walking'),(103,'Dog walking'),(100,'Grooming'),(101,'Nail cutting'),(104,'Washing');
/*!40000 ALTER TABLE `Reserves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Staff`
--

DROP TABLE IF EXISTS `Staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Staff` (
  `staffID` int NOT NULL,
  `title` char(20) NOT NULL,
  `firstName` char(20) NOT NULL,
  `lastName` char(20) NOT NULL,
  `email` char(30) NOT NULL,
  `speciality` char(20) DEFAULT NULL,
  `hasManagerAccess` tinyint(1) DEFAULT NULL,
  `password` char(20) NOT NULL,
  PRIMARY KEY (`staffID`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `password` (`password`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Staff`
--

LOCK TABLES `Staff` WRITE;
/*!40000 ALTER TABLE `Staff` DISABLE KEYS */;
INSERT INTO `Staff` VALUES (180,'Dog walking','Milton','Keynes','mkey@yahoo.com','Walker',0,'304databases'),(240,'Dog washing','Anna','Banana','annaa@banana.com','Washer',1,'itsmyfavourite2131'),(360,'Grooming','Mike','Jaeger','mikejaeger@gmail.com','Groomer',0,'superfly1121'),(720,'Nail cutting','Amy','Beerhouse','beerhouse@gmail.com','Nail trimmer',0,'ellemayoh'),(747,'Washing','Bob','Deelan','bd1120@hotmail.com','Washer',0,'sosadsoverysad0101');
/*!40000 ALTER TABLE `Staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WorksAt`
--

DROP TABLE IF EXISTS `WorksAt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WorksAt` (
  `branchID` int NOT NULL,
  `staffID` int NOT NULL,
  PRIMARY KEY (`branchID`,`staffID`),
  KEY `staffID` (`staffID`),
  CONSTRAINT `worksat_ibfk_1` FOREIGN KEY (`branchID`) REFERENCES `Branch` (`branchID`) ON UPDATE CASCADE,
  CONSTRAINT `worksat_ibfk_2` FOREIGN KEY (`staffID`) REFERENCES `Staff` (`staffID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WorksAt`
--

LOCK TABLES `WorksAt` WRITE;
/*!40000 ALTER TABLE `WorksAt` DISABLE KEYS */;
INSERT INTO `WorksAt` VALUES (3,180),(5,240),(2,360),(4,720),(1,747);
/*!40000 ALTER TABLE `WorksAt` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-04 13:52:14
