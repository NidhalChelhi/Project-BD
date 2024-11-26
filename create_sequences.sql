-- =========================================================================================
-- Fichier : create_sequences.sql
-- Description : Ce script crée les séquences nécessaires pour générer des IDs uniques.
-- Auteur : [Votre Nom]
-- Date : [Date du projet]
-- =========================================================================================

-- Séquence pour la table Lieu
CREATE SEQUENCE seq_lieu_id START WITH 1 INCREMENT BY 1;

-- Séquence pour la table Artiste
CREATE SEQUENCE seq_artiste_id START WITH 1 INCREMENT BY 1;

-- Séquence pour la table Spectacle
CREATE SEQUENCE seq_spectacle_id START WITH 1 INCREMENT BY 1;

-- Séquence pour la table Rubrique
CREATE SEQUENCE seq_rubrique_id START WITH 1 INCREMENT BY 1;

-- Séquence pour la table Billet
CREATE SEQUENCE seq_billet_id START WITH 1 INCREMENT BY 1;

-- Fin du fichier
