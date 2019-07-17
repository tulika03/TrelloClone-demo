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
-- Dumping data for table `board_master`
--

LOCK TABLES `board_master` WRITE;
/*!40000 ALTER TABLE `board_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `board_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `board_type_master`
--

LOCK TABLES `board_type_master` WRITE;
/*!40000 ALTER TABLE `board_type_master` DISABLE KEYS */;
INSERT INTO `board_type_master` VALUES (1,'Personal'),(2,'Team');
/*!40000 ALTER TABLE `board_type_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `card_attachment`
--

LOCK TABLES `card_attachment` WRITE;
/*!40000 ALTER TABLE `card_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `card_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `card_comments`
--

LOCK TABLES `card_comments` WRITE;
/*!40000 ALTER TABLE `card_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `card_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `card_master`
--

LOCK TABLES `card_master` WRITE;
/*!40000 ALTER TABLE `card_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `card_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `email_notification_log`
--

LOCK TABLES `email_notification_log` WRITE;
/*!40000 ALTER TABLE `email_notification_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_notification_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `list_master`
--

LOCK TABLES `list_master` WRITE;
/*!40000 ALTER TABLE `list_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `list_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `member_board_bridge`
--

LOCK TABLES `member_board_bridge` WRITE;
/*!40000 ALTER TABLE `member_board_bridge` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_board_bridge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `member_card_bridge`
--

LOCK TABLES `member_card_bridge` WRITE;
/*!40000 ALTER TABLE `member_card_bridge` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_card_bridge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `member_master`
--

LOCK TABLES `member_master` WRITE;
/*!40000 ALTER TABLE `member_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `member_team_bridge`
--

LOCK TABLES `member_team_bridge` WRITE;
/*!40000 ALTER TABLE `member_team_bridge` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_team_bridge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `team_master`
--

LOCK TABLES `team_master` WRITE;
/*!40000 ALTER TABLE `team_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `team_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `team_mode_master`
--

LOCK TABLES `team_mode_master` WRITE;
/*!40000 ALTER TABLE `team_mode_master` DISABLE KEYS */;
INSERT INTO `team_mode_master` VALUES (1,'private'),(2,'public'),(3,'team');
/*!40000 ALTER TABLE `team_mode_master` ENABLE KEYS */;
UNLOCK TABLES;

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

-- Dump completed on 2019-07-17 13:55:24
