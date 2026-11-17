-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 17 nov. 2026 à 15:21
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `entraideetu`
--

-- --------------------------------------------------------

--
-- Structure de la table `autoecole`
--

CREATE TABLE `autoecole` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `commune` varchar(50) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `note` decimal(2,1) DEFAULT NULL,
  `nb_avis` int(11) NOT NULL DEFAULT 0,
  `conseil` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `autoecole`
--

INSERT INTO `autoecole` (`id`, `nom`, `commune`, `adresse`, `telephone`, `note`, `nb_avis`, `conseil`) VALUES
(1, 'Driving School Green Valley', 'Nouméa', '1 Rue Jean-François Cherrier, Nouméa', '+687 43.24.12', 5.0, 10, 'Voiture + moto · équipe très patiente'),
(2, 'Pacifikonduite', 'Nouméa', '17 Route du S, Cap Normandie, Nouméa', '+687 31.71.17', 3.4, 4, 'Conduite zen · ambiance bienveillante'),
(3, 'Chrono 64 Vallée Des Colons', 'Nouméa', '77 Rue Auguste Benebig, Nouméa', '+687 27.50.54', 3.4, 26, 'Grand établissement · lire les avis'),
(4, 'Driving School Dynamic Koutio', 'Dumbéa', '28 Rue Theodore Monod, Dumbéa', '+687 46.76.46', 3.5, 6, 'Simulateur de conduite disponible'),
(5, 'Les Pilotes Du Caillou – Païta', 'Païta', 'Complexe commercial de la Gare, Rte du Mont Mou, Païta', '+687 31.07.70', 5.0, 20, 'Note parfaite avec 20 avis'),
(6, 'Chrono 64 Paita', 'Païta', '163 Rue Charles Berthelin, Paita', '+687 28.10.58', NULL, 0, 'Pas encore d\'avis disponibles'),
(7, 'Driving School of Boulari', 'Mont-Dore', 'BP 196, Mont-Dore', '+687 44.92.90', 5.0, 1, 'Très accueillant'),
(8, 'Driving School VKP', 'Koné', 'Zone artisanale de Baco, Impasse du Lion, Koné', '+687 47.20.24', 5.0, 1, 'Seule auto-école recensée en Province Nord');

-- --------------------------------------------------------

--
-- Structure de la table `reponse`
--

CREATE TABLE `reponse` (
  `id` int(11) NOT NULL,
  `message` text NOT NULL,
  `date_creation` datetime DEFAULT current_timestamp(),
  `id_sujet` int(11) NOT NULL,
  `id_utilisateur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `reponse`
--

INSERT INTO `reponse` (`id`, `message`, `date_creation`, `id_sujet`, `id_utilisateur`) VALUES
(1, 'dryryrey', '2026-11-18 01:18:39', 3, 1),
(2, 'etzetzetzetzet', '2026-11-18 01:19:00', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `sujet`
--

CREATE TABLE `sujet` (
  `id` int(11) NOT NULL,
  `titre` varchar(100) NOT NULL,
  `message` text NOT NULL,
  `categorie` enum('permis','avis','astuces','vie') NOT NULL,
  `date_creation` datetime DEFAULT current_timestamp(),
  `id_utilisateur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `sujet`
--

INSERT INTO `sujet` (`id`, `titre`, `message`, `categorie`, `date_creation`, `id_utilisateur`) VALUES
(1, 'Combien d\'heures de conduite avant l\'examen ?', 'Je commence la conduite bientôt. Vous avez fait combien d\'heures avant de passer l\'examen ?', 'permis', '2026-11-18 01:14:43', 1),
(2, 'Astuces pour réviser le code ?', 'Vous utilisez quelle appli ou quel site pour réviser le code de la route ?', 'astuces', '2026-11-18 01:14:43', 1),
(3, 'yyeryery', 'eryeryeryeyeryery', 'astuces', '2026-11-18 01:18:30', 1);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id` int(11) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `email` varchar(150) NOT NULL,
  `commune` varchar(50) DEFAULT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `date_inscription` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `prenom`, `nom`, `email`, `commune`, `mot_de_passe`, `date_inscription`) VALUES
(1, 'TEST-A', 'NOMFAMILLE', 'test@test.nc', 'Nouméa', '$2y$10$LBjQS4d6MuSdNfuyMy8FNOAARAcO8wfzI1mGi/DqwR8hvgvFHD4ae', '2026-11-18 00:45:43');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `autoecole`
--
ALTER TABLE `autoecole`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `reponse`
--
ALTER TABLE `reponse`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_sujet` (`id_sujet`),
  ADD KEY `id_utilisateur` (`id_utilisateur`);

--
-- Index pour la table `sujet`
--
ALTER TABLE `sujet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_utilisateur` (`id_utilisateur`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `autoecole`
--
ALTER TABLE `autoecole`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `reponse`
--
ALTER TABLE `reponse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `sujet`
--
ALTER TABLE `sujet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `reponse`
--
ALTER TABLE `reponse`
  ADD CONSTRAINT `reponse_ibfk_1` FOREIGN KEY (`id_sujet`) REFERENCES `sujet` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reponse_ibfk_2` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `sujet`
--
ALTER TABLE `sujet`
  ADD CONSTRAINT `sujet_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
