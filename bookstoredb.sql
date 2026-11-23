-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: bookstoredb
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `barcode` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `author` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` float DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `category_id` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `barcode` (`barcode`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `book_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES ('0000001','Nhà Giả Kim','Paulo Coelho',79000,119,'https://via.placeholder.com/150',1,1,1),('0000002','Đắc Nhân Tâm','Dale Carnegie',86000,349,'https://via.placeholder.com/150',1,2,2),('0000003','Clean Code','Robert C. Martin',320000,79,'https://via.placeholder.com/150',1,3,3),('0000004','Tuổi Trẻ Đáng Giá Bao Nhiêu','Rosie Nguyễn',95000,180,'https://via.placeholder.com/150',1,4,4),('0000005','Cây Cam Ngọt Của Tôi','José Mauro de Vasconcelos',108000,210,'https://via.placeholder.com/150',1,1,5),('0000006','Muôn Kiếp Nhân Sinh','Nguyên Phong',168000,145,'https://via.placeholder.com/150',1,4,6),('0000007','Cha Giàu Cha Nghèo','Robert Kiyosaki',135000,260,'https://via.placeholder.com/150',1,2,7),('0000008','Nhà Đầu Tư Thông Minh','Benjamin Graham',199000,95,'https://via.placeholder.com/150',1,2,8),('0000009','Thiết Kế Hệ Thống Dữ Liệu Lớn','Martin Kleppmann',450000,60,'https://via.placeholder.com/150',1,3,9),('0000010','Lập Trình Python Cơ Bản','Eric Matthes',280000,110,'https://via.placeholder.com/150',1,3,10),('0000011','Sapiens: Lược Sử Loài Người','Yuval Noah Harari',210000,150,'https://via.placeholder.com/150',1,5,11),('0000012','Guns, Germs, and Steel','Jared Diamond',240000,85,'https://via.placeholder.com/150',1,5,12),('0000013','Dế Mèn Phiêu Lưu Ký','Tô Hoài',65000,300,'https://via.placeholder.com/150',1,6,13),('0000014','Hoàng Tử Bé','Antoine de Saint-Exupéry',75000,220,'https://via.placeholder.com/150',1,6,14),('0000015','English Grammar in Use','Raymond Murphy',185000,190,'https://via.placeholder.com/150',1,7,15),('0000016','Hackers IELTS Reading','Hackers Academia',220000,130,'https://via.placeholder.com/150',1,7,16),('0000017','Vũ Trụ Trong Vỏ Hạt Dẻ','Stephen Hawking',160000,90,'https://via.placeholder.com/150',1,8,17),('0000018','Lược Sử Thời Gian','Stephen Hawking',145000,115,'https://via.placeholder.com/150',1,8,18),('0000019','Tư Duy Nhanh Và Chậm','Daniel Kahneman',239000,175,'https://via.placeholder.com/150',1,4,19),('0000020','Kinh Tế Học Hài Hước','Steven D. Levitt',125000,140,'https://via.placeholder.com/150',1,2,20);
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES ('Công nghệ thông tin',3),('Khoa học - Kỹ thuật',8),('Kinh tế',2),('Lịch sử - Địa lý',5),('Ngoại ngữ',7),('Tâm lý - Kỹ năng sống',4),('Thiếu nhi',6),('Văn học',1);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_receipt`
--

DROP TABLE IF EXISTS `import_receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `import_receipt` (
  `created_date` datetime DEFAULT NULL,
  `user_id` int NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `import_receipt_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_receipt`
--

LOCK TABLES `import_receipt` WRITE;
/*!40000 ALTER TABLE `import_receipt` DISABLE KEYS */;
INSERT INTO `import_receipt` VALUES ('2026-01-04 08:47:00',12,1),('2026-02-03 14:02:00',2,2),('2026-03-01 16:12:00',12,3),('2026-04-06 14:21:00',12,4),('2026-05-13 09:22:00',12,5),('2026-06-20 13:36:00',2,6),('2026-07-09 15:40:00',12,7),('2026-08-03 10:34:00',2,8),('2026-09-08 13:53:00',2,9),('2026-10-03 11:58:00',12,10),('2026-11-09 10:15:00',12,11),('2026-12-03 08:55:00',2,12);
/*!40000 ALTER TABLE `import_receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `import_receipt_detail`
--

DROP TABLE IF EXISTS `import_receipt_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `import_receipt_detail` (
  `import_receipt_id` int NOT NULL,
  `book_id` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `import_receipt_id` (`import_receipt_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `import_receipt_detail_ibfk_1` FOREIGN KEY (`import_receipt_id`) REFERENCES `import_receipt` (`id`),
  CONSTRAINT `import_receipt_detail_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `import_receipt_detail`
--

LOCK TABLES `import_receipt_detail` WRITE;
/*!40000 ALTER TABLE `import_receipt_detail` DISABLE KEYS */;
INSERT INTO `import_receipt_detail` VALUES (1,8,150,1),(1,5,300,2),(2,7,300,3),(2,8,300,4),(3,15,200,5),(3,19,150,6),(4,7,150,7),(4,11,150,8),(5,9,250,9),(5,2,150,10),(5,15,300,11),(5,4,200,12),(6,3,150,13),(6,2,180,14),(6,8,150,15),(6,10,250,16),(7,12,180,17),(7,20,200,18),(8,15,200,19),(8,13,300,20),(9,2,250,21),(9,11,200,22),(10,16,250,23),(10,13,180,24),(11,19,180,25),(11,14,180,26),(11,13,300,27),(11,12,250,28),(12,6,300,29),(12,14,150,30);
/*!40000 ALTER TABLE `import_receipt_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipt`
--

DROP TABLE IF EXISTS `receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipt` (
  `created_date` datetime DEFAULT NULL,
  `customer_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `free_shipping` tinyint(1) DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `payment_method` enum('DIRECT_AT_COUNTER','CASH_AT_STORE','ONLINE_FREE_SHIP') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('PENDING','PAID','CANCELLED') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `staff_id` (`staff_id`),
  CONSTRAINT `receipt_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `receipt_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt`
--

LOCK TABLES `receipt` WRITE;
/*!40000 ALTER TABLE `receipt` DISABLE KEYS */;
INSERT INTO `receipt` VALUES ('2026-11-04 22:50:05','asd','123',1,5,NULL,'ONLINE_FREE_SHIP','PAID',1),('2026-11-04 22:58:42','Admin','',0,1,NULL,'CASH_AT_STORE','PENDING',2),('2026-01-13 14:38:29','Hoàng Thùy Linh','123 Nguyễn Huệ, Q.1, TP.HCM',1,10,3,'ONLINE_FREE_SHIP','PAID',3),('2026-01-04 21:40:19','Lê Hoàng Cường','45 Lê Lợi, Q.1, TP.HCM',1,8,NULL,'ONLINE_FREE_SHIP','PENDING',4),('2026-01-04 13:56:53','Lê Hoàng Cường','',0,8,3,'DIRECT_AT_COUNTER','PENDING',5),('2026-01-25 16:49:08','Lê Hoàng Cường','',0,8,3,'CASH_AT_STORE','PAID',6),('2026-01-12 15:57:33','Khách hàng ABC','',0,4,3,'DIRECT_AT_COUNTER','PAID',7),('2026-02-16 11:34:08','Lê Hoàng Cường','45 Lê Lợi, Q.1, TP.HCM',1,8,11,'ONLINE_FREE_SHIP','PAID',8),('2026-02-07 11:34:28','Hoàng Thùy Linh','',0,10,11,'DIRECT_AT_COUNTER','PAID',9),('2026-02-18 21:00:05','Trần Thị Bình','',0,7,3,'DIRECT_AT_COUNTER','CANCELLED',10),('2026-02-26 20:29:18','Hoàng Thùy Linh','45 Lê Lợi, Q.1, TP.HCM',1,10,11,'ONLINE_FREE_SHIP','PAID',11),('2026-02-28 16:10:03','Khách hàng ABC','',0,4,3,'DIRECT_AT_COUNTER','CANCELLED',12),('2026-02-19 17:33:20','Trần Thị Bình','',0,7,11,'DIRECT_AT_COUNTER','CANCELLED',13),('2026-03-19 09:04:34','Khách hàng ASD','',0,5,11,'CASH_AT_STORE','PAID',14),('2026-03-15 21:34:45','Lê Hoàng Cường','99 Cách Mạng Tháng 8, Q.10, TP.HCM',1,8,3,'ONLINE_FREE_SHIP','PAID',15),('2026-03-07 19:21:13','Lê Hoàng Cường','',0,8,11,'CASH_AT_STORE','PAID',16),('2026-03-18 19:27:35','Vũ Thị Mai','',0,NULL,3,'DIRECT_AT_COUNTER','PAID',17),('2026-03-12 20:35:56','Phạm Minh Dung','45 Lê Lợi, Q.1, TP.HCM',1,9,NULL,'ONLINE_FREE_SHIP','PENDING',18),('2026-03-26 14:51:42','Phạm Minh Dung','',0,9,11,'DIRECT_AT_COUNTER','PENDING',19),('2026-03-08 11:52:58','Hoàng Thùy Linh','',0,10,3,'CASH_AT_STORE','PAID',20),('2026-03-09 13:41:32','Nguyễn Văn An','123 Nguyễn Huệ, Q.1, TP.HCM',1,6,3,'ONLINE_FREE_SHIP','PAID',21),('2026-04-19 11:16:02','Khách hàng ABC','',0,4,3,'DIRECT_AT_COUNTER','PAID',22),('2026-04-07 14:42:24','Hoàng Thùy Linh','',0,10,11,'DIRECT_AT_COUNTER','PAID',23),('2026-04-19 17:41:20','Phạm Minh Dung','',0,9,3,'CASH_AT_STORE','PAID',24),('2026-04-08 15:39:54','Trần Thị Bình','',0,7,3,'CASH_AT_STORE','PAID',25),('2026-04-26 15:42:33','Nguyễn Văn An','12 Võ Văn Tần, Q.3, TP.HCM',1,6,NULL,'ONLINE_FREE_SHIP','CANCELLED',26),('2026-04-08 12:28:04','Lê Hoàng Cường','',0,8,11,'DIRECT_AT_COUNTER','PAID',27),('2026-04-05 19:13:04','Lê Hoàng Cường','',0,8,11,'CASH_AT_STORE','PAID',28),('2026-05-24 19:34:51','Trần Thị Bình','',0,7,11,'DIRECT_AT_COUNTER','PAID',29),('2026-05-03 18:27:08','Nguyễn Văn An','',0,6,3,'DIRECT_AT_COUNTER','PENDING',30),('2026-05-14 12:53:05','Lê Hoàng Cường','78 Trần Hưng Đạo, Q.5, TP.HCM',1,8,3,'ONLINE_FREE_SHIP','PAID',31),('2026-05-05 11:08:30','Khách hàng ASD','78 Trần Hưng Đạo, Q.5, TP.HCM',1,5,11,'ONLINE_FREE_SHIP','PAID',32),('2026-05-13 14:45:12','Hoàng Thùy Linh','123 Nguyễn Huệ, Q.1, TP.HCM',1,10,3,'ONLINE_FREE_SHIP','PAID',33),('2026-05-21 13:00:54','Khách hàng ABC','',0,4,11,'CASH_AT_STORE','PAID',34),('2026-05-15 14:52:46','Hoàng Thùy Linh','',0,10,3,'CASH_AT_STORE','PAID',35),('2026-05-15 17:39:42','Trần Minh Tuấn','',0,NULL,11,'DIRECT_AT_COUNTER','PAID',36),('2026-05-08 12:42:37','Lê Hoàng Cường','12 Võ Văn Tần, Q.3, TP.HCM',1,8,11,'ONLINE_FREE_SHIP','PAID',37),('2026-06-23 10:12:13','Phạm Minh Dung','',0,9,11,'CASH_AT_STORE','PAID',38),('2026-06-06 12:00:45','Khách hàng ABC','',0,4,3,'CASH_AT_STORE','PAID',39),('2026-06-06 08:16:55','Lê Hoàng Cường','',0,8,11,'DIRECT_AT_COUNTER','PAID',40),('2026-06-08 09:35:48','Hoàng Thùy Linh','99 Cách Mạng Tháng 8, Q.10, TP.HCM',1,10,3,'ONLINE_FREE_SHIP','PAID',41),('2026-06-06 11:11:35','Lê Hoàng Cường','',0,8,11,'DIRECT_AT_COUNTER','PAID',42),('2026-06-21 10:58:17','Nguyễn Văn An','',0,6,3,'DIRECT_AT_COUNTER','PENDING',43),('2026-06-14 19:20:38','Khách vãng lai','',0,NULL,3,'DIRECT_AT_COUNTER','PAID',44),('2026-06-03 15:22:26','Khách hàng ABC','78 Trần Hưng Đạo, Q.5, TP.HCM',1,4,3,'ONLINE_FREE_SHIP','PAID',45),('2026-06-17 21:00:42','Trần Thị Bình','',0,7,NULL,'CASH_AT_STORE','PENDING',46),('2026-06-16 18:28:48','Lê Hoàng Cường','',0,8,3,'CASH_AT_STORE','PAID',47),('2026-07-27 09:29:07','Vũ Thị Mai','',0,NULL,11,'DIRECT_AT_COUNTER','PAID',48),('2026-07-05 21:04:17','Nguyễn Văn An','',0,6,11,'CASH_AT_STORE','PAID',49),('2026-07-19 18:31:55','Trần Thị Bình','78 Trần Hưng Đạo, Q.5, TP.HCM',1,7,11,'ONLINE_FREE_SHIP','PAID',50),('2026-07-13 18:50:52','Trần Minh Tuấn','',0,NULL,11,'DIRECT_AT_COUNTER','PAID',51),('2026-07-28 13:54:43','Nguyễn Văn An','',0,6,NULL,'CASH_AT_STORE','PENDING',52),('2026-07-15 10:44:19','Vũ Thị Mai','',0,NULL,11,'DIRECT_AT_COUNTER','CANCELLED',53),('2026-07-16 17:09:14','Trần Thị Bình','',0,7,11,'CASH_AT_STORE','PAID',54),('2026-07-22 16:10:04','Lê Hoàng Cường','',0,8,11,'CASH_AT_STORE','PAID',55),('2026-08-27 18:25:17','Hoàng Thùy Linh','99 Cách Mạng Tháng 8, Q.10, TP.HCM',1,10,3,'ONLINE_FREE_SHIP','PAID',56),('2026-08-27 10:40:06','Khách hàng ABC','78 Trần Hưng Đạo, Q.5, TP.HCM',1,4,NULL,'ONLINE_FREE_SHIP','CANCELLED',57),('2026-08-17 12:53:10','Hoàng Thùy Linh','',0,10,11,'CASH_AT_STORE','PAID',58),('2026-08-28 20:35:23','Khách hàng ABC','',0,4,11,'CASH_AT_STORE','PAID',59),('2026-08-27 18:23:06','Khách hàng ABC','',0,4,11,'CASH_AT_STORE','PAID',60),('2026-08-02 08:19:31','Nguyễn Văn An','',0,6,3,'DIRECT_AT_COUNTER','PAID',61),('2026-08-28 13:06:43','Nguyễn Văn An','12 Võ Văn Tần, Q.3, TP.HCM',1,6,3,'ONLINE_FREE_SHIP','PAID',62),('2026-08-26 13:15:08','Trần Minh Tuấn','',0,NULL,3,'DIRECT_AT_COUNTER','PAID',63),('2026-08-09 21:09:08','Khách vãng lai','',0,NULL,3,'DIRECT_AT_COUNTER','PAID',64),('2026-08-24 14:33:07','Trần Thị Bình','',0,7,11,'CASH_AT_STORE','PAID',65),('2026-08-02 19:50:58','Nguyễn Văn An','12 Võ Văn Tần, Q.3, TP.HCM',1,6,NULL,'ONLINE_FREE_SHIP','PENDING',66),('2026-09-14 18:06:31','Khách hàng ABC','',0,4,3,'CASH_AT_STORE','PAID',67),('2026-09-23 09:54:41','Phạm Minh Dung','12 Võ Văn Tần, Q.3, TP.HCM',1,9,3,'ONLINE_FREE_SHIP','PAID',68),('2026-09-03 09:53:05','Khách vãng lai','',0,NULL,11,'DIRECT_AT_COUNTER','PAID',69),('2026-09-19 16:13:09','Lê Hoàng Cường','',0,8,3,'DIRECT_AT_COUNTER','PAID',70),('2026-09-22 21:44:17','Phạm Minh Dung','',0,9,11,'CASH_AT_STORE','PAID',71),('2026-09-15 13:10:23','Hoàng Thùy Linh','',0,10,3,'CASH_AT_STORE','PAID',72),('2026-09-09 15:42:27','Trần Thị Bình','',0,7,11,'CASH_AT_STORE','PAID',73),('2026-09-16 16:42:19','Lê Hoàng Cường','',0,8,3,'CASH_AT_STORE','PAID',74),('2026-09-25 12:18:20','Phạm Minh Dung','',0,9,11,'CASH_AT_STORE','PAID',75),('2026-09-02 14:01:29','Lê Hoàng Cường','',0,8,NULL,'CASH_AT_STORE','CANCELLED',76),('2026-09-17 09:25:55','Khách hàng ASD','',0,5,11,'CASH_AT_STORE','PAID',77),('2026-09-24 21:41:52','Khách hàng ASD','',0,5,3,'DIRECT_AT_COUNTER','PAID',78),('2026-10-19 15:43:59','Phạm Minh Dung','99 Cách Mạng Tháng 8, Q.10, TP.HCM',1,9,NULL,'ONLINE_FREE_SHIP','PENDING',79),('2026-10-03 12:29:28','Hoàng Thùy Linh','',0,10,11,'CASH_AT_STORE','PAID',80),('2026-10-17 14:29:37','Khách hàng ABC','99 Cách Mạng Tháng 8, Q.10, TP.HCM',1,4,11,'ONLINE_FREE_SHIP','PAID',81),('2026-10-27 13:45:05','Trần Thị Bình','',0,7,3,'DIRECT_AT_COUNTER','PAID',82),('2026-10-22 14:18:16','Lê Hoàng Cường','78 Trần Hưng Đạo, Q.5, TP.HCM',1,8,3,'ONLINE_FREE_SHIP','PAID',83),('2026-10-10 18:44:42','Phạm Minh Dung','78 Trần Hưng Đạo, Q.5, TP.HCM',1,9,3,'ONLINE_FREE_SHIP','PAID',84),('2026-10-16 11:14:08','Hoàng Thùy Linh','',0,10,3,'CASH_AT_STORE','PAID',85),('2026-10-13 10:10:11','Hoàng Thùy Linh','45 Lê Lợi, Q.1, TP.HCM',1,10,NULL,'ONLINE_FREE_SHIP','PENDING',86),('2026-10-27 11:23:43','Trần Thị Bình','',0,7,NULL,'CASH_AT_STORE','CANCELLED',87),('2026-10-28 13:35:59','Hoàng Thùy Linh','78 Trần Hưng Đạo, Q.5, TP.HCM',1,10,3,'ONLINE_FREE_SHIP','PAID',88),('2026-10-17 10:53:27','Khách vãng lai','',0,NULL,11,'DIRECT_AT_COUNTER','PAID',89),('2026-10-23 21:08:48','Lê Hoàng Cường','',0,8,3,'CASH_AT_STORE','PAID',90),('2026-10-18 19:38:33','Khách hàng ASD','',0,5,11,'CASH_AT_STORE','PAID',91),('2026-10-20 15:04:07','Lê Hoàng Cường','',0,8,NULL,'CASH_AT_STORE','PENDING',92),('2026-11-10 14:00:39','Trần Thị Bình','123 Nguyễn Huệ, Q.1, TP.HCM',1,7,3,'ONLINE_FREE_SHIP','PAID',93),('2026-11-03 13:15:46','Nguyễn Văn An','',0,6,11,'DIRECT_AT_COUNTER','PAID',94),('2026-11-15 08:18:12','Nguyễn Văn An','',0,6,3,'DIRECT_AT_COUNTER','PAID',95),('2026-11-15 14:21:11','Nguyễn Văn An','',0,6,11,'CASH_AT_STORE','PAID',96),('2026-11-06 16:18:20','Phạm Minh Dung','',0,9,11,'CASH_AT_STORE','PAID',97),('2026-11-14 12:40:50','Hoàng Thùy Linh','',0,10,11,'DIRECT_AT_COUNTER','CANCELLED',98),('2026-11-21 13:23:24','Vũ Thị Mai','',0,NULL,3,'DIRECT_AT_COUNTER','CANCELLED',99),('2026-11-16 16:24:58','Hoàng Thùy Linh','',0,10,11,'CASH_AT_STORE','PAID',100),('2026-11-11 18:22:45','Nguyễn Văn An','45 Lê Lợi, Q.1, TP.HCM',1,6,11,'ONLINE_FREE_SHIP','PAID',101),('2026-11-16 08:23:35','Hoàng Thùy Linh','',0,10,3,'CASH_AT_STORE','PAID',102),('2026-11-16 16:26:49','Khách hàng ABC','78 Trần Hưng Đạo, Q.5, TP.HCM',1,4,3,'ONLINE_FREE_SHIP','PAID',103),('2026-11-18 18:37:11','Khách vãng lai','',0,NULL,11,'DIRECT_AT_COUNTER','PAID',104),('2026-11-11 19:14:22','Nguyễn Văn An','123 Nguyễn Huệ, Q.1, TP.HCM',1,6,NULL,'ONLINE_FREE_SHIP','CANCELLED',105),('2026-11-20 19:57:38','Khách hàng ABC','123 Nguyễn Huệ, Q.1, TP.HCM',1,4,3,'ONLINE_FREE_SHIP','PAID',106),('2026-11-07 20:36:26','Vũ Thị Mai','',0,NULL,11,'DIRECT_AT_COUNTER','PAID',107),('2026-11-20 10:20:55','Hoàng Thùy Linh','12 Võ Văn Tần, Q.3, TP.HCM',1,10,11,'ONLINE_FREE_SHIP','PAID',108),('2026-11-15 11:09:06','Hoàng Thùy Linh','',0,10,11,'CASH_AT_STORE','PAID',109),('2026-11-06 15:32:29','Trần Thị Bình','',0,7,3,'CASH_AT_STORE','PAID',110),('2026-12-08 11:37:22','Trần Thị Bình','',0,7,11,'CASH_AT_STORE','PAID',111),('2026-12-07 13:35:18','Trần Thị Bình','99 Cách Mạng Tháng 8, Q.10, TP.HCM',1,7,11,'ONLINE_FREE_SHIP','PAID',112),('2026-12-26 13:35:23','Khách vãng lai','',0,NULL,11,'DIRECT_AT_COUNTER','PAID',113),('2026-12-17 15:09:38','Vũ Thị Mai','',0,NULL,11,'DIRECT_AT_COUNTER','PENDING',114),('2026-12-27 08:23:21','Lê Hoàng Cường','',0,8,11,'CASH_AT_STORE','PAID',115),('2026-12-26 20:37:36','Phạm Minh Dung','',0,9,11,'DIRECT_AT_COUNTER','PAID',116);
/*!40000 ALTER TABLE `receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipt_detail`
--

DROP TABLE IF EXISTS `receipt_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipt_detail` (
  `receipt_id` int NOT NULL,
  `book_id` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `unit_price` float DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `receipt_id` (`receipt_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `receipt_detail_ibfk_1` FOREIGN KEY (`receipt_id`) REFERENCES `receipt` (`id`),
  CONSTRAINT `receipt_detail_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt_detail`
--

LOCK TABLES `receipt_detail` WRITE;
/*!40000 ALTER TABLE `receipt_detail` DISABLE KEYS */;
INSERT INTO `receipt_detail` VALUES (1,2,1,86000,1),(1,3,1,320000,2),(2,1,1,79000,3),(3,1,5,79000,4),(3,11,2,210000,5),(3,9,1,450000,6),(4,1,1,79000,7),(4,3,1,320000,8),(5,15,2,185000,9),(6,18,2,145000,10),(6,11,1,210000,11),(6,7,2,135000,12),(7,1,1,79000,13),(7,3,1,320000,14),(8,1,1,79000,15),(8,11,2,210000,16),(8,4,2,95000,17),(8,7,1,135000,18),(9,2,1,86000,19),(10,1,5,79000,20),(10,2,1,86000,21),(11,1,1,79000,22),(11,2,1,86000,23),(12,1,2,79000,24),(12,4,1,95000,25),(13,10,1,280000,26),(13,2,2,86000,27),(14,12,1,240000,28),(15,2,2,86000,29),(15,4,1,95000,30),(15,5,1,108000,31),(16,3,2,320000,32),(16,2,1,86000,33),(16,11,2,210000,34),(17,1,2,79000,35),(17,7,2,135000,36),(18,1,1,79000,37),(18,6,3,168000,38),(19,1,3,79000,39),(20,4,3,95000,40),(20,5,5,108000,41),(21,11,1,210000,42),(21,5,5,108000,43),(21,7,1,135000,44),(22,11,1,210000,45),(22,2,2,86000,46),(22,10,1,280000,47),(23,4,1,95000,48),(24,10,2,280000,49),(24,4,1,95000,50),(24,6,1,168000,51),(24,7,1,135000,52),(25,8,1,199000,53),(25,1,1,79000,54),(25,4,2,95000,55),(25,15,1,185000,56),(26,16,2,220000,57),(26,18,1,145000,58),(26,3,2,320000,59),(26,4,1,95000,60),(27,4,1,95000,61),(28,19,2,239000,62),(28,1,3,79000,63),(28,10,5,280000,64),(28,11,1,210000,65),(29,20,1,125000,66),(29,15,3,185000,67),(29,13,1,65000,68),(29,7,2,135000,69),(30,13,1,65000,70),(30,7,5,135000,71),(31,8,1,199000,72),(31,2,1,86000,73),(32,2,1,86000,74),(32,4,3,95000,75),(32,6,1,168000,76),(33,19,1,239000,77),(33,20,2,125000,78),(33,12,1,240000,79),(34,5,2,108000,80),(34,14,3,75000,81),(34,15,2,185000,82),(35,15,1,185000,83),(36,16,1,220000,84),(36,11,1,210000,85),(36,4,1,95000,86),(36,5,1,108000,87),(37,4,1,95000,88),(37,5,2,108000,89),(37,15,5,185000,90),(38,10,1,280000,91),(39,1,1,79000,92),(39,5,1,108000,93),(39,15,1,185000,94),(40,5,1,108000,95),(41,1,3,79000,96),(41,2,1,86000,97),(41,11,1,210000,98),(41,15,2,185000,99),(42,19,2,239000,100),(42,4,3,95000,101),(42,5,1,108000,102),(42,15,1,185000,103),(43,17,1,160000,104),(43,13,1,65000,105),(43,15,1,185000,106),(44,3,5,320000,107),(44,6,1,168000,108),(44,15,2,185000,109),(45,2,1,86000,110),(45,10,1,280000,111),(45,18,5,145000,112),(45,13,1,65000,113),(46,7,2,135000,114),(47,10,1,280000,115),(47,4,1,95000,116),(47,15,1,185000,117),(48,8,1,199000,118),(48,3,3,320000,119),(48,15,1,185000,120),(49,5,2,108000,121),(50,8,1,199000,122),(50,4,2,95000,123),(50,14,2,75000,124),(50,7,2,135000,125),(51,3,1,320000,126),(51,5,2,108000,127),(51,15,2,185000,128),(52,2,1,86000,129),(52,3,1,320000,130),(52,4,2,95000,131),(52,5,3,108000,132),(53,11,2,210000,133),(53,2,1,86000,134),(53,3,2,320000,135),(54,15,3,185000,136),(55,16,1,220000,137),(55,11,1,210000,138),(55,7,5,135000,139),(55,15,1,185000,140),(56,8,2,199000,141),(56,10,2,280000,142),(56,4,2,95000,143),(56,7,2,135000,144),(57,11,1,210000,145),(57,3,2,320000,146),(57,6,3,168000,147),(57,7,1,135000,148),(58,8,3,199000,149),(58,5,2,108000,150),(58,15,5,185000,151),(59,5,1,108000,152),(60,10,2,280000,153),(60,15,1,185000,154),(61,5,1,108000,155),(61,3,1,320000,156),(61,4,1,95000,157),(61,20,5,125000,158),(62,2,2,86000,159),(62,4,1,95000,160),(62,15,1,185000,161),(63,8,2,199000,162),(63,3,1,320000,163),(64,1,1,79000,164),(64,4,1,95000,165),(65,4,3,95000,166),(66,15,2,185000,167),(67,2,1,86000,168),(67,5,2,108000,169),(67,7,1,135000,170),(68,2,2,86000,171),(68,7,1,135000,172),(68,14,1,75000,173),(68,15,3,185000,174),(69,2,5,86000,175),(69,11,2,210000,176),(69,14,1,75000,177),(70,11,2,210000,178),(70,20,2,125000,179),(70,5,1,108000,180),(71,19,1,239000,181),(71,1,1,79000,182),(71,3,1,320000,183),(72,1,2,79000,184),(73,2,1,86000,185),(73,4,2,95000,186),(74,4,2,95000,187),(75,4,1,95000,188),(75,7,3,135000,189),(76,11,1,210000,190),(76,15,2,185000,191),(76,12,1,240000,192),(76,7,1,135000,193),(77,2,3,86000,194),(77,4,1,95000,195),(78,3,1,320000,196),(78,15,1,185000,197),(79,2,2,86000,198),(79,11,1,210000,199),(79,5,1,108000,200),(80,2,2,86000,201),(81,1,1,79000,202),(81,15,2,185000,203),(82,2,2,86000,204),(82,3,2,320000,205),(82,5,1,108000,206),(82,7,1,135000,207),(83,3,3,320000,208),(84,17,1,160000,209),(84,11,1,210000,210),(84,1,1,79000,211),(84,7,3,135000,212),(85,20,1,125000,213),(86,8,1,199000,214),(86,20,1,125000,215),(86,15,5,185000,216),(86,7,2,135000,217),(87,17,1,160000,218),(87,3,1,320000,219),(87,20,2,125000,220),(88,9,1,450000,221),(89,1,2,79000,222),(89,2,1,86000,223),(89,11,1,210000,224),(89,7,2,135000,225),(90,4,2,95000,226),(91,11,2,210000,227),(92,4,2,95000,228),(93,1,5,79000,229),(93,11,1,210000,230),(93,15,1,185000,231),(94,16,2,220000,232),(94,6,2,168000,233),(94,15,1,185000,234),(95,1,1,79000,235),(95,18,2,145000,236),(95,11,1,210000,237),(95,7,1,135000,238),(96,3,1,320000,239),(97,1,2,79000,240),(97,11,3,210000,241),(97,15,2,185000,242),(98,5,1,108000,243),(98,15,1,185000,244),(99,2,1,86000,245),(99,5,1,108000,246),(99,7,2,135000,247),(100,16,1,220000,248),(100,3,2,320000,249),(100,5,5,108000,250),(100,15,2,185000,251),(101,17,2,160000,252),(101,4,1,95000,253),(102,11,5,210000,254),(103,7,1,135000,255),(104,5,1,108000,256),(105,2,1,86000,257),(105,3,1,320000,258),(105,5,1,108000,259),(106,19,1,239000,260),(107,2,1,86000,261),(107,11,1,210000,262),(107,6,1,168000,263),(108,17,1,160000,264),(108,7,1,135000,265),(109,19,2,239000,266),(109,6,1,168000,267),(110,17,1,160000,268),(111,2,1,86000,269),(111,13,1,65000,270),(111,5,1,108000,271),(112,2,1,86000,272),(113,7,2,135000,273),(114,5,2,108000,274),(114,15,1,185000,275),(115,5,5,108000,276),(116,2,1,86000,277),(116,3,1,320000,278),(116,4,1,95000,279),(116,15,2,185000,280);
/*!40000 ALTER TABLE `receipt_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rule`
--

DROP TABLE IF EXISTS `rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rule` (
  `min_import_quantity` int DEFAULT NULL,
  `max_stock_to_import` int DEFAULT NULL,
  `cancel_order_hours` int DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rule`
--

LOCK TABLES `rule` WRITE;
/*!40000 ALTER TABLE `rule` DISABLE KEYS */;
INSERT INTO `rule` VALUES (150,300,48,1);
/*!40000 ALTER TABLE `rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `joined_date` datetime DEFAULT NULL,
  `user_role` enum('ADMIN','STAFF','WAREHOUSE','USER') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('Admin','admin','e10adc3949ba59abbe56e057f20f883e','https://res.cloudinary.com/dxxwcby8l/image/upload/v1647056401/ipmsmnxjydrhpo2btdx8.jpg',1,'2026-11-04 15:37:15','ADMIN',1),('Quản lý kho','kho','e10adc3949ba59abbe56e057f20f883e','https://res.cloudinary.com/dxxwcby8l/image/upload/v1647056401/ipmsmnxjydrhpo2btdx8.jpg',1,'2026-11-04 15:37:15','WAREHOUSE',2),('Thu ngân','nhanvien','e10adc3949ba59abbe56e057f20f883e','https://res.cloudinary.com/dxxwcby8l/image/upload/v1647056401/ipmsmnxjydrhpo2btdx8.jpg',1,'2026-11-04 15:37:15','STAFF',3),('abc','abc','e10adc3949ba59abbe56e057f20f883e','https://res.cloudinary.com/dxxwcby8l/image/upload/v1647056401/ipmsmnxjydrhpo2btdx8.jpg',1,'2026-11-04 15:37:15','USER',4),('asd','asd','7815696ecbf1c96e6894b779456d330e','https://res.cloudinary.com/dxxwcby8l/image/upload/v1647056401/ipmsmnxjydrhpo2btdx8.jpg',1,'2026-11-04 22:48:35','USER',5),('Nguyễn Văn An','nguyenvana','e10adc3949ba59abbe56e057f20f883e','https://res.cloudinary.com/dxxwcby8l/image/upload/v1647056401/ipmsmnxjydrhpo2btdx8.jpg',1,'2026-01-10 09:00:00','USER',6),('Trần Thị Bình','tranthib','e10adc3949ba59abbe56e057f20f883e','https://res.cloudinary.com/dxxwcby8l/image/upload/v1647056401/ipmsmnxjydrhpo2btdx8.jpg',1,'2026-02-15 10:30:00','USER',7),('Lê Hoàng Cường','lehoangc','e10adc3949ba59abbe56e057f20f883e','https://res.cloudinary.com/dxxwcby8l/image/upload/v1647056401/ipmsmnxjydrhpo2btdx8.jpg',1,'2026-03-20 14:15:00','USER',8),('Phạm Minh Dung','phamminhd','e10adc3949ba59abbe56e057f20f883e','https://res.cloudinary.com/dxxwcby8l/image/upload/v1647056401/ipmsmnxjydrhpo2btdx8.jpg',1,'2026-04-05 16:45:00','USER',9),('Hoàng Thùy Linh','hoangthuyl','e10adc3949ba59abbe56e057f20f883e','https://res.cloudinary.com/dxxwcby8l/image/upload/v1647056401/ipmsmnxjydrhpo2btdx8.jpg',1,'2026-05-12 11:20:00','USER',10),('Thu ngân 2','nhanvien2','e10adc3949ba59abbe56e057f20f883e','https://res.cloudinary.com/dxxwcby8l/image/upload/v1647056401/ipmsmnxjydrhpo2btdx8.jpg',1,'2026-03-01 08:00:00','STAFF',11),('Quản lý kho 2','kho2','e10adc3949ba59abbe56e057f20f883e','https://res.cloudinary.com/dxxwcby8l/image/upload/v1647056401/ipmsmnxjydrhpo2btdx8.jpg',1,'2026-03-01 08:00:00','WAREHOUSE',12);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-23 14:37:24
