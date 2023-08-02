--1.1 Retrieving All Rows and Columns from a Table
SELECT * FROM emp
WHERE deptno = 10;


--1.2 Retrieving a Subset of Rows from a Table
SELECT * FROM emp
WHERE deptno = 10;


--1.3 Finding Rows That Satisfy Multiple Conditions
SELECT * from emp
where deptno = 10 
	or comm is not NULL
	or deptno = 20 and sal <= 2000;
    
 
 --1.4 Retrieving a Subset of Columns from a Table
select ename, deptno, sal
from emp;


--1.5 Providing Meaningful Names for Columns
select ename as name, deptno as department_number, sal as salary, comm as commission
from emp;


--1.6 Referencing an Aliased Column in the WHERE Clause
 --**note: inline view is needed because processing order (FROM --> WHERE --> SELECT)
select * 
FROM (
  select ename as employee_name, sal as salary, comm as commission
  from emp) x
where salary < 5000;

 

--1.7 Concatenating Column Values
--**note: using built-in fuction
--MySQL: concat(ename, ' WORKS AS A ',job) as concatenate_column
--SQL server: using + operator (ename + ' WORKS AS A '+ job as concatenate_column)
--Postgre: double vertical bar || as concatenation operator)

select ename||' WORKS AS A ' ||job as concatenate_comlumn
from emp
where deptno = 10;


--1.8 Using Conditional Logic in a SELECT Statement
select ename, sal,
	case when sal <=2000 then 'UNDERPAID'
    	when sal >=4000 then 'OVERPAID'
    	else 'OK'
    END as criteria_column
from emp;




--1.9 Limiting the Number of Rows Returned


--1.10 Returning n Random Records from a Table


--1.11 Finding Null Values


--1.12 Transforming Nulls into Real Values


--1.13 Searching for Patterns








