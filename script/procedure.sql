-- Procédure stockée pour l'insertion de notes par un enseignant
CREATE OR REPLACE FUNCTION note_enseignant(
    p_id_matiere VARCHAR,
    p_id_semestre VARCHAR,
    p_id_etudiant INTEGER,
    p_id_controle INTEGER,
    p_id_enseignant INTEGER,
    p_note NUMERIC
)
RETURNS VOID
AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Matiere
        WHERE id_matiere = p_id_matiere
            AND id_semestre = p_id_semestre
            AND id_enseignant = p_id_enseignant
    ) THEN
        INSERT INTO Notes (note, id_matiere, id_semestre, id_etudiant, id_controle, id_enseignant)
        VALUES (p_note, p_id_matiere, p_id_semestre, p_id_etudiant, p_id_controle, p_id_enseignant);
    END IF;
END;
$$ LANGUAGE plpgsql;