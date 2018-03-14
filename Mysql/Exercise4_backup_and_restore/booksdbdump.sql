-- MySQL dump 10.13  Distrib 5.7.21, for osx10.12 (x86_64)
--
-- Host: localhost    Database: BooksDB
-- ------------------------------------------------------
-- Server version	5.7.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `AuthorBook`
--

DROP TABLE IF EXISTS `AuthorBook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AuthorBook` (
  `AuthID` smallint(6) NOT NULL,
  `BookID` smallint(6) NOT NULL,
  PRIMARY KEY (`AuthID`,`BookID`),
  KEY `BookID` (`BookID`),
  CONSTRAINT `authorbook_ibfk_1` FOREIGN KEY (`AuthID`) REFERENCES `Authors` (`AuthID`),
  CONSTRAINT `authorbook_ibfk_2` FOREIGN KEY (`BookID`) REFERENCES `Books` (`BookID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AuthorBook`
--

LOCK TABLES `AuthorBook` WRITE;
/*!40000 ALTER TABLE `AuthorBook` DISABLE KEYS */;
INSERT INTO `AuthorBook` VALUES (1009,12786),(1006,14356),(1008,15729),(1011,15729),(1014,16284),(1010,17695),(1012,19264),(1012,19354);
/*!40000 ALTER TABLE `AuthorBook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Authors`
--

DROP TABLE IF EXISTS `Authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Authors` (
  `AuthID` smallint(6) NOT NULL,
  `AuthFN` varchar(20) DEFAULT NULL,
  `AuthMN` varchar(20) DEFAULT NULL,
  `AuthLN` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`AuthID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Authors`
--

LOCK TABLES `Authors` WRITE;
/*!40000 ALTER TABLE `Authors` DISABLE KEYS */;
INSERT INTO `Authors` VALUES (1006,'Hunter','S.','Thompson'),(1007,'Joyce','Carol','Oates'),(1008,'Black',NULL,'Elk'),(1009,'Rainer','Maria','Rilke'),(1010,'John','Kennedy','Toole'),(1011,'John','G.','Neihardt'),(1012,'Annie',NULL,'Proulx'),(1013,'Alan',NULL,'Watts'),(1014,'Nelson',NULL,'Algren');
/*!40000 ALTER TABLE `Authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Books`
--

DROP TABLE IF EXISTS `Books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Books` (
  `BookID` smallint(6) NOT NULL,
  `BookTitle` varchar(60) NOT NULL,
  `Copyright` year(4) NOT NULL,
  PRIMARY KEY (`BookID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Books`
--

LOCK TABLES `Books` WRITE;
/*!40000 ALTER TABLE `Books` DISABLE KEYS */;
INSERT INTO `Books` VALUES (12786,'Letters to a Young Poet',1934),(13331,'Winesburg, Ohio',1919),(14356,'Hell\'s Angels',1966),(15729,'Black Elk Speaks',1932),(16284,'Noncomformity',1996),(17695,'A Confederacy of Dunces',1980),(19264,'Postcards',1992),(19354,'The Shipping News',1993);
/*!40000 ALTER TABLE `Books` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-14 17:26:57
