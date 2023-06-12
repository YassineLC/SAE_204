CREATE ROLE eleve;
CREATE ROLE enseignant;
CREATE ROLE admin SUPERUSER;

GRANT ALL PRIVILEGES ON postgres.* TO admin;
GRANT SELECT ON notes TO eleve;
GRANT INSERT, UPDATE ON notes TO enseignant;
GRANT UPDATE ON coefficient TO enseignant;


REVOKE INSERT, UPDATE ON TABLE  notes FROM eleve;
REVOKE UPDATE ON TABLE coefficient FROM eleve;
