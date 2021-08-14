CREATE DATABASE  IF NOT EXISTS `buyMe` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `buyMe`;
-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: buyMe
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
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alerts` (
  `messageId` int NOT NULL AUTO_INCREMENT,
  `userAcc` varchar(40) NOT NULL,
  `message` varchar(250) NOT NULL,
  `seen` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`messageId`),
  KEY `userAcc` (`userAcc`),
  CONSTRAINT `alerts_ibfk_1` FOREIGN KEY (`userAcc`) REFERENCES `useraccount` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alertslist`
--

DROP TABLE IF EXISTS `alertslist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alertslist` (
  `userAcc` varchar(40) NOT NULL,
  `category` varchar(40) NOT NULL,
  `brand` varchar(25) NOT NULL,
  `damageCondition` varchar(40) NOT NULL,
  `color` varchar(20) NOT NULL,
  `maxPrice` decimal(10,2) NOT NULL,
  PRIMARY KEY (`userAcc`,`category`,`brand`,`damageCondition`,`color`),
  CONSTRAINT `alertslist_ibfk_1` FOREIGN KEY (`userAcc`) REFERENCES `useraccount` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alertslist`
--

LOCK TABLES `alertslist` WRITE;
/*!40000 ALTER TABLE `alertslist` DISABLE KEYS */;
/*!40000 ALTER TABLE `alertslist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autobidder`
--

DROP TABLE IF EXISTS `autobidder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autobidder` (
  `userAcc` varchar(40) NOT NULL,
  `productId` int NOT NULL,
  `maxPrice` decimal(10,2) NOT NULL,
  PRIMARY KEY (`userAcc`,`productId`),
  KEY `productId` (`productId`),
  CONSTRAINT `autobidder_ibfk_1` FOREIGN KEY (`userAcc`) REFERENCES `useraccount` (`username`) ON DELETE CASCADE,
  CONSTRAINT `autobidder_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE
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
  `productId` int NOT NULL,
  `buyerAccount` varchar(40) DEFAULT NULL,
  `currentBid` decimal(10,2) NOT NULL,
  `datePlaced` datetime DEFAULT NULL,
  PRIMARY KEY (`productId`,`currentBid`),
  KEY `buyerAccount` (`buyerAccount`),
  CONSTRAINT `bid_ibfk_1` FOREIGN KEY (`buyerAccount`) REFERENCES `useraccount` (`username`) ON DELETE CASCADE,
  CONSTRAINT `bid_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE
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
-- Table structure for table `bidhistory`
--

DROP TABLE IF EXISTS `bidhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bidhistory` (
  `productId` int NOT NULL,
  `buyerAccount` varchar(40) DEFAULT NULL,
  `bidPrice` decimal(10,2) NOT NULL,
  `bidDate` datetime DEFAULT NULL,
  PRIMARY KEY (`bidPrice`,`productId`),
  KEY `productId` (`productId`),
  CONSTRAINT `bidhistory_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`productId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bidhistory`
--

LOCK TABLES `bidhistory` WRITE;
/*!40000 ALTER TABLE `bidhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `bidhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buyinghistory`
--

DROP TABLE IF EXISTS `buyinghistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyinghistory` (
  `productId` int NOT NULL,
  `buyerAccount` varchar(40) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `purchaseDate` datetime DEFAULT NULL,
  PRIMARY KEY (`productId`),
  KEY `buyerAccount` (`buyerAccount`),
  CONSTRAINT `buyinghistory_ibfk_1` FOREIGN KEY (`buyerAccount`) REFERENCES `useraccount` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyinghistory`
--

LOCK TABLES `buyinghistory` WRITE;
/*!40000 ALTER TABLE `buyinghistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `buyinghistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `productId` int NOT NULL AUTO_INCREMENT,
  `category` varchar(40) NOT NULL,
  `brand` varchar(40) DEFAULT NULL,
  `damageCondition` enum('Poor','Fair','Like New','Original Condition','NA') NOT NULL,
  `color` varchar(40) DEFAULT NULL,
  `sellerAccount` varchar(40) NOT NULL,
  `reservePrice` decimal(10,2) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `isSold` tinyint(1) DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  PRIMARY KEY (`productId`,`sellerAccount`)
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
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `questionId` int NOT NULL AUTO_INCREMENT,
  `userAcc` varchar(40) DEFAULT NULL,
  `question` varchar(250) NOT NULL,
  `answer` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`questionId`),
  KEY `userAcc` (`userAcc`),
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`userAcc`) REFERENCES `useraccount` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sellinghistory`
--

DROP TABLE IF EXISTS `sellinghistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sellinghistory` (
  `productId` int NOT NULL,
  `sellerAccount` varchar(40) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `saleDate` datetime DEFAULT NULL,
  PRIMARY KEY (`productId`),
  KEY `sellerAccount` (`sellerAccount`),
  CONSTRAINT `sellinghistory_ibfk_1` FOREIGN KEY (`sellerAccount`) REFERENCES `useraccount` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sellinghistory`
--

LOCK TABLES `sellinghistory` WRITE;
/*!40000 ALTER TABLE `sellinghistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `sellinghistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `useraccount`
--

DROP TABLE IF EXISTS `useraccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `useraccount` (
  `username` varchar(40) NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `email` varchar(100) NOT NULL,
  `firstName` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `lastName` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `address` varchar(100) NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  `accessLevel` enum('END_USER','CUSTOMER_REP','ADMIN') NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `useraccount`
--

LOCK TABLES `useraccount` WRITE;
/*!40000 ALTER TABLE `useraccount` DISABLE KEYS */;
INSERT INTO `useraccount` VALUES ('rep115932','HW)<;46jE<E*g,#','rep115932@buyme.com','John','Doe','100 Ryders Ln, Milltown, NJ 08850',1,'CUSTOMER_REP'),('root','UN5AW!]x9K{[bP','admin@buyme.com','Admin','Istrator','57 US Highway 1, New Brunswick, NJ 08901',1,'ADMIN');
/*!40000 ALTER TABLE `useraccount` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-12 19:39:33
