
DROP TRIGGER IF EXISTS LaikasNesikertaTrigger ON vaziavimas;
DROP FUNCTION IF EXISTS LaikasNesikerta;

DROP VIEW IF EXISTS Vairuotojai_teises;
DROP VIEW IF EXISTS Sunkus_paketai_si_men;

DROP INDEX IF EXISTS Isvikimo_data_laikas;
DROP INDEX IF EXISTS Paketo_svoris;

DROP TABLE IF EXISTS Transporto_priemone;
DROP TABLE IF EXISTS Vezami;
DROP TABLE IF EXISTS Dalyvauja;
DROP TABLE IF EXISTS Paketas;
DROP TABLE IF EXISTS Turi;
DROP TABLE IF EXISTS Teises;
DROP TABLE IF EXISTS Vaziavimas;
DROP TABLE IF EXISTS Vairuotojas;

