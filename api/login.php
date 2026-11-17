<?php
session_start();
include '../connexion.php';
header('Content-Type: application/json; charset=utf-8');
mysqli_set_charset($conn, 'utf8mb4');

$data  = json_decode(file_get_contents('php://input'), true);
$email = trim($data['email'] ?? '');
$mdp   = $data['password'] ?? '';

// 1. Chercher l'utilisateur par son email (requête préparée)
$stmt = mysqli_prepare($conn,
    "SELECT id, prenom, nom, email, commune, mot_de_passe FROM utilisateur WHERE email = ?");
mysqli_stmt_bind_param($stmt, 's', $email);
mysqli_stmt_execute($stmt);
$resultat = mysqli_stmt_get_result($stmt);
$user = mysqli_fetch_assoc($resultat);

// 2. Vérifier le mot de passe avec le hash stocké
if (!$user || !password_verify($mdp, $user['mot_de_passe'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Email ou mot de passe incorrect.'], JSON_UNESCAPED_UNICODE);
    exit;
}

// 3. Ne jamais renvoyer le hash, puis mémoriser l'utilisateur en session
unset($user['mot_de_passe']);
$_SESSION['user'] = $user;

echo json_encode(['token' => '', 'user' => $user], JSON_UNESCAPED_UNICODE);
mysqli_close($conn);
