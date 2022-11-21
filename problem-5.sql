-- 1. Create following tables
--  emp_mstr (e_mpno, f_name, l_name, m_name, dept, desg, branch_no)
--  branch_master (branch_name, branch_no)
--  contact_details(emp_no, cntc_type, cntc_data)
-- Solve following query:
-- A. List the employee details along with branch names to which they belong
--  B. List the employee details along with contact details using left outer join & right join


-- 2. Create View on borrower table by selecting any two columns and perform insert update
-- delete operations


--  emp_mstr (e_mpno, f_name, l_name, m_name, dept, desg, branch_no)
CREATE TABLE emp_mstr(
emp_no int,
fname varchar(20),
mname varchar(20),
lname varchar(20),
dept varchar(30),
desg varchar(50),
branch_no int
);


--  branch_master (branch_name, branch_no)
CREATE TABLE branch_mstr(
branch_name varchar(20),
branch_no int
);


--  contact_details(emp_no, cntc_type, cntc_data)
CREATE TABLE contact_details(
emp_no int,
cntc_type varchar(30),
cntc_data varchar(50)
);