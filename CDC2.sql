CREATE TABLE Ecole (
  IdEcole INT PRIMARY KEY,
  NomEcole VARCHAR(50) NOT NULL,
  AdresseEcole VARCHAR(255) NOT NULL
);

CREATE TABLE Etudiant (
  IdEtudiant INT PRIMARY KEY,
  NomEtudiant VARCHAR(50) NOT NULL,
  PrenomEtudiant VARCHAR(50) NOT NULL,
  IdEcole INT NOT NULL,
  FOREIGN KEY (IdEcole) REFERENCES Ecole(IdEcole)
);

CREATE TABLE Entreprise (
  IdEntreprise INT PRIMARY KEY,
  NomEntreprise VARCHAR(50) NOT NULL,
  AdresseEntreprise VARCHAR(255) NOT NULL,
  IdEnseignant INT,
  DateVisite DATE,
  FOREIGN KEY (IdEnseignant) REFERENCES Enseignant(IdEnseignant)
);

CREATE TABLE Enseignant (
  IdEnseignant INT PRIMARY KEY,
  NomEnseignant VARCHAR(50) NOT NULL,
  PrenomEnseignant VARCHAR(50) NOT NULL
);

CREATE TABLE StagesPFE (
  IdStage INT PRIMARY KEY,
  Sujet VARCHAR(255) NOT NULL,
  Durée INT NOT NULL,
  Rémunération FLOAT NOT NULL,
  IdEntreprise INT NOT NULL,
  FOREIGN KEY (IdEntreprise) REFERENCES Entreprise(IdEntreprise)
);

CREATE TABLE Convention (
  IdConvention INT PRIMARY KEY,
  SujetDéfinitif VARCHAR(255) NOT NULL,
  Date_D DATE NOT NULL,
  RémunérationDéfi FLOAT NOT NULL,
  DateConvention DATE NOT NULL,
  IdEnseignant INT NOT NULL,
  FOREIGN KEY (IdEnseignant) REFERENCES Enseignant(IdEnseignant)
);

CREATE TABLE Signature (
  IdEtudiant INT NOT NULL,
  IdConvention INT NOT NULL,
  PRIMARY KEY (IdEtudiant, IdConvention),
  FOREIGN KEY (IdEtudiant) REFERENCES Etudiant(IdEtudiant),
  FOREIGN KEY (IdConvention) REFERENCES Convention(IdConvention)
);

CREATE TABLE Correspondance (
  IdStage INT NOT NULL,
  IdConvention INT NOT NULL,
  PRIMARY KEY (IdStage, IdConvention),
  FOREIGN KEY (IdStage) REFERENCES StagesPFE(IdStage),
  FOREIGN KEY (IdConvention) REFERENCES Convention(IdConvention)
);


INSERT INTO Ecole (IdEcole, NomEcole, AdresseEcole) VALUES (1, 'Université Hassan II', 'Avenue des FAR, Casablanca');
INSERT INTO Ecole (IdEcole, NomEcole, AdresseEcole) VALUES (2, 'Université Mohammed V', 'Avenue Ibn Battouta, Rabat');

INSERT INTO Etudiant (IdEtudiant, NomEtudiant, PrenomEtudiant, IdEcole) VALUES (1, 'Benmoussa', 'Amine', 1);
INSERT INTO Etudiant (IdEtudiant, NomEtudiant, PrenomEtudiant, IdEcole) VALUES (2, 'Chakir', 'Fatima', 2);

INSERT INTO Enseignant (IdEnseignant, NomEnseignant, PrenomEnseignant) VALUES (1, 'Berrada', 'Khalid');
INSERT INTO Enseignant (IdEnseignant, NomEnseignant, PrenomEnseignant) VALUES (2, 'El Amrani', 'Hicham');

INSERT INTO Entreprise (IdEntreprise, NomEntreprise, AdresseEntreprise, IdEnseignant, DateVisite) VALUES (1, 'IBM', 'Boulevard Al Qods, Casablanca', 1, TO_DATE('2023-05-01', 'YYYY-MM-DD'));
INSERT INTO Entreprise (IdEntreprise, NomEntreprise, AdresseEntreprise, IdEnseignant, DateVisite) VALUES (2, 'Microsoft', 'Boulevard Zerktouni, Rabat', NULL, NULL);

INSERT INTO StagesPFE (IdStage, Sujet, Durée, Rémunération, IdEntreprise) VALUES (1, 'Developpement d une application de gestion de stock', 6, 5000.0, 1);
INSERT INTO StagesPFE (IdStage, Sujet, Durée, Rémunération, IdEntreprise) VALUES (2, 'Conception dun système dinformation géographique', 4, 3500.0, 2);

INSERT INTO Convention(IdConvention, SujetDéfinitif, Date_D, RémunérationDéfi, DateConvention, IdEnseignant) VALUES (1, 'Application de gestion de stock', TO_DATE('2023-04-28', 'YYYY-MM-DD'), 3000.0, TO_DATE('2023-05-02', 'YYYY-MM-DD'), 1);
INSERT INTO Convention (IdConvention, SujetDéfinitif, Date_D, RémunérationDéfi, DateConvention, IdEnseignant) VALUES (2, 'Système dinformation géographique', TO_DATE('2023-04-30', 'YYYY-MM-DD'), 2500.0, TO_DATE('2023-05-05', 'YYYY-MM-DD'), 2);

INSERT INTO Signature (IdEtudiant, IdConvention) VALUES (1, 1);
INSERT INTO Signature (IdEtudiant, IdConvention) VALUES (2, 2);

INSERT INTO Correspondance (IdStage, IdConvention) VALUES (1, 1);
INSERT INTO Correspondance (IdStage, IdConvention) VALUES (2, 2);






--Sélectionner tous les étudiants :

SELECT * FROM Etudiant;

 --Sélectionner tous les enseignants :

 
SELECT * FROM Enseignant;

 --Sélectionner tous les stages de PFE :
 
 
SELECT * FROM StagesPFE;

 --Sélectionner toutes les conventions :
 
SELECT * FROM Convention;

--Sélectionner toutes les entreprises :
 
 
SELECT * FROM Entreprise;
 --Sélectionner tous les étudiants ayant signé une convention :
 
 
SELECT * FROM Etudiant WHERE IdEtudiant IN (SELECT IdEtudiant FROM Signature);
 --Sélectionner tous les étudiants ayant signé une convention dont la rémunération est supérieure à 2000 :
 
 
SELECT * FROM Etudiant WHERE IdEtudiant IN (SELECT IdEtudiant FROM Signature WHERE IdConvention IN (SELECT IdConvention FROM Convention WHERE RémunérationDéfi > 2000));
 --Sélectionner tous les stages de PFE dont la durée est supérieure à 5 mois :
 
 
SELECT * FROM StagesPFE WHERE Durée > 5;
-- Sélectionner toutes les conventions signées par un étudiant dont le nom est 'Chakir' :
 
 
SELECT * FROM Convention WHERE IdConvention IN (SELECT IdConvention FROM Signature WHERE IdEtudiant IN (SELECT IdEtudiant FROM Etudiant WHERE NomEtudiant = 'Chakir'));
--Sélectionner tous les stages de PFE proposés par IBM :
 
 
SELECT * FROM StagesPFE WHERE IdEntreprise IN (SELECT IdEntreprise FROM Entreprise WHERE NomEntreprise = 'IBM');