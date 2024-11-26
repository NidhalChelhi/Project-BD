-- =========================================================================================
-- Fichier : pkg_lieu.pkb
-- Description : Package body pour la gestion des lieux.
-- Auteur : [Votre Nom]
-- Date : [Date du projet]
-- =========================================================================================
CREATE OR REPLACE PACKAGE BODY pkg_lieu AS

    -- Procédure pour ajouter un nouveau lieu
    PROCEDURE add_lieu (
        p_nomLieu IN VARCHAR2,
        p_adresse IN VARCHAR2,
        p_capacite IN NUMBER,
        p_status IN VARCHAR2 DEFAULT 'ACTIVE'
    ) IS
    BEGIN
        INSERT INTO Lieu (NomLieu, Adresse, capacite, status)
        VALUES (p_nomLieu, p_adresse, p_capacite, p_status);
        DBMS_OUTPUT.PUT_LINE('Lieu ajouté avec succès : ' || p_nomLieu);
    END add_lieu;

    -- Procédure pour modifier le nom ou la capacité d'un lieu
    PROCEDURE update_lieu (
        p_idLieu IN NUMBER,
        p_nomLieu IN VARCHAR2,
        p_capacite IN NUMBER
    ) IS
    BEGIN
        UPDATE Lieu
        SET NomLieu = p_nomLieu, capacite = p_capacite
        WHERE idLieu = p_idLieu AND status = 'ACTIVE';
        DBMS_OUTPUT.PUT_LINE('Lieu mis à jour avec succès : ' || p_nomLieu);
    END update_lieu;

    -- Procédure pour supprimer un lieu (physiquement ou logiquement)
    PROCEDURE delete_lieu (
        p_idLieu IN NUMBER
    ) IS
        v_spectacle_count NUMBER;
    BEGIN
        -- Vérifier si des spectacles sont associés à ce lieu
        SELECT COUNT(*) INTO v_spectacle_count
        FROM Spectacle
        WHERE idLieu = p_idLieu;

        IF v_spectacle_count = 0 THEN
            -- Suppression physique si aucun spectacle n'est associé
            DELETE FROM Lieu
            WHERE idLieu = p_idLieu;
            DBMS_OUTPUT.PUT_LINE('Lieu supprimé physiquement : ' || p_idLieu);
        ELSE
            -- Suppression logique si des spectacles existent
            UPDATE Lieu
            SET status = 'DELETED'
            WHERE idLieu = p_idLieu;
            DBMS_OUTPUT.PUT_LINE('Lieu marqué comme supprimé logiquement : ' || p_idLieu);
        END IF;
    END delete_lieu;

    -- Fonction pour rechercher un lieu
    FUNCTION search_lieu (
        p_nomLieu IN VARCHAR2 DEFAULT NULL,
        p_capacite IN NUMBER DEFAULT NULL
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT idLieu, NomLieu, Adresse, capacite, status
        FROM Lieu
        WHERE status = 'ACTIVE'
        AND (p_nomLieu IS NULL OR LOWER(NomLieu) LIKE '%' || LOWER(p_nomLieu) || '%')
        AND (p_capacite IS NULL OR capacite = p_capacite);
        RETURN v_cursor;
    END search_lieu;

END pkg_lieu;
/
