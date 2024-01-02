-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 22, 2023 at 01:17 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sijali`
--

-- --------------------------------------------------------

--
-- Table structure for table `bantuan_balasan`
--

CREATE TABLE `bantuan_balasan` (
  `id` int(3) NOT NULL,
  `id_user` int(3) NOT NULL,
  `balasan` varchar(250) NOT NULL,
  `timestamp` varchar(10) NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bantuan_permasalahan`
--

CREATE TABLE `bantuan_permasalahan` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `jenis_bantuan` varchar(40) NOT NULL,
  `deskripsi` text NOT NULL,
  `foto` text NOT NULL,
  `status` varchar(10) NOT NULL,
  `balasan` text NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bantuan_permasalahan`
--

INSERT INTO `bantuan_permasalahan` (`id`, `id_user`, `jenis_bantuan`, `deskripsi`, `foto`, `status`, `balasan`, `timestamp`) VALUES
(4, 2, 'Permasalahan Kasus Batas', 'Lorem Ipsum adalah contoh teks atau dummy dalam industri percetakan dan penataan huruf atau typesetting. Lorem Ipsum telah menjadi standar contoh teks sejak tahun 1500an, saat seorang tukang cetak yang tidak dikenal mengambil sebuah kumpulan teks dan mengacaknya untuk menjadi sebuah buku contoh huruf.', 'uploads/66cd7a5d-e573-4847-ad17-fc6dced4e6b04288259665544453797.jpg', 'unread', 'okee', '2023-12-16 00:00:00'),
(5, 2, 'Permasalahan Kasus Batas', 'ada masalah nih bos bagaimana jika pisang gorengnya itu bukan milih sendiri', 'uploads/fb76e58c-844e-4871-914f-91e5239f88072690444104607756531.jpg', 'unread', 'okeee', '2023-12-16 00:00:00'),
(6, 2, 'Permasalahan Kasus Batas', 'aaaaa', 'uploads/bantuan_permasalahan/d2094429-3071-4a36-af68-d44b9f19c51b2633120633427773815.jpg', 'unread', '', '2023-12-16 00:00:00'),
(7, 2, 'Permasalahan Kasus Batas', 'halo bantu saya', 'uploads/bantuan_permasalahan/22097ab7-801f-45c4-9e6d-211f964a24fa7169248134665925742.jpg', 'unread', 'iya saya bantu', '2023-12-16 00:00:00'),
(8, 4, 'Permasalahan Kasus Batas', 'dd\n\n', 'uploads/bantuan_permasalahan/10f415cf-6fce-4c49-8ee6-68cab0e658908857206451226862208.jpg', 'unread', '', '2023-12-16 00:00:00'),
(9, 4, 'Permasalahan Kasus Batas', 'dd\n\n', 'uploads/bantuan_permasalahan/10f415cf-6fce-4c49-8ee6-68cab0e658908857206451226862208.jpg', 'unread', 'coba cek\n', '2023-12-16 00:00:00'),
(10, 4, 'Permasalahan Kasus Batas', 'CJ GG ufjgdzjhdgmgxjxjgxjggx\n', 'uploads/bantuan_permasalahan/8f2c7f90-b0e0-40b6-a1c0-28d1ee8acd717027031798773132904.jpg', 'unread', '', '2023-12-16 00:00:00'),
(11, 4, 'Permasalahan Kasus Batas', 'txt xhjbkbgcubibibjb', 'uploads/bantuan_permasalahan/69bc1322-4b4b-466b-8ab7-60a2b05bebeb1920607180895868152.jpg', 'unread', '', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `bantuan_usulan`
--

CREATE TABLE `bantuan_usulan` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `jenis_bantuan` varchar(40) NOT NULL,
  `deskripsi` text NOT NULL,
  `longitude` double NOT NULL,
  `latitude` double NOT NULL,
  `foto` text NOT NULL,
  `status` varchar(10) NOT NULL,
  `balasan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bantuan_usulan`
--

INSERT INTO `bantuan_usulan` (`id`, `id_user`, `jenis_bantuan`, `deskripsi`, `longitude`, `latitude`, `foto`, `status`, `balasan`) VALUES
(6, 2, 'Usulan Kasus Batas', 'halo saya ada usulan mengenai kasus batas di daerah thousand island nih mengenai gen z di pulau Bali', -122.084, 37.4219983, 'uploads/5421015f-07bd-4c87-b7c0-6df97353e9d83608628463006778407.jpg', 'unread', 'oke baik tim kami sedang melakukan investigasi'),
(7, 2, 'Usulan Kasus Batas', 'Lorem Ipsum adalah contoh teks atau dummy dalam industri percetakan dan penataan huruf atau typesetting. Lorem Ipsum telah menjadi standar contoh teks sejak tahun 1500an, saat seorang tukang cetak yang tidak dikenal mengambil sebuah kumpulan teks dan mengacaknya untuk menjadi sebuah buku contoh huruf. Lorem Ipsum adalah contoh teks atau dummy dalam industri percetakan dan penataan huruf atau typesetting. Lorem Ipsum telah menjadi standar contoh teks sejak tahun 1500an, saat seorang tukang cetak yang tidak dikenal mengambil sebuah kumpulan teks dan mengacaknya untuk menjadi sebuah buku contoh huruf.', -122.084, 37.4219983, 'uploads/843d686c-77af-476c-9215-8f8705337d976690546448448743509.jpg', 'unread', 'oke baby'),
(8, 2, 'Usulan Kasus Batas', 'haloooo', -122.084, 37.4219983, 'uploads/060ec908-1eec-4110-a084-c3508482ad9d925434067046853342.jpg', 'unread', 'halo ges'),
(9, 2, 'Usulan Kasus Batas', 'aaaaa', -122.084, 37.4219983, 'uploads/cf001018-7879-4f14-887d-ef181555615e1805903682919336203.jpg', 'unread', ''),
(10, 2, 'Usulan Kasus Batas', 'aaaa', 0, 122, 'uploads/5103cb83-c311-4217-841d-e028f266921e8896790417041251836.jpg', 'unread', ''),
(11, 2, 'Usulan Kasus Batas', 'aaaa', -122.084, 37.4219983, 'uploads/bantuan_usulan/a2827160-7694-4fb7-ba5b-79d83760806e669195258892750913.jpg', 'unread', ''),
(12, 2, 'Usulan Kasus Batas', 'aaaa', -122.084, 37.4219983, 'uploads/bantuan_usulan/4b5e38c4-aba6-458e-89ec-43bdfc6859775768553240592407466.jpg', 'unread', ''),
(13, 2, 'Usulan Kasus Batas', 'bantu tolong', -122.084, 37.4219983, 'uploads/bantuan_usulan/76f5175a-cf64-4341-bed1-58a8c1f61e285587999798814257430.jpg', 'unread', ''),
(14, 2, 'Usulan Kasus Batas', 'usulan 1', -122.084, 37.4219983, 'uploads/bantuan_usulan/d67f7555-5eef-43e8-ba4d-10d69e461fbf8525237284665820131.jpg', 'unread', ''),
(15, 2, 'Usulan Kasus Batas', 'usul 1', -122.084, 37.4219983, 'uploads/bantuan_usulan/eaca4404-5242-4f2c-8c6b-37fc8b75ab423070105623448225670.jpg', 'unread', '');

-- --------------------------------------------------------

--
-- Table structure for table `kasus_batas`
--

CREATE TABLE `kasus_batas` (
  `id` int(11) NOT NULL,
  `jenis_usaha` text NOT NULL,
  `uraian_kegiatan` text NOT NULL,
  `kd_kategori` varchar(20) NOT NULL,
  `rincian_kategori` text NOT NULL,
  `kd_kbli` varchar(20) NOT NULL,
  `deskripsi_kbli` text NOT NULL,
  `foto` text NOT NULL,
  `tanggal` date DEFAULT NULL,
  `waktu` time DEFAULT NULL,
  `status_kb` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kasus_batas`
--

INSERT INTO `kasus_batas` (`id`, `jenis_usaha`, `uraian_kegiatan`, `kd_kategori`, `rincian_kategori`, `kd_kbli`, `deskripsi_kbli`, `foto`, `tanggal`, `waktu`, `status_kb`) VALUES
(1, 'Bisnis online', 'Penyediakan portal untuk informasi dan komunikasi, seperti Google, Facebook, portal berita. Termasuk platform digital untuk transaksi penjualan, seperti  lazada.com, bhinneka.com, amazon.com, olx.com, operator gojek, bukalapak.com dan portal-portal web dan flatform digital yang berorientasi profit ', 'J', 'Informasi dan komunikasi', '63122', 'Portal web dan/atau platform digital dengan tujuan komersial', '', NULL, NULL, ''),
(2, 'Bisnis online', 'Aktivitas Penyelenggara Transaksi Perdagangan Melalui Sistem Elektronik (PTPMSE), seperti penyedia marketplace, price grabber, daily deals, iklan baris online juga diklasifikasikan di kelompok yang sama.', 'J', 'Informasi dan komunikasi', '63122', 'Portal web dan/atau platform digital dengan tujuan komersial', '', NULL, NULL, ''),
(3, 'Pemilihan (sortasi), pembersihan dan pengupasan kopi, baik menggunakan mesin maupun tanpa mesin', 'Pemilihan (sortasi), pembersihan dan pengupasan kopi, baik menggunakan mesin maupun tanpa mesin. Kopinya berasal dari pembelian.', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobil dan sepeda motor', '46209', 'Perdagangan besar hasil pertanian dan hewan hidup lainnya', '', NULL, NULL, ''),
(4, 'Pemilihan (sortasi), pembersihan dan pengupasan kopi, baik menggunakan mesin maupun tanpa mesin', 'Pemilihan (sortasi), pembersihan dan pengupasan kopi, baik menggunakan mesin maupun tanpa mesin. Kopinya berasal dari pembelian.', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobil dan sepeda motor', '47219', 'Perdagangan eceran hasil pertanian lainnya ', '', NULL, NULL, ''),
(5, 'Pembuatan gaplek', 'Bahan bakunya berasal dari kebun sendiri, atau bahan bakunya berasal dari pembelian', 'C', 'Industri pengolahan', '10313', 'Industri pengeringan buah-buahan dan sayuran ', '', NULL, NULL, ''),
(6, 'Pembuatan gaplek', 'Bahan bakunya berasal dari kebun sendiri, atau bahan bakunya berasal dari pembelian', 'C', 'Industri pengolahan', '10613', 'Industri Penggilingan Aneka Umbi dan Sayuran (Termasuk Rhizoma)', '', NULL, NULL, ''),
(7, 'Penjahit', 'Usaha menjahit pakaian/konveksi', 'C', 'Industri pengolahan', '14111', 'Industri pakaian jadi (konveksi) dari tekstil', '', NULL, NULL, ''),
(8, 'Penjahit', 'Usaha menjahit pakaian/konveksi', 'C', 'Industri pengolahan', '14131', 'Industri perlengkapan pakaian dari tekstil', '', NULL, NULL, ''),
(9, 'Penjahit', 'Jika melayani perorangan/tailor bahan dari penjahit atau konsumen.', 'C', 'Industri pengolahan', '14120', 'Penjahitan dan pembuatan pakaian sesuai pesanan', '', NULL, NULL, ''),
(10, 'Penjahit', 'Jika melayani hanya vermak pakaian (tanpa menjahit pakaian baru)', 'S', 'Aktivitas jasa lainnya', '95291', 'Aktivitas vermak pakaian', '', NULL, NULL, ''),
(11, 'Usaha kost', 'Usaha kost, baik dengan makan maupun tanpa makan ', 'I', 'Penyediaan akomodasi & penyediaan makan minum', '55900', 'Penyediaan akomodasi lainnya', '', NULL, NULL, ''),
(12, 'Usaha real estat', 'Pembelian, penjualan, persewaan, dan pengoperasian bangunan baik yang mengusahakan kegiatan konstruksi maupun tidak (jika yang disewakan adalah satu rumah secara utuh, dalam waktu berbulan-bulan dan tidak ada sevice/ pelayanan tambahan, biasa disebut kontrakan rumah).', 'L', 'Realestat', '68111', 'Real estat yang dimiliki sendiri atau disewa�', '', NULL, NULL, ''),
(13, 'Usaha real estat', 'Pembelian, penjualan, persewaan, dan pengoperasian bangunan baik yang mengusahakan kegiatan konstruksi maupun tidak (jika yang disewakan adalah satu rumah secara utuh, dalam waktu berbulan-bulan dan tidak ada sevice/ pelayanan tambahan, biasa disebut kontrakan rumah).', 'L', 'Realestat', '68200', 'Real estat atas dasar balas jasa (fee) atau kontrak', '', NULL, NULL, ''),
(14, 'Penyewaan kendaraan ', 'Usaha penyewaan bus/ mobil/angkutan wisata dengan operator. Contoh: Big Bird, White Horse, Hiba Utama.', 'H', 'Pengangkutan dan pergudangan', '49221', 'Angkutan bus pariwisata', '', NULL, NULL, ''),
(15, 'Penyewaan kendaraan ', 'Usaha penyewaan bus/ mobil/angkutan wisata dengan operator. Contoh: Big Bird, White Horse, Hiba Utama.', 'H', 'Pengangkutan dan pergudangan', '49229', 'Angkutan bus tidak dalam trayek lainnya', '', NULL, NULL, ''),
(16, 'Penyewaan kendaraan ', 'Usaha penyewaan bus/ mobil/angkutan wisata dengan operator. Contoh: Big Bird, White Horse, Hiba Utama.', 'H', 'Pengangkutan dan pergudangan', '49422', 'Angkutan sewa', '', NULL, NULL, ''),
(17, 'Penyewaan kendaraan ', 'Usaha penyewaan bus/ mobil/angkutan wisata dengan operator. Contoh: Big Bird, White Horse, Hiba Utama.', 'H', 'Pengangkutan dan pergudangan', '49425', 'Angkutan darat untuk wisata', '', NULL, NULL, ''),
(18, 'Penyewaan kendaraan ', 'Usaha penyewaan bus/ mobil/angkutan wisata tanpa operator. Contoh: astra rent car, mobil carter', 'N', 'Aktivitas penyewaan dan sewa guna usaha tanpa hak opsi, ketenagaker-jaan, agen perjalanan & penunjang usaha lainnya', '77100', 'Aktivitas penyewaan dan sewa guna usaha tanpa hak opsi mobil, bus, truk dan sejenisnya', '', NULL, NULL, ''),
(19, 'Penyewaan kendaraan ', 'Usaha penyewaan sepeda motor dan sepeda tanpa operator', 'N', 'Aktivitas penyewaan dan sewa guna usaha tanpa hak opsi, ketenagaker-jaan, agen perjalanan & penunjang usaha lainnya', '77311', 'Aktivitas penyewaan dan sewa guna usaha tanpa hak opsi alat transportasi darat bukan kendaraan bermotor roda empat atau lebih', '', NULL, NULL, ''),
(20, 'Penyewaan alat-alat, seperti: traktor, buldozer, dan sebagainya', 'Usaha menyewakan traktor pertanian tanpa operator.', 'N', 'Aktivitas penyewaan dan sewa guna usaha tanpa hak opsi, ketenagaker-jaan, agen perjalanan & penunjang usaha lainnya', '77392', 'Aktivitas penyewaan dan sewa guna usaha tanpa hak opsi mesin pertanian dan peralatannya', '', NULL, NULL, ''),
(21, 'Penyewaan alat-alat, seperti: traktor, buldozer, dan sebagainya', 'Usaha menyewakan traktor, buldozer untuk kegiatan konstruksi bangunan tanpa operator.', 'N', 'Aktivitas penyewaan dan sewa guna usaha tanpa hak opsi, ketenagaker-jaan, agen perjalanan & penunjang usaha lainnya', '77393', 'Aktivitas penyewaan dan sewa guna usaha tanpa hak opsi mesin dan peralatan konstruksi dan teknik sipil', '', NULL, NULL, ''),
(22, 'Penjualan pulsa', 'Perdagangan jasa dikembalikan pada sektornya masing-masing. Pulsa termasuk perdagangan jasa', 'J', 'Informasi dan Komunikasi', '61999', 'Aktivitas telekomunikasi lainnya ytdl', '', NULL, NULL, ''),
(23, 'Membuat  nasi uduk, nasi kuning, nasi mawut, nasi goreng, nasi gurih, es campur, mie goreng', 'Produk utama berupa makanan/ hidangan siap saji dan ada proses peracikan dan penyajian.', 'I', 'Penyediaan akomodasi dan penyediaan makan minum ', '56102', 'Rumah/Warung makan (bangunan tetap)', '', NULL, NULL, ''),
(24, 'Membuat  nasi uduk, nasi kuning, nasi mawut, nasi goreng, nasi gurih, es campur, mie goreng', 'Produk utama berupa makanan/ hidangan siap saji dan ada proses peracikan dan penyajian.', 'I', 'Penyediaan akomodasi dan penyediaan makan minum ', '56103', 'Kedai makanan (bangunan tidak tetap/bisa bongkar pasang)', '', NULL, NULL, ''),
(25, 'Membuat  nasi uduk, nasi kuning, nasi mawut, nasi goreng, nasi gurih, es campur, mie goreng', 'Produk utama hidangan makanan kemasan. Contoh : nasi uduk dalam kemasan (dibungkus)', 'I', 'Penyediaan akomodasi dan penyediaan makan minum ', '56109', 'Restoran dan penyediaan makanan keliling lain', '', NULL, NULL, ''),
(26, 'Katering', 'Jasa katering adalah jasa penyedia makanan berdasarkan kontrak perjanjian untuk waktu tertentu', 'I', 'Penyediaan akomodasi dan penyediaan makan minum ', '56290', 'Penyedia jasa boga periode tertentu', '', NULL, NULL, ''),
(27, 'Katering', 'Jasa katering hanya untuk pesta-pesta yang tidak rutin', 'I', 'Penyediaan akomodasi dan penyediaan makan minum ', '56210', 'Jasa boga untuk suatu event tertentu (event catering)', '', NULL, NULL, ''),
(28, 'Penjual sate, mie tektek, bubur ayam, bakso, batagor, empek-empek, gorengan keliling', 'Membuat makanan yang masih ada proses peracikan dan tidak tahan lama, produk utama berupa makanan siap saji', 'I', 'Penyediaan akomodasi dan penyediaan makan minum', '56104', 'Penyediaan makanan keliling/tempat tidak tetap', '', NULL, NULL, ''),
(29, 'Pembuatan bakso, empek-empek, batagor, cilok mentah', 'Membuat pentol bakso, empek-empek berbasis daging lumatan', 'C', 'Industri pengolahan', '10216', 'Industri berbasis daging lumatan dan surimi', '', NULL, NULL, ''),
(30, 'Pembuatan bakso, empek-empek, batagor, cilok mentah', 'Membuat pentol bakso, empek-empek berbasis ikan dan biota air lainnya', 'C', 'Industri pengolahan', '10296', 'Industri berbasis lumatan biota air lainnya', '', NULL, NULL, ''),
(31, 'Pembuatan bakso, empek-empek, batagor, cilok mentah', 'Membuat pentol bakso berbasis daging dan unggas', 'C', 'Industri pengolahan', '10130', 'Industri pengolahan dan pengawetan produk daging dan daging unggas', '', NULL, NULL, ''),
(32, 'Pembuatan bakso, empek-empek, batagor, cilok mentah', 'Membuat pentol cilok (bahan baku terbuat dari sagu)', 'C', 'Industri pengolahan', '10799', 'Industri produk makanan lainnya', '', NULL, NULL, ''),
(33, 'Pemotongan hewan', 'Pemotongan hewan yang dilakukan oleh rumah potong hewan (RPH).', 'C', 'Industri pengolahan', '10110', 'Kegiatan rumah potong dan pengepakan daging bukan unggas', '', NULL, NULL, ''),
(34, 'Pemotongan hewan', 'Pemotongan hewan yang dilakukan oleh rumah potong hewan (RPH).', 'C', 'Industri pengolahan', '10120', 'Kegiatan rumah potong dan pengepakan daging unggas', '', NULL, NULL, ''),
(35, 'Pemotongan hewan', 'Pemotongan hewan yang dilakukan oleh rumah potong hewan (RPH).', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobildan sepeda motor', '47214', 'Perdagangan eceran hasil peternakan', '', NULL, NULL, ''),
(36, 'Pemotongan hewan', 'Pemotongan hewan yang dilakukan oleh rumah potong hewan (RPH).', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobildan sepeda motor', '47752', 'Perdagangan eceran hewan ternak', '', NULL, NULL, ''),
(37, 'Penggaraman/ pengeringan, pengasapan, pemindangan dan pembekuan ikan', 'Usaha penggaraman/pengeringan, pengasapan, pemindangan dan pembekuan ikan. Produk akhir berupa ikan asin, ikan asap, ikan pindang, ikan kaleng, dll.', 'C', 'Industri pengolahan', '102', 'Industri pengolahan dan pengawetan ikan dan biota air (10211 s.d. 10299)', '', NULL, NULL, ''),
(38, 'Pengolahan minyak makan', 'Usaha pengolahan minyak makan yang dilakukan usaha pertaniannya. Produk akhir berupa minyak makan ', 'C', 'Industri pengolahan', '10411', 'Industri minyak mentah dan lemak nabati', '', NULL, NULL, ''),
(39, 'Pengolahan minyak makan', 'Usaha pengolahan minyak makan yang dilakukan usaha pertaniannya. Produk akhir berupa minyak makan ', 'C', 'Industri pengolahan', '10412', 'Industri margarine', '', NULL, NULL, ''),
(40, 'Pengolahan minyak makan', 'Usaha pengolahan minyak makan yang dilakukan usaha pertaniannya. Produk akhir berupa minyak makan ', 'C', 'Industri pengolahan', '10413', 'Industri minyak mentah dan lemak hewani selain ikan', '', NULL, NULL, ''),
(41, 'Pengolahan minyak makan', 'Usaha pengolahan minyak makan yang dilakukan usaha pertaniannya. Produk akhir berupa minyak makan ', 'C', 'Industri pengolahan', '10422', 'Industri minyak mentah kelapa', '', NULL, NULL, ''),
(42, 'Pengolahan minyak makan', 'Usaha pengolahan minyak makan yang dilakukan usaha pertaniannya. Produk akhir berupa minyak makan ', 'C', 'Industri pengolahan', '10423', 'Industri Minyak Goreng Kelapa', '', NULL, NULL, ''),
(43, 'Pengolahan minyak makan', 'Usaha pengolahan minyak makan yang dilakukan usaha pertaniannya. Produk akhir berupa minyak makan ', 'C', 'Industri pengolahan', '10431', 'Industri minyak mentah kelapa sawit (CPO)', '', NULL, NULL, ''),
(44, 'Pengolahan minyak makan', 'Usaha pengolahan minyak makan yang dilakukan usaha pertaniannya. Produk akhir berupa minyak makan ', 'C', 'Industri pengolahan', '10432', 'Industri minyak mentah inti kelapa sawit (CPKO)', '', NULL, NULL, ''),
(45, 'Pengolahan minyak makan', 'Usaha pengolahan minyak makan yang dilakukan usaha pertaniannya. Produk akhir berupa minyak makan ', 'C', 'Industri pengolahan', '10437', 'Industri minyak goreng kelapa sawit', '', NULL, NULL, ''),
(46, 'Pemerahan/ pengolahan susu', 'Pengolahan susu. Produk akhir berupa susu olahan. ', 'C', 'Industri pengolahan', '10510', 'Industri pengolahan susu segar dan krim', '', NULL, NULL, ''),
(47, 'Pemerahan/ pengolahan susu', 'Pengolahan susu. Produk akhir berupa susu olahan. ', 'C', 'Industri pengolahan', '10520', 'Industri pengolahan susu bubuk dan susu kental', '', NULL, NULL, ''),
(48, 'Penggilingan padi/gabah', 'Menggiling padi/gabah  dengan huller/rice milling unit. Produk akhir berupa beras. ', 'C', 'Industri pengolahan ', '10631', 'Industri penggilingan padi dan penyosohan beras', '', NULL, NULL, ''),
(49, 'Penyosohan beras, baik menggunakan mesin atau tidak', 'Penyosohan beras untuk meningkatkan kualitas beras, yang dapat dipisahkan dari usaha pertaniannya.', 'C', 'Industri pengolahan', '10631', 'Industri penggilingan padi dan penyosohan beras', '', NULL, NULL, ''),
(50, 'Pembuatan kopra', 'Bahan bakunya berasal dari kebun sendiri, atau bahan bakunya berasal dari pembelian. ', 'C', 'Industri pengolahan', '10421', 'Industri kopra', '', NULL, NULL, ''),
(51, 'Pembuatan ransum dan konsentrat pakan ternak', 'Produk akhir berupa ransum dan konsentrat pakan ternak ', 'C', 'Industri pengolahan', '10801', 'Industri ransum makanan hewan', '', NULL, NULL, ''),
(52, 'Pembuatan ransum dan konsentrat pakan ternak', 'Produk akhir berupa ransum dan konsentrat pakan ternak ', 'C', 'Industri pengolahan', '10802', 'Industri konsentrat makanan hewan', '', NULL, NULL, ''),
(53, 'Pembuatan gula aren, gula kelapa dan gula tebu', 'Pembuatan gula aren, gula kelapa dan gula tebu yang bahan bakunya berasal dari kebun sendiri dan dapat dipisahkan dari usaha pertaniannya, atau dari pembelian', 'C', 'Industri pengolahan', '10721', 'Industri gula pasir', '', NULL, NULL, ''),
(54, 'Pembuatan gula aren, gula kelapa dan gula tebu', 'Pembuatan gula aren, gula kelapa dan gula tebu yang bahan bakunya berasal dari kebun sendiri dan dapat dipisahkan dari usaha pertaniannya, atau dari pembelian', 'C', 'Industri pengolahan', '10722', 'Industri gula merah', '', NULL, NULL, ''),
(55, 'Pengeringan buah kopi, daun teh dan daun tembakau ', 'Produk akhir berupa biji kopi, daun teh kering, dan daun tembakau kering dengan alat pengering', 'C', 'Industri pengolahan', '10313', 'Industri pengeringan buah-buahan dan sayuran', '', NULL, NULL, ''),
(56, 'Pengeringan buah kopi, daun teh dan daun tembakau ', 'Produk akhir berupa biji kopi, daun teh kering, dan daun tembakau kering dengan alat pengering', 'C', 'Industri pengolahan', '12091', 'Industri pengeringan dan pengolahan tembakau', '', NULL, NULL, ''),
(57, 'Penggilingan kopi', 'Penggilingan kopi yang dilakukan pedagang dan hasilnya langsung dijual kepada konsumen akhir.', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobildan sepeda motor', '47243', 'Perdagangan eceran kopi, gula pasir dan gula merah', '', NULL, NULL, ''),
(58, 'Penggilingan kopi', 'Penggilingan kopi yang hasilnya dijual melalui perantara/pedagang atau langsung diekspor.', 'C', 'Industri pengolahan', '10761', 'Industri pengolahan kopi ', '', NULL, NULL, ''),
(59, 'Pembuatan bungkus rokok dari klobot/ daun nipah', 'Bahan bakunya berasal baik dari pembelian maupun kebun sendiri.', 'C', 'Industri pengolahan', '12099', 'Industri bumbu rokok serta kelengkapan rokok lainnya', '', NULL, NULL, ''),
(60, 'Pengolahan kapuk', 'Pengolahan kapuk yang bahan bakunya baik berasal dari kebun sendiri atau pembelian. Produk akhirnya adalah kapuk.', 'C', 'Industri pengolahan', '13995', 'Industri kapuk', '', NULL, NULL, ''),
(61, 'Pengulitan rotan', 'Pengulitan rotan yang bahan bakunya berasal dari pembelian.', 'C', 'Industri pengolahan', '16104', 'Industri pengolahan rotan', '', NULL, NULL, ''),
(62, 'Pembuatan arang', 'Pembuatan arang dengan cara modern', 'C', 'Industri pengolahan', '20115', 'Industri Kimia Dasar Organik Yang Bersumber Dari Hasil\r\nPertanian', '', NULL, NULL, ''),
(63, 'Penggergajian kayu/papan', 'Usaha penggergajian kayu gelondongan menjadi balok, papan dan sebagainya.', 'C', 'Industri pengolahan', '16101', 'Industri penggergajian kayu', '', NULL, NULL, ''),
(64, 'Pengasinan telur', 'Bahan bakunya berasal dari hasil peternakan sendiri maupun berasal dari pembelian.', 'C', 'Industri pengolahan', '10799', 'Industri produk makanan lainnya', '', NULL, NULL, ''),
(65, 'Pembuatan tepung beras, tepung sagu dan tepung ketela pohon', 'Pembuatan tepung beras, tepung sagu dan tepung ketela pohon, baik bahan bakunya berasal dari kebun sendiri maupun dari pembelian atau dari pihak lain.', 'C', 'Industri pengolahan', '10613', 'Industri penggilingan aneka umbi dan sayuran (termasuk rhizoma)', '', NULL, NULL, ''),
(66, 'Pembuatan tepung beras, tepung sagu dan tepung ketela pohon', 'Pembuatan tepung beras, tepung sagu dan tepung ketela pohon, baik bahan bakunya berasal dari kebun sendiri maupun dari pembelian atau dari pihak lain.', 'C', 'Industri pengolahan', '10616', 'Industri tepung terigu', '', NULL, NULL, ''),
(67, 'Pembuatan tepung beras, tepung sagu dan tepung ketela pohon', 'Pembuatan tepung beras, tepung sagu dan tepung ketela pohon, baik bahan bakunya berasal dari kebun sendiri maupun dari pembelian atau dari pihak lain.', 'C', 'Industri pengolahan', '10621', 'Industri pati ubi kayu', '', NULL, NULL, ''),
(68, 'Pembuatan tepung beras, tepung sagu dan tepung ketela pohon', 'Pembuatan tepung beras, tepung sagu dan tepung ketela pohon, baik bahan bakunya berasal dari kebun sendiri maupun dari pembelian atau dari pihak lain.', 'C', 'Industri pengolahan', '10622', 'Industri berbagai macam pati palma', '', NULL, NULL, ''),
(69, 'Pembuatan tepung beras, tepung sagu dan tepung ketela pohon', 'Pembuatan tepung beras, tepung sagu dan tepung ketela pohon, baik bahan bakunya berasal dari kebun sendiri maupun dari pembelian atau dari pihak lain.', 'C', 'Industri pengolahan', '10633', 'Industri tepung beras dan tepung jagung', '', NULL, NULL, ''),
(70, 'Pembuatan dendeng dan abon', 'Usaha pembuatan dendeng dan abon, dijual melalui perantara atau penjaja atau dijual langsung kepada konsumen akhir tanpa perantara. ', 'C', 'Industri pengolahan', '10130', 'Industri pengolahan dan pengawetan produk daging dan daging unggas', '', NULL, NULL, ''),
(71, 'Pembuatan es ', 'Pembuatan es lilin, es mambo, yang sejenis dijual melalui perantara/ penjaja atau dijual langsung kepada konsumen akhir tanpa perantara.', 'C', 'Industri pengolahan', '10532', 'Industri pengolahan es sejenisnya yang dapat dimakan (bukan es batu dan es balok)', '', NULL, NULL, ''),
(72, 'Pembuatan es ', 'Produksi es batu/ es balok', 'D', 'Pengadaan listrik, gas, uap/ air panas dan udara dingin', '35302', 'Produksi es', '', NULL, NULL, ''),
(73, 'Pembuatan tahu, tempe, oncom dan tauco', 'Pembuatan tahu, tempe, oncom dan tauco, baik dijual langsung kepada konsumen akhir maupun dijual melalui perantara. ', 'C', 'Industri pengolahan', '10391', 'Industri tempe kedelai', '', NULL, NULL, ''),
(74, 'Pembuatan tahu, tempe, oncom dan tauco', 'Pembuatan tahu, tempe, oncom dan tauco, baik dijual langsung kepada konsumen akhir maupun dijual melalui perantara. ', 'C', 'Industri pengolahan', '10392', 'Industri tahu kedelai', '', NULL, NULL, ''),
(75, 'Pembuatan tahu, tempe, oncom dan tauco', 'Pembuatan tahu, tempe, oncom dan tauco, baik dijual langsung kepada konsumen akhir maupun dijual melalui perantara. ', 'C', 'Industri pengolahan', '10771', 'Industri kecap', '', NULL, NULL, ''),
(76, 'Pembuatan tahu, tempe, oncom dan tauco', 'Pembuatan tahu, tempe, oncom dan tauco, baik dijual langsung kepada konsumen akhir maupun dijual melalui perantara. ', 'C', 'Industri pengolahan', '10779', 'Industri produk masak lainnya', '', NULL, NULL, ''),
(77, 'Percetakan', 'Usaha pencetakan buku, majalah, koran, dan sebagainya; Menggandakan dengan metode transfer gambar/tulisan dari pelat, sceen atau file kompter ke media seperti kertas, plastik, logam, tekstil, kaca, kayu, dll. Transfer gambar/tulisan dari pelat, sreen atau file komputer misalnya file e-book menjadi buku.', 'C', 'Industri pengolahan', '18111', 'Industri pencetakan umum', '', NULL, NULL, ''),
(78, 'Percetakan', 'Mencetak buku menggunakan mesin fotocopy; Mengkopi atau menggandakan sesuatu tanpa melalui metode transfer gambar/tulisan dari pelat, screen atau file komputer', 'N', 'Aktivitas penyewaan dan sewa guna usaha tanpa hak opsi, ketenaga-kerjaan, agen perjalanan dan penunjang usaha lainnya ', '82190', 'Aktivitas foto kopi, penyiapan dokumen dan aktivitas khusus penunjang kantor lainnya ', '', NULL, NULL, ''),
(79, 'Pembuatan pintu, jendela, dan kusen', 'Usaha pembuatan pintu, jendela, dan kusen baik atas pesanan maupun tidakdan dikerjakan di lokasi bangunan yang sedang dikerjakan oleh pembuat kusen.', 'C', 'Industri pengolahan', '16221', 'Industri barang bangunan dari kayu', '', NULL, NULL, ''),
(80, 'Pembuatan pintu, jendela, dan kusen', 'Usaha pembuatan pintu, jendela, dan kusen baik atas pesanan maupun tidakdan dikerjakan di lokasi bangunan yang sedang dikerjakan oleh pembuat kusen.', 'C', 'Industri pengolahan', '16222', 'Industri bangunan prafabrikasi dari kayu', '', NULL, NULL, ''),
(81, 'Pembuatan pintu, jendela, dan kusen', 'Jika dikerjakan di lokasi bangunan yang sedang dikerjakan oleh pengusaha konstruksi', 'F', 'Konstruksi', '41011', 'Konstruksi gedung tempat tinggal', '', NULL, NULL, ''),
(82, 'Pembuatan pintu, jendela, dan kusen', 'Jika dikerjakan di lokasi bangunan yang sedang dikerjakan oleh pengusaha konstruksi', 'F', 'Konstruksi', '41020', 'Pemasangan bangunan prafabrikasi untuk gedung', '', NULL, NULL, ''),
(83, 'Toko Emas', 'Toko emas yang menjual/ membeli barang-barang perhiasan ', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobil dan sepeda motor', '47735', 'Perdagangan eceran barang perhiasan', '', NULL, NULL, ''),
(84, 'Toko Emas', 'Toko emas/perak yang menjual barang-barang perhiasan yang dibuat sendiri', 'C', 'Industri pengolahan', '32112', 'Industri barang perhiasan dari logam mulia untuk keperluan pribadi', '', NULL, NULL, ''),
(85, 'Penggalian batu', 'Usaha penggalian batu dengan proses pemecahan.', 'B', 'Pertambangan dan penggalian', '08101', 'Penggalian batu hias dan batu bangunan', '', NULL, NULL, ''),
(86, 'Penambang timah, emas/perak, tembaga, nikel', 'Usaha penambangan timah, emas/perak, nikel merupakan satu kegiatan usaha dengan peleburan, yang dapat dipisahkan (Hasil penambangan timah, emas/perak, nikel)', 'B', 'Pertambangan dan penggalian', '07292', 'Pertambangan bijih timah hitam', '', NULL, NULL, ''),
(87, 'Penambang timah, emas/perak, tembaga, nikel', 'Usaha penambangan timah, emas/perak, nikel merupakan satu kegiatan usaha dengan peleburan, yang dapat dipisahkan (Hasil penambangan timah, emas/perak, nikel)', 'B', 'Pertambangan dan penggalian', '07295', 'Pertambangan bijih nikel', '', NULL, NULL, ''),
(88, 'Penambang timah, emas/perak, tembaga, nikel', 'Usaha penambangan timah, emas/perak, nikel merupakan satu kegiatan usaha dengan peleburan, yang dapat dipisahkan (Hasil penambangan timah, emas/perak, nikel)', 'B', 'Pertambangan dan penggalian', '07301', 'Pertambangan emas dan perak', '', NULL, NULL, ''),
(89, 'Penambang timah, emas/perak, tembaga, nikel', 'Usaha penambangan timah, emas/perak, nikel merupakan satu kegiatan usaha dengan peleburan, yang dapat dipisahkan (Kegiatan peleburan timah, emas/perak, nikel).', 'C', 'Industri pengolahan', '24101', 'Industri besi dan baja dasar (iron and steel making)', '', NULL, NULL, ''),
(90, 'Penambang timah, emas/perak, tembaga, nikel', 'Usaha penambangan timah, emas/perak, nikel merupakan satu kegiatan usaha dengan peleburan, yang dapat dipisahkan (Kegiatan peleburan timah, emas/perak, nikel).', 'C', 'Industri pengolahan', '24102', 'Industri penggilingan baja (steel rolling)', '', NULL, NULL, ''),
(91, 'Perekaman kaset, CD, video, minus one', 'Usaha rekaman suara/gambar dengan pita kaset, piringan hitam, dan video.', 'J', 'Informasi dan komunikasi', '59201', 'Aktivitas perekaman suara', '', NULL, NULL, ''),
(92, 'Jasa kesehatan hewan', 'Kegiatan pelayanan kesehatan atau pengobatan hewan dari jenis hewan ternak atau hewan piaraan oleh dokter hewan.', 'M', 'Aktivitas profesional, ilmiah, dan teknis', '75000', 'Aktivitas kesehatan hewan', '', NULL, NULL, ''),
(93, 'Reparasi', 'Reparasi dan perawatan mobil dan  sepeda motor', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobil dan sepeda motor', '45201', 'Reparasi mobil', '', NULL, NULL, ''),
(94, 'Reparasi', 'Reparasi dan perawatan mobil dan  sepeda motor', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobil dan sepeda motor', '45407', 'Reparasi dan perawatan sepeda mobil', '', NULL, NULL, ''),
(95, 'Reparasi', 'Reparasi komputer, barang-barang keperluan pribadi, dan alat rumah tangga ', 'S', 'Aktivitas jasa lainnya', '95', 'Reparasi komputer, barang keperluan pribadi, dan alat rumah tangga ', '', NULL, NULL, ''),
(96, 'Reparasi', 'Reparasi mesin, peralatan elektronik dan optik, peralatan listrik, alat angkutan bukan kendaraan bermotor, dan peralatan lainnya.', 'C', 'Industri pengolahan', '331', 'Reparasi mesin, peralatan elektronik dan optik, peralatan listrik, alat angkutan bukan kendaraan bermotor, dan peralatan ', '', NULL, NULL, ''),
(97, 'Penggalian tanah urug', 'Penggalian tanah urug.', 'B', 'Pertambangan dan penggalian', '08105', 'Penggalian tanah dan tanah liat', '', NULL, NULL, ''),
(98, 'Penggalian tanah urug', 'Penggalian tanah urug dilanjutkan dengan peningkatan kegunaan lahan oleh pengusaha tanah urug itu sendiri.', 'F', 'Konstruksi', '43120', 'Penyiapan lahan', '', NULL, NULL, ''),
(99, 'Penggalian tanah urug', 'Tanah urug dibeli dan kemudian dijual kepada pengusaha lain untuk peningkatan lahan.', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobil dan sepeda motor', '47529', 'Perdagangan eceran bahan dan barang konstruksi lainnya', '', NULL, NULL, ''),
(100, 'Distributor alat-alat kantor', 'Melakukan kegiatan sebagai distributor mesin fotokopi, printer, fax, dan computer', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobil dan sepeda motor', '47411', 'Perdagangan eceran komputer dan perlengkapannya', '', NULL, NULL, ''),
(101, 'Distributor alat-alat kantor', 'Melakukan kegiatan sebagai distributor mesin fotokopi, printer, fax, dan computer', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobil dan sepeda motor', '47415', 'Perdagangan eceran mesin kantor', '', NULL, NULL, ''),
(102, 'Salon kecantikan', 'Usaha salon kecantikan yang mempunyai kegiatan lainnya menjual alat-alat make-up, menyewakan baju penganten.', 'S', 'Aktivitas jasa lainnya', '96112', 'Aktivitas salon kecantikan', '', NULL, NULL, ''),
(103, 'Pelayaran khusus', 'Pelayaran khusus yang dimiliki oleh suatu perusahaan khusus untuk mengangkut hasil produksinya sendiri, misalnya perusahaan kayu lapis.', 'C', 'Industri pengolahan', '16211', 'Industri kayu lapis', '', NULL, NULL, ''),
(104, 'Pelayaran khusus', 'Apabila mengangkut barang pihak lain. ', 'H', 'Pengangkutan dan pergudangan', '501', 'Angkutan laut', '', NULL, NULL, ''),
(105, 'Pemeliharaan ikan', 'Pemeliharaan ikan di kolam untuk keperluan pemancingan', 'R', 'Kesenian, hiburan, dan rekreasi', '93233', 'Kolam pemancingan', '', NULL, NULL, ''),
(106, 'Pengolahan \r\ngetah karet', 'Produk utama berupa lateks atau sir (karet lembaran).', 'C', 'Industri pengolahan', '22121', 'Industri pengasapan karet', '', NULL, NULL, ''),
(107, 'Pembuatan briket batubara', 'Pembuatan briket batubara (tanpa melihat asal bahan baku)', 'C', 'Industri pengolahan', '19292', 'Industri briket batu bara', '', NULL, NULL, ''),
(108, 'Pengusahaan tenaga panas bumi', 'Pengusahaan tenaga panas bumi sampai ke tempat pemanfaatannya. ', 'B', 'Pertambangan dan penggalian', '06202', 'Pengusahaan tenaga panas bumi', '', NULL, NULL, ''),
(109, 'Pengusahaan tenaga panas bumi', 'Produk akhir berupa uap panas yang disalurkan ', 'D', 'Pengadaan listrik, gas, uap/ air panas dan udara dingin', '35301', 'Pengadaan uap, air panas, dan udara dingin', '', NULL, NULL, ''),
(110, 'Pendidikan', 'Pendidikan yang utamanya berkaitan dengan rekreasi, seperti pendidikan golf dan bridge.', 'P', 'Pendidikan', '85410', 'Jasa pendidikan olahraga dan rekreasi', '', NULL, NULL, ''),
(111, 'Pendidikan', 'Pendidikan pada tempat penitipan anak.', 'P', 'Pendidikan', '85134', 'Pendidikan taman penitipan anak', '', NULL, NULL, ''),
(112, 'Pendidikan', 'Pendidikan pada TPA (Taman Pendidikan Al Qur�an)', 'P', 'Pendidikan', '85499', 'Pendidikan lainnya swasta', '', NULL, NULL, ''),
(113, 'Pendidikan', 'Pendidikan pada TPA (Taman Pendidikan Al Qur�an)', 'P', 'Pendidikan', '85440', 'Satuan pendidikan Kerjasama Pendidikan nonformal', '', NULL, NULL, ''),
(114, 'Pendidikan', 'Pendidikan pada TPA (Taman Pendidikan Al Qur�an)', 'P', 'Pendidikan', '85451', 'Pendidikan pesantren lainnya', '', NULL, NULL, ''),
(115, 'Pendidikan', 'Pendidikan pada TPA (Taman Pendidikan Al Qur�an)', 'P', 'Pendidikan', '85452', 'Pendidikan keagamaan islam non formal', '', NULL, NULL, ''),
(116, 'Pendidikan', 'Pendidikan pada TPA (Taman Pendidikan Al Qur�an)', 'P', 'Pendidikan', '85459', 'Pendidikan keagamaan lainnya YTDL', '', NULL, NULL, ''),
(117, 'Pendidikan', 'Pendidikan pada TPA (Taman Pendidikan Al Qur�an)', 'P', 'Pendidikan', '85499', 'Pendidikan lainnya swasta *(perubahan deskripsi dan pemecahan kode)', '', NULL, NULL, ''),
(118, 'Aktivitas kebersihan', 'Pengelolaan kembali limbah menjadi bahan baku sekunder atau bahan baku untuk industri lain', 'E', 'Pengelolaan air, pengelolaan air limbah, Pengelolaan dan daur ulang sampah dan aktivitas remediasi', '38301', 'Pemulihan material barang logam (perubahan judul dan deskripsi/cakupan)', '', NULL, NULL, ''),
(119, 'Aktivitas kebersihan', 'Pengelolaan kembali limbah menjadi bahan baku sekunder atau bahan baku untuk industri lain', 'E', 'Pengelolaan air, pengelolaan air limbah, Pengelolaan dan daur ulang sampah dan aktivitas remediasi', '38302', 'Pemulihan material barang bukan logam', '', NULL, NULL, ''),
(120, 'Aktivitas kebersihan', 'Pengelolaan dari limbah atau sampah menjadi produk akhir, contoh: Krakatau Steel', 'C', 'Industri pengolahan', '25', 'Industri barang logam', '', NULL, NULL, ''),
(121, 'Aktivitas kebersihan', 'Pengelolaan dari limbah atau sampah menjadi produk akhir, contoh: Krakatau Steel', 'C', 'Industri pengolahan', '81210', 'Aktivitas kebersihan umum bangunan', '', NULL, NULL, ''),
(122, 'Aktivitas kebersihan', 'Pembersihan bangunan kantor maupun rumah', 'N', 'Aktivitas penyewaan dan sewa guna usaha tanpa hak opsi, ketenagaker-jaan, agen perjalanan & penunjang usaha lainnya', '81290', 'Aktivitas kebersihan bangunan dan industri lainnya', '', NULL, NULL, ''),
(123, 'Publikasi koran, majalah', 'Publikasi koran dan majalah ', 'J', 'Informasi dan Komunikasi', '58130', 'Penerbitan surat kabar, jurnal dan buletin atau majalah', '', NULL, NULL, ''),
(124, 'Pembuatan karangan bunga', 'Jika utamanya menjual bunga potong tetapi ada juga membuat karangan bunga/ florist.', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobildan sepeda motor', '47761', 'Perdagangan eceran bunga potong/florist', '', NULL, NULL, ''),
(125, 'Pembuatan karangan bunga', 'Jika utamanya membuat karangan bunga/ florist tetapi juga menjual bunga potong', 'C', 'Industri pengolahan', '32903', 'Industri Kerajinan YTDL', '', NULL, NULL, ''),
(126, 'Pemasangan/ pembuatan gigi palsu', 'Pembuatan gigi palsu dan pemasangannya di tukang gigi', 'Q', 'Jasa kesehatan dan kegiatan sosial', '86901', 'Aktivitas pelayanan Kesehatan yang dilakukan oleh tenaga Kesehatan selain dokter dan dokter gigi', '', NULL, NULL, ''),
(127, 'Pemasangan/ pembuatan gigi palsu', 'Pembuatan dan pemasangan gigi palsu yang dilakukan di rumah sakit.', 'Q', 'Jasa kesehatan dan kegiatan sosial', '8610', 'Aktivitas rumah sakit', '', NULL, NULL, ''),
(128, 'Pemasangan/ pembuatan gigi palsu', 'Pembuatan dan pemasangan gigi palsu yang dilakukan di dokter gigi', 'Q', 'Jasa kesehatan dan kegiatan sosial', '86203', 'Aktivitas praktek dokter gigi', '', NULL, NULL, ''),
(129, 'Pengasahan/ pembuatan batu cincin/ Permata/batu akik', 'Penghalusan batu berharga/ permata, intan dan berlian termasuk penajaman dan pengilapan batu batuan, misalnya batu aki', 'C', 'Industri pengolahan', '32111', 'Industri permata', '', NULL, NULL, ''),
(130, 'Pengasahan/ pembuatan batu cincin/ Permata/batu akik', 'Pembuatan perhiasan imitasi termasuk ikatan cincin', 'C', 'Industri pengolahan', '32120', 'Industri perhiasan imitasi dan barang sejenis', '', NULL, NULL, ''),
(131, 'Pembangkitan listrik oleh selain PLN ', 'Pembangkitan dan penyaluran listrik kepada pihak lain oleh selain PLN.', 'D', 'Pengadaan listrik, gas/uap air panas, dan udara dingin', '35101', 'Pembangkitan tenaga listrik', '', NULL, NULL, ''),
(132, 'Penyaluran air ', 'Penyaluran air untuk keperluan industri, rumah tangga, dll.', 'E', 'Pengadaan air, pengelolaan sampah dan daur ulang, pembuangan dan pembersihan limbah dan sampah', '36001', 'Penampungan, penjernihan dan penyaluran air minum', '', NULL, NULL, ''),
(133, 'Penyaluran air ', 'Penyaluran air untuk keperluan industri, rumah tangga (baik melalui gerobak atau lainnya), dan lain-lain. Termasuk melalui kanal irigasi', 'E', 'Pengadaan air, pengelolaan sampah dan daur ulang, pembuangan dan pembersihan limbah dan sampah', '36003', 'Aktivitas penunjang treathment air', '', NULL, NULL, ''),
(134, 'Penyaluran air ', 'Industri air kemasan termasuk industri air isi ulang', 'C', 'Industri pengolahan', '11051', 'Industri air kemasan', '', NULL, NULL, ''),
(135, 'Penyaluran air ', 'Industri air kemasan termasuk industri air isi ulang', 'C', 'Industri pengolahan', '11052', 'Industri air minum isi ulang', '', NULL, NULL, ''),
(136, 'Pembotolan madu', 'Usaha pengolahan dan pembotolan madu yang bahan bakunya  dari pembelian. Contoh madu gingseng kemasan, madu olahan ', 'C', 'Industri pengolahan', '21022', 'Industri produk obat tradisional untuk manusia', '', NULL, NULL, ''),
(137, 'Pembotolan madu', 'Usaha pengolahan dan pembotolan madu yang bahan bakunya  dari pembelian. Contoh madu gingseng kemasan, madu olahan ', 'C', 'Industri pengolahan', '10779', 'Industri produk masak lainnya', '', NULL, NULL, ''),
(138, 'Jasa pengiriman dokumen, barang, dan uang', 'Usaha pengiriman uang (hanya uang saja). Contoh: western union', 'K', 'Aktivitas keuangan dan asuransi', '64190', 'Perantara moneter lainnya', '', NULL, NULL, ''),
(139, 'Jasa pengiriman dokumen, barang, dan uang', 'Usaha pengiriman uang (hanya uang saja). Contoh: western union', 'K', 'Aktivitas keuangan dan asuransi', '66411', 'Penyedia jasa pembayaran (PJP)', '', NULL, NULL, ''),
(140, 'Jasa pengiriman dokumen, barang, dan uang', 'Produk utama mengirimkan surat', 'H', 'Pengangkutan dan Pergudangan', '53100', 'Aktivitas pos', '', NULL, NULL, ''),
(141, 'Jasa pengiriman dokumen, barang, dan uang', 'Produk utama mengirimkan barang, dokumen. Contoh: JNE, Tiki', 'H', 'Pengangkutan dan Pergudangan', '53201', 'Aktivitas kurir', '', NULL, NULL, ''),
(142, 'Jasa pengiriman dokumen, barang, dan uang', 'Produk utama mengirimkan barang (dalam ukuran/jumlah besar)', 'H', 'Pengangkutan dan Pergudangan', '5229', 'Aktivitas ekpedisi', '', NULL, NULL, ''),
(143, 'Angkutan multimoda', 'Usaha angkutan barang dengan berbagai moda angkutan (minimal 2 moda angkutan) termasuk jasa pengurusan administrasi dan pergudangan (contoh: PT Multimoda Sarana Logistik, PT Pandu Logistik)', 'H', 'Pengangkutan dan Pergudangan', '52295', 'Angkutan multimoda', '', NULL, NULL, ''),
(144, 'Usaha Credit Union', 'Usaha yang kegiatan utamanya meminjamkan uang saja tanpa ada kegiatan simpanan (contoh: pinjaman cepat tanpa agunan, rentenir)', 'K', 'Aktivitas keuangan dan asuransi', '64190', 'Perantara moneter lainnya', '', NULL, NULL, ''),
(145, 'Usaha pemulung', 'Kegiatan usaha pemulung, tidak ada proses membeli namun ada proses menjual', 'E', 'Pengelolaan Air, pengelolaan limbah, pengelolaan daur ulang sampah, dan aktivitas remediasi�', '38110', 'Pengumpulan limbah dan sampah tidak berbahaya', '', NULL, NULL, ''),
(146, 'Usaha pengumpul barang bekas/ pengepul', 'Kegiatan yang terdapat proses membeli dalam memperoleh barang bekas yang akan dijual (pengumpul)', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobil dan sepeda motor', '46696', 'Perdagangan besar barang bekas dan sisa-sisa tak terpakai (scrap)', '', NULL, NULL, ''),
(147, 'Membuat jamu', 'Produk utama berupa jamu dalam kemasan', 'C', 'Industri pengolahan', '21022', 'Industri produk obat tradisional untuk manusia', '', NULL, NULL, ''),
(148, 'Membuat jamu', 'Usaha jamu keliling dengan pembuatan jamu sendiri (baik jamu gendong, atau menggunakan kendaraan seperti mobil, motor, sepeda, gerobak, dll)', 'I', 'Penyediaan akomodasi dan penyediaan makan minum', '56306', 'Penyediaan minuman keliling/tempat tidak tetap', '', NULL, NULL, ''),
(149, 'Pembuatan lilin', 'Membuat lilin untuk penerangan rumah tangga (candle)', 'C', 'Industri pengolahan', '32906', 'Industry produksi radioisotop', '', NULL, NULL, ''),
(150, 'Pembuatan lilin', 'Membuat lilin untuk penerangan rumah tangga (candle)', 'C', 'Industri pengolahan', '32907', 'Industri fabrikasi elemen bakar uranium', '', NULL, NULL, ''),
(151, 'Pembuatan lilin', 'Membuat lilin sebagai alat kebersihan seperti lilin buatan atau lilin olahan (wax)', 'C', 'Industri pengolahan', '32909', 'Industri pengolahan lainnya ytdl', '', NULL, NULL, ''),
(152, 'Pembuatan lilin', 'Membuat lilin sebagai alat kebersihan seperti lilin buatan atau lilin olahan (wax)', 'C', 'Industri pengolahan', '20231', 'Industri sabun dan bahan pembersih keperluan rumah tangga', '', NULL, NULL, ''),
(153, 'Angkutan udara khusus', 'Angkutan udaranya digunakan khusus untuk kegiatan pemotretan, survei dan pemetaan khusus dengan pesawat udara.', 'M', 'Aktivitas profesional, ilmiah dan teknis', '74202', 'Aktivitas angkutan udara khusus pemotretan, survei dan pemetaan', '', NULL, NULL, ''),
(154, 'Angkutan udara khusus', 'Angkutan udaranya digunakan khusus untuk kegiatan olahraga.', 'H', 'Pengangkutan dan pergudangan', '51106', 'Angkutan udara untuk olahraga', '', NULL, NULL, ''),
(155, 'Angkutan udara khusus', 'Angkutan udaranya digunakan khusus untuk kegiatan lain selain poin A sd. D', 'H', 'Pengangkutan dan pergudangan', '51109', 'Angkutan udara untuk penumpang lainnya ', '', NULL, NULL, ''),
(156, 'Penjual aki atau ban bekas', 'Penjualan suku cadang mobil atau motor, baik baru maupun bekas (aki, ban)', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobil dan sepeda motor', '45302', 'Perdagangan eceran suku cadang dan aksesori mobil', '', NULL, NULL, ''),
(157, 'Penjual aki atau ban bekas', 'Pengumpul aki atau ban bekas (afkir)', 'E', 'Pengelolaan air, pengelolaan air limbah, Pengelolaan dan daur ulang sampah dan aktivitas remediasi', '38110', 'Pengumpulan limbah dan sampah tidak berbahaya', '', NULL, NULL, ''),
(158, 'Penjual aki atau ban bekas', 'Vulkanisir ban', 'C', 'Industri Pengolahan�', '22112', 'Industri vulkanisir ban', '', NULL, NULL, ''),
(159, 'Penjualan roti (Holland Bakery, Roti �O, Rotiboy, J.Co, Dunkin� Donuts, dll)', 'Membuat roti dan langsung menjual ke konsumen (di dalam mall, stasiun, bandara, dll) baik menyediakan meja dan kursi untuk makan di tempat maupun tidak. Contoh: Roti �O, Rotiboy, BreadTalk, BreadLife, dll)', 'I', 'Penyediaan Akomodasi dan Penyediaan Makan Minum', '56101', 'Restoran', '', NULL, NULL, ''),
(160, 'Penjualan roti (Holland Bakery, Roti �O, Rotiboy, J.Co, Dunkin� Donuts, dll)', 'Menerima roti dari produsen dan dijual ke konsumen, tidak ada stok (unit penunjang)', 'C', 'Industri pengolahan', '10710', 'Industri produk roti dan kue', '', NULL, NULL, ''),
(161, 'Penjualan roti (Holland Bakery, Roti �O, Rotiboy, J.Co, Dunkin� Donuts, dll)', 'Membuat roti (dari bahan mentah) dan menjual langsung ke konsumen pada bangunan permanen', 'C', 'Industri Pengolahan�', '10710', 'Industri produk roti dan kue', '', NULL, NULL, ''),
(162, 'Penjualan roti (Holland Bakery, Roti �O, Rotiboy, J.Co, Dunkin� Donuts, dll)', 'Membeli dan menjual dengan sistem waralaba (tunggal)', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobil dan sepeda motor', '47242', 'Perdagangan eceran roti, kue kering, serta kue basah, dan sejenisnya', '', NULL, NULL, ''),
(163, 'Indomaret Point, Lawson, dll', 'Walaupun ada tempat makan dan minum namun izin serta porsi pendapatan terbesar adalah perdagangan/retail', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobil dan sepeda motor', '47111', 'Perdagangan eceran berbagai macam barang yang utamanya makanan, minuman atau tembakau di minimarket/supermarket/\r\nhypermarket ', '', NULL, NULL, ''),
(164, 'Penjualan tanaman hias', 'Jika melakukan penjualan tanaman bunga dan hanya melakukan pemeliharan  untuk menunggu tanaman sampai laku dijual', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobil dan sepeda motor', '47761', 'Perdagangan eceran bunga potong/florist', '', NULL, NULL, ''),
(165, 'Penjualan tanaman hias', 'Jika melakukan penjualan tanaman bunga dan hanya melakukan pemeliharan  untuk menunggu tanaman sampai laku dijual', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobil dan sepeda motor', '47762', 'Perdagangan eceran tanaman dan bibit tanaman', '', NULL, NULL, ''),
(166, 'Agrowisata', 'Usaha pertanian yang terintegrasi dengan kegiatan wisata. Contoh: taman buah mekarsari, taman bunga wiladatika, taman strawberry', 'R', 'Kesenian, Hiburan dan Rekreasi', '93231', 'Wisata agro', '', NULL, NULL, ''),
(167, 'Penjualan benih hortikultura', 'Usaha penjualan benih hortikultura dari hasil pembelian  (pihak lain), termasuk pedagang keliling tanaman hias, buah-buahan, hortikultura', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobil dan sepeda motor', '47762', 'Perdagangan eceran tanaman dan bibit tanaman', '', NULL, NULL, ''),
(168, 'Pembuatan pisang goreng', 'Jika dibuat di rumah dan dijual melalui perantara/ penjaja atau dijual langsung kepada konsumen akhir tanpa perantara', 'C', 'Industri Pengolahan�', '10750', 'Industri makanan dan masakan olahan', '', NULL, NULL, ''),
(169, 'Pembuatan pisang goreng', 'Jika dijajakan (dengan menggoreng) keliling', 'I', 'Penyediaan akomodasi dan penyediaan makan minum', '56104', 'Penyediaan makanan keliling/tempat tidak tetap', '', NULL, NULL, ''),
(170, 'Pembuatan pisang goreng', 'Jika menjual pisang goreng bukan buatan sendiri', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobil dan sepeda motor', '47242', 'Perdagangan eceran roti, kue kering, serta kue basah dan sejenisnya', '', NULL, NULL, ''),
(171, 'Pembuatan pisang goreng', 'Jika menjual pisang goreng bukan buatan sendiri', 'G', 'Perdagangan besar dan eceran; reparasi dan perawatan mobil dan sepeda motor', '47822', 'Perdagangan eceran kaki lima dan los pasar roti, kue kering, kue basah dan sejenisnya', '', NULL, NULL, ''),
(172, 'Biro Perjalanan Wisata/travel', 'Usaha yang produk utamanya adalah jasa penjualan tiket, jasa penjualan paket wisata', 'N', 'Aktivitas penyewaan dan sewa guna usaha tanpa hak opsi, ketenaga-kerjaan, agen perjalanan, dan penunjang usaha lainnya', '79111', 'Aktivitas agen perjalanan wisata', '', NULL, NULL, ''),
(173, 'Biro Perjalanan Wisata/travel', 'Usaha yang produk utamanya adalah jasa penjualan tiket, jasa penjualan paket wisata', 'N', 'Aktivitas penyewaan dan sewa guna usaha tanpa hak opsi, ketenaga-kerjaan, agen perjalanan, dan penunjang usaha lainnya', '79112', 'Aktivitas agen perjalanan ibadah umroh dan haji khusus', '', NULL, NULL, ''),
(174, 'Biro Perjalanan Wisata/travel', 'Usaha yang produk utamanya adalah jasa penjualan tiket, jasa penjualan paket wisata', 'N', 'Aktivitas penyewaan dan sewa guna usaha tanpa hak opsi, ketenaga-kerjaan, agen perjalanan, dan penunjang usaha lainnya', '79119', 'Aktivitas agen perjalanan lainnya', '', NULL, NULL, ''),
(175, 'Biro Perjalanan Wisata/travel', 'Usaha yang produk utamanya adalah jasa penjualan tiket, jasa penjualan paket wisata', 'N', 'Aktivitas penyewaan dan sewa guna usaha tanpa hak opsi, ketenaga-kerjaan, agen perjalanan, dan penunjang usaha lainnya', '79121', 'Aktivitas biro perjalanan wisata', '', NULL, NULL, ''),
(176, 'Biro Perjalanan Wisata/travel', 'Usaha yang produk utamanya adalah jasa penjualan tiket, jasa penjualan paket wisata', 'N', 'Aktivitas penyewaan dan sewa guna usaha tanpa hak opsi, ketenaga-kerjaan, agen perjalanan, dan penunjang usaha lainnya', '79122', 'Aktivitas biro perjalanan ibadah umroh dan haji khusus', '', NULL, NULL, ''),
(177, 'Biro Perjalanan Wisata/travel', 'Usaha yang produk utamanya adalah jasa penjualan tiket, jasa penjualan paket wisata', 'N', 'Aktivitas penyewaan dan sewa guna usaha tanpa hak opsi, ketenaga-kerjaan, agen perjalanan, dan penunjang usaha lainnya', '79129', 'Aktivitas biro perjalanan lainnya', '', NULL, NULL, ''),
(179, '', '', 'A', 'Pertanian, Kehutanan, dan Perikanan', '', '', 'uploads/138f8d55-d121-41d9-bbdf-fef1c060efb21633504219731670706.jpg', NULL, NULL, ''),
(180, '', '', 'A', 'Pertanian, Kehutanan, dan Perikanan', '', '', 'uploads/4b24578e-5af2-4af9-9c0f-aa56309871213660981672065125445.jpg', NULL, NULL, ''),
(185, 'konstruksi Yang besarrr', 'aaaaaaaaaaaaaa says membuat konstruksi Yang besarrr', 'J', 'Informasi Dan Komunikasi', '67541', 'zzzzzzzzzzzzz saya membuat rumah dsb', 'uploads/85af76ff-295f-40b2-8b0a-18fc0125dbf57102285576619396352.jpg', '2023-11-25', '15:07:22', 'diperbarui'),
(186, 'bisnis online', 'menjual kalung kaling', 'A', 'Pertanian, Kehutanan, dan Perikanan', '67890', 'kalung ajaib', 'uploads/37bd3a10-54ad-45d0-b753-16d835cebb228185844599699927472.jpg', NULL, NULL, ''),
(187, 'jaga kerbau', 'wah', 'A', 'Pertanian, Kehutanan, dan Perikanan', '8970', 'keren', 'uploads/9bbceb84-aea9-47f4-906a-5daeb22f8ec4528241870642637685.jpg', '0000-00-00', NULL, 'diupdate'),
(188, 'jaga swah', 'oi', 'A', 'Pertanian, Kehutanan, dan Perikanan', '7890', 'ei', 'uploads/474b4611-d251-41a0-8caf-2558d5d59ec06366105580953267676.jpg', '0000-00-00', NULL, 'diupdate'),
(189, 'jaga sawahan dan sekitarnya', 'iu', 'A', 'Pertanian, Kehutanan, dan Perikanan', '8888', 'aaaaaaa', 'uploads/44522395-39ef-4eeb-b5f9-4d2c417e2d20962956627313903588.jpg', '2023-11-25', '15:11:19', 'diperbarui'),
(190, 'jaga nyamuk', 'ssss', 'A', 'Pertanian, Kehutanan, dan Perikanan', '78999', 'ggggg', 'uploads/bb959221-f85a-4b91-9649-1b2de30cfc9c6985823961857901550.jpg', '2023-11-25', '15:12:24', 'diperbarui'),
(191, 'aaaaaaa', 'aaaaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '8900', 'aaaaa', 'uploads/12da4bf4-d7b4-4528-98c6-dfafee2922b95141512495029511311.jpg', '2023-11-24', NULL, 'diupdate'),
(192, 'Jualan mainan keliling', 'aaaaaaaaaaaaaa', 'S', 'Aktivitas Jasa Lainnya', '89071', 'bbbbbbbbbbbb', 'uploads/fd228487-de75-4cd6-b392-25a352c5bfd18808272574644384696.jpg', '2023-11-25', '15:03:58', 'ditambahkan'),
(193, 'ffff', 'aaaaaaaaaaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '567', 'aaaaaaaaa', 'uploads/57208bf8-89f2-4541-8efc-9e95b562ef002517911230466146164.jpg', '2023-12-03', '20:24:08', 'ditambahkan'),
(194, 'aaaaaa', 'aaaaaaaaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '444', 'aaaaaaaaaa', 'uploads/bfc55cd3-2163-45c6-911d-56e0f4c751a91527371442054970419.jpg', '2023-12-03', '20:24:08', 'ditambahkan'),
(195, 'aaaaaaaaaa', 'aaaaaaaaaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaaaaaaaaaa', 'sijali/uploads/415b1f8b-8ede-4279-9538-6f8128fd7dad3032824748329821743.jpg', '2023-12-03', '20:48:31', 'ditambahkan'),
(196, 'ssssss', 'sssssssss', 'A', 'Pertanian, Kehutanan, dan Perikanan', '11221', 'ssddd', '../uploads/ff3d1f58-20ae-43ed-8f49-a167d8b3ed9b3781542256926330267.jpg', '2023-12-03', '20:48:31', 'ditambahkan'),
(197, 'aaaa', 'aaaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', '../sijali/uploads/4cb794f7-f102-4e39-bd00-7ae3996bd3b05924707583829429475.jpg', '2023-12-03', '20:56:47', 'ditambahkan'),
(198, 'aaaaa', 'aaaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12344', 'aaaa', 'https://sijali.gaweyan.online/uploads/56e587bb-4c18-444c-a2be-f414960d951f4020774954432232301.jpg', '2023-12-03', '21:02:10', 'ditambahkan'),
(199, 'aaa', 'aaaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaaa', '/sijali/uploads/9380eba2-eda3-4696-b3f0-080489f626196138273386127040443.jpg', '2023-12-03', '21:02:10', 'ditambahkan'),
(200, 'aaa', 'aaaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', './uploads/2070ddd4-5e94-42ec-8f30-8b8fe95b3bd58379553079991263341.jpg', '2023-12-03', '21:02:10', 'ditambahkan'),
(201, 'aaa', 'aaaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12335', 'aaaa', '../uploads/c7637675-e91c-44e0-baf7-8917ee50af378345531195025920133.jpg', '2023-12-03', '21:11:21', 'ditambahkan'),
(202, 'aaaaaaaa', 'aaaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaaaaaaa', '/uploads/93404fa3-f81e-4796-ab1e-a774b9d7e275820465830557104902.jpg', '2023-12-03', '21:18:01', 'ditambahkan'),
(203, 'aaaa', 'aaaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaa', 'uploads/5517bcd2-0e84-4f06-85f7-9991dfe6976f7565119990707203048.jpg', '2023-12-03', '21:29:27', 'ditambahkan'),
(204, 'aaaa', 'aa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', 'upload/2027f848-5dc3-47be-bfbe-5575de3402cb570192436911322561.jpg', '2023-12-03', '21:29:27', 'ditambahkan'),
(205, 'aaa', 'aaaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaaa', 'srv1135-files.hstgr.io/935f880cd5ead09d/files/public_html/sijali/upload/5dbe6d51-ab7d-4c65-8921-345f258c705f391577023454046954.jpg', '2023-12-03', '21:29:27', 'ditambahkan'),
(206, 'zzz', 'zzz', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'zzz', 'uploads/81201f9a-c5d3-4267-b84d-220b188ccd4d3489354679693301075.jpg', '2023-12-07', '22:48:09', 'ditambahkan'),
(207, 'rrrr', 'rrrr', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'rrrr', 'uploads/9b84cb0f-ba7f-4e51-9dc0-ad1f7c5729377069797808725160506.jpg', '2023-12-07', '22:54:57', 'ditambahkan');
INSERT INTO `kasus_batas` (`id`, `jenis_usaha`, `uraian_kegiatan`, `kd_kategori`, `rincian_kategori`, `kd_kbli`, `deskripsi_kbli`, `foto`, `tanggal`, `waktu`, `status_kb`) VALUES
(208, 'aaaa', 'aaaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaa', 'uploads/8fabc510-8eec-4a9e-856b-50d2aa4e1f3d4074012611694033786.jpg', '2023-12-07', '22:54:57', 'ditambahkan'),
(209, 'eee', 'ee Dr', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'eeee', 'uploads/758d83ce-7b26-4c92-bb23-479c1ca4b6a56508454433062800766.jpg', '2023-12-07', '23:00:55', 'ditambahkan'),
(210, 'aaa', 'aaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'www', 'uploads/71060d6f-3e56-4945-b054-6c3144bee5de2938052684415241223.jpg', '2023-12-07', '23:00:55', 'ditambahkan'),
(211, '', '', '', '', '', '', 'uploads/', '0000-00-00', '00:00:00', 'ditambahkan'),
(212, 'rrrr', 'rrrr', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'rrrr', 'uploads/d4dd7c48-4b84-4591-809e-5eb52a81f3868719985164350573250.jpg', '2023-12-08', '19:07:02', 'ditambahkan'),
(213, 'halo gan', 'oiii', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', 'uploads/f975dcde-0884-4dd4-ab1d-0b7d5cfae85e6838362987554716472.jpg', '2023-12-08', '19:11:14', 'ditambahkan'),
(214, 'halo gan', 'oiii', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', 'uploads/f975dcde-0884-4dd4-ab1d-0b7d5cfae85e6838362987554716472.jpg', '2023-12-08', '19:11:14', 'ditambahkan'),
(215, 'halo gan', 'oiii', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', 'uploads/f975dcde-0884-4dd4-ab1d-0b7d5cfae85e6838362987554716472.jpg', '2023-12-08', '19:11:14', 'ditambahkan'),
(216, 'aaiii', 'aaii\n', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12344', 'aaaa', 'uploads/8a2d5d8a-2b59-4c82-a37c-916aa1a6b4774785202001965289938.jpg', '2023-12-08', '19:13:05', 'ditambahkan'),
(217, 'aaiii', 'aaii\n', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12344', 'aaaa', 'uploads/8a2d5d8a-2b59-4c82-a37c-916aa1a6b4774785202001965289938.jpg', '2023-12-08', '19:13:05', 'ditambahkan'),
(218, 'awa', 'aaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', 'uploads/4ce007a7-0484-4608-8b71-e2582016b4732960018558124003337.jpg', '2023-12-08', '19:16:26', 'ditambahkan'),
(219, 'awa', 'aaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', 'uploads/4ce007a7-0484-4608-8b71-e2582016b4732960018558124003337.jpg', '2023-12-08', '19:16:26', 'ditambahkan'),
(220, 'awa', 'aaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', 'uploads/4ce007a7-0484-4608-8b71-e2582016b4732960018558124003337.jpg', '2023-12-08', '19:16:26', 'ditambahkan'),
(221, 'awa', 'aaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', 'uploads/4ce007a7-0484-4608-8b71-e2582016b4732960018558124003337.jpg', '2023-12-08', '19:16:26', 'ditambahkan'),
(222, 'awa', 'aaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', 'uploads/4ce007a7-0484-4608-8b71-e2582016b4732960018558124003337.jpg', '2023-12-08', '19:16:26', 'ditambahkan'),
(223, 'awa', 'aaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', 'uploads/4ce007a7-0484-4608-8b71-e2582016b4732960018558124003337.jpg', '2023-12-08', '19:16:26', 'ditambahkan'),
(224, 'awa', 'aaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', 'uploads/4ce007a7-0484-4608-8b71-e2582016b4732960018558124003337.jpg', '2023-12-08', '19:16:26', 'ditambahkan'),
(225, 'awa', 'aaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', 'uploads/4ce007a7-0484-4608-8b71-e2582016b4732960018558124003337.jpg', '2023-12-08', '19:16:26', 'ditambahkan'),
(226, 'awa', 'aaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', 'uploads/4ce007a7-0484-4608-8b71-e2582016b4732960018558124003337.jpg', '2023-12-08', '19:16:26', 'ditambahkan'),
(227, 'awa', 'aaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', 'uploads/4ce007a7-0484-4608-8b71-e2582016b4732960018558124003337.jpg', '2023-12-08', '19:16:26', 'ditambahkan'),
(228, 'awa', 'aaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', 'uploads/4ce007a7-0484-4608-8b71-e2582016b4732960018558124003337.jpg', '2023-12-08', '19:16:26', 'ditambahkan'),
(229, 'awa', 'aaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', 'uploads/4ce007a7-0484-4608-8b71-e2582016b4732960018558124003337.jpg', '2023-12-08', '19:16:26', 'ditambahkan'),
(230, 'iii', 'iii', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'iii', 'uploads/IMG-20231208-WA0016.jpg', '2023-12-08', '19:20:29', 'ditambahkan'),
(231, 'aaa', 'aaaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaa', 'uploads/IMG-20231208-WA0016.jpg', '2023-12-08', '19:20:29', 'ditambahkan'),
(232, 'aaaa', 'aaaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaa', 'uploads/c7ca42fb-b149-43d5-b772-0d3d357c97a5736017286239710838.jpg', '2023-12-08', '19:20:29', 'ditambahkan'),
(233, 'aaaa', 'aaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12445', 'aaa', 'uploads/IMG-20231208-WA0016.jpg', '2023-12-08', '19:24:01', 'ditambahkan'),
(234, 'aaaa', 'aaaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaa', 'uploads/523a3d63-fffc-4f84-8560-3dbc585961207216125637178708442.jpg', '2023-12-08', '19:33:21', 'ditambahkan'),
(235, 'aaaa', 'aaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', 'uploads/5e0f8830-31a9-420c-bd3b-0e9caad2bfd33628330770497478844.jpg', '2023-12-08', '19:33:21', 'ditambahkan'),
(236, 'aaaaa', 'aaaa', 'A', 'Pertanian, Kehutanan, dan Perikanan', '12345', 'aaaa', 'uploads/kasus_batas/b63c47fe-fe3c-4a71-ab5d-49b864ae25ec6971144949611842860.jpg', '2023-12-08', '19:33:21', 'ditambahkan');

-- --------------------------------------------------------

--
-- Table structure for table `kritik_saran`
--

CREATE TABLE `kritik_saran` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `kritik` text NOT NULL,
  `saran` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kritik_saran`
--

INSERT INTO `kritik_saran` (`id`, `id_user`, `kritik`, `saran`) VALUES
(15, 2, 'ada saran nih', 'saran apa tu'),
(16, 2, 'sssss', 'aaaa'),
(17, 2, 'aaaa', ''),
(18, 2, '', 'aaa'),
(19, 2, 'hahahaha', 'hohoho');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `role` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `nama`, `role`) VALUES
(1, 'dani1', '399994e2841035742c52d54bae25e3e1', 'Hamdani Dani', 'admin'),
(2, 'mitra007', 'd62046a8518b1d0fcb16ca2edd71dfd7', 'Raihan Han', 'mitra'),
(3, 'spv001', '8012b7fb742f0c4eca975228d400fc4f', 'Raihan Rahmanda', 'supervisor'),
(4, 'dani2', '5628dd6859640dc34bd2474bf56666c6', 'Hamdani Hamdani', 'mitra'),
(35, 'yandre', '1696ef4b2b8683a45b3b31436ef9ceb4', 'Yandre', 'supervisor'),
(36, 'afied', '4413f96e81af2b8735f7829d0c476a31', 'Afied', 'mitra'),
(37, 'kuntum', '10e1db61e97bd57d9cd54498c8dfe184', 'Kuntum', 'mitra'),
(38, 'katrin', '3573907752aec1de970adf9e0217dba6', 'Katrin', 'mitra');

-- --------------------------------------------------------

--
-- Table structure for table `wordcloud`
--

CREATE TABLE `wordcloud` (
  `id` int(11) NOT NULL,
  `keyword` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wordcloud`
--

INSERT INTO `wordcloud` (`id`, `keyword`) VALUES
(344, 'kopi'),
(345, 'baik'),
(346, 'menggunakan'),
(347, 'mesin'),
(348, 'maupun'),
(349, 'tanpa'),
(350, 'mesin'),
(351, 'bisnis'),
(352, 'online'),
(353, 'pemilihan'),
(354, 'sortasi'),
(355, 'pembersihan'),
(356, 'pengupasan'),
(357, 'kopi'),
(358, 'baik'),
(359, 'menggunakan'),
(360, 'mesin'),
(361, 'maupun'),
(362, 'tanpa'),
(363, 'mesin'),
(364, 'pembuatan'),
(365, 'gaplek'),
(366, 'penjahit'),
(367, 'pembuatan'),
(368, 'gaplek'),
(369, 'usaha'),
(370, 'kost'),
(371, 'penyewaan'),
(372, 'kendaraan'),
(373, ''),
(374, 'penyewaan'),
(375, 'kendaraan'),
(376, ''),
(377, 'penyewaan'),
(378, 'kendaraan'),
(379, ''),
(380, 'usaha'),
(381, 'real'),
(382, 'estat'),
(383, 'penyewaan'),
(384, 'kendaraan'),
(385, ''),
(386, 'pembuatan'),
(387, 'gaplek'),
(388, 'penjahit'),
(389, 'usaha'),
(390, 'real'),
(391, 'estat'),
(392, 'usaha'),
(393, 'real'),
(394, 'estat'),
(395, 'penyewaan'),
(396, 'kendaraan'),
(397, ''),
(398, 'penjualan'),
(399, 'pulsa'),
(400, 'usaha'),
(401, 'real'),
(402, 'estat'),
(403, 'penyewaan'),
(404, 'kendaraan'),
(405, ''),
(406, 'penyewaan'),
(407, 'kendaraan'),
(408, ''),
(409, 'penggaraman'),
(410, 'pengeringan'),
(411, 'pengasapan'),
(412, 'pemindangan'),
(413, 'pembekuan'),
(414, 'ikan'),
(415, 'penggaraman'),
(416, 'pengeringan'),
(417, 'pengasapan'),
(418, 'pemindangan'),
(419, 'pembekuan'),
(420, 'ikan'),
(421, 'pembuatan'),
(422, 'es'),
(423, ''),
(424, ''),
(425, 'penjahit'),
(426, 'pengeringan'),
(427, 'buah'),
(428, 'kopi'),
(429, 'daun'),
(430, 'teh'),
(431, 'daun'),
(432, 'tembakau'),
(433, ''),
(434, 'bisnis'),
(435, 'online'),
(436, 'bisnis'),
(437, 'online');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bantuan_balasan`
--
ALTER TABLE `bantuan_balasan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `bantuan_permasalahan`
--
ALTER TABLE `bantuan_permasalahan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `bantuan_usulan`
--
ALTER TABLE `bantuan_usulan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `kasus_batas`
--
ALTER TABLE `kasus_batas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kritik_saran`
--
ALTER TABLE `kritik_saran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_user_2` (`id_user`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wordcloud`
--
ALTER TABLE `wordcloud`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bantuan_balasan`
--
ALTER TABLE `bantuan_balasan`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bantuan_permasalahan`
--
ALTER TABLE `bantuan_permasalahan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `bantuan_usulan`
--
ALTER TABLE `bantuan_usulan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `kasus_batas`
--
ALTER TABLE `kasus_batas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=238;

--
-- AUTO_INCREMENT for table `kritik_saran`
--
ALTER TABLE `kritik_saran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `wordcloud`
--
ALTER TABLE `wordcloud`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=438;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bantuan_balasan`
--
ALTER TABLE `bantuan_balasan`
  ADD CONSTRAINT `bantuan_balasan_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `bantuan_permasalahan`
--
ALTER TABLE `bantuan_permasalahan`
  ADD CONSTRAINT `bantuan_permasalahan_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `bantuan_usulan`
--
ALTER TABLE `bantuan_usulan`
  ADD CONSTRAINT `bantuan_usulan_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kritik_saran`
--
ALTER TABLE `kritik_saran`
  ADD CONSTRAINT `kritik_saran_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
