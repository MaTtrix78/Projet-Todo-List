<?php
$pageTitle = $pageTitle ?? 'Todo App';
$utilisateurConnecte = $_SESSION['utilisateur_identifiant'] ?? null;
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= htmlspecialchars($pageTitle, ENT_QUOTES, 'UTF-8') ?></title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header class="site-header">
        <div class="container header-inner">
            <a href="index.php" class="brand">Todo App</a>

            <nav class="main-nav" aria-label="Navigation principale">
                <ul class="nav-list">
                    <li><a href="index.php">Accueil</a></li>
                    <?php if ($utilisateurConnecte !== null): ?>
                        <li class="nav-user">Connecté : <?= htmlspecialchars($utilisateurConnecte, ENT_QUOTES, 'UTF-8') ?></li>
                        <li><a href="deconnexion.php">Déconnexion</a></li>
                    <?php else: ?>
                        <li><a href="connexion.php">Connexion</a></li>
                        <li><a href="inscription.php">Inscription</a></li>
                    <?php endif; ?>
                </ul>
            </nav>
        </div>
    </header>

    <main class="site-main">
        <div class="container"></div>