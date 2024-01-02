<?php
// Pastikan mengganti informasi database sesuai dengan kebutuhan Anda
//include 'conn.php';

$host = "localhost"; // Sesuaikan dengan host MySQL Anda
$username = "root"; // Sesuaikan dengan nama pengguna MySQL Anda
$password = ""; // Sesuaikan dengan kata sandi MySQL Anda
$dbname = "sijali"; // Sesuaikan dengan nama database Anda

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // Get data from the form
        $nama = $_POST['nama'];
        $username = $_POST['username'];
        $password = md5($_POST['password']); // Hash the password
        $role = $_POST['role'];

        // Check if the username already exists
        $stmt = $pdo->prepare("SELECT COUNT(*) FROM users WHERE username = ?");
        $stmt->execute([$username]);
        $count = $stmt->fetchColumn();

        if ($count > 0) {
            // Username already exists, display a popup or error message
            echo '<script>alert("Username sudah ada. Silahkan input username lain!"); window.location.href = "add_user.php";</script>';
            exit;
        }

        // Insert new user data into the database
        $stmt = $pdo->prepare("INSERT INTO users (nama, username, password, role) VALUES (?, ?, ?, ?)");
        $stmt->execute([$nama, $username, $password, $role]);

        // Redirect to the users.php page after successful addition
        header("Location: users.php");
        exit;
    } catch (PDOException $e) {
        echo 'Error: ' . $e->getMessage();
    }
} else {
    // If the request method is not POST, redirect to the homepage or display an error message
    header("Location: index.php"); // Change this to the desired location
    exit;
}
