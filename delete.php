<?php
header("Access-Control-Allow-Origin: *");
include 'koneksi.php';

$id = $_POST['id'];

$sql = "DELETE FROM buku WHERE id='$id'";

if(mysqli_query($koneksi, $sql)){
    echo json_encode(["message" => "Berhasil hapus"]);
} else {
    echo json_encode(["message" => "Gagal hapus"]);
}
?>