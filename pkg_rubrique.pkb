-- =========================================================================================
-- Fichier : pkg_rubrique.pkb
-- Description : Package body pour la gestion des rubriques.
-- Auteur : [Votre Nom]
-- Date : [Date du projet]
-- =========================================================================================
CREATE OR REPLACE PACKAGE BODY pkg_rubrique AS

    -- Procédure pour ajouter une rubrique
    PROCEDURE add_rubrique (
        p_idSpec IN NUMBER,
        p_idArt IN NUMBER,
        p_h_debutR IN NUMBER,
        p_dureeRub IN NUMBER,
        p_type IN VARCHAR2
    ) IS
        v_spectacle_start NUMBER;
        v_spectacle_duration NUMBER;
        v_spectacle_end NUMBER;
        v_speciality VARCHAR2(10);
        v_artist_conflict_count NUMBER;
    BEGIN
        -- Vérifier la spécialité de l'artiste
        SELECT specialite INTO v_speciality
        FROM Artiste
        WHERE idArt = p_idArt;

        IF LOWER(v_speciality) != LOWER(p_type) THEN
            RAISE_APPLICATION_ERROR(-20001, 'Le type de la rubrique ne correspond pas à la spécialité de l artiste.');
        END IF;

        -- Récupérer les détails du spectacle
        SELECT h_debut, dureeS INTO v_spectacle_start, v_spectacle_duration
        FROM Spectacle
        WHERE idSpec = p_idSpec;

        -- Calculer l'heure de fin du spectacle
        v_spectacle_end := v_spectacle_start + v_spectacle_duration;

        -- Vérifier si la rubrique commence avant le début du spectacle
        IF p_h_debutR < v_spectacle_start THEN
            RAISE_APPLICATION_ERROR(-20002, 'La rubrique ne peut pas commencer avant le début du spectacle.');
        END IF;

        -- Vérifier si la rubrique dépasse la durée du spectacle
        IF (p_h_debutR + p_dureeRub) > v_spectacle_end THEN
            RAISE_APPLICATION_ERROR(-20003, 'La rubrique dépasse la durée du spectacle.');
        END IF;

        -- Vérifier la disponibilité de l'artiste
        SELECT COUNT(*) INTO v_artist_conflict_count
        FROM Rubrique
        WHERE idArt = p_idArt
          AND idSpec = p_idSpec
          AND (p_h_debutR BETWEEN h_debutR AND (h_debutR + dureeRub)
               OR (p_h_debutR + p_dureeRub) BETWEEN h_debutR AND (h_debutR + dureeRub));

        IF v_artist_conflict_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'L artiste est indisponible à cette heure.');
        END IF;

        -- Ajouter la rubrique
        INSERT INTO Rubrique (idSpec, idArt, h_debutR, dureeRub, type)
        VALUES (p_idSpec, p_idArt, p_h_debutR, p_dureeRub, p_type);

        DBMS_OUTPUT.PUT_LINE('Rubrique ajoutée avec succès.');
    END add_rubrique;

    -- Procédure pour modifier une rubrique
    PROCEDURE update_rubrique (
        p_idRub IN NUMBER,
        p_idArt IN NUMBER DEFAULT NULL,
        p_h_debutR IN NUMBER DEFAULT NULL,
        p_dureeRub IN NUMBER DEFAULT NULL,
        p_type IN VARCHAR2 DEFAULT NULL
    ) IS
        v_speciality VARCHAR2(10);
        v_idSpec NUMBER;
        v_spectacle_start NUMBER;
        v_spectacle_duration NUMBER;
        v_spectacle_end NUMBER;
        v_artist_conflict_count NUMBER;
        v_current_h_debutR NUMBER;
        v_current_dureeRub NUMBER;
        v_updated_h_debutR NUMBER; -- Local variable for updated start time
        v_updated_dureeRub NUMBER; -- Local variable for updated duration
    BEGIN
        -- Vérifier si la rubrique existe
        BEGIN
            SELECT idSpec, h_debutR, dureeRub
            INTO v_idSpec, v_current_h_debutR, v_current_dureeRub
            FROM Rubrique
            WHERE idRub = p_idRub;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20010, 'La rubrique spécifiée n existe pas.');
        END;

        -- Vérifier la spécialité de l'artiste si le type est modifié
        IF p_type IS NOT NULL THEN
            SELECT specialite INTO v_speciality
            FROM Artiste
            WHERE idArt = NVL(p_idArt, (SELECT idArt FROM Rubrique WHERE idRub = p_idRub));

            IF LOWER(v_speciality) != LOWER(p_type) THEN
                RAISE_APPLICATION_ERROR(-20001, 'Le type de la rubrique ne correspond pas à la spécialité de l artiste.');
            END IF;
        END IF;

        -- Récupérer les détails du spectacle lié à la rubrique
        SELECT h_debut, dureeS INTO v_spectacle_start, v_spectacle_duration
        FROM Spectacle
        WHERE idSpec = v_idSpec;

        -- Calculer l'heure de fin du spectacle
        v_spectacle_end := v_spectacle_start + v_spectacle_duration;

        -- Vérifier les contraintes temporelles si h_debutR ou dureeRub sont modifiés
        IF p_h_debutR IS NOT NULL THEN
            v_updated_h_debutR := p_h_debutR; -- Use provided value
        ELSE
            v_updated_h_debutR := v_current_h_debutR; -- Use current value
        END IF;

        IF p_dureeRub IS NOT NULL THEN
            v_updated_dureeRub := p_dureeRub; -- Use provided value
        ELSE
            v_updated_dureeRub := v_current_dureeRub; -- Use current value
        END IF;

        -- Vérifier si le début est avant le début du spectacle
        IF v_updated_h_debutR < v_spectacle_start THEN
            RAISE_APPLICATION_ERROR(-20002, 'La rubrique ne peut pas commencer avant le début du spectacle.');
        END IF;

        -- Vérifier si la rubrique dépasse la durée du spectacle
        IF (v_updated_h_debutR + v_updated_dureeRub) > v_spectacle_end THEN
            RAISE_APPLICATION_ERROR(-20003, 'La rubrique dépasse la durée du spectacle.');
        END IF;

        -- Vérifier les conflits d'horaires avec d'autres rubriques pour l'artiste
        IF p_idArt IS NOT NULL OR p_h_debutR IS NOT NULL OR p_dureeRub IS NOT NULL THEN
            SELECT COUNT(*) INTO v_artist_conflict_count
            FROM Rubrique
            WHERE idArt = NVL(p_idArt, (SELECT idArt FROM Rubrique WHERE idRub = p_idRub))
              AND idSpec = v_idSpec
              AND idRub != p_idRub
              AND (v_updated_h_debutR BETWEEN h_debutR AND (h_debutR + dureeRub)
                   OR (v_updated_h_debutR + v_updated_dureeRub) BETWEEN h_debutR AND (h_debutR + dureeRub));

            IF v_artist_conflict_count > 0 THEN
                RAISE_APPLICATION_ERROR(-20004, 'L artiste est déjà pris à cette heure.');
            END IF;
        END IF;

        -- Modifier la rubrique
        UPDATE Rubrique
        SET idArt = NVL(p_idArt, idArt),
            h_debutR = v_updated_h_debutR,
            dureeRub = v_updated_dureeRub,
            type = NVL(p_type, type)
        WHERE idRub = p_idRub;

        DBMS_OUTPUT.PUT_LINE('Rubrique mise à jour avec succès.');
    END update_rubrique;

    -- Procédure pour supprimer une rubrique
    PROCEDURE delete_rubrique (
        p_idRub IN NUMBER
    ) IS
    BEGIN
        DELETE FROM Rubrique
        WHERE idRub = p_idRub;

        DBMS_OUTPUT.PUT_LINE('Rubrique supprimée avec succès.');
    END delete_rubrique;

    -- Fonction pour chercher une rubrique
    FUNCTION search_rubrique (
        p_idSpec IN NUMBER DEFAULT NULL,
        p_nomArt IN VARCHAR2 DEFAULT NULL
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
        SELECT r.idRub, r.idSpec, r.idArt, r.h_debutR, r.dureeRub, r.type
        FROM Rubrique r
        JOIN Artiste a ON r.idArt = a.idArt
        WHERE (p_idSpec IS NULL OR r.idSpec = p_idSpec)
          AND (p_nomArt IS NULL OR LOWER(a.NomArt) LIKE '%' || LOWER(p_nomArt) || '%');
        RETURN v_cursor;
    END search_rubrique;

END pkg_rubrique;
/
