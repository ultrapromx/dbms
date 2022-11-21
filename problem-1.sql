-- Create following tables with appropriate constraints like primary key, foreign key, check constrains, not null etc.
--  Account (Acc_no, branch_name, balance) 
--  branch (branch_name, branch_city, assets)
--  customer (cust_name, cust_street, cust_city) 
--  Depositor (cust_name, Acc_no)
--  Loan (loan_no, branch_name, amount) 
-- Borrower (cust_name, loan_no)
-- Solve following query:
-- A. Find all loan numbers for loans made at Akurdi Branch with loan amount > 12000.
--  B. Find all customers who have a loan from bank. Find their names, loan_no and loan amount.
--  C. Find all customers who have an account or loan or both at bank.
--  D. Delete all loans with loan amount between 1300 and 1500.
--  E. Create synonym for customer table as cust. 

SHOW databases;

DROP DATABASE IF exists dbms;

CREATE DATABASE dbms;

USE dbms;

-- Account (Acc_no, branch_name, balance)
CREATE TABLE account(
acc_no int(11) not null unique,
branch_name varchar(20) not null,
balance int not null,
primary key(acc_no));

insert into account values ('101', 'Akurdi', 10000);
insert into account values ('102', 'Akurdi', 15000);
insert into account values ('201', 'Ravet', 5000);
insert into account values ('301', 'Nigdi', 7000);
insert into account values ('302', 'Nigdi', 20000);
insert into account values ('401', 'Pimpri', 4000);

SELECT * FROM account;


--  branch (branch_name, branch_city, assets)
CREATE TABLE branch(
branch_name varchar(20) not null unique,
branch_city varchar(20) not null,
assets int not null,
primary key(branch_name));

insert into branch values ('Akurdi', 'Pune1', 900000);
insert into branch values ('Ravet', 'Pune2', 2100000);
insert into branch values ('Nigdi', 'Pune3', 1700000);
insert into branch values ('Pimpri', 'Pune4', 8000000);

SELECT * FROM branch;


--  customer (cust_name, cust_street, cust_city) 
CREATE TABLE customer(
cust_name varchar(20) not null unique,
cust_street varchar(20) not null,
cust_city varchar(15) not null,
primary key(cust_name));

insert into customer values ('AAA', 'Main', 'Pune1');
insert into customer values ('BBB', 'South', 'Pune2');
insert into customer values ('CCC', 'North', 'Pune3');
insert into customer values ('PPP', 'South', 'Pune4');
insert into customer values ('QQQ', 'Main', 'Pune1');
insert into customer values ('RRR', 'South', 'Pune2');
insert into customer values ('XXX', 'North', 'Pune3');
insert into customer values ('YYY', 'South', 'Pune4');
insert into customer values ('ZZZ', 'Main', 'Pune1');

SELECT * FROM customer;


--  Depositor (cust_name, Acc_no)
CREATE TABLE depositor(
cust_name varchar(20) not null,
acc_no int(11) not null,
primary key(cust_name, acc_no),
foreign key(acc_no) references account(acc_no),
foreign key(cust_name) references customer(cust_name));

insert into depositor values ('AAA','101');
insert into depositor values ('BBB','102');
insert into depositor values ('CCC','201');
insert into depositor values ('PPP','301');
insert into depositor values ('QQQ','302');
insert into depositor values ('RRR','401');

SELECT * from depositor;


--  Loan (loan_no, branch_name, amount)
CREATE TABLE loan(
loan_no int not null unique,
branch_name varchar(20) not null,
amount int not null,
primary key(loan_no),
foreign key(branch_name) references branch(branch_name));

insert into loan values (1111, 'Akurdi', 10000);
insert into loan values (1112, 'Akurdi', 50000);
insert into loan values (2221, 'Ravet', 5000);
insert into loan values (3331, 'Nigdi', 40000);
insert into loan values (3332, 'Nigdi', 30000);
insert into loan values (4441, 'Pimpri', 70000);

SELECT * FROM loan;


-- Borrower (cust_name, loan_no)
CREATE TABLE borrower(
cust_name varchar(20) not null,
loan_no int not null,
primary key(cust_name, loan_no),
foreign key(cust_name) references customer(cust_name),
foreign key(loan_no) references loan(loan_no));

insert into borrower values ('AAA', '1111');
insert into borrower values ('BBB', '1112');
insert into borrower values ('CCC', '2221');
insert into borrower values ('PPP', '3331');
insert into borrower values ('QQQ', '3332');
insert into borrower values ('RRR', '4441');

SELECT * FROM borrower;



-- Solve following query:

-- A. Find all loan numbers for loans made at Akurdi Branch with loan amount > 12000.
SELECT * FROM loan
WHERE branch_name='Akurdi' AND amount > 12000;



--  B. Find all customers who have a loan from bank. Find their names, loan_no and loan amount.
SELECT borrower.cust_name, borrower.loan_no, loan.amount FROM borrower, loan
WHERE loan.loan_no = borrower.loan_no;



--  C. Find all customers who have an account or loan or both at bank.
SELECT borrower.cust_name FROM borrower, loan
WHERE loan.loan_no = borrower.loan_no
UNION
SELECT cust_name FROM depositor;



--  D. Delete all loans with loan amount between 1300 and 1500.
DELETE FROM loan
WHERE amount > 1300 AND amount < 1500;



--  E. Create synonym for customer table as cust.
CREATE SYNONYM cust
FOR dbms.customer;
