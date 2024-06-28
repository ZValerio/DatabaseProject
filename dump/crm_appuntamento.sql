-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: crm
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `appuntamento`
--

DROP TABLE IF EXISTS `appuntamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appuntamento` (
  `CodiceFiscaleCliente` char(16) NOT NULL,
  `CodiceOfferta` char(6) NOT NULL,
  `Sede` varchar(30) NOT NULL,
  `Data` date NOT NULL,
  `Orario` time NOT NULL,
  PRIMARY KEY (`CodiceFiscaleCliente`,`CodiceOfferta`),
  KEY `CodiceOfferta_appuntamento_idx` (`CodiceOfferta`),
  KEY `DataAppuntamento_idx` (`Data`),
  CONSTRAINT `CF_appuntamento` FOREIGN KEY (`CodiceFiscaleCliente`) REFERENCES `nota` (`CodiceFiscaleCliente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CodiceOfferta_appuntamento` FOREIGN KEY (`CodiceOfferta`) REFERENCES `nota` (`CodiceOfferta`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appuntamento`
--

LOCK TABLES `appuntamento` WRITE;
/*!40000 ALTER TABLE `appuntamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `appuntamento` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `appuntamento_BEFORE_INSERT` BEFORE INSERT ON `appuntamento` FOR EACH ROW BEGIN
	DECLARE counter INT DEFAULT 0;
	DECLARE precedente TIME;
    DECLARE successivo TIME;
    SELECT COUNT(*) INTO counter
    FROM appuntamento
    WHERE appuntamento.CodiceFiscaleCliente= NEW.CodiceFiscaleCliente AND appuntamento.`Data` = NEW.`Data`;
    IF counter > 0 THEN 
		SELECT MAX(Orario) INTO precedente
		FROM appuntamento
		WHERE appuntamento.Orario< NEW.Orario;
		SELECT MIN(Orario) INTO successivo
		FROM appuntamento
		WHERE appuntamento.Orario> NEW.Orario;
        IF precedente IS NOT NULL THEN
			IF TIMEDIFF(NEW.Orario, precedente) < '02:00:00' THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: già presente un appuntamento precedente per il cliente a meno di due ore!';
			END IF;
		END IF;
        IF successivo IS NOT NULL THEN
			IF TIMEDIFF(successivo,NEW.Orario) < '02:00:00' THEN
				SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Errore: già presente un appuntamento successivo per il cliente a meno di due ore!';
			END IF;
		END IF;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-28 22:43:24
