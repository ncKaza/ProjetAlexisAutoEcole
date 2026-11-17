<?php
session_start();
header('Content-Type: application/json; charset=utf-8');

// Renvoie l'étudiant connecté, ou une erreur 401 si personne n'est connecté
if (!isset($_SESSION['user'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Non connecté']);
    exit;
}

echo json_encode(['user' => $_SESSION['user']], JSON_UNESCAPED_UNICODE);
