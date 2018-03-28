SET SCHEMA DB2MOVIES;

--LIKE (Iva%) - % moje da ima 0 ili poveche simvoli sled Iva(v sluchaq)
--LIke (.._) - _ tochno edin simvol

SELECT *
FROM MOVIE;

/*
�������� ������, ����� ������� ������� �� ������ �MGM� 
*/
SELECT ADDRESS 
FROM STUDIO
WHERE NAME='MGM';

SELECT ADDRESS 
FROM STUDIO
WHERE lower(NAME) ='mgm';

/*
�������� ������, ����� ������� ��������� ���� �� ��������� Sandra Bullock 
*/
SELECT BIRTHDATE
FROM MOVIESTAR
WHERE NAME LIKE 'Sandra%';

/*
�������� ������, ����� ������� ������� �� ������ �������, ����� �� ���������
��� ���� ���� 1980 � ���������� �� ����� ��� ������ �Love� 
*/
SELECT DISTINCT STARNAME
FROM STARSIN
WHERE MOVIEYEAR = 1980 OR MOVIETITLE LIKE '%Wars%'
ORDER BY STARNAME DESC; 
-- moje vmesto STARNAME da ima chislo, koeto znachi po koq kolona da sortira, DESC - nizhodqsht, ASC - vuzhodqsht

/*
�������� ������, ����� ������� ������� �� ������ �������, ����� �� ���� ���
������ � Malibu
*/
SELECT NAME
FROM MOVIESTAR
WHERE GENDER = 'M' OR ADDRESS LIKE '%Malibu%';

/*
�������� ������, ����� ������� ������� ������ ����������� �� ����� ��
�������� ��� 10 000 000 ������
*/
SELECT NAME, NETWORTH
FROM MOVIEEXEC
WHERE NETWORTH > 100000000;

/*
zaqvki za SHIPS.
*/
SET SCHEMA DB2SHIPS;

/*
�������� ������, ����� ������� ����� �� ����� � �������� �� ������ ������� �
���� �� �������� ��-����� �� 10 
*/
SELECT CLASS, COUNTRY, NUMGUNS
FROM CLASSES
WHERE NUMGUNS < 10;

/*
�������� ������, ����� ������� ������� �� ������ ������, ������� �� ����
����� 1918. ������� ��������� �� �������� shipName 
*/
SELECT NAME AS SHIP_NAME
FROM SHIPS
WHERE LAUNCHED < 1918 AND NAME LIKE 'R%';

/*
�������� ������, ����� ������� ������� �� �������� �������� � ����� �
������� �� ������� � ����� �� ��������
*/
SELECT BATTLE, SHIP
FROM OUTCOMES
WHERE RESULT = 'sunk'
ORDER BY 1; --v sluchaq 1 == BATTLE

/*
�������� ������, ����� ������� ������� �� �������� � ��� ��������� � �����
�� ������ ����
*/
SELECT NAME
FROM SHIPS
WHERE NAME = CLASS;

/*
�������� ������, ����� ������� ������� �� ������ ������ ��������� � �������
R 
*/
SELECT NAME
FROM SHIPS
WHERE NAME LIKE 'R%';

/*
�������� ������, ����� ������� ������� �� ������ ������, ����� ��� �
��������� �� ����� ��� ����. 
*/
SELECT NAME
FROM SHIPS
WHERE NAME LIKE '% %' AND NAME NOT LIKE '% % %';

/*
Kompiutri
*/
SET SCHEMA DB2PC;

/*
�������� ������, ����� ������� ����� �� �����, ������� � ������ �� ����� ��
������ �������� � ���� ��-����� �� 1200 ������. ������� ���������� ��
���������� ������� � ������ �� �����, ��������� MHz � GB
*/
SELECT MODEL, SPEED AS MHz, HD AS GB
FROM PC
WHERE PRICE < 1200
ORDER BY MODEL, GB;

/*
�������� ������, ����� ������� ������ ������������� �� �������� ���
����������
*/
SELECT DISTINCT MAKER
FROM PRODUCT
WHERE TYPE = 'Printer';

/*
�������� ������, ����� ������� ����� �� �����, ������ �� �������, ������ ��
����� �� ���������, ����� ���� � ��-������ �� 1000 ������
*/
SELECT MODEL, RAM, SCREEN
FROM LAPTOP
WHERE PRICE > 1000;

/* 
�������� ������, ����� ������� ������ ������ ��������
*/
SELECT *
FROM PRINTER;

/*
�������� ������, ����� ������� ����� �� �����, ������� � ������ �� ����� ��
���� �������� � DVD 12x ��� 16x � ���� ��-����� �� 2000 ������.
*/

SELECT *
FROM;