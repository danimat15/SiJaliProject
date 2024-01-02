<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout</title>
    <!-- Tambahkan link CSS Bootstrap jika diperlukan -->
    <link rel="stylesheet" href="path/to/bootstrap.css">
    <!-- Tambahkan script Bootstrap jika diperlukan -->
    <script src="path/to/bootstrap.js"></script>
</head>

<body>



    <?php
// Mulai sesi
session_start();
    // Periksa apakah form konfirmasi logout telah dikirim
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Proses logout di sini (hapus sesi atau tindakan logout lainnya)

        // Redirect ke halaman index.php
        header("Location: ..\sign-in\index.php");
        exit();
    }
    ?>

    <!-- Tampilkan popup konfirmasi -->
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body text-center">
                        <h5 class="card-title">Konfirmasi Logout</h5>
                        <p class="card-text">Apakah Anda yakin ingin keluar?</p>
                        <form method="post">
                            <button type="submit" class="btn btn-primary">Ya, Logout</button>
                            <a href="index.php" class="btn btn-secondary">Tidak, Batal</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <?php


    // Hapus semua data sesi
    session_unset();

    // Hancurkan sesi
    session_destroy();

    // Redirect ke halaman login setelah logout
    header('Location: ../sign-in/index.php'); // Gantilah dengan path yang benar
    exit();
    ?>
</body>

</html>