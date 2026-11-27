Projet PHP – ToDo ListApplication web de gestion de listes de tâches développée en PHP et MySQL. Elle permet à chaque utilisateur de créer un compte, d'organiser ses listes, de gérer ses tâches (statut, priorité, échéance), de les filtrer ou trier et de suivre son avancement depuis un tableau de bord.PrérequisServeur web local avec PHP (ex. WampServer, XAMPP, Laragon)Serveur de base de données MySQL (avec phpMyAdmin ou client en ligne de commande)Git pour cloner le dépôtInstallation pas à pas1. Cloner le dépôtOuvrez un terminal dans le répertoire racine de votre serveur web (ex. www sous WampServer ou htdocs) et exécutez :git clone <URL_DE_VOTRE_DEPOT_GITHUB>
cd Projet-Todo-List
2. Créer et initialiser la base de donnéesOuvrez phpMyAdmin (http://localhost/phpmyadmin).Créez une nouvelle base de données vide nommée todo_app avec l'interclassement utf8mb4_unicode_ci (ou importez directement le script qui exécute CREATE DATABASE).Dans l'onglet Importer, sélectionnez le fichier SQL du projet (bdd.sql) et cliquez sur Exécuter.Vérifiez que les trois tables (utilisateur, liste, tache) ainsi que les données de test sont bien présentes.3. Configurer la connexion à la base de donnéesOuvrez le fichier inc/connexion_bdd.php et vérifiez les paramètres de connexion à MySQL selon votre environnement local :$dsn = 'mysql:host=localhost;dbname=todo_app;charset=utf8mb4';
$utilisateurBdd = 'root';
$motDePasseBdd = '';
(Sous WampServer par défaut, l'identifiant est root et le mot de passe est vide "".)4. Lancer l'applicationDémarrez les services Apache et MySQL de votre serveur local.Ouvrez votre navigateur à l'adresse du projet (http://localhost/Projet-Todo-List/index.php).Comptes de testLe script bdd.sql crée automatiquement deux comptes utilisateurs accompagnés de listes et de tâches couvrant tous les statuts et toutes les priorités :IdentifiantMot de passealiceMotDePasseAlice123!bobMotDePasseBob456!Structure du projetProjet-Todo-List/
├── css/
│   └── style.css          # Feuille de style principale de l'application
├── inc/
│   ├── connexion_bdd.php  # Connexion PDO à MySQL (try/catch + error_log)
│   ├── connexion.php      # Gestion / traitement de la connexion utilisateur
│   ├── deconnexion.php    # Gestion / traitement de la déconnexion
│   ├── entete.php         # Gabarit haut de page (HTML <head> et menu)
│   ├── fonctions.php      # Requêtes préparées et fonctions utilitaires
│   ├── init.php           # Démarrage commun (session, ini_set, inclusions)
│   └── pied.php           # Gabarit bas de page (pied de page et fermeture HTML)
├── bdd.sql                # Script de création des tables et données de test
├── index.php              # Page d'accueil / Tableau de bord
└── README.md              # Documentation du projet
FonctionnalitésGestion des comptes : inscription avec contrôle des saisies et hachage sécurisé du mot de passe (password_hash), connexion, déconnexion et accès restreint aux pages privées.Gestion des listes : affichage des listes personnelles avec compteur de tâches et pourcentage d'avancement, création, renommage et suppression (entraînant la suppression en cascade des tâches associées).Gestion des tâches : création, changement de statut (À faire, En cours, Terminée), attribution d'une priorité (Basse, Moyenne, Haute, Urgente), gestion d'une échéance et suppression.Filtres, recherche et tri : filtrage par statut et priorité, recherche par mot-clé dans le titre et tri dynamique des tâches.Tableau de bord : récapitulatif chiffré des tâches de l'utilisateur connecté et affichage des 5 prochaines tâches à échéance.