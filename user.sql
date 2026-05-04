CREATE TABLE utilisateurs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    mot_de_passe VARCHAR(255) NOT NULL
);

INSERT INTO utilisateurs (nom, prenom, email, mot_de_passe) VALUES
('Pidjo', 'Alexis', 'alexis.pidjo@example.com', 'motdepasse123');

INSERT INTO utilisateurs (nom, prenom, email, mot_de_passe) VALUES
('Wassaumi', 'Josias', 'josias.wassaumi@example.com', 'motdepasse1234');