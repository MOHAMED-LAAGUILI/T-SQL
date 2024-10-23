create database facturation

/**************************************/
create table agence(
numag varchar(15) primary key not null,
nomag varchar(15),
adresseag varchar(15),
telag numeric)
/****************************************/
create table client(
numclt varchar(15) primary key,
nomclt varchar(15),
prnclt varchar(15),
adresseclt varchar(15),
telclt numeric)
/****************************************/
create table produit(
ref varchar(15) primary key,
desig varchar(15),
pu numeric)
/**************************************************************************/
create table facture
(numfact varchar(15),
datfact datetime,
tht numeric,
tva numeric,
ttc numeric,
numclt varchar(15),
numag varchar(15),
primary key (numfact),
foreign key (numclt) references client(numclt),
foreign key (numag) references agence (numag))
/********************************************************/
/**********************************************************/
create table facturer
(numfact varchar(15) ,
ref varchar(15) ,
qtfact numeric ,
mt numeric,
primary key (numfact,ref),
foreign key (numfact) references facture(numfact),
foreign key (ref) references produit(ref))
/*************************************/

/*******************************************************/
insert agence
values('ag001','mohamed5','rabat','0537142563')

insert agence
values('ag002','zerktoun','casa','0522842563')

insert agence
values('ag003','allal abdellah','ksar','0539857485')

insert agence
values('ag004','allal el fassi','fes','0535145285')

insert agence
values('ag005','fatima fihrya','fes','0535468596')
/**********************************************************/
insert client
values('cl001','idriss','mouad','al aouamra','0642294341')
insert client
values('cl002','smaina','imad','grsia','0654857985')
insert client
values('cl003','el gouad','ayoub','ksar','0687546241')
insert client
values('cl004','rami','zakaria','al aouamra','0695867458')
insert client
values('cl005','kasri','mohamed','zouada','0685425681')
/****************************************************************/
insert produit
values('ref001','ecran','700')
insert produit
values('ref002','clavier','30')
insert produit
values('ref003','souris','20')
insert produit
values('ref004','u.c','2500')
insert produit
values('ref005','scaner','1300')
insert produit
values('ref006','disque dur','600')
/***********************************************************************/
insert facture
values('fact001','09/12/2018','2120','424','2544','cl003','ag001')
insert facture
values('fact002','12/07/2018','2500','500','3000','cl001','ag002')
insert facture
values('fact003','01/10/2019','1500','300','1800','cl003','ag001')
insert facture
values('fact004','1/01/2019','2000','400','2400','cl003','ag001')
insert facture
values('fact005','1/01/2019','3200','640','3840','cl002','ag003')
insert facture
values('fact006','03/02/2019','2600','520','3120','cl004','ag005')
insert facture
values('fact007','2/02/2019','2000','400','2400','cl004','ag005')
/**************************************************************************/
select*from facture
/*****************************************************/
insert facturer
values('fact001','ref001','3','2100')
insert facturer
values('fact002','ref003','1','20')
insert facturer
values('fact002','ref004','1','2500')
insert facturer
values('fact003','ref001','2','1400')
insert facturer
values('fact003','ref002','2','60')
insert facturer
values('fact003','ref003','2','40')
insert facturer
values('fact004','ref005','1','1300')
insert facturer
values('fact004','ref006','1','600')
insert facturer
values('fact004','ref003','5','100')
insert facturer
values('fact005','ref001','1','700')
insert facturer
values('fact005','ref004','1','2500')
insert facturer
values('fact006','ref005','2','2600')
insert facturer
values('fact007','ref001','1','700')
insert facturer
values('fact007','ref005','1','1300')
/*******************************************************************/
select *from client
where adresseclt='rabat'
/*******************************************/
select *from client
where adresseclt='rabat' or adresseclt='ksar'
/***************************************************************/
--selectionner les agences qui n'ont effectué aucune facture
select*from agence
where numag not in (select numag from facture)
--selectionner pour chaque agence le nombre de facture effectué
select a.numag,adresseag,telag,count(f.numag)
from agence a,facture f
where a.numag=f.numag
group by a.numag,nomag,adresseag,telag

select *from client
select *from produit

select *from agence

select *from client
select*from facture
select*from facturer


drop table client
drop table produit

drop table agence

drop table client
drop table facture
drop table facturer



-- selectionner les agences qui n'ont avoir / effectuer aucune facture
select * from agence where agence.numag  not in
(Select facture.numag from facture)

-- selctionner pour chaque agence le nombre des facture effectuer
select agence.numag ,agence.nomag ,COUNT(facture.numag) as Nmbr_Fact
from agence, facture
where agence.numag = facture.numag
group by agence.numag, agence.nomag

-- Selectionner les client dagence donner par ex mohamed5
-- sans variable
select distinct c.numclt,c.nomclt,c.prnclt
from client c, agence a, facture f where c.numclt = f.numclt and a.numag = f.numag
and a.nomag = 'mohamed5' 

-- avec variables
declare @nom  varchar(20)  /* = 'mohamed5' */
set @nom = 'mohamed5'
select distinct c.numclt,c.nomclt,c.prnclt
from client c, agence a, facture f where c.numclt = f.numclt and a.numag = f.numag
and a.nomag = @nom

-- selectionner la totale de chaque client
select c.numclt, c.nomclt , sum(f.ttc) as total from client c, facture f
where c.numclt = f.numclt
group by c.numclt, c.nomclt

declare @cltnom  varchar(20)  /* = 'mohamed5' */
set @cltnom = (select COUNT(*) as effectif from client)
print @cltnom


-- 
declare @moy  varchar(20)  
set @moy = (select avg() from client)

select c.numclt, c.nomclt , sum(f.ttc) as total from client c, facture f
where c.numclt = f.numclt
group by c.numclt, c.nomclt
having sum(f.ttc) > @moy
order by c.numclt desc


Declare @nbrclt int
set @nbrclt = (Select Count(*) from client )
print 'Nombres des client effectif : ' + ltrim(str(@nbrclt))

declare @a int
set @a = 2
select @a

-- Declare Table
Declare @stagiaire table
(
 numInsc   int  primary  key,
 nom   varchar(20),
 prenom   varchar(20),
 moyenne  float
)

-- insert into table
insert into @stagiaire values(101,'AHMED','SALAH',14)
insert into @stagiaire values(102,'INASS','ZIYAD',14.5)
insert into @stagiaire values(103,'KARIM','SIDQI',12.5)

UPDATE @stagiaire set moyenne=15.5 where numInsc=102
DELETE FROM @stagiaire WHERE nom='SIDQI'
Select * from @stagiaire



-- insert other table data into this table type
Declare @agence_copy table 
(numag varchar(15) primary key not null,
nomag varchar(15),
adresseag varchar(15),
telag numeric)

insert into @agence_copy select * from agence where adresseag = 'Fes'
select * from @agence_copy


-- Begin & End
/*
Begin
 instruction 1
 instruction 2
 instruction 
End
*/

Begin
Declare @agence_copy table 
(numag varchar(15) primary key not null,
nomag varchar(15),
adresseag varchar(15),
telag numeric)

insert into @agence_copy select * from agence where adresseag = 'Fes'
select * from @agence_copy
End

-------------------------------------------
-- Condition if

Declare @a int
set @a= 5
if(@a>4)
	begin
	print 'HI'
	print 'Hi again'
	End

---------------------------------------------
Declare @nbrclt int
set @nbrclt = (Select Count(*) from client )

if( @nbrclt < 1)
	Begin
	print 'Table empty'
	End
Else
	Begin
	Select * from client
	End

-------------------------------------------
Declare @nbrprdt varchar(50)
Declare @numprdt varchar(50)
set @numprdt = 'ref008'
set @nbrprdt = (Select Count(*) from produit)

if(exists(select * from produit where ref = @numprdt ) and @nbrprdt > 7)
	Begin 
	Delete from facturer where ref = (Select  ref from produit where ref = @numprdt )
	delete from produit where ref = @numprdt
	print 'the client has been deleted successfully'
	End
	
if(not exists(select * from produit where ref = @numprdt ))
	Begin
	print 'No such client exist'
	End
if(not exists(select * from produit where ref = @numprdt ) and @nbrprdt < 7)
	Begin
	print 'and'
	End

if(@nbrprdt < 7)
	Begin
	print 'number of product less than 6'
	End
----------------------------------------------

-- Condition case
/*
Case
	When condition 1 then 
	result
	When condition 2 then 
	result
	When condition 3 then 
	result
	Else
	result
End;
*/
Select * From produit

Select *, 'Categories' = 
	case
		when pu < 40 then 'cat1'
		when pu < 1000 then 'cat2'
		when pu < 2000 then 'cat3'
		Else 'cat4'
	End
From produit
Order by categories


--------------------------
Select * From Agence

Select *, 'Validte' = 
	case adresseag
		when 'casa' then 'Oui'
		when 'ksar' then 'Oui'
		Else 'Non'
	End
From Agence

--------------------------
Select * from  client
Select * from  facture

select client.numclt, client.nomclt, sum(facture.ttc) as total_achat, 'remise' = 
case
	when sum(facture.ttc) < 4000 then 0
	when sum(facture.ttc) between 4000 and 5000 then sum(facture.ttc) * 0.3
	when sum(facture.ttc) < 10000 then sum(facture.ttc) * 0.5
	else sum(facture.ttc) * 0.7
end
from client, facture
where client.numclt = facture.numclt and year(facture.datfact) = 2019
group by client.numclt, client.nomclt
--------------------------------------------------------------


select client.numclt, client.nomclt, sum(facture.ttc) as total_achat, 'Type_Client' = 
case
	when sum(facture.ttc) < 1000 then 'Passager'
	when sum(facture.ttc) between 1000 and 5000 then 'Potentielle'
	else 'Fideil'
end
from client, facture
where client.numclt = facture.numclt
group by client.numclt, client.nomclt

---------------------------------------------------------

select client.numclt, client.nomclt, sum(facture.ttc) as total_achat, 'remise' = 
case
	when sum(facture.ttc) < 4000 then 0
	when sum(facture.ttc) between 4000 and 5000 then sum(facture.ttc) * 0.3
	when sum(facture.ttc) < 10000 then sum(facture.ttc) * 0.5
	else sum(facture.ttc) * 0.7
end,'Type_Client' = 
case
	when sum(facture.ttc) < 1000 then 'Passager'
	when sum(facture.ttc) between 1000 and 5000 then 'Potentielle'
	else 'Fideil'
end
from client, facture
where client.numclt = facture.numclt
group by client.numclt, client.nomclt
------------------------------------------------------


-- LOOP While
/*
	While(condition)
		Begin
		  instruction ou bloc d’instructions
		End
*/

-- factoriel 

Declare @i int, @f int,@n int
select @n=6, @f=1, @i=1

while (@i<=@n)
begin
          set @f=@f*@i
          set @i=@i+1
end
-- Select @f as 'le factoriel'
print 'le factoriel de '+ ltrim(str(@n)) + ' est ' + ltrim(str(@f)) 



Declare @moy float, @val int, @i int,@count int
set @moy = (select * from facture)
set @val = 5000
set @i = 1
set @count = (select count(*) from facture)

	while (@i<@count)
		begin
		if (@moy < @val)
		begin
			update facture set tht = tht + tht * 0.5, tva= tva + tva * 0.5, ttc = ttc + ttc * 0.5
		end
          set @i=@i+1
		end
	print 'Les facture est bien modifier ' + ltrim(str(@i)) + ' fois'
---------------------------------------------------


While((select max(ttc) from facture) <= 10000)
	begin
	update facture set tht = tht + tht * 0.5, tva= tva + tva * 0.5, ttc = ttc + ttc * 0.5
	end
 select max(ttc) as maximum from facture
 -----------------------------------------------------------
 
 /*

  Variables Globale

 */
 select @@version -- Microsoft SQL Server 2005 - 9.00.3077.00 (Intel X86) 

 select @@error
 
 select @@rowcount -- remember last rows shown

 select @@fetch_status 
 --------------------------------------------------------------------

 /*
 procédures stockées simple   --   like function

Create proc ps_Client as
begin
    select * from Clients where IdClient>3
end

--exécution de la procédure

Execute ps_Client or Exec ps_Client

 */


Create proc ps_Fact as
	begin
	select * from facture
	end

-- calling procedure	
Execute ps_Fact

-- dropping procedure
drop proc ps_Fact
--------------------------------------------------------------


Create proc ps_adr as
	begin
	select * from client where adresseclt = 'ksar'
	end
	
Exec ps_adr



/*
 procédures stockées avec des parametre d'entrés (input)
 */
 
 create proc infoClient(@adr varchar(20)) as
   begin
	select * from client where adresseclt = @adr
   end

exec  infoClient 'ksar'

drop proc infoClient

--------------------------------------------

 create proc prdt(@desig varchar(20), @pu Numeric) as
   begin
	select * from produit where desig = @desig and pu = @pu
   end

exec prdt 'ecran',700

drop proc prdt
------------------------------------------------
 create proc prod(@refer varchar(20)) as
  begin
	   if(exists (select ref from produit where ref = @refer))
		begin
		 Delete from facturer where ref = @refer
		 Delete from produit where ref = @refer
		end
	   else
		begin
		 print 'ce produit nexist pas'	   
		end
  end

exec prod 'ref005'

select * from facturer
select * from produit
--------------------------------

/*
 procédures stockées avec des parametre d'entrés(input) et sortie (output)
 */
 
create proc   ps_NbClientsVille2(@ville varchar(20), @nbClients  int output) as
begin
     set @nbClients=(select count(*) from client where adresseclt=@ville)
end


Declare  @nbCli  int
Exec  ps_NbClientsVille2   'al aouamra',  @nbCli output
select   'Le nombre de Clients est:' , @nbCli
-- select   'Le nombre de Clients est: ' + ltrim(str(@nbCli))


------------------------------------------

create proc   ps_total(@nclt varchar(20), @ttc  numeric output) as
begin
      set @ttc=(select SUM(ttc) from facture where numclt=@nclt)
end


Declare  @ttc  numeric
Exec  ps_total  'cl004',  @ttc output
select   'les total d"achat de ce Clients est:' as message  , @ttc as total

drop proc ps_total
select* from facture

---------------------------------------------------------------------------

create proc  cl_exist(@clt varchar(20), @ttc  numeric output) as
begin
      set @ttc=(select SUM(ttc) from facture where numclt=@clt)
end

Declare  @ttc  numeric
Exec cl_exist  'cl004',  @ttc output
if(@ttc > 0)
select   'les total d"achat de ce Clients est:' as message  , @ttc as total
else
print 'le client n exist pas'

-------------------------------------------------------------------------------
create proc  AgVent(@agence varchar(20), @sum  numeric output) as
begin
      set @sum=(select SUM(ttc) from facture where numag=@agence)
end

Declare  @sum  numeric
Exec AgVent  'ag001',  @sum output
if(@sum > 0)
select   'les total d"achat de ce agence est:' as message  , @sum as total
else
print 'l agence n exist pas'

-----------------------------------------------------------------------------

/*
Fonction simple

create function siteEcole()returns varchar(30) as
	begin
		return 'www.miage.com'
	end


	-- calling function
select dbo.siteEcole()
    -- or
print dbo.siteEcole()

-- delete function
Drop function dbo.siteEcole

*/

create function siteEcole() returns varchar(30) as
	begin
		return 'www.miage.com'
	end

-- calling function
select dbo.siteEcole()

-- delete function
Drop function dbo.siteEcole

---------------------------------------------------------
-- fonction
create function nbrClt() returns float as
	begin
		return (select count(*) from client)
	end

select dbo.nbrClt()

-------------------------------------------------------
-- fonction avec parametre d'entree 1

create function Multip(@nbr float) returns float as
	begin
		return @nbr * 2
	end

select dbo.Multip(10)

----------------------------------------------------
-- fonction avec parametre d'entree 2

create function nbrClt2(@adr varchar(30)) returns int as
	begin
		return (select count(*) from client where adresseclt = @adr)
	end

select dbo.nbrClt2('ksar')

----------------------------------------------------
-- fonction avec parametre d'entree 2


create function totalAchat(@nmrclt varchar(30)) returns float as
	begin
		return (select sum(ttc) from facture where numclt = @nmrclt group by numclt)
	end

select dbo.totalAchat('cl003')

----------------------------------------------------
-- fonction avec parametre d'entree 3 de type table

create function TableMulti(@val int) returns @Tab table(a int, x varchar(2), b int,egal varchar(2), c int)
as
begin
declare @i int
set @i=1
while @i <=10
  begin
    insert into @Tab  values(@i,'x', @val,'=', @i*@val)
    set @i=@i+1
  end 
   return 
end   

select * from dbo.TableMulti(5)

---------------------------------------------------
-- fonction avec parametre d'entree 4 de type table
create function cl(@addd varchar(30)) 
returns @tab  Table(
numclt varchar(15) primary key,
nomclt varchar(15),
prnclt varchar(15),
adresseclt varchar(15)) as
	begin
	 insert into @tab select numclt,nomclt,prnclt,adresseclt from client where adresseclt = @addd
	return
	end
select * from dbo.cl('al aouamra')
---------------------------------------------------------------
-- fonction avec parametre d'entree 5 de type table

create function Total_Achat(@numclt varchar(30)) 
returns @tab  Table(
numclt varchar(15) primary key,
nomclt varchar(15),
prnclt varchar(15),
adresseclt varchar(15),
Total numeric) as
begin
	 insert into @tab
	 select client.numclt, client.nomclt, client.prnclt, client.adresseclt, sum(facture.ttc)
	 from client, facture where client.numclt = facture.numclt and facture.numclt = @numclt
	 group by client.numclt, client.nomclt,client.prnclt, client.adresseclt
	return
end

select * from dbo.Total_Achat('cl001')

-----------------------------------------------------------------------------


/*
Les curseurs

DECLARE  cursor_name  CURSOR  FOR  select_statement

OPEN cursor_name
*/

-- create a cursor
DECLARE CurNumClt CURSOR  FOR  select numclt from client


-- open cursor
OPEN CurNumClt0

-- insert cursor values in a variable
DECLARE @Num_Client varchar(30)
FETCH  NEXT from CurNumClt INTO  @Num_Client

-- start executing cursor
WHILE @@FETCH_STATUS = 0
	BEGIN
      print @Num_Client
	  FETCH NEXT  from  CurNumClt Into @Num_Client
	END

-- close cursor
CLOSE CurNumClt

-- delete cursor
DEALLOCATE CurNumClt



-------------------------------------------------------
DECLARE CurNomClt CURSOR  FOR  select numclt,nomclt from client


OPEN CurNomClt
DECLARE @Id_Client varchar(30)
DECLARE @Nom_Client varchar(30)

FETCH  NEXT from CurNomClt INTO  @Id_Client,@Nom_Client

WHILE @@FETCH_STATUS = 0
	BEGIN
      print @Id_Client + ' ' + @Nom_Client
	  FETCH NEXT  from  CurNomClt Into @Id_Client,@Nom_Client
	END

CLOSE CurNomClt

DEALLOCATE CurNomClt

-------------------------------------------------------------

select *from client
select *from produit
select *from agence
select *from client
select*from facture
select*from facturer
------------------------------------------------------

DECLARE CurClt CURSOR  FOR  select numclt from client


OPEN CurClt
DECLARE @Id_Client varchar(30)
DECLARE @Nombr_Clt int
set @Nombr_Clt = 0


FETCH  NEXT from CurClt INTO  @Id_Client

WHILE @@FETCH_STATUS = 0
	BEGIN
      print @Id_Client
	  set @Nombr_Clt = @Nombr_Clt + 1
	  FETCH NEXT  from  CurClt Into @Id_Client
	END

CLOSE CurClt
print 'nombre' + convert(char(5),@Nombr_Clt)


DEALLOCATE CurClt
-----------------------------------------------------------

DECLARE FactClt CURSOR  FOR  select numfact, tht,ttc, numclt from facture where numclt = 'cl003'  


OPEN FactClt
DECLARE @numfact varchar(30)
DECLARE @tht numeric
DECLARE @ttc numeric
DECLARE @numclt varchar(30)


FETCH  NEXT from FactClt INTO  @numfact, @tht,@ttc, @numclt

WHILE @@FETCH_STATUS = 0
	BEGIN
      print  @numclt + ' | ' + @numfact + ' | ' + str(ltrim(@tht)) + ' | ' + str(ltrim(@ttc))
	  FETCH NEXT  from  FactClt Into @numfact, @tht,@ttc, @numclt
	END

CLOSE FactClt
-----------------------------------------------

/*Simple cursor*/

-- Last

DECLARE Cur1  Scroll CURSOR  FOR  select numclt from client

OPEN Cur1
DECLARE @Id_Client varchar(30)

FETCH  Last from Cur1 INTO  @Id_Client
      print @Id_Client
CLOSE Cur1

DEALLOCATE Cur1


-- First

DECLARE Cur2  Scroll CURSOR  FOR  select numclt from client

OPEN Cur2
DECLARE @Id_Client varchar(30)

FETCH  First from Cur2 INTO  @Id_Client
      print @Id_Client
CLOSE Cur2

DEALLOCATE Cur2


-- Absolute

DECLARE Cur3  Scroll CURSOR  FOR  select numclt from client

OPEN Cur3
DECLARE @Id_Client varchar(30)

FETCH  Absolute 2 from Cur3 INTO  @Id_Client
      print @Id_Client
CLOSE Cur3

DEALLOCATE Cur3


-- Prior

DECLARE Cur4  Scroll CURSOR  FOR  select numclt from client

OPEN Cur4
DECLARE @Id_Client varchar(30)

FETCH  Prior from Cur4 INTO  @Id_Client
      print @Id_Client
CLOSE Cur4

DEALLOCATE Cur4

------------------------------------------------------
/*
Trigger 

CREATE TRIGGER TrigerName ON table Name
	Condition Event
        AS
        BEGIN
         -- InstructioN(Action)
        END



// Enable Triger 
Enable TRIGGER TrigerName ON sourcetable 
Enable TRIGGER All ON sourcetable 

// Disable Triger 
Disable TRIGGER TrigerName ON sourcetable 
Disable TRIGGER All ON sourcetable 

// Delete Triger 
Drop TRIGGER TrigerName

//
select * from sys.triggers
 
--- Avant l’exécution  // like an  event listinner


CREATE    TRIGGER     TG_EXEMPLE1     ON     TABLE1
	INSTEAD OF INSERT, UPDATE
        AS
        BEGIN
         -- Instruction …
        END



--- Au moment de l’exécution

		CREATE    TRIGGER     TG_EXEMPLE 2    ON     TABLE1
		 FOR   INSERT,   UPDATE
               AS
               BEGIN
                       -- Instruction …
                END



--- Après  l’exécution

		CREATE    TRIGGER     TG_EXEMPLE     ON     TABLE1
		 AFTER   INSERT, UPDATE
               AS
               BEGIN
                       -- Instruction …
                END


*/
-- INSTEAD OF
-- ex1
create table Coureur
(IdCr   int  primary   key,
 NomCr    varchar(20),
 Age int)

insert into Coureur Values
('1','mohamed',20)
insert into Coureur Values
('2','said',21)
insert into Coureur Values
('3','Laaguili',22)


CREATE TABLE Competition
(IdComp   int    primary  key,
DateComp DATETIME,
Ville   varchar(20),
IdCour int references Coureur(IdCr)) 

INSERT INTO Competition values
('1','22/04/2023','ksar','2')
INSERT INTO Competition values
('2','23/04/2023','ksar','1')
INSERT INTO Competition values
('3','24/04/2023','ksar','1')
INSERT INTO Competition values
('4','25/04/2023','ksar','3')
INSERT INTO Competition values
('5','26/04/2023','ksar','3')



select * from Coureur
select * from Competition

Delete   from  Coureur  where  IdCr=1

CREATE TRIGGER Tg_Sup_Cour ON Coureur
INSTEAD OF DELETE
AS
BEGIN
    DELETE FROM Competition WHERE IdCour = (SELECT IdCr FROM deleted)
    DELETE FROM Coureur WHERE IdCr = (SELECT IdCr FROM deleted)
END      

-----------------------------------------------------

-- INSTEAD OF
-- ex2

CREATE TABLE Competition_Copy
(IdComp   int,
DateComp DATETIME,
Ville   varchar(20),
IdCour int) 

Delete   from  Competition  where  IdComp = 4


CREATE TRIGGER Tg_Ins_Comp ON Competition
INSTEAD OF DELETE
AS
BEGIN
    insert into Competition_Copy select * from  Competition where IdComp = (SELECT IdComp FROM deleted)
	DELETE FROM Competition WHERE IdComp = (SELECT IdComp FROM deleted)
END 


select * from Competition
select * from Competition_Copy

------------------------------------------------------------
-- After
insert into Competition values
('6','26/04/2023','ksar','2')

	CREATE TRIGGER Message_Deleted_Competetion ON Competition
		 AFTER   Insert
               AS
               BEGIN
				   print 'Competition Added Successfully'
                END

----------------------------------------------------------
select * from sys.triggers
--------------------------------------------------------
