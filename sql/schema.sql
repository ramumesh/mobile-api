CREATE DATABASE  IF NOT EXISTS `enviamajor_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `enviamajor_db`;
-- MySQL dump 10.13  Distrib 8.0.17, for macos10.14 (x86_64)
--
-- Host: localhost    Database: enviamajor_db
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Table structure for table `em_event_master`
--

DROP TABLE IF EXISTS `em_event_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_event_master` (
  `em_event_id` int(11) NOT NULL,
  `em_event_name` varchar(45) DEFAULT NULL,
  `em_event_desc` text,
  PRIMARY KEY (`em_event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `em_login`
--

DROP TABLE IF EXISTS `em_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_login` (
  `id` int(11) NOT NULL,
  `em_customer_id` int(11) NOT NULL,
  `em_phone_number` varchar(12) NOT NULL,
  `em_pin` varchar(20) DEFAULT NULL,
  `em_invite_url` text,
  `em_active` int(1) DEFAULT NULL,
  `em_is_first_time` int(1) DEFAULT NULL,
  `create_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `em_customer_id_idx` (`em_customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `em_login_log`
--

DROP TABLE IF EXISTS `em_login_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_login_log` (
  `id` int(11) NOT NULL,
  `em_customer_id` int(11) DEFAULT NULL,
  `create_ts` datetime DEFAULT NULL,
  `location` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `em_profile`
--

DROP TABLE IF EXISTS `em_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_profile` (
  `em_customer_id` int(11) NOT NULL,
  `phone_number` varchar(12) NOT NULL,
  `first_name` varchar(25) NOT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `address` text,
  `city` varchar(20) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  `create_ts` datetime DEFAULT CURRENT_TIMESTAMP,
  `modify_ts` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`em_customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `em_profile_history`
--

DROP TABLE IF EXISTS `em_profile_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_profile_history` (
  `id` int(11) NOT NULL,
  `em_customer_id` int(11) NOT NULL,
  `phone_number` varchar(12) NOT NULL,
  `first_name` varchar(25) NOT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `address` text,
  `city` varchar(20) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  `create_ts` datetime DEFAULT CURRENT_TIMESTAMP,
  `modify_ts` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `em_vendor_link`
--

DROP TABLE IF EXISTS `em_vendor_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `em_vendor_link` (
  `em_customer_id` int(11) NOT NULL,
  `vendor_customer_id` int(11) NOT NULL,
  `vendor_Id` int(11) NOT NULL,
  UNIQUE KEY `idem_vendor_link_UNIQUE` (`em_customer_id`),
  UNIQUE KEY `vendor_customer_id_UNIQUE` (`vendor_customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vendor_enable_config`
--

DROP TABLE IF EXISTS `vendor_enable_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor_enable_config` (
  `vendor_id` int(11) NOT NULL,
  `transaction_type_id` varchar(45) DEFAULT NULL,
  `enable_mapping` int(1) DEFAULT NULL,
  `is_active` int(1) DEFAULT NULL,
  `create_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vendor_master`
--

DROP TABLE IF EXISTS `vendor_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor_master` (
  `vendor_id` int(11) NOT NULL,
  `vendor_name` varchar(20) NOT NULL,
  `vendor_description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-07 20:12:02
