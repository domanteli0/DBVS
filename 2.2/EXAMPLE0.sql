-- CHECK pradzia != tikslas
INSERT INTO Vaziavimas
    VALUES(
        'ABCDEFGHJK2345678',
        '2022-12-01 08:00:00',   
        '2022-12-01 12:00:00',
        
        'Lietuva',
        'Vilnius',
        'Naugarduko g.',
        '24',
        'LT-01111',

        'Latvija',
        'Vilnius',
        'Naugarduko g.',
        '24',
        'LT-01111'
    );

-- Check view
-- INSERT INTO Paketas VALUES(10, 10000, 10, 10, 10);

-- check triger
-- INSERT INTO Dalyvauja VALUES(Transporto_priemone,   Pradzia,   Pabaiga, Vairuotojo_Ak);
UPDATE vaziavimas SET Pradzia = '2023-01-01 11:00:00' WHERE Pradzia = '2023-01-01 12:00:01';
