-- phpMyAdmin SQL Dump
-- version 3.3.5
-- http://www.phpmyadmin.net
--
-- Serveur: 127.0.0.1
-- Généré le : Jeu 06 Décembre 2012 à 22:57
-- Version du serveur: 5.1.49
-- Version de PHP: 5.3.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `livres`
--

-- --------------------------------------------------------

--
-- Structure de la table `cours`
--

CREATE TABLE IF NOT EXISTS `cours` (
  `numero` varchar(15) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `duree` int(11) NOT NULL,
  PRIMARY KEY (`numero`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `cours`
--

INSERT INTO `cours` (`numero`, `nom`, `duree`) VALUES
('420-AW6-RO', 'Développement de projets informatiques', 90),
('420-AV4-RO', 'Conception d''applications hypermédias', 60),
('420-AX4-RO', 'Développement en environnement graphique', 60),
('420-353-RO', 'Programmation réseau', 45),
('420-026-RO', 'Programmation structurée', 90),
('420-046-RO', 'Programmation orientée objets', 90);

-- --------------------------------------------------------

--
-- Structure de la table `evaluation`
--

CREATE TABLE IF NOT EXISTS `evaluation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idProf` varchar(20) NOT NULL,
  `idLivre` varchar(20) NOT NULL,
  `note` tinyint(4) NOT NULL,
  `commentaire` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `evaluation`
--

INSERT INTO `evaluation` (`id`, `idProf`, `idLivre`, `note`, `commentaire`) VALUES
(1, 'adupont', '978-1-4302-2889-9', 8, 'Très bon livre couvrant une bonne partie de la technologie Java-EE avec une étude assez approfondie de JPA. Le livre couvre aussi le framework JSF ainsi que les services web (SOAP et Restful).\r\nLe seul reproche que je peux lui faire est qu''il ne couvre pas les fondements de la programmation web (servlets et JSP).'),
(2, 'sduvet', '978-1-4302-2889-9', 7, 'Assez bon livre sur la technologie Java-EE. La couverture de JSF et JPA est appréciée. Par contre, je regrette qu''il ne couvre pas des frameworks très populaires tels que Struts et Hibernate.'),
(3, 'adupont', '2-89377-250-1', 7, 'Bon et gros livre couvrant beaucoup de sujets relatifs au développement de systèmes d''informations. On s''y perd un peu dans les nombreux sujets quelques fois antagonistes (exemple : approche structurée et approche objet).'),
(4, 'alapointe', '9781430239307', 7, 'Très bon livre pour découvrir le développement d''applications Android avec Java.');

-- --------------------------------------------------------

--
-- Structure de la table `evaluationcours`
--

CREATE TABLE IF NOT EXISTS `evaluationcours` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idLivre` varchar(20) NOT NULL,
  `idProf` varchar(20) NOT NULL,
  `idCours` varchar(15) NOT NULL,
  `note` tinyint(4) NOT NULL,
  `commentaire` tinytext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `evaluationcours`
--

INSERT INTO `evaluationcours` (`id`, `idLivre`, `idProf`, `idCours`, `note`, `commentaire`) VALUES
(1, '2-89377-250-1', 'alapointe', '420-AW6-RO', 5, 'Pour ce cours sur le développement de projets selon l''approche objet, ce livre ne peut servir que de référence aux étudiants dans le volet de gestion de projet (surtout sa planification). UML et les processus de développement objet ne sont pas couverts ad'),
(2, '978-1-4302-2889-9', 'alapointe', '420-AW6-RO', 5, 'Dans ce cours, ce livre peut être utile pour des étudiants qui développent leur projet en Java-EE s''ils utilisent un des éléments suivants : JSF, JPA, seervices web.');

-- --------------------------------------------------------

--
-- Structure de la table `livre`
--

CREATE TABLE IF NOT EXISTS `livre` (
  `ISBN` varchar(20) NOT NULL DEFAULT '',
  `Titre` tinytext NOT NULL,
  `Edition` varchar(20) DEFAULT NULL,
  `Annee` mediumint(9) DEFAULT NULL,
  `MotsCles` tinytext,
  `NomAuteur` varchar(30) DEFAULT NULL,
  `etat` varchar(15) DEFAULT 'Disponible',
  `Description` text NOT NULL,
  `NbPages` int(11) NOT NULL,
  `note` double DEFAULT NULL,
  `nbEvaluations` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ISBN`),
  KEY `NumAuteur` (`NomAuteur`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Informations sur les livres';

--
-- Contenu de la table `livre`
--

INSERT INTO `livre` (`ISBN`, `Titre`, `Edition`, `Annee`, `MotsCles`, `NomAuteur`, `etat`, `Description`, `NbPages`, `note`, `nbEvaluations`) VALUES
('978-1-4302-2889-9', 'Begining Java EE 6 Platform with GlassFish 3', 'APress', 2010, 'Java, Web, JSF, GlassFish, Application d''entreprise, JPA, Persistence, Services web, Java-EE, JPA', 'Antonio Goncalves', 'Neuf', 'Développement avec Java-EE. Gestion de persistence avec JPA. Le framework JSF. Les services web.', 508, 0, 0),
('9781430239307', 'Pro Android 4', 'APress', 2012, 'Android, Java, Applications mobiles, Développement.', 'Satya Komatineni, Dave MacLean', 'Disponible', 'Développement d''applications en Java pour Android.', 991, 0, 0),
('2-89377-250-1', 'Analyse et conception de systèmes d''information', 'Reynald Goulet eds.', 2003, 'Analyse et conception de systèmes, Approche structurée, Approche objet, Gestion de projets.', 'Satzinger et al.', 'usagé', 'Analyse et conception de systèmes selon les approches structurée et objet. Rôle de l''analyste et gestion de projets.', 1000, 0, 0),
('2-7440-7090-4', 'UML 2 et les design patterns, 3e edition', 'Pearson education', 2005, 'UML, RUP, processus unifié, développement itératif et incrémental', 'Craig Larman', 'Disponible', 'Livre abordant l''analyse et la conception de système selon l''approche objet d''un point de vue mise en oeuvre. L''auteur nous fait partager son expérience pratique.', 655, NULL, 0),
('2895937591, ', 'Java Structuré', 'Groupe Modulo Incorp', 2007, 'Introduction à la programmation structurée, algorithmique, Java', 'Jo Ann Smith, Aicha Mebarek', 'Disponible', 'Initiation à la programmation structurée avec le langage Java.', 158, NULL, 0),
('9780132149181', 'Java Software Solutions: Foundations of Program Development, 7Ed', 'Addison-Wesley', 2011, 'programmation objet, java, initiation à la programmation', 'John Lewis, William Loftus', 'Disponible', 'Livre très pédagogique d''introduction à la programmation en Java.', 832, NULL, 0),
('2-7440-7312-1', 'Au coeur de Java, 8e édition', 'Pearson France', 2008, 'Programmation en Java, Swing, Programmation objets.', 'Horstmann, Cay S., Cornell, Ga', 'Disponible', 'Très bon livre d''introduction à Java mais pour des personnes ayant déjà programmé.', 928, NULL, 0),
('2-7440-1962-3', 'Au coeur de Java 2, vol. 2 Fonctions avancées, JDK', 'CampusPress', 2005, 'Programmation multithread, accès aux bases de données avec JDBC, programmation réseau avec les sockets, RMI.', 'Horstmann, Cay S., Cornell, Ga', 'Disponible', 'Livre couvrant des concepts avancés de la programmation avec l''édition standard de Java (Java-SE).', 858, NULL, 0),
('0-201-73733-7', 'Object-Oriented Software Development Using Java', 'Addison Wesley', 2003, 'Développement objet, programmation java, design patterns', 'Jia, Xiaoping', 'Disponible', 'Livre très pédagogique axé sur la conception d''application et l''exploitation des principaux patrons de conception.', 677, NULL, 0);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `username` varchar(20) NOT NULL,
  `nom_prenom` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `user`
--

INSERT INTO `user` (`username`, `nom_prenom`, `password`) VALUES
('adupont', 'Alain Dupont', 'dupont'),
('sduvet', 'Sylvie Duvet', 'duvet'),
('alapointe', 'Ali Lapointe', 'lapointe'),
('jmarois', 'Jean Marois', 'marois'),
('pcharest', 'Pauline Charest', 'charest');
