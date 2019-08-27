CREATE DATABASE  IF NOT EXISTS `trellodb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `trellodb`;
-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
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
-- Table structure for table `board_images_options`
--

DROP TABLE IF EXISTS `board_images_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `board_images_options` (
  `image_id` int(11) NOT NULL AUTO_INCREMENT,
  `image_name` varchar(70) DEFAULT NULL,
  `image_type` varchar(45) NOT NULL,
  PRIMARY KEY (`image_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_images_options`
--

LOCK TABLES `board_images_options` WRITE;
/*!40000 ALTER TABLE `board_images_options` DISABLE KEYS */;
INSERT INTO `board_images_options` VALUES (1,'chimney1.png','admin image'),(2,'w2.jpg','admin image'),(3,'bg_image1.jpg','admin image'),(4,'201712036_Assignment1 (1).pdf','admin image');
/*!40000 ALTER TABLE `board_images_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_master`
--

DROP TABLE IF EXISTS `board_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `board_master` (
  `board_id` int(11) NOT NULL AUTO_INCREMENT,
  `board_title` varchar(100) NOT NULL,
  `board_desc` varchar(500) NOT NULL,
  `createdOn` bigint(20) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `boardImage` int(11) NOT NULL,
  `board_type_id` int(11) NOT NULL,
  `updatedOn` bigint(20) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`board_id`),
  KEY `createdBy` (`createdBy`),
  KEY `boardImage` (`boardImage`),
  KEY `board_type_id` (`board_type_id`),
  CONSTRAINT `board_master_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `member_master` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `board_master_ibfk_2` FOREIGN KEY (`boardImage`) REFERENCES `board_images_options` (`image_id`) ON UPDATE CASCADE,
  CONSTRAINT `board_master_ibfk_3` FOREIGN KEY (`board_type_id`) REFERENCES `board_type_master` (`board_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_master`
--

LOCK TABLES `board_master` WRITE;
/*!40000 ALTER TABLE `board_master` DISABLE KEYS */;
INSERT INTO `board_master` VALUES (1,'Test board 1','This board has been created for test purpose',1565680416000,1,4,2,NULL,NULL),(6,'board test 2','test purpose',1565681871000,1,3,1,NULL,NULL);
/*!40000 ALTER TABLE `board_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_member_table`
--

DROP TABLE IF EXISTS `board_member_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `board_member_table` (
  `member_board_id` int(11) NOT NULL AUTO_INCREMENT,
  `createdBy` int(11) NOT NULL,
  `createdOn` bigint(20) NOT NULL,
  `member_id` int(11) NOT NULL,
  `board_id` int(11) NOT NULL,
  PRIMARY KEY (`member_board_id`),
  KEY `createdBy` (`createdBy`),
  KEY `member_id` (`member_id`),
  KEY `board_id` (`board_id`),
  CONSTRAINT `board_member_table_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `member_master` (`member_id`),
  CONSTRAINT `board_member_table_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `member_master` (`member_id`),
  CONSTRAINT `board_member_table_ibfk_3` FOREIGN KEY (`board_id`) REFERENCES `board_master` (`board_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_member_table`
--

LOCK TABLES `board_member_table` WRITE;
/*!40000 ALTER TABLE `board_member_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `board_member_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board_type_master`
--

DROP TABLE IF EXISTS `board_type_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `board_type_master` (
  `board_type_id` int(11) NOT NULL,
  `board_type_name` varchar(100) NOT NULL,
  PRIMARY KEY (`board_type_id`),
  UNIQUE KEY `board_type_id_UNIQUE` (`board_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board_type_master`
--

LOCK TABLES `board_type_master` WRITE;
/*!40000 ALTER TABLE `board_type_master` DISABLE KEYS */;
INSERT INTO `board_type_master` VALUES (1,'Personal'),(2,'Team');
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
  CONSTRAINT `card_attachment_ibfk_1` FOREIGN KEY (`a_card_id`) REFERENCES `card_master` (`card_id`) ON DELETE CASCADE ON UPDATE CASCADE,
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
  KEY `memberCardId` (`memberCardId`),
  KEY `card_comments_ibfk_2_idx` (`createdBy`),
  CONSTRAINT `card_comments_ibfk_1` FOREIGN KEY (`c_card_id`) REFERENCES `card_master` (`card_id`),
  CONSTRAINT `card_comments_ibfk_2` FOREIGN KEY (`createdBy`) REFERENCES `member_master` (`member_id`),
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
  PRIMARY KEY (`card_id`),
  KEY `card_list_id` (`card_list_id`),
  KEY `card_master_ibfk_1_idx` (`createdBy`),
  CONSTRAINT `card_master_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `member_master` (`member_id`),
  CONSTRAINT `card_master_ibfk_2` FOREIGN KEY (`card_list_id`) REFERENCES `list_master` (`list_id`) ON DELETE CASCADE ON UPDATE CASCADE
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
-- Table structure for table `email_notification_log`
--

DROP TABLE IF EXISTS `email_notification_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `email_notification_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createdOn` datetime NOT NULL,
  `createdBy` int(11) NOT NULL,
  `sentTo` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `createdBy` (`createdBy`),
  CONSTRAINT `email_notification_log_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `user_master` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_notification_log`
--

LOCK TABLES `email_notification_log` WRITE;
/*!40000 ALTER TABLE `email_notification_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_notification_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `list_master`
--

DROP TABLE IF EXISTS `list_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `list_master` (
  `list_id` int(11) NOT NULL AUTO_INCREMENT,
  `list_name` varchar(100) NOT NULL,
  `createdOn` bigint(20) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `list_board_id` int(11) NOT NULL,
  `archive_value` tinyint(4) NOT NULL DEFAULT '0',
  `list_position` double NOT NULL,
  PRIMARY KEY (`list_id`),
  KEY `createdBy_idx` (`createdBy`),
  KEY `list_master_ibfk_2_idx` (`list_board_id`),
  CONSTRAINT `createdBy` FOREIGN KEY (`createdBy`) REFERENCES `member_master` (`member_id`),
  CONSTRAINT `list_master_ibfk_2` FOREIGN KEY (`list_board_id`) REFERENCES `board_master` (`board_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `list_master`
--

LOCK TABLES `list_master` WRITE;
/*!40000 ALTER TABLE `list_master` DISABLE KEYS */;
INSERT INTO `list_master` VALUES (3,'checklist for test data',1565958879000,1,1,0,16384),(4,'checklist 2',1565958879000,1,1,0,32768),(5,'view queries',1565959063000,1,1,0,49152),(6,'add new wish list',1565959084000,1,1,0,65536),(7,'Travel destination list',1565959112000,1,1,0,81920),(8,'Travel destination list',1565959112000,1,1,0,81920),(9,'Cuisines list',1565959145000,1,1,0,98304),(10,'carslist',1565959160000,1,1,0,114688),(11,'bikes list',1565959172000,1,1,0,131072),(12,'tasks completed list',1565959184000,1,1,0,147456),(13,'tasks pending list',1565959194000,1,1,0,163840),(14,'tasks to be added list',1565959200000,1,1,0,180224),(15,'tasks removed list',1565959209000,1,1,0,196608),(16,'holidays list',1565959220000,1,1,0,212992),(17,'RH list',1565959230000,1,1,0,229376),(18,'board checklist 1',1565959297000,1,6,0,16384),(19,'Foof check',1565959338000,1,6,0,32768),(20,'holidays check',1565959347000,1,6,0,49152),(21,'travel check',1565959354000,1,6,0,65536),(22,'rest check',1565959361000,1,6,0,81920),(23,'cuisines check',1565959367000,1,6,0,98304),(24,'decorations check',1565959378000,1,6,0,114688);
/*!40000 ALTER TABLE `list_master` ENABLE KEYS */;
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
  `addedOn` bigint(20) NOT NULL,
  `member_email` varchar(100) DEFAULT NULL,
  `member_fullname` varchar(100) DEFAULT NULL,
  `contact` bigint(20) DEFAULT NULL,
  `phoneCode` varchar(6) DEFAULT NULL,
  `verification_key` varchar(45) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `confirmed` tinyint(1) NOT NULL,
  `member_type` varchar(45) NOT NULL,
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `member_fullname_UNIQUE` (`member_fullname`),
  UNIQUE KEY `member_email_UNIQUE` (`member_email`),
  UNIQUE KEY `contact_UNIQUE` (`contact`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_master`
--

LOCK TABLES `member_master` WRITE;
/*!40000 ALTER TABLE `member_master` DISABLE KEYS */;
INSERT INTO `member_master` VALUES (1,1563535150,'tulika312@gmail.com','Tulika P',9787656765,'+91','962265','$2b$10$7CK.axb52uMp9q09LACuT.qbHPYFoMYbPMWScyKsD5d9i2aJUDA8K',1,'normal'),(2,1563535187,'anita2@gmail.com','anita@gmail.com',9007654576,'+91',NULL,'$2b$10$h18VHAN6sfyxHH77pMtMF.4TPs1xUyGr3eFhR6nHQ40Za97QGycHq',1,'normal');
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
  KEY `mt_member_id` (`mt_member_id`),
  KEY `mt_team_id` (`mt_team_id`),
  KEY `member_team_bridge_ibfk_1_idx` (`createdBy`),
  CONSTRAINT `member_team_bridge_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `member_master` (`member_id`),
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
  `createdOn` bigint(20) NOT NULL,
  `createdBy` int(11) NOT NULL,
  `team_mode_id` int(11) NOT NULL,
  PRIMARY KEY (`team_id`),
  KEY `team_mode_id_idx` (`team_mode_id`),
  KEY `team_master_ibfk_1_idx` (`createdBy`),
  CONSTRAINT `team_master_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `member_master` (`member_id`),
  CONSTRAINT `team_mode_id` FOREIGN KEY (`team_mode_id`) REFERENCES `team_mode_master` (`team_mode_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_master`
--

LOCK TABLES `team_master` WRITE;
/*!40000 ALTER TABLE `team_master` DISABLE KEYS */;
INSERT INTO `team_master` VALUES (1,'team 1','team 1 desc',1565944736000,1,2);
/*!40000 ALTER TABLE `team_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_mode_master`
--

DROP TABLE IF EXISTS `team_mode_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `team_mode_master` (
  `team_mode_id` int(11) NOT NULL,
  `team_mode_type` varchar(20) NOT NULL,
  PRIMARY KEY (`team_mode_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_mode_master`
--

LOCK TABLES `team_mode_master` WRITE;
/*!40000 ALTER TABLE `team_mode_master` DISABLE KEYS */;
INSERT INTO `team_mode_master` VALUES (1,'private'),(2,'public'),(3,'team');
/*!40000 ALTER TABLE `team_mode_master` ENABLE KEYS */;
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
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(500) NOT NULL,
  `contact` varchar(10) NOT NULL,
  `phoneCode` varchar(5) NOT NULL,
  `user_address` varchar(300) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `verification_key` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_email_UNIQUE` (`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_master`
--

LOCK TABLES `user_master` WRITE;
/*!40000 ALTER TABLE `user_master` DISABLE KEYS */;
INSERT INTO `user_master` VALUES (3,'Anita','anita@gmail.com',NULL,'$2b$10$E2FkL6m/OT5jjFJhW5zOg.Ngov2vde4xAc2YlIpHZQbKuCfqs6F4G','9654567543','+91','okhla','New Delhi','Delhi','India','705383'),(4,'Sunita','sunita@gmail.com',NULL,'$2b$10$J1EIZemRgkcRf9o3LIG4rOF.vZodWtdd/XK05FO4URPXI5jjCJ/Lq','9654557543','+91','okhla','New Delhi','Delhi','India','356622'),(5,'Tulika','tulika312@gmail.com',NULL,'$2b$10$pE.C8fXRkwbQ/FprxwW0p.CJuZ3/eX4ee7bt7a1HKkVQ1RpzqSXvq','8897678765','+91','subroto park','new delhi','Delhi','India','777419');
/*!40000 ALTER TABLE `user_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'trellodb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-19 15:59:02
