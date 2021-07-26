CREATE DATABASE  IF NOT EXISTS `database20` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `database20`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: database20
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `administrator`
--

DROP TABLE IF EXISTS `administrator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrator` (
  `email` varchar(40) NOT NULL,
  `username` varchar(40) NOT NULL,
  `pass` varchar(40) NOT NULL,
  PRIMARY KEY (`email`,`username`),
  KEY `username` (`username`),
  CONSTRAINT `administrator_ibfk_1` FOREIGN KEY (`username`) REFERENCES `useraccount` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrator`
--

LOCK TABLES `administrator` WRITE;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` VALUES ('root@buyMe.com','root','UN5AW!]x9K{[bP');
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asks`
--

DROP TABLE IF EXISTS `asks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asks` (
  `CR_email` varchar(40) NOT NULL,
  `CR_username` varchar(40) DEFAULT NULL,
  `EU_email` varchar(40) NOT NULL,
  `EU_username` varchar(40) DEFAULT NULL,
  `qID` int DEFAULT NULL,
  `question` varchar(250) DEFAULT NULL,
  `answer` text,
  PRIMARY KEY (`CR_email`,`EU_email`),
  KEY `CR_email` (`CR_email`,`CR_username`),
  KEY `EU_email` (`EU_email`,`EU_username`),
  CONSTRAINT `asks_ibfk_1` FOREIGN KEY (`CR_email`, `CR_username`) REFERENCES `customerrep` (`email`, `username`),
  CONSTRAINT `asks_ibfk_2` FOREIGN KEY (`EU_email`, `EU_username`) REFERENCES `enduser` (`email`, `username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asks`
--

LOCK TABLES `asks` WRITE;
/*!40000 ALTER TABLE `asks` DISABLE KEYS */;
/*!40000 ALTER TABLE `asks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auction`
--

DROP TABLE IF EXISTS `auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auction` (
  `auctionNumber` int NOT NULL,
  `winner` varchar(40) DEFAULT NULL,
  `previousBid` float DEFAULT NULL,
  `currentPrice` float DEFAULT NULL,
  `initialPrice` float DEFAULT NULL,
  `reservePrice` float DEFAULT NULL,
  `timeRemaining` datetime DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  PRIMARY KEY (`auctionNumber`),
  KEY `winner` (`winner`),
  CONSTRAINT `auction_ibfk_1` FOREIGN KEY (`winner`) REFERENCES `buyer` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auction`
--

LOCK TABLES `auction` WRITE;
/*!40000 ALTER TABLE `auction` DISABLE KEYS */;
/*!40000 ALTER TABLE `auction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autobidder`
--

DROP TABLE IF EXISTS `autobidder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autobidder` (
  `bidNum` int NOT NULL,
  `email` varchar(40) NOT NULL,
  `itemNumber` int NOT NULL,
  `upperLimit` float NOT NULL,
  PRIMARY KEY (`bidNum`,`itemNumber`,`email`),
  KEY `itemNumber` (`itemNumber`),
  KEY `email` (`email`),
  CONSTRAINT `autobidder_ibfk_1` FOREIGN KEY (`bidNum`) REFERENCES `bid` (`bidNum`),
  CONSTRAINT `autobidder_ibfk_2` FOREIGN KEY (`itemNumber`) REFERENCES `product` (`itemNumber`) ON DELETE CASCADE,
  CONSTRAINT `autobidder_ibfk_3` FOREIGN KEY (`email`) REFERENCES `buyer` (`email`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autobidder`
--

LOCK TABLES `autobidder` WRITE;
/*!40000 ALTER TABLE `autobidder` DISABLE KEYS */;
/*!40000 ALTER TABLE `autobidder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bid`
--

DROP TABLE IF EXISTS `bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bid` (
  `bidNum` int NOT NULL,
  `bidDate` date NOT NULL,
  `bidPrice` float NOT NULL,
  `itemNumber` int NOT NULL,
  `email` varchar(40) NOT NULL,
  PRIMARY KEY (`bidNum`),
  KEY `email` (`email`),
  KEY `itemNumber` (`itemNumber`),
  CONSTRAINT `bid_ibfk_1` FOREIGN KEY (`email`) REFERENCES `buyer` (`email`),
  CONSTRAINT `bid_ibfk_2` FOREIGN KEY (`itemNumber`) REFERENCES `product` (`itemNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bid`
--

LOCK TABLES `bid` WRITE;
/*!40000 ALTER TABLE `bid` DISABLE KEYS */;
/*!40000 ALTER TABLE `bid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buyer`
--

DROP TABLE IF EXISTS `buyer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyer` (
  `email` varchar(40) NOT NULL,
  `username` varchar(40) NOT NULL,
  `pass` varchar(40) NOT NULL,
  PRIMARY KEY (`email`,`username`),
  CONSTRAINT `buyer_ibfk_1` FOREIGN KEY (`email`, `username`) REFERENCES `enduser` (`email`, `username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyer`
--

LOCK TABLES `buyer` WRITE;
/*!40000 ALTER TABLE `buyer` DISABLE KEYS */;
/*!40000 ALTER TABLE `buyer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerrep`
--

DROP TABLE IF EXISTS `customerrep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerrep` (
  `email` varchar(40) NOT NULL,
  `username` varchar(40) NOT NULL,
  `pass` varchar(40) NOT NULL,
  PRIMARY KEY (`email`,`username`),
  KEY `username` (`username`),
  CONSTRAINT `customerrep_ibfk_1` FOREIGN KEY (`username`) REFERENCES `useraccount` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerrep`
--

LOCK TABLES `customerrep` WRITE;
/*!40000 ALTER TABLE `customerrep` DISABLE KEYS */;
INSERT INTO `customerrep` VALUES ('rep115932@buyMe.com','rep115932','HW)<;46jE<E*g,#}'),('rep192052@root.com','rep192052','3Y38%L)F:d8dYp&4');
/*!40000 ALTER TABLE `customerrep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enduser`
--

DROP TABLE IF EXISTS `enduser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enduser` (
  `email` varchar(40) NOT NULL,
  `username` varchar(40) NOT NULL,
  PRIMARY KEY (`email`,`username`),
  KEY `username` (`username`),
  CONSTRAINT `enduser_ibfk_1` FOREIGN KEY (`username`) REFERENCES `useraccount` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enduser`
--

LOCK TABLES `enduser` WRITE;
/*!40000 ALTER TABLE `enduser` DISABLE KEYS */;
/*!40000 ALTER TABLE `enduser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `itemNumber` int NOT NULL AUTO_INCREMENT,
  `sellerAccount` varchar(40) DEFAULT NULL,
  `damageCondition` varchar(40) DEFAULT NULL,
  `color` varchar(40) DEFAULT NULL,
  `category` varchar(40) DEFAULT NULL,
  `productDescription` varchar(40) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `brand` varchar(40) DEFAULT NULL,
  `isSold` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`itemNumber`),
  KEY `sellerAccount` (`sellerAccount`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`sellerAccount`) REFERENCES `seller` (`email`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productalert`
--

DROP TABLE IF EXISTS `productalert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productalert` (
  `alertID` varchar(40) NOT NULL,
  `email` varchar(40) DEFAULT NULL,
  `brand` varchar(40) DEFAULT NULL,
  `size` varchar(40) DEFAULT NULL,
  `category` varchar(40) DEFAULT NULL,
  `color` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`alertID`),
  KEY `email` (`email`),
  CONSTRAINT `productalert_ibfk_1` FOREIGN KEY (`email`) REFERENCES `enduser` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productalert`
--

LOCK TABLES `productalert` WRITE;
/*!40000 ALTER TABLE `productalert` DISABLE KEYS */;
/*!40000 ALTER TABLE `productalert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchasehistory`
--

DROP TABLE IF EXISTS `purchasehistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchasehistory` (
  `email` varchar(40) NOT NULL,
  `username` varchar(40) NOT NULL,
  PRIMARY KEY (`email`,`username`),
  CONSTRAINT `purchasehistory_ibfk_1` FOREIGN KEY (`email`, `username`) REFERENCES `userhistory` (`email`, `username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchasehistory`
--

LOCK TABLES `purchasehistory` WRITE;
/*!40000 ALTER TABLE `purchasehistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchasehistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salehistory`
--

DROP TABLE IF EXISTS `salehistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salehistory` (
  `email` varchar(40) NOT NULL,
  `username` varchar(40) NOT NULL,
  PRIMARY KEY (`email`,`username`),
  CONSTRAINT `salehistory_ibfk_1` FOREIGN KEY (`email`, `username`) REFERENCES `userhistory` (`email`, `username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salehistory`
--

LOCK TABLES `salehistory` WRITE;
/*!40000 ALTER TABLE `salehistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `salehistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salesreport`
--

DROP TABLE IF EXISTS `salesreport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salesreport` (
  `email` varchar(40) NOT NULL,
  `username` varchar(40) NOT NULL,
  PRIMARY KEY (`email`,`username`),
  KEY `username` (`username`),
  CONSTRAINT `salesreport_ibfk_1` FOREIGN KEY (`email`) REFERENCES `administrator` (`email`),
  CONSTRAINT `salesreport_ibfk_2` FOREIGN KEY (`username`) REFERENCES `useraccount` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesreport`
--

LOCK TABLES `salesreport` WRITE;
/*!40000 ALTER TABLE `salesreport` DISABLE KEYS */;
/*!40000 ALTER TABLE `salesreport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller`
--

DROP TABLE IF EXISTS `seller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller` (
  `email` varchar(40) NOT NULL,
  `username` varchar(40) NOT NULL,
  `pass` varchar(40) NOT NULL,
  PRIMARY KEY (`email`,`username`),
  CONSTRAINT `seller_ibfk_1` FOREIGN KEY (`email`, `username`) REFERENCES `enduser` (`email`, `username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller`
--

LOCK TABLES `seller` WRITE;
/*!40000 ALTER TABLE `seller` DISABLE KEYS */;
/*!40000 ALTER TABLE `seller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type1`
--

DROP TABLE IF EXISTS `type1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type1` (
  `itemNumber` int NOT NULL AUTO_INCREMENT,
  `attributeName` varchar(40) NOT NULL,
  PRIMARY KEY (`itemNumber`,`attributeName`),
  CONSTRAINT `type1_ibfk_1` FOREIGN KEY (`itemNumber`) REFERENCES `product` (`itemNumber`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type1`
--

LOCK TABLES `type1` WRITE;
/*!40000 ALTER TABLE `type1` DISABLE KEYS */;
/*!40000 ALTER TABLE `type1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type2`
--

DROP TABLE IF EXISTS `type2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type2` (
  `itemNumber` int NOT NULL AUTO_INCREMENT,
  `attributeName` varchar(40) NOT NULL,
  PRIMARY KEY (`itemNumber`,`attributeName`),
  CONSTRAINT `type2_ibfk_1` FOREIGN KEY (`itemNumber`) REFERENCES `product` (`itemNumber`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type2`
--

LOCK TABLES `type2` WRITE;
/*!40000 ALTER TABLE `type2` DISABLE KEYS */;
/*!40000 ALTER TABLE `type2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type3`
--

DROP TABLE IF EXISTS `type3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type3` (
  `itemNumber` int NOT NULL AUTO_INCREMENT,
  `attributeName` varchar(40) NOT NULL,
  PRIMARY KEY (`itemNumber`,`attributeName`),
  CONSTRAINT `type3_ibfk_1` FOREIGN KEY (`itemNumber`) REFERENCES `product` (`itemNumber`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type3`
--

LOCK TABLES `type3` WRITE;
/*!40000 ALTER TABLE `type3` DISABLE KEYS */;
/*!40000 ALTER TABLE `type3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `useraccount`
--

DROP TABLE IF EXISTS `useraccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `useraccount` (
  `email` varchar(40) DEFAULT NULL,
  `username` varchar(40) NOT NULL,
  `pass` varchar(40) NOT NULL,
  `phone` varchar(13) DEFAULT NULL,
  `addressLine1` varchar(150) DEFAULT NULL,
  `addressLine2` varchar(150) DEFAULT NULL,
  `county` varchar(40) DEFAULT NULL,
  `state` char(2) DEFAULT NULL,
  `zipCode` char(5) DEFAULT NULL,
  `firstName` varchar(40) DEFAULT NULL,
  `middleName` varchar(40) DEFAULT NULL,
  `lastName` varchar(40) DEFAULT NULL,
  `age` int DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `isActive` tinyint(1) DEFAULT NULL,
  `lastSeen` datetime DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `useraccount`
--

LOCK TABLES `useraccount` WRITE;
/*!40000 ALTER TABLE `useraccount` DISABLE KEYS */;
INSERT INTO `useraccount` VALUES (NULL,'rep115932','HW)<;46jE<E*g,#}',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(NULL,'rep192052','3Y38%L)F:d8dYp&4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(NULL,'root','UN5AW!]x9K{[bP',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `useraccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userhistory`
--

DROP TABLE IF EXISTS `userhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userhistory` (
  `email` varchar(40) NOT NULL,
  `username` varchar(40) NOT NULL,
  PRIMARY KEY (`email`,`username`),
  CONSTRAINT `userhistory_ibfk_1` FOREIGN KEY (`email`, `username`) REFERENCES `enduser` (`email`, `username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userhistory`
--

LOCK TABLES `userhistory` WRITE;
/*!40000 ALTER TABLE `userhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `userhistory` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-25 23:45:05
