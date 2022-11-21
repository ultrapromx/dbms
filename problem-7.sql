-- 7) Perform Unnamed PL/SQLcode block:
-- 1. Borrower (Roll_no, Name, Date_of_Issue, Name_of_Book, Status)
--  2. Fine (Roll_no, Date, Amt)
--  Accept Roll_no and Name_of_Book from user.
--  Check the number of days (from Date_of_Issue).
--  If days are between 15 to 30 then fine amount will be Rs 5per day.
--  If no. of days>30, per day fine will be Rs 50 per day and for days less than 30, Rs. 5 per day.
--  After submitting the book, status will change from I to R.
--  If condition of fine is true, then details will be stored into fine table.
--  Also handles the exception by named exception handler or user define exception handler. 

show databases;

create database plsql;

use plsql;

CREATE TABLE  borrower(
roll_no int, 
name VARCHAR(25), 
date_of_issue DATE,
name_of_book VARCHAR(25), 
status VARCHAR(20));

CREATE TABLE fine(
roll_no int,
date DATE,
amt int);

INSERT INTO borrower VALUES(1,'ASHUTOSH','2022-08-01','HARRY POTTER','PENDING');
INSERT INTO borrower VALUES(2,'ARYAN','2022-08-10','DARK MATTER','PENDING');
INSERT INTO borrower VALUES(3,'ROHAN','2022-09-05','SILENT HILL','PENDING');
INSERT INTO borrower VALUES(4,'SANKET','2022-09-15','GOD OF WAR','PENDING');
INSERT INTO borrower VALUES(5,'SARTHAK','2022-10-01','SPIDER-MAN','PENDING');


/*
delimiter $
create procedure fine_calculation(IN  rno int, bname varchar(20))
begin
declare i_date date;
declare diff int;
declare fine_amt int;
declare exit handler for sqlexception select 'Table Not Found';
select date_of_issue into i_date from borrower where roll_no=rno and name_of_book=bname;
select datediff(curdate(),i_date) into diff;
if(diff>15 and diff<=30) then
set fine_amt=diff*5;
insert into fine values(rno,curdate(),fine_amt);
elseif(diff>30) then
set fine_amt=15*5 + (diff(diff-30)*50;
insert into fine values(rno,curdate(),fine_amt);
end if;
update borrower set status='RECEIVED' where roll_no=rno and name_of_book=bname;
end;
$
delimiter;

*/







/*
CREATE TABLE  borrower(roll_no NUMBER , name VARCHAR2(25), dateofissue DATE,name_of_book VARCHAR2(25), status VARCHAR2(20));
CREATE TABLE fine(roll_no NUMBER,date_of_return DATE,amt NUMBER);
INSERT INTO borrower VALUES(45,'ASHUTOSH',TO_DATE('01-08-2022','DD-MM-YYYY'),'HARRY POTTER','PENDING');
INSERT INTO borrower VALUES(46,'ARYAN',TO_DATE('15-08-2022','DD-MM-YYYY'),'DARK MATTER','PENDING');
INSERT INTO borrower VALUES(47,'ROHAN',TO_DATE('24-08-2022','DD-MM-YYYY'),'SILENT HILL','PENDING');
INSERT INTO borrower VALUES(48,'SANKET',TO_DATE('26-08-2022','DD-MM-YYYY'),'GOD OF WAR','PENDING');
INSERT INTO borrower VALUES(49,'SARTHAK',TO_DATE('09-09-2022','DD-MM-YYYY'),'SPIDER-MAN','PENDING');
*/



DECLARE 
	i_roll_no NUMBER;
	name_of_book VARCHAR2(25);
	no_of_days NUMBER;
	return_date DATE := TO_DATE(SYSDATE,'DD-MM-YYYY');
	temp NUMBER;
	doi DATE;
	fine NUMBER;
BEGIN
	i_roll_no := &i_roll_no;
	name_of_book := '&nameofbook';
	--dbms_output.put_line(return_date);
	SELECT to_date(borrower.dateofissue,'DD-MM-YYYY') INTO doi FROM borrower WHERE borrower.roll_no = i_roll_no AND borrower.name_of_book = name_of_book;
	no_of_days := return_date-doi;
	dbms_output.put_line(no_of_days);
	IF (no_of_days >15 AND no_of_days <=30) THEN
		fine := 5*no_of_days;
		
	ELSIF (no_of_days>30 ) THEN
		temp := no_of_days-30;
		fine := 150 + temp*50;
	END IF;
	dbms_output.put_line(fine);
	INSERT INTO fine VALUES(i_roll_no,return_date,fine);
	UPDATE borrower SET status = 'RETURNED' WHERE borrower.roll_no = i_roll_no;
	
	
END;
/

/*
-----------------------------------------------INPUT---------------------------------------------------------------------------------------------------------
Enter value for i_roll_no: 46
Enter value for nameofbook: DARK MATTER
---------------------------------------------OUTPUT---------------------------------------------------------------------------------------------------------
BORROWER:
   ROLL_NO              NAME 		     DATEOFISSUE        NAME_OF_BOOK                      STATUS
---------- ------------------------- -------- ---------------------------------------------------------------
	45      ASHUTOSH		     01-08-22           HARRY POTTER                      PENDING
	46      ARYAN		             15-08-22           DARK MATTER                       RETURNED
	47      ROHAN		             24-08-22           SILENT HILL                       PENDING
        48      SANKET		             26-08-22           GOD OF WAR                        PENDING
	49      SARTHAK		             09-09-22           SPIDER-MAN                        PENDING
        
---------------------------------------------------------------------------------------------------------------------------------------------------------
FINE:
   ROLL_NO DATEOFRE	AMOUNT
---------- -------- ----------
	46 14-09-22	   150
`````````````````````````````````````````````````````````````````INPUT``````````````````````````````````````````````````````````````````````````````````````````
Enter value for i_roll_no: 45
Enter value for nameofbook: HARRY POTTER
---------------------------------------------------------------OUTPUT--------------------------------------------------------------------------------------------------------
BORROWER:
   ROLL_NO NAME 		     DATEOFIS   NAME_OF_BOOK      STATUS
---------- ------------------------- -------- ---------------------------------------------
	45 ASHUTOSH		     01-08-22   HARRY POTTER      RETURNED
	46 ARYAN		     15-08-22   DARK MATTER       RETURNED
	47 ROHAN		     24-08-22   SILENT HILL       PENDING
	48 SANKET		     26-08-22   GOD OF WAR        PENDING
	49 SARTHAK		     09-09-22   SPIDER-MAN        PENDING
`````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````
FINE:
   ROLL_NO DATEOFRE	AMOUNT
---------- -------- ----------
	46 14-09-22	   150
	45 14-09-22	   850