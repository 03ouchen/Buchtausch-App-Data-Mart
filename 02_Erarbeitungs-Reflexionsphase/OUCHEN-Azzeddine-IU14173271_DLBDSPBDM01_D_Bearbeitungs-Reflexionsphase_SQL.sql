-- =========================================
-- Phase 2: Buchtausch-App
-- PostgreSQL
-- =========================================

-- 1. Benutzer
CREATE TABLE Benutzer (
    BenutzerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Adresse VARCHAR(255),
    "E-Mail" VARCHAR(255) NOT NULL UNIQUE,
    Telefon VARCHAR(30)
);

-- 2. Verlag
CREATE TABLE Verlag (
    VerlagID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

-- 3. Genre
CREATE TABLE Genre (
    GenreID INT PRIMARY KEY,
    Bezeichnung VARCHAR(100) NOT NULL UNIQUE
);

-- 4. Sprache
CREATE TABLE Sprache (
    SpracheID INT PRIMARY KEY,
    Bezeichnung VARCHAR(100) NOT NULL UNIQUE
);

-- 5. Zustand
CREATE TABLE Zustand (
    ZustandID INT PRIMARY KEY,
    Bezeichnung VARCHAR(100) NOT NULL UNIQUE
);

-- 6. Autor
CREATE TABLE Autor (
    AutorID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL
);

-- 7. Abholort
CREATE TABLE Abholort (
    AbholortID INT PRIMARY KEY,
    Adresse VARCHAR(255) NOT NULL,
    PLZ VARCHAR(10) NOT NULL,
    Ort VARCHAR(100) NOT NULL,
    Breitengrad DECIMAL(9,6),
    Längengrad DECIMAL(9,6)
);

-- 8. Zeitslot
CREATE TABLE Zeitslot (
    ZeitslotID INT PRIMARY KEY,
    Wochentag VARCHAR(20) NOT NULL,
    Beginn TIME NOT NULL,
    Ende TIME NOT NULL,
    CHECK (Beginn < Ende)
);

-- 9. Versandoption
CREATE TABLE Versandoption (
    VersandoptionID INT PRIMARY KEY,
    Bezeichnung VARCHAR(100) NOT NULL UNIQUE
);

-- 10. Buch
CREATE TABLE Buch (
    BuchID INT PRIMARY KEY,
    Titel VARCHAR(255) NOT NULL,
    Veröffentlichungsjahr INT,
    BenutzerID INT NOT NULL,
    VerlagID INT NOT NULL,
    GenreID INT NOT NULL,
    SpracheID INT NOT NULL,
    ZustandID INT NOT NULL,

    FOREIGN KEY (BenutzerID) REFERENCES Benutzer(BenutzerID),
    FOREIGN KEY (VerlagID) REFERENCES Verlag(VerlagID),
    FOREIGN KEY (GenreID) REFERENCES Genre(GenreID),
    FOREIGN KEY (SpracheID) REFERENCES Sprache(SpracheID),
    FOREIGN KEY (ZustandID) REFERENCES Zustand(ZustandID),

    CHECK (Veröffentlichungsjahr IS NULL OR Veröffentlichungsjahr > 0)
);

-- 11. Bewertung
CREATE TABLE Bewertung (
    BewertungID INT PRIMARY KEY,
    Sterne INT NOT NULL,
    Kommentar TEXT,
    Bewertungsdatum DATE NOT NULL,
    BenutzerID INT NOT NULL,
    BuchID INT NOT NULL,

    FOREIGN KEY (BenutzerID) REFERENCES Benutzer(BenutzerID),
    FOREIGN KEY (BuchID) REFERENCES Buch(BuchID),

    CHECK (Sterne BETWEEN 1 AND 5),
    UNIQUE (BenutzerID, BuchID)
);

-- =========================================
-- Beziehungen
-- =========================================

-- geschrieben von: Buch <-> Autor (M:N)
CREATE TABLE Buch_Autor (
    BuchID INT NOT NULL,
    AutorID INT NOT NULL,

    PRIMARY KEY (BuchID, AutorID),

    FOREIGN KEY (BuchID) REFERENCES Buch(BuchID),
    FOREIGN KEY (AutorID) REFERENCES Autor(AutorID)
);

-- Angebot: Benutzer + Buch + Abholort
CREATE TABLE Angebot (
    BenutzerID INT NOT NULL,
    BuchID INT NOT NULL,
    AbholortID INT NOT NULL,

    PRIMARY KEY (BenutzerID, BuchID, AbholortID),

    FOREIGN KEY (BenutzerID) REFERENCES Benutzer(BenutzerID),
    FOREIGN KEY (BuchID) REFERENCES Buch(BuchID),
    FOREIGN KEY (AbholortID) REFERENCES Abholort(AbholortID)
);

-- Ausleihe: eigenständige relationale Struktur
CREATE TABLE Ausleihe (
    BenutzerID INT NOT NULL,
    BuchID INT NOT NULL,
    ZeitslotID INT NOT NULL,
    Ausleihdatum DATE NOT NULL,
    Rueckgabedatum DATE,

    PRIMARY KEY (BenutzerID, BuchID, Ausleihdatum),

    FOREIGN KEY (BenutzerID) REFERENCES Benutzer(BenutzerID),
    FOREIGN KEY (BuchID) REFERENCES Buch(BuchID),
    FOREIGN KEY (ZeitslotID) REFERENCES Zeitslot(ZeitslotID),

    CHECK (
        Rueckgabedatum IS NULL
        OR Rueckgabedatum >= Ausleihdatum
    )
);

-- Versand: Benutzer + Buch + Versandoption + Abholort
CREATE TABLE Versand (
    BenutzerID INT NOT NULL,
    BuchID INT NOT NULL,
    VersandoptionID INT NOT NULL,
    AbholortID INT NOT NULL,

    PRIMARY KEY (
        BenutzerID,
        BuchID,
        VersandoptionID,
        AbholortID
    ),

    FOREIGN KEY (BenutzerID) REFERENCES Benutzer(BenutzerID),
    FOREIGN KEY (BuchID) REFERENCES Buch(BuchID),
    FOREIGN KEY (VersandoptionID)
        REFERENCES Versandoption(VersandoptionID),
    FOREIGN KEY (AbholortID)
        REFERENCES Abholort(AbholortID)
);
-- =========================================
-- TESTDATEN
-- =========================================

INSERT INTO Benutzer
(BenutzerID, Name, Adresse, "E-Mail", Telefon)
VALUES
(1, 'Max Mustermann', 'Hauptstraße 10', 'max@example.de', '01511111111'),
(2, 'Anna Schmidt', 'Bahnhofstraße 20', 'anna@example.de', '01522222222'),
(3, 'Peter Müller', 'Gartenstraße 5', 'peter@example.de', '01533333333');

INSERT INTO Verlag
(VerlagID, Name)
VALUES
(1, 'Ravensburger'),
(2, 'Carlsen');

INSERT INTO Genre
(GenreID, Bezeichnung)
VALUES
(1, 'Roman'),
(2, 'Fantasy'),
(3, 'Krimi');

INSERT INTO Sprache
(SpracheID, Bezeichnung)
VALUES
(1, 'Deutsch'),
(2, 'Englisch');

INSERT INTO Zustand
(ZustandID, Bezeichnung)
VALUES
(1, 'Sehr gut'),
(2, 'Gut'),
(3, 'Akzeptabel');

INSERT INTO Autor
(AutorID, Name)
VALUES
(1, 'J. K. Rowling'),
(2, 'George Orwell'),
(3, 'Cornelia Funke');

INSERT INTO Abholort
(AbholortID, Adresse, PLZ, Ort, Breitengrad, Längengrad)
VALUES
(1, 'Hauptstraße 10', '44135', 'Dortmund', 51.5136, 7.4653),
(2, 'Bahnhofstraße 20', '44137', 'Dortmund', 51.5030, 7.4570);

INSERT INTO Zeitslot
(ZeitslotID, Wochentag, Beginn, Ende)
VALUES
(1, 'Montag', '10:00', '12:00'),
(2, 'Mittwoch', '14:00', '16:00'),
(3, 'Freitag', '17:00', '19:00');

INSERT INTO Versandoption
(VersandoptionID, Bezeichnung)
VALUES
(1, 'Abholung'),
(2, 'Postversand');

INSERT INTO Buch
(BuchID, Titel, Veröffentlichungsjahr, BenutzerID, VerlagID, GenreID, SpracheID, ZustandID)
VALUES
(1, 'Harry Potter und der Stein der Weisen', 1997, 1, 1, 2, 1, 1),
(2, '1984', 1949, 2, 2, 1, 1, 2),
(3, 'Tintenherz', 2003, 3, 1, 2, 1, 1);

INSERT INTO Bewertung
(BewertungID, Sterne, Kommentar, Bewertungsdatum, BenutzerID, BuchID)
VALUES
(1, 5, 'Sehr gutes Buch.', '2026-09-10', 2, 1),
(2, 4, 'Interessante Geschichte.', '2026-09-11', 3, 2);

INSERT INTO Buch_Autor
(BuchID, AutorID)
VALUES
(1, 1),
(2, 2),
(3, 3);

INSERT INTO Angebot
(BenutzerID, BuchID, AbholortID)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 1);

INSERT INTO Ausleihe
(BenutzerID, BuchID, ZeitslotID, Ausleihdatum, Rueckgabedatum)
VALUES
(2, 1, 1, '2026-09-12', '2026-09-15'),
(3, 2, 2, '2026-09-13', NULL);

INSERT INTO Versand
(BenutzerID, BuchID, VersandoptionID, AbholortID)
VALUES
(2, 1, 2, 1),
(3, 2, 1, 2);

SELECT * FROM Benutzer;


SELECT * FROM Ausleihe
ORDER BY Ausleihdatum;


