-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 11, 2016 at 09:25 AM
-- Server version: 5.6.12-log
-- PHP Version: 5.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ecargo_database`
--
CREATE DATABASE IF NOT EXISTS `ecargo_database` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `ecargo_database`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddReview`(IN `productid` INT, IN `userid` INT, IN `description` TEXT, IN `rating` INT)
BEGIN
INSERT INTO reviews (Comment, ProductId, Rating, UserId) VALUES (description, productid, rating, userid);
SELECT r.Rating,
		r.Comment,
        u.UserName
FROM reviews AS r INNER JOIN users u ON u.Id = r.UserId
WHERE r.ProductId = productid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLatestProducts`(IN `maxitem` INT)
    NO SQL
SELECT p.Id,
	   p.Description,
       b.Name AS BrandName,
       p.ProductName
FROM products AS p INNER JOIN brands AS b ON b.Id = p.BrandId
LIMIT maxitem$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductById`(IN `productid` INT)
    NO SQL
    DETERMINISTIC
SELECT p.Id,
	   p.Description,
       b.Name AS BrandName,
	   p.Price,
       p.ProductName
FROM products AS p INNER JOIN brands AS b ON b.Id = p.BrandId
WHERE p.Id = productid$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetProductsByBrandId`(IN `brandid` INT, IN `maxitem` INT)
    NO SQL
SELECT p.Id,
	   p.Description,
       b.Name AS BrandName,
       p.ProductName
FROM products AS p INNER JOIN brands AS b ON b.Id = p.BrandId
WHERE b.Id = brandid
LIMIT maxitem$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetReviewsByProductId`(IN `productid` INT)
    NO SQL
SELECT r.Rating,
		r.Comment,
        u.UserName
FROM reviews AS r INNER JOIN users u ON u.Id = r.UserId
WHERE r.ProductId = productid$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE IF NOT EXISTS `brands` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` tinytext NOT NULL,
  `Description` text NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`Id`, `Name`, `Description`) VALUES
(1, 'Dolce & Gabbana', 'This is Dolce & Gabbana.'),
(2, 'Armani', 'This is Armani.'),
(3, 'Versace', 'This is Versace.');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE IF NOT EXISTS `products` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `ProductName` tinytext NOT NULL,
  `Description` text NOT NULL,
  `Price` float NOT NULL,
  `Colour` text NOT NULL,
  `DateCreated` datetime NOT NULL,
  `Availability Status` tinytext NOT NULL,
  `BrandId` int(11) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`Id`, `ProductName`, `Description`, `Price`, `Colour`, `DateCreated`, `Availability Status`, `BrandId`) VALUES
(1, 'Black & White', 'Black & White', 530, '[''default'']', '2016-03-08 05:00:00', 'In Stock', 1),
(2, 'Black & White Dress', 'Black & White Dress', 500, '[''default'']', '2016-03-03 08:00:00', 'In Stock', 1),
(3, 'White Dress', 'White Dress', 600, '[''default'']', '2016-03-07 06:00:00', 'In Stock', 1),
(4, 'Apple Dress', 'Apple Dress', 700, '[''default'']', '2016-03-06 09:00:00', 'Out Of Stock', 1),
(5, 'Armani Black Dress', 'Armani', 700, '[''black'']', '2016-03-04 09:00:00', 'In Stock', 2),
(6, 'Armari Red High Heel', 'Armani', 300, '[''red'']', '2016-03-04 00:00:00', 'In Stock', 2),
(7, 'Armani Red Wallet', 'Armani', 200, '[''red'']', '2016-03-02 00:00:00', 'Out Of Stock', 2),
(8, 'Versace Black T-Shirt', 'Versace', 200, '[''black'']', '2016-03-03 09:00:00', 'Out Of Stock', 3),
(9, 'Versace White T-Shirt', 'Versace', 200, '[''white'']', '2016-03-01 08:00:00', 'In Stock', 3),
(10, 'Versace White T-Shirt 2016', 'Versace', 300, '[''white'']', '2016-03-03 00:00:00', 'In Stock', 3);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE IF NOT EXISTS `reviews` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Rating` tinyint(10) NOT NULL,
  `Comment` text NOT NULL,
  `ProductId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=49 ;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`Id`, `Rating`, `Comment`, `ProductId`, `UserId`) VALUES
(1, 3, 'This is Great', 1, 1),
(2, 7, 'This is Good', 2, 1),
(3, 8, 'This is beautyful', 1, 1),
(25, 7, 'Cool !', 1, 1),
(26, 5, 'Great !', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserType` int(11) NOT NULL,
  `UserName` varchar(30) NOT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `DateOfBirth` date NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`Id`, `UserType`, `UserName`, `Email`, `DateOfBirth`) VALUES
(1, 1, 'Customer1', 'customer1@gmail.com', '1991-05-09'),
(2, 1, 'Customer2', 'customer2@gmail.com', '1991-03-01');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
