부서별 월급의 합, 부서인원을 구해보자
출력 부서id , 월급의 합

select department_id, sum(salary), count(*)
from employees
group by department_id;


5.select	 department_id, avg(salary)
1.from		 employees
2.where		 department_id = 100
3.group by	 department_id
4.having	 avg(salary)>8000
6.order by	 department_id;

5.select
1.from
2.where
3.group by
4.having
6.order by


직무별 급여의 합, 평균, 최대급여, 최소급여를 나타내 보자.
출력 직무 id , 급여의 합

select job_id, sum(salary), avg(salary), max(salary), min(salary)
from employees
group by job_id;

부서번호가 10,20인 부서별 최대 급여를 구하여라
출력 부서번호 최대월급

select department_id, max(salary)
from employees
where department_id in (10, 20)
group by department_id;

--or
select department_id, max(salary)
from employees
group by department_id
having department_id in (10,20);


재고 관련 업무를 담당하고 있는 사원의 월별 입사인원을 구하라
단 인원이 2명 이하인 달은 제외한다.
출력 월 , 입사자수

select job_id,to_char(hire_date, 'MM'), count(*)
from employees
where job_id like 'ST%'
group by to_char(hire_date, 'MM')
having count(*) >2
order by to_char(hire_date, 'MM');

--or 
select job_id, hire_date , count(*)
from employees
where job_id like 'ST%'
group by  hire_date 
having count(*) >2
order by  hire_date ;



부서별 평균 월급을 구하라
단. 부서원이 10명 이상인 부서에 한한다.
출력 부서id , 평균월급, 부서원수

select department_id, avg(salary), count(*)
from employees
group by department_id
having count(*) >= 10 ;



정보처리기사 따자
개발인지 관리인지 정확히 확인하자



--5-1 연습문제
true
false
true
--5-4
select max(salary) Maximum,
 min(salary) Minimun,
 sum(salary) Sum,
 to_char(avg(salary),9999) Average
from employees;

an
select 
round(max(salary),0) Maximum,
 round(min(salary),0) Minimun,
 round(sum(salary),0) Sum,
 round(avg(salary),0) Average
from employees;

--5-5
select job_id,
 round(max(salary),0) Maximum,
  round(min(salary),0) Minimun,
  round(sum(salary),0) Sum,
  round(avg(salary),0) Average
from employees
group by job_id;

--5-6
select job_id, count(*)
from employees
group by job_id;

--5-7
select count (distinct manager_id) as "Number of Manager"
from employees;

--5-8
select max(salary)-min(salary) as "Difference"
from employees;

--5-9
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000
order by min(salary) desc;

--5-10
select
d.department_name "Name",
l.location_id "Location",
count (*) "Number of people",
round(avg(salary),2) "Salary"
from employees e 
join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
group by d.department_name, l.location_id;

*******--5-11
select count(*) as "TOTAL",
	sum(decode(to_char(hire_date,'yyyy'),2005,1,0)) "1995",
	sum(decode(to_char(hire_date,'yyyy'),2006,1,0)) "1996",
	sum(decode(to_char(hire_date,'yyyy'),2007,1,0)) "1997",
	sum(decode(to_char(hire_date,'yyyy'),2008,1,0)) "1998"
from employees;

CASE WHEN THEN ELSE END

*******--5-12
select job_id as "job",
	sum(decode(department_id, 20, salary)) "dept 20",
	sum(decode(department_id, 50, salary)) "dept 50",
	sum(decode(department_id, 80, salary)) "dept 80",
	sum(decode(department_id, 90, salary)) "dept 90",
	sum(salary) "total"
	from employees
	group by job_id;

	
select last_name, job_id
from employees
where job_id =
(select job_id
from employees
where employee_id = 141)
and salary >
(select salary
from employees
where employee_id = 134);


select department_id , min (salary)
from employees
group by department_id
having min(salary)>
(select min(salary)
from employees
where department_id = 50);

평균 급여가 가장 적은 업무를 찾습니다.
select job_id, avg(salary)
from employees
group by job_id
having avg(salary) =
(select min(avg(salary))
from employees
group by job_id);



select employee_id, last_name
from employees
where salary in
(select min(salary)
from employees
group by department_id);


select last_name, department_id, salary
from employees
where salary in
(select min(salary)
from employees
group by department_id)
order by salary;


select employee_id, last_name, job_id, salary
from employees
where salary < any
(select salary
from employees
where job_id = 'IT PROG')
and job_id <> 'IT PROG';


select emp.last_name
from employees emp
where emp.employee_id in
(select mgr.manager_id
from employees mgr);

select last_name
from employees
where employee_id not in
(select manager_id
from employees
where manager_id is not null);



--6-1연습문제
select last_name, hire_date
from employees
where department_id in
	(select department_id
	from employees
	where last_name = 'Zlotkey')
and last_name <> 'Zlotkey';

--6-2
select employee_id, last_name, salary
from employees
where salary >= any
	(select avg(salary)
	from employees)
order by salary;

--6-3
select employee_id, last_name
from employees
where department_id in
	(select department_id
	from employees
	where last_name like '%u%');

--or
select e.employee_id, e.last_name
from employees e, employees u
where u.last_name like '%u%'
and e.last_name = u.last_name;

--6-4
select last_name, department_id, job_id
from employees e join departments d
on e.department_id = d.department_id
where location_id = 1700;

--or
select last_name, department_id, job_id
from employees
where department_id in
	(select department_id
	from departments
	where location_id = 1700);

*****--6-5
select mgr.last_name, mgr.salary
from employees e join employees mgr
on e.employee_id = mgr.manager_id
where mgr.manager_id in
	(select manager_id
	from employees
	where last_name = 'King')
and mgr.last_name <> 'King';

--ans
select last_name, salary
from employees
where manager_id in
	(select employee_id
	from employees
	where last_name = 'King');

--6-6
select e.department_id, e.last_name, e.job_id
from employees e, departments d
where e.department_id = d.department_id
and d.department_name = 'Executive';

--ans
select department_id, last_name, job_id
from employees
where department_id in
	(select department_id
	from departments
	where department_name = 'Executive');

--6-7
select employee_id, last_name, salary
from employees
where department_id in
	(select department_id
	from employees
	where last_name like '%u%')
and salary > any
	(select avg(salary)
	from employees);

conn sys as sysdba
create user aaa identified by aaa;
grant dba to aaa;
drop user aaa cascade;


create table member(
	id varchar2(50) primary key,
	password varchar2(50) not null,
	name varchar2(50) not null,
	address varchar2(50)
	)

drop table member;
delete * from member;


insert into member(id,password, name, address)
values('java','1234','손연재','수서');
insert into member(id,password, name, address)
values('jdbc','abcd','백박사','판교');
insert into member(id,password, name)
values('jsp','king','황정민');
insert into member(id,password, name)
values('sevlet','a','춘포리');


update member set address='신길' where name ='백박사';

delete from member where name = '황정민';


jdbc programming pattern
1.
6.close()
/





