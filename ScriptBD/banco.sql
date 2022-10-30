CREATE DATABASE  IF NOT EXISTS `testewk` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `testewk`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: testewk
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
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `uf` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `nome_idx` (`nome`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Pedro','Xanxerê','SC'),(2,'Maria','Porto Alegre','RS'),(3,'José',NULL,NULL),(4,'Marcos','Cuiabá','MS'),(5,'Paula','Curitiba','PR'),(6,'Fernando','Rio de Janeiro','RJ'),(7,'Sadia SA','Concórdia','SC'),(8,'Perdigão SA','Maravilha','SC'),(9,'Seara SA','Joaçaba','SC'),(10,'Banco do Brasil SA','Brasília','DF'),(11,'Piere','Paris','FR'),(12,'Jhon','Orlando','FL'),(13,'Fritz','Blumenau','SC'),(14,'Raimundo','Fortaleza','CE'),(15,'Francisco','Natal','RN'),(16,'Carlos',NULL,NULL),(17,'Marcelo','Passo Fundo','RS'),(18,'Venâncio',NULL,NULL),(19,'Marta',NULL,NULL),(20,'Luciano','Xanxerê','SC'),(21,'Anita','Xanxerê','SC'),(22,'',NULL,NULL);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `data_emissao` date NOT NULL,
  `codigo_cliente` int NOT NULL,
  `total` double NOT NULL,
  PRIMARY KEY (`codigo`),
  CONSTRAINT `fk_cliente` FOREIGN KEY (`codigo`) REFERENCES `clientes` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos_produtos`
--

DROP TABLE IF EXISTS `pedidos_produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos_produtos` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `numero_pedido` int NOT NULL,
  `codigo_produto` int NOT NULL,
  `quantidade` int NOT NULL,
  `valor_unitario` double NOT NULL,
  `valor_total` double NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_produto` (`codigo_produto`),
  KEY `fk_pedido` (`numero_pedido`),
  CONSTRAINT `fk_pedido` FOREIGN KEY (`numero_pedido`) REFERENCES `pedidos` (`codigo`),
  CONSTRAINT `fk_pedido_produto` FOREIGN KEY (`codigo_produto`) REFERENCES `produtos` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos_produtos`
--

LOCK TABLES `pedidos_produtos` WRITE;
/*!40000 ALTER TABLE `pedidos_produtos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos_produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `codigo` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  `preco_venda` double NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (84,'Frango frito',5),(85,'Feijão',4),(86,'Arroz',2),(87,'Farinha de Trigo',3),(88,'Fubá',1),(89,'Azeite',6),(90,'Fósforos',5.3),(91,'Ervilha',4.6),(92,'Teclado',8.2),(93,'Mouse',10),(94,'Monitor',10.2),(95,'Fone de Ouvido',100.3),(96,'Copo 200ML',6),(97,'Figurinha da Copa',4),(98,'Caderno 200 folhas',10),(99,'Resma de papel',50),(100,'Borracha',14),(101,'Pincel',8),(102,'Fita desiva',7),(103,'Maça',9),(104,'Banana',8),(105,'Pera',7),(106,'Melão',6),(107,'Cenoura',1),(108,'Alface',1),(109,'Pepino',2),(110,'Ovos',2);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'testewk'
--

--
-- Dumping routines for database 'testewk'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-28 16:14:54
