# Buchtausch-App – Data-Mart-Erstellung in SQL

## Projektbeschreibung

Dieses Projekt wurde im Rahmen des IU-Projekts **„Data-Mart-Erstellung in SQL“** entwickelt.

Ziel ist die Konzeption und Implementierung einer relationalen PostgreSQL-Datenbank für eine Buchtausch-App. Die Datenbank unterstützt den lokalen Austausch von Büchern auf Basis von Ausleihvorgängen.

Benutzende können Bücher zur Ausleihe anbieten und Bücher anderer Benutzender ausleihen. Zusätzlich werden Informationen zu Autor:innen, Verlagen, Genres, Sprachen, Zuständen, Abholorten, Zeitslots, Versandoptionen und Bewertungen verwaltet.

## Technische Umsetzung

- Datenbanksystem: PostgreSQL
- Programmiersprache: SQL
- Datenmodellierung: Entity-Relationship-Modell
- Primär- und Fremdschlüssel zur Verknüpfung der Tabellen
- Integritätsbedingungen mit `NOT NULL`, `UNIQUE` und `CHECK`
- Komplexe SQL-JOIN-Abfragen
- Indizes zur Optimierung ausgewählter Abfragen
- PostgreSQL-Funktion und Trigger für eine Geschäftsregel

## Datenbankstruktur

Die Datenbank umfasst unter anderem folgende Tabellen:

- Benutzer
- Buch
- Autor
- Verlag
- Genre
- Sprache
- Zustand
- Abholort
- Zeitslot
- Versandoption
- Bewertung
- Buch_Autor
- Angebot
- Ausleihe
- Versand

## Funktionalitäten

Die implementierte Datenbank unterstützt unter anderem:

- Verwaltung von Benutzenden und Büchern
- Verwaltung von Autor:innen, Verlagen und Genres
- Verwaltung von Buchzuständen und Sprachen
- Verwaltung von Angeboten und Ausleihvorgängen
- Verwaltung von Abholorten und Zeitslots
- Bewertungen von Büchern
- Versandoptionen
- Komplexe JOIN-Abfragen
- Räumliche Suche anhand von Geokoordinaten
- Prüfung von Datenintegrität und Geschäftsregeln

## Tests und Validierung

Zur Überprüfung der Datenbank wurden positive und negative Testfälle durchgeführt.

Getestet wurden unter anderem:

- `NOT NULL`-Constraints
- `UNIQUE`-Constraints
- `CHECK`-Constraints
- Fremdschlüsselbedingungen
- Komplexe JOIN-Abfragen
- Indexierung
- Räumliche Suche
- Geschäftsregel für Ausleihvorgänge

Die detaillierten SQL-Anweisungen, Testergebnisse und Screenshots sind in der Dokumentation der Erarbeitungs-/Reflexionsphase enthalten.

## Projektstruktur


Buchtausch-App-Data-Mart/
│
├── 01_Konzeptionsphase/
│   └── README.md
│
├── 02_Erarbeitungs-Reflexionsphase/
│   └── README.md
│
├── 03_Finalisierungsphase/
│   └── README.md
│
└── README.md



-------------------------

## Installation und Ausführung

### Voraussetzungen

Für die Ausführung des Projekts werden folgende Komponenten benötigt:

- PostgreSQL
- pgAdmin 4
- SQL-Skript des Projekts

### Datenbank erstellen

1. PostgreSQL installieren und eine Verbindung zum PostgreSQL-Server herstellen.
2. In pgAdmin eine neue Datenbank für das Projekt erstellen.
3. Das bereitgestellte SQL-Skript in pgAdmin öffnen.
4. Das SQL-Skript vollständig ausführen.
5. Nach erfolgreicher Ausführung werden die Tabellen, Beziehungen, Constraints, Funktionen, Trigger und Indizes angelegt.
6. Anschließend können die eingefügten Dummy-Daten und die implementierten SQL-Abfragen überprüft werden.

### Überprüfung

Nach der Ausführung des SQL-Skripts kann in pgAdmin überprüft werden, ob die Tabellen und Daten erfolgreich erstellt wurden. Zusätzlich können die dokumentierten Testfälle und SQL-Abfragen ausgeführt werden, um die Funktionalität und Datenintegrität der Datenbank zu überprüfen.

Die detaillierte Dokumentation der SQL-Anweisungen, Testfälle und Ergebnisse befindet sich in den Dokumenten der jeweiligen Projektphasen.
