<?php

// Désactive l'affichage des erreurs PHP à l'écran (elles restent journalisées côté serveur)
ini_set('display_errors', '0');
ini_set('display_startup_errors', '0');

// Démarrage de la session si aucune session n'est déjà active
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Chargement de la connexion à la base de données ($pdo) et des fonctions utilitaires
require_once __DIR__ . '/connexion_bdd.php';
require_once __DIR__ . '/fonctions.php';