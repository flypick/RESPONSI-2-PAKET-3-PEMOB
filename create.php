<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST"); // Izinkan metode POST
include 'koneksi.php';

$judul = $_POST['judul'];
$harga = $_POST['harga'];
$jumlah = $_POST['jumlah'];
$tanggal_masuk = $_POST['tanggal_masuk'];
$volume = $_POST['volume'];
$penulis = $_POST['penulis'];
$penerbit = $_POST['penerbit'];

$sql = "INSERT INTO buku (judul, harga, jumlah, tanggal_masuk, volume, penulis, penerbit) 
        VALUES ('$judul', '$harga', '$jumlah', '$tanggal_masuk', '$volume', '$penulis', '$penerbit')";

if(mysqli_query($koneksi, $sql)){
    echo json_encode(["message" => "Berhasil menambahkan buku"]);
} else {
    echo json_encode(["message" => "Gagal menambahkan buku"]);
}
?>