<?php
header("Access-Control-Allow-Origin: *");
include 'koneksi.php';

$username = $_POST['username'];
$password = md5($_POST['password']); // Password dienkripsi sederhana

$sql = "INSERT INTO users (username, password) VALUES ('$username', '$password')";

if(mysqli_query($koneksi, $sql)){
    echo json_encode(["message" => "Registrasi Berhasil"]);
} else {
    echo json_encode(["message" => "Gagal"]);
}
?>