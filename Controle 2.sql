/*
Exemple Controle 2

I-
	1- Creez la base donnees Traitement_commande et la relation
	2- insert les donnes
	3- selection les commande qui ont la date de commande inferieur '09/03/2017' 

II-
	
*/


CREATE DATABASE Traitement_commande

CREATE TABLE PRODUIT
(CodePdt varchar(30) PRIMARY KEY,
Designation varchar(30),
PrixUnit FLOAT,
TauxTVA FLOAT)

CREATE TABLE CLIENT
(CodeClt varchar(30) PRIMARY KEY,
Nom varchar(30),
Adresse varchar(30))

CREATE TABLE COMMANDE
(NumCDE varchar(30) PRIMARY KEY,
CodeClt varchar(30),
DateCDE DATETIME,
TotalHT FLOAT,
FOREIGN KEY (CodeClt) references CLIENT (CodeClt))

CREATE TABLE LIGNE_CDE
(CodePdt varchar(30),
NumCDE varchar(30),
Quantite int,
Montant FLOAT,
PRIMARY KEY(CodePdt, NumCDE),
FOREIGN KEY (CodePdt) references PRODUIT (CodePdt))


select * from PRODUIT
select * from CLIENT
select * from COMMANDE
select * from LIGNE_CDE


insert into PRODUIT values
('1','Fromage',1500.00,0.20)
insert into PRODUIT values
('2','Fruits secs',700.00,0.20)
insert into PRODUIT values
('3','Lait',1450.00,0.20)
insert into PRODUIT values
('4','Lait fermenté',1930.00,0.20)
insert into PRODUIT values
('5','Beurres',1850.00,0.20)


insert into CLIENT values
('1','Faouzi','Rabat')
insert into CLIENT values
('2','Amzil','Ksar')
insert into CLIENT values
('3','Daoudi','Kénitra')
insert into CLIENT values
('4','Badraoui','Fés')


insert into COMMANDE values
('1','3','09/02/2017',7400.00)
insert into COMMANDE values
('2','2','11/04/2017',3780.00)
insert into COMMANDE values
('3','4','15/04/2017',8100.00)
insert into COMMANDE values
('4','1','18/05/2017',5150.00)


insert into LIGNE_CDE values
('1','1','3',4500.00)
insert into LIGNE_CDE values
('1','3','4',6000.00)
insert into LIGNE_CDE values
('2','3','3',2100.00)
insert into LIGNE_CDE values
('3','1','2',2900.00)
insert into LIGNE_CDE values
('3','4','1',1450.00)
insert into LIGNE_CDE values
('4','2','1',1930.00)
insert into LIGNE_CDE values
('5','2','1',1850.00)
insert into LIGNE_CDE values
('5','4','2',3700.00)

-- 1
select * from COMMANDE where DateCDE <= '09/03/2017' 

-- 2
select * from COMMANDE where CodeClt = '3'

-- 3
declare @max float
set @max = (select max(PrixUnit) from PRODUIT)
select * from PRODUIT where PrixUnit = @max

-- 4
select NumCDE ,count(CodePdt) as nbr_PRDT from LIGNE_CDE 
Group by NumCDE
HAVING count(CodePdt) > 1

-- 5
create procedure CLT(@codecl varchar(30)) as
begin
	if(exists(select CodeClt from CLIENT where CodeClt = @codecl))
	BEGIN
	 Delete COMMANDE WHERE CodeClt = @codecl
	 Delete CLIENT where CodeClt = @codecl
	END
	else
	 print'No such client code'
end

drop proc CLT
exec CLT '3'

-- 6





-- 7
Create Function ClientNB_Cmd (@nbrcmd int) returns @clientTable
	Table(Num varchar(30), Nom varchar(30), Adresse varchar(30), Nbrcmd int)as
		begin
			insert into @clientTable select CLIENT.CodeClt, Nom, Adresse, COUNT(COMMANDE.NumCDE) as NbrCmd
			from CLIENT, COMMANDE 
			where COMMANDE.CodeClt = CLIENT.CodeClt
			group by CLIENT.CodeClt, Nom, Adresse 
			Having Count(COMMANDE.NumCDE) = @nbrcmd
			return
		end

select * from ClientNB_Cmd (1)
drop function ClientNB_Cmd


-- 8
Create proc CltNB_Cmd(@nomclt varchar(30),@NbrCMD int output)as
	begin
	set @NbrCMD = (select Count(COMMANDE.NumCDE) from COMMANDE, CLIENT 
	where COMMANDE.CodeClt = CLIENT.CodeClt and Nom = @nomclt
	group by CLIENT.CodeClt, CLIENT.Nom)
	end

declare @nbrcmd int
exec CltNB_Cmd 'Amzil', @nbrcmd output
select @nbrcmd as Nombre_Commande