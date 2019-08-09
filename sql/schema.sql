CREATE DATABASE  IF NOT EXISTS `enviamajor_db`; 
USE `enviamajor_db`;

--
-- Table structure for table `em_event_master`
--

DROP TABLE IF EXISTS `em_event_master`;
CREATE TABLE `em_event_master` (
  `em_event_id` int(11) NOT NULL,
  `em_event_name` varchar(45) DEFAULT NULL,
  `em_event_desc` text,
  PRIMARY KEY (`em_event_id`)
) ENGINE=InnoDB;

--
-- Table structure for table `em_login`
--

DROP TABLE IF EXISTS `em_login`;

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
) ENGINE=InnoDB; 


--
-- Table structure for table `em_login_log`
--

DROP TABLE IF EXISTS `em_login_log`;

CREATE TABLE `em_login_log` (
  `id` int(11) NOT NULL,
  `em_customer_id` int(11) DEFAULT NULL,
  `create_ts` datetime DEFAULT NULL,
  `location` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB ;


--
-- Table structure for table `em_profile`
--

DROP TABLE IF EXISTS `em_profile`;

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
) ENGINE=InnoDB ;


--
-- Table structure for table `em_profile_history`
--

DROP TABLE IF EXISTS `em_profile_history`;

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
) ENGINE=InnoDB;


--
-- Table structure for table `em_vendor_link`
--

DROP TABLE IF EXISTS `em_vendor_link`;

CREATE TABLE `em_vendor_link` (
  `em_customer_id` int(11) NOT NULL,
  `vendor_customer_id` int(11) NOT NULL,
  `vendor_Id` int(11) NOT NULL,
  UNIQUE KEY `idem_vendor_link_UNIQUE` (`em_customer_id`),
  UNIQUE KEY `vendor_customer_id_UNIQUE` (`vendor_customer_id`)
) ENGINE=InnoDB;


--
-- Table structure for table `vendor_enable_config`
--

DROP TABLE IF EXISTS `vendor_enable_config`;

CREATE TABLE `vendor_enable_config` (
  `vendor_id` int(11) NOT NULL,
  `transaction_type_id` varchar(45) DEFAULT NULL,
  `enable_mapping` int(1) DEFAULT NULL,
  `is_active` int(1) DEFAULT NULL,
  `create_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`vendor_id`)
) ENGINE=InnoDB ;


--
-- Table structure for table `vendor_master`
--

DROP TABLE IF EXISTS `vendor_master`;

CREATE TABLE `vendor_master` (
  `vendor_id` int(11) NOT NULL,
  `vendor_name` varchar(20) NOT NULL,
  `vendor_description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`vendor_id`)
) ENGINE=InnoDB;

-- Dump completed on 2019-08-07 20:12:02
