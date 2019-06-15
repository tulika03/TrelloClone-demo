CREATE DATABASE  IF NOT EXISTS `trellodb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `trellodb`;
-- MySQL dump 10.13  Distrib 8.0.12, for Win64 (x86_64)
--
-- Host: localhost    Database: trellodb
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `board_master`
--

DROP TABLE IF EXISTS `board_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `board_master` (
  `board_id` int(11) NOT NULL AUTO_INCREMENT,
  `board_number` varchar(100) NOT NULL,
  `board_title` varchar(100) NOT NULL,
  `board_desc` varchar(1000) DEFAULT NULL,
  `createdOn` datetime NOT NULL,
  `boardImage` varchar(500) DEFAULT NULL,
  `createdBy` int(11) NOT NULL,
  `board_team_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`board_id`),
  KEY `createdBy` (`createdBy`),
  KEY `board_team_id` (`board_team_id`),
  CONSTRAINT `board_master_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `user_master` (`user_id`),
  CONSTRAINT `board_team_id` FOREIGN KEY (`board_team_id`) REFERENCES `board_master` (`board_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_master`
--

LOCK TABLES `board_master` WRITE;
/*!40000 ALTER TABLE `board_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `board_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_type_master`
--

DROP TABLE IF EXISTS `board_type_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `board_type_master` (
  `board_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `board_type_name` varchar(100) NOT NULL,
  PRIMARY KEY (`board_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_type_master`
--

LOCK TABLES `board_type_master` WRITE;
/*!40000 ALTER TABLE `board_type_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `board_type_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card_attachment`
--

DROP TABLE IF EXISTS `card_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `card_attachment` (
  `attachment_id` int(11) NOT NULL AUTO_INCREMENT,
  `attachemnt_link` varchar(200) NOT NULL,
  `a_card_id` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime DEFAULT NULL,
  PRIMARY KEY (`attachment_id`),
  KEY `a_card_id` (`a_card_id`),
  KEY `createdBy` (`createdBy`),
  CONSTRAINT `card_attachment_ibfk_1` FOREIGN KEY (`a_card_id`) REFERENCES `card_master` (`card_id`),
  CONSTRAINT `card_attachment_ibfk_2` FOREIGN KEY (`createdBy`) REFERENCES `user_master` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card_attachment`
--

LOCK TABLES `card_attachment` WRITE;
/*!40000 ALTER TABLE `card_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `card_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card_comments`
--

DROP TABLE IF EXISTS `card_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `card_comments` (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_desc` varchar(2000) NOT NULL,
  `c_card_id` int(11) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `createdOn` datetime DEFAULT NULL,
  `memberCardId` int(11) NOT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `c_card_id` (`c_card_id`),
  KEY `createdBy` (`createdBy`),
  KEY `memberCardId` (`memberCardId`),
  CONSTRAINT `card_comments_ibfk_1` FOREIGN KEY (`c_card_id`) REFERENCES `card_master` (`card_id`),
  CONSTRAINT `card_comments_ibfk_2` FOREIGN KEY (`createdBy`) REFERENCES `user_master` (`user_id`),
  CONSTRAINT `card_comments_ibfk_3` FOREIGN KEY (`memberCardId`) REFERENCES `member_card_bridge` (`member_card_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card_comments`
--

LOCK TABLES `card_comments` WRITE;
/*!40000 ALTER TABLE `card_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `card_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card_master`
--

DROP TABLE IF EXISTS `card_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `card_master` (
  `card_id` int(11) NOT NULL AUTO_INCREMENT,
  `card_title` varchar(100) NOT NULL,
  `card_desc` varchar(1000) DEFAULT NULL,
  `createdOn` datetime NOT NULL,
  `createdBy` int(11) NOT NULL,
  `card_labels` varchar(1000) DEFAULT NULL,
  `card_due_date` date DEFAULT NULL,
  `card_due_time` time DEFAULT NULL,
  `car_set_reminder` varchar(200) DEFAULT NULL,
  `card_list_id` int(11) NOT NULL,
  `card_board_id` int(11) NOT NULL,
  PRIMARY KEY (`card_id`),
  KEY `createdBy` (`createdBy`),
  KEY `card_list_id` (`card_list_id`),
  KEY `card_board_id` (`card_board_id`),
  CONSTRAINT `card_master_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `user_master` (`user_id`),
  CONSTRAINT `card_master_ibfk_2` FOREIGN KEY (`card_list_id`) REFERENCES `list_master` (`list_id`),
  CONSTRAINT `card_master_ibfk_3` FOREIGN KEY (`card_board_id`) REFERENCES `board_master` (`board_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card_master`
--

LOCK TABLES `card_master` WRITE;
/*!40000 ALTER TABLE `card_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `card_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `list_master`
--

DROP TABLE IF EXISTS `list_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `list_master` (
  `list_id` int(11) NOT NULL AUTO_INCREMENT,
  `list_number` varchar(100) NOT NULL,
  `list_name` varchar(100) NOT NULL,
  `createdOn` datetime NOT NULL,
  `createdBy` int(11) NOT NULL,
  `dueDate` date DEFAULT NULL,
  `list_board_id` int(11) NOT NULL,
  `dueTime` time DEFAULT NULL,
  PRIMARY KEY (`list_id`),
  KEY `createdBy` (`createdBy`),
  KEY `list_board_id` (`list_board_id`),
  CONSTRAINT `list_master_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `user_master` (`user_id`),
  CONSTRAINT `list_master_ibfk_2` FOREIGN KEY (`list_board_id`) REFERENCES `board_master` (`board_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `list_master`
--

LOCK TABLES `list_master` WRITE;
/*!40000 ALTER TABLE `list_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `list_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_board_bridge`
--

DROP TABLE IF EXISTS `member_board_bridge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `member_board_bridge` (
  `member_board_id` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) NOT NULL,
  `createdOn` int(11) NOT NULL,
  `mb_member_id` int(11) NOT NULL,
  `mb_board_id` int(11) NOT NULL,
  PRIMARY KEY (`member_board_id`),
  KEY `createdBy` (`createdBy`),
  KEY `mb_member_id` (`mb_member_id`),
  KEY `mb_board_id` (`mb_board_id`),
  CONSTRAINT `member_board_bridge_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `user_master` (`user_id`),
  CONSTRAINT `member_board_bridge_ibfk_2` FOREIGN KEY (`mb_member_id`) REFERENCES `member_master` (`member_id`),
  CONSTRAINT `member_board_bridge_ibfk_3` FOREIGN KEY (`mb_board_id`) REFERENCES `board_master` (`board_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_board_bridge`
--

LOCK TABLES `member_board_bridge` WRITE;
/*!40000 ALTER TABLE `member_board_bridge` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_board_bridge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_card_bridge`
--

DROP TABLE IF EXISTS `member_card_bridge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `member_card_bridge` (
  `member_card_id` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) NOT NULL,
  `createdOn` int(11) NOT NULL,
  `cm_member_id` int(11) NOT NULL,
  `cm_card_id` int(11) NOT NULL,
  PRIMARY KEY (`member_card_id`),
  KEY `createdBy` (`createdBy`),
  KEY `cm_member_id` (`cm_member_id`),
  KEY `cm_card_id` (`cm_card_id`),
  CONSTRAINT `member_card_bridge_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `user_master` (`user_id`),
  CONSTRAINT `member_card_bridge_ibfk_2` FOREIGN KEY (`cm_member_id`) REFERENCES `member_master` (`member_id`),
  CONSTRAINT `member_card_bridge_ibfk_3` FOREIGN KEY (`cm_card_id`) REFERENCES `card_master` (`card_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_card_bridge`
--

LOCK TABLES `member_card_bridge` WRITE;
/*!40000 ALTER TABLE `member_card_bridge` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_card_bridge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_master`
--

DROP TABLE IF EXISTS `member_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `member_master` (
  `member_id` int(11) NOT NULL AUTO_INCREMENT,
  `member_email` varchar(100) DEFAULT NULL,
  `addedOn` datetime NOT NULL,
  `addedBy` int(11) NOT NULL,
  PRIMARY KEY (`member_id`),
  KEY `addedBy` (`addedBy`),
  CONSTRAINT `member_master_ibfk_1` FOREIGN KEY (`addedBy`) REFERENCES `user_master` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_master`
--

LOCK TABLES `member_master` WRITE;
/*!40000 ALTER TABLE `member_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_team_bridge`
--

DROP TABLE IF EXISTS `member_team_bridge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `member_team_bridge` (
  `member_team_id` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) NOT NULL,
  `createdOn` int(11) NOT NULL,
  `mt_member_id` int(11) NOT NULL,
  `mt_team_id` int(11) NOT NULL,
  PRIMARY KEY (`member_team_id`),
  KEY `createdBy` (`createdBy`),
  KEY `mt_member_id` (`mt_member_id`),
  KEY `mt_team_id` (`mt_team_id`),
  CONSTRAINT `member_team_bridge_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `user_master` (`user_id`),
  CONSTRAINT `member_team_bridge_ibfk_2` FOREIGN KEY (`mt_member_id`) REFERENCES `member_master` (`member_id`),
  CONSTRAINT `member_team_bridge_ibfk_3` FOREIGN KEY (`mt_team_id`) REFERENCES `team_master` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_team_bridge`
--

LOCK TABLES `member_team_bridge` WRITE;
/*!40000 ALTER TABLE `member_team_bridge` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_team_bridge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_master`
--

DROP TABLE IF EXISTS `team_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `team_master` (
  `team_id` int(11) NOT NULL AUTO_INCREMENT,
  `team_name` varchar(100) NOT NULL,
  `team_desc` varchar(1000) DEFAULT NULL,
  `team_image` varchar(1000) DEFAULT NULL,
  `team_mode` varchar(30) NOT NULL,
  `createdOn` datetime NOT NULL,
  `createdBy` int(11) NOT NULL,
  PRIMARY KEY (`team_id`),
  KEY `createdBy` (`createdBy`),
  CONSTRAINT `team_master_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `user_master` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_master`
--

LOCK TABLES `team_master` WRITE;
/*!40000 ALTER TABLE `team_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `team_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_master`
--

DROP TABLE IF EXISTS `user_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user_master` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_master`
--

LOCK TABLES `user_master` WRITE;
/*!40000 ALTER TABLE `user_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'trellodb'
--

--
-- Dumping routines for database 'trellodb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-09 21:45:04
