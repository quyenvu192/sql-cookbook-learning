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

--using INTERSECT with INdemo

Select empno, ename, job, sal, deptno
	from emp
   where (ename, job, sal) in 
   	(select ename, job, sal from emp
   INTERSECT
   	select ename, job, sal from v);

--3.4 Retrieving Values from One Table That Do Not Exist in Another











--3.5 Retrieving Rows from One Table That Do Not Correspond to Rows in Another
--3.6 Adding Joins to a Query Without Interfering wit Other Joinsdemo
--3.7 Determining Whether Two Tables Have the Same Data
--3.8 Identifying and Avoiding Cartesian Products
--3.9 Performing Joins When Using Aggregates
--3.10 Performing Outer Joins When Using Aggregates
--3.11 Returning Missing Data from Multiple Tables
--3.12 Using NULLs in Operations and Comparisons
