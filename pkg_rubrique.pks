-- =========================================================================================
-- Fichier : pkg_rubrique.pks
-- Description : Package specification pour la gestion des rubriques.
-- Auteur : [Votre Nom]
-- Date : [Date du projet]
-- =========================================================================================
CREATE OR REPLACE PACKAGE pkg_rubrique AS
    -- Procédure pour ajouter une rubrique
    PROCEDURE add_rubrique (
        p_idSpec IN NUMBER,
        p_idArt IN NUMBER,
        p_h_debutR IN NUMBER,
        p_dureeRub IN NUMBER,
        p_type IN VARCHAR2
    );

    -- Procédure pour modifier une rubrique
    PROCEDURE update_rubrique (
        p_idRub IN NUMBER,
        p_idArt IN NUMBER DEFAULT NULL,
        p_h_debutR IN NUMBER DEFAULT NULL,
        p_dureeRub IN NUMBER DEFAULT NULL,
        p_type IN VARCHAR2 DEFAULT NULL
    );

    -- Procédure pour supprimer une rubrique
    PROCEDURE delete_rubrique (
        p_idRub IN NUMBER
    );

    -- Fonction pour chercher une rubrique
    FUNCTION search_rubrique (
        p_idSpec IN NUMBER DEFAULT NULL,
        p_nomArt IN VARCHAR2 DEFAULT NULL
    ) RETURN SYS_REFCURSOR;

END pkg_rubrique;
/
