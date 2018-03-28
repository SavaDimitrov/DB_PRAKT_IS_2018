SET SCHEMA DB2MOVIES;

--LIKE (Iva%) - % moje da ima 0 ili poveche simvoli sled Iva(v sluchaq)
--LIke (.._) - _ tochno edin simvol

SELECT *
FROM MOVIE;

/*
Напишете заявка, която извежда адресът на студио ‘MGM’ 
*/
SELECT ADDRESS 
FROM STUDIO
WHERE NAME='MGM';

SELECT ADDRESS 
FROM STUDIO
WHERE lower(NAME) ='mgm';

/*
Напишете заявка, която извежда рождената дата на актрисата Sandra Bullock 
*/
SELECT BIRTHDATE
FROM MOVIESTAR
WHERE NAME LIKE 'Sandra%';

/*
Напишете заявка, която извежда имената на всички актьори, които са участвали
във филм през 1980 в заглавието на които има думата ‘Love’ 
*/
SELECT DISTINCT STARNAME
FROM STARSIN
WHERE MOVIEYEAR = 1980 OR MOVIETITLE LIKE '%Wars%'
ORDER BY STARNAME DESC; 
-- moje vmesto STARNAME da ima chislo, koeto znachi po koq kolona da sortira, DESC - nizhodqsht, ASC - vuzhodqsht

/*
Напишете заявка, която извежда имената на всички актьори, които са мъже или
живеят в Malibu
*/
SELECT NAME
FROM MOVIESTAR
WHERE GENDER = 'M' OR ADDRESS LIKE '%Malibu%';

/*
Напишете заявка, която извежда имената всички изпълнители на филми на
стойност над 10 000 000 долара
*/
SELECT NAME, NETWORTH
FROM MOVIEEXEC
WHERE NETWORTH > 100000000;

/*
zaqvki za SHIPS.
*/
SET SCHEMA DB2SHIPS;

/*
Напишете заявка, която извежда името на класа и страната за всички класове с
брой на оръдията по-малък от 10 
*/
SELECT CLASS, COUNTRY, NUMGUNS
FROM CLASSES
WHERE NUMGUNS < 10;

/*
Напишете заявка, която извежда имената на всички кораби, пуснати на вода
преди 1918. Задайте псевдоним на колоната shipName 
*/
SELECT NAME AS SHIP_NAME
FROM SHIPS
WHERE LAUNCHED < 1918 AND NAME LIKE 'R%';

/*
Напишете заявка, която извежда имената на корабите потънали в битка и
имената на битките в които са потънали
*/
SELECT BATTLE, SHIP
FROM OUTCOMES
WHERE RESULT = 'sunk'
ORDER BY 1; --v sluchaq 1 == BATTLE

/*
Напишете заявка, която извежда имената на корабите с име съвпадащо с името
на техния клас
*/
SELECT NAME
FROM SHIPS
WHERE NAME = CLASS;

/*
Напишете заявка, която извежда имената на всички кораби започващи с буквата
R 
*/
SELECT NAME
FROM SHIPS
WHERE NAME LIKE 'R%';

/*
Напишете заявка, която извежда имената на всички кораби, чието име е
съставено от точно две думи. 
*/
SELECT NAME
FROM SHIPS
WHERE NAME LIKE '% %' AND NAME NOT LIKE '% % %';

/*
Kompiutri
*/
SET SCHEMA DB2PC;

/*
Напишете заявка, която извежда номер на модел, честота и размер на диска за
всички компютри с цена по-малка от 1200 долара. Задайте псевдоними за
атрибутите честота и размер на диска, съответно MHz и GB
*/
SELECT MODEL, SPEED AS MHz, HD AS GB
FROM PC
WHERE PRICE < 1200
ORDER BY MODEL, GB;

/*
Напишете заявка, която извежда всички производители на принтери без
повторения
*/
SELECT DISTINCT MAKER
FROM PRODUCT
WHERE TYPE = 'Printer';

/*
Напишете заявка, която извежда номер на модел, размер на паметта, размер на
екран за лаптопите, чиято цена е по-голяма от 1000 долара
*/
SELECT MODEL, RAM, SCREEN
FROM LAPTOP
WHERE PRICE > 1000;

/* 
Напишете заявка, която извежда всички цветни принтери
*/
SELECT *
FROM PRINTER;

/*
Напишете заявка, която извежда номер на модел, честота и размер на диска за
тези компютри с DVD 12x или 16x и цена по-малка от 2000 долара.
*/

SELECT *
FROM;