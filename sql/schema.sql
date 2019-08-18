CREATE TABLE `em_event_master` (
  `em_event_id` int(11) NOT NULL,
  `em_event_name` varchar(45) DEFAULT NULL,
  `em_event_desc` text,
  PRIMARY KEY (`em_event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE `em_login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customerId` int(11) NOT NULL,
  `phoneNumber` varchar(12) NOT NULL,
  `pin` varchar(20) DEFAULT NULL,
  `inviteUrl` text,
  `isActive` int(1) DEFAULT '0',
  `isFirstTime` int(1) DEFAULT '1',
  `create_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `referenceCode` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customerId_UNIQUE` (`customerId`),
  KEY `em_customer_id_idx` (`customerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE `em_login_log` (
  `id` int(11) NOT NULL,
  `em_customer_id` int(11) DEFAULT NULL,
  `create_ts` datetime DEFAULT NULL,
  `location` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE `em_profile` (
  `customerId` int(11) NOT NULL AUTO_INCREMENT,
  `phoneNumber` varchar(12) NOT NULL,
  `firstName` varchar(25) NOT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `address` text,
  `city` varchar(20) DEFAULT NULL,
  `country` varchar(20) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  `createTs` datetime DEFAULT CURRENT_TIMESTAMP,
  `modifyTs` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `homeStoreNumber` int(11) DEFAULT NULL,
  PRIMARY KEY (`customerId`),
  UNIQUE KEY `phoneNumber_UNIQUE` (`phoneNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE `em_vendor_link` (
  `customerId` int(11) NOT NULL,
  `vendorCustomerId` int(11) NOT NULL,
  `vendorId` int(11) NOT NULL,
  UNIQUE KEY `idem_vendor_link_UNIQUE` (`customerId`),
  UNIQUE KEY `vendor_customer_id_UNIQUE` (`vendorCustomerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE `vendor_enable_config` (
  `vendor_id` int(11) NOT NULL,
  `transaction_type_id` varchar(45) DEFAULT NULL,
  `enable_mapping` int(1) DEFAULT NULL,
  `is_active` int(1) DEFAULT NULL,
  `create_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
CREATE TABLE `vendor_master` (
  `vendorId` int(11) NOT NULL,
  `vendorName` varchar(20) NOT NULL,
  `vendorDescription` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`vendorId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
