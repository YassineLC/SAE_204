CREATE VIEW VueMoyenneMatiere AS
SELECT n.id_matiere, m.nom AS nom_matiere, AVG(n.note) AS moyenne_matiere
FROM Notes n
JOIN Matiere m ON n.id_matiere = m.id_matiere AND n.id_semestre = m.id_semestre
GROUP BY n.id_matiere, m.nom;

CREATE VIEW VueMoyenneGroupe AS
SELECT e.groupe, AVG(n.note) AS moyenne_groupe
FROM Notes n
JOIN Etudiant e ON n.id_etudiant = e.id_etudiant
GROUP BY e.groupe;

CREATE VIEW VueMoyenneEtudiant AS
SELECT e.id_etudiant, e.groupe, e.nom, e.prenom,
       AVG(n.note * c.coefficient) AS moyenne
FROM Etudiant e
JOIN Notes n ON e.id_etudiant = n.id_etudiant
JOIN Coefficient c ON n.id_matiere = c.id_matiere
                  AND n.id_controle = c.id_controle
                  AND n.id_semestre = c.id_semestre
                  AND n.id_enseignant = c.id_enseignant
GROUP BY e.id_etudiant, e.groupe, e.nom, e.prenom;
