-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 24, 2024 at 10:26 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rm_nusantara`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_pemesanan` (IN `p_id_pelanggan` INT, IN `p_total` DECIMAL(10,2))   BEGIN
    DECLARE v_id_pemesanan INT;
    DECLARE v_tanggal DATE;
    
    SET v_tanggal = CURDATE();
    
    -- Insert into pemesanan
    INSERT INTO pemesanan (id_pelanggan, tanggal, total)
    VALUES (p_id_pelanggan, v_tanggal, p_total);
    
    SET v_id_pemesanan = LAST_INSERT_ID();
    
    -- Control flow using IF statement
    IF p_total > 100000 THEN
        INSERT INTO detail_pemesanan (id_pemesanan, id_menu, jumlah, harga)
        VALUES (v_id_pemesanan, 1, 1, 15000);
    ELSE
        INSERT INTO detail_pemesanan (id_pemesanan, id_menu, jumlah, harga)
        VALUES (v_id_pemesanan, 2, 1, 12000);
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tampilkan_menu` ()   BEGIN
    SELECT * FROM menu;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `total_pemesanan` () RETURNS DECIMAL(10,2)  BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(total) INTO total FROM pemesanan;
    RETURN total;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `total_pemesanan_per_pelanggan` (`id_pelanggan` INT) RETURNS DECIMAL(10,2)  BEGIN
    DECLARE total DECIMAL(10, 2);
    SELECT SUM(total) INTO total FROM pemesanan WHERE id_pelanggan = id_pelanggan;
    RETURN total;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detail_pemesanan`
--

CREATE TABLE `detail_pemesanan` (
  `id` int(11) NOT NULL,
  `id_pemesanan` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `harga` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_pemesanan`
--

INSERT INTO `detail_pemesanan` (`id`, `id_pemesanan`, `id_menu`, `jumlah`, `harga`) VALUES
(1, 1, 1, 2, 30000.00),
(2, 2, 2, 1, 12000.00),
(3, 3, 3, 1, 5000.00),
(4, 4, 4, 1, 10000.00),
(5, 5, 5, 2, 12000.00),
(6, 6, 1, 1, 15000.00),
(7, 8, 2, 1, 12000.00);

-- --------------------------------------------------------

--
-- Table structure for table `karyawan`
--

CREATE TABLE `karyawan` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `jabatan` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `karyawan`
--

INSERT INTO `karyawan` (`id`, `nama`, `jabatan`) VALUES
(1, 'Fajar', 'Koki'),
(2, 'Gilang', 'Pelayan'),
(3, 'Hani', 'Kasir'),
(4, 'Indra', 'Manager'),
(5, 'Joko', 'Pelayan');

-- --------------------------------------------------------

--
-- Table structure for table `karyawan_shift`
--

CREATE TABLE `karyawan_shift` (
  `id` int(11) NOT NULL,
  `id_karyawan` int(11) NOT NULL,
  `shift` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `karyawan_shift`
--

INSERT INTO `karyawan_shift` (`id`, `id_karyawan`, `shift`) VALUES
(1, 1, 'Pagi'),
(2, 2, 'Siang'),
(3, 3, 'Malam'),
(4, 4, 'Pagi'),
(5, 5, 'Malam');

-- --------------------------------------------------------

--
-- Table structure for table `log_pelanggan`
--

CREATE TABLE `log_pelanggan` (
  `id` int(11) NOT NULL,
  `id_pelanggan` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `telepon` varchar(15) DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  `timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `log_pelanggan`
--

INSERT INTO `log_pelanggan` (`id`, `id_pelanggan`, `nama`, `alamat`, `telepon`, `action`, `timestamp`) VALUES
(1, 0, 'Fauzan', 'Jl. Kebon Jeruk', '081234567895', 'BEFORE INSERT', '2024-07-24 14:56:12'),
(2, 6, 'Fauzan', 'Jl. Kebon Jeruk', '081234567895', 'AFTER INSERT', '2024-07-24 14:56:12'),
(3, 1, 'Andi', 'Jl. Merdeka 1', '081234567890', 'BEFORE UPDATE', '2024-07-24 14:57:09'),
(4, 1, 'Andi', 'Jl. Kebon Kelapa', '081234567890', 'AFTER UPDATE', '2024-07-24 14:57:09');

-- --------------------------------------------------------

--
-- Table structure for table `log_pemesanan`
--

CREATE TABLE `log_pemesanan` (
  `id` int(11) NOT NULL,
  `id_pemesanan` int(11) DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  `timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `log_pemesanan`
--

INSERT INTO `log_pemesanan` (`id`, `id_pemesanan`, `action`, `timestamp`) VALUES
(1, 1, 'INSERT', '2024-07-24 14:59:53'),
(2, 2, 'UPDATE', '2024-07-24 14:59:53'),
(3, 3, 'DELETE', '2024-07-24 14:59:53'),
(4, 1, 'UPDATE', '2024-07-24 14:59:53'),
(5, 2, 'INSERT', '2024-07-24 14:59:53');

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  `kategori` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id`, `nama`, `harga`, `kategori`) VALUES
(1, 'Nasi Goreng', 15000.00, 'Makanan'),
(2, 'Mie Goreng', 12000.00, 'Makanan'),
(3, 'Teh Manis', 5000.00, 'Minuman'),
(4, 'Jus Jeruk', 10000.00, 'Minuman'),
(5, 'Es Teh', 6000.00, 'Minuman');

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `telepon` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id`, `nama`, `alamat`, `telepon`) VALUES
(1, 'Andi', 'Jl. Kebon Kelapa', '081234567890'),
(2, 'Budi', 'Jl. Merdeka 2', '081234567891'),
(3, 'Citra', 'Jl. Merdeka 3', '081234567892'),
(4, 'Dewi', 'Jl. Merdeka 4', '081234567893'),
(5, 'Eka', 'Jl. Merdeka 5', '081234567894'),
(6, 'Fauzan', 'Jl. Kebon Jeruk', '081234567895');

--
-- Triggers `pelanggan`
--
DELIMITER $$
CREATE TRIGGER `after_delete_pelanggan` AFTER DELETE ON `pelanggan` FOR EACH ROW BEGIN
    INSERT INTO log_pelanggan (id_pelanggan, nama, alamat, telepon, action) 
    VALUES (OLD.id, OLD.nama, OLD.alamat, OLD.telepon, 'AFTER DELETE');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_pelanggan` AFTER INSERT ON `pelanggan` FOR EACH ROW BEGIN
    INSERT INTO log_pelanggan (id_pelanggan, nama, alamat, telepon, action) 
    VALUES (NEW.id, NEW.nama, NEW.alamat, NEW.telepon, 'AFTER INSERT');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_update_pelanggan` AFTER UPDATE ON `pelanggan` FOR EACH ROW BEGIN
    INSERT INTO log_pelanggan (id_pelanggan, nama, alamat, telepon, action) 
    VALUES (NEW.id, NEW.nama, NEW.alamat, NEW.telepon, 'AFTER UPDATE');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_delete_pelanggan` BEFORE DELETE ON `pelanggan` FOR EACH ROW BEGIN
    INSERT INTO log_pelanggan (id_pelanggan, nama, alamat, telepon, action) 
    VALUES (OLD.id, OLD.nama, OLD.alamat, OLD.telepon, 'BEFORE DELETE');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_insert_pelanggan` BEFORE INSERT ON `pelanggan` FOR EACH ROW BEGIN
    INSERT INTO log_pelanggan (id_pelanggan, nama, alamat, telepon, action) 
    VALUES (NEW.id, NEW.nama, NEW.alamat, NEW.telepon, 'BEFORE INSERT');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `before_update_pelanggan` BEFORE UPDATE ON `pelanggan` FOR EACH ROW BEGIN
    INSERT INTO log_pelanggan (id_pelanggan, nama, alamat, telepon, action) 
    VALUES (OLD.id, OLD.nama, OLD.alamat, OLD.telepon, 'BEFORE UPDATE');
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pemesanan`
--

CREATE TABLE `pemesanan` (
  `id` int(11) NOT NULL,
  `id_pelanggan` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pemesanan`
--

INSERT INTO `pemesanan` (`id`, `id_pelanggan`, `tanggal`, `total`) VALUES
(1, 1, '2024-07-20', 120000.00),
(2, 2, '2024-07-21', 30000.00),
(3, 3, '2024-07-22', 15000.00),
(4, 4, '2024-07-23', 35000.00),
(5, 5, '2024-07-24', 25000.00),
(6, 1, '2024-07-24', 200000.00),
(7, 3, '2024-07-24', 150000.00),
(8, 3, '2024-07-24', 50000.00);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_pelanggan_kontak`
-- (See below for the actual view)
--
CREATE TABLE `view_pelanggan_kontak` (
`id` int(11)
,`nama` varchar(255)
,`telepon` varchar(15)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_pemesanan_besar`
-- (See below for the actual view)
--
CREATE TABLE `view_pemesanan_besar` (
`id` int(11)
,`id_pelanggan` int(11)
,`tanggal` date
,`total` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_pemesanan_besar_simple`
-- (See below for the actual view)
--
CREATE TABLE `view_pemesanan_besar_simple` (
`id` int(11)
,`id_pelanggan` int(11)
);

-- --------------------------------------------------------

--
-- Structure for view `view_pelanggan_kontak`
--
DROP TABLE IF EXISTS `view_pelanggan_kontak`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_pelanggan_kontak`  AS SELECT `pelanggan`.`id` AS `id`, `pelanggan`.`nama` AS `nama`, `pelanggan`.`telepon` AS `telepon` FROM `pelanggan` ;

-- --------------------------------------------------------

--
-- Structure for view `view_pemesanan_besar`
--
DROP TABLE IF EXISTS `view_pemesanan_besar`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_pemesanan_besar`  AS SELECT `pemesanan`.`id` AS `id`, `pemesanan`.`id_pelanggan` AS `id_pelanggan`, `pemesanan`.`tanggal` AS `tanggal`, `pemesanan`.`total` AS `total` FROM `pemesanan` WHERE `pemesanan`.`total` > 100000 ;

-- --------------------------------------------------------

--
-- Structure for view `view_pemesanan_besar_simple`
--
DROP TABLE IF EXISTS `view_pemesanan_besar_simple`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_pemesanan_besar_simple`  AS SELECT `view_pemesanan_besar`.`id` AS `id`, `view_pemesanan_besar`.`id_pelanggan` AS `id_pelanggan` FROM `view_pemesanan_besar`WITH CASCADED CHECK OPTION  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_pemesanan`
--
ALTER TABLE `detail_pemesanan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_menu` (`id_menu`),
  ADD KEY `idx_pemesanan_menu` (`id_pemesanan`,`id_menu`);

--
-- Indexes for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `karyawan_shift`
--
ALTER TABLE `karyawan_shift`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_karyawan` (`id_karyawan`);

--
-- Indexes for table `log_pelanggan`
--
ALTER TABLE `log_pelanggan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `log_pemesanan`
--
ALTER TABLE `log_pemesanan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pemesanan_action` (`id_pemesanan`,`action`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_pelanggan_nama_alamat` (`nama`,`alamat`);

--
-- Indexes for table `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pelanggan` (`id_pelanggan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_pemesanan`
--
ALTER TABLE `detail_pemesanan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `karyawan`
--
ALTER TABLE `karyawan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `karyawan_shift`
--
ALTER TABLE `karyawan_shift`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `log_pelanggan`
--
ALTER TABLE `log_pelanggan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `log_pemesanan`
--
ALTER TABLE `log_pemesanan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pemesanan`
--
ALTER TABLE `pemesanan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_pemesanan`
--
ALTER TABLE `detail_pemesanan`
  ADD CONSTRAINT `detail_pemesanan_ibfk_1` FOREIGN KEY (`id_pemesanan`) REFERENCES `pemesanan` (`id`),
  ADD CONSTRAINT `detail_pemesanan_ibfk_2` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id`);

--
-- Constraints for table `karyawan_shift`
--
ALTER TABLE `karyawan_shift`
  ADD CONSTRAINT `karyawan_shift_ibfk_1` FOREIGN KEY (`id_karyawan`) REFERENCES `karyawan` (`id`);

--
-- Constraints for table `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD CONSTRAINT `pemesanan_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
