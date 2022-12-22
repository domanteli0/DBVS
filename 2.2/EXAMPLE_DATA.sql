DELETE FROM Paketas;
DELETE FROM Vairuotojas;
DELETE FROM Teises;
DELETE FROM Transporto_priemone;
DELETE FROM Vaziavimas;
DELETE FROM Dalyvauja;
DELETE FROM Vezami;
DELETE FROM Turi;

-- INSERT INTO Paketas VALUES(Id, Svoris, Plotis, Ilgis, Aukštis);
INSERT INTO Paketas VALUES(0, 10, 100, 200, 3000);
INSERT INTO Paketas VALUES(1, 200, 1000, 3500, 9000);
INSERT INTO Paketas VALUES(2, 20, 1000, 350, 900);
INSERT INTO Paketas VALUES(3, 50, 200, 3500, 1000);
INSERT INTO Paketas VALUES(4, 5, 300, 350, 900);
INSERT INTO Paketas VALUES(5, 2, 300, 100, 50);
INSERT INTO Paketas VALUES(6, 1, 200, 200, 40);

-- INSERT INTO Vairuotojas VALUES(Ak);
INSERT INTO Vairuotojas VALUES('5200010109999');
INSERT INTO Vairuotojas VALUES('4199910109999');

-- INSERT INTO Teises VALUES(Kategorija);
INSERT INTO Teises VALUES('C1E');
INSERT INTO Teises VALUES('CE');

INSERT INTO Teises VALUES('C1');
INSERT INTO Teises VALUES('C');

-- INSERT INTO Transporto_priemone VALUES(VIN, Teisiu_kategorija);
INSERT INTO Transporto_priemone VALUES('ABCDEFGHJK2345679', 'C');
INSERT INTO Transporto_priemone VALUES('ABCDEFGHJK2345678', 'C1');
INSERT INTO Transporto_priemone VALUES('ABCDEFGHJK2345677', 'CE');
INSERT INTO Transporto_priemone VALUES('ABCDEFGHJK2345676', 'C1E');

-- INSERT INTO Vaziavimas
--     VALUES(
--         Transporto_priemone,
--         Pradzia,   
--         Pabaiga,
--         -- TODO: pradzia < pabaiga

--         Pradinis_salis,
--         Pradinis_miestas,
--         Pradinis_gatve,
--         Pradinis_namo_nr,
--         Pradinis_pasto_kodas,

--         Tikslo_salis,
--         Tikslo_miestas,
--         Tikslo_gatve,
--         Tikslo_namo_nr,
--         Tikslo_pasto_kodas
--     );

INSERT INTO Vaziavimas
    VALUES(
        'ABCDEFGHJK2345679',
        '2023-01-01 08:00:00',   
        '2023-01-01 12:00:00',
        
        'Lietuva',
        'Vilnius',
        'Naugarduko g.',
        '24',
        'LT-01111',
        
        'Lietuva',
        'Klaidėpa',
        'Upės',
        '20A',
        'LT-11111'
    );


-- TRIGGER EXAMPLE
INSERT INTO Vaziavimas
    VALUES(
        'ABCDEFGHJK2345679',
        '2023-01-01 12:00:01',   
        '2023-01-01 14:00:00',
        
        'Lietuva',
        'Vilnius',
        'Naugarduko g.',
        '24',
        'LT-01111',
        
        'Lietuva',
        'Klaidėpa',
        'Upės',
        '20A',
        'LT-11111'
    );

--  Vairuotojas - Teisės
INSERT INTO Turi VALUES('C', '5200010109999');
INSERT INTO Turi VALUES('CE', '5200010109999');
INSERT INTO Turi VALUES('CE', '4199910109999');

-- INSERT INTO Dalyvauja VALUES(Transporto_priemone,   Pradzia,   Pabaiga, Vairuotojo_Ak);
INSERT INTO Dalyvauja VALUES('ABCDEFGHJK2345679', '2023-01-01 08:00:00', '2023-01-01 12:00:00', '5200010109999');
INSERT INTO Dalyvauja VALUES('ABCDEFGHJK2345679', '2023-01-01 12:00:01', '2023-01-01 14:00:00', '5200010109999');

--  Paketas - Važiavimas
INSERT INTO Vezami VALUES('ABCDEFGHJK2345679', '2023-01-01 08:00:00', '2023-01-01 12:00:00', 0);
INSERT INTO Vezami VALUES('ABCDEFGHJK2345679', '2023-01-01 08:00:00', '2023-01-01 12:00:00', 1);
INSERT INTO Vezami VALUES('ABCDEFGHJK2345679', '2023-01-01 08:00:00', '2023-01-01 12:00:00', 2);
INSERT INTO Vezami VALUES('ABCDEFGHJK2345679', '2023-01-01 08:00:00', '2023-01-01 12:00:00', 3);
INSERT INTO Vezami VALUES('ABCDEFGHJK2345679', '2023-01-01 08:00:00', '2023-01-01 12:00:00', 4);

