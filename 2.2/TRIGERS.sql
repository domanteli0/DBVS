
DROP TRIGGER IF EXISTS LaikasNesikertaTrigger ON vaziavimas;
DROP FUNCTION IF EXISTS LaikasNesikerta;

CREATE FUNCTION LaikasNesikerta() RETURNS TRIGGER AS
    'BEGIN
    IF (SELECT COUNT(*) FROM vaziavimas
        WHERE ( 
            vaziavimas.Transporto_priemone = NEW.Transporto_priemone AND
            (
                (NEW.pradzia BETWEEN vaziavimas.pradzia AND vaziavimas.pabaiga) OR
                (NEW.pabaiga BETWEEN vaziavimas.pradzia AND vaziavimas.pabaiga)
            )
        )) > 0
    THEN
        RAISE EXCEPTION ''Ši transporto priemonė jau užimta šiuo laiku'';
    END IF;
    RETURN NEW;
    END;'
LANGUAGE plpgsql;

CREATE TRIGGER LaikasNesikertaTrigger
BEFORE  INSERT OR
        UPDATE ON vaziavimas
FOR EACH ROW
EXECUTE PROCEDURE LaikasNesikerta();


DROP TRIGGER IF EXISTS TuriTinkamasTeisesTriger ON Dalyvauja;
DROP FUNCTION IF EXISTS TuriTinkamasTeises;

CREATE FUNCTION TuriTinkamasTeises() RETURNS TRIGGER AS
    'BEGIN
    IF (
            SELECT COUNT(*) FROM Transporto_priemone, Turi
            WHERE NEW.Transporto_priemone = Transporto_priemone.VIN AND
                NEW.Vairuotojo_Ak = Turi.Vairuotojo_ak AND
                Transporto_priemone.Teisiu_kategorija = Turi.Teise
        ) = 0
    THEN
        RAISE EXCEPTION ''Vairuotojas neturi tinkamu teisių šiai transporto priemonei'';
    END IF;
    RETURN NEW;
    END;'
LANGUAGE plpgsql;

CREATE TRIGGER TuriTinkamasTeisesTriger
BEFORE  INSERT OR
        UPDATE ON Dalyvauja
FOR EACH ROW
EXECUTE PROCEDURE TuriTinkamasTeises();



