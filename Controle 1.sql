/*
1- creer base donnee miage
2- creer le tables suivants
Etudiants(#numero, nom, prenom, filier, DateNais, Telephone)
Exames(#numeroExam, #numero, DateExam, Note)
3- inserer 4 enregistrement a la table etudiant et 7 enregistrement a la table exams
4- afficher la list des etudiant de la filiere TS2DI si exist sinon afficher un message (condition if)
5- afficher les information sur les etudiant est leur note de chaque etudiante est la mention enformat suivant (switch case)
  - si la note < 10 la mention non-admis 
  - si la note entre 10 et 11 la mention passable 
  - si la note entre 12 et 14 la mention bien
  - si la note > 14 la mention assez-bien
 6- ajouter +1 pour chaque etudiant tantque la moyenne < 12 (while)
 7- creer un procedure stocke simple qui permet d'afficher la list des etudiants qui l'anne de naissance < 2000 (procedure)
 8- creer un procedure stocke avec de parametre d'entres est note apres afficher les etudiant avec note > ce parameter
 si aucun etudiant afficher un message
 */
 
 --1
 create database miage

 --2
 create table Etudiants
 (Numero varchar(30) primary key not null,
 Nom varchar(30),
 Prenom varchar(30),
 Filier varchar(30),
 DateNaissance datetime,
 Telephone varchar(30))

 create table Exames
 (NumeroExam varchar(30),
 Numero varchar(30),
 DateExam dateTime,
 Note Numeric,
 primary key(NumeroExam),
 Foreign key (Numero) References Etudiants(Numero))

 --3
 insert into Etudiants values
 ('et001','LAAGUILI','Mohamed','Filier','01/04/2001','060000000000')
 insert into Etudiants values
 ('et002','Rossi','Ayman','Filier','20/04/2001','060000000000')
 insert into Etudiants values
 ('et003','El Fels','Khawla','Filier','22/04/2001','060000000000')

 select * from Etudiants

 insert into Exames values
 ('ex001','et001','01/04/2022','17')
insert into Exames values
 ('ex002','et001','02/04/2022','18')
 insert into Exames values
 ('ex003','et002','02/04/2022','14')
 insert into Exames values
 ('ex004','et002','03/04/2022','15')
 insert into Exames values
 ('ex005','et003','03/04/2022','18')

 select * from Exames

 --4
declare @filier varchar(20)
set @filier='Filier'

if(exists(select Filier from Etudiants where Filier = 'Filier'))
	begin
	select * from Etudiants where Filier = @filier
	end
else
	begin 
	print 'no such filier'
	end

--5
select *,'Mention'=
case
	when Note < 10 then 'Non-admis'
	when Note between 10 and 11 then 'Passable'
	when Note between 12 and 14 then 'Bien'
	when Note > 14 then 'Assez-bien'
end
from Exames

--6
declare @moy float 
set @moy = (select avg(note) from Exames)

while (@moy<12)
		begin
			update Exames set Note = Note + 1
		end

Select * from Exames

--7
create proc etd as
begin
 Select * from Etudiants where year(DateNaissance) < '2000'
end

exec etd

--8
create proc EtdNote (@Note float)as
begin
 Select * from Exames where Note = @Note
end

exec EtdNote '17'