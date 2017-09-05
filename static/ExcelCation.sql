CREATE DATABASE  IF NOT EXISTS `excellent_education` DEFAULT CHARACTER SET utf8;
USE `excellent_education`;
-- MySQL dump 10.13  Distrib 5.5.57, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: excellent_education
-- ------------------------------------------------------
-- Server version	5.5.57-0ubuntu0.14.04.1

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
-- Table structure for table `administrator`
--

DROP TABLE IF EXISTS `administrator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `administrator` (
  `ADMIN_NAME` varchar(16) NOT NULL,
  `PASSWORD` varchar(16) NOT NULL,
  PRIMARY KEY (`ADMIN_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrator`
--

LOCK TABLES `administrator` WRITE;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` VALUES ('JSON','123456');
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student` (
  `STUDENT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `STUDENT_NAME` varchar(10) NOT NULL,
  `STUDENT_EMAIL` varchar(25) NOT NULL,
  `STUDENT_PASSWORD` varchar(12) NOT NULL,
  `HEADIMG` varchar(16) DEFAULT NULL,
  `GENDER` int(11) NOT NULL,
  `TELEPHONE` char(11) NOT NULL,
  `ADDRESS` varchar(60) NOT NULL,
  `INTRODUCE` varchar(60) DEFAULT NULL,
  `GRADE_MARK` int(11) DEFAULT NULL,
  `SUBJECT_MARK` int(11) DEFAULT NULL,
  `PARENT_TEL` char(11) DEFAULT NULL,
  `PARENT_NAME` varchar(8) DEFAULT NULL,
  `ID_NUMBER` varchar(18) NOT NULL,
  `TOKEN` int(11) DEFAULT NULL,
  PRIMARY KEY (`STUDENT_ID`),
  UNIQUE KEY `STUDENT_EMAIL` (`STUDENT_EMAIL`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'jason','963321510@qq.com','123456','',1,'13049145120','华南师范大学南海校区学生公寓C座301','就读于软件学院软件工程专业，2014级学生',12,3,'135xxxx5448','jes','4452xxxxxxxxxxxx59',1),(2,'kobe','445544@qq.com','123456','',1,'13049145120','华南师范大学南海校区学生公寓D座301','就读于软件学院软件工程专业，2012级学生',12,3,'139xxxx5448','brece','4452xxxxxxxxxxxx59',2),(3,'jordan','12345@qq.com','123456','',1,'13049145120','华南师范大学南海校区学生公寓E座301','就读于软件学院软件工程专业，2015级学生',12,3,'136xxxx5448','bruse','4452xxxxxxxxxxxx59',3),(4,'jackson','23456@qq.com','123456','',1,'13049145120','华南师范大学南海校区学生公寓F座301','就读于软件学院软件工程专业，2016级学生',12,3,'125xxxx5448','blus','4452xxxxxxxxxxxx59',4);
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher` (
  `TEACHER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `TEACHER_NAME` varchar(10) NOT NULL,
  `TEACHER_EMAIL` varchar(25) NOT NULL,
  `TEACHER_PASSWORD` varchar(12) NOT NULL,
  `HEADIMG` varchar(16) DEFAULT NULL,
  `GENDER` int(11) NOT NULL,
  `TELEPHONE` char(11) NOT NULL,
  `ADDRESS` varchar(60) NOT NULL,
  `INTRODUCE` varchar(60) DEFAULT NULL,
  `ID_NUMBER` varchar(18) NOT NULL,
  `SUB_MARK` int(11) NOT NULL,
  `TOKEN` int(11) DEFAULT NULL,
  PRIMARY KEY (`TEACHER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `career`
--

DROP TABLE IF EXISTS `career`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `career` (
  `CAREER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CAREER_CONTENT` varchar(100) NOT NULL,
  `CAREER_START_TIME` date DEFAULT NULL,
  `CAREER_END_TIME` date DEFAULT NULL,
  `CAREER_TEACHER_ID` int(11) NOT NULL,
  PRIMARY KEY (`CAREER_ID`),
  FOREIGN KEY `FK_CAREER_TEACHER` (`CAREER_TEACHER_ID`) on DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `career`
--

LOCK TABLES `career` WRITE;
/*!40000 ALTER TABLE `career` DISABLE KEYS */;
INSERT INTO `career` VALUES (1,'教高一英语两个学期','2015-09-07','2016-07-21',1),(2,'教高中数学','2016-09-01','2017-01-12',2),(3,'教初中化学三个学期','2015-09-07','2016-07-21',3),(4,'教高一数学四个学期','2013-09-07','2015-07-20',4),(5,'教高一英语两个学期','2015-09-04','2016-07-15',5),(6,'教高一物理一个学期','2013-09-02','2014-01-22',5),(7,'教高一英语三个学期','2015-02-23','2016-07-20',1),(8,'教高一语文三个学期','2014-09-07','2016-01-08',2),(9,'在广州广雅中学教授英语','2015-02-10','2017-03-30',4),(10,'教高中数学','2015-06-21','2015-08-30',3);
/*!40000 ALTER TABLE `career` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `certification`
--

DROP TABLE IF EXISTS `certification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certification` (
  `CER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CER_TITLE` varchar(50) NOT NULL,
  `CER_TEACHER_ID` int(11) NOT NULL,
  PRIMARY KEY (`CER_ID`),
  FOREIGN KEY `FK_CER_TEACHER` (`CER_TEACHER_ID`) on DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certification`
--

LOCK TABLES `certification` WRITE;
/*!40000 ALTER TABLE `certification` DISABLE KEYS */;
INSERT INTO `certification` VALUES (2,'中级教师资格证',1),(3,'高级教师资格证',1),(4,'中级教师资格证',2),(5,'计算机辅助教学高级证书',3),(6,'高级教师资格证',5),(7,'初级教师资格证',5),(8,'中级教师资格证',5),(9,'高级职称',3),(10,'计算机辅助教学高级证书',2);
/*!40000 ALTER TABLE `certification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course` (
  `COURSE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `COURSE_TITLE` varchar(30) NOT NULL,
  `COURSE_CONTENT` varchar(100) DEFAULT NULL,
  `COURSE_GRADEMARK` int(11) DEFAULT NULL,
  `COURSE_SUBMARK` int(11) DEFAULT NULL,
  `COURSE_START_TIME` date NOT NULL,
  `COURSE_END_TIME` date NOT NULL,
  `COURSE_FEE` int(11) NOT NULL,
  `COURSE_TEACHER_ID` int(11) NOT NULL,
  `COURSE_VEDIO` varchar(50) NOT NULL,
  `COURSE_DURATION` int(11) NOT NULL,
  `COURSE_MARK` int(11) NOT NULL,
  PRIMARY KEY (`COURSE_ID`),
  FOREIGN KEY `FK_COURSE_TEACHER` (`COURSE_TEACHER_ID`) on DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'定语从句','定语从句详解及应用',9,3,'2017-03-24','2017-03-24',0,4,'',0,2),(3,'平行线','平行线证明及其应用',8,2,'0000-00-00','0000-00-00',0,5,'',0,1),(6,'定语从句','定语从句详解及应用',9,3,'2017-03-24','2017-03-24',0,6,'',0,2),(7,'等腰三角形','等腰三角形的证明及其应用',8,2,'2016-07-30','2017-07-30',0,7,'',0,2),(8,'平行线','平行线证明及其应用',8,2,'0000-00-00','0000-00-00',0,8,'',0,1),(9,'阅读理解','高考阅读理解冲关',12,3,'0000-00-00','0000-00-00',0,9,'',30,1);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_record`
--

DROP TABLE IF EXISTS `course_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_record` (
  `RECORD_ID` int(11) NOT NULL AUTO_INCREMENT,
  `RECORD_START_TIME` date NOT NULL,
  `RECORD_END_TIME` date NOT NULL,
  `RECORD_GRADE` int(11) DEFAULT NULL,
  `RECORD_FINISH` int(11) NOT NULL,
  `RECORD_COURSE_ID` int(11) DEFAULT NULL,
  `RECORD_STUDENT_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`RECORD_ID`),
  KEY `FK_RECORD_STUDENT` (`RECORD_STUDENT_ID`),
  KEY `FK_RECORD_COURSE` (`RECORD_COURSE_ID`),
  CONSTRAINT `FK_RECORD_COURSE` FOREIGN KEY (`RECORD_COURSE_ID`) REFERENCES `course` (`COURSE_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RECORD_STUDENT` FOREIGN KEY (`RECORD_STUDENT_ID`) REFERENCES `student` (`STUDENT_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_record`
--

LOCK TABLES `course_record` WRITE;
/*!40000 ALTER TABLE `course_record` DISABLE KEYS */;
INSERT INTO `course_record` VALUES (2,'2017-05-10','2017-05-15',9,1,1,1),(3,'2017-04-15','2017-05-15',6,1,1,2),(4,'2017-04-11','2017-04-15',8,1,3,3),(5,'2017-04-15','2017-03-15',11,1,1,4),(6,'2016-06-03','0000-00-00',10,2,3,2);
/*!40000 ALTER TABLE `course_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `course_view`
--

-- DROP TABLE IF EXISTS `course_view`;
DROP VIEW IF EXISTS `course_view`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `course_view` (
  `COURSE_ID` tinyint NOT NULL,
  `COURSE_TITLE` tinyint NOT NULL,
  `COURSE_CONTENT` tinyint NOT NULL,
  `GRADEMARK` tinyint NOT NULL,
  `SUBMARK` tinyint NOT NULL,
  `COURSE_MARK` tinyint NOT NULL,
  `TEACHER_NAME` tinyint NOT NULL,
  `TEACHER_HEADIMG` tinyint NOT NULL
) ENGINE=MyISAM;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `evaluation`
--

DROP TABLE IF EXISTS `evaluation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evaluation` (
  `EVAL_ID` int(11) NOT NULL AUTO_INCREMENT,
  `EVAL_CONTENT` varchar(50) DEFAULT NULL,
  `EVAL_LEVEL` int(11) NOT NULL,
  `EVAL_SEND_TIME` date NOT NULL,
  `EVAL_RECORD_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`EVAL_ID`),
  KEY `FK_EVAL_RECORD` (`EVAL_RECORD_ID`),
  CONSTRAINT `FK_EVAL_RECORD` FOREIGN KEY (`EVAL_RECORD_ID`) REFERENCES `course_record` (`RECORD_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evaluation`
--

LOCK TABLES `evaluation` WRITE;
/*!40000 ALTER TABLE `evaluation` DISABLE KEYS */;
INSERT INTO `evaluation` VALUES (4,'课程讲解详细,通俗易懂',4,'2017-03-15',5),(5,'课程内容充实,学习到很多知识',4,'2017-03-15',2),(6,'一般吧,教的不是很好',2,'2017-03-16',3),(7,'讲解语言幽默,很好理解',4,'2017-03-20',4),(8,'讲的一般般',3,'2015-03-05',3);
/*!40000 ALTER TABLE `evaluation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friend`
--

DROP TABLE IF EXISTS `friend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friend` (
  `friend_id` int(11) NOT NULL,
  `student_id_one` int(11) NOT NULL,
  `student_id_two` int(11) NOT NULL,
  PRIMARY KEY (`friend_id`),
  KEY `fk_friend_1_idx` (`student_id_one`),
  KEY `fk_friend_2_idx` (`student_id_two`),
  CONSTRAINT `fk_friend_1` FOREIGN KEY (`student_id_one`) REFERENCES `student` (`STUDENT_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_friend_2` FOREIGN KEY (`student_id_two`) REFERENCES `student` (`STUDENT_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend`
--

LOCK TABLES `friend` WRITE;
/*!40000 ALTER TABLE `friend` DISABLE KEYS */;
/*!40000 ALTER TABLE `friend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `friend_student_view`
--

-- DROP TABLE IF EXISTS `friend_student_view`;
DROP VIEW IF EXISTS `friend_student_view`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `friend_student_view` (
  `FRIEND_ID` tinyint NOT NULL,
  `STUDENT_ID` tinyint NOT NULL,
  `STUDENT_FRIEND_ID` tinyint NOT NULL,
  `STUDENT_FRIEND_NAME` tinyint NOT NULL,
  `STUDENT_FRIEND_HEADIMG` tinyint NOT NULL
) ENGINE=MyISAM;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `homework`
--

DROP TABLE IF EXISTS `homework`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `homework` (
  `WORK_ID` int(11) NOT NULL AUTO_INCREMENT,
  `WORK_TITLE` varchar(40) DEFAULT NULL,
  `WORK_CONTENT` varchar(200) NOT NULL,
  `WORK_GRADEMARK` int(11) DEFAULT NULL,
  `WORK_SUBMARK` int(11) DEFAULT NULL,
  `WORK_UPTIME` date NOT NULL,
  `WORK_COURSE_ID` int(11) NOT NULL,
  `WORK_ISFINISH` int(11) NOT NULL,
  `STUDENT_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`WORK_ID`),
  KEY `FK_WORK_COURSE` (`WORK_COURSE_ID`),
  KEY `FK_WORK_STUDENT_ID` (`STUDENT_ID`),
  CONSTRAINT `FK_WORK_STUDENT_ID` FOREIGN KEY (`STUDENT_ID`) REFERENCES `student` (`STUDENT_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `homework`
--

LOCK TABLES `homework` WRITE;
/*!40000 ALTER TABLE `homework` DISABLE KEYS */;
INSERT INTO `homework` VALUES (1,'定语从句','翻译下列句子:1.我的叔叔特别爱看书,经常鼓励我们也多看书.',8,3,'2017-05-16',1,1,1),(3,'等腰三角形的证明','如图,请求出多变形的面积.',8,2,'2017-05-10',2,2,2),(4,'议论文','随着技术不断进步,人类越来越懒,一切都交由机器来完成,有人断言机器终将取代人类,请以这则材料为中心写一篇议论文.',10,1,'2017-03-16',3,2,4),(5,'定语从句','翻译下列句子:1.我的叔叔特别爱看书,经常鼓励我们也多看书.',8,3,'2017-05-16',1,1,2),(6,'同位语从句','翻译下列句子:1.我的爸爸,一个喜欢到处旅游的人,去过很多地方.',8,3,'2017-06-16',1,1,2),(7,'等腰三角形的证明','如图,请求出多变形的面积.',8,2,'2017-05-10',2,2,3),(8,'议论文','随着技术不断进步,人类越来越懒,一切都交由机器来完成,有人断言机器终将取代人类,请以这则材料为中心写一篇议论文.',10,1,'2017-03-16',3,1,3);
/*!40000 ALTER TABLE `homework` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `homework_view`
--

-- DROP TABLE IF EXISTS `homework_view`;
DROP VIEW IF EXISTS `homework_view`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `homework_view` (
  `WORK_ID` tinyint NOT NULL,
  `STUDENT_ID` tinyint NOT NULL,
  `WORK_TITLE` tinyint NOT NULL,
  `WORK_SUBMARK` tinyint NOT NULL,
  `WORK_ISFINISH` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `like_view`
--

-- DROP TABLE IF EXISTS `like_view`;
DROP VIEW IF EXISTS `like_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `like_view` (
  `like_message_id` tinyint NOT NULL,
  `message_like` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `MESSAGE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `MESSAGE_TITLE` varchar(40) NOT NULL,
  `MESSAGE_CONTENT` text NOT NULL,
  `MESSAGE_SEND_TIME` date NOT NULL,
  `MESSAGE_MARK` int(11) NOT NULL,
  `COURSE_GRADEMARK` int(11) DEFAULT NULL,
  `COURSE_SUBMARK` int(11) DEFAULT NULL,
  `MESSAGE_SENDER_MARK` int(11) NOT NULL,
  `MESSAGE_SENDER_ID` int(11) NOT NULL,
  `MESSAGE_LIKE` int(11) DEFAULT NULL,
  `MESSAGE_STAR` int(11) DEFAULT NULL,
  PRIMARY KEY (`MESSAGE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,'植物生长的向光性','植物在光的作用下,生长素横向运输,导致向光的一边生长素浓度高,背光的一边生长素浓度低,植物在适宜的生长素浓度下,生长快,导致植物背光处生长快,整体向阳生长','2017-04-18',1,11,6,1,1,NULL,NULL),(2,'钠和水的反应','钠的活泼性强,和水反应激烈,最后生成氢氧化钠和氢气','2017-04-18',1,10,5,2,2,NULL,NULL),(3,'等高线','把地面上海拔高度相同的点连成的闭合曲线，并垂直投影到一个水平面上，并按比例缩绘在图纸上，就得到等高线','2017-04-18',2,10,12,2,1,NULL,NULL),(4,'定语从句','用一个句子来修饰','2017-04-18',1,9,3,2,1,NULL,NULL),(29,'水水水水','添加一条口语课余','2017-09-03',2,7,6,3,1,NULL,NULL),(30,'水水水水','添加一条口语课余','2017-09-03',2,7,6,3,1,NULL,NULL),(31,'呃呃呃','的法国人l8u/kopko','2017-09-03',1,7,2,3,1,NULL,NULL),(32,'呃呃呃','的法国人l8u/kopko','2017-09-03',1,7,2,3,1,NULL,NULL);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER TR_INSERT_MESSAGE
AFTER INSERT ON MESSAGE
FOR EACH ROW
BEGIN
 IF NEW.MESSAGE_MARK=1 THEN
  BEGIN
   IF NOT EXISTS
    (SELECT TEACHER_NAME FROM TEACHER WHERE NEW.MESSAGE_SENDER_ID=TEACHER_ID)
   THEN
    DELETE FROM MESSAGE WHERE MESSAGE_ID=NEW.MESSAGE_ID;
   END IF;
  END;
 ELSE
  BEGIN
   IF NOT EXISTS
    (SELECT * FROM STUDENT WHERE STUDENT_ID=NEW.MESSAGE_SENDER_ID)
   THEN
    DELETE FROM MESSAGE WHERE MESSAGE_ID=NEW.MESSAGE_ID;
   END IF;
  END;
 END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `message_comment`
--

DROP TABLE IF EXISTS `message_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_comment` (
  `COMMENT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `COMMENT_CONTENT` varchar(100) NOT NULL,
  `COMMENT_SEND_TIME` date NOT NULL,
  `COMMENT_SENDER_MARK` int(11) NOT NULL,
  `COMMENT_SENDER_ID` int(11) NOT NULL,
  `COMMENT_ROOT_ID` int(11) NOT NULL,
  `COMMENT_TOCOMMENT_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`COMMENT_ID`),
  KEY `FK_COMMENT_MESSAGE` (`COMMENT_ROOT_ID`),
  KEY `FK_COMMENT_COMMENT` (`COMMENT_TOCOMMENT_ID`),
  CONSTRAINT `FK_COMMENT_COMMENT` FOREIGN KEY (`COMMENT_TOCOMMENT_ID`) REFERENCES `message_comment` (`COMMENT_ID`) ON DELETE SET NULL,
  CONSTRAINT `FK_COMMENT_MESSAGE` FOREIGN KEY (`COMMENT_ROOT_ID`) REFERENCES `message` (`MESSAGE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_comment`
--

LOCK TABLES `message_comment` WRITE;
/*!40000 ALTER TABLE `message_comment` DISABLE KEYS */;
INSERT INTO `message_comment` VALUES (1,'不明白','2017-04-18',1,1,2,1),(2,'受教了','2017-04-18',1,1,3,1),(3,'教的很好','2017-04-18',2,3,2,3),(4,'.....','2017-04-18',2,2,1,2),(9,'讲的一般般','2016-06-03',2,3,2,3);
/*!40000 ALTER TABLE `message_comment` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER TR_INSERT_COMMENT
AFTER INSERT ON MESSAGE_COMMENT
FOR EACH ROW
BEGIN
 IF NEW.COMMENT_SENDER_MARK=1 THEN
  BEGIN
   IF NOT EXISTS
    (SELECT TEACHER_NAME FROM TEACHER WHERE NEW.COMMENT_SENDER_ID=TEACHER_ID)
   THEN
    DELETE FROM MESSAGE_COMMENT WHERE COMMENT_ID=NEW.COMMENT_ID;
   END IF;
  END;
 ELSE
  BEGIN
   IF NOT EXISTS
    (SELECT STUDENT_NAME FROM STUDENT WHERE NEW.COMMENT_SENDER_ID=STUDENT_ID)
   THEN
    DELETE FROM MESSAGE_COMMENT WHERE COMMENT_ID=NEW.COMMENT_ID;
   END IF;
  END;
 END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `message_comment_view`
--

DROP TABLE IF EXISTS `message_comment_view`;
DROP VIEW IF EXISTS `message_comment_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `message_comment_view` (
  `COMMENT_ID` tinyint NOT NULL,
  `COMMENT_CONTENT` tinyint NOT NULL,
  `COMMENT_SEND_TIME` tinyint NOT NULL,
  `COMMENT_SENDER_ID` tinyint NOT NULL,
  `COMMENT_SENDER_MARK` tinyint NOT NULL,
  `COMMENT_TOCOMMENT_ID` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `message_info_view`
--

DROP TABLE IF EXISTS `message_info_view`;
DROP VIEW IF EXISTS `message_info_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `message_info_view` (
  `id` tinyint NOT NULL,
  `title` tinyint NOT NULL,
  `content` tinyint NOT NULL,
  `send_time` tinyint NOT NULL,
  `message_mark` tinyint NOT NULL,
  `course_grademark` tinyint NOT NULL,
  `course_submark` tinyint NOT NULL,
  `sender_id` tinyint NOT NULL,
  `sender_mark` tinyint NOT NULL,
  `message_like` tinyint NOT NULL,
  `message_star` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `message_like`
--

DROP TABLE IF EXISTS `message_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_like` (
  `LIKE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_MARK` int(11) NOT NULL,
  `LIKE_MESSAGE_ID` int(11) DEFAULT NULL,
  `LIKE_USER_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`LIKE_ID`),
  KEY `FK_LIKE_STUDENT` (`LIKE_USER_ID`),
  KEY `FK_LIKE_MESSAGE` (`LIKE_MESSAGE_ID`),
  CONSTRAINT `FK_LIKE_MESSAGE` FOREIGN KEY (`LIKE_MESSAGE_ID`) REFERENCES `message` (`MESSAGE_ID`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `FK_LIKE_STUDENT` FOREIGN KEY (`LIKE_USER_ID`) REFERENCES `student` (`STUDENT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_like`
--

LOCK TABLES `message_like` WRITE;
/*!40000 ALTER TABLE `message_like` DISABLE KEYS */;
INSERT INTO `message_like` VALUES (1,1,1,1),(2,2,2,2),(3,1,3,3),(4,2,4,4),(5,2,4,NULL),(6,2,3,3);
/*!40000 ALTER TABLE `message_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_star`
--

DROP TABLE IF EXISTS `message_star`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_star` (
  `STAR_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_MARK` int(11) NOT NULL,
  `STAR_MESSAGE_ID` int(11) DEFAULT NULL,
  `STAR_USER_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`STAR_ID`),
  KEY `FK_MARK_MESSAGE` (`STAR_MESSAGE_ID`),
  KEY `FK_MARK_STUDENT` (`STAR_USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_star`
--

LOCK TABLES `message_star` WRITE;
/*!40000 ALTER TABLE `message_star` DISABLE KEYS */;
INSERT INTO `message_star` VALUES (1,1,1,1),(2,2,2,2),(3,2,3,3),(4,2,4,4),(5,2,3,3);
/*!40000 ALTER TABLE `message_star` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `message_teacher_view`
--

DROP TABLE IF EXISTS `message_teacher_view`;
DROP VIEW IF EXISTS `message_teacher_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `message_teacher_view` (
  `MESSAGE_ID` tinyint NOT NULL,
  `HEADIMG` tinyint NOT NULL,
  `TEACHER_NAME` tinyint NOT NULL,
  `MESSAGE_TITLE` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `message_view`
--

DROP TABLE IF EXISTS `message_view`;
DROP VIEW IF EXISTS `message_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `message_view` (
  `MESSAGE_ID` tinyint NOT NULL,
  `MESSAGE_TITLE` tinyint NOT NULL,
  `SEND_TIME` tinyint NOT NULL,
  `MESSAGE_MARK` tinyint NOT NULL,
  `SENDER_ID` tinyint NOT NULL,
  `SENDER_MARK` tinyint NOT NULL,
  `MESSAGE_LIKE` tinyint NOT NULL,
  `MESSAGE_STAR` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `messagecomment_student_view`
--

DROP TABLE IF EXISTS `messagecomment_student_view`;
DROP VIEW IF EXISTS `messagecomment_student_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `messagecomment_student_view` (
  `COMMENT_ID` tinyint NOT NULL,
  `STUDENT_NAME` tinyint NOT NULL,
  `COMMENT_CONTENT` tinyint NOT NULL,
  `COMMENT_SEND_TIME` tinyint NOT NULL,
  `COMMENT_ROOT_ID` tinyint NOT NULL,
  `COMMENT_TOCOMMENT_ID` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `micro_course_message`
--

DROP TABLE IF EXISTS `micro_course_message`;
DROP VIEW IF EXISTS `micro_course_message`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `micro_course_message` (
  `COURSE_id` tinyint NOT NULL,
  `COURSE_title` tinyint NOT NULL,
  `COURSE_VEDIO` tinyint NOT NULL,
  `course_content` tinyint NOT NULL,
  `GRADE` tinyint NOT NULL,
  `SUBMARK` tinyint NOT NULL,
  `COURSE_MARK` tinyint NOT NULL,
  `TEACHER_NAME` tinyint NOT NULL,
  `HEADIMG` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `record_course_view`
--

DROP TABLE IF EXISTS `record_course_view`;
DROP VIEW IF EXISTS `record_course_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `record_course_view` (
  `RECORD_ID` tinyint NOT NULL,
  `COURSE_TITLE` tinyint NOT NULL,
  `COURSE_CONTENT` tinyint NOT NULL,
  `TEACHER_NAME` tinyint NOT NULL,
  `RECORD_FINISH` tinyint NOT NULL,
  `STUDENT_ID` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `star_view`
--

DROP TABLE IF EXISTS `star_view`;
DROP VIEW IF EXISTS `star_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `star_view` (
  `star_message_id` tinyint NOT NULL,
  `message_star` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `student`
--

--
-- Temporary table structure for view `student_evaluation_view`
--

DROP TABLE IF EXISTS `student_evaluation_view`;
DROP VIEW IF EXISTS `student_evaluation_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `student_evaluation_view` (
  `EVAL_ID` tinyint NOT NULL,
  `STUDENT_NAME` tinyint NOT NULL,
  `EVAL_CONTENT` tinyint NOT NULL,
  `EVAL_SEND_TIME` tinyint NOT NULL,
  `RECORD_COURSE_ID` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `student_note`
--

DROP TABLE IF EXISTS `student_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_note` (
  `NOTE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `NOTE_TITLE` varchar(30) DEFAULT NULL,
  `CONTENT` varchar(400) NOT NULL,
  `GRADEMARK` int(11) DEFAULT NULL,
  `NOTE_SUBMARK` int(11) DEFAULT NULL,
  `NOTE_SET_TIME` date NOT NULL,
  `COURSE_ID` int(11) DEFAULT NULL,
  `STUDENT_ID` int(11) NOT NULL,
  PRIMARY KEY (`NOTE_ID`),
  KEY `FK_NOTE_STUDENT` (`STUDENT_ID`),
  KEY `FK_NOTE_COURSE` (`COURSE_ID`),
  CONSTRAINT `FK_NOTE_COURSE` FOREIGN KEY (`COURSE_ID`) REFERENCES `course` (`COURSE_ID`) ON DELETE SET NULL,
  CONSTRAINT `FK_NOTE_STUDENT` FOREIGN KEY (`STUDENT_ID`) REFERENCES `student` (`STUDENT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_note`
--

LOCK TABLES `student_note` WRITE;
/*!40000 ALTER TABLE `student_note` DISABLE KEYS */;
INSERT INTO `student_note` VALUES (1,'植物生长素','植物生长素的极性传输',11,12,'2017-04-19',1,2),(2,'光合作用','植物的叶绿素作用下,结合二氧化碳,水发生光合作用,产生葡淀粉',11,12,'2017-04-19',1,2),(3,'碳酸钠和二氧化碳反应','碳酸钠和二氧化碳反应生产碳酸氢钠和水',11,11,'2017-04-19',NULL,3),(4,'定语从句','修饰名词',9,3,'2017-04-19',1,2),(5,'','讲的一般般',10,3,'2016-06-03',3,2),(8,'','植物生',0,0,'2017-05-26',1,1);
/*!40000 ALTER TABLE `student_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `student_note_view`
--

DROP TABLE IF EXISTS `student_note_view`;
DROP VIEW IF EXISTS `student_note_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `student_note_view` (
  `NOTE_ID` tinyint NOT NULL,
  `NOTE_TITLE` tinyint NOT NULL,
  `NOTE_CONTENT` tinyint NOT NULL,
  `NOTE_SET_TIME` tinyint NOT NULL,
  `NOTE_STUDENT_ID` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `student_work`
--

DROP TABLE IF EXISTS `student_work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_work` (
  `STUDENTWORK_ID` int(11) NOT NULL AUTO_INCREMENT,
  `STUDENTWORK_CONTENT` varchar(200) NOT NULL,
  `STUDENTWORK_UPTIME` date NOT NULL,
  `STUDENTWORK_FINISH` int(11) NOT NULL,
  `STUDENTWORK_HOMEWORK_ID` int(11) NOT NULL,
  PRIMARY KEY (`STUDENTWORK_ID`),
  KEY `FK_STUDNETWORK_HOMEWORK` (`STUDENTWORK_HOMEWORK_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_work`
--

LOCK TABLES `student_work` WRITE;
/*!40000 ALTER TABLE `student_work` DISABLE KEYS */;
INSERT INTO `student_work` VALUES (1,'植物生长素','2017-04-19',1,5),(2,'光合作用','2017-04-19',1,3),(3,'等腰三角形','2017-04-19',1,1),(4,'定语从句','2017-04-20',0,4),(5,'植物生长素','2017-04-19',1,6),(6,'光合作用','2017-04-19',1,7),(7,'等腰三角形','2017-04-19',1,8);
/*!40000 ALTER TABLE `student_work` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `studentview`
--

DROP TABLE IF EXISTS `studentview`;
DROP VIEW IF EXISTS `studentview`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `studentview` (
  `STUDENT_ID` tinyint NOT NULL,
  `STUDENT_NAME` tinyint NOT NULL,
  `STUDENT_HEADIMG` tinyint NOT NULL,
  `GENDER` tinyint NOT NULL,
  `SUBJECT_MARK` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `studentwork_homework_finish_view`
--

DROP TABLE IF EXISTS `studentwork_homework_finish_view`;
DROP VIEW IF EXISTS `studentwork_homework_finish_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `studentwork_homework_finish_view` (
  `WORK_ID` tinyint NOT NULL,
  `STUDENT_ID` tinyint NOT NULL,
  `WORK_TITLE` tinyint NOT NULL,
  `WORK_CONTENT` tinyint NOT NULL,
  `WORK_UPTIME` tinyint NOT NULL,
  `WORK_answer` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `studentwork_homework_unfinish_view`
--

DROP TABLE IF EXISTS `studentwork_homework_unfinish_view`;
DROP VIEW IF EXISTS `studentwork_homework_unfinish_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `studentwork_homework_unfinish_view` (
  `WORK_ID` tinyint NOT NULL,
  `STUDENT_ID` tinyint NOT NULL,
  `WORK_TITLE` tinyint NOT NULL,
  `WORK_CONTENT` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `study_plan`
--

DROP TABLE IF EXISTS `study_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `study_plan` (
  `PLAN_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PLAN_TITLE` varchar(30) DEFAULT NULL,
  `PLAN_CONTENT` varchar(200) NOT NULL,
  `PLAN_SET_TIME` date NOT NULL,
  `STUDENT_ID` int(11) NOT NULL,
  PRIMARY KEY (`PLAN_ID`),
  KEY `FK_PLAN_STUDENT` (`STUDENT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `study_plan`
--

LOCK TABLES `study_plan` WRITE;
/*!40000 ALTER TABLE `study_plan` DISABLE KEYS */;
INSERT INTO `study_plan` VALUES (1,'写作','今日完成英语写作一篇','2017-02-03',1),(2,'阅读','上午完成阅读理解三篇','2017-02-08',2),(3,'背诵','周三之前背好<虞美人>','2017-03-03',3),(4,'计算','今天做20道分解因式','2017-02-11',4),(5,'证明','今日学习证明等腰三角形','2017-02-23',5),(6,'','讲的一般般','2016-06-03',6);
/*!40000 ALTER TABLE `study_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES (4,'bourn','1234536@qq.com','223344','',1,'13456845923','广州市天河区中山大道56号','讲课简单易懂，平易近人。','445692157894582684',5,4),(6,'hobor','123456@qq.com','223344','',1,'13456859523','广州市天河区中山大道17号','讲课简单易懂，平易近人。','445692157896325684',2,1),(7,'hawking','123456@qq.com','223344','',1,'13412369523','广州市天河区中山大道15号','讲课简单易懂，平易近人。','445692157452825684',3,2),(8,'eris','123456@qq.com','223344','',2,'13456875123','广州市天河区天河城大道21号','讲课简单易懂，平易近人。','445692157846325684',4,3),(9,'bourn','123456@qq.com','223344','',1,'13456845923','广州市天河区中山大道56号','讲课简单易懂，平易近人。','445692157894582684',5,4),(10,'jam','123456@qq.com','223344','',2,'13456452123','广州市天河区锦绣小区43栋','讲课简单易懂，平易近人。','445692157899658684',6,5);
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `teacher_course_eval_view`
--

DROP TABLE IF EXISTS `teacher_course_eval_view`;
DROP VIEW IF EXISTS `teacher_course_eval_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `teacher_course_eval_view` (
  `EVAL_ID` tinyint NOT NULL,
  `EVAL_CONTENT` tinyint NOT NULL,
  `EVAL_LEVEL` tinyint NOT NULL,
  `course_id` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `teacher_message`
--

DROP TABLE IF EXISTS `teacher_message`;
DROP VIEW IF EXISTS `teacher_message`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `teacher_message` (
  `TEACHER_ID` tinyint NOT NULL,
  `TEACHER_NAME` tinyint NOT NULL,
  `HEADIMG` tinyint NOT NULL,
  `TELEPHONE` tinyint NOT NULL,
  `ADDRESS` tinyint NOT NULL,
  `INTRODUCE` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `teacher_view`
--

DROP TABLE IF EXISTS `teacher_view`;
DROP VIEW IF EXISTS `teacher_view`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `teacher_view` (
  `TEACHER_ID` tinyint NOT NULL,
  `HEADIMG` tinyint NOT NULL,
  `TEACHER_NAME` tinyint NOT NULL,
  `INTRODUCE` tinyint NOT NULL,
  `SUB_MARK` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `webcast_course_message`
--

DROP TABLE IF EXISTS `webcast_course_message`;
DROP VIEW IF EXISTS `webcast_course_message`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `webcast_course_message` (
  `COURSE_id` tinyint NOT NULL,
  `COURSE_VEDIO` tinyint NOT NULL,
  `COURSE_TITLE` tinyint NOT NULL,
  `COURSE_CONTENT` tinyint NOT NULL,
  `GRADE` tinyint NOT NULL,
  `SUBMARK` tinyint NOT NULL,
  `COURSE_MARK` tinyint NOT NULL,
  `COURSE_START_TIME` tinyint NOT NULL,
  `COURSE_END_TIME` tinyint NOT NULL,
  `COURSE_FEE` tinyint NOT NULL,
  `TEACHER_NAME` tinyint NOT NULL,
  `HEADIMG` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'excellent_education'
--

--
-- Dumping routines for database 'excellent_education'
--

--
-- Final view structure for view `course_view`
--

/*!50001 DROP TABLE IF EXISTS `course_view`*/;
/*!50001 DROP VIEW IF EXISTS `course_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `course_view` AS select `course`.`COURSE_ID` AS `COURSE_ID`,`course`.`COURSE_TITLE` AS `COURSE_TITLE`,`course`.`COURSE_CONTENT` AS `COURSE_CONTENT`,`course`.`COURSE_GRADEMARK` AS `GRADEMARK`,`course`.`COURSE_SUBMARK` AS `SUBMARK`,`course`.`COURSE_MARK` AS `COURSE_MARK`,`teacher`.`TEACHER_NAME` AS `TEACHER_NAME`,`teacher`.`HEADIMG` AS `TEACHER_HEADIMG` from (`course` join `teacher`) where (`course`.`COURSE_TEACHER_ID` = `teacher`.`TEACHER_ID`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `friend_student_view`
--

/*!50001 DROP TABLE IF EXISTS `friend_student_view`*/;
/*!50001 DROP VIEW IF EXISTS `friend_student_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `friend_student_view` AS select `friend`.`friend_id` AS `FRIEND_ID`,`friend`.`student_id_one` AS `STUDENT_ID`,`student`.`STUDENT_ID` AS `STUDENT_FRIEND_ID`,`student`.`STUDENT_NAME` AS `STUDENT_FRIEND_NAME`,`student`.`HEADIMG` AS `STUDENT_FRIEND_HEADIMG` from (`friend` join `student`) where (`friend`.`student_id_two` = `student`.`STUDENT_ID`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `homework_view`
--

/*!50001 DROP TABLE IF EXISTS `homework_view`*/;
/*!50001 DROP VIEW IF EXISTS `homework_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `homework_view` AS select `homework`.`WORK_ID` AS `WORK_ID`,`homework`.`STUDENT_ID` AS `STUDENT_ID`,`homework`.`WORK_TITLE` AS `WORK_TITLE`,`homework`.`WORK_SUBMARK` AS `WORK_SUBMARK`,`homework`.`WORK_ISFINISH` AS `WORK_ISFINISH` from `homework` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `like_view`
--

/*!50001 DROP TABLE IF EXISTS `like_view`*/;
/*!50001 DROP VIEW IF EXISTS `like_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `like_view` AS select `message`.`MESSAGE_ID` AS `like_message_id`,count(`message_like`.`LIKE_ID`) AS `message_like` from (`message` join `message_like`) where (`message`.`MESSAGE_ID` = `message_like`.`LIKE_MESSAGE_ID`) group by `message`.`MESSAGE_ID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `message_comment_view`
--

/*!50001 DROP TABLE IF EXISTS `message_comment_view`*/;
/*!50001 DROP VIEW IF EXISTS `message_comment_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `message_comment_view` AS select `message_comment`.`COMMENT_ID` AS `COMMENT_ID`,`message_comment`.`COMMENT_CONTENT` AS `COMMENT_CONTENT`,`message_comment`.`COMMENT_SEND_TIME` AS `COMMENT_SEND_TIME`,`message_comment`.`COMMENT_SENDER_ID` AS `COMMENT_SENDER_ID`,`message_comment`.`COMMENT_SENDER_MARK` AS `COMMENT_SENDER_MARK`,`message_comment`.`COMMENT_TOCOMMENT_ID` AS `COMMENT_TOCOMMENT_ID` from (`message_comment` join `message`) where (`message`.`MESSAGE_ID` = `message_comment`.`COMMENT_TOCOMMENT_ID`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `message_info_view`
--

/*!50001 DROP TABLE IF EXISTS `message_info_view`*/;
/*!50001 DROP VIEW IF EXISTS `message_info_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `message_info_view` AS select `message`.`MESSAGE_ID` AS `id`,`message`.`MESSAGE_TITLE` AS `title`,`message`.`MESSAGE_CONTENT` AS `content`,`message`.`MESSAGE_SEND_TIME` AS `send_time`,`message`.`MESSAGE_MARK` AS `message_mark`,`message`.`COURSE_GRADEMARK` AS `course_grademark`,`message`.`COURSE_SUBMARK` AS `course_submark`,`message`.`MESSAGE_SENDER_ID` AS `sender_id`,`message`.`MESSAGE_SENDER_MARK` AS `sender_mark`,`like_view`.`message_like` AS `message_like`,`star_view`.`message_star` AS `message_star` from ((`message` join `star_view`) join `like_view`) where ((`message`.`MESSAGE_ID` = `like_view`.`like_message_id`) and (`message`.`MESSAGE_ID` = `star_view`.`star_message_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `message_teacher_view`
--

/*!50001 DROP TABLE IF EXISTS `message_teacher_view`*/;
/*!50001 DROP VIEW IF EXISTS `message_teacher_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `message_teacher_view` AS select `message`.`MESSAGE_ID` AS `MESSAGE_ID`,`teacher`.`HEADIMG` AS `HEADIMG`,`teacher`.`TEACHER_NAME` AS `TEACHER_NAME`,`message`.`MESSAGE_TITLE` AS `MESSAGE_TITLE` from (`message` join `teacher`) where (`message`.`MESSAGE_SENDER_ID` = `teacher`.`TEACHER_ID`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `message_view`
--

/*!50001 DROP TABLE IF EXISTS `message_view`*/;
/*!50001 DROP VIEW IF EXISTS `message_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `message_view` AS select `message`.`MESSAGE_ID` AS `MESSAGE_ID`,`message`.`MESSAGE_TITLE` AS `MESSAGE_TITLE`,`message`.`MESSAGE_SEND_TIME` AS `SEND_TIME`,`message`.`MESSAGE_MARK` AS `MESSAGE_MARK`,`message`.`MESSAGE_SENDER_ID` AS `SENDER_ID`,`message`.`MESSAGE_SENDER_MARK` AS `SENDER_MARK`,`message`.`MESSAGE_LIKE` AS `MESSAGE_LIKE`,`message`.`MESSAGE_STAR` AS `MESSAGE_STAR` from `message` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `messagecomment_student_view`
--

/*!50001 DROP TABLE IF EXISTS `messagecomment_student_view`*/;
/*!50001 DROP VIEW IF EXISTS `messagecomment_student_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `messagecomment_student_view` AS select `message_comment`.`COMMENT_ID` AS `COMMENT_ID`,`student`.`STUDENT_NAME` AS `STUDENT_NAME`,`message_comment`.`COMMENT_CONTENT` AS `COMMENT_CONTENT`,`message_comment`.`COMMENT_SEND_TIME` AS `COMMENT_SEND_TIME`,`message_comment`.`COMMENT_ROOT_ID` AS `COMMENT_ROOT_ID`,`message_comment`.`COMMENT_TOCOMMENT_ID` AS `COMMENT_TOCOMMENT_ID` from (`message_comment` join `student`) where (`message_comment`.`COMMENT_SENDER_ID` = `student`.`STUDENT_ID`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `micro_course_message`
--

/*!50001 DROP TABLE IF EXISTS `micro_course_message`*/;
/*!50001 DROP VIEW IF EXISTS `micro_course_message`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `micro_course_message` AS select `course`.`COURSE_ID` AS `COURSE_id`,`course`.`COURSE_TITLE` AS `COURSE_title`,`course`.`COURSE_VEDIO` AS `COURSE_VEDIO`,`course`.`COURSE_CONTENT` AS `course_content`,`course`.`COURSE_GRADEMARK` AS `GRADE`,`course`.`COURSE_SUBMARK` AS `SUBMARK`,`course`.`COURSE_MARK` AS `COURSE_MARK`,`teacher`.`TEACHER_NAME` AS `TEACHER_NAME`,`teacher`.`HEADIMG` AS `HEADIMG` from (`teacher` join `course`) where ((`course`.`COURSE_TEACHER_ID` = `teacher`.`TEACHER_ID`) and (`course`.`COURSE_MARK` = 1)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `record_course_view`
--

/*!50001 DROP TABLE IF EXISTS `record_course_view`*/;
/*!50001 DROP VIEW IF EXISTS `record_course_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `record_course_view` AS select `course_record`.`RECORD_ID` AS `RECORD_ID`,`course`.`COURSE_TITLE` AS `COURSE_TITLE`,`course`.`COURSE_CONTENT` AS `COURSE_CONTENT`,`teacher`.`TEACHER_NAME` AS `TEACHER_NAME`,`course_record`.`RECORD_FINISH` AS `RECORD_FINISH`,`student`.`STUDENT_ID` AS `STUDENT_ID` from (((`course` join `course_record`) join `teacher`) join `student`) where ((`course_record`.`RECORD_COURSE_ID` = `course`.`COURSE_ID`) and (`course_record`.`RECORD_STUDENT_ID` = `student`.`STUDENT_ID`) and (`course`.`COURSE_TEACHER_ID` = `teacher`.`TEACHER_ID`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `star_view`
--

/*!50001 DROP TABLE IF EXISTS `star_view`*/;
/*!50001 DROP VIEW IF EXISTS `star_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `star_view` AS select `message`.`MESSAGE_ID` AS `star_message_id`,count(`message_star`.`STAR_ID`) AS `message_star` from (`message` join `message_star`) where (`message`.`MESSAGE_ID` = `message_star`.`STAR_MESSAGE_ID`) group by `message`.`MESSAGE_ID` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `student_evaluation_view`
--

/*!50001 DROP TABLE IF EXISTS `student_evaluation_view`*/;
/*!50001 DROP VIEW IF EXISTS `student_evaluation_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `student_evaluation_view` AS select `evaluation`.`EVAL_ID` AS `EVAL_ID`,`student`.`STUDENT_NAME` AS `STUDENT_NAME`,`evaluation`.`EVAL_CONTENT` AS `EVAL_CONTENT`,`evaluation`.`EVAL_SEND_TIME` AS `EVAL_SEND_TIME`,`course_record`.`RECORD_COURSE_ID` AS `RECORD_COURSE_ID` from ((`evaluation` join `student`) join `course_record`) where ((`evaluation`.`EVAL_RECORD_ID` = `course_record`.`RECORD_ID`) and (`course_record`.`RECORD_STUDENT_ID` = `student`.`STUDENT_ID`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `student_note_view`
--

/*!50001 DROP TABLE IF EXISTS `student_note_view`*/;
/*!50001 DROP VIEW IF EXISTS `student_note_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `student_note_view` AS select `student_note`.`NOTE_ID` AS `NOTE_ID`,`student_note`.`NOTE_TITLE` AS `NOTE_TITLE`,`student_note`.`CONTENT` AS `NOTE_CONTENT`,`student_note`.`NOTE_SET_TIME` AS `NOTE_SET_TIME`,`student`.`STUDENT_ID` AS `NOTE_STUDENT_ID` from (`student_note` join `student`) where (`student_note`.`STUDENT_ID` = `student`.`STUDENT_ID`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `studentview`
--

/*!50001 DROP TABLE IF EXISTS `studentview`*/;
/*!50001 DROP VIEW IF EXISTS `studentview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `studentview` AS select `student`.`STUDENT_ID` AS `STUDENT_ID`,`student`.`STUDENT_NAME` AS `STUDENT_NAME`,`student`.`HEADIMG` AS `STUDENT_HEADIMG`,`student`.`GENDER` AS `GENDER`,`student`.`SUBJECT_MARK` AS `SUBJECT_MARK` from `student` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `studentwork_homework_finish_view`
--

/*!50001 DROP TABLE IF EXISTS `studentwork_homework_finish_view`*/;
/*!50001 DROP VIEW IF EXISTS `studentwork_homework_finish_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `studentwork_homework_finish_view` AS select `homework`.`WORK_ID` AS `WORK_ID`,`homework`.`STUDENT_ID` AS `STUDENT_ID`,`homework`.`WORK_TITLE` AS `WORK_TITLE`,`homework`.`WORK_CONTENT` AS `WORK_CONTENT`,`homework`.`WORK_UPTIME` AS `WORK_UPTIME`,`student_work`.`STUDENTWORK_CONTENT` AS `WORK_answer` from (`homework` join `student_work`) where ((`homework`.`WORK_ISFINISH` = 1) and (`homework`.`WORK_ID` = `student_work`.`STUDENTWORK_HOMEWORK_ID`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `studentwork_homework_unfinish_view`
--

/*!50001 DROP TABLE IF EXISTS `studentwork_homework_unfinish_view`*/;
/*!50001 DROP VIEW IF EXISTS `studentwork_homework_unfinish_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `studentwork_homework_unfinish_view` AS select `homework`.`WORK_ID` AS `WORK_ID`,`homework`.`STUDENT_ID` AS `STUDENT_ID`,`homework`.`WORK_TITLE` AS `WORK_TITLE`,`homework`.`WORK_CONTENT` AS `WORK_CONTENT` from `homework` where (`homework`.`WORK_ISFINISH` = 2) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `teacher_course_eval_view`
--

/*!50001 DROP TABLE IF EXISTS `teacher_course_eval_view`*/;
/*!50001 DROP VIEW IF EXISTS `teacher_course_eval_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `teacher_course_eval_view` AS select `evaluation`.`EVAL_ID` AS `EVAL_ID`,`evaluation`.`EVAL_CONTENT` AS `EVAL_CONTENT`,`evaluation`.`EVAL_LEVEL` AS `EVAL_LEVEL`,`course`.`COURSE_ID` AS `course_id` from (((`evaluation` join `teacher`) join `course`) join `course_record`) where ((`course_record`.`RECORD_COURSE_ID` = `course`.`COURSE_ID`) and (`course`.`COURSE_TEACHER_ID` = `teacher`.`TEACHER_ID`) and (`evaluation`.`EVAL_RECORD_ID` = `course_record`.`RECORD_ID`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `teacher_message`
--

/*!50001 DROP TABLE IF EXISTS `teacher_message`*/;
/*!50001 DROP VIEW IF EXISTS `teacher_message`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `teacher_message` AS select `teacher`.`TEACHER_ID` AS `TEACHER_ID`,`teacher`.`TEACHER_NAME` AS `TEACHER_NAME`,`teacher`.`HEADIMG` AS `HEADIMG`,`teacher`.`TELEPHONE` AS `TELEPHONE`,`teacher`.`ADDRESS` AS `ADDRESS`,`teacher`.`INTRODUCE` AS `INTRODUCE` from `teacher` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `teacher_view`
--

/*!50001 DROP TABLE IF EXISTS `teacher_view`*/;
/*!50001 DROP VIEW IF EXISTS `teacher_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `teacher_view` AS select `teacher`.`TEACHER_ID` AS `TEACHER_ID`,`teacher`.`HEADIMG` AS `HEADIMG`,`teacher`.`TEACHER_NAME` AS `TEACHER_NAME`,`teacher`.`INTRODUCE` AS `INTRODUCE`,`teacher`.`SUB_MARK` AS `SUB_MARK` from `teacher` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `webcast_course_message`
--

/*!50001 DROP TABLE IF EXISTS `webcast_course_message`*/;
/*!50001 DROP VIEW IF EXISTS `webcast_course_message`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `webcast_course_message` AS select `course`.`COURSE_ID` AS `COURSE_id`,`course`.`COURSE_VEDIO` AS `COURSE_VEDIO`,`course`.`COURSE_TITLE` AS `COURSE_TITLE`,`course`.`COURSE_CONTENT` AS `COURSE_CONTENT`,`course`.`COURSE_GRADEMARK` AS `GRADE`,`course`.`COURSE_SUBMARK` AS `SUBMARK`,`course`.`COURSE_MARK` AS `COURSE_MARK`,`course`.`COURSE_START_TIME` AS `COURSE_START_TIME`,`course`.`COURSE_END_TIME` AS `COURSE_END_TIME`,`course`.`COURSE_FEE` AS `COURSE_FEE`,`teacher`.`TEACHER_NAME` AS `TEACHER_NAME`,`teacher`.`HEADIMG` AS `HEADIMG` from (`teacher` join `course`) where ((`course`.`COURSE_TEACHER_ID` = `teacher`.`TEACHER_ID`) and (`course`.`COURSE_MARK` = 2)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-09-04 13:30:13
