<?php
header("Access-Control-Allow-Origin: *");
include 'koneksi.php';

$id = $_POST['id'];
$judul = $_POST['judul'];
$harga = $_POST['harga'];
$jumlah = $_POST['jumlah'];
$tanggal_masuk = $_POST['tanggal_masuk'];
$volume = $_POST['volume'];
$penulis = $_POST['penulis'];
$penerbit = $_POST['penerbit'];

$sql = "UPDATE buku SET 
        judul='$judul', 
        harga='$harga', 
        jumlah='$jumlah', 
        tanggal_masuk='$tanggal_masuk',
        volume='$volume',
        penulis='$penulis',
        penerbit='$penerbit'
        WHERE id='$id'";

if(mysqli_query($koneksi, $sql)){
    echo json_encode(["message" => "Berhasil update"]);
} else {
    echo json_encode(["message" => "Gagal update"]);
}
?>