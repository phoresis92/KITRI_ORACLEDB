
--GROUP FUNCTION
AVG
COUNT
MAX
MIN
STDDEV
SUM
VARIANCE

--숫자 함수 Function
round
trunc
mod()나머지
abs()절대값
floor 소수점 이하 절삭

--문자함수
lower
upper

initcap

concat
-select concat(substr('921017-1928374', 1, 8), '******') from dual;

substr('ename', 2, 3) = nam
-select substr('921017-1483742', 1, 8) || '******' from dual;

instr('ename', 'e' ,1,2) = 5
-INSTR('비교할 대상', '비교하고자하는 값', 비교를 시작할 위치, 검색된 결과의 순번)
-select instr('TEST SAMPLE CODE', 'E' ,3,1) from dual;

length()
-select length('HelloWorld') from dual;

lpad()
rpad('ename', 10, '+') = ename+++++
-select rpad(substr('921017-1928374', 1,8), 15, '*') from dual;

replace()
-select replace('HelloWorld', 'hello','Hi') from dual;




--날짜 함수
sysdate
months_between
NEXT_DAY
add_months
last_day

-두 날자 사이 경과 시간/일/개월/주/년
- 일 단위
sysdate - hire_date : 입사한지 경과일수
- 주 단위
(sysdate - hire_date)/7
-한달 단위
months_between(sysdate - hire_date)
-년 단위
(sysdate - hire_date)/365

--변환함수
to_char()
-to_char(hire_date, 'yyyy"년도"mm"월"dd"일" : hh"시"mi"분"ss"초"') "변경입사일"
from employees;

select first_name, hire_date, job_title
from employees e, jobs j
where e.job_id = j.job_id
and to_char(hire_date, 'mm') = 10;
--and hire_date like '___10%'
--and substr(hire_date, 4 ,2) = '10'

to_date()
to_number()


=============================================================================

--NVL (NULL VALUES)
select last_name,
salary, nvl(commission_pct,0) as commi,
salary + salary * nvl(commission_pct, 0) as an_sal
from employees;

--NVL2
SELECT NVL2(NULL, 1, 0) FROM DUAL;

--NULLIF
select nullif(1,1) from dual;
select nullif(1,2) from dual;

--coalesce
select coalesce(null,null,1,2,100,null) from dual;



============================================================================

--CASE (CASE WHEN THEN ELSE END)
select last_name, job_id, salary,
	case job_id when 'IT_PROG'	then 1.10*salary
				when 'ST_CLERK' THEN 1.15*salary
				when 'SA_REP'	THEN 1.20*salary
		ELSE salary END "revised_salary"
from employees;


--DECODE
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
	
	





