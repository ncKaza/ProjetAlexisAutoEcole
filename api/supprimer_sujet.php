<?php
session_start();
include '../connexion.php';
header('Content-Type: application/json; charset=utf-8');
mysqli_set_charset($conn, 'utf8mb4');

// 1. Il faut être connecté
if (!isset($_SESSION['user'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Tu dois être connecté.'], JSON_UNESCAPED_UNICODE);
    exit;
}

$data    = json_decode(file_get_contents('php://input'), true);
$idSujet = (int) ($data['id'] ?? 0);

// 2. Vérifier que le sujet existe et appartient à l'utilisateur connecté
$stmt = mysqli_prepare($conn, "SELECT id_utilisateur FROM sujet WHERE id = ?");
mysqli_stmt_bind_param($stmt, 'i', $idSujet);
mysqli_stmt_execute($stmt);
$sujet = mysqli_fetch_assoc(mysqli_stmt_get_result($stmt));

if (!$sujet) {
    http_response_code(404);
    echo json_encode(['error' => 'Sujet introuvable.'], JSON_UNESCAPED_UNICODE);
    exit;
}
if ((int) $sujet['id_utilisateur'] !== (int) $_SESSION['user']['id']) {
    http_response_code(403);
    echo json_encode(['error' => 'Tu ne peux supprimer que tes propres messages.'], JSON_UNESCAPED_UNICODE);
    exit;
}

// 3. Supprimer (les réponses partent aussi grâce à ON DELETE CASCADE)
$stmt = mysqli_prepare($conn, "DELETE FROM sujet WHERE id = ?");
mysqli_stmt_bind_param($stmt, 'i', $idSujet);
mysqli_stmt_execute($stmt);

echo json_encode(['ok' => true]);
mysqli_close($conn);