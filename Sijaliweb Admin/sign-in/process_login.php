<?php
// Include file koneksi ke database
include '..\conn.php';

// Inisialisasi pesan kesalahan
$errorMsg = '';

// Cek apakah form login telah di-submit
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Ambil data dari form
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Enkode password menggunakan MD5
    $hashedPassword = md5($password);

    // Query untuk memeriksa keberadaan username, password, dan role di database
    $query = "SELECT * FROM users WHERE username = '$username' AND password = '$hashedPassword' AND role = 'admin'";
    $result = mysqli_query($conn, $query);

    if ($result) {
        // Cek jumlah baris hasil query
        $num_rows = mysqli_num_rows($result);

        if ($num_rows == 1) {
            // Jika username, password, dan role cocok, set variabel sesi dan redirect ke halaman dashboard
            session_start();

            // Ambil data pengguna
            $user_data = mysqli_fetch_assoc($result);

            // Set variabel sesi
            $_SESSION['user_id'] = $user_data['id']; // Sesuaikan dengan nama kolom ID di tabel
            $_SESSION['username'] = $user_data['username'];

            // Redirect ke halaman dashboard
            header('Location: ..\dashboard\users.php');
            exit();
        } else {
            // Jika username atau password atau role salah, set pesan kesalahan
            $errorMsg = 'Username, password, atau role salah. Silakan coba lagi.';
        }
    } else {
        // Jika terjadi kesalahan dalam query, set pesan kesalahan
        $errorMsg = 'Terjadi kesalahan dalam login. Silakan coba lagi.';
        echo "Error: " . mysqli_error($conn);
    }

    // Tutup koneksi ke database
    mysqli_close($conn);
}
?>

    <script>
        <?php if ($errorMsg): ?>
            alert('<?php echo $errorMsg; ?>');
            window.location.href = 'index.php';
        <?php endif; ?>
    </script>

