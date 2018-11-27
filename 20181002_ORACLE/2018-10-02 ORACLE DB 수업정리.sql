
create table test(
id varchar2(50),
pw number not null
);



select employee_id, last_name, job_id
from employees
where job_id like '%SA\_%' --Escape '\';




사원이름이 'gee' 이거나 'smith' 인 사원의 정보를 얻자
출력결과>사원번호 , 이름, 부서, 직무


select employee_id, last_name, department_id, job_id
from employees
where last_mane in ('Gee', 'Smith');


부서번호가 50,80인 부서원 중 월급이 8000이상인 사원의 정보를 얻자
출력 결과 사원번호 , 이름 , 부서 , 직무

select employee_id, last_name, department_id, job_id
where department_id in ( 50, 80 )
and salary >= 8000;



2005년 입사자 중에서 영업사원이거나 급여를 3000이하를 받는 사원의 정보를 얻자
출력 결과 사원번호 , 이름 , 부서 , 직무


select employee_id, last_name, department_id, job_id
from employees
where hire_date like '%05'
and (job_id like 'SA%'
or salary <=3000);


부서를 발령받지 않은 사원의 정보를 얻자.

select employee_id, last_name, department_id, job_id
from employees
--where department_id is null;
where department_id is not null;


전 사원의 정보를 얻자. (단 월급에 대한 내림차순)

select employee_id, last_name, department_id, job_id
from employees
order by salary desc;


단 부서 id 에 따른 오름차순

select employee_id, last_name, department_id, job_id
from employees
order by department_id;



연습2-4
select last_name, department_id, salary
from employees
where hire_date BETWEEN '2005/02/20' and '2005/05/01'
order by hire_date ;

연습2-5
select last_name, department_id
from employees
where department_id in( 20 , 50)
order by last_name;


2-6
select last_name as Employee, salary as "Monthly Salary"
from employees
where salary between 5000 and 12000
and department_id in ( 20, 50);

2-7
select last_name , hire_date
from employees
where hire_date like '%16';

2-8
select last_name, job_id
from employees
where manager_id is null;

2-9
select last_name, salary, commission_pct
from employees
where commission_pct is not null
order by salary desc, commission_pct desc;

2-10
select last_name
from employees
where last_name like '__a%';

2-11
select last_name
from employees
where last_name like '%a%'
and last_name like '%e%';

2-12
select last_name, job_id, salary
from employees
where (job_id like 'SA%'
or job_id like 'ST%')
and salary not in (2500, 3500, 7000);

2-13
select last_name, salary, commission_pct
from employees
where commission_pct = 0.2;





select 'The job id for' || UPPER(last_name)||' is ' ||LOWER(job_id) as "EMPLOYEE DETAILS"
FROM employees;


select employee_id, last_name, department_id
from employees
where last_name = 'higgins';

select employee_id, last_name, department_id
from employees
where LOWER(last_name) = 'higgins';


select employee_id, concat(first_name, last_name) as NAME,
job_id, LENGTH (last_name), instr(last_name, 'a') as "contains 'a'?"
from employees
where substr(job_id, 4) = 'REP';



select initcap('SQL Course') from dual; 첫글자만 대문자로 변환, 나머지 소문자
select lower('SQL Course') from dual; 소문자
select upper(' 대문자로 '
select concat(concat('Hello','World'),'!') from dual; 문자의 값을 연결
select 'Hello' || 'World' || '!' from dual;

select substr('HelloWorld', -5,3) from dual; 문자를 잘루 추출
select length('HelloWorld') from dual;
select replace('HelloWorld', 'hello','Hi') from dual;



select substr('921017-1483742', 1, 8) || '******' from dual;
select concat(substr('921017-1928374', 1, 8), '******') from dual;
select rpad(substr('921017-1928374', 1,8), 15, '*') from dual;

Nvl, NVL2 ? 함수 보고오기  CF) http://www.gurubee.net/lecture/1880
join 함수 보고오기

select ROUND(45.923,2), ROUND(45.923,0), ROUND(45.923,-1)
from DUAL;

SELECT TRUNC(45.923,2), TRUNC(45.923), TRUNC(45.923,-2)
FROM DUAL;

(스캇 계정 생성
conn /as sysdba
@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\scott.sql
conn scott/TIGER
desc emp;
select * from emp;)


(--JOIN In ora_user2 
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

--OTHER JOIN
select employee.ename, manager.ename as 매니저
from emp employee, emp manager
where employee.mgr = manager.empno(+); --MGR이 NULL인 KING의 값을 도출)
