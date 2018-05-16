SET SCHEMA DB2MOVIES;
SET SCHEMA DB2SHIPS;
SET SCHEMA DB2PC;

--PRIMERNI ZADACHI

--VARIANT 1

--######### MOVIES ###########
--TASK 1
--Да се напише заявка, която извежда имената и годините на всички филми, които са
--по-дълги от 120 минути и са снимани преди 1990 г. Ако дължината на филма е
--неизвестна (NULL), името и годината на този филм също да се изведат. 

SELECT TITLE, YEAR, LENGTH
FROM MOVIE
WHERE (LENGTH > 120 AND YEAR < 1990)
OR 	  (LENGTH IS NULL AND YEAR < 1990);

--OPTIMIZACIQ
SELECT TITLE, YEAR, LENGTH
FROM MOVIE
WHERE (LENGTH > 120 OR LENGTH IS NULL) AND YEAR < 1990;

--TASK 2
--Да се напише заявка, която извежда имената на най-младия актьор (мъж).
--Забележка: полът на актьора може да бъде 'M' или 'F'.

SELECT *
FROM MOVIESTAR
WHERE GENDER = 'M' 
AND BIRTHDATE = (SELECT MAX(BIRTHDATE)
				 FROM MOVIESTAR
				 WHERE GENDER = 'M');

--VTORI NACHIN(KATO GORNIQ)
SELECT *
FROM MOVIESTAR
WHERE GENDER = 'M' 
AND BIRTHDATE >= ALL(SELECT MAX(BIRTHDATE)
				 FROM MOVIESTAR
				 WHERE GENDER = 'M');
				 
--VTORI NACHIN - TOVA SHTE RABOTI AKO 
--IMA SAMO 1 CHOVEK RODEN NA TAZI DATA
SELECT *
FROM MOVIESTAR
WHERE GENDER = 'M'
ORDER BY BIRTHDATE DESC
FETCH FIRST 1 ROWS ONLY;

--########### SHIPS ##############

--TASK 3
--Да се напише заявка, която извежда държавата и броят на потъналите кораби за
--тази държава. Държави, които нямат кораби или имат кораб, но той не е участвал в
--битка, също да бъдат изведени.

SELECT C.COUNTRY, COUNT(*) AS SUNK_SHIPS
FROM CLASSES C LEFT JOIN SHIPS S ON C.CLASS = S.CLASS
LEFT JOIN OUTCOMES O ON S.NAME = O.SHIP
WHERE O.RESULT = 'sunk' OR O.RESULT IS NULL
GROUP BY C.COUNTRY ;

--########### PC ##############
--TASK 4
--Да се изведат различните модели компютри, чиято цена е по-ниска от най-евтиния
--лаптоп, произвеждан от същия производител

SELECT PC.*, P.MAKER
FROM PC JOIN PRODUCT P ON PC.MODEL = P.MODEL
WHERE PRICE < (SELECT MIN(PRICE)
			   FROM LAPTOP L JOIN PRODUCT P1
			   ON L.MODEL = P1.MODEL
			   WHERE P.MAKER = P1.MAKER);

--VARIANT 2
--######### MOVIES ###########
--TASK 1
--Да се напише заявка, която извежда имената и пола на всички актьори, чието име
--започва с 'J' и са родени след 1948 година. Резултатът да бъде подреден по име в
--намаляващ ред.

SELECT NAME, GENDER
FROM MOVIESTAR
WHERE NAME LIKE 'J%'
AND YEAR(BIRTHDATE) > 1948
--AND BIRTHDATE > '1948-12-31' --VTORI VARIANT, AKO NE SE SETIM ZA GORNIQ RED
ORDER BY NAME DESC;

--########## SHIPS #########
--TAKS 2 
--Да се напише заявка, която извежда име и държава на всички кораби, които никога
--не са потъвали в битка (може и да не са участвали). 

SELECT C.COUNTRY, S.NAME, O.RESULT
FROM CLASSES C LEFT JOIN SHIPS S ON C.CLASS = S .CLASS
LEFT JOIN OUTCOMES O ON S.NAME = O.SHIP
WHERE O.RESULT <> 'sunk' OR O.RESULT IS NULL;

--########## PC #########
--TASK 3
--Да се напише заявка, която извежда всички модели лаптопи, за които се предлагат
--както разновидности с 15" екран, така и с 11" екран. 

SELECT L1.MODEL, L1.SCREEN
FROM LAPTOP L1, LAPTOP L2
WHERE L1.MODEL = L2.MODEL 
AND L1.SCREEN = 15 
AND L2.SCREEN = 11;

--TASK 4
--Един модел компютри може да се предлага в няколко разновидности с евентуално
--различна цена. Да се изведат тези модели компютри, чиято средна цена (на
--различните му разновидности) е по-ниска от най-евтиния лаптоп.

SELECT MODEL, AVG(PRICE) AS PC_AVG
FROM PC
GROUP BY MODEL
HAVING AVG(PRICE) < (SELECT MIN(PRICE)
					 FROM LAPTOP);

--VARIANT 3
--########## SHIPS ###########
--TASK 1
--Да се напише заявка, която извежда имената на всички кораби без повторения,
--които са участвали в поне една битка и чиито имена започват с буквите C или K. 

SELECT DISTINCT S.NAME
FROM SHIPS S JOIN OUTCOMES O
ON S.NAME = O.SHIP
WHERE S.NAME LIKE 'C%'
OR S.NAME LIKE 'K%';

--######### MOVIES ###########
--TASK 2
--Да се напише заявка, която извежда името на филма, годината и броят на актьорите
--участвали в този филм, за тези филми с повече от 2-ма актьори.

SELECT MOVIETITLE, MOVIEYEAR, COUNT(*)
FROM STARSIN
GROUP BY MOVIETITLE, MOVIEYEAR
HAVING COUNT(*) > 2; --NE E WHERE ZASHTOTO V WHERE KLAUZA NE MOJE DA STOI TAKAVA FUNKCIQ

SELECT MOVIETITLE, MOVIEYEAR, COUNT(NAME), COUNT(*)
FROM STARSIN, MOVIESTAR
WHERE STARNAME = NAME
AND GENDER = 'M'
GROUP BY MOVIETITLE, MOVIEYEAR
HAVING COUNT(*) >= 2;









