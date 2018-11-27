1. 80번부서의 평균급여보다 많은 급여를 받는 직원의 이름, 부서id, 급여를 조회하시오.

select first_name , department_id, salary
from employees
where salary >
(select avg(salary)
from employees
where department_id =80);

2. 'South San Francisco'에 근무하는 직원의 최소급여보다 급여를 많이 받으면서 
50 번부서의 평균급여보다 많은 급여를 받는 직원의 이름, 급여, 부서명, 
부서id를 조회하시오.

select first_name, salary, department_name, d.department_id
from employees e, departments, d locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and salary >
(select min(salary)
from employees , locations 
where lower(city) = 'south san francisco')
and salary >
(select avg(salary)
from employees
where department_id = 50);


3. 각 직급별(job_title) 인원수를 조회하되 사용되지 않은 직급이 있다면 해당 직급도
출력결과에 포함시키시오. 그리고 직급별 인원수가 3명 이상인 직급만 출력결과에 포함시키시오.

select job_title, count(*)
from jobs j , employees e
where j.job_id(+) = e.job_id
group by job_title
having count(job_title)>=3;

***4. 각 부서별 최대급여를 받는 직원의 이름, 부서명, 급여를 조회하시오.

select e.department_id, first_name, department_name, salary
from employees e, departments d
where e.department_id = d.department_id
and (e.department_id, e.salary) in
(select department_id, sum(salary)
from employees
group by department_id);
 

******5. 직원의 이름, 부서id, 급여를 조회하시오. 그리고 직원이 속한 해당 부서의 
최소급여를 마지막에 포함시켜 출력 하시오.

select first_name, department_id, salary,
(select min(salary)
from employees e2
where e1.department_id = e2.department_id) 최소급여
from employees e1;

select department_id, min(salary)
from employees
group by department_id
order by department_id;



6. 월별 입사자 수를 조회하되, 입사자 수가 5명 이상인 월만 출력하시오.

select  to_char(hire_date,'mm'),count(*)
from employees
group by  to_char(hire_date,'mm')
having to_char(hire_date,'mm') >=5;

substr

7. 년도별 입사자 수를 조회하시오. 
단, 입사자수가 많은 년도부터 출력되도록 합니다.

select  to_char(hire_date,'yy'),count(*)
from employees
group by  to_char(hire_date,'yy')
order by to_char(hire_date,'yy') ;


8. 'Southlake'에서 근무하는 직원의 이름, 급여, 직책(job_title)을 조회하시오.

select first_name, salary, job_title
from employees e, departments d, locations l , jobs j
where e.department_id = d.department_id
and d.location_id = l.location_id
and e.job_id = j.job_id
and lower(city) = 'southlake';


9. 국가별 근무 인원수를 조회하시오. 단, 인원수가 3명 이상인 국가정보만 출력되어야함.

select country_name, count(*)
from employees e, departments d, locations l , countries c
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id
group by country_name
having count(country_name)>=3;



10. 직원의 이름, 급여, 직원의 관리자 이름을 조회하시오. 단, 관리자가 없는 직원은
   '<관리자 없음>'이 출력되도록 해야 한다.
   
select e.first_name, e.salary, nvl(to_char(e.manager_id),'관리자없음')
from employees e, employees man
where e.manager_id = man.employee_id(+)
   
   


11. 직원의 이름, 부서명, 근무년수를 조회하되, 15년 이상 장기 근속자만 출력되록한다.

select first_name, department_name, months_between(sysdate-hire_date)/12
from employees e, departments d
where e.department_id = d.department_id
and months_between(sysdate-hire_date)/12>=15;

12. 각 부서 이름별로 최대급여와 최소급여를 조회하시오. 단, 최대/최소급여가 동일한
   부서는 출력결과에서 제외시킨다.
   
   select department_name, max(salary), min(salary)
   from employees e, departments d
   where e.department_id = d.department_id
   group by department_name
   having max(salary) <>min(salary);


***13. 자신이 속한 부서의 평균급여보다 많은 급여를 받는 직원정보만 조회하시오.
   단, 출력결과에 자신이 속한 부서의 평균 급여정보도 출력되어야한다. 
   
   select first_name, department_id , salary,
   (select avg(salary)
   from employees e3
   where e3.department_id = e1.department_id)
   from employees e1
   where salary >
   (select avg(salary)
   from employees e2
   where e1.department_id = e2.department_id
   group by department_id)
   
   
   select first_name, department_id, dd.sal
   from employees e , (select department_id , avg(salary) sal from employees group by department_id) dd
   where e.department_id = dd.department_id
   and e.salary > dd.sal
   
   


***14. '월'별 최대급여자의 이름, 급여를 조회하시오.

select max(salary)
from employees
group by to_char(hire_date, 'mm')

select to_char(hire_date, 'mm'), first_name, salary
from employees
where (salary, to_char(hire_date, 'mm')) in
(select max(salary), to_char(hire_date, 'mm')
from employees
group by to_char(hire_date, 'mm'));


15. 부서별, 직급별, 평균급여를 조회하시오. 
   단, 평균급여가 50번부서의 평균보다 많은 부서만 출력되어야 합니다.
   
   select avg(salary)
   from employees
   where salary >
   (select avg(salary)
   from employees
   where department_id = 50)
   group by department_id
   
 select avg(salary), grade
   from employees e, salgrade s
   where e.salary between s.lowsalary and s.hisalary
   group by grade;
   

   select department_id, grade ,salary
   from employees e, salgrade s
   where e.salary between s.lowsalary and hisalary
   and (salary, grade) in
   (select avg(salary), grade
   from employees e, salgrade s
   where e.salary between s.lowsalary and s.hisalary
   group by grade)
   


16. 자신의 관리자보다 많은 급여를 받는 직원의 이름과 급여를 조회하시오.


select e.first_name, e.salary
from employees e, employees man
where e.manager_id = man.employee_id
and e.salary > man.salary;
