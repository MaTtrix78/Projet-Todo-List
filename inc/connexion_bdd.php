<?php

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

$dsn = 'mysql:host=localhost;dbname=todo_app;charset=utf8mb4';
$utilisateurBdd = 'root';
$motDePasseBdd = '';
$optionsPdo = [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES => false,
];

try {
    $pdo = new PDO($dsn, $utilisateurBdd, $motDePasseBdd, $optionsPdo);
} catch (PDOException $e) {
    error_log('Erreur de connexion PDO (todo_app) : ' . $e->getMessage());
    http_response_code(500);
    exit('Service temporairement indisponible. Veuillez réessayer plus tard.');
}