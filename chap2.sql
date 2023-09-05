---------Sorting Query Results
--2.1 Returning Query Results in a Specified Order
--**note: by default ORDER BY (ascending ASC), else descending DESC
select ename, job, sal 
from emp
where deptno = 10
order by sal;

--instead of specify the column name, can use the number representing the column corresponding with the SELECT statement
select ename, job, sal
from emp
where deptno = 10
order by 3 DESC;

--2.2 Sorting by Multiple Fields
select * from emp
where deptno = 10
order by deptno ASC, sal DESC;

--2.3 Sorting by Substrings
SELECT ename,job from emp 
order by substr(job,LENGTH(job)-1)


--2.4 Sorting Mixed Alphanumeric Data




--2.5 Dealing with Nulls When Sorting

SELECT	ename, sal, comm
from emp
order by comm;

--**note: using ORDER BY will also sort the value with NULL ascending automatically. 
--**However, can use CASE to to conditionally sort the column and to sort non-NULL values in ascending or descending order and all NULL values last

SELECT ename, sal, comm, is_null
from 
	(select ename, sal, comm,
            case when comm is NULL then 0 else 1 
            end as is_null
       from emp) x 
ORDER by is_null DESC, comm DESC;

    
--2.6 Sorting on a Data-Dependent Key
--**note: CASE WHEN can be used in ORDER BY clause

Select ename, sal, job, comm
FROM emp
order by case when job = 'SALESMAN' then comm else sal end;
