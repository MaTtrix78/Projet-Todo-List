-- 1. Création et sélection de la base de données
DROP DATABASE IF EXISTS todo_app;
CREATE DATABASE todo_app
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE todo_app;

-- 2. Table utilisateur
CREATE TABLE utilisateur (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    identifiant VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(120) UNIQUE,
    mdp_hash VARCHAR(255) NOT NULL,
    date_inscription DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Table liste
CREATE TABLE liste (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    couleur VARCHAR(7) NOT NULL DEFAULT '#3B82F6',
    utilisateur_id INT UNSIGNED NOT NULL,
    date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_liste_utilisateur
        FOREIGN KEY (utilisateur_id)
        REFERENCES utilisateur (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Table tache
CREATE TABLE tache (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    liste_id INT UNSIGNED NOT NULL,
    titre VARCHAR(150) NOT NULL,
    description TEXT NULL,
    priorite VARCHAR(20) NOT NULL DEFAULT 'moyenne',
    statut VARCHAR(20) NOT NULL DEFAULT 'a_faire',
    echeance DATETIME NULL,
    position INT UNSIGNED NOT NULL DEFAULT 0,
    date_creation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_tache_liste
        FOREIGN KEY (liste_id)
        REFERENCES liste (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT chk_tache_priorite
        CHECK (priorite IN ('basse', 'moyenne', 'haute', 'urgente')),
    CONSTRAINT chk_tache_statut
        CHECK (statut IN ('a_faire', 'en_cours', 'terminee'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Index pour accélérer les jointures et filtres courants
CREATE INDEX idx_liste_utilisateur_id ON liste (utilisateur_id);
CREATE INDEX idx_tache_liste_id ON tache (liste_id);
CREATE INDEX idx_tache_statut ON tache (statut);
CREATE INDEX idx_tache_priorite ON tache (priorite);

-- ============================================================================
-- 5. Données de test (2 utilisateurs, 4 listes, 16 tâches)
-- Mots de passe en clair (à renseigner dans le README) :
--   - alice : MotDePasseAlice123!
--   - bob   : MotDePasseBob456!
-- ============================================================================

INSERT INTO utilisateur (identifiant, email, mdp_hash) VALUES
    ('alice', 'alice@exemple.fr', '$2b$12$exempleHashBcryptPourAlice1234567890123456789012'),
    ('bob',   'bob@exemple.fr',   '$2b$12$exempleHashBcryptPourBob12345678901234567890123');

INSERT INTO liste (nom, couleur, utilisateur_id) VALUES
    ('Projet Université', '#2563EB', 1),
    ('Courses & Maison',  '#16A34A', 1),
    ('Travail Quotidien', '#D97706', 2),
    ('Objectifs Perso',   '#9333EA', 2);

INSERT INTO tache (liste_id, titre, description, priorite, statut, echeance, position) VALUES
    -- Liste 1 : Projet Université (Alice)
    (1, 'Rédiger le cahier des charges', 'Définir le périmètre et les cas d''usage', 'haute', 'terminee', '2026-11-10 18:00:00', 1),
    (1, 'Concevoir le schéma relationnel', 'Tables utilisateur, liste et tache', 'urgente', 'terminee', '2026-11-20 18:00:00', 2),
    (1, 'Écrire les tests unitaires', NULL, 'moyenne', 'en_cours', '2026-12-05 23:59:00', 3),
    (1, 'Préparer la soutenance', 'Slides de 10 minutes + démo live', 'basse', 'a_faire', NULL, 4),

    -- Liste 2 : Courses & Maison (Alice)
    (2, 'Acheter du café en grains', NULL, 'moyenne', 'a_faire', '2026-11-29 12:00:00', 1),
    (2, 'Ranger le bureau', 'Trier les câbles et documents papier', 'basse', 'en_cours', NULL, 2),
    (2, 'Payer la facture d''électricité', 'Vérifier le prélèvement mensuel', 'urgente', 'a_faire', '2026-11-30 20:00:00', 3),
    (2, 'Commander des ampoules LED', NULL, 'basse', 'terminee', '2026-11-15 17:00:00', 4),

    -- Liste 3 : Travail Quotidien (Bob)
    (3, 'Corriger le bug de connexion', 'Erreur 500 quand l''identifiant contient un espace', 'urgente', 'en_cours', '2026-11-27 17:30:00', 1),
    (3, 'Relire la pull request #42', NULL, 'haute', 'a_faire', '2026-11-28 11:00:00', 2),
    (3, 'Mettre à jour la documentation API', 'Ajouter les codes retour d''erreur', 'moyenne', 'terminee', '2026-11-18 16:00:00', 3),
    (3, 'Nettoyer les branches Git obsolètes', NULL, 'basse', 'a_faire', NULL, 4),

    -- Liste 4 : Objectifs Perso (Bob)
    (4, 'Courir 10 km', 'Sortie endurance fondamentale', 'moyenne', 'terminee', '2026-11-22 10:00:00', 1),
    (4, 'Lire deux chapitres d''un livre technique', NULL, 'basse', 'en_cours', '2026-12-01 21:00:00', 2),
    (4, 'Sauvegarder les photos sur disque externe', 'Vérifier l''intégrité de l''archive', 'haute', 'a_faire', '2026-12-10 19:00:00', 3),
    (4, 'Planifier les congés d''hiver', NULL, 'basse', 'a_faire', NULL, 4);