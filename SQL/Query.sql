SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `banking_data`;

CREATE TABLE `banking_data` (
  `PlayerUID` varchar(20) NOT NULL DEFAULT '0',
  `PlayerName` varchar(128) NOT NULL DEFAULT 'Null',
  `BankSaldo` bigint(24) NOT NULL DEFAULT '0',
  `LastUpdated` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PlayerUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `character_data` ADD CashMoney int(11) NOT NULL DEFAULT 0 AFTER PlayerUID;