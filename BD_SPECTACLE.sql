BEGIN
    pkg_spectacle.update_spectacle(
        p_idSpec => 1,
        p_dateS => TO_DATE('2024-12-26', 'YYYY-MM-DD'),
        p_h_debut => 21.00,
        p_idLieu => 2
    );
END;
/

SELECT * FROM Spectacle;