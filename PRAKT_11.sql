SET SCHEMA DB2PC;

--PRIMERNI ZADACHI VARIANT 2--
--ZADACHA 4

--Един модел компютри може да се предлага в няколко разновидности с евентуално
--различна цена. Да се изведат тези модели компютри, чиято средна цена (на
--различните му разновидности) е по-ниска от най-евтиния лаптоп. 
SELECT MODEL, AVG(PRICE) AS AVG_PRC, COUNT(*) AS BROJ
FROM PC
GROUP BY MODEL
HAVING AVG(PRICE) <= (SELECT MIN(PRICE) FROM LAPTOP);


--PRIMERNI ZADACHI VARIANT 3--

----ZADACHA 3
--Да се напише заявка, която извежда за всеки компютър: код на продукта (code);
--производител; брой компютри, които имат цена, по-голяма или равна на неговата. 

SELECT PC1.CODE, P.MAKER, COUNT(PC2.CODE) AS PC_CNT
FROM PC AS PC1 JOIN PRODUCT P
ON P.MODEL = PC1.MODEL
JOIN PC AS PC2 ON PC1.PRICE < PC2.PRICE
GROUP BY PC1.CODE, P.MAKER;


--ZADACHA 4
--Един модел компютри може да се предлага в няколко разновидности с евентуално
--различна цена. Да се изведат тези модели компютри, чиято сума от цените (на
--различните му разновидности) е по-ниска от сумата на цените на лаптопите.

SELECT MODEL
FROM PC
GROUP BY MODEL
HAVING SUM(PRICE) <= (SELECT SUM(PRICE) FROM LAPTOP);


--PRIMERNI ZADACHI DOPULNITELNA ZADACHA--
--Зад. Един модел компютри може да се предлага в няколко разновидности с евентуално
--различна цена. Да се изведат тези модели компютри, чиято средна цена (на различните му
--разновидности) е по-ниска от най-евтиния лаптоп, произвеждан от същия производител.

SELECT PC.MODEL 
FROM  PC JOIN PRODUCT P
ON P.MODEL = PC.MODEL
GROUP BY PC.MODEL, P.MAKER
HAVING AVG(PRICE) <= (SELECT MIN(PRICE)
					  FROM LAPTOP L JOIN PRODUCT PL
					  ON L.MODEL = PL.MODEL
					  WHERE PL.MAKER = P.MAKER);


--#########################################################################--
--OBSHTI ZADACHI--

SET SCHEMA DB2SHIPS;

--Имената и годините на пускане на всички кораби, които имат същото име като
--своя клас.

SELECT LAUNCHED, NAME, CLASS
FROM SHIPS
WHERE NAME = CLASS;


SET SCHEMA DB2MOVIES;
--Всички филми, чието заглавие съдържа едновременно думите 'Star' и 'Trek' (не
--непременно в този ред). Резултатите да се подредят по година (първо най-новите
--филми), а филмите от една и съща година - по азбучен ред.

SELECT *
FROM MOVIE
WHERE TITLE LIKE '%Star %Trek%'
OR TITLE LIKE '%Trek% Star%'
ORDER BY YEAR DESC, TITLE;


--Заглавията и годините на филмите, в които са играли звезди, родени между
--1.1.1970 и 1.7.1980.

SELECT MOVIETITLE, MOVIEYEAR
FROM STARSIN JOIN MOVIESTAR
ON NAME = STARNAME
WHERE BIRTHDATE BETWEEN '1970-01-01'
AND '1980-07-01';

SET SCHEMA DB2SHIPS;
--Имената на всички кораби, за които едновременно са изпълнени следните
--условия: (1) участвали са в поне една битка и (2) имената им (на корабите)
--започват с C или K.

SELECT NAME
FROM SHIPS JOIN OUTCOMES
ON NAME = SHIP
WHERE NAME LIKE 'C%' OR NAME LIKE 'K%';

--Всички държави, които имат потънали в битка кораби.

SELECT DISTINCT C.COUNTRY
FROM CLASSES C JOIN SHIPS S
ON C.CLASS = S.CLASS
JOIN OUTCOMES O ON S.NAME = O.SHIP
WHERE O.RESULT = 'sunk';

--Всички държави, които нямат нито един потънал кораб.

SELECT COUNTRY
FROM CLASSES
EXCEPT 
SELECT C.COUNTRY
FROM CLASSES C JOIN SHIPS S
ON C.CLASS = S.CLASS
JOIN OUTCOMES O ON S.NAME = O.SHIP
WHERE O.RESULT = 'sunk';

--VTORI NACHIN
SELECT DISTINCT COUNTRY
FROM CLASSES
WHERE COUNTRY NOT IN(SELECT C.COUNTRY
					 FROM CLASSES C JOIN SHIPS S
					 ON C.CLASS = S.CLASS
					 JOIN OUTCOMES O ON S.NAME = O.SHIP
					 WHERE O.RESULT = 'sunk');

--(От държавен изпит) Имената на класовете, за които няма кораб, пуснат на вода
--(launched) след 1921 г. Ако за класа няма пуснат никакъв кораб, той също трябва
--да излезе в резултата.

SELECT C.CLASS, S.*
FROM CLASSES C LEFT JOIN SHIPS S
ON C.CLASS = S.CLASS
WHERE C.CLASS NOT IN (SELECT CLASS FROM SHIPS
					  WHERE LAUNCHED > 1921);

--Името, държавата и калибъра (bore) на всички класове кораби с 6, 8 или 10
--оръдия. Калибърът да се изведе в сантиметри (1 инч е приблизително 2.54 см).

SELECT S.NAME, C.COUNTRY, C.BORE*2.54 AS SM
FROM CLASSES C JOIN SHIPS S
ON C.CLASS = S.CLASS
WHERE C.NUMGUNS = 6 OR C.NUMGUNS = 8 OR C.NUMGUNS = 10;

--Държавите, които имат класове с различен калибър (напр. САЩ имат клас с 14
--калибър и класове с 16 калибър, докато Великобритания има само класове с 15).


--Страните, които произвеждат кораби с най-голям брой оръдия (numguns).

SELECT DISTINCT COUNTRY 
FROM CLASSES 
WHERE NUMGUNS = (SELECT MAX(NUMGUNS) FROM CLASSES);

--Компютрите, които са по-евтини от всеки лаптоп на същия производител.

--Компютрите, които са по-евтини от всеки лаптоп и принтер на същия
--производител.