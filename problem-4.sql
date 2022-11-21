-- 1. Create following tables
--  customer_master (cust_no, fname, lname)
--  address_details (cust_no, add1, add2, state, city, pincode)
--  acc_fixdeposite_cust_details (custno, acc_fd_no)
--  fixdeposite_dets(fd_sr_no, amt)
-- Solve following query:
-- A. Retrieve the address of customer whose Fname as 'xyz' and Lname as 'pqr'
-- B. List the customer holding fixed deposit of amount more than 5000

-- 2. Create View on borrower table by selecting any two columns and perform insert update
-- delete operations


-- 1. Create following tables

--  customer_master (cust_no, fname, lname)
CREATE TABLE customer_master(
cust_no int primary key,
fname varchar(20),
lname varchar(20));

Insert into customer_master values(1, 'xyz', 'pqr');
Insert into customer_master values(2, 'abc', 'omg');
Insert into customer_master values(3, 'lmn', 'wtf');

SELECT * FROM customer_master;


--  address_details (cust_no, add1, add2, state, city, pincode)
create table address_details(
cust_no int primary key,
add1 varchar(50),
add2 varchar(50),
state varchar(20),
city varchar(20),
pincode int
);

insert into address_details values(1, 'add11', 'add21', 'Maharashtra', 'Pune', 411033);
insert into address_details values(2, 'add12', 'add22', 'Maharashtra', 'Pune', 411044);
insert into address_details values(3, 'add13', 'add23', 'Maharashtra', 'Pune', 411055);

SELECT * FROM address_details;


-- A. Retrieve the address of customer whose Fname as 'xyz' and Lname as 'pqr'
SELECT * FROM address_details
WHERE address_details.cust_no = (SELECT cust_no from customer_master where fname="xyz" and lname="pqr");


--  fixdeposite_dets(fd_sr_no, amt)
CREATE TABLE fd_details(
acc_fd_no int primary key,
amount int
);

INSERT INTO fd_details values(111, 10000);
INSERT INTO fd_details values(222, 30000);

SELECT * FROM fd_details;


--  acc_fixdeposite_cust_details (cust_no, acc_fd_no)
CREATE TABLE acc_fd_cust_details(
cust_no int,
acc_fd_no int,
foreign key(cust_no) references customer_master(cust_no),
foreign key(acc_fd_no) references fd_details(acc_fd_no));

insert into acc_fd_cust_details values(1, 111);
insert into acc_fd_cust_details values(2, 222);

SELECT * FROM acc_fd_cust_details;

-- B. List the customer holding fixed deposit of amount more than 5000
SELECT * FROM customer_master
JOIN fd_details ON acc_fd_cust_details.cust_no = customer_master.cust_no
JOIN fd_details ON acc_fd_cust_details.acc_fd_no = fd_details.acc_fd_no
WHERE amount>5000;



-- 2. Create View on borrower table by selecting any two columns and perform insert update
-- delete operations

create table borrowertab(
 cust_no int,
 fname varchar(20),
 account_no int,
 loan int
);
SELECT * FROM borrower;
-- create table depositortab( 
-- custNo int,
--  branchname varchar(20),
--  accountNo int,
--  amount int
-- );
insert into borrowertab values (1,'aaa', 431506,8000);
insert into borrowertab values (2,'bbb', 431507,1000);
insert into borrowertab values (3,'ccc', 431508,5000);
insert into borrowertab values (4,'ddd',431504,17000);

 create view newtable2
 as select Fname,loan
 from borrowertab;
 
 select*from newtable2;
 
 update newtable2 set Fname="zzz" where Fname="aaa";





