-- =========================================================================================
-- Fichier : pkg_spectacle.pkb
-- Description : Package body pour la gestion des spectacles.
-- Auteur : [Votre Nom]
-- Date : [Date du projet]
-- =========================================================================================
CREATE OR REPLACE PACKAGE BODY pkg_spectacle AS

    -- Procédure pour ajouter un spectacle
    PROCEDURE add_spectacle (
        p_titre IN VARCHAR2,
        p_dateS IN DATE,
        p_h_debut IN NUMBER,
        p_dureeS IN NUMBER,
        p_nbrSpectateur IN NUMBER,
        p_idLieu IN NUMBER
    ) IS
        v_venue_capacity NUMBER;
        v_conflict_count NUMBER;
    BEGIN
        -- Vérifier la capacité du lieu
        SELECT capacite INTO v_venue_capacity
        FROM Lieu
        WHERE idLieu = p_idLieu AND status = 'ACTIVE';

        IF p_nbrSpectateur > v_venue_capacity THEN
            RAISE_APPLICATION_ERROR(-20001, 'La capacité du lieu est insuffisante pour ce spectacle.');
        END IF;

        -- Vérifier les conflits d'horaires avec d'autres spectacles
        SELECT COUNT(*) INTO v_conflict_count
        FROM Spectacle
        WHERE idLieu = p_idLieu
          AND dateS = p_dateS
          AND (p_h_debut BETWEEN h_debut AND (h_debut + dureeS)
               OR (p_h_debut + p_dureeS) BETWEEN h_debut AND (h_debut + dureeS));

        IF v_conflict_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Un conflit d horaire existe avec un autre spectacle.');
        END IF;

        -- Ajouter le spectacle
        INSERT INTO Spectacle (Titre, dateS, h_debut, dureeS, nbrSpectateur, idLieu)
        VALUES (p_titre, p_dateS, p_h_debut, p_dureeS, p_nbrSpectateur, p_idLieu);

        DBMS_OUTPUT.PUT_LINE('Spectacle ajouté avec succès : ' || p_titre);
    END add_spectacle;

    -- Procédure pour annuler un spectacle
    PROCEDURE cancel_spectacle (
        p_idSpec IN NUMBER
    ) IS
    BEGIN
        UPDATE Spectacle
        SET dateS = NULL
        WHERE idSpec = p_idSpec;

        DBMS_OUTPUT.PUT_LINE('Spectacle annulé avec succès : ' || p_idSpec);
    END cancel_spectacle;

    -- Procédure pour modifier un spectacle
    PROCEDURE update_spectacle (
        p_idSpec IN NUMBER,
        p_titre IN VARCHAR2 DEFAULT NULL,
        p_dateS IN DATE DEFAULT NULL,
        p_h_debut IN NUMBER DEFAULT NULL,
        p_dureeS IN NUMBER DEFAULT NULL,
        p_nbrSpectateur IN NUMBER DEFAULT NULL,
        p_idLieu IN NUMBER DEFAULT NULL
    ) IS
        v_venue_capacity NUMBER;
    BEGIN
        -- Vérifier si la capacité du lieu est respectée
        IF p_idLieu IS NOT NULL THEN
            SELECT capacite INTO v_venue_capacity
            FROM Lieu
            WHERE idLieu = p_idLieu AND status = 'ACTIVE';

            IF p_nbrSpectateur IS NOT NULL AND p_nbrSpectateur > v_venue_capacity THEN
                RAISE_APPLICATION_ERROR(-20001, 'La capacité du lieu est insuffisante pour ce spectacle.');
            END IF;
        END IF;

        -- Mettre à jour le spectacle
        UPDATE Spectacle
        SET Titre = NVL(p_titre, Titre),
            dateS = NVL(p_dateS, dateS),
            h_debut = NVL(p_h_debut, h_debut),
            dureeS = NVL(p_dureeS, dureeS),
            nbrSpectateur = NVL(p_nbrSpectateur, nbrSpectateur),
            idLieu = NVL(p_idLieu, idLieu)
        WHERE idSpec = p_idSpec;

        DBMS_OUTPUT.PUT_LINE('Spectacle mis à jour avec succès : ' || p_idSpec);
    END update_spectacle;

    -- Fonction pour chercher un spectacle
    FUNCTION search_spectacle (
        p_titre IN VARCHAR2 DEFAULT NULL,
        p_idSpec IN NUMBER DEFAULT NULL
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT idSpec, Titre, dateS, h_debut, dureeS, nbrSpectateur, idLieu
        FROM Spectacle
        WHERE (p_titre IS NULL OR LOWER(Titre) LIKE '%' || LOWER(p_titre) || '%')
          AND (p_idSpec IS NULL OR idSpec = p_idSpec);
        RETURN v_cursor;
    END search_spectacle;

END pkg_spectacle;
/
