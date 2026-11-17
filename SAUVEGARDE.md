# Sauvegarde et restauration – EntaideÉtu

## Solution
- Code source : Git + GitHub (copie distante + historique de toutes les versions).
- Base de données : export SQL `entraideetu.sql`, versionné avec le code.

## Sauvegarde
1. Exporter la BD :
   `C:\xampp\mysql\bin\mysqldump.exe -u root --databases entraideetu --result-file=entraideetu.sql`
2. `git add .`
3. `git commit -m "message"`
4. `git push`

## Restauration
1. Cloner le dépôt dans `C:\xampp\htdocs\` :
   `git clone https://github.com/ncKaza/ProjetAlexisAutoEcole.git`
2. phpMyAdmin → onglet Importer → `entraideetu.sql` (recrée la base et les tables).
3. Démarrer Apache et MySQL dans XAMPP.
4. Ouvrir `http://localhost/ProjetAlexisAutoEcole/pages/index.html`.
5. Revenir à une ancienne version : `git log --oneline` puis `git checkout <commit>`.

## Test réalisé le 18/11/2026
- Clone dans `C:\xampp\htdocs\test_restauration` → site affiché : OK
- Import du SQL dans une base de test `entraideetu_test` → 4 tables présentes : OK