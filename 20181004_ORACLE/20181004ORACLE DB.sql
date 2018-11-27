
오늘과 2007년 1월 1일간의 개월 수는?

SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2007-01-01','yyyy,mm,dd'))
FROM dual;


오늘 날짜에 1년을 더해보자

SELECT ADD_MONTHS(SYSDATE,12)
FROM dual;

SELECT SYSDATE + TO_YMINTERVAL('01-00')
FROM dual;


--sql vol1_144
SELECT employee_id, hire_date, months_between(sysdate, hire_date) tenure,
add_months(hire_date, 6), next_day(hire_date, 'FRIDAY'), last_day(hire_date)
from employees
where months_between(sysdate,hire_date) <36;

--145
SELECT employee_id, hire_date, round(hire_date, 'month'), trunc(hire_date,'month')
from employees
where hire_date like '%05';



select employee_id, to_char(hire_date, 'mm-yy') as month_hired
from employees;

select last_name,
salary, nvl(commission_pct,0) as commi,
salary + salary * nvl(commission_pct, 0) as an_sal
from employees;

select last_name, job_id, salary,
	case job_id when 'IT_PROG'	then 1.10*salary
				when 'ST_CLERK' THEN 1.15*salary
				when 'SA_REP'	THEN 1.20*salary
		ELSE salary END "revised_salary"
from employees;


SELECT last_name, job_id, salary,
	decode(job_id, 	'IT_PROG', 	1.10*salary,
					'ST_CLERK', 1.15*salary,
					'SA_REP',	1.20*salary,
			salary) as revised_salary
FROM employees;

select last_name, salary,
	decode (trunc(salary/2000, 0),
					0, 0.00,
					1, 0.09,
					2, 0.20,
					3, 0.30,
					4, 0.40,
					5, 0.50,
					6, 0.44,
						0.45) as tax
from employees;



select e.employee_id, e.last_name, e.department_id
d.department_id, d.location_id
from employees e, department d
where e.department_id, d.department_id;


select last_name, d.department_id, l.location_id, city
from employees e, departments d, locations l
where e.department_id= d.department_id
and d.location_id=l.location_id;


select e.last_name|| '  works for   ' || em.last_name
from employees e, employees em
where e.manager_id = em.employee_id(+);



select e.employee_id, e.last_name, d.location_id
from employees e join departments d
using (department_id);


SELECT e.employee_id, e.last_name, e.department_id,
		d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id);

select e.last_name emp, m.last_name mgr
from employees e join employees m
on (e.manager_id = m.employee_id);

자료구조 알고리즘 중요

--SQL VOL1_219
등가조인: 자연/내부 조인
포괄조인: 왼쪽 포괄 조인
자체조인: JOIN ON
비등가조인: JOIN USING
카티시안 곱: 교차 조인


SELECT e.employee_id, e.last_name, e.department_id,
	d.department_id, d.location_id
from employees e join departments d
on (e.department_id = d.department_id)
and e.manager_id = 149;


--연습4-1
SELECT last_name, e.department_id, department_name
from employees e , departments d
where e.department_id = d.department_id;

select last_name, e.department_id, department_name
from employees e join departments d 
on (e.department_id = d.department_id);

select last_name, department_id, department_name
from employees e 
natural join departments d 

--4-2
select distinct job_id, location_id
from  employees e , departments d
where e.department_id = d.department_id
and e.department_id = 80;

--4-3
select e.last_name, d.department_name, l.location_id, l.city
from employees e, locations l, departments d 
where e.department_id = d.department_id
and d.location_id = l.location_id
and commission_pct is not null;

--4-4
select last_name, department_name
from employees e, departments d
where e.department_id = d.department_id
and last_name like '%a%';

--4-5
select last_name ,job_id, e.department_id, department_name
from employees e 
join departments d 
on (e.department_id = d.department_id)
join locations l 
on (d.location_id = l.location_id)
where lower(l.city) ='toronto';

--4-6
select	e.last_name 		as employeee,
		e.employee_id 		as EMP# ,
		em.last_name 		as Manager,
		em.employee_id 		as Mgr#
from employees e join employees em
on (e.manager_id = em.employee_id);


--4-7
select	e.last_name 		as employeee,
		e.employee_id 		as EMP# ,
		em.last_name 		as Manager,
		em.employee_id 		as Mgr#
from employees e 
left outer join employees em
on (e.manager_id = em.employee_id)
order by employee_id asc;

select	e.last_name 		as employeee,
		e.employee_id 		as EMP# ,
		em.last_name 		as Manager,
		em.employee_id 		as Mgr#
from employees e , employees em
WHERE e.manager_id = em.employee_id(+);


--4-8
SELECT e.department_id department, e.last_name employee,
c.last_name colleague
from employees e join employees c
on (e.department_id = c.department_id)
where e.employee_id <> c. employee_id
order by e.department_id, e.last_name, c.last_name;

--4-9
desc job_grades
select e.last_name, e.job_id, d.department_name,
e.salary, j.grade_level
from employees e, departments d, job_grades j
where e.department_id = d.department_id
and e.salary between j.lowest_sal and j.highest_sal;

--or 
select e.last_name, e.job_id, d.department_name,
e.salary, j.grade_level
from employees e join departments d 
on (e.department_id = d.department_id)
join job_grades j 
on (e.salary between j.lowest_sal and j.highest_sal);

--4-10
select e.last_name, e.hire_date
from employees e, employees davies
where davies.last_name = 'Davies'
and davies.hire_date <e.hire_date

--or
select e.last_name, e.hire_date
from employees e join employees davies
on (davies.last_name = 'Davies')
where davies.hire_date < e.hire_date;


--4-11
select w.last_name, w.hire_date, m.last_name, m.hire_date
from employees w, employees m 
where w.manager_id = m.employee_id
and w.hire_date < m.hire_date;

--or
select w.last_name, w.hire_date, m.last_name, m.hire_date
from employees w join employees m
on (w.manager_id = m.employee_id)
where w.hire_date < m.hire_date;
















select e.last_name, e.hire_date, m.last_name, m.hire_date
from employees e , employees m 
where e.employee_id = m.manager_id
and e.hire_date < m.hire_date;















