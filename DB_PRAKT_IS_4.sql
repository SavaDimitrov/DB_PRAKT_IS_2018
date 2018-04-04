SET SCHEMA DB2MOVIES;

SELECT *
FROM STUDIO S, MOVIE M --SUEDINENIE; STUDIO AS S, MOVIE AS M
WHERE S.NAME=M.STUDIONAME; --VRUZKA M/U DVETE TABLICI; PURVICHEN SPRQMO ...

--##########OBEDINENIE#############--
--BEZ POVTORENIE
(SELECT MOVIETITLE AS TITLE , MOVIEYEAR AS YEAR
FROM STARSIN)
UNION
(SELECT TITLE, YEAR 
FROM MOVIE);


--S POVTORRENIE
(SELECT MOVIETITLE AS TITLE , MOVIEYEAR AS YEAR
FROM STARSIN)
UNION ALL --CHANGED
(SELECT TITLE, YEAR 
FROM MOVIE);

--##########SECHENIE#############--
--BEZ POVTORENIE
(SELECT MOVIETITLE AS TITLE , MOVIEYEAR AS YEAR
FROM STARSIN)
INTERSECT 
(SELECT TITLE, YEAR 
FROM MOVIE);

--S POVTORRENIE
(SELECT MOVIETITLE AS TITLE , MOVIEYEAR AS YEAR
FROM STARSIN)
INTERSECT ALL
(SELECT TITLE, YEAR 
FROM MOVIE);

--##########RAZLIKA#############--
--BEZ POVTORENIE
(SELECT TITLE, YEAR 
FROM MOVIE)
EXCEPT
(SELECT MOVIETITLE AS TITLE , MOVIEYEAR AS YEAR
FROM STARSIN);

--S POVTORRENIE
(SELECT TITLE, YEAR 
FROM MOVIE)
EXCEPT ALL
(SELECT MOVIETITLE AS TITLE , MOVIEYEAR AS YEAR
FROM STARSIN);

--########TASKS########--
/*
Напишете заявка, която извежда имената на актьорите мъже участвали в ‘Terms
of Endearment’
*/

SELECT NAME
FROM MOVIESTAR, STARSIN
WHERE STARNAME = NAME
AND GENDER = 'M' AND MOVIETITLE = 'Terms of Endearment';
/*
Напишете заявка, която извежда имената на актьорите участвали във филми
продуцирани от ‘MGM’през 1995 г.
*/

SELECT STARNAME
FROM MOVIE, STARSIN 
WHERE TITLE = MOVIETITLE
AND YEAR = MOVIEYEAR
AND STUDIONAME = 'MGM' AND YEAR = 1995;

/*
Напишете заявка, която извежда името на президента на ‘MGM’
*/
SELECT DISTINCT ME.NAME
FROM STUDIO S, MOVIE M, MOVIEEXEC ME
WHERE S.NAME = M.STUDIONAME
AND M.PRODUCERC# = ME.CERT#
AND S.NAME = 'MGM';

/*
Напишете заявка, която извежда имената на всички филми с дължина по-голяма
от дължината на филма ‘Gone With the Wind’
*/

SELECT M_ALL.TITLE
FROM MOVIE M_ALL, MOVIE M_GONE
WHERE M_GONE.TITLE = 'Gone With the Wind'
AND M_ALL.LENGTH < M_GONE.LENGTH; -- > - NQMA TAKIVA FILMI, ZATOVA <

/*
Напишете заявка, която извежда имената на тези продукции на стойност по-
голяма от продукциите на продуценти ‘Merv Griffin’
*/

SELECT ME_ALL.NAME, M.TITLE
FROM MOVIEEXEC ME_ALL, MOVIEEXEC ME_MG, MOVIE M
WHERE ME_MG.NAME = 'Mery Griffin'
AND ME_ALL.NETWORTH > ME_MG.NETWORTH
AND ME_ALL.CERT# = M.PRODUCERC#;

SET SCHEMA DB2SHIPS;

/*
Напишете заявка, която извежда името на корабите по-тежки от 35000
*/

SELECT S.NAME
FROM CLASSES C, SHIPS S
WHERE C.CLASS = S.CLASS
AND C.DISPLACEMENT > 50000;


/*
 Напишете заявка, която извежда имената, водоизместимостта и броя оръжия на
всички кораби участвали в битката при ‘Guadalcanal’
*/

SELECT S.NAME, C.DISPLACEMENT, C.NUMGUNS
FROM CLASSES C, SHIPS S, OUTCOMES O
WHERE C.CLASS = S.CLASS
AND S.NAME = O.SHIP
AND O.BATTLE = 'Guadalcanal';


/*
Напишете заявка, която извежда имената на тези държави, които имат кораби от
тип ‘bb’ и ‘bc’ едновременно
*/

SELECT C_BB.COUNTRY
FROM CLASSES C_BB, CLASSES C_BC
WHERE C_BB.COUNTRY = C_BC.COUNTRY 
AND C_BB.TYPE = 'bb'
AND  C_BC.TYPE = 'bc';


/*
Напишете заявка, която извежда имената на тези битки с три кораби на една и
съща държава
*/

SELECT DISTINCT O1.BATTLE, C1.COUNTRY
FROM CLASSES C1, SHIPS S1, OUTCOMES O1,
	 CLASSES C2, SHIPS S2, OUTCOMES O2,
	 CLASSES C3, SHIPS S3, OUTCOMES O3
WHERE C1.CLASS = S1.CLASS AND S1.NAME = O1.SHIP
AND   C2.CLASS = S2.CLASS AND S2.NAME = O2.SHIP
AND   C3.CLASS = S3.CLASS AND S3.NAME = O3.SHIP
AND   C1.COUNTRY = C2.COUNTRY
AND   C2.COUNTRY = C3.COUNTRY
AND   O1.BATTLE = O2.BATTLE
AND   O2.BATTLE = O3.BATTLE
AND   S1.NAME <> S2.NAME
AND   S2.NAME <> S3.NAME
AND   S1.NAME <> S3.NAME;


/*
Напишете заявка, която извежда имената на тези кораби, които са били
повредени в една битка, но по късно са участвали в друга битка
*/