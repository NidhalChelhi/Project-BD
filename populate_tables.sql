-- =========================================================================================
-- Fichier : populate_tables.sql
-- Description : Ce script insère des données dans les tables de la base de données.
--               Les données sont basées sur le fichier Excel pour la table Lieu.
-- Auteur : [Votre Nom]
-- Date : [Date du projet]
-- =========================================================================================


-- Insertion des données dans la table Lieu
INSERT INTO Lieu (NomLieu, Adresse, capacite, status)
VALUES ('CABARET RESTAURANT SHEHERAZADE', 'Médina Mediterranea - Yasmine-Hammamet - Tunisie', 100, 'ACTIVE');

INSERT INTO Lieu (NomLieu, Adresse, capacite, status)
VALUES ('THÉÂTRE EL HAMRA', '28, rue El Jazira - Tunis - Tunisie', 550, 'ACTIVE');

INSERT INTO Lieu (NomLieu, Adresse, capacite, status)
VALUES ('Théâtre Municipal de Tunis', 'Avenue Bourguiba - Tunis - Tunisie', 1099, 'ACTIVE');

INSERT INTO Lieu (NomLieu, Adresse, capacite, status)
VALUES ('CINÉMA TUNISIA ODYSSÉE', 'Medina Mediterranea - Yasmine-Hammamet - Tunisie', 435, 'ACTIVE');

INSERT INTO Lieu (NomLieu, Adresse, capacite, status)
VALUES ('L ÉTOILE DU NORD', '41, avenue Farhat-Hached - Tunis - Tunisie', 1067, 'ACTIVE');

INSERT INTO Lieu (NomLieu, Adresse, capacite, status)
VALUES ('Pathé Tunis City', 'Cebalet ben ammar, route de Bizerte km 17 Ariana, Tunis 2032, Tunisie', 425, 'ACTIVE');

INSERT INTO Lieu (NomLieu, Adresse, capacite, status)
VALUES ('CENTRE DOUAR EL HASFI', 'Route du Zoo-Paradis - 2200 - Tozeur - Tunisie', 648, 'ACTIVE');

INSERT INTO Lieu (NomLieu, Adresse, capacite, status)
VALUES ('EL MAWEL', '5, rue Amine-Abbassi - Tunis - Tunisie', 354, 'ACTIVE');

INSERT INTO Lieu (NomLieu, Adresse, capacite, status)
VALUES ('EL TEATRO', 'Avenue Ouled Haffouz - Tunis - Tunisie', 1619, 'ACTIVE');

INSERT INTO Lieu (NomLieu, Adresse, capacite, status)
VALUES ('ZINBLEDI', 'Route de Tunis km12 - 4000 - Sousse - Tunisie', 1772, 'ACTIVE');

INSERT INTO Lieu (NomLieu, Adresse, capacite, status)
VALUES ('Le Colisée', 'Avenue Habib Bourguiba, Tunis, Tunisie', 1490, 'ACTIVE');

INSERT INTO Lieu (NomLieu, Adresse, capacite, status)
VALUES ('Cine Jamil', 'Rue du docteur Mohamed Ben Salah, Ariana, Tunisie', 897, 'ACTIVE');

INSERT INTO Lieu (NomLieu, Adresse, capacite, status)
VALUES ('L agora', 'Rue 1 La Marsa', 603, 'ACTIVE');

INSERT INTO Lieu (NomLieu, Adresse, capacite, status)
VALUES ('Alhambra “zéphyr”', 'Centre Commercial Zéphyr La Marsa', 958, 'ACTIVE');

INSERT INTO Lieu (NomLieu, Adresse, capacite, status)
VALUES ('CinéMadart', 'Rue Hbib Bourguiba - Monoprix Dermech, Tunisie', 866, 'ACTIVE');

INSERT INTO Lieu (NomLieu, Adresse, capacite, status)
VALUES ('theatre opera', 'CITE DE LA CULTURE A TUNIS', 1800, 'ACTIVE');



-- Insertion des données dans la table Artiste
INSERT INTO Artiste (NomArt, PrenomArt, specialite)
VALUES ('Ben Youssef', 'Ali', 'musique');

INSERT INTO Artiste (NomArt, PrenomArt, specialite)
VALUES ('Trabelsi', 'Sami', 'comedie');

INSERT INTO Artiste (NomArt, PrenomArt, specialite)
VALUES ('Aouicha', 'Hedi', 'dance');

INSERT INTO Artiste (NomArt, PrenomArt, specialite)
VALUES ('Kacem', 'Salem', 'chant');

INSERT INTO Artiste (NomArt, PrenomArt, specialite)
VALUES ('Bouhlel', 'Fatma', 'theatre');

INSERT INTO Artiste (NomArt, PrenomArt, specialite)
VALUES ('Mansouri', 'Noura', 'magie');


-- Insertion des données dans la table Spectacle
INSERT INTO Spectacle (Titre, dateS, h_debut, dureeS, nbrSpectateur, idLieu)
VALUES ('Symphonie Magique', TO_DATE('2024-12-20', 'YYYY-MM-DD'), 19.00, 3.5, 700, 1);

INSERT INTO Spectacle (Titre, dateS, h_debut, dureeS, nbrSpectateur, idLieu)
VALUES ('Comédie Tunisienne', TO_DATE('2024-12-25', 'YYYY-MM-DD'), 20.00, 2.0, 500, 2);

INSERT INTO Spectacle (Titre, dateS, h_debut, dureeS, nbrSpectateur, idLieu)
VALUES ('Chorale Internationale', TO_DATE('2025-01-10', 'YYYY-MM-DD'), 18.30, 4.0, 1099, 3);

INSERT INTO Spectacle (Titre, dateS, h_debut, dureeS, nbrSpectateur, idLieu)
VALUES ('Danse Moderne', TO_DATE('2025-01-15', 'YYYY-MM-DD'), 21.00, 2.5, 1200, 4);



-- Insertion des données dans la table Rubrique
INSERT INTO Rubrique (idSpec, idArt, h_debutR, dureeRub, type)
VALUES (1, 1, 19.00, 1.5, 'musique');

INSERT INTO Rubrique (idSpec, idArt, h_debutR, dureeRub, type)
VALUES (2, 2, 20.00, 2.0, 'comedie');

INSERT INTO Rubrique (idSpec, idArt, h_debutR, dureeRub, type)
VALUES (3, 3, 18.30, 2.5, 'chant');

INSERT INTO Rubrique (idSpec, idArt, h_debutR, dureeRub, type)
VALUES (4, 4, 21.00, 1.0, 'danse');


-- Insertion des données dans la table Billet
INSERT INTO Billet (categorie, prix, idSpec, vendu)
VALUES ('Gold', 300, 1, 'Oui');

INSERT INTO Billet (categorie, prix, idSpec, vendu)
VALUES ('Silver', 200, 2, 'Non');

INSERT INTO Billet (categorie, prix, idSpec, vendu)
VALUES ('Normale', 100, 3, 'Oui');

INSERT INTO Billet (categorie, prix, idSpec, vendu)
VALUES ('Gold', 300, 4, 'Non');

-- Fin du fichier

