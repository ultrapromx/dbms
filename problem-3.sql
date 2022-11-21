-- Create following tables with appropriate constraints like primary key, foreign key, check
-- constrains, not null etc.
--  Account (Acc_no, branch_name, balance) 
--  branch (branch_name, branch_city, assets)
--  customer (cust_name, cust_street, cust_city) 
--  Depositor (cust_name, Acc_no)
--  Loan (loan_no, branch_name, amount) 
--  Borrower (cust_name, loan_no)
-- Solve following query:
-- A. List all customers in alphabetical order who have loan from Akurdi branch.
--  B. Find all customer who have account but no loan at the bank.
--  C. Find average account balance at Akurdi branch.
--  D. Find no. of depositors at each branch.
--  E. Find the branches where average account balance > 12000. 

SHOW databases;

USE dbms;

-- A. List all customers in alphabetical order who have loan from Akurdi branch.
SELECT borrower.cust_name, loan.branch_name FROM borrower, loan
WHERE loan.loan_no = borrower.loan_no AND loan.branch_name='Akurdi'
ORDER BY borrower.cust_name;


--  B. Find all customer who have account but no loan at the bank.


--  C. Find average account balance at Akurdi branch.
SELECT AVG(acc_no) FROM account
WHERE account.branch_name = 'Akurdi';


--  D. Find no. of depositors at each branch.
SELECT branch_name, COUNT(branch_name) FROM account
GROUP BY branch_name;

--  E. Find the branches where average account balance > 12000. 
SELECT DISTINCT branch_name FROM account
GROUP BY branch_name
HAVING AVG(balance)>12000;