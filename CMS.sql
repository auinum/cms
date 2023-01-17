-- Adminer 4.8.1 MySQL 8.0.31-0ubuntu0.22.04.1 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `Announcement`;
CREATE TABLE `Announcement` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Identifer` varchar(256) NOT NULL COMMENT '識別號',
  `Title` varchar(256) NOT NULL COMMENT '標題',
  `Content` text NOT NULL COMMENT '內容',
  `DateCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立日期',
  `DateExpired` datetime DEFAULT NULL,
  `DatePublished` datetime DEFAULT NULL COMMENT '發布日期',
  `AuthorUserSN` int unsigned NOT NULL COMMENT '作者序號',
  PRIMARY KEY (`SN`),
  UNIQUE KEY `Identifer` (`Identifer`),
  KEY `AuthorUserSN` (`AuthorUserSN`),
  CONSTRAINT `Announcement_FK_1` FOREIGN KEY (`AuthorUserSN`) REFERENCES `User` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='公告';


DROP TABLE IF EXISTS `AnnouncementFile`;
CREATE TABLE `AnnouncementFile` (
  `AnnouncementSN` int unsigned NOT NULL COMMENT '公告序號',
  `AttachmentFileSN` int unsigned NOT NULL COMMENT '附件序號',
  PRIMARY KEY (`AnnouncementSN`,`AttachmentFileSN`),
  KEY `AttachmentFileSN` (`AttachmentFileSN`),
  CONSTRAINT `AnnouncementFile_FK_1` FOREIGN KEY (`AnnouncementSN`) REFERENCES `Announcement` (`SN`),
  CONSTRAINT `AnnouncementFile_FK_2` FOREIGN KEY (`AttachmentFileSN`) REFERENCES `File` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='公告附件';


DROP TABLE IF EXISTS `AnnouncementSort`;
CREATE TABLE `AnnouncementSort` (
  `AnnouncementSN` int unsigned NOT NULL COMMENT '公告序號',
  `SortSN` int unsigned NOT NULL COMMENT '類別序號',
  PRIMARY KEY (`AnnouncementSN`,`SortSN`),
  KEY `SortSN` (`SortSN`),
  CONSTRAINT `AnnouncementSort_FK_1` FOREIGN KEY (`AnnouncementSN`) REFERENCES `Announcement` (`SN`),
  CONSTRAINT `AnnouncementSort_FK_2` FOREIGN KEY (`SortSN`) REFERENCES `Sort` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='公告類別';


DROP TABLE IF EXISTS `Article`;
CREATE TABLE `Article` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Identifer` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '識別號',
  `Title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '標題',
  `Intro` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '簡介',
  `Content` text NOT NULL COMMENT '內容',
  `DateCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立日期',
  `DateExpired` datetime DEFAULT NULL,
  `DatePublished` datetime DEFAULT NULL COMMENT '發布日期',
  `AuthorUserSN` int unsigned NOT NULL COMMENT '作者序號',
  PRIMARY KEY (`SN`),
  UNIQUE KEY `Identifer` (`Identifer`),
  KEY `AuthorUserSN` (`AuthorUserSN`),
  CONSTRAINT `Article_FK_1` FOREIGN KEY (`AuthorUserSN`) REFERENCES `User` (`SN`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文章';


DROP TABLE IF EXISTS `ArticleCategory`;
CREATE TABLE `ArticleCategory` (
  `ArticleSN` int unsigned NOT NULL COMMENT '文章序號',
  `CategorySN` int unsigned NOT NULL COMMENT '分類序號',
  PRIMARY KEY (`ArticleSN`,`CategorySN`),
  KEY `CategorySN` (`CategorySN`),
  CONSTRAINT `ArticleCategory_FK_1` FOREIGN KEY (`ArticleSN`) REFERENCES `Article` (`SN`),
  CONSTRAINT `ArticleCategory_FK_2` FOREIGN KEY (`CategorySN`) REFERENCES `Category` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文章分類';


DROP TABLE IF EXISTS `ArticleFile`;
CREATE TABLE `ArticleFile` (
  `ArticleSN` int unsigned NOT NULL COMMENT '文章序號',
  `AttachmentFileSN` int unsigned NOT NULL COMMENT '附件序號',
  PRIMARY KEY (`ArticleSN`,`AttachmentFileSN`),
  KEY `AttachmentFileSN` (`AttachmentFileSN`),
  CONSTRAINT `ArticleFile_FK_1` FOREIGN KEY (`ArticleSN`) REFERENCES `Article` (`SN`),
  CONSTRAINT `ArticleFile_FK_2` FOREIGN KEY (`AttachmentFileSN`) REFERENCES `Announcement` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文章附件';


DROP TABLE IF EXISTS `ArticleTag`;
CREATE TABLE `ArticleTag` (
  `ArticleSN` int unsigned NOT NULL COMMENT '文章序號',
  `TagSN` int unsigned NOT NULL COMMENT '標籤序號',
  PRIMARY KEY (`ArticleSN`,`TagSN`),
  KEY `TagSN` (`TagSN`),
  CONSTRAINT `ArticleTag_FK_1` FOREIGN KEY (`ArticleSN`) REFERENCES `Article` (`SN`),
  CONSTRAINT `ArticleTag_FK_2` FOREIGN KEY (`TagSN`) REFERENCES `Tag` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文章標籤';


DROP TABLE IF EXISTS `Attribute`;
CREATE TABLE `Attribute` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Name` char(64) NOT NULL COMMENT '名稱',
  PRIMARY KEY (`SN`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='屬性';


DROP TABLE IF EXISTS `Category`;
CREATE TABLE `Category` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Identifer` varchar(256) NOT NULL COMMENT '識別號',
  `Title` varchar(256) NOT NULL COMMENT '標題',
  `Intro` varchar(256) NOT NULL COMMENT '簡介',
  `Description` text NOT NULL COMMENT '說明',
  `Hidden` bit(1) NOT NULL DEFAULT b'0' COMMENT '隱藏的',
  PRIMARY KEY (`SN`),
  UNIQUE KEY `Identifer` (`Identifer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='分類';


DROP TABLE IF EXISTS `Component`;
CREATE TABLE `Component` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Code` char(64) NOT NULL COMMENT '代號',
  PRIMARY KEY (`SN`),
  UNIQUE KEY `Code` (`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='組件';


DROP TABLE IF EXISTS `ComponentAttribute`;
CREATE TABLE `ComponentAttribute` (
  `ComponentSN` int unsigned NOT NULL COMMENT '組件序號',
  `AttributeSN` int unsigned NOT NULL COMMENT '屬性序號',
  PRIMARY KEY (`ComponentSN`,`AttributeSN`),
  KEY `AttributeSN` (`AttributeSN`),
  CONSTRAINT `ComponentAttribute_ibfk_1` FOREIGN KEY (`ComponentSN`) REFERENCES `Component` (`SN`),
  CONSTRAINT `ComponentAttribute_ibfk_2` FOREIGN KEY (`AttributeSN`) REFERENCES `Attribute` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='組件屬性';


DROP TABLE IF EXISTS `Configuration`;
CREATE TABLE `Configuration` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Key` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '鍵',
  `Value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '值',
  PRIMARY KEY (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='組態';


DROP TABLE IF EXISTS `ConfigurationAttribute`;
CREATE TABLE `ConfigurationAttribute` (
  `ConfigurationSN` int unsigned NOT NULL COMMENT '組態序號',
  `InputAttributeSN` int unsigned NOT NULL COMMENT '輸入屬性序號',
  `Value` text NOT NULL COMMENT '值',
  PRIMARY KEY (`ConfigurationSN`,`InputAttributeSN`),
  KEY `InputAttributeSN` (`InputAttributeSN`),
  CONSTRAINT `ConfigurationAttribute_ibfk_1` FOREIGN KEY (`ConfigurationSN`) REFERENCES `Configuration` (`SN`),
  CONSTRAINT `ConfigurationAttribute_ibfk_2` FOREIGN KEY (`InputAttributeSN`) REFERENCES `InputAttribute` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='組態輸入屬性';


DROP TABLE IF EXISTS `ConfigurationOption`;
CREATE TABLE `ConfigurationOption` (
  `ConfigurationSN` int unsigned NOT NULL COMMENT '組態序號',
  `Value` char(64) NOT NULL COMMENT '值',
  `Label` varchar(256) NOT NULL COMMENT '標籤',
  PRIMARY KEY (`ConfigurationSN`,`Value`),
  CONSTRAINT `ConfigurationOption_ibfk_1` FOREIGN KEY (`ConfigurationSN`) REFERENCES `Configuration` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='組態選項';


DROP TABLE IF EXISTS `ConfigurationTranslation`;
CREATE TABLE `ConfigurationTranslation` (
  `ConfigurationSN` int unsigned NOT NULL COMMENT '組態序號',
  `LangTagSN` int unsigned NOT NULL COMMENT '語言標籤序號',
  `Name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名稱',
  `Definition` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '定義',
  PRIMARY KEY (`ConfigurationSN`,`LangTagSN`),
  KEY `LangTagSN` (`LangTagSN`),
  CONSTRAINT `ConfigurationTranslation_FK_1` FOREIGN KEY (`ConfigurationSN`) REFERENCES `Configuration` (`SN`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ConfigurationTranslation_FK_2` FOREIGN KEY (`LangTagSN`) REFERENCES `LangTag` (`SN`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='組態譯文';


DROP TABLE IF EXISTS `File`;
CREATE TABLE `File` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Name` varchar(255) NOT NULL COMMENT '檔名',
  `Extension` varchar(255) NOT NULL COMMENT '副檔名',
  `ContentType` char(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '內容類型',
  `ContentHash` char(64) NOT NULL COMMENT '內容雜湊值',
  `Description` text NOT NULL COMMENT '說明',
  `DateUploaded` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上傳日期',
  `DateDeleted` datetime DEFAULT NULL COMMENT '刪除日期',
  `UploaderUserSN` int unsigned NOT NULL COMMENT '上傳者序號',
  PRIMARY KEY (`SN`),
  KEY `UploaderUserSN` (`UploaderUserSN`),
  CONSTRAINT `File_FK_1` FOREIGN KEY (`UploaderUserSN`) REFERENCES `User` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='檔案';


DROP TABLE IF EXISTS `Folder`;
CREATE TABLE `Folder` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Identifer` varchar(256) NOT NULL COMMENT '識別號',
  `Name` varchar(256) NOT NULL COMMENT '名稱',
  `Intro` varchar(256) DEFAULT NULL COMMENT '簡介',
  `Description` text COMMENT '說明',
  `ParentFolderSN` int unsigned DEFAULT NULL COMMENT '上層資料夾序號',
  PRIMARY KEY (`SN`),
  KEY `ParentFolderSN` (`ParentFolderSN`),
  CONSTRAINT `Folder_FK_1` FOREIGN KEY (`ParentFolderSN`) REFERENCES `Folder` (`SN`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='資料夾';


DROP TABLE IF EXISTS `FolderFile`;
CREATE TABLE `FolderFile` (
  `FolderSN` int unsigned NOT NULL COMMENT '資料夾序號',
  `FileSN` int unsigned NOT NULL COMMENT '檔案序號',
  PRIMARY KEY (`FolderSN`,`FileSN`),
  KEY `FileSN` (`FileSN`),
  CONSTRAINT `FolderFile_FK_1` FOREIGN KEY (`FolderSN`) REFERENCES `Folder` (`SN`),
  CONSTRAINT `FolderFile_FK_2` FOREIGN KEY (`FileSN`) REFERENCES `File` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='資料夾檔案';


DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Code` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '代號',
  `Implicit` bit(1) NOT NULL DEFAULT b'0' COMMENT '隱含的',
  `Disabled` bit(1) NOT NULL DEFAULT b'0' COMMENT '禁用的',
  `DateCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立日期',
  `CreatorUserSN` int unsigned NOT NULL COMMENT '建立者序號',
  PRIMARY KEY (`SN`),
  KEY `CreatorUserSN` (`CreatorUserSN`),
  CONSTRAINT `Group_FK_1` FOREIGN KEY (`CreatorUserSN`) REFERENCES `User` (`SN`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='群組';

INSERT INTO `Group` (`SN`, `Code`, `Implicit`, `Disabled`, `DateCreated`, `CreatorUserSN`) VALUES
(0,	'DEVELOPER',	CONV('0', 2, 10) + 0,	CONV('0', 2, 10) + 0,	'2022-11-11 00:00:00',	0),
(1,	'*',	CONV('1', 2, 10) + 0,	CONV('0', 2, 10) + 0,	'2022-11-11 00:00:00',	0),
(2,	'USER',	CONV('1', 2, 10) + 0,	CONV('0', 2, 10) + 0,	'2022-11-11 00:00:00',	0),
(3,	'SYSOP',	CONV('0', 2, 10) + 0,	CONV('0', 2, 10) + 0,	'2022-11-11 00:00:00',	0);

DROP TABLE IF EXISTS `GroupRight`;
CREATE TABLE `GroupRight` (
  `GroupSN` int unsigned NOT NULL COMMENT '群組序號',
  `RightSN` int unsigned NOT NULL COMMENT '權限序號',
  `DateCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立日期',
  `CreatorUserSN` int unsigned NOT NULL COMMENT '建立者序號',
  PRIMARY KEY (`GroupSN`,`RightSN`),
  KEY `RightSN` (`RightSN`),
  KEY `CreatorUserSN` (`CreatorUserSN`),
  CONSTRAINT `GroupRight_FK_2` FOREIGN KEY (`GroupSN`) REFERENCES `Group` (`SN`),
  CONSTRAINT `GroupRight_FK_3` FOREIGN KEY (`RightSN`) REFERENCES `Right` (`SN`),
  CONSTRAINT `GroupRight_FK_4` FOREIGN KEY (`CreatorUserSN`) REFERENCES `User` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='群組權限';

INSERT INTO `GroupRight` (`GroupSN`, `RightSN`, `DateCreated`, `CreatorUserSN`) VALUES
(1,	1,	'2022-11-11 00:00:00',	0);

DROP TABLE IF EXISTS `GroupTranslation`;
CREATE TABLE `GroupTranslation` (
  `GroupSN` int unsigned NOT NULL COMMENT '群組序號',
  `LangTagSN` int unsigned NOT NULL COMMENT '語言標籤序號',
  `Name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名稱',
  `Definition` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '定義',
  PRIMARY KEY (`GroupSN`,`LangTagSN`),
  KEY `LangTagSN` (`LangTagSN`),
  CONSTRAINT `GroupTranslation_FK_1` FOREIGN KEY (`GroupSN`) REFERENCES `Group` (`SN`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `GroupTranslation_FK_2` FOREIGN KEY (`LangTagSN`) REFERENCES `LangTag` (`SN`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='群組譯文';


DROP TABLE IF EXISTS `InputAttribute`;
CREATE TABLE `InputAttribute` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Name` varchar(256) NOT NULL COMMENT '名稱',
  PRIMARY KEY (`SN`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='輸入屬性';


DROP TABLE IF EXISTS `InterfaceText`;
CREATE TABLE `InterfaceText` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Code` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '代號',
  PRIMARY KEY (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='介面文字';


DROP TABLE IF EXISTS `InterfaceTextTranslation`;
CREATE TABLE `InterfaceTextTranslation` (
  `InterfaceTextSN` int unsigned NOT NULL COMMENT '介面文字序號',
  `LangTagSN` int unsigned NOT NULL COMMENT '語言標籤序號',
  `Name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名稱',
  `Definition` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '定義',
  PRIMARY KEY (`InterfaceTextSN`,`LangTagSN`),
  KEY `LangTagSN` (`LangTagSN`),
  CONSTRAINT `InterfaceTextTranslation_FK_1` FOREIGN KEY (`InterfaceTextSN`) REFERENCES `InterfaceText` (`SN`),
  CONSTRAINT `InterfaceTextTranslation_FK_2` FOREIGN KEY (`LangTagSN`) REFERENCES `LangTag` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='介面文字譯文';


DROP TABLE IF EXISTS `LangTag`;
CREATE TABLE `LangTag` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Language` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '語言子標籤',
  `Script` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文字子標籤',
  `Region` char(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '地區子標籤',
  `Name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名稱',
  `Disabled` bit(1) NOT NULL DEFAULT b'1' COMMENT '禁用的',
  PRIMARY KEY (`SN`),
  UNIQUE KEY `Language_Script_Region` (`Language`,`Script`,`Region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='語言標籤';

INSERT INTO `LangTag` (`SN`, `Language`, `Script`, `Region`, `Name`, `Disabled`) VALUES
(1,	'en',	NULL,	NULL,	'English',	CONV('1', 2, 10) + 0),
(2,	'zh',	NULL,	NULL,	'中文',	CONV('1', 2, 10) + 0),
(3,	'zh',	'Hans',	NULL,	'中文（简体）',	CONV('1', 2, 10) + 0),
(4,	'zh',	'Hans',	'CN',	'中文（大陆简体）',	CONV('1', 2, 10) + 0),
(5,	'zh',	'Hant',	'MY',	'中文（大马简体）',	CONV('1', 2, 10) + 0),
(6,	'zh',	'Hans',	'SG',	'中文（新加坡简体）',	CONV('1', 2, 10) + 0),
(7,	'zh',	'Hant',	NULL,	'中文（繁體）',	CONV('1', 2, 10) + 0),
(8,	'zh',	'Hant',	'HK',	'中文（香港繁體）',	CONV('1', 2, 10) + 0),
(9,	'zh',	'Hant',	'MO',	'中文（澳門繁體）',	CONV('1', 2, 10) + 0),
(10,	'zh',	'Hant',	'TW',	'中文（臺灣正體）',	CONV('1', 2, 10) + 0);

DROP TABLE IF EXISTS `Log`;
CREATE TABLE `Log` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Code` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '代號',
  PRIMARY KEY (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日誌';


DROP TABLE IF EXISTS `LogTranslation`;
CREATE TABLE `LogTranslation` (
  `LogSN` int unsigned NOT NULL COMMENT '事件序號',
  `LangTagSN` int unsigned NOT NULL COMMENT '語言標籤序號',
  `Name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名稱',
  `Definition` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '定義',
  PRIMARY KEY (`LogSN`,`LangTagSN`),
  KEY `LangTagSN` (`LangTagSN`),
  CONSTRAINT `LogTranslation_FK_1` FOREIGN KEY (`LogSN`) REFERENCES `Log` (`SN`),
  CONSTRAINT `LogTranslation_FK_2` FOREIGN KEY (`LangTagSN`) REFERENCES `LangTag` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='日誌譯文';


DROP TABLE IF EXISTS `Page`;
CREATE TABLE `Page` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Identifer` varchar(256) NOT NULL COMMENT '識別號',
  `Title` varchar(256) NOT NULL COMMENT '標題',
  `Intro` varchar(256) DEFAULT NULL COMMENT '簡介',
  `CreatorUserSN` int unsigned NOT NULL COMMENT '建立者序號',
  PRIMARY KEY (`SN`),
  UNIQUE KEY `Identifer` (`Identifer`),
  KEY `CreatorUserSN` (`CreatorUserSN`),
  CONSTRAINT `Page_ibfk_1` FOREIGN KEY (`CreatorUserSN`) REFERENCES `User` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='頁面';


DROP TABLE IF EXISTS `PageComponent`;
CREATE TABLE `PageComponent` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `VerticalOrder` int NOT NULL COMMENT '垂直順序',
  `HorizontalOrder` int NOT NULL COMMENT '水平順序',
  `PageSN` int unsigned NOT NULL COMMENT '頁面序號',
  `ComponentSN` int unsigned NOT NULL COMMENT '組件序號',
  PRIMARY KEY (`SN`),
  KEY `PageSN` (`PageSN`),
  KEY `ComponentSN` (`ComponentSN`),
  CONSTRAINT `PageComponent_ibfk_1` FOREIGN KEY (`PageSN`) REFERENCES `Page` (`SN`),
  CONSTRAINT `PageComponent_ibfk_2` FOREIGN KEY (`ComponentSN`) REFERENCES `Component` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='頁面組件';


DROP TABLE IF EXISTS `PageComponentAttribute`;
CREATE TABLE `PageComponentAttribute` (
  `PageComponentSN` int unsigned NOT NULL COMMENT '頁面組件序號',
  `AttributeSN` int unsigned NOT NULL COMMENT '屬性序號',
  `Value` text NOT NULL COMMENT '值',
  PRIMARY KEY (`PageComponentSN`,`AttributeSN`),
  KEY `AttributeSN` (`AttributeSN`),
  CONSTRAINT `PageComponentAttribute_ibfk_1` FOREIGN KEY (`PageComponentSN`) REFERENCES `PageComponent` (`SN`),
  CONSTRAINT `PageComponentAttribute_ibfk_2` FOREIGN KEY (`AttributeSN`) REFERENCES `Attribute` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='頁面組件屬性';


DROP TABLE IF EXISTS `PrederenceOption`;
CREATE TABLE `PrederenceOption` (
  `PreferenceSN` int unsigned NOT NULL COMMENT '序號',
  `Value` char(64) NOT NULL COMMENT '值',
  `Label` varchar(256) NOT NULL COMMENT '標籤',
  PRIMARY KEY (`PreferenceSN`,`Value`),
  CONSTRAINT `PrederenceOption_ibfk_1` FOREIGN KEY (`PreferenceSN`) REFERENCES `Preference` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='偏好選項';


DROP TABLE IF EXISTS `Preference`;
CREATE TABLE `Preference` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Code` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '代號',
  PRIMARY KEY (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='偏好';


DROP TABLE IF EXISTS `PreferenceAttribute`;
CREATE TABLE `PreferenceAttribute` (
  `PreferenceSN` int unsigned NOT NULL COMMENT '偏好序號',
  `InputAttributeSN` int unsigned NOT NULL COMMENT '輸入屬性序號',
  `Value` text NOT NULL COMMENT '值',
  PRIMARY KEY (`PreferenceSN`,`InputAttributeSN`),
  KEY `InputAttributeSN` (`InputAttributeSN`),
  CONSTRAINT `PreferenceAttribute_ibfk_1` FOREIGN KEY (`PreferenceSN`) REFERENCES `Preference` (`SN`),
  CONSTRAINT `PreferenceAttribute_ibfk_2` FOREIGN KEY (`InputAttributeSN`) REFERENCES `InputAttribute` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='偏好輸入屬性';


DROP TABLE IF EXISTS `PreferenceTranslation`;
CREATE TABLE `PreferenceTranslation` (
  `PreferenceSN` int unsigned NOT NULL COMMENT '偏好序號',
  `LangTagSN` int unsigned NOT NULL COMMENT '語言標籤序號',
  `Name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名稱',
  `Definition` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '定義',
  PRIMARY KEY (`PreferenceSN`,`LangTagSN`),
  KEY `LangTagSN` (`LangTagSN`),
  CONSTRAINT `PreferenceTranslation_FK_1` FOREIGN KEY (`PreferenceSN`) REFERENCES `Preference` (`SN`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `PreferenceTranslation_FK_2` FOREIGN KEY (`LangTagSN`) REFERENCES `LangTag` (`SN`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='偏好譯文';


DROP TABLE IF EXISTS `Right`;
CREATE TABLE `Right` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Code` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '代號',
  PRIMARY KEY (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='權限';

INSERT INTO `Right` (`SN`, `Code`) VALUES
(1,	'CREATE_USER'),
(2,	'NO_RATE_LIMIT'),
(3,	'UPLOAD'),
(4,	'CREATE_ARTICLE'),
(5,	'EDIT_GROUP_RIGHT'),
(6,	'EDIT_USER_GROUP'),
(7,	'EDIT_INTERFACE'),
(8,	'READ_USER');

DROP TABLE IF EXISTS `RightTranslation`;
CREATE TABLE `RightTranslation` (
  `RightSN` int unsigned NOT NULL COMMENT '權限序號',
  `LangTagSN` int unsigned NOT NULL COMMENT '語言標籤序號',
  `Name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名稱',
  `Definition` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '定義',
  PRIMARY KEY (`RightSN`,`LangTagSN`),
  KEY `LangTagSN` (`LangTagSN`),
  CONSTRAINT `RightTranslation_FK_1` FOREIGN KEY (`RightSN`) REFERENCES `Right` (`SN`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `RightTranslation_FK_2` FOREIGN KEY (`LangTagSN`) REFERENCES `LangTag` (`SN`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='權限譯文';


DROP TABLE IF EXISTS `Session`;
CREATE TABLE `Session` (
  `ID` char(32) NOT NULL COMMENT '識別碼',
  `Data` text NOT NULL COMMENT '資料',
  `DateIssued` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '發行日期',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工作階段';


DROP TABLE IF EXISTS `Sort`;
CREATE TABLE `Sort` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Identifer` varchar(256) NOT NULL COMMENT '識別號',
  `Name` varchar(256) NOT NULL COMMENT '名稱',
  PRIMARY KEY (`SN`),
  UNIQUE KEY `Identifer` (`Identifer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='類別';


DROP TABLE IF EXISTS `Tag`;
CREATE TABLE `Tag` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Title` varchar(256) NOT NULL COMMENT '標題',
  `Intro` text COMMENT '簡介',
  PRIMARY KEY (`SN`),
  UNIQUE KEY `Title` (`Title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='標籤';


DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
  `SN` int unsigned NOT NULL AUTO_INCREMENT COMMENT '序號',
  `Username` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '使用者名稱',
  `Email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '電子信箱',
  `PasswordHash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '使用者密碼雜湊值',
  `FirstName` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名字',
  `LastName` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '姓氏',
  `Nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '暱稱',
  `DateRegistered` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '註冊日期',
  `Deactivated` bit(1) NOT NULL DEFAULT b'0' COMMENT '停用的',
  `CreatorUserSN` int unsigned DEFAULT NULL COMMENT '建立者序號',
  PRIMARY KEY (`SN`),
  UNIQUE KEY `Username` (`Username`),
  KEY `CreatorUserSN` (`CreatorUserSN`),
  CONSTRAINT `User_FK_1` FOREIGN KEY (`CreatorUserSN`) REFERENCES `User` (`SN`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='使用者';

INSERT INTO `User` (`SN`, `Username`, `Email`, `PasswordHash`, `FirstName`, `LastName`, `Nickname`, `DateRegistered`, `Deactivated`, `CreatorUserSN`) VALUES
(0,	'Developer',	'N/A',	'$2y$10$D7LVfI4kCHfdWx1qDKU6DOVGcGcaGAUi4SXiEHkUchN.uFCuuJMvu',	'N/A',	'N/A',	'Developer',	'2022-11-11 00:00:00',	CONV('0', 2, 10) + 0,	0),
(1,	'One',	'N/A',	'$2y$10$wyOC8yI2U748BHpLD12Om.lFsR0vAc6AMdmU9LxD2RQqpV1rM9EP2',	'N/A',	'N/A',	'One',	'2023-01-14 13:52:53',	CONV('0', 2, 10) + 0,	0),
(2,	'Two',	'N/A',	'$2y$10$wyOC8yI2U748BHpLD12Om.lFsR0vAc6AMdmU9LxD2RQqpV1rM9EP2',	'N/A',	'N/A',	'Two',	'2023-01-14 13:53:06',	CONV('0', 2, 10) + 0,	1);

DROP TABLE IF EXISTS `UserGroup`;
CREATE TABLE `UserGroup` (
  `UserSN` int unsigned NOT NULL COMMENT '使用者序號',
  `GroupSN` int unsigned NOT NULL COMMENT '群組序號',
  `DateGranted` datetime NOT NULL COMMENT '授予日期',
  `DateExpired` datetime DEFAULT NULL COMMENT '結束日期',
  `DateRevoked` datetime DEFAULT NULL COMMENT '撤銷日期',
  `GrantorUserSN` int unsigned NOT NULL COMMENT '授予者序號',
  PRIMARY KEY (`UserSN`,`GroupSN`),
  KEY `GroupSN` (`GroupSN`),
  KEY `GrantorUserSN` (`GrantorUserSN`),
  CONSTRAINT `UserGroup_FK_2` FOREIGN KEY (`UserSN`) REFERENCES `User` (`SN`),
  CONSTRAINT `UserGroup_FK_3` FOREIGN KEY (`GroupSN`) REFERENCES `Group` (`SN`),
  CONSTRAINT `UserGroup_FK_4` FOREIGN KEY (`GrantorUserSN`) REFERENCES `User` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='使用者群組';

INSERT INTO `UserGroup` (`UserSN`, `GroupSN`, `DateGranted`, `DateExpired`, `DateRevoked`, `GrantorUserSN`) VALUES
(0,	1,	'2022-11-11 00:00:00',	NULL,	NULL,	0);

DROP TABLE IF EXISTS `UserLog`;
CREATE TABLE `UserLog` (
  `UserSN` int unsigned NOT NULL COMMENT '使用者序號',
  `LogSN` int unsigned NOT NULL COMMENT '日誌序號',
  `Value` text NOT NULL COMMENT '輸入值',
  `DateOccurred` datetime NOT NULL COMMENT '發生日期',
  KEY `UserSN` (`UserSN`),
  KEY `LogSN` (`LogSN`),
  CONSTRAINT `UserLog_FK_1` FOREIGN KEY (`UserSN`) REFERENCES `User` (`SN`),
  CONSTRAINT `UserLog_FK_2` FOREIGN KEY (`LogSN`) REFERENCES `Log` (`SN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='使用者日誌';


DROP TABLE IF EXISTS `UserPreference`;
CREATE TABLE `UserPreference` (
  `UserSN` int unsigned NOT NULL COMMENT '使用者序號',
  `PreferenceSN` int unsigned NOT NULL COMMENT '偏好序號',
  `Value` text COMMENT '輸入值',
  PRIMARY KEY (`UserSN`,`PreferenceSN`),
  KEY `PreferenceSN` (`PreferenceSN`),
  CONSTRAINT `UserPreference_FK_1` FOREIGN KEY (`UserSN`) REFERENCES `User` (`SN`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `UserPreference_FK_2` FOREIGN KEY (`PreferenceSN`) REFERENCES `Preference` (`SN`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='使用者偏好';


DROP VIEW IF EXISTS `UserRight`;
CREATE TABLE `UserRight` (`SN` int unsigned, `Code` char(16));


DROP TABLE IF EXISTS `UserRight`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `UserRight` AS select `U`.`SN` AS `SN`,`R`.`Code` AS `Code` from ((((`Right` `R` join `GroupRight` `GR` on((`GR`.`RightSN` = `R`.`SN`))) join `Group` `G` on((`G`.`SN` = `GR`.`GroupSN`))) join `UserGroup` `UG` on((`UG`.`GroupSN` = `G`.`SN`))) join `User` `U` on((`U`.`SN` = `UG`.`UserSN`)));

-- 2023-01-17 02:19:58
