
<?php
// Pastikan mengganti informasi database sesuai dengan kebutuhan Anda
// include 'conn.php';

$host = "localhost"; // Sesuaikan dengan host MySQL Anda
$username = "root"; // Sesuaikan dengan nama pengguna MySQL Anda
$password = ""; // Sesuaikan dengan kata sandi MySQL Anda
$database = "sijali"; // Sesuaikan dengan nama database Anda

if ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['id'])) {
    $userId = $_GET['id'];

    try {
        $pdo = new PDO("mysql:host=$host;dbname=$database", $username, $password);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // Hapus data pengguna berdasarkan ID
        $stmt = $pdo->prepare("DELETE FROM users WHERE id = ?");
        $stmt->execute([$userId]);

        // Redirect kembali ke halaman users.php setelah penghapusan
        header('Location: users.php');
        exit;
    } catch (PDOException $e) {
        echo 'Error: ' . $e->getMessage();
        exit;
    }
} else {
    // Metode permintaan tidak valid atau parameter ID tidak diberikan
    echo 'Permintaan tidak valid.';
    exit;
}
