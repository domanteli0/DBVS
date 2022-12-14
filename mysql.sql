-- pateikti SQL sakiniai yra pakeisti pagal dėstytojo prašymus atsiskaitymo metu, todėl gali neatitikti užduoties aprašo

-- 1. Visi vardai, kuriuos turi bibliotekos skaitytojai.
SELECT DISTINCT vardas, SUBSTRING(vardas from 2 for 1)  FROM stud.skaitytojas
ORDER BY vardas;

-- 2. Visų konkrečią dieną paimtų egzempliorių numeriai, jų grąžinimo datos ir skaitytojų AK.

SELECT egzempliorius.nr, grazinti, ak, grazinti - CURRENT_DATE AS "Liko dienų"
FROM stud.egzempliorius JOIN stud.skaitytojas ON skaitytojas.nr=egzempliorius.skaitytojas
WHERE paimta = '2022-10-02';

-- 3. Kiekvienam autoriui (vardui ir pavardei) leidyklų, kuriose jis išleido bent vieną knygą, skaičius.

SELECT A.vardas, A.pavarde, COUNT(DISTINCT knyga.leidykla) AS "Leidyklų sk.", COUNT(DISTINCT A.ISBN) AS "Knygų sk.", COUNT(E.Nr) AS "Egz_sk"
FROM knyga JOIN autorius AS A ON A.ISBN=knyga.ISBN JOIN egzempliorius E ON E.ISBN=knyga.ISBN
GROUP BY A.vardas, A.pavarde
HAVING COUNT(E.Nr)>5
ORDER BY COUNT(E.Nr);

-- 4. Data kai gimė daugiausiai skaitytojų, paėmusių bent vieną knygą. Greta pateikti ir tuomet gimusių skaitytojų skaičių.

WITH gim AS (
    SELECT S.gimimas AS "data", COUNT(S.gimimas) AS sk
    FROM skaitytojas AS S JOIN egzempliorius AS E ON E.skaitytojas=S.nr
    GROUP BY S.gimimas
    ),
    m AS (SELECT max(sk) AS max FROM gim)
    SELECT data, sk, m.max
    FROM gim, m
    WHERE sk<max;

-- 5. Lentelė, turinti daugiausiai skirtingų tipų stulpelių.

WITH meta AS (
        SELECT Table_Schema, Table_Name, COUNT(DISTINCT data_type) AS Count
        FROM Information_Schema.Columns
        GROUP BY Table_Schema, Table_Name
    ),
    max AS (
        SELECT MAX(Count) AS max FROM meta
    )
    SELECT Table_Schema, Table_Name, Count FROM meta JOIN max ON meta.Count = max.max
