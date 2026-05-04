<?php include 'connexion.php'; ?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mes utilisateurs</title>
    
</head>
<body>
    <h1>Liste des utilisateurs</h1>

    <?php
    $sql     = "SELECT * FROM utilisateurs";
    $result  = mysqli_query($conn, $sql);

    if (mysqli_num_rows($result) > 0) {
        echo "<table>
                <tr>
                    <th>ID</th>
                    <th>Nom</th>
                    <th>Prénom</th>
                    <th>Email</th>
                </tr>";

        while ($row = mysqli_fetch_assoc($result)) {
            echo "<tr>
                    <td>{$row['id']}</td>
                    <td>{$row['nom']}</td>
                    <td>{$row['prenom']}</td>
                    <td>{$row['email']}</td>
                  </tr>";
        }
        echo "</table>";
    } else {
        echo "<p>Aucun utilisateur trouvé.</p>";
    }

    mysqli_close($conn);
    ?>
</body>
</html>