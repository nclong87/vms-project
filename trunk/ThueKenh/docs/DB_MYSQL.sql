/*
SQLyog Ultimate v9.51 
MySQL - 5.1.41-community-log : Database - test
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `account_khuvuc` */

DROP TABLE IF EXISTS `account_khuvuc`;

CREATE TABLE `account_khuvuc` (
  `ACCOUNT_ID` varchar(100) DEFAULT NULL,
  `KHUVUC_ID` varchar(100) DEFAULT NULL,
  KEY `FK_account_khuvuc1` (`ACCOUNT_ID`),
  KEY `FK_account_khuvuc2` (`KHUVUC_ID`),
  CONSTRAINT `FK_account_khuvuc1` FOREIGN KEY (`ACCOUNT_ID`) REFERENCES `accounts` (`ID`),
  CONSTRAINT `FK_account_khuvuc2` FOREIGN KEY (`KHUVUC_ID`) REFERENCES `khuvuc` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `account_khuvuc` */

/*Table structure for table `accounts` */

DROP TABLE IF EXISTS `accounts`;

CREATE TABLE `accounts` (
  `ID` varchar(100) NOT NULL,
  `USERNAME` varchar(100) DEFAULT NULL,
  `PASSWORD` varchar(100) DEFAULT NULL,
  `IDGROUP` varchar(100) DEFAULT NULL,
  `ACTIVE` varchar(100) DEFAULT NULL,
  `IDKHUVUC` varchar(100) DEFAULT NULL,
  `IDPHONGBAN` varchar(200) DEFAULT NULL,
  `MAINMENU` varchar(100) DEFAULT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  `PHONE` varchar(100) DEFAULT NULL,
  `LOGIN_TIME` varchar(100) DEFAULT NULL,
  `NO_SMS` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_accounts_pb` (`IDPHONGBAN`),
  CONSTRAINT `FK_accounts_pb` FOREIGN KEY (`IDPHONGBAN`) REFERENCES `phongban` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `accounts` */

/*Table structure for table `bienbanvanhanh` */

DROP TABLE IF EXISTS `bienbanvanhanh`;

CREATE TABLE `bienbanvanhanh` (
  `ID` varchar(200) NOT NULL,
  `FILESCAN_ID` varchar(200) DEFAULT NULL,
  `SOBIENBAN` varchar(200) DEFAULT NULL,
  `USERCREATE` varchar(200) DEFAULT NULL,
  `TIMECREATE` varchar(200) DEFAULT NULL,
  `DELETED` varchar(200) DEFAULT NULL,
  `FILENAME` varchar(200) DEFAULT NULL,
  `FILEPATH` varchar(200) DEFAULT NULL,
  `FILESIZE` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `bienbanvanhanh` */

/*Table structure for table `doitac` */

DROP TABLE IF EXISTS `doitac`;

CREATE TABLE `doitac` (
  `ID` varchar(200) NOT NULL,
  `TENDOITAC` varchar(200) DEFAULT NULL,
  `DELETED` varchar(200) DEFAULT NULL,
  `STT` varchar(200) DEFAULT NULL,
  `MA` varchar(200) DEFAULT NULL,
  `KHUVUC_ID` varchar(200) DEFAULT NULL,
  `SOTUYENKENH` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_doitacsss` (`KHUVUC_ID`),
  CONSTRAINT `FK_doitacsss` FOREIGN KEY (`KHUVUC_ID`) REFERENCES `khuvuc` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `doitac` */

/*Table structure for table `khuvuc` */

DROP TABLE IF EXISTS `khuvuc`;

CREATE TABLE `khuvuc` (
  `ID` varchar(200) NOT NULL,
  `TENKHUVUC` varchar(200) DEFAULT NULL,
  `DELETED` varchar(200) DEFAULT NULL,
  `STT` varchar(200) DEFAULT NULL,
  `MA` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `khuvuc` */

/*Table structure for table `phongban` */

DROP TABLE IF EXISTS `phongban`;

CREATE TABLE `phongban` (
  `ID` varchar(200) NOT NULL,
  `TENPHONGBAN` varchar(200) DEFAULT NULL,
  `DELETED` varchar(200) DEFAULT NULL,
  `STT` varchar(200) DEFAULT NULL,
  `MA` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `phongban` */

/*Table structure for table `sms` */

DROP TABLE IF EXISTS `sms`;

CREATE TABLE `sms` (
  `DATE_SEND` date DEFAULT NULL,
  `PHONE` varchar(200) DEFAULT NULL,
  `CONTENT` varchar(200) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `sms` */

/*Table structure for table `sucokenh` */

DROP TABLE IF EXISTS `sucokenh`;

CREATE TABLE `sucokenh` (
  `ID` varchar(200) NOT NULL,
  `TUYENKENH_ID` varchar(200) DEFAULT NULL,
  `PHULUC_ID` varchar(200) DEFAULT NULL,
  `THANHTOAN_ID` varchar(200) DEFAULT NULL,
  `LOAISUCO` varchar(200) DEFAULT NULL,
  `THOIDIEMBATDAU` varchar(200) DEFAULT NULL,
  `THOIDIEMKETTHUC` varchar(200) DEFAULT NULL,
  `THOIGIANMLL` varchar(200) DEFAULT NULL,
  `NGUYENNHAN` varchar(200) DEFAULT NULL,
  `PHUONGANXULY` varchar(200) DEFAULT NULL,
  `NGUOIXACNHAN` varchar(200) DEFAULT NULL,
  `TRANGTHAI` varchar(200) DEFAULT NULL,
  `USERCREATE` varchar(200) DEFAULT NULL,
  `TIMECREATE` varchar(200) DEFAULT NULL,
  `DELETED` varchar(200) DEFAULT NULL,
  `FILENAME` varchar(200) DEFAULT NULL,
  `FILEPATH` varchar(200) DEFAULT NULL,
  `FILESIZE` varchar(200) DEFAULT NULL,
  `BIENBANVANHANH_ID` varchar(200) DEFAULT NULL,
  `CUOCTHANG` varchar(200) DEFAULT NULL,
  `GIAMTRUMLL` varchar(200) DEFAULT NULL,
  KEY `FK_sucokenhs` (`TUYENKENH_ID`),
  KEY `FK_sucokenh1` (`BIENBANVANHANH_ID`),
  CONSTRAINT `FK_sucokenh1` FOREIGN KEY (`BIENBANVANHANH_ID`) REFERENCES `bienbanvanhanh` (`ID`),
  CONSTRAINT `FK_sucokenhs` FOREIGN KEY (`TUYENKENH_ID`) REFERENCES `tuyenkenh` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sucokenh` */

/*Table structure for table `tuyenkenh` */

DROP TABLE IF EXISTS `tuyenkenh`;

CREATE TABLE `tuyenkenh` (
  `ID` varchar(200) NOT NULL,
  `MADIEMDAU` varchar(200) DEFAULT NULL,
  `MADIEMCUOI` varchar(200) DEFAULT NULL,
  `GIAOTIEP_ID` varchar(200) DEFAULT NULL,
  `DUAN_ID` varchar(200) DEFAULT NULL,
  `PHONGBAN_ID` varchar(200) DEFAULT NULL,
  `DOITAC_ID` varchar(200) DEFAULT NULL,
  `DUNGLUONG` varchar(200) DEFAULT NULL,
  `TRANGTHAI` varchar(200) DEFAULT NULL,
  `USERCREATE` varchar(200) DEFAULT NULL,
  `TIMECREATE` varchar(200) DEFAULT NULL,
  `DELETED` varchar(200) DEFAULT NULL,
  `SOLUONG` varchar(200) DEFAULT NULL,
  `FLAG` varchar(200) DEFAULT NULL,
  `NGAYBATDAU` varchar(200) DEFAULT NULL,
  `LOAIKENH` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_tuyenkenha` (`DOITAC_ID`),
  KEY `FK_tuyenkenhdasd` (`PHONGBAN_ID`),
  CONSTRAINT `FK_tuyenkenha` FOREIGN KEY (`DOITAC_ID`) REFERENCES `doitac` (`ID`),
  CONSTRAINT `FK_tuyenkenhdasd` FOREIGN KEY (`PHONGBAN_ID`) REFERENCES `phongban` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `tuyenkenh` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
