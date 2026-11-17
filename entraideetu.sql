-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: entraideetu
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `entraideetu`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `entraideetu` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `entraideetu`;

--
-- Table structure for table `autoecole`
--

DROP TABLE IF EXISTS `autoecole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoecole` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `commune` varchar(50) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `note` decimal(2,1) DEFAULT NULL,
  `nb_avis` int(11) NOT NULL DEFAULT 0,
  `conseil` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoecole`
--

LOCK TABLES `autoecole` WRITE;
/*!40000 ALTER TABLE `autoecole` DISABLE KEYS */;
INSERT INTO `autoecole` VALUES (1,'Driving School Green Valley','Nouméa','1 Rue Jean-François Cherrier, Nouméa','+687 43.24.12',5.0,10,'Voiture + moto · équipe très patiente'),(2,'Pacifikonduite','Nouméa','17 Route du S, Cap Normandie, Nouméa','+687 31.71.17',3.4,4,'Conduite zen · ambiance bienveillante'),(3,'Chrono 64 Vallée Des Colons','Nouméa','77 Rue Auguste Benebig, Nouméa','+687 27.50.54',3.4,26,'Grand établissement · lire les avis'),(4,'Driving School Dynamic Koutio','Dumbéa','28 Rue Theodore Monod, Dumbéa','+687 46.76.46',3.5,6,'Simulateur de conduite disponible'),(5,'Les Pilotes Du Caillou – Païta','Païta','Complexe commercial de la Gare, Rte du Mont Mou, Païta','+687 31.07.70',5.0,20,'Note parfaite avec 20 avis'),(6,'Chrono 64 Paita','Païta','163 Rue Charles Berthelin, Paita','+687 28.10.58',NULL,0,'Pas encore d\'avis disponibles'),(7,'Driving School of Boulari','Mont-Dore','BP 196, Mont-Dore','+687 44.92.90',5.0,1,'Très accueillant'),(8,'Driving School VKP','Koné','Zone artisanale de Baco, Impasse du Lion, Koné','+687 47.20.24',5.0,1,'Seule auto-école recensée en Province Nord');
/*!40000 ALTER TABLE `autoecole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reponse`
--

DROP TABLE IF EXISTS `reponse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reponse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  `date_creation` datetime DEFAULT current_timestamp(),
  `id_sujet` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_sujet` (`id_sujet`),
  KEY `id_utilisateur` (`id_utilisateur`),
  CONSTRAINT `reponse_ibfk_1` FOREIGN KEY (`id_sujet`) REFERENCES `sujet` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reponse_ibfk_2` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reponse`
--

LOCK TABLES `reponse` WRITE;
/*!40000 ALTER TABLE `reponse` DISABLE KEYS */;
INSERT INTO `reponse` VALUES (1,'dryryrey','2026-11-18 01:18:39',3,1),(2,'etzetzetzetzet','2026-11-18 01:19:00',1,1);
/*!40000 ALTER TABLE `reponse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sujet`
--

DROP TABLE IF EXISTS `sujet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sujet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `categorie` enum('permis','avis','astuces','vie') NOT NULL,
  `date_creation` datetime DEFAULT current_timestamp(),
  `id_utilisateur` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_utilisateur` (`id_utilisateur`),
  CONSTRAINT `sujet_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sujet`
--

LOCK TABLES `sujet` WRITE;
/*!40000 ALTER TABLE `sujet` DISABLE KEYS */;
INSERT INTO `sujet` VALUES (1,'Combien d\'heures de conduite avant l\'examen ?','Je commence la conduite bientôt. Vous avez fait combien d\'heures avant de passer l\'examen ?','permis','2026-11-18 01:14:43',1),(2,'Astuces pour réviser le code ?','Vous utilisez quelle appli ou quel site pour réviser le code de la route ?','astuces','2026-11-18 01:14:43',1),(3,'yyeryery','eryeryeryeyeryery','astuces','2026-11-18 01:18:30',1);
/*!40000 ALTER TABLE `sujet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `utilisateur` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prenom` varchar(50) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `email` varchar(150) NOT NULL,
  `commune` varchar(50) DEFAULT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `date_inscription` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utilisateur`
--

LOCK TABLES `utilisateur` WRITE;
/*!40000 ALTER TABLE `utilisateur` DISABLE KEYS */;
INSERT INTO `utilisateur` VALUES (1,'TEST-A','NOMFAMILLE','test@test.nc','Nouméa','$2y$10$LBjQS4d6MuSdNfuyMy8FNOAARAcO8wfzI1mGi/DqwR8hvgvFHD4ae','2026-11-18 00:45:43');
/*!40000 ALTER TABLE `utilisateur` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-18 10:04:44
