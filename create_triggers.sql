-- =========================================================================================
-- Fichier : create_triggers.sql
-- Description : Ce script crée les triggers pour automatiser la gestion des données.
-- Auteur : [Votre Nom]
-- Date : [Date du projet]
-- =========================================================================================

-- Trigger pour auto-générer l'idLieu
CREATE OR REPLACE TRIGGER trg_lieu_id
BEFORE INSERT ON Lieu
FOR EACH ROW
BEGIN
    :NEW.idLieu := seq_lieu_id.NEXTVAL;
END;
/

-- Trigger pour auto-générer l'idArt
CREATE OR REPLACE TRIGGER trg_artiste_id
BEFORE INSERT ON Artiste
FOR EACH ROW
BEGIN
    :NEW.idArt := seq_artiste_id.NEXTVAL;
END;
/

-- Trigger pour auto-générer l'idSpec
CREATE OR REPLACE TRIGGER trg_spectacle_id
BEFORE INSERT ON Spectacle
FOR EACH ROW
BEGIN
    :NEW.idSpec := seq_spectacle_id.NEXTVAL;
END;
/

-- Trigger pour auto-générer l'idRub
CREATE OR REPLACE TRIGGER trg_rubrique_id
BEFORE INSERT ON Rubrique
FOR EACH ROW
BEGIN
    :NEW.idRub := seq_rubrique_id.NEXTVAL;
END;
/

-- Trigger pour auto-générer l'idBillet
CREATE OR REPLACE TRIGGER trg_billet_id
BEFORE INSERT ON Billet
FOR EACH ROW
BEGIN
    :NEW.idBillet := seq_billet_id.NEXTVAL;
END;
/

-- Trigger pour valider le nombre de spectateurs dans un spectacle
CREATE OR REPLACE TRIGGER trg_check_spectacle_capacity
BEFORE INSERT OR UPDATE ON Spectacle
FOR EACH ROW
DECLARE
    venue_capacity NUMBER;
BEGIN
    SELECT capacite INTO venue_capacity
    FROM Lieu
    WHERE idLieu = :NEW.idLieu;

    IF :NEW.nbrSpectateur > venue_capacity THEN
        RAISE_APPLICATION_ERROR(-20001, 'Le nombre de spectateurs dépasse la capacité du lieu.');
    END IF;
END;
/

-- Trigger pour vérifier que la date du spectacle est dans le futur
CREATE OR REPLACE TRIGGER trg_check_spectacle_date
BEFORE INSERT OR UPDATE ON Spectacle
FOR EACH ROW
BEGIN
    IF :NEW.dateS < SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20002, 'La date du spectacle doit être dans le futur.');
    END IF;
END;
/

-- Trigger pour ajuster les horaires des rubriques lors de modifications
CREATE OR REPLACE TRIGGER trg_update_rubrique_timing
AFTER UPDATE ON Spectacle
FOR EACH ROW
BEGIN
    UPDATE Rubrique
    SET h_debutR = h_debutR + (:NEW.h_debut - :OLD.h_debut)
    WHERE idSpec = :NEW.idSpec;
END;
/

-- Fin du fichier
