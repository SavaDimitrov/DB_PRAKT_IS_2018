SET SCHEMA FN71737;

--CREATE TABLE MOVIE LIKE {something}.{something} - creating tables similar to {something}.{something}
--CREATE TABLE MOVIE LIKE FN71000.MOVIE;
--CREATE TABLE MOVIE LIKE FN71000.MOVIEEXEC;
--CREATE TABLE MOVIE LIKE FN71000.MOVIESTAR;
--CREATE TABLE MOVIE LIKE FN71000.STARSIN;
--CREATE TABLE MOVIE LIKE FN71000.STUDIO;

-- --num - fixes error code 7 && 23

--1
ALTER TABLE MOVIE
DROP COLUMN TITLE;
--2
ALTER TABLE MOVIE
DROP COLUMN YEAR;
--3
ALTER TABLE MOVIE
ADD TITLE VARCHAR(20) NOT NULL DEFAULT '';
--4
ALTER TABLE MOVIE
ADD YEAR INT NOT NULL DEFAULT 0;
--6
CALL SYSPROC.ADMIN_CMD('REORG TABLE MOVIE');
--5 --7
ALTER TABLE MOVIE
ADD PRIMARY KEY(TITLE, YEAR);

--PRAVI PROMENI
ALTER TABLE STUDIO
ALTER COLUMN NAME SET NOT NULL;

ALTER TABLE MOVIEEXEC
ALTER COLUMN CERT# SET NOT NULL;

CALL SYSPROC.ADMIN_CMD('REORG TABLE STUDIO');

--PRAVI PRIMARY KEY
ALTER TABLE STUDIO
ADD PRIMARY KEY(NAME);

--FIXED CODE 7
CALL SYSPROC.ADMIN_CMD('REORG TABLE MOVIEEXEC');

--...
ALTER TABLE MOVIEEXEC
ADD PRIMARY KEY(CERT#);

--PRAVI FOREIGH KEY
ALTER TABLE MOVIE
ADD FOREIGN KEY(STUDIONAME)
REFERENCES STUDIO(NAME);

--DOBAVQ REDOVE, INFOTO ZA REDU SE VUVEJDA PO KOLONI
INSERT INTO STUDIO(NAME, ADDRESS, PRESC#)
VALUES('MGM', 'USA', '0123456789');

INSERT INTO STUDIO(NAME, ADDRESS, PRESC#)
VALUES('PARAMOUNT', 'USA', '0123456789');

INSERT INTO STUDIO(NAME, ADDRESS, PRESC#)
VALUES('MGM1', 'USA', '0123456789'),
 	('PARAMOUNT1', 'USA', '0123456789');

--ISKARVA TABLICATA 
SELECT * FROM STUDIO;

--TAKA MOJEM DA PROMENQME INFO
UPDATE STUDIO
SET ADDRESS = 'ALBANIA'
WHERE NAME = 'MGM';

--MAHA CQL RED, S IMETO KOETO E PODADENO NA WHERE
DELETE FROM STUDIO
WHERE NAME = 'MGM1';

SELECT * FROM STUDIO;

CREATE TABLE TEST(
 ID INT NOT NULL PRIMARY KEY,
 STUDIONAME VARCHAR(20)
 REFERENCES STUDIO(NAME),
 YEAR INT CHECK(YEAR >= 0 AND YEAR <= 100)
);

INSERT INTO TEST(ID, STUDIONAME, YEAR)
VALUES(0, 'FMI', 50);

--INSERT INTO STUDIO(NAME, ADDRESS, PRESC#)
--VALUES('FMI', 'BG', '081673456');

SELECT * FROM TEST;

INSERT INTO TEST(ID, STUDIONAME, YEAR)
VALUES(1, 'FMI', 99);
