<?php
$host = "localhost"; // Sesuaikan dengan host MySQL Anda
$username = "root"; // Sesuaikan dengan nama pengguna MySQL Anda
$password = ""; // Sesuaikan dengan kata sandi MySQL Anda
$database = "sijali"; // Sesuaikan dengan nama database Anda

// Membuat koneksi
$conn = new mysqli($host, $username, $password, $database);

// Memeriksa koneksi
if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

// Setel karakter set ke UTF-8
$conn->set_charset("utf8");

?>
