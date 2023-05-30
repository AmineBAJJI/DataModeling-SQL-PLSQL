CREATE TABLE Homme (
  IdHomme INT PRIMARY KEY,
  Nom VARCHAR(50),
  Prenom VARCHAR(50),
  DateNaissance DATE
);

CREATE TABLE Femme (
  IdFemme INT PRIMARY KEY,
  Nom VARCHAR(50),
  Prenom VARCHAR(50),
  DateNaissance DATE
);

CREATE TABLE DateMariage (
  IdDateMariage INT PRIMARY KEY,
  DateMariage DATE
);

CREATE TABLE Mariage (
  IdHomme INT,
  IdFemme INT,
  IdDateMariage INT,
  PRIMARY KEY (IdHomme, IdFemme, IdDateMariage),
  FOREIGN KEY (IdHomme) REFERENCES Homme(IdHomme),
  FOREIGN KEY (IdFemme) REFERENCES Femme(IdFemme),
  FOREIGN KEY (IdDateMariage) REFERENCES DateMariage(IdDateMariage)
);

CREATE TABLE DateDivorce (
  IdDateDivorce INT PRIMARY KEY,
  DateDivorce DATE
);

CREATE TABLE Divorce (
  IdHomme INT,
  IdFemme INT,
  IdDateDivorce INT,
  PRIMARY KEY (IdHomme, IdFemme, IdDateDivorce),
  FOREIGN KEY (IdHomme) REFERENCES Homme(IdHomme),
  FOREIGN KEY (IdFemme) REFERENCES Femme(IdFemme),
  FOREIGN KEY (IdDateDivorce) REFERENCES DateDivorce(IdDateDivorce)
);


INSERT INTO Homme (IdHomme, Nom, Prenom, DateNaissance)
VALUES (1, 'Ben Ahmed', 'Mohammed', TO_DATE('1990-02-12', 'YYYY-MM-DD'));

INSERT INTO Homme (IdHomme, Nom, Prenom, DateNaissance)
VALUES (2, 'El Kadi', 'Hassan', TO_DATE('1985-07-30', 'YYYY-MM-DD'));

INSERT INTO Homme (IdHomme, Nom, Prenom, DateNaissance)
VALUES (3, 'Rahal', 'Karim', TO_DATE('1995-10-18', 'YYYY-MM-DD'));

INSERT INTO Homme (IdHomme, Nom, Prenom, DateNaissance)
VALUES (4, 'Tazi', 'Said', TO_DATE('1978-03-05', 'YYYY-MM-DD'));

INSERT INTO Femme (IdFemme, Nom, Prenom, DateNaissance)
VALUES (1, 'Zahraoui', 'Fatima', TO_DATE('1992-11-03', 'YYYY-MM-DD'));

INSERT INTO Femme (IdFemme, Nom, Prenom, DateNaissance)
VALUES (2, 'El Bakkali', 'Amina', TO_DATE('1988-05-25', 'YYYY-MM-DD'));

INSERT INTO Femme (IdFemme, Nom, Prenom, DateNaissance)
VALUES (3, 'Lamrini', 'Sara', TO_DATE('1997-09-02', 'YYYY-MM-DD'));

INSERT INTO Femme (IdFemme, Nom, Prenom, DateNaissance)
VALUES (4, 'Zouhair', 'Naima', TO_DATE('1982-12-15', 'YYYY-MM-DD'));

INSERT INTO DateMariage (IdDateMariage, DateMariage)
VALUES (1, TO_DATE('2020-06-20', 'YYYY-MM-DD'));

INSERT INTO DateMariage (IdDateMariage, DateMariage)
VALUES (2, TO_DATE('2015-09-12', 'YYYY-MM-DD'));

INSERT INTO Mariage (IdHomme, IdFemme, IdDateMariage)
VALUES (1, 1, 1);

INSERT INTO Mariage (IdHomme, IdFemme, IdDateMariage)
VALUES (2, 3, 2);

INSERT INTO DateDivorce (IdDateDivorce, DateDivorce)
VALUES (1, TO_DATE('2022-03-12', 'YYYY-MM-DD'));

INSERT INTO Divorce (IdHomme, IdFemme, IdDateDivorce)
VALUES (1, 1, 1);

INSERT INTO Divorce (IdHomme, IdFemme, IdDateDivorce)
VALUES (2, 3, 1);

INSERT INTO Homme (IdHomme, Nom, Prenom, DateNaissance)
VALUES (5, 'Ali', 'Ahmed', TO_DATE('1987-04-22', 'YYYY-MM-DD'));

INSERT INTO Homme (IdHomme, Nom, Prenom, DateNaissance)
VALUES (6, 'Azzouzi', 'Khalid', TO_DATE('1992-11-25', 'YYYY-MM-DD'));

INSERT INTO Homme (IdHomme, Nom, Prenom, DateNaissance)
VALUES (7, 'Berrada', 'Youssef', TO_DATE('1980-06-10', 'YYYY-MM-DD'));

INSERT INTO Femme (IdFemme, Nom, Prenom, DateNaissance)
VALUES (5, 'Lahmadi', 'Khadija', TO_DATE('1990-08-16', 'YYYY-MM-DD'));

INSERT INTO Femme (IdFemme, Nom, Prenom, DateNaissance)
VALUES (6, 'Ouahbi', 'Nadia', TO_DATE('1985-12-29', 'YYYY-MM-DD'));

INSERT INTO Femme (IdFemme, Nom, Prenom, DateNaissance)
VALUES (7, 'Sekkat', 'Loubna', TO_DATE('1993-03-05', 'YYYY-MM-DD'));

INSERT INTO DateMariage (IdDateMariage, DateMariage)
VALUES (3, TO_DATE('2017-12-01', 'YYYY-MM-DD'));

INSERT INTO DateMariage (IdDateMariage, DateMariage)
VALUES (4, TO_DATE('2010-04-20', 'YYYY-MM-DD'));

INSERT INTO Mariage (IdHomme, IdFemme, IdDateMariage)
VALUES (3, 5, 3);

INSERT INTO Mariage (IdHomme, IdFemme, IdDateMariage)
VALUES (4, 6, 4);

INSERT INTO Divorce (IdHomme, IdFemme, IdDateDivorce)
VALUES (3, 5, 1);

INSERT INTO Divorce (IdHomme, IdFemme, IdDateDivorce)
VALUES (4, 6, 1);


CREATE TRIGGER Assurer_Nbre_Marriages_Homme
BEFORE INSERT ON Mariage
FOR EACH ROW
BEGIN
    DECLARE Nbre_Marriages INT;
    SELECT COUNT(*) INTO Nbre_Marriages FROM Mariage WHERE IdHomme = NEW.IdHomme;
    IF Nbre_Marriages > 4 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Un homme ne peut pas se marier plus de 4 fois!!!';
    END IF;
END;

il faut obligatoirement les faire s
DELETE FROM MARIAGE;
DELETE FROM DIVORCE;
DELETE FROM HOMME;
DELETE FROM FEMME;
DELETE FROM DateDivorce;
DELETE FROM DateMariage;

ALTER TABLE Mariage
ADD CONSTRAINT unique_femme
UNIQUE (IdFemme);


CREATE OR REPLACE TRIGGER SUPPRIMER_MARIAGE
AFTER INSERT ON Divorce
FOR EACH ROW
BEGIN
    DELETE FROM Mariage WHERE IdHomme = :new.IdHomme AND IdFemme = :new.IdFemme;
END;

CREATE OR REPLACE TRIGGER VERIFIER_FEMME_MARIEE
BEFORE INSERT ON Mariage
FOR EACH ROW
DECLARE
    nbre_mariages INTEGER;
BEGIN
    SELECT COUNT(*) INTO nbre_mariages FROM Mariage WHERE IdFemme = :new.IdFemme;
    IF nbre_mariages > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'La femme est déjà mariée à un autre homme.');
    END IF;
END;