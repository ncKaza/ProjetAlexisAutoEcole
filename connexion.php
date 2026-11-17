<?php
$host     = "localhost";
$user     = "root";       // utilisateur par défaut XAMPP
$password = "";           // mot de passe vide par défaut
$database = "entraideetu";

$conn = mysqli_connect($host, $user, $password, $database);

if (!$conn) {
    die("Erreur de connexion : " . mysqli_connect_error());
}
?>