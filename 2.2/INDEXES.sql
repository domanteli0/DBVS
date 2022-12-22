DROP INDEX IF EXISTS Isvikimo_data_laikas;
DROP INDEX IF EXISTS Paketo_svoris;

CREATE UNIQUE INDEX Isvikimo_data_laikas
ON Vaziavimas(Pradzia, Pabaiga, Transporto_priemone);

CREATE INDEX Paketo_svoris
ON Paketas(Svoris);