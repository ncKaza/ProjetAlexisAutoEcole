<?php
session_start();
include '../connexion.php';
header('Content-Type: application/json; charset=utf-8');
mysqli_set_charset($conn, 'utf8mb4');

// 1. Récupérer les données envoyées par le formulaire (en JSON)
$data = json_decode(file_get_contents('php://input'), true);

$prenom  = trim($data['prenom'] ?? '');
$nom     = trim($data['nom'] ?? '');
$email   = trim($data['email'] ?? '');
$commune = trim($data['commune'] ?? '');
$mdp     = $data['password'] ?? '';

// 2. Vérifications côté serveur
$erreurs = [];
if ($prenom === '' || $nom === '')               $erreurs[] = 'Prénom et nom obligatoires.';
if (!filter_var($email, FILTER_VALIDATE_EMAIL))  $erreurs[] = 'Email invalide.';
if (strlen($mdp) < 8)                            $erreurs[] = 'Mot de passe : 8 caractères minimum.';

if (count($erreurs) > 0) {
    http_response_code(422);
    echo json_encode(['errors' => $erreurs], JSON_UNESCAPED_UNICODE);
    exit;
}

// 3. Vérifier que l'email n'existe pas déjà
$stmt = mysqli_prepare($conn, "SELECT id FROM utilisateur WHERE email = ?");
mysqli_stmt_bind_param($stmt, 's', $email);
mysqli_stmt_execute($stmt);
mysqli_stmt_store_result($stmt);

if (mysqli_stmt_num_rows($stmt) > 0) {
    http_response_code(409);
    echo json_encode(['error' => 'Cet email est déjà utilisé.'], JSON_UNESCAPED_UNICODE);
    exit;
}

// 4. Hasher le mot de passe et insérer l'utilisateur (requête préparée)
$hash = password_hash($mdp, PASSWORD_DEFAULT);

$stmt = mysqli_prepare($conn,
    "INSERT INTO utilisateur (prenom, nom, email, commune, mot_de_passe) VALUES (?, ?, ?, ?, ?)");
mysqli_stmt_bind_param($stmt, 'sssss', $prenom, $nom, $email, $commune, $hash);
mysqli_stmt_execute($stmt);

$user = [
    'id'      => mysqli_insert_id($conn),
    'prenom'  => $prenom,
    'nom'     => $nom,
    'email'   => $email,
    'commune' => $commune
];

// 5. Connecter automatiquement l'étudiant (session PHP)
$_SESSION['user'] = $user;

// 6. Répondre au JavaScript
http_response_code(201);
echo json_encode(['token' => '', 'user' => $user], JSON_UNESCAPED_UNICODE);
mysqli_close($conn);
