<?php
// Pastikan mengganti informasi database sesuai dengan kebutuhan Anda
//include 'conn.php';

$host = "localhost"; // Sesuaikan dengan host MySQL Anda
$username = "root"; // Sesuaikan dengan nama pengguna MySQL Anda
$password = ""; // Sesuaikan dengan kata sandi MySQL Anda
$dbname = "sijali"; // Sesuaikan dengan nama database Anda

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // Get data from the form
        $id = $_POST['id'];
        $nama = $_POST['nama'];
        $username = $_POST['username'];
        $role = $_POST['role'];

        // Update user data in the database
        $stmt = $pdo->prepare("UPDATE users SET nama = ?, username = ?, role = ? WHERE id = ?");
        $stmt->execute([$nama, $username, $role, $id]);

        // Redirect to the users.php page after successful update
        // Display success notification using JavaScript
        echo '<script>';
        echo 'alert("Update data berhasil!");';
        echo 'window.location.href = "users.php";'; // Redirect to the users.php page after successful update
        echo '</script>';
        exit;
    } catch (PDOException $e) {
        echo 'Error: ' . $e->getMessage();
    }
} else {
    // If the request method is not POST, redirect to the homepage or display an error message
    header("Location: index.php"); // Change this to the desired location
    exit;
}
