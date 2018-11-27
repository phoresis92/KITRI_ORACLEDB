오라클 자체 join 문법 : 다른 db에서 사용불가
ansi join 문법 : db 공통 문법 (natural join)

--JOIN In ora_user2 
--CROSS JOIN = cartesian product 
SELECT s.*, e.*
FROM STUDENT S
cross join enrol e;

SELECT s.*, e.*
FROM STUDENT S, enrol e;


A={1,2}
B={a,b,c}

A JOIN B
{1,a} , {1,b} , {1,c},
{2,a} , {2,b} , {2,c}



--NATURAL JOIN
SELECT departmnet_id, department_name, location_id, city
FROM departments
NATURAL JOIN locations
where department_id in (20,50);

select deptno, dname, loc
from emp
natural join dept
where deptno in (20,30); --equl join 과 같음/ 하나의 컬럼이 같은 조건

select e.employee_id, e.last_name, d.location_id
from employees e join departments d
using (department_id); --uon equl join 과 같음/ JOIN 과 USING 사용

SELECT e.employee_id, e.last_name, e.department_id,
		d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id); -- equal join

select e.last_name emp, m.last_name mgr
from employees e join employees m
on (e.manager_id = m.employee_id); -- JOIN 과 ON 사용

select employee_id, city, department_name
from employees e
join departments d
on d.department_id = e.department_id
join locations l
on d.location_id = l.location_id; -- ON 절로 3WAY조인 작성

SELECT e.employee_id, e.last_name, e.department_id,
	d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id)
and e.manager_id = 149; -- AND 추가조건

--equl join
select ename, dname
from emp, dept
where emp.deptno = dept.deptno;

-- non equl join
SELECT ename, sal, grade
from emp, salgrade
where emp.sal>=salgrade.losal
and emp.sal<=salgrade.hisal
order by grade desc;

select ename, sal, grade
from emp, salgrade
where emp.sal between salgrade.losal and salgrade.hisal
order by grade desc;

-- equl & non equl join mix Exam
select ename, dname, sal, grade
from emp, dept, salgrade
where emp.deptno = dept.deptno
and emp.sal between salgrade.losal and salgrade.hisal;

-- SELF JOIN
select employee.ename, manager.ename,employee.mgr
from emp employee, emp manager
where employee.mgr = manager.empno;

select e.last_name|| '  works for   ' || em.last_name
from employees e, employees em
where e.manager_id = em.employee_id(+);

--Outer JOIN
select employee.ename, manager.ename as 매니저
from emp employee, emp manager
where employee.mgr = manager.empno(+); --MGR이 NULL인 KING의 값을 도출

SELECT e.last_name, e.department_id, d.department_name
from employees e
left outer join departments d -- LEFT OUTER JOIN
on (e.department_id = d.department_id);-- (LEFT, RIGHT, FULL)

-null값이 없는 쪽에 (+)를 붙여야 한다.


==========================================================================


--set 연산 ( 집합 )
-컬럼 타입이 같아야한다
union : 합집합 : 2개 qurey 결과 합침 : 중복 데이터 1번
----------
	----------
--------------	<결과값

union all : 합집합 : 2개 query 결과 합침 : 중복 데이터 여러번
----------
	----------
--------------	<결과값
	------		<결과값
	
intersect : 교집합 : 2개 query 공통 나타나는 결과
----------
	----------
	------		<결과값

minus : 차집합 : 2개 query. 첫번째 query 만족, 두번째 query 불만족
----------
	----------
----			<결과값

--example
select first_name, last_name, hire_date, department_id
from employees
where hire_date <= '06/12/31'

intersect

select first_name, last_name, hire_date, department_id
from employees
where department_id in (50, 80, 100)

order by department_id
