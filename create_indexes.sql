-- =========================================================================================
-- Fichier : create_indexes.sql
-- Description : Ce script crée des indexes pour optimiser les recherches dans les tables.
-- Auteur : [Votre Nom]
-- Date : [Date du projet]
-- =========================================================================================

-- Index pour chercher par nom dans la table Lieu
CREATE INDEX idx_lieu_nom ON Lieu (NomLieu);

-- Index pour chercher par adresse dans la table Lieu
CREATE INDEX idx_lieu_adresse ON Lieu (Adresse);

-- Index pour chercher par titre dans la table Spectacle
CREATE INDEX idx_spectacle_titre ON Spectacle (Titre);

-- Index pour chercher par date dans la table Spectacle
CREATE INDEX idx_spectacle_date ON Spectacle (dateS);

-- Index pour chercher par type dans la table Rubrique
CREATE INDEX idx_rubrique_type ON Rubrique (type);

-- Index pour chercher par catégorie dans la table Billet
CREATE INDEX idx_billet_categorie ON Billet (categorie);

-- Fin du fichier
