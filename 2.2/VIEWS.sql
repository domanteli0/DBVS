DROP VIEW IF EXISTS Vairuotojai_teises;
CREATE VIEW Vairuotojai_teises
    AS SELECT Teise, COUNT(Vairuotojo_ak) FROM Turi
    GROUP BY Teise;

DROP VIEW IF EXISTS Sunkus_paketai_si_men;
CREATE VIEW Sunkus_paketai_si_men
    AS SELECT Paketas.Id, Paketas FROM Paketas, Vezami 
    WHERE 
        Paketas.Id = Vezami.Paketo_ID AND
        EXTRACT(month FROM Vezami.Pradzia) = EXTRACT(month FROM CURRENT_TIMESTAMP) AND 
        Paketas.Svoris > 100;
