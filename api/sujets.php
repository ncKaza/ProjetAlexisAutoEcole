<?php
session_start();
include '../connexion.php';
header('Content-Type: application/json; charset=utf-8');
mysqli_set_charset($conn, 'utf8mb4');

// Protège l'affichage contre l'injection de HTML (faille XSS)
function securiser($texte) {
    return htmlspecialchars($texte, ENT_NOQUOTES, 'UTF-8');
}

/* ════════ POST : publier un nouveau sujet ════════ */
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    if (!isset($_SESSION['user'])) {
        http_response_code(401);
        echo json_encode(['error' => 'Tu dois être connecté pour publier.'], JSON_UNESCAPED_UNICODE);
        exit;
    }

    $data      = json_decode(file_get_contents('php://input'), true);
    $titre     = trim($data['titre'] ?? '');
    $message   = trim($data['message'] ?? '');
    $categorie = $data['categorie'] ?? '';
    $categoriesValides = ['permis', 'avis', 'astuces', 'vie'];

    if ($titre === '' || $message === '' || !in_array($categorie, $categoriesValides)) {
        http_response_code(422);
        echo json_encode(['error' => 'Titre, message et catégorie obligatoires.'], JSON_UNESCAPED_UNICODE);
        exit;
    }

    $idUtilisateur = $_SESSION['user']['id'];

    $stmt = mysqli_prepare($conn,
        "INSERT INTO sujet (titre, message, categorie, id_utilisateur) VALUES (?, ?, ?, ?)");
    mysqli_stmt_bind_param($stmt, 'sssi', $titre, $message, $categorie, $idUtilisateur);
    mysqli_stmt_execute($stmt);

    http_response_code(201);
    echo json_encode(['id' => mysqli_insert_id($conn)]);
    mysqli_close($conn);
    exit;
}

/* ════════ GET : lister les sujets avec leurs réponses ════════ */

// 1. Les sujets + le nom de leur auteur (jointure avec utilisateur)
$sql = "SELECT s.id, s.titre, s.message, s.categorie,
               UNIX_TIMESTAMP(s.date_creation) AS ts, u.prenom, u.nom
        FROM sujet s
        JOIN utilisateur u ON s.id_utilisateur = u.id
        ORDER BY s.date_creation ASC, s.id ASC";
$result = mysqli_query($conn, $sql);

$sujets = [];
while ($row = mysqli_fetch_assoc($result)) {
    $sujets[$row['id']] = [
        'id'      => (int) $row['id'],
        'name'    => securiser($row['prenom'] . ' ' . $row['nom']),
        'title'   => securiser($row['titre']),
        'body'    => securiser($row['message']),
        'cat'     => $row['categorie'],
        'ts'      => (int) $row['ts'] * 1000,   // en millisecondes pour le JavaScript
        'replies' => []
    ];
}

// 2. Les réponses + le nom de leur auteur, rangées dans leur sujet
$sql = "SELECT r.id_sujet, r.message, UNIX_TIMESTAMP(r.date_creation) AS ts, u.prenom, u.nom
        FROM reponse r
        JOIN utilisateur u ON r.id_utilisateur = u.id
        ORDER BY r.date_creation ASC, r.id ASC";
$result = mysqli_query($conn, $sql);

while ($row = mysqli_fetch_assoc($result)) {
    if (isset($sujets[$row['id_sujet']])) {
        $sujets[$row['id_sujet']]['replies'][] = [
            'name' => securiser($row['prenom'] . ' ' . $row['nom']),
            'text' => securiser($row['message']),
            'ts'   => (int) $row['ts'] * 1000
        ];
    }
}

echo json_encode(array_values($sujets), JSON_UNESCAPED_UNICODE);
mysqli_close($conn);
