-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 07 avr. 2023 à 14:23
-- Version du serveur : 10.4.25-MariaDB
-- Version de PHP : 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `marmittongr2`
--

-- --------------------------------------------------------

--
-- Structure de la table `etapes`
--

CREATE TABLE `etapes` (
  `id_etape` int(11) UNSIGNED NOT NULL,
  `description_etape` text NOT NULL,
  `id_recette` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `etapes`
--

INSERT INTO `etapes` (`id_etape`, `description_etape`, `id_recette`) VALUES
(1, 'Mettre la farine dans une terrine et former un puits.', 1),
(2, 'Y déposer les oeufs entiers, le sucre, l\'huile et le beurre.', 1),
(3, 'Mélanger délicatement avec un fouet en ajoutant au fur et à mesure le lait. La pâte ainsi obtenue doit avoir une consistance d\'un liquide légèrement épais.', 1),
(4, 'Parfumer de rhum.', 1),
(5, 'Faire chauffer une poêle antiadhésive et la huiler très légèrement à l\'aide d\'un papier Essuie-tout. Y verser une louche de pâte, la répartir dans la poêle puis attendre qu\'elle soit cuite d\'un côté avant de la retourner. Cuire ainsi toutes les crêpes à feu doux.\r\n\r\n', 1),
(6, 'Etaler la pâte sur une plaque et verser la moitié de la fondue de tomates, poser le jambon en lamelles, verser le restant du fondu.', 2),
(7, 'Disposer les fonds d\'artichauts, les câpres, les olives noires, le parmesan, l\'origan, enfourner à thermostat 7 (210°C) pendant 15 min, puis casser un oeuf par convive sur la pizza.', 2),
(8, 'Remettre au four 5 minutes.', 2),
(9, 'Faire bouillir de l\'eau (pour les ramens). Quand l\'eau boue, y mettre les ramens pendant 3 min pas plus. Ensuite égoutter les ramens et les laisser dans leur plat avec un couvercle.', 3),
(10, 'Faire bouillir 1.5 L d\'eau avec les 2 cubes de bouillon.', 3),
(11, 'En attendant que l\'eau boue. Couper les steaks en morceaux carrés d\'environ 2cm, les placer dans une assiette puis les recouvrir de sauce Yakitori pour les faire mariner avant de les mettre dans le bouillon.', 3),
(12, 'Couper le chou, les échalotes, les oignons, la coriandre et le gingembre en petits morceaux.', 3),
(13, 'Quand l\'eau bout y mettre les ingrédients dans l\'ordre suivant : La coriandre > le gingembre > les échalotes > les oignons > le chou. (Entre chaque ingrédients attendre 1 min)', 3),
(14, '2 min après avoir mis le choux, mettre dans l\'eau les 2 œufs et les morceaux de steak pour 3 min de cuisson. Après ces 3 min de cuisson le bouillon est prêt !', 3),
(15, 'Dans une grande tasse ou un mug (20 cl), mettre une noisette de sauce harissa avec 2 cuillères à soupe de sauce soja, mettre de l\'eau chaude puis mélanger le tout à la cuillère.', 3),
(16, 'Verser le bouillon et la sauce sur les ramens et mélanger.', 3),
(17, 'Hacher les oignons. Peler l\'ail.', 4),
(18, 'Dans une cocotte minute, faire roussir la viande et les lardons dans l’huile ou le beurre.', 4),
(19, 'Ajouter les oignons, les champignons égouttés et saupoudrer de fariner. Mélanger et laisser dorer un instant.', 4),
(20, 'Mouiller avec le vin rouge qui doit recouvrir la viande.', 4),
(21, 'Saler et poivrer.', 4),
(22, 'Ajouter l’ail et le bouquet garni.', 4),
(23, 'Fermer la cocotte minute.', 4),
(24, 'Laisser cuire doucement 60 min à partir de la mise en rotation de la soupape.', 4),
(25, 'Séparer les blancs des jaunes d\'oeufs.', 5),
(26, 'Mélanger les jaunes avec le sucre roux et le sucre vanillé.', 5),
(27, 'Ajouter le mascarpone au fouet.', 5),
(28, 'Monter les blancs en neige et les incorporer délicatement à la spatule au mélange précédent. Réserver.', 5),
(29, 'Mouiller les biscuits dans le café rapidement avant d\'en tapisser le fond du plat.', 5),
(30, 'Recouvrir d\'une couche de crème au mascarpone puis répéter l\'opération en alternant couche de biscuits et couche de crème en terminant par cette dernière.', 5),
(31, 'Saupoudrer de cacao.', 5),
(32, 'Mettre au réfrigérateur 4 heures minimum puis déguster frais.', 5);

-- --------------------------------------------------------

--
-- Structure de la table `ingredients`
--

CREATE TABLE `ingredients` (
  `id_ingredient` int(11) UNSIGNED NOT NULL,
  `nom_ingredient` varchar(255) NOT NULL,
  `description_ingredient` text NOT NULL,
  `unite` varchar(20) NOT NULL,
  `prix` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ingredients`
--

INSERT INTO `ingredients` (`id_ingredient`, `nom_ingredient`, `description_ingredient`, `unite`, `prix`) VALUES
(1, 'farine', '', 'g', '3.35'),
(2, 'sucre', '', 'c à s', '1.39'),
(3, 'huile', '', 'c à s', '1.69'),
(4, 'beurre', '', 'g', '2.35'),
(5, 'rhum', '', 'cl', '10.29'),
(6, 'oeuf', '', 'entiers', '0.11'),
(7, 'lait', '', 'cl', '1.38'),
(8, 'tomate', '', 'boite', '1.39'),
(9, 'origan', '', 'pincée', '0.49'),
(10, 'pâte à pain', '', 'g', '1.60'),
(11, 'jambon', '', 'tranche', '0.28'),
(12, 'fond d\'artichaud', '', 'pièce', '6.19'),
(13, 'câpres', '', 'c à s', '2.39'),
(14, 'olives noires', '', 'p.m', '7.10'),
(15, 'parmesan', '', 'g', '16.56'),
(16, 'coriandre', '', 'poigné', '0.89'),
(17, 'harissa', '', 'p.m', '0.78'),
(18, 'gingembre', '', 'unité', '1.80'),
(19, 'cube de bouillon de poule', '', 'pièce', '1.99'),
(20, 'ramen', '', 'g', '3.10'),
(21, 'steak de boeuf', '', 'morceau', '5.86'),
(22, 'chou chinois', '', 'pièce', '2.10'),
(23, 'échalote', '', 'pièce', '1.00'),
(24, 'oignon nouveau', '', 'pièce', '1.34'),
(25, 'sauce soja', '', 'p.m', '1.25'),
(26, 'sauce Yakitori', '', 'p.m', '3.95'),
(27, 'lardons', '', 'g', '1.89'),
(28, 'oignon', '', 'pièce', '0.20'),
(29, 'sel', '', 'p.m', '0.64'),
(30, 'poivre', '', 'p.m', '2.69'),
(31, 'boeuf pour bourguignon', '', 'g', '18.90'),
(32, 'vin rouge', '', 'l', '7.95'),
(33, 'ail', '', 'pièce', '0.21'),
(34, 'bouquet garni', '', 'pièce', '2.67'),
(35, 'champignon de Paris', '', 'g', '3.90'),
(36, 'sucre roux', '', 'g', '2.99'),
(37, 'sucre vanillé', '', 'pièce', '2.49'),
(38, 'biscuits à la cuillère', '', 'pièce', '1.03'),
(39, 'cacao amer', '', 'g', '1.79'),
(40, 'mascarpone', '', 'g', '1.89'),
(41, 'café noir', '', 'cl', '3.00');

-- --------------------------------------------------------

--
-- Structure de la table `recettes`
--

CREATE TABLE `recettes` (
  `id_recette` int(11) UNSIGNED NOT NULL,
  `nom_recette` varchar(255) NOT NULL,
  `description_recette` text NOT NULL,
  `temps_preparation` int(11) NOT NULL,
  `temps_cuisson` int(11) NOT NULL,
  `difficulte` varchar(50) NOT NULL,
  `nb_personnes` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `recettes`
--

INSERT INTO `recettes` (`id_recette`, `nom_recette`, `description_recette`, `temps_preparation`, `temps_cuisson`, `difficulte`, `nb_personnes`) VALUES
(1, 'Crêpe', 'pâte à crêpe simple et rapide pour 15 crêpes', 10, 3, 'Facile', 4),
(2, 'Pizza', 'Pizza royale', 5, 15, 'Facile', 2),
(3, 'Ramen', 'Bouillon à base de poulet', 45, 10, 'Moyenne', 1),
(4, 'Boeuf Bourgignon ', 'Recette traditionelle typique française ', 10, 60, 'facile', 1),
(5, 'Tiramisu', 'dessert italien', 15, 0, 'Facile', 1);

-- --------------------------------------------------------

--
-- Structure de la table `recettes_ingredients`
--

CREATE TABLE `recettes_ingredients` (
  `id_recette` int(11) UNSIGNED NOT NULL,
  `id_ingredient` int(11) UNSIGNED NOT NULL,
  `quantite` decimal(10,2) NOT NULL DEFAULT 1.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `recettes_ingredients`
--

INSERT INTO `recettes_ingredients` (`id_recette`, `id_ingredient`, `quantite`) VALUES
(1, 1, '300.00'),
(1, 2, '3.00'),
(1, 3, '2.00'),
(1, 4, '50.00'),
(1, 5, '5.00'),
(1, 6, '3.00'),
(1, 7, '60.00'),
(2, 6, '2.00'),
(2, 8, '0.50'),
(2, 9, '0.50'),
(2, 10, '150.00'),
(2, 11, '1.50'),
(2, 12, '1.00'),
(2, 13, '1.00'),
(2, 14, '1.00'),
(2, 15, '25.00'),
(3, 6, '0.33'),
(3, 16, '0.25'),
(3, 17, '1.00'),
(3, 18, '0.33'),
(3, 19, '0.33'),
(3, 20, '100.00'),
(3, 21, '1.00'),
(3, 22, '1.00'),
(3, 23, '0.33'),
(3, 24, '1.00'),
(3, 25, '1.00'),
(3, 26, '1.00'),
(4, 1, '20.00'),
(4, 4, '8.50'),
(4, 27, '16.50'),
(4, 28, '0.33'),
(4, 29, '1.00'),
(4, 30, '1.00'),
(4, 31, '133.50'),
(4, 32, '1.00'),
(4, 33, '0.25'),
(4, 34, '0.25'),
(4, 35, '41.50'),
(5, 6, '0.75'),
(5, 36, '25.00'),
(5, 37, '0.25'),
(5, 38, '6.00'),
(5, 39, '7.50'),
(5, 40, '62.50'),
(5, 41, '12.50');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `etapes`
--
ALTER TABLE `etapes`
  ADD PRIMARY KEY (`id_etape`),
  ADD KEY `id_recette` (`id_recette`);

--
-- Index pour la table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`id_ingredient`);

--
-- Index pour la table `recettes`
--
ALTER TABLE `recettes`
  ADD PRIMARY KEY (`id_recette`);

--
-- Index pour la table `recettes_ingredients`
--
ALTER TABLE `recettes_ingredients`
  ADD PRIMARY KEY (`id_recette`,`id_ingredient`),
  ADD KEY `id_ingredient` (`id_ingredient`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `etapes`
--
ALTER TABLE `etapes`
  MODIFY `id_etape` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT pour la table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `id_ingredient` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT pour la table `recettes`
--
ALTER TABLE `recettes`
  MODIFY `id_recette` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `etapes`
--
ALTER TABLE `etapes`
  ADD CONSTRAINT `etapes_ibfk_1` FOREIGN KEY (`id_recette`) REFERENCES `recettes` (`id_recette`) ON DELETE CASCADE;

--
-- Contraintes pour la table `recettes_ingredients`
--
ALTER TABLE `recettes_ingredients`
  ADD CONSTRAINT `recettes_ingredients_ibfk_1` FOREIGN KEY (`id_recette`) REFERENCES `recettes` (`id_recette`) ON DELETE CASCADE,
  ADD CONSTRAINT `recettes_ingredients_ibfk_2` FOREIGN KEY (`id_ingredient`) REFERENCES `ingredients` (`id_ingredient`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
