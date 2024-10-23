Create Database LivreExercice

create table TYPE_EXERCICE
(type_exercice varchar(2) primary key not null,
libelle_type varchar(25) not null)

create table EXERCICE
(numero_exercice varchar(30) not null,
enonce varchar(30),
nombre_page int,
type_exercice varchar(2) not null,
primary key(numero_exercice, type_exercice),
foreign key (type_exercice) references TYPE_EXERCICE(type_exercice))

create table ESTIMATION
(type_exercice varchar(2) not null,
niveau varchar(30),
duree_estime datetime,
primary key(type_exercice , niveau),
foreign key (type_exercice) references TYPE_EXERCICE(type_exercice))


drop table TYPE_EXERCICE
drop table EXERCICE
drop table ESTIMATION

insert into TYPE_EXERCICE Values
('M','Manipulation de BD')
insert into TYPE_EXERCICE Values
('C','Conception de BD')
insert into TYPE_EXERCICE Values
('P','Problem de BD')

insert into ESTIMATION values
('M','Moyen','03:15:00')
insert into ESTIMATION values
('M','Facile','02:30:00')
insert into ESTIMATION values
('C','Defficile','05:00:00')
insert into ESTIMATION values
('P','Facile','04:20:00')
insert into ESTIMATION values
('M','Defficile','04:30:00')
insert into ESTIMATION values
('P','Moyen','05:10:00')
insert into ESTIMATION values
('C','Facile','02:45:00')
insert into ESTIMATION values
('C','Moyen','04:00:00')
insert into ESTIMATION values
('P','Defficile','06:25:00')

insert into Exercice values
('EX001','Enonce EX001','3','C')
insert into Exercice values
('EX002','Enonce EX002','8','M')
insert into Exercice values
('EX003','Enonce EX003','6','P')
insert into Exercice values
('EX004','Enonce EX004','2','P')
insert into Exercice values
('EX005','Enonce EX005','5','C')
insert into Exercice values
('EX006','Enonce EX006','4','C')


-- 1
SELECT * FROM EXERCICE WHERE nombre_page < 4

-- 2
SELECT * FROM ESTIMATION WHERE DATEPART(HOUR, duree_estime) < 3

-- 3
SELECT TE.libelle_type, ES.type_exercice, MAX(ES.duree_estime)
FROM TYPE_EXERCICE AS TE
JOIN ESTIMATION AS ES ON TE.type_exercice = ES.type_exercice
WHERE ES.duree_estime = (SELECT MAX(duree_estime) FROM ESTIMATION)
GROUP BY TE.libelle_type, ES.type_exercice;

-- 4
SELECT
  numero_exercice,
  enonce,
  nombre_page,
  type_exercice,
  CASE
    WHEN nombre_page < 2 THEN 'small'
    WHEN nombre_page < 4 THEN 'Medium'
    ELSE 'large'
  END
FROM
  EXERCICE

-- 5
DECLARE @TotalExercices INT;
DECLARE @i INT;

SET @TotalExercises = 0;
SET @i = 1;

WHILE @i <= (SELECT COUNT(*) FROM EXERCICE)
BEGIN
  SET @TotalExercices = @TotalExercices + 1;
  SET @i = @i + 1;
END;

SELECT @TotalExercises AS TotalExercises;

--6
CREATE FUNCTION GetTotalPagesAndCount(
  @TypeExercice varchar(2)
)
RETURNS TABLE
AS
RETURN
(
  SELECT
    SUM(nombre_page) AS TotalPages,
    COUNT(*) AS ExerciseCount
  FROM
    EXERCICE
  WHERE
    type_exercice = @TypeExercice
)


SELECT TotalPages, ExerciseCount
FROM dbo.GetTotalPagesAndCount('C');

-- 7
CREATE PROCEDURE GetExercisesByType
  @TypeExercice varchar(2),
  @ExerciseCount int OUTPUT
AS
BEGIN
  SET NOCOUNT ON

  SELECT *
  FROM EXERCICE
  WHERE type_exercice = @TypeExercice

  SET @ExerciseCount = @@ROWCOUNT
END

DECLARE @Count int

EXEC GetExercisesByType 'P', @ExerciseCount = @Count OUTPUT;

SELECT @Count AS ExerciseCount

-- 8
CREATE TRIGGER trg_estimation_delete
ON ESTIMATION
FOR DELETE
AS
BEGIN
  INSERT INTO DELETED_ESTIMATION (type_exercice, niveau, duree_estime)
  SELECT type_exercice, niveau, duree_estime
  FROM DELETED
END

CREATE TABLE DELETED_ESTIMATION (
  type_exercice VARCHAR(2) NOT NULL,
  niveau VARCHAR(30),
  duree_estime DATETIME,
  -- Additional columns if needed
)

DELETE ESTIMATION WHERE type_exercice = 'P'

SELECT * FROM ESTIMATION
SELECT * FROM DELETED_ESTIMATION
SELECT * FROM TYPE_EXERCICE
SELECT * FROM EXERCICE