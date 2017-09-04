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
  CONSTRAINT `FK_CAREER_TEACHER` FOREIGN KEY (`EVAL_TEACHER_ID`) REFERENCES `course_record` (`TEACHER_ID`) ON DELETE CASCADE ON UPDATE CASCADE
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;



DROP TABLE IF EXISTS `certification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `certification` (
  `CER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CER_TITLE` varchar(50) NOT NULL,
  `CER_TEACHER_ID` int(11) NOT NULL,
  PRIMARY KEY (`CER_ID`),
  CONSTRAINT `FK_CERT_TEACHER` FOREIGN KEY (`EVAL_TEACHER_ID`) REFERENCES `course_record` (`TEACHER_ID`) ON DELETE CASCADE ON UPDATE CASCADE
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;



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
  CONSTRAINT `FK_EVAL_RECORD` FOREIGN KEY (`EVAL_RECORD_ID`) REFERENCES `course_record` (`RECORD_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;



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
  CONSTRAINT `FK_RECORD_COURSE` FOREIGN KEY (`RECORD_COURSE_ID`) REFERENCES `course` (`COURSE_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RECORD_STUDENT` FOREIGN KEY (`RECORD_STUDENT_ID`) REFERENCES `student` (`STUDENT_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


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
  CONSTRAINT `FK_COURSE_TEACHER` FOREIGN KEY (`COURSE_TEACHER_ID`) REFERENCES `teacher` (`TEACHER_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Dumping data for table `course_record`
--

LOCK TABLES `course_record` WRITE;
/*!40000 ALTER TABLE `course_record` DISABLE KEYS */;
INSERT INTO `course_record` VALUES (2,'2017-05-10','2017-05-15',9,1,1,1),(3,'2017-04-15','2017-05-15',6,1,1,2),(4,'2017-04-11','2017-04-15',8,1,3,3),(5,'2017-04-15','2017-03-15',11,1,1,4),(6,'2016-06-03','0000-00-00',10,2,3,2);
/*!40000 ALTER TABLE `course_record` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Dumping data for table `evaluation`
--

LOCK TABLES `evaluation` WRITE;
/*!40000 ALTER TABLE `evaluation` DISABLE KEYS */;
INSERT INTO `evaluation` VALUES (4,'课程讲解详细,通俗易懂',4,'2017-03-15',5),(5,'课程内容充实,学习到很多知识',4,'2017-03-15',2),(6,'一般吧,教的不是很好',2,'2017-03-16',3),(7,'讲解语言幽默,很好理解',4,'2017-03-20',4),(8,'讲的一般般',3,'2015-03-05',3);
/*!40000 ALTER TABLE `evaluation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;



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
  CONSTRAINT `FK_COMMENT_COMMENT` FOREIGN KEY (`COMMENT_TOCOMMENT_ID`) REFERENCES `message_comment` (`COMMENT_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_COMMENT_MESSAGE` FOREIGN KEY (`COMMENT_ROOT_ID`) REFERENCES `message` (`MESSAGE_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;



DROP TABLE IF EXISTS `message_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_like` (
  `LIKE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_MARK` int(11) NOT NULL,
  `LIKE_MESSAGE_ID` int(11) DEFAULT NULL,
  `LIKE_USER_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`LIKE_ID`),
  CONSTRAINT `FK_LIKE_MESSAGE` FOREIGN KEY (`LIKE_MESSAGE_ID`) REFERENCES `message` (`MESSAGE_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_LIKE_STUDENT` FOREIGN KEY (`LIKE_USER_ID`) REFERENCES `student` (`STUDENT_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;



DROP TABLE IF EXISTS `message_star`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_star` (
  `STAR_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_MARK` int(11) NOT NULL,
  `STAR_MESSAGE_ID` int(11) DEFAULT NULL,
  `STAR_USER_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`STAR_ID`),
  CONSTRAINT `FK_STAR_MESSAGE` FOREIGN KEY (`STAR_MESSAGE_ID`) REFERENCES `message` (`MESSAGE_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_STAR_STUDENT` FOREIGN KEY (`STAR_USER_ID`) REFERENCES `student` (`STUDENT_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;



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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,'植物生长的向光性','植物在光的作用下,生长素横向运输,导致向光的一边生长素浓度高,背光的一边生长素浓度低,植物在适宜的生长素浓度下,生长快,导致植物背光处生长快,整体向阳生长','2017-04-18',1,11,6,1,1,NULL,NULL),(2,'钠和水的反应','钠的活泼性强,和水反应激烈,最后生成氢氧化钠和氢气','2017-04-18',1,10,5,2,2,NULL,NULL),(3,'等高线','把地面上海拔高度相同的点连成的闭合曲线，并垂直投影到一个水平面上，并按比例缩绘在图纸上，就得到等高线','2017-04-18',2,10,12,2,1,NULL,NULL),(4,'定语从句','用一个句子来修饰','2017-04-18',1,9,3,2,1,NULL,NULL),(29,'水水水水','添加一条口语课余','2017-09-03',2,7,6,3,1,NULL,NULL),(31,'呃呃呃','的法国人l8u/kopko','2017-09-03',1,7,2,3,1,NULL,NULL),(32,'呃呃呃','的法国人l8u/kopko','2017-09-03',1,7,2,3,1,NULL,NULL);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `message_comment`
--

LOCK TABLES `message_comment` WRITE;
/*!40000 ALTER TABLE `message_comment` DISABLE KEYS */;
INSERT INTO `message_comment` VALUES (1,'不明白','2017-04-18',1,1,2,1),(2,'受教了','2017-04-18',1,1,3,1),(3,'教的很好','2017-04-18',2,3,2,3),(4,'.....','2017-04-18',2,2,1,2),(9,'讲的一般般','2016-06-03',2,3,2,3);
/*!40000 ALTER TABLE `message_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `message_like`
--

LOCK TABLES `message_like` WRITE;
/*!40000 ALTER TABLE `message_like` DISABLE KEYS */;
INSERT INTO `message_like` VALUES (1,1,1,1),(2,2,2,2),(3,1,3,3),(4,2,4,4),(5,2,4,NULL),(6,2,3,3);
/*!40000 ALTER TABLE `message_like` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

--
-- Dumping data for table `message_star`
--

LOCK TABLES `message_star` WRITE;
/*!40000 ALTER TABLE `message_star` DISABLE KEYS */;
INSERT INTO `message_star` VALUES (1,1,1,1),(2,2,2,2),(3,2,3,3),(4,2,4,4),(5,2,3,3);
/*!40000 ALTER TABLE `message_star` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;


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
  CONSTRAINT `FK_WORK_STUDENT_ID` FOREIGN KEY (`STUDENT_ID`) REFERENCES `student` (`STUDENT_ID`) ON DELETE SET NULL
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;



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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;



DROP TABLE IF EXISTS `student_work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_work` (
  `STUDENTWORK_ID` int(11) NOT NULL AUTO_INCREMENT,
  `STUDENTWORK_CONTENT` varchar(200) NOT NULL,
  `STUDENTWORK_UPTIME` date NOT NULL,
  `STUDENTWORK_FINISH` int(11) NOT NULL,
  `STUDENTWORK_HOMEWORK_ID` int(11) NOT NULL,
  PRIMARY KEY (`STUDENTWORK_ID`)
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;



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
  CONSTRAINT `FK_PLAN_STUDENT` FOREIGN KEY (`STUDENT_ID`) REFERENCES `student` (`STUDENT_ID`) ON DELETE CASCADE ON UPDATE NO CASCADE,
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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;



DROP TABLE IF EXISTS `friend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friend` (
  `friend_id` int(11) NOT NULL,
  `student_id_one` int(11) NOT NULL,
  `student_id_two` int(11) NOT NULL,
  PRIMARY KEY (`friend_id`),
  CONSTRAINT `fk_friend_1` FOREIGN KEY (`student_id_one`) REFERENCES `student` (`STUDENT_ID`) ON DELETE CASCADE ON UPDATE NO CASCADE,
  CONSTRAINT `fk_friend_2` FOREIGN KEY (`student_id_two`) REFERENCES `student` (`STUDENT_ID`) ON DELETE CASCADE ON UPDATE NO CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend`
--

LOCK TABLES `friend` WRITE;
/*!40000 ALTER TABLE `friend` DISABLE KEYS */;
/*!40000 ALTER TABLE `friend` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
