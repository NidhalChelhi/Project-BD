-- =========================================================================================
-- Fichier : create_tables.sql
-- Description : Ce script crée toutes les tables nécessaires pour le projet.
-- Auteur : [Votre Nom]
-- Date : [Date du projet]
-- =========================================================================================

-- Table: Lieu
CREATE TABLE Lieu (
    idLieu INTEGER PRIMARY KEY,
    NomLieu VARCHAR2(30) NOT NULL,
    Adresse VARCHAR2(100) NOT NULL,
    capacite NUMBER NOT NULL CHECK (capacite BETWEEN 100 AND 2000),
    status VARCHAR2(10) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'DELETED'))
);

-- Table: Artiste
CREATE TABLE Artiste (
    idArt INTEGER PRIMARY KEY,
    NomArt VARCHAR2(30) NOT NULL,
    PrenomArt VARCHAR2(30) NOT NULL,
    specialite VARCHAR2(10) NOT NULL
);

-- Table: Spectacle
CREATE TABLE Spectacle (
    idSpec INTEGER PRIMARY KEY,
    Titre VARCHAR2(40) NOT NULL,
    dateS DATE,
    h_debut NUMBER(4,2) NOT NULL,
    dureeS NUMBER(4,2) NOT NULL CHECK (dureeS BETWEEN 1 AND 4),
    nbrSpectateur INTEGER NOT NULL,
    idLieu INTEGER NOT NULL,
    CONSTRAINT fk_spect_lieu FOREIGN KEY (idLieu) REFERENCES Lieu(idLieu),
    CONSTRAINT chk_nbrSpectateurs CHECK (nbrSpectateur > 0)
);

-- Table: Rubrique
CREATE TABLE Rubrique (
    idRub INTEGER PRIMARY KEY,
    idSpec INTEGER NOT NULL,
    idArt INTEGER NOT NULL,
    h_debutR NUMBER(4,2) NOT NULL,
    dureeRub NUMBER(4,2) NOT NULL,
    type VARCHAR2(10),
    CONSTRAINT fk_rub_spec FOREIGN KEY (idSpec) REFERENCES Spectacle(idSpec) ON DELETE CASCADE,
    CONSTRAINT fk_rub_art FOREIGN KEY (idArt) REFERENCES Artiste(idArt) ON DELETE CASCADE
);

-- Table: Billet
CREATE TABLE Billet (
    idBillet INTEGER PRIMARY KEY,
    categorie VARCHAR2(10) CHECK (categorie IN ('Gold', 'Silver', 'Normale')),
    prix NUMBER(5,2) NOT NULL CHECK (prix BETWEEN 10 AND 300),
    idSpec INTEGER NOT NULL,
    vendu VARCHAR2(3) NOT NULL CHECK (vendu IN ('Oui', 'Non')),
    CONSTRAINT fk_billet_spec FOREIGN KEY (idSpec) REFERENCES Spectacle(idSpec)
);

-- Fin du fichier
