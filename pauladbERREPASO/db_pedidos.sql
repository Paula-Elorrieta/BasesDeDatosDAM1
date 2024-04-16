CREATE DATABASE db_pedidos;
use db_pedidos;

-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: pedidos_dam
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `articulo`
--

DROP TABLE IF EXISTS `articulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `articulo` (
  `CodArt` char(5) COLLATE utf8mb4_spanish_ci NOT NULL,
  `DesArt` varchar(30) COLLATE utf8mb4_spanish_ci NOT NULL,
  `PVPArt` float NOT NULL,
  PRIMARY KEY (`CodArt`),
  KEY `IDesArt` (`DesArt`(10)),
  CONSTRAINT `ch_PVPArt` CHECK ((`PVPArt` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articulo`
--

LOCK TABLES `articulo` WRITE;
/*!40000 ALTER TABLE `articulo` DISABLE KEYS */;
INSERT INTO `articulo` VALUES ('A0012','Goma de borrar',0.15),('A0043','Bolígrafo azul',0.78),('A0075','Lápiz 2B',0.55),('A0078','Bolígrafo rojo normal',1.05),('A0089','Sacapuntas',0.25);
/*!40000 ALTER TABLE `articulo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lineapedido`
--

DROP TABLE IF EXISTS `lineapedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lineapedido` (
  `RefPed` char(5) COLLATE utf8mb4_spanish_ci NOT NULL,
  `CodArt` char(5) COLLATE utf8mb4_spanish_ci NOT NULL,
  `CantArt` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`RefPed`,`CodArt`),
  KEY `fk_CodArt_LineaPedido` (`CodArt`),
  CONSTRAINT `fk_CodArt_LineaPedido` FOREIGN KEY (`CodArt`) REFERENCES `articulo` (`CodArt`) ON UPDATE CASCADE,
  CONSTRAINT `fk_RefPed_LineaPedido` FOREIGN KEY (`RefPed`) REFERENCES `pedido` (`refped`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lineapedido`
--

LOCK TABLES `lineapedido` WRITE;
/*!40000 ALTER TABLE `lineapedido` DISABLE KEYS */;
INSERT INTO `lineapedido` VALUES ('P0001','A0043',10),('P0001','A0078',12),('P0002','A0043',5),('P0003','A0075',20),('P0004','A0012',15),('P0004','A0043',5),('P0004','A0089',50);
/*!40000 ALTER TABLE `lineapedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `refped` char(5) COLLATE utf8mb4_spanish_ci NOT NULL,
  `fecped` date NOT NULL,
  PRIMARY KEY (`refped`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES ('P0001','2022-02-16'),('P0002','2022-02-18'),('P0003','2022-02-23'),('P0004','2022-02-25');
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-08 19:06:30