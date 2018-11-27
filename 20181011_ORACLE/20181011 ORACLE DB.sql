http://192.168.13.14:9090/oracle/

--subquery 부질의

select(select)
from(select)
where(select)
group by(select)
having(select)
order by(select)

1.mainqurey에 포함
2.()로 묶어서 표시
3.wh
4.일반 select구조와 동일한 구조이나 order by 절은 사용할 수 없다.




--Sarah 의 부서번호와 같은 사원을 찾기
select first_name, department_id
from employees 
where department_id =
(select department_id
from employees
where first_name = 'Sarah')
and first_name <> 'Sarah';

select e.first_name, e.department_id
from employees e, employees sarah
where sarah.first_name = 'Sarah'
and e.department_id = sarah.department_id
and e.first_name <> 'Sarah';


--Sarah와 같은 월에 입사한 사원의 이름, 입사일자 조회

select first_name, hire_date
from employees
where to_char(hire_date, 'mm') =
(select to_char(hire_date,'mm')
from employees
where first_name = 'Sarah')
and first_name <> 'Sarah';

select e.first_name, e.hire_date
from employees e, employees sarah
where to_char(sarah.hire_date, 'mm') = to_char(e.hire_date, 'mm')
and sarah.first_name = 'Sarah'
and e.first_name <> 'Sarah';

--substr사용
select first_name, hire_date
from employees
where substr(hire_date, 4,2) =
(select substr(hire_date,4,2)
from employees
where first_name = 'Sarah')
and first_name <> 'Sarah';


--사라랑 같은 월에 입사한 사원수 조회
단 사라 제외, 사원수가 10명 이상인 경우 출력

select count(*)
from employees
where substr(hire_date,4,2) = 
(select substr(hire_date,4,2)
from employees
where first_name = 'Sarah')
and first_name<>'Sarah'
having count(*)>=10;

-- 부서별 사원의 급여 총합 조회하되 10만 이상인 부서만 조회

select department_id, sum(salary)
from employees
group by department_id
having sum(salary) >= 100000;

--SQL문 실행 순서
5.select	 department_id, trunc(avg(salary))
1.from		 employees
2.where		 department_id = 100
3.group by	 department_id
4.having	 avg(salary)>8000
6.order by	 department_id;


-- 자신의 상사 이름이 lex인 사원의 이름과 급여 조회

select e.first_name, e.salary
from employees e, employees man
where e.manager_id = man.employee_id
and man.first_name = 'Lex';


select first_name , salary
from employees
where manager_id =
	(select employee_id
	from employees
	where first_name = 'Lex');

-- 전사원의 평균급여 이상의 급여를 받는 사원의 이름,급여 조회
출력 값 first_name, salary, avg(salary)

select first_name 사원명, salary 급여, 
trunc((select avg(salary) from employees)) 평균급여
--(select round(avg(salary)) from employees)
from employees
where salary >= any
(select avg(salary)
from employees);


--David 동일 부서 근무 사원 이름,급여,부서코드 조회

select first_name, department_id
from employees 
where department_id in -- 뒤 subquery 값이 여러개일 경우
(select department_id
from employees
where first_name = 'David')
and first_name <> 'David';

select e.first_name, e.department_id
from employees e, employees kelly
where kelly.first_name = 'David'
and e.department_id in kelly.department_id
and e.first_name <> 'David';



단일행 subquery -subquery 결과 하나
다중행 subquery -subquery 결과 여러값

			단일행		다중행
같은지 비교		=			=any, in
최대 최소 비교	> >=		> any()
모든 요소 비교	> >=		> all()
any() = or 와 같은 개념
all() = and 와 같은 개념

		------------
		----------------> any
					----> all

--급여를 10000 이상 받는 사원이 속한 부서 정보를 조회
부서 정보는 부서코드 와 부서명으로 조회 JOIN+SUBQURY(단일,다중)


select e.department_id, department_name, salary
from employees e , departments d
where e.department_id = d.department_id
and department_id in
(select department_id
from employees
where salary>10000)




select distinct e.department_id , department_name
from employees e , departments d
where e.department_id = d.department_id 
and e.department_id in
(select distinct department_id
from employees
where salary >=10000)
order by department_id



-- 50번 부서원 최대 급여보다 더 많은 급여를 받는 사원

select first_name, salary
from employees
where salary >
(select max(salary)
from employees
where department_id = 50);


-- 위와 같음

select first_name, salary
from employees
where salary > all
(select salary
from employees
where department_id = 50);

--80번 부서
select first_name, salary
from employees
where salary <
(select min(salary)
from employees
where department_id = 80);

--위와 같음
select first_name, salary
from employees
where salary < all
(select salary
from employees
where department_id = 80);

부서별 최고급여를 받는 사원의 이름, 급여 조회
-- 부서별 최고 급여
select department_id, max(salary)
from employees
group by department_id;

--해답 (pairwise subquery)
select department_id, first_name, salary
from employees 
where (department_id, salary) in --pairwise
(select department_id, max(salary)
from employees
group by department_id)
order by department_id;

--다른 답
select employee_id, last_name, salary, department_id
from   employees e1
where  salary >= all( select salary
                     from   employees e2
                     where  e1.department_id = e2.department_id)
order by department_id

출처: http://darte1.tistory.com/9 [Dartes Note]

--or
select e1.employee_id, e1.first_name, e1.salary, e1.department_id
from employees e1 , (select department_id, max(salary) as getsalary from employees group by department_id) e2
where e1.salary = e2.getsalary
and e1.department_id = e2.department_id
order by department_id;

출처: http://darte1.tistory.com/9 [Dartes Note]





인터넷 게시판
게시물 갯수 : 107개
게시물 10개씩 잘라서 1페이지 취급

-employees 테이블 1페이지 1번~10번 게시물 출력
-employees 테이블 2페이지 11번~20번 게시물 출력
==>paging 처리

오라클 paging 처리
1.rownum 함수
rownum:select시 레코드 번호 생성 함수

select employee_id,salary
from employees;
==> 107개 (insert 순서로 나온다)

select employee_id,salary , commission_pct
from employees
order by commission_pct asc nulls first;

select employee_id,salary , commission_pct
from employees
order by commission_pct desc nulls last;

select rownum, employee_id, salary
from employees
order by salary desc;
2.subquery
select rownum, employee_id, salary
from employees
order by salary desc;
의 문제점으로 서브쿼리 사용

from(select* from employees
order by salary desc)

select rownum, employee_id, salary
from(select* from employees
order by salary desc);

--급여 많은 사람순으로 정렬하여 급여 1-5번째 레코드 가져와라

select rownum, employee_id, salary
from(select* from employees
order by salary desc)
where rownum >=1 and rownum<=5;

--급여 많은 사람순으로 정렬하여 급여 6-10번째 레코드 가져와라

select rownum, employee_id, salary
from(select* from employees
order by salary desc)
where rownum >=6 and rownum<=10;
--rownum : >,>= 연산 불가 (단 1은 제외)

--inline view
select r, employee_id, salary
from (select rownum r, employee_id, salary
		from(select* from employees
				order by salary desc))
where r >=6 and r<=10;
-- 가짜 테이블 : 자주 사용
==> view



inline view


1.정렬 2.select 순서 레코드 번호 생성
- 사원들 최근 입사일 순서로 사원 이름, 입사일,급여, 부서코드를 조회하되 상위 20개만 조회.

select r, first_name, hire_date, salary, department_id
from (select rownum r, first_name, hire_date, salary, department_id
		from (select * from employees order by hire_date desc))
where r <= 20;

select imsi2.*
from (select rownum r, imsi.*
		from (select * from employees order by hire_date desc) imsi) imsi2
where r <= 20;

- 부서명 알파벳순으로 정렬하여 10번째 부서의부서코드와 부서명 조회

select r, department_id, department_name
from (select rownum r, department_id, department_name
		from (select * from departments order by department_name))
where r = 10 ;

- 국가명 알파벳순, 같은 국가명인 경우 도시명 알파벳순으로 정렬하여  3-6번째 레코드 조회

select r, country_name, city
from (select rownum r, country_name, city
from (select country_name, city
		from countries c , locations l
		where c.country_id = l.country_id
		order by country_name, city))
where r>= 3 and r<=6;

숫자 내림차순: 큰 -작은
날짜 내림차순: 최근-오래
문자 오름차순: 사전(a-z)


--set 연산
union
union all
intersect
minus


select first_name, last_name
from employees
where department_id in (50, 80, 100);
==>85명

select first_name, last_name
from employees
where hire_date <= '06/12/31';
==> 77명






6장 DATA DEFINITION LANG.

데이터베이스>다수 사용자(hr)>다수 테이블 > 다수 레코드(컬럼 구성)

ORACLE = RDB( Relational : 관계형 )
데이터 관계 테이블형태 구성

create table~ : 테이블 생성 SQL
alter table~ : 테이블 구조변경 SQL
drop table~ : 테이블 삭제 SQL

create table 이름
(컬럼1 타입(길이) [제약조건/생략가능],
컬럼2 타입(길이) [제약조건/생략가능],
.....);

테이블이름 , 컬럼이름
1. 대소문자 구분 없다.
2. DB 저장시 대문자 저장(테이블이름 조회시 대문자)
3. 30자 까지 가능
4. 숫자, 문자, _, 구성가능
5. 숫자로 시작 불가능

(오라클 DB : 독자적 > 표준화
-타입
정수 NUMBER(정수자리수) integer
실수 NUMBER(정수자리수+소수점이하자리수,소수점이하자리수) float
문자열 
CHAR : 2000BYTE , VARCHAR2 : 4000BYTE(1300) ,
'KELLY'저장시
EMP_NAME CHAR(10) -- > 10바이트 공간 고정적 유지
EMP_NAME2 VARCHAR2(10) -- > 5바이트 공간 사용
CLOB, LONG : 대용량, GB
영문자 : 1글자 1BYTE
한글 : 1글자 3BYTE
날짜 DATE

정수, 실수값 저장 : 10, 3.14
문자, 날짜값 저장 : 'KELLY' , '08/01/01'
























