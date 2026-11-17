<?php
include '../connexion.php';
header('Content-Type: application/json; charset=utf-8');
mysqli_set_charset($conn, 'utf8mb4');

$sql = "SELECT id, nom AS name, commune AS zone, adresse AS address,
               telephone AS phone, note AS rating, nb_avis AS count, conseil AS tip
        FROM autoecole";
$result = mysqli_query($conn, $sql);

$autoecoles = [];
while ($row = mysqli_fetch_assoc($result)) {
    $autoecoles[] = $row;
}

echo json_encode($autoecoles, JSON_UNESCAPED_UNICODE);
mysqli_close($conn);