<?php
session_start();
include '../connexion.php';
header('Content-Type: application/json; charset=utf-8');
mysqli_set_charset($conn, 'utf8mb4');

// 1. Seul un étudiant connecté peut modifier son profil
if (!isset($_SESSION['user'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Tu dois être connecté.'], JSON_UNESCAPED_UNICODE);
    exit;
}

// 2. Lire les nouvelles valeurs envoyées en JSON
$data    = json_decode(file_get_contents('php://input'), true);
$prenom  = trim($data['prenom'] ?? '');
$nom     = trim($data['nom'] ?? '');
$commune = trim($data['commune'] ?? '');

if ($prenom === '' || $nom === '') {
    http_response_code(422);
    echo json_encode(['error' => 'Prénom et nom obligatoires.'], JSON_UNESCAPED_UNICODE);
    exit;
}

// 3. UPDATE en requête préparée : l'id vient de la SESSION, jamais du formulaire
$id = $_SESSION['user']['id'];
$stmt = mysqli_prepare($conn, "UPDATE utilisateur SET prenom = ?, nom = ?, commune = ? WHERE id = ?");
mysqli_stmt_bind_param($stmt, 'sssi', $prenom, $nom, $commune, $id);
mysqli_stmt_execute($stmt);

// 4. Mettre la session à jour (le menu affichera le nouveau prénom)
$_SESSION['user']['prenom']  = $prenom;
$_SESSION['user']['nom']     = $nom;
$_SESSION['user']['commune'] = $commune;

echo json_encode(['user' => $_SESSION['user']], JSON_UNESCAPED_UNICODE);
mysqli_close($conn);