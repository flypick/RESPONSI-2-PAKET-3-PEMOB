<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
include 'koneksi.php';

$query = mysqli_query($koneksi, "SELECT * FROM buku");
$result = array();

while($row = mysqli_fetch_assoc($query)){
    $result[] = $row;
}

echo json_encode($result);
?>