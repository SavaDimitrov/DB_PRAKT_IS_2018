SET SCHEMA DB2PC;

--PRIMERNI ZADACHI VARIANT 2--
--ZADACHA 4

--���� ����� �������� ���� �� �� �������� � ������� ������������� � ����������
--�������� ����. �� �� ������� ���� ������ ��������, ����� ������ ���� (��
--���������� �� �������������) � ��-����� �� ���-������� ������. 
SELECT MODEL, AVG(PRICE) AS AVG_PRC, COUNT(*) AS BROJ
FROM PC
GROUP BY MODEL
HAVING AVG(PRICE) <= (SELECT MIN(PRICE) FROM LAPTOP);


--PRIMERNI ZADACHI VARIANT 3--

----ZADACHA 3
--�� �� ������ ������, ����� ������� �� ����� ��������: ��� �� �������� (code);
--������������; ���� ��������, ����� ���� ����, ��-������ ��� ����� �� ��������. 

SELECT PC1.CODE, P.MAKER, COUNT(PC2.CODE) AS PC_CNT
FROM PC AS PC1 JOIN PRODUCT P
ON P.MODEL = PC1.MODEL
JOIN PC AS PC2 ON PC1.PRICE < PC2.PRICE
GROUP BY PC1.CODE, P.MAKER;


--ZADACHA 4
--���� ����� �������� ���� �� �� �������� � ������� ������������� � ����������
--�������� ����. �� �� ������� ���� ������ ��������, ����� ���� �� ������ (��
--���������� �� �������������) � ��-����� �� ������ �� ������ �� ���������.

SELECT MODEL
FROM PC
GROUP BY MODEL
HAVING SUM(PRICE) <= (SELECT SUM(PRICE) FROM LAPTOP);


--PRIMERNI ZADACHI DOPULNITELNA ZADACHA--
--���. ���� ����� �������� ���� �� �� �������� � ������� ������������� � ����������
--�������� ����. �� �� ������� ���� ������ ��������, ����� ������ ���� (�� ���������� ��
--�������������) � ��-����� �� ���-������� ������, ����������� �� ����� ������������.

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

--������� � �������� �� ������� �� ������ ������, ����� ���� ������ ��� ����
--���� ����.

SELECT LAUNCHED, NAME, CLASS
FROM SHIPS
WHERE NAME = CLASS;


SET SCHEMA DB2MOVIES;
--������ �����, ����� �������� ������� ������������ ������ 'Star' � 'Trek' (��
--���������� � ���� ���). ����������� �� �� �������� �� ������ (����� ���-������
--�����), � ������� �� ���� � ���� ������ - �� ������� ���.

SELECT *
FROM MOVIE
WHERE TITLE LIKE '%Star %Trek%'
OR TITLE LIKE '%Trek% Star%'
ORDER BY YEAR DESC, TITLE;


--���������� � �������� �� �������, � ����� �� ������ ������, ������ �����
--1.1.1970 � 1.7.1980.

SELECT MOVIETITLE, MOVIEYEAR
FROM STARSIN JOIN MOVIESTAR
ON NAME = STARNAME
WHERE BIRTHDATE BETWEEN '1970-01-01'
AND '1980-07-01';

SET SCHEMA DB2SHIPS;
--������� �� ������ ������, �� ����� ������������ �� ��������� ��������
--�������: (1) ��������� �� � ���� ���� ����� � (2) ������� �� (�� ��������)
--�������� � C ��� K.

SELECT NAME
FROM SHIPS JOIN OUTCOMES
ON NAME = SHIP
WHERE NAME LIKE 'C%' OR NAME LIKE 'K%';

--������ �������, ����� ���� �������� � ����� ������.

SELECT DISTINCT C.COUNTRY
FROM CLASSES C JOIN SHIPS S
ON C.CLASS = S.CLASS
JOIN OUTCOMES O ON S.NAME = O.SHIP
WHERE O.RESULT = 'sunk';

--������ �������, ����� ����� ���� ���� ������� �����.

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

--(�� �������� �����) ������� �� ���������, �� ����� ���� �����, ������ �� ����
--(launched) ���� 1921 �. ��� �� ����� ���� ������ ������� �����, ��� ���� ������
--�� ������ � ���������.

SELECT C.CLASS, S.*
FROM CLASSES C LEFT JOIN SHIPS S
ON C.CLASS = S.CLASS
WHERE C.CLASS NOT IN (SELECT CLASS FROM SHIPS
					  WHERE LAUNCHED > 1921);

--�����, ��������� � �������� (bore) �� ������ ������� ������ � 6, 8 ��� 10
--������. ��������� �� �� ������ � ���������� (1 ��� � ������������� 2.54 ��).

SELECT S.NAME, C.COUNTRY, C.BORE*2.54 AS SM
FROM CLASSES C JOIN SHIPS S
ON C.CLASS = S.CLASS
WHERE C.NUMGUNS = 6 OR C.NUMGUNS = 8 OR C.NUMGUNS = 10;

--���������, ����� ���� ������� � �������� ������� (����. ��� ���� ���� � 14
--������� � ������� � 16 �������, ������ �������������� ��� ���� ������� � 15).


--��������, ����� ����������� ������ � ���-����� ���� ������ (numguns).

SELECT DISTINCT COUNTRY 
FROM CLASSES 
WHERE NUMGUNS = (SELECT MAX(NUMGUNS) FROM CLASSES);

--����������, ����� �� ��-������ �� ����� ������ �� ����� ������������.

--����������, ����� �� ��-������ �� ����� ������ � ������� �� �����
--������������.