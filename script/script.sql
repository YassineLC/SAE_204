DROP TABLE IF EXISTS Notes CASCADE;
DROP TABLE IF EXISTS Controle CASCADE;
DROP TABLE IF EXISTS Etudiant CASCADE;
DROP TABLE IF EXISTS Coefficient CASCADE;
DROP TABLE IF EXISTS Matiere CASCADE;
DROP TABLE IF EXISTS Enseignant CASCADE;
DROP TABLE IF EXISTS Semestre CASCADE;
DROP TABLE IF EXISTS SAE CASCADE;
DROP TABLE IF EXISTS Ressource CASCADE;
DROP TABLE IF EXISTS Portfolio CASCADE;
DROP TABLE IF EXISTS Competences CASCADE;

CREATE TABLE Portfolio (
    id_portfolio VARCHAR NOT NULL,
    CONSTRAINT portfolio_pk PRIMARY KEY (id_portfolio)
);

CREATE TABLE Ressource (
    id_ressource VARCHAR NOT NULL,
    CONSTRAINT ressource_pk PRIMARY KEY (id_ressource)
);

CREATE TABLE SAE (
    id_sae VARCHAR NOT NULL,
    CONSTRAINT sae_pk PRIMARY KEY (id_sae)
);

CREATE TABLE Semestre (
    id_semestre VARCHAR NOT NULL,
    CONSTRAINT semestre_pk PRIMARY KEY (id_semestre)
);

CREATE TABLE Enseignant (
    id_enseignant INTEGER NOT NULL,
    nom VARCHAR NOT NULL,
    prenom VARCHAR NOT NULL,
    CONSTRAINT enseignant_pk PRIMARY KEY (id_enseignant)
);

CREATE TABLE Matiere (
    id_matiere VARCHAR NOT NULL,
    id_semestre VARCHAR NOT NULL,
    id_enseignant INTEGER NOT NULL,
    nom VARCHAR NOT NULL,
    id_ressource VARCHAR,
    id_sae VARCHAR,
    id_portfolio VARCHAR,
    CONSTRAINT matiere_pk PRIMARY KEY (id_matiere, id_semestre),
    CONSTRAINT semestre_matiere_fk FOREIGN KEY (id_semestre) REFERENCES Semestre (id_semestre),
    CONSTRAINT enseignant_matiere_fk FOREIGN KEY (id_enseignant) REFERENCES Enseignant (id_enseignant)
);


CREATE TABLE Controle (
    id_controle INTEGER NOT NULL,
    id_semestre VARCHAR NOT NULL,
    id_matiere VARCHAR NOT NULL,
    id_enseignant INTEGER NOT NULL,
    nom VARCHAR NOT NULL,
    coefficient NUMERIC NOT NULL,
    CONSTRAINT controle_pk PRIMARY KEY (id_controle, id_semestre, id_matiere, id_enseignant),
    CONSTRAINT enseignant_controle_fk FOREIGN KEY (id_enseignant) REFERENCES Enseignant (id_enseignant),
    CONSTRAINT matiere_controle_fk FOREIGN KEY (id_matiere, id_semestre) REFERENCES Matiere (id_matiere, id_semestre)
);

CREATE TABLE Competences (
    id_competence INTEGER NOT NULL,
    competences_nom VARCHAR NOT NULL,
    CONSTRAINT competences_pk PRIMARY KEY (id_competence)
);

CREATE TABLE Coefficient (
    id_matiere VARCHAR NOT NULL,
    id_controle INTEGER NOT NULL,
    id_semestre VARCHAR NOT NULL,
    id_enseignant INTEGER NOT NULL,
    coefficient NUMERIC NOT NULL,
    id_competence INTEGER NOT NULL,
    id_coefficient INTEGER NOT NULL,
    CONSTRAINT coefficient_pk PRIMARY KEY (id_matiere, id_controle, id_semestre, id_enseignant, id_coefficient),
    CONSTRAINT competences_coefficient_fk FOREIGN KEY (id_competence) REFERENCES Competences (id_competence),
    CONSTRAINT controle_coefficient_fk FOREIGN KEY (id_controle, id_semestre, id_matiere, id_enseignant) REFERENCES Controle (id_controle, id_semestre, id_matiere, id_enseignant)
);

CREATE TABLE Etudiant (
    id_etudiant INTEGER NOT NULL,
    groupe VARCHAR NOT NULL,
    nom VARCHAR NOT NULL,
    prenom VARCHAR NOT NULL,
    CONSTRAINT etudiant_pk PRIMARY KEY (id_etudiant)
);

CREATE TABLE Notes (
    id_note NUMERIC NOT NULL,
    note NUMERIC NOT NULL,
    id_matiere VARCHAR NOT NULL,
    id_semestre VARCHAR NOT NULL,
    id_etudiant INTEGER NOT NULL,
    id_controle INTEGER NOT NULL,
    id_enseignant INTEGER NOT NULL,
    CONSTRAINT notes_pk PRIMARY KEY (id_note),
    CONSTRAINT etudiant_notes_fk FOREIGN KEY (id_etudiant) REFERENCES Etudiant (id_etudiant),
    CONSTRAINT matiere_notes_fk FOREIGN KEY (id_matiere, id_semestre) REFERENCES Matiere (id_matiere, id_semestre),
    CONSTRAINT controle_notes_fk FOREIGN KEY (id_controle, id_semestre, id_matiere, id_enseignant) REFERENCES Controle (id_controle, id_semestre, id_matiere, id_enseignant)
);


\copy Semestre FROM ./tables/semestre.txt;
\copy SAE FROM ./tables/sae.txt;
\copy Ressource FROM ./tables/ressource.txt;
\copy Portfolio FROM ./tables/portfolio.txt;
\copy Etudiant FROM ./tables/etudiant.txt;
\copy Enseignant FROM ./tables/enseignant.txt;
\copy Competences FROM ./tables/competences.txt;
\copy Matiere FROM ./tables/matiere.txt;
\copy Controle FROM ./tables/controle.txt;
\copy Notes FROM ./tables/notes.txt;
\copy Coefficient FROM ./tables/coefficient.txt;
