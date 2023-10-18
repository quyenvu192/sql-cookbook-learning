--3.1 Stacking One Rowset atop Another
SELECT ename as ename_dname, deptno
from emp
where deptno = 10
UNION ALL
Select dname, deptno
From dept;

--*note: column in UNION ALL must match in number and data typedemo

SELECT deptno from emp
UNION ALL
SELECT deptno from dept; --Using UNION ALL in this case will append all deptno from both table
    		   --Including duplicates --> can use UNION just to get DISTINCT list of value

SELECT deptno from emp
UNION
SELECT deptno from dept;


--3.2 Combining Related Rows

select e.ename, d.loc
from emp e, dept d
where e.deptno = d.deptno
	and d.deptno = 10;
    
--using INNER JOIN:

select e.ename, d.loc
from emp e INNER JOIN dept d
	ON (e.deptno = d.deptno)
WHERE e.deptno = 10;

--3.3 Finding Rows in Common Between Two Tables

create view V
as 
select ename, job,sal
	from emp
   where job = 'CLERK';

select * from V;

select e.empno, e.ename, e.deptno, v.ename, v.job, v.sal
from emp e INNER JOIN V v
	ON (e.ename = v.ename
       AND e.job = v.job
       AND e.sal = v.sal);

--using INTERSECT with IN

Select empno, ename, job, sal, deptno
	from emp
   where (ename, job, sal) in 
   	(select ename, job, sal from emp
   INTERSECT
   	select ename, job, sal from v);

--3.4 Retrieving Values from One Table That Do Not Exist in Another

SELECT deptno
	from dept
EXCEPT
SELECT deptno
	from emp; --> act similar to substract (upper query - lower query)
              --> return 40 --> there is no employee in deptno 40 yet
    
SELECT deptno from emp
EXCEPT
select deptno from dept --> double check if there is any Department number that not exist in DEPT table 
                        --> return null
                        
--ALTERNATIVE using NOT IN
select deptno
from dept
where deptno not in (select deptno from emp);

--note when using NOT IN with nulls value

create table new_dept(deptno integer);
insert into new_dept values (10);
insert into new_dept values (50);
insert into new_dept values (null);

select deptno
from dept
where deptno NOT IN (SELECT deptno from new_dept) --> returns null because (NOT) IN performs like OR logical
												  --> to prevent this --> using NOT EXISTS instead
                                                  
Select d.deptno
	from dept d
  where not EXISTS (select 1 from new_dept nd where d.deptno = nd.deptno);
   

--3.5 Retrieving Rows from One Table That Do Not Correspond to Rows in Another

select d.*
FROM dept d left OUTER JOIN emp e --keyword OUTER is optional
	on (d.deptno = e.deptno)
where e.deptno is NULL;

--*note: using outer join to keep only rows that have no match
--breakdown solution: Using LEFT OUTER JOIN without filtering NULLdemo

select e.ename, e.deptno as emp_deptno, d.*
from dept d LEFT JOIN emp e
	on (d.deptno = e.deptno);

--SMITH 20 20 RESEARCH DALLAS
--ALLEN 30 30 SALES CHICAGO
--WARD 30 30 SALES CHICAGO
--JONES 20 20 RESEARCH DALLAS
--MARTIN 30 30 SALES CHICAGO
--BLAKE 30 30 SALES CHICAGO
--CLARK 10 10 ACCOUNTING NEW YORK
--SCOTT 20 20 RESEARCH DALLAS
--KING 10 10 ACCOUNTING NEW YORK
--TURNER 30 30 SALES CHICAGO
--ADAMS 20 20 RESEARCH DALLAS
--JAMES 30 30 SALES CHICAGO
--FORD 20 20 RESEARCH DALLAS
--MILLER 10 10 ACCOUNTING NEW YORK
--NULL  NULL 40 OPERATIONS BOSTON --> filtering this row to get the result (null value due to no employee working in dept 40
								  --> meaning no match between emp table and dept table

--3.6 Adding Joins to a Query Without Interfering wit Other Joins

SELECT e.ename,d.loc, b.received
from dept d, emp e, emp_bonus b
	where d.deptno = e.deptno
    	and e.empno = b.empno; --> using this query will not return all emp entries, but only those who has bonus

-->using OUTER JOIN to retrieve all data 

select e.ename, d.loc, b.received
	from emp e JOIN dept d
    	ON (e.deptno = d.deptno)
    left JOIN emp_bonus b
    	on (e.empno = b.empno)
    order BY 3;

--alternative: using scalar subquery 

select e.ename,d.loc, (select b.received from emp_bonus b where e.empno = b.empno) as received_column
  from emp e, dept d 
  where e.deptno = d.deptno
  order by 3;
    	


--3.7 Determining Whether Two Tables Have the Same Data
--3.8 Identifying and Avoiding Cartesian Products
--3.9 Performing Joins When Using Aggregates
--3.10 Performing Outer Joins When Using Aggregates
--3.11 Returning Missing Data from Multiple Tables
--3.12 Using NULLs in Operations and Comparisons
