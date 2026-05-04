<?php include 'connexion.php'; ?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Mes auto-écoles</title>
    
</head>
<body>
    <h1>Liste des auto-écoles</h1>

    <?php
    $sql     = "SELECT * FROM AutoEcole";
    $result  = mysqli_query($conn, $sql);

    if (mysqli_num_rows($result) > 0) {
        echo "<table>
                <tr>
                    <th>ID</th>
                    <th>Nom</th>
                </tr>";

        while ($row = mysqli_fetch_assoc($result)) {
            echo "<tr>
                    <td>{$row['id']}</td>
                    <td>{$row['nom']}</td>
                  </tr>";
        }
        echo "</table>";
    } else {
        echo "<p>Aucune auto-école trouvée.</p>";
    }

    mysqli_close($conn);
    ?>
</body>
</html>