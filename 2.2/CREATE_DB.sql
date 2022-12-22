DROP TABLE IF EXISTS Transporto_priemone;
DROP TABLE IF EXISTS Vezami;
DROP TABLE IF EXISTS Dalyvauja;
DROP TABLE IF EXISTS Paketas;
DROP TABLE IF EXISTS Turi;
DROP TABLE IF EXISTS Teises;
DROP TABLE IF EXISTS Vaziavimas;
DROP TABLE IF EXISTS Vairuotojas;

-- Esybės
CREATE TABLE Paketas
    (
        Id SERIAL NOT NULL PRIMARY KEY,
        Svoris FLOAT NOT NULL,
        Plotis INTEGER NOT NULL,
        Ilgis INTEGER NOT NULL,
        Aukštis INTEGER NOT NULL
    );

CREATE TABLE Vairuotojas
    (
        Ak CHAR(13) UNIQUE NOT NULL PRIMARY KEY
    );

CREATE TABLE Teises
    (
        Kategorija VARCHAR(4) UNIQUE NOT NULL PRIMARY KEY
    );

CREATE TABLE Transporto_priemone
    (
        VIN CHAR(17) UNIQUE NOT NULL PRIMARY KEY,
        Teisiu_kategorija VARCHAR(4) NOT NULL
    );

-- <https://en.wikipedia.org/wiki/Vehicle_identification_number#History_of_the_bodywork_number>
ALTER TABLE Transporto_priemone
    ADD CONSTRAINT NO_DISALLOWED_VIN_CHARS
    CHECK(NOT (VIN LIKE '%O%' OR VIN LIKE '%o%' OR VIN LIKE '%I%' OR VIN LIKE '%i%' OR VIN LIKE '%Q%' OR VIN LIKE '%q%'));

CREATE TABLE Vaziavimas
    (
        Transporto_priemone CHAR(17) NOT NULL,
        Pradzia TIMESTAMPTZ NOT NULL,   
        Pabaiga TIMESTAMPTZ NOT NULL,
        -- TODO: pradzia < pabaiga

        Pradinis_salis VARCHAR(100),
        Pradinis_miestas VARCHAR(100),
        Pradinis_gatve VARCHAR(100),
        Pradinis_namo_nr VARCHAR(100),
        Pradinis_pasto_kodas VARCHAR(20),

        Tikslo_salis VARCHAR(100),
        Tikslo_miestas VARCHAR(100),
        Tikslo_gatve VARCHAR(100),
        Tikslo_namo_nr VARCHAR(100),
        Tikslo_pasto_kodas VARCHAR(20)
    );
ALTER TABLE Vaziavimas
    ADD PRIMARY KEY (Transporto_priemone, Pradzia, Pabaiga),
    ADD CONSTRAINT PradziaPabaiga CHECK (Pradzia < Pabaiga),
    ADD CONSTRAINT PradinisNelyguTikslas CHECK (
        NOT (Pradinis_salis = Tikslo_salis AND
        Pradinis_miestas = Tikslo_miestas AND
        Pradinis_gatve = Tikslo_gatve AND
        Pradinis_namo_nr = Tikslo_namo_nr AND
        Pradinis_pasto_kodas = Tikslo_pasto_kodas)
    );
        


-- -- RYŠIAI -- --
--  Vairuotojas - Važiavimas
CREATE TABLE Dalyvauja
    (
        -- Važiavimas
        Transporto_priemone CHAR(17) NOT NULL,   
        Pradzia TIMESTAMPTZ NOT NULL,   
        Pabaiga TIMESTAMPTZ NOT NULL,
        FOREIGN KEY (Transporto_priemone, Pradzia, Pabaiga) 
            REFERENCES Vaziavimas(Transporto_priemone, Pradzia, Pabaiga) 
            ON DELETE CASCADE ON UPDATE CASCADE,

        Vairuotojo_Ak CHAR(13) NOT NULL,
        FOREIGN KEY (Vairuotojo_Ak) REFERENCES Vairuotojas(Ak)
            ON DELETE CASCADE ON UPDATE CASCADE,

        PRIMARY KEY (Transporto_priemone, Pradzia, Pabaiga, Vairuotojo_Ak)
    );
-- ALTER TABLE Dalyvauja
--     ADD CONSTRAINT Tinkamos_teisės CHECK (
--         (
--             SELECT * FROM Turi, Dalyvauja, Transporto_priemone
--             WHERE Turi.Vairuotojo_Ak = Dalyvauja.Vairuotojo_Ak AND
--                 Transporto_priemone.VIN = Dalyvauja.Transporto_priemone AND
--                 Turi.Teise = Transporto_priemone.Teisiu_kategorija
--         ) > 1
--     );

--  Paketas - Važiavimas
CREATE TABLE Vezami 
    (
        -- Važiavimas
        Transporto_priemone CHAR(17) NOT NULL,   
        Pradzia TIMESTAMPTZ NOT NULL,   
        Pabaiga TIMESTAMPTZ NOT NULL,
        FOREIGN KEY (Transporto_priemone, Pradzia, Pabaiga) 
            REFERENCES Vaziavimas(Transporto_priemone, Pradzia, Pabaiga) 
            ON DELETE RESTRICT ON UPDATE CASCADE,

        -- Paketas
        Paketo_ID SERIAL NOT NULL,
        FOREIGN KEY (Paketo_ID) REFERENCES Paketas(Id)
            ON DELETE CASCADE ON UPDATE CASCADE,
        
        PRIMARY KEY (Transporto_priemone, Pradzia, Pabaiga, Paketo_ID)
    );

--  Vairuotojas - Teisės
CREATE TABLE Turi
    (
        Teise VARCHAR(4),
        Vairuotojo_ak CHAR(13),

        FOREIGN KEY (Teise) 
            REFERENCES Teises(Kategorija) 
            ON DELETE CASCADE ON UPDATE CASCADE,
        FOREIGN KEY (Vairuotojo_ak) 
            REFERENCES Vairuotojas(Ak) 
            ON DELETE CASCADE ON UPDATE CASCADE,
        
        PRIMARY KEY (Teise, Vairuotojo_ak)
    );