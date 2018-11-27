강사 조성희
bluejeansh@hanmail.net

sql
1 검색 : Select

2 데이터 저장/ 수정 / 삭제 : DML(Data Manipulation Lang.) 5장
	데이터 = 레코드 = 행
	데이터 저장 길이/ 타입/제약조건 정의

3 데이터 구조의 정의 / 변경/ 삭제 DDL(Data Definition Lang.) 6장

4 데이터 사용 권한 부여/삭제 DCL(Data Control Lang.)
	사용자 생성 / 접속 테이블생성권한 : User(hr,SCOTT)X/admin(system)O관리계정만 사용가능

5 데이터 트랜젝션 제어 TCL(Transaction Control Lang.) 5장

DQL : Data query Lang : SELECT
DDL : Data Definition Lang : CREATE TABLE / ALTER TABLE / DROP TABLE
DML : Data Manipulation Lang : INSERT / UPDATE / DELETE
DCL : Data Control Lang : GRANT / REVOKE
TCL : COMMIT / ROLLBACK
+
PL(PROCEDUREAL LANG)/SQL : 결과 저장 변수, 반복, 조건 포함 블럭 7,8,9장

(오라클: 대소문자 구분x)	보통 컬럼명을 대문자 sql을 소문자로 구분
(자바: 대소문자 구분O)
(html: 대소문자 구분x)
(java script : 대소문자 구분O)


select * from tab;
--tabtype table , view


select 컬럼명 
from 테이블명
[where 조건식]
[group by 그룹함수 컬럼명]
[having 그룹함수 조건식]
[order by 정렬기준 컬럼명 asc,desc];

--join query
select 컬럼명1, 컬럼명2
from 테이블명 1, 테이블명 2; 

-employees 테이블에서 이름(first_name), 부서코드(department_id) 조회

select first_name, department_id
from employees;

-employees 테이블에서 이름(first_name), 부서이름(department_name), 부서코드(department_id) 조회

select first_name, e.department_id, department_name
from employees e join departments d
on (e.department_id = d.department_id);

--ed : sqlplus 에서 txt 파일로 확인할수 있다

A={1,2}
B={a,b,c}

A JOIN B
{1,a} , {1,b} , {1,c},
{2,a} , {2,b} , {2,c}


-- equi join
select first_name, e.department_id, department_name
from employees e join departments d
on (e.department_id = d.department_id);

select count(*) from employees;

-- table alias 약자,별칭
-- 모든 사원 이름 , 부서명, 근무 도시명 출력
select first_name, e.department_id, department_name, city
from employees e, departments d,locations l
where e.department_id= d.department_id
and d.location_id = l.location_id;

-or
select first_name, department_name, city
from employees e join departments d
on (e.department_id= d.department_id)
join  locations l
on d.location_id = l.location_id;

-- 런던에 근무하는 사원수 출력
select city as "도시명", l.location_id as "지역 코드", count(*) as "사원수"
from employees e, departments d,locations l
where e.department_id= d.department_id
and d.location_id = l.location_id
and lower(city) = 'london' -- upper, lower, initcap
group by l.location_id, city;

--manager 직군 사원의 이름, 부서명, 직군명 출력

select first_name as "사원 이름", department_name as "부서명", e.job_id as "직업 코드", job_title as "직업명"
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id
and (upper(e.job_id) like '%MGR' --escape '\';
or j.job_id like '%MAN');

--accounting 부서에 근무하는 사원의 이름과 입사일 출력(2018-10-10 : 10:12:14 로 변경)
Date type
기본 포맷/ 변경
select sysdate from dual;


select * from NLS_DATABASE_PARAMETERS
where PARAMETER = 'NLS_DATE_FORMAT';

--접속 환경에서의 날자 포맷
select * from NLS_SESSION_PARAMETERS
where PARAMETER = 'NLS_DATE_FORMAT';

select hire_date from employees;

to_char / to_date / to_number
오라클은 기본 포맷 데이터만 날자데이터로 인식
to_char(hire_date, 'yyyy-mm-dd : hh-mi-ss')

select hire_date "원래입사일",
to_char(hire_date, 'yyyy"년도"mm"월"dd"일" : hh"시"mi"분"ss"초"') "변경입사일"
from employees;

--10월에 입사한 사원의 사원명, 입사일, 직종명
오라클 데이터 타입
정수: number(6)
실수 : number(8,2) 전체자리수 8
날짜 : date
문자 : varchar2(100)
varchar2: 한글의 경우 1글자가 2byte이상(오라클의 경우 3byte)


select first_name, hire_date, job_title
from employees e, jobs j
where e.job_id = j.job_id
and to_char(hire_date, 'mm') = 10;
--and hire_date like '___10%'
--and substr(hire_date, 4 ,2) = '10'

--입사한지 15년 이상 경과한 사원명, 입사일
-두 날자 사이 경과 시간/일/개월/주/년
sysdate - hire_date : 입사한지 경과일수



select first_name 사원명, hire_date 입사일, trunc(months_between(sysdate,hire_date)/12) 경과년수
from employees
where months_between(sysdate,hire_date) >(15*12)
order by hire_date;

-or
select first_name 사원명, hire_date 입사일, Round((sysdate-hire_date)/365) 경과년수
from employees
where (sysdate - hire_date)/365 >= 15
order by hire_date;

-주단위
(sysdate - hire_date)/7
-한달 단위
months_between(sysdate - hire_date)
-년 단위
(sysdate - hire_date)/365

--입사한지 200개월 이상 경과한 사원명,

select first_name 사원명, hire_date 입사일, trunc(months_between(sysdate , hire_date)) "경과 개월수"
from employees
where months_between(sysdate , hire_date)>=150
order by hire_date;





-- cartesian product = cross join -이런 결과값이 나오면 안된다
select first_name, department_name
from employees e ,departments d;

--non equi join
-employees 급여 등급 매기는 테이블
create table salgrade
(grade number(2),
lowsalary number(8,2),
hisalary number(8,2));


insert into salgrade values(1,1000,5000);
insert into salgrade values(2,5001,10000);
insert into salgrade values(3,10001,15000);
insert into salgrade values(4,15001,20000);
insert into salgrade values(5,20001,99999);

commit; rollback;

select first_name 사원명, salary 급여, s.grade 급여등급
from employees e, salgrade s
where e.salary between s.lowsalary and s.hisalary;

select first_name 사원명, salary 급여, s.grade 급여등급
from employees e, salgrade s
where e.salary >= s.lowsalary
and e.salary <= s.hisalary;

--self join

-각 사원의 상사 사번 조회
select me.employee_id 내사번, me.first_name 내이름, me.manager_id 상사사번, ma.first_name 상사이름 
from employees me left outer join employees ma
on me.manager_id = ma.employee_id
order by me.employee_id;

select me.employee_id 내사번, me.first_name 내이름, me.manager_id 상사사번, ma.first_name 상사이름
from employees me , employees ma
where me.manager_id = ma.employee_id(+)
order by me.employee_id;


--EXAMPLE

--상사이름이 steven 인 사원의 이름과 직종코드, 상사이름 출력

select me.first_name 사원명, me.job_id 사원직종, man.first_name 상사이름
from employees me , employees man
where me.manager_id = man.employee_id
and lower(man.first_name) = 'steven';

--상사보다 더 많은 급여를 받는 사원 이름과 급여, 상사의 이름과 급여 출력

select me.first_name 사원명, me.salary 사원급여, man.first_name 상사명, man.salary 상사급여
from employees me , employees man
where me.manager_id = man.employee_id
and me.salary > man.salary;

--이름이 KELLY 인 사원과 같은 부서에서 근무하는 사원의 이름, 부서 출력.
--단, KELLY 제외 하고 출력

select first_name 사원명, department_id 부서코드
from employees
where department_id =
(select department_id
from employees
where UPPER(first_name) = 'KELLY')
and UPPER(first_name) <> 'KELLY'
order by first_name;

-or
select e.first_name 사원명, e.department_id 부서코드
from employees e, employees kelly
where UPPER(kelly.first_name) = 'KELLY'
and kelly.department_id = e.department_id
and upper(e.first_name) <> 'KELLY'
order by e.first_name;


-- outer join 반대 inner join

-- employees 테이블 모든 사원의 사원명, 부서명 출력
-- 테이블 모든 사원(107명)을 출력해라 부서 없는 사원 포함
-- 부서가 없는 사원은 '부서미배정' 이라 표기하라

select first_name, department_id
from employees
where department_id is null;


select first_name 사원명, 
nvl(department_name , '부서미배정') 부서명, 
nvl(to_char(d.department_id),'미배정') 부서번호
from employees e , departments d
where e.department_id = d.department_id(+);

-or
select first_name 사원명,  
NVL(department_name, '부서미배정') 부서명,
nvl(to_char(e.department_id),'미배정')
from employees e left join departments d
on e.department_id = d.department_id;

-null값이 없는 쪽에 (+)를 붙여야 한다.


-- 부서 없는 사원 포함 사원명, 부서명 조회 출력해라
--부서명별 부서원명 조회

select department_name, first_name
from employees e, departments d
where d.department_id(+) = e.department_id
order by department_name;


--부서원 하나도 없는 부서명 포함 조회

select department_name,first_name
from employees e, departments d
where d.department_id = e.department_id(+)
order by department_name;


-- 모든 사원의 상사 급여 출력해라 상사 없는 사원도 같이 출력 상사급여는 0 표시

select me.first_name 사원명 , 
me.salary 급여, 
nvl(man.first_name, 'boss') 상사명, 
nvl(man.salary, 0) 상사급여
from employees me , employees man
where me.manager_id = man.employee_id(+);

오라클 자체 join 문법 : 다른 db에서 사용불가
ansi join 문법 : db 공통 문법 :

http://192.168.13.11:9090/oracle/



































