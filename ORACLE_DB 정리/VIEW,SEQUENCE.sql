
--객체 : 데이터 저장 구조 타입 : 데이터 저장집합
1.TABLE : 행과 열의 2차원 형태. 데이터 저장소, 실제컬럼구조
2.VIEW : TABLE에서 추출한 일부 데이터를 QUERY 형태로 저장한 가상의 테이블이름
3.INDEX : 검색 객체
4.SEQUENCE : 자동 숫자 생성 객체


--생성
create view 뷰이름 as subquery;
create[or replace] view 뷰이름 as subquery;

--삭제
drop view 뷰이름;

--view 조회법
select * from user_views;

--주의사항!!!
1. 그룹함수, 연산 수식(=실제 존재컬럼명x) alias 설정
2. 실제 존재컬럼명 뷰 생성 : alias 선택적 /must name this expression with a column alias
3. 조인테이블 생성 뷰 = 복합뷰 에서는 dml 불가
4. 그룹함수, 연산 수식 생성 뷰 = dml 불가
5. 서브쿼리 내부 1개 테이블 = 단일 뷰
	5-1 dml 사용ㅇ : 서브쿼리 내부 낫널 컬럼 모두 포함
	5-2 dml 사용x : 테이블에는 낫널 컬럼이 존재하고 서브쿼리에서는 낫널 포함x
6.select * from 뷰이름;

select
from (select: 조회 데이터를 가상 테이블로 보자 : inline view)
-- select 구문에서 from 에 사용 되는 서브쿼리를 inline view 라 한다!!!
where
group by
having 
order by

-employees 테이블에서 급여 많은 사원 5명 조회
select *
from (
select rownum r, first_name, salary
		from (select * from employees order by salary desc)
		) --inline view
where r between 6 and 10; --top-n query(rownum사용한다!!!)

========================================

ex)employees 테이블(동일) 접근 권한 부서별 다르게 사용 할 때(인사부, 총무부)

--사번, 급여, 입사일, 커미션 : 총무부
create or replace view emp_총무부
as
select employee_id, hire_date, salary, commission_pct
from employees;

create or replace view emp_총무부
(a,b,c,d) -- alias 여기에 붙여도 가능
as
select employee_id, hire_date, salary, commission_pct
from employees;

--사번, 이름, 입사일, 부서, 직종코드 : 인사부
create or replace view emp_인사부
as
select employee_id, hire_date, first_name, last_name, job_id, department_id
from employees e, departments d, jobs j
where e.department_id = d.department_id
and d.job_id = j.job_id;

--불가하다 제약조건 중 not null 자리가 있기 때문;
insert into emp_총무부
values (1000, sysdate, 10000, 0.5);

====================================

-50번 부서의 최대급여, 최소급여, 사원수, 평균급여, 급여총합

select max(salary), min(salary), count(salary), round(avg(salary)), sum(salary)
from employees
where department_id = 50;

-- 이 select 문이 빈번하게 사용 될경우 / 이름 부여 정의
-- 실제 존재 테이블명과 다를경우 must name this expression with a column alias
create view emp_50_group
as
select max(salary) max_sal, min(salary) min_sal, count(salary) cnt_sal, 
round(avg(salary)) avg_sal, sum(salary) sum_sal
from employees
where department_id = 50;

-- 수정
create or replace view emp_50_group
as
select max(salary) max_sal, min(salary) min_sal, count(salary) cnt_sal, 
round(avg(salary)) avg_sal --, sum(salary) sum_sal
from employees
where department_id = 50;


select * from emp_50_group

1. as 뒤 select 실행
2. 실행 결과 alias 테이블 처럼 가상 생성
3. 조회

--데이터 입력 불가한 경우가 많다
insert into emp_50_group
values(1,1,1,1,1)

drop view emp_50_group;

=====================================

인사관리를 위한 시스템 구축중 지역region,국가, 위치 에 대한 전체 리스트 정보를 빈번하게 사용할
경우가 생겼다. 여러 프로그램에서 매번 


create or replace view LOC_DETAILS_VIEW
as
select r.region_id, c.country_id, location_id, 
region_name, country_name, street_address, 
postal_code, city, state_province
from regions r, countries c, locations l
where r.region_id = c.region_id
and l.country_id = c.country_id
order by region_id, country_id,location_id;
--order by 1,2,3;

select * from loc_details_view;
select * from user_views;
drop view loc_details_view;



------------------------------------

db object
계정 생성 table 객체 정보
계정 생성 view 객체 정보
"실제데이터의 부가데이터정보" = metadata
오라클 메타데이터정보 제공 내장 테이블 = dictionary
제약조건리스트/테이블리스트/뷰리스트/시퀀스리스트/

desc dictionary;

1.table_name
user_xxx : hr 현재 계정 객체정보만
dba_xxx : dba 객체정보
all_xxx : dba+모든 user 계정 객체정보

USER_CONSTRAINTS : 제약조건 정보
-desc user_constraints=>컬럼정보
select constraint_name, constraint_type, search_condtion, table_name
from user_constraints;

USER_TABLES : 테이블 정보
-select * from tab; -- table + view
select * from user_tables; -- table

USER_VIEWS
-select * from user_views; -- view이름 + 서브쿼리

USER_SEQUENCES
USER_SOURCE




=============================================================================

SEQUENCE : 테이블 UNIQUE, NOT NULL 조건 만족 데이터가 숫자일 경우 자동 증가/감소값 생성 객체(게시물)
(사번, 학번, 주민번호, 사회보장번호, 여권번호)
>특정 테이블 전용으로 sequence 사용 한다. 타 테이블에 사용 하면 일정한 숫자 증가를 얻을 수 없다.

--SEQUENCE 조회법
desc user_sequences
select sequence_name, increment_by, max_value, min_value, cycle_flag
from user_sequences
where SEQUENCE_name = 'EMP_SEQ';


--생성

create sequence 시퀀스명;
[start with 10]
[increment by 5]
[maxvalue 50]
[cycle || nocycle]


--사용
시퀀스명.nextval(next value) : 다음 증가값
시퀀스명.currval(current value) : 현재 증가최종값

select emp_seq.currval from dual; => 현재값
select emp_seq.nextval from dual; => 1값 생성 시작, 현재값 + 1

--수정
ALTER SEQUENCE sequence_name;
    [INCREMENT BY n]
    [MAXVALUE n | NOMAXVALUE]
    [MINVALUE n | NOMINVALUE]
    [CYCLE | NOCYCLE]
    [CACHE | NOCACHE]

--삭제
drop sequence;


===================================


create sequence emp_seq;

create sequence emp2_seq
start with 10
increment by 5
maxvalue 30;

--account 테이블 acc_id 컬럼값 자동 생성
--시작 40000, 100씩 증가, 50000까지

create sequence account_seq
start with 40000
increment by 100
maxvalue 50000;

insert into account values(account_seq.nextval, 1111, 1000);
insert into account values

--서브쿼리를 이용한 시퀀스 대체
(select max(acc_id)+100 from account, 1111, 1000);

=====================================













