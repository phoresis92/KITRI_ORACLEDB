
DQL 
: Data query Lang : SELECT 검색


--SUB QUERY 부질의

1.mainqurey에 포함
2.()로 묶어서 표시
3.wh
4.일반 select구조와 동일한 구조이나 order by 절은 사용할 수 없다.


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


단일행 subquery -subquery 결과 하나
다중행 subquery -subquery 결과 여러값

			단일행		다중행
같은지 비교		=			=any, in
최대 최소 비교	> >=		> any()
모든 요소 비교	> >=		> all()
any() = or 와 같은 개념
all() = and 와 같은 개념

	--------
	------------> any
			----> all

--pariwise subquery
select department_id, first_name, salary
from employees 
where (department_id, salary) in --pairwise
(select department_id, max(salary)
from employees
group by department_id)
order by department_id;