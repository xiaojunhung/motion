-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 產生時間： 2017 年 02 月 12 日 15:34
-- 伺服器版本: 10.1.16-MariaDB
-- PHP 版本： 5.5.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `pedtacdb`
--

-- --------------------------------------------------------

--
-- 資料表結構 `AccelerationData`
--

CREATE TABLE `AccelerationData` (
  `ID` int(11) NOT NULL,
  `AccX` double NOT NULL,
  `AccY` double NOT NULL,
  `AccZ` double NOT NULL,
  `MsgX` double NOT NULL,
  `MsgY` double NOT NULL,
  `MsgZ` double NOT NULL,
  `PhoneDataTime` datetime NOT NULL,
  `PhoneID` varchar(50) NOT NULL,
  `TrackingID` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='追蹤用數據';

-- --------------------------------------------------------

--
-- 資料表結構 `MagneticData`
--

CREATE TABLE `MagneticData` (
  `ID` int(11) NOT NULL,
  `AxisX` double NOT NULL,
  `AxisY` double NOT NULL,
  `MsgX` double NOT NULL,
  `MsgY` double NOT NULL,
  `MsgZ` double NOT NULL,
  `DataTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='地磁辨識資料';

--
-- 已匯出資料表的索引
--

--
-- 資料表索引 `AccelerationData`
--
ALTER TABLE `AccelerationData`
  ADD PRIMARY KEY (`ID`);

--
-- 資料表索引 `MagneticData`
--
ALTER TABLE `MagneticData`
  ADD PRIMARY KEY (`ID`);

--
-- 在匯出的資料表使用 AUTO_INCREMENT
--

--
-- 使用資料表 AUTO_INCREMENT `AccelerationData`
--
ALTER TABLE `AccelerationData`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- 使用資料表 AUTO_INCREMENT `MagneticData`
--
ALTER TABLE `MagneticData`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
