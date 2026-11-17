// Vérifie si un étudiant est connecté (session PHP) et met à jour la page
let utilisateurConnecte = null;

function afficherUtilisateur() {
  fetch('../api/me.php')
    .then(r => r.ok ? r.json() : null)
    .then(data => {
      const champNom = document.getElementById('compose-name'); // champ "prénom" du forum (page d'accueil)

      // Personne n'est connecté
      if (!data) {
        if (champNom) {
          champNom.placeholder = 'Connecte-toi pour publier…';
          champNom.readOnly = true;
        }
        return;
      }

      // Un étudiant est connecté
      utilisateurConnecte = data.user;

      const lien = document.getElementById('nav-auth');
      if (lien) {
        lien.textContent = '👤 ' + data.user.prenom;
        lien.href = 'profil.html';
      }

      if (champNom) {
        champNom.value = data.user.prenom + ' ' + data.user.nom;
        champNom.readOnly = true;
        champNom.dispatchEvent(new Event('input')); // met à jour l'avatar
      }
    });
}