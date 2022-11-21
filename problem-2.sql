-- Create following tables with appropriate constraints like primary key, foreign key, check constrains,
-- not null etc.
--  Account (Acc_no, branch_name, balance) 
--  branch (branch_name, branch_city, assets)
--  customer (cust_name, cust_street, cust_city) 
--  Depositor (cust_name, Acc_no)
--  Loan (loan_no, branch_name, amount) 
--  Borrower (cust_name, loan_no)
-- Solve following query:
-- A. Find the names of all branches in loan relation.
--  B. List all customers in alphabetical order who have loan from Akurdi branch.
--  C. Find all customers who have both account and loan at bank.
--  D. Find the average account balance at each branch
--  E. Delete all tuples at every branch located in Nigdi. 

SHOW databases;

USE dbms;

-- A. Find the names of all branches in loan relation.
SELECT DISTINCT branch_name FROM loan;


--  B. List all customers in alphabetical order who have loan from Akurdi branch.
SELECT borrower.cust_name, loan.branch_name FROM borrower, loan
WHERE loan.loan_no = borrower.loan_no AND loan.branch_name='Akurdi'
ORDER BY borrower.cust_name;


--  C. Find all customers who have both account and loan at bank.
SELECT borrower.cust_name FROM borrower, loan
WHERE loan.loan_no = borrower.loan_no && borrower.cust_name IN (SELECT cust_name FROM depositor);


--  D. Find the average account balance at each branch
SELECT branch_name, AVG(balance) FROM account
GROUP BY branch_name;


--  E. Delete all tuples at every branch located in Nigdi. 
DELETE FROM branch
-- WHERE branch_name = 'Pune3';
WHERE branch_name = 'Pune3';