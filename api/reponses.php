<?php
session_start();
include '../connexion.php';
header('Content-Type: application/json; charset=utf-8');
mysqli_set_charset($conn, 'utf8mb4');

// POST : ajouter une réponse à un sujet (étudiant connecté uniquement)
if (!isset($_SESSION['user'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Tu dois être connecté pour répondre.'], JSON_UNESCAPED_UNICODE);
    exit;
}

$data    = json_decode(file_get_contents('php://input'), true);
$idSujet = (int) ($data['id_sujet'] ?? 0);
$message = trim($data['message'] ?? '');

if ($idSujet <= 0 || $message === '') {
    http_response_code(422);
    echo json_encode(['error' => 'Message obligatoire.'], JSON_UNESCAPED_UNICODE);
    exit;
}

$idUtilisateur = $_SESSION['user']['id'];

$stmt = mysqli_prepare($conn,
    "INSERT INTO reponse (message, id_sujet, id_utilisateur) VALUES (?, ?, ?)");
mysqli_stmt_bind_param($stmt, 'sii', $message, $idSujet, $idUtilisateur);

try {
    mysqli_stmt_execute($stmt);
} catch (mysqli_sql_exception $e) {
    // ex : le sujet n'existe pas (la clé étrangère refuse l'insertion)
    http_response_code(400);
    echo json_encode(['error' => 'Sujet introuvable.'], JSON_UNESCAPED_UNICODE);
    exit;
}

http_response_code(201);
echo json_encode(['id' => mysqli_insert_id($conn)]);
mysqli_close($conn);
