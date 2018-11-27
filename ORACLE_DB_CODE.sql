
http://www.gurubee.net/roadmap/oracle 참조하세요


설계도를 그린뒤 코드를 짜자 무턱대고 코드부터 손대면 뒤죽박죽. 생각을 하라고

alias 약자,별칭

데이터 = 레코드 = 행

CL SCR : CLEAR SCREEN

--sql
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
TCL : Transaction Crontrol Lang : COMMIT / ROLLBACK
+
PL(PROCEDUREAL LANG)/SQL : 결과 저장 변수, 반복, 조건 포함 블럭 7,8,9장

--객체 : 데이터 저장 구조 타입 : 데이터 저장집합
1.TABLE : 행과 열의 2차원 형태. 데이터 저장소
2.VIEW : TABLE에서 추출한 일부 데이터를 QUERY 형태로 저장한 가상의 테이블이름
3.INDEX : 검색 객체
4.SEQUENCE : 자동 숫자 생성 객체

ORACLE = RDB( Relational : 관계형 )
데이터 관계 테이블형태 구성

--QUERY 형식
select 컬럼명 
from 테이블명
[where 조건식]
[group by 그룹함수 컬럼명]
[having 그룹함수 조건식]
[order by 정렬기준 컬럼명 asc,desc];

--SQL문 실행 순서
5.select	 department_id, avg(salary)
1.from		 employees
2.where		 department_id = 100
3.group by	 department_id
4.having	 avg(salary)>8000
6.order by	 department_id;


--CRUD기능
CREATE / READ / UPDATE / DELETE
게시물 작성 - 게시물 저장 : INSERT
게시물 수정 : UPDATE
게시물 삭제 : DELETE
게시물 조회 : SELECT

=======================================================

--sqlplus

- EDIT - 버퍼에 저장된 쿼리문을 편집하는 명령어(축약형 ED)

- HOST - 도스프롬포트를 연다.
- EXIT - 다시 SQLPLUS로 돌아온다.

- save - 마지막에 실행한 명령어를 저장하는 명령어
- @ - 저장한 명령어를 불러와서 실행시키는 명령어
	@ C:\Users\hushe\Desktop\ORACLE_DB\20181016\EMP_SELECT_EXCEPTION -- .SQL의 경우 확장자 넣지 않아도 된다.
- GET - 저장한 명령어를 버퍼로 불러오는 명령어 
- LIST - 버퍼에 있는 내용을 확인하기 위한 명령어 (축약형 : L)
- RUN  - 버퍼에 저장된 쿼리문을 실행(축약형 : R) 
- / - 버퍼에 저장된 쿼리문을 실행

-SET_HEADING - 컬럼제목의 출력 여부를 결정 
-SET_LINESIZE - 한 화면에 출력되는 라인의 수를 수정
-SET_PAGESIZE - 페이지 크기를 결정



=========================================================================


DCL : admin 계정만 사용
create user name identified by pass ;
grant connect, resource(일반유저 생성) to username; 



--SCOTT계정 생성
conn /as sysdba
@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\scott.sql
conn SCOTT/TIGER
desc emp;
select * from emp;)

--HR 계정 생성
conn /as sysdba;
alter user hr account unlock;
alter user hr identified by hr;

-- sysdba 접속
conn /as sysdba

-- user 생성
create user 유저명 identified by 비밀번호;

-- user 조회
select * from all_users;
select * from dba_users;

--dba 권한 주기
grant dba to 유저명;
grant connect, resource to project;

--user delete 유저삭제
drop user aaa cascade;


====================================================

--Date type 
select sysdate from dual;

기본 포맷 확인법
select * from NLS_DATABASE_PARAMETERS
where PARAMETER = 'NLS_DATE_FORMAT';

접속 환경에서의 날자 포맷
select * from NLS_SESSION_PARAMETERS
where PARAMETER = 'NLS_DATE_FORMAT';


=============================================================================

--table delete 테이블삭제
drop table member;

--table 생성
create table TEST
(A NUMBER(5) constraint pk_a primary key,
B VARCHAR2(50) [제약조건/생략가능],
.....);
TEST
A		B
100		교육부	RECORD=ROW
200		인사개발부	RECORD=ROW
COLUMN	COLUMN

create table student(
stu_no char(9),
stu_name varchar2(12),
stu_dept varchar2(20),
stu_grade number(1),
stu_class char(1),
stu_gender char(1),
stu_height number(5,2),
stu_weight number(5,2),
constraint p_stu_no primary key(stu_no));


--테이블이름 , 컬럼이름 속성
1. 대소문자 구분 없다.
2. DB 저장시 대문자 저장(테이블이름 조회시 대문자)
3. 30자 까지 가능
4. 숫자, 문자, _$#, 구성가능
5. 숫자로 시작 불가능
6. SQL 예약어 이름으로 사용 불가능 CREATE TABLE
7. 공백X

--데이터 타입(DATA TYPE)
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

-- table 복사
CREATE TABLE 테이블명
AS
SELECT~
=>테이블 생성 + 데이터 복사

create table emp_copy
as select * from employees;

-필요 조건만 선택 가능
create table emp_50
as select first_name, salary, department_id
from employees where department_id = 50;

-기존 존재 테이블 복사(데이터 복사x)
create table emp_none
as
select * from employees
where 1=0;

--TABLE 테이블명 변경 수정
rename 이전테이블 to 새로운테이블 ;
rename 이전테이블 to 새로운테이블 ;

--table 삭제
drop table student;

===========================================================================

--컬럼 추가
alter table 테이블명 add(컬럼명 타입(길이))
alter table emp add(
GENDER varchar2(6));
--컬럼 수정
alter table emp modify (gender number(1));
기존 컬럼에 데이터가 들어 있다면 서로 호환 되는 것 끼리만 데이터타입의 변경이 가능하다(거의 불가능)
--컬럼 이름변경
alter table emp rename column 이전컬럼 to 새로운컬럼;
alter table emp rename column indate to hire_date;
-- 컬럼 삭제
alter table emp drop column GENDER;
alter table emp drop (GENDER, , , );

=========================================================================

--insert into
- insert into 테이블명(컬럼1, 2, 3)
values(값1, 2, 3);

- insert into 테이블명
values(값1, 2, 3);

- insert into 테이블명(컬럼1, 3)
values(값1, 3);


=========================================================================

--UPDATE
-레코드(여러개컬럼값) 일부 컬럼값 수정/삭제
update 테이블명 
set 수정컬럼명=수정값 [, 수정컬럼명2=수정값2]
[where 수정레코드추출조건식];

update dept_const
set dept_manager_id = 100
where department_id is null; -- =null 은  'null'을 찾는 꼴

--인사부 소속 사원을 총무부 배치 변경
update emp_const
set dept_id = (총무부 부서코드 조회)
where dept_id = (인사부 부서코드 조회)

update emp_const
set dept_id = 
(select dept_id from dept_const where dept_name = '총무부')
where dept_id = 
(select dept_id from dept_const where dept_name = '인사부')

--설계도를 그린뒤 코드를 짜자 무턱대고 코드부터 손대면 및에 꼴 난다. 생각을 하라고
--틀린코드
update emp_const
set dept_name = '총무부'
where (name, dept_id) in
(select name, dept_id
from emp_const e, dept_cont d
where e.dept_id = d.dept_id
and d.dept_name = 인사부)


============================================================================

--delete

drop table 테이블명 > 복구불가
alter table 테이블명 drop colum 컬럼명 > 복구불가
alter table 테이블명 drop constraint 제약조건이름 > 복구불가

데이터만 삭제 = 복구가능
delete 테이블명 [where 조건식];
--> 테이블 삭제 x , 데이터만 삭제된다


0. delete emp_const where emp_id=200;
>삭제 가능

1. delete emp_const where emp_id=100;
>삭제 불가 dept_const 에서 dept_manager_id 가 foreign key 로 사용하고 있다

1-1. delete dept_const where dept_manager_id =100;
>매니저 번호를 삭제한 후 사원 100 삭제가능

1-2. update dept_const set dept_manager_id =200
		where dept_manager_id = 100;
>매니저 번호를 200으로 변경 후 사원 100 삭제가능


4. 이전 참조키 삭제
alter table emp_const drop constraint emp_const_dept_id_fk;

5. 참조키 설정 + on delete cascade 옵션추가 , on delete set null
alter table emp_const add constraint emp_const_dept_id_fk
foreign key(dept_id) references dept_const(dept_id)
on delete cascade;

6. 이전 참조키 삭제
alter table dept_const drop constraint dept_const_manager_fk;

7. 참조키 설정 + on delete cascade 옵션추가
alter table dept_const
add constraint dept_const_manager_fk
foreign key(dept_manager_id) 
references emp_const(emp_id) 
on delete cascade;
--on delete set null;

cascade연속적으로

delete emp_const where emp_id=100





============================================================================

--휴지통
-휴지통에 들은 테이블을 조회.
SQL> show recyclebin;
-휴지통의 모든 내용이 비워집니다.
SQL> purge recyclebin;
-삭제된 테이블을 되살리고 싶다면
SQL> flashback table 테이블명 to before drop;
-만약, 특정 테이블을 휴지통에 남기지 않고 모두 삭제하려면..
SQL> drop table 테이블명 purge;
-purge문 없이 그냥 drop 한 후에는
SQL> purge table 테이블명;



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

===========================================================================

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

===========================================================================



	

=========================================================================

인터넷 게시판
게시물 갯수 : 107개
게시물 10개씩 잘라서 1페이지 취급

-employees 테이블 1페이지 1번~10번 게시물 출력
-employees 테이블 2페이지 11번~20번 게시물 출력
==>paging 처리


오라클 paging 처리
--top-n query(rownum사용한다!!!)
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




-- order by null 값 순서 변경
order by commission_pct asc nulls first
order by commission_pct desc nulls last

--rownum 함수==>paging 처리
rownum:select시 레코드 번호 생성 함수

--inline view
select
from (select: 조회 데이터를 가상 테이블로 보자 : inline view)
-- select 구문에서 from 에 사용 되는 서브쿼리를 inline view 라 한다!!!

1.정렬 2.select 순서 레코드 번호 생성

-rownum : >,>= 연산 불가 (단 1은 제외)
select rownum, employee_id, salary
from(select* from employees
order by salary desc)
where rownum >=6 and rownum<=10;

-inline view 를 사용해 해결 가능
select r, employee_id, salary
from (select rownum r, employee_id, salary
		from(select* from employees
				order by salary desc))
where r >=6 and r<=10;
==>paging 처리

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

===========================================================================

--제약조건 표현 : 데이터의 무결성 보장
constraint 제약조건이름(테이블명_컬럼_타입약자) 제약조건타입 부가조건
R foreign
P primary
U unique
C check, notnull(search_condition 컬럼 참조해서 구분)

--제약조건 표현 종류
예외 default 기본값 설정(default sysdate)
1. primary key : UNIQUE+ NOT NULL
2. not null : 컬럼 값 존재(중복O)
3. unique : 컬럼 값 중복X(NULL O)
4. check(where절과 같음) : 사용자 정의 : 제약조건 외
5. foreign key : 다른 테이블 존재값 참조
*** 참조 사용 값 : unique/primary key 조건만 참조가능
즉 부모테이블이 uk/pk 자식테이블이 fk

부모컬럼 : 참조당함
자식컬럼 : 참조한다
부모컬럼 데이터 삭제시 문제 발생 가능

-- alter table 사용 (구조변경)
alter table (존재하는 컬럼에 제약조건 추가)
alter table 테이블명 add() -테이블에 컬럼추가
-alter table 테이블명 add(컬럼명 타입(길이))
alter table 테이블명 modify() -컬럼 데이터타입 수정
alter table 테이블명 drop () -테이블에 컬럼 삭제
alter table table_name rename column 
	old_column_name TO new_column_name; -컬럼명 변경
alter table emp_const add constraint -기존컬럼에 제약조건 추가
emp_con_deptname_fk foreign key(dept_name)
references dept_const(dept_name)

ALTER TABLE 테이블명
ADD CONSTRAINT 제약조건명 제약조건 (컬럼명);

--alter table 로 디폴트default 값 추가 
ALTER TABLE 테이블
           MODIFY (컬럼1 VARCHAR2(05)  DEFAULT 'N' NOT NULL,
                   컬럼2 NUMBER(08)    DEFAULT 0   NOT NULL,
                   컬럼3 DATE          DEFAULT SYSDATE NOT NULL);


--제약조건 확인 / 조회 =>
select * from dictionary =>desc user_constraints;

select constraint_name,
constraint_type,
table_name,
search_condition
from USER_CONSTRAINTS
where table_name = 'EMP_CONST';
 => select * from user_constraints where table_name = 'upper';

-디폴트 값 찾기 find default

 SELECT column_name, data_default, data_type, nullable
 FROM user_tab_cols
 WHERE table_name = UPPER('table_name')  
 AND column_name = UPPER('col_name')


-- 제약조건 효력 : insert/update/delete



--부서 이름이 uk pk 조건이 아니어서 pk인 id 값을 통해 fk 제약 조건을 만들어낸다.
1. emp_const 테이블 dept_name 컬럼 삭제
alter table emp_const drop column dept_name;

2. emp_const 테이블 dept_id 컬럼 추가
alter table emp_const add (dept_id number(5) ); -- dept_const 와 같은 date type으로 설정해야한다.

3. dept_id 컬럼은 dept_const테이블의 dept_id참조
alter table emp_const add constraint
emp_const_dept_id foreign key(dept_id) references dept_const(dept_id));

2+3==>
alter table emp_const add
(dept_id number(5) constraint
emp_const_dept_id references dept_const(dept_id)
);

-- 테이블 수정 제약조건 추가
alter table 테이블명 add constraint

--제약 조건 삭제법
alter table 테이블명 drop constraint 제약조건이름(emp_const_deptname_fk)

--not null 예외적 제약 조건 삭제법
alter table 테이블명 modify 컬럼명 null;




==========================================================================


TCL : Transaction Crontrol Lang 
: COMMIT / ROLLBACK 데이터 트랜젝션 제어
>트랜잭션 : 여러 단일 작업으로 이루어진 논리적 업무 단위

 = 여러 sql 구성 작업 단위
 따라서 1개 sql 오류 발생시 실행하지 않는다.
 
  2개 sql 실행이 문제 없이 실행 : 2개 sql 실행 이후 commit;
 1sql 싱행완료 but 2sql 실행 안됨 = 1sql 실행 복구 rollback;


ex)
a to b 계좌이체작업 : 논리적 1개
- but 단위로 나누게 되면
1> a 계좌 출금
2> b 계좌 입금

if)
1> a 계좌 출금		완료
-------------은행 서버 다운(이전 완료 1번 작업 원상태 복구)
2> b 계좌 입금		미완료
-------------계좌이체작업완료

트랜잭션 내부 포함 모든 단일 작업
all		완료 
or 
nothing 원상태 복구

계좌정보 : 레코드
레코드 수정 2개 sql : 모두 완료 되어야 커밋


===============================================

create table account(
acc_id number(10) constraint acc_id_pk primary key,
password number(10),
balance(잔액) number(10,2));

insert into account
values (1001,1111,10000);
insert into account
values (2001,2222,0);

commit;

===============================================


select : 조회 : 데이터에 변화가 없기 때문에 커밋 롤백 x
ddl : 자동 commit;
dml : 커밋 롤백 처리해야한다.
 
drop rollback 불가
delete rollback 가능

트랜잭션 언제 시작 종료 하는가
db client tool 시작 - 트랜잭션 시작
insert
update
delete		commit / rollback - 트랜잭션 종료
자동 트랜잭션 시작
insert
update
delete		commit / rollback - 트랜잭션 종료
....
sql plus : 종료시 자동 commit
sql developer : 종료시 커밋/롤백 선택



1001 계좌에서 2001 계좌 5000원 이체
1> 1001계좌 5000원 출금 = 잔액 변경
update account
set balance = balance -5000
where acc_id = 1001;
2>2001계좌 5000 입금 = 잔액 변경
update account
set balance =+ 5000
where acc_id = 2001;
3>완료
commit; --트랜잭션 종료
--트랜잭션 시작
4>insert into account values(3001,3333,50000);
select * from account;
-- 현재 insert 영구적 저장x : 임시 메모리 저장 : 
--같은 session 확인가능, 다른 session 확인불가
commit; --트랜잭션 종료 ( 결과 db 반영하고 트랜잭션 종료)
--트랜잭션 시작
delete account where acc_id = 3001;
rollback; -- 트랜잭션 종료 ( sql 결과 취소 후 트랜잭션 종료)

=============================================================================

--데이터 로킹 (Lock)

-주의사항!!!
1 ddl 실행 이전 dml문장 : commit/rollback 설정
	-DDL은 입력과 동시에 자동 COMMIT 된다.
2. 트랜잭션 진행중인 dml 다른 session 사용 불가능(lock : 다른 session 멈춤)
3. 트랜잭션의 단위는 각각의 개인이 결정해야한다 규칙이 있지 않다.

--자바 + sql : sql 실행 멈춤상황 예시 ( lock )
--트랜잭션 시작
--sql developer 에서 밑 sql 입력
update account
set balance = balance*1.1
where acc_id = 3001;
--sqlplus에서 밑 sql 입력
update account 
set balance = balance+10000 
where acc_id = 3001;
--sqlplus 멈춤 ( lock 이 걸려있다)
--sql developer 에서 밑 sql 입력
rollback; -- sqlplus에서 lock 이 해제 된다
--sqlplus에서 밑 sql 입력
rollback; -- sql developer 락 해제


--트랜잭션 시작
--sql developer 에서 밑 sql 입력
update account
set balance = balance*1.1
where acc_id = 3001;

create table transactiontest (a number(1)); -- 자동 커밋

--sqlplus에서 밑 sql 입력
update account 
set balance = balance+10000 
--lock 이 걸려 있지 않다 왜냐 create table(ddl)명령으로 인해 자동 커밋


===================================================================



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

===========================================================================



http://www.gurubee.net/oracle/plsql 강좌

PL/SQL 
: procedural language extention to structured query language
결과 저장 변수, 반복, 조건 포함 블럭

SQL : 한번에 1개의 SQL 실행
MAIN QUERY (SUBQUERY) MAIN 이주로 2개라 볼 수 없다
1번에 여러개 SQL 실행할 수 있는 블럭 구조 생성 INSERT SELECT UPDATE ...

PL/SQL
1. 한번에 여러개 SQL 실행 블럭 구조
2. SQL 실행결과를 변수에 저장 가능 = 메로리 공간 데이터 값 저장
3. 조건문
4. 반복문

pl/sql 프로그램을 논리적인 블록으로 나누는 구조화 된 블록 언어 이다.
		선언부(선택적), 실행부(필수적), 예외 처리부(선택적)로 구성, BEGIN과 END 키워드는 반드시 기술

--주의사항!!!
SQL : DQL, DML, TCL 문장 그대로 사용 + pl/sql 변수 사용
	DDL,DCL : pl/sql 사용x : create table a, drop table a,...
	
--pl/sql 출력 설정(오라클 출력)
출력 전제조건 설정 : SET SERVEROUT ON;
DBMS_OUTPUT.PUT_LINE(출력내용);
	
--pl/sql 에 들어가는 sql문
-insert into 테이블명 values(!변수명!...)
-update 테이블명 set 컬럼명 = !변수명!
-where 컬럼명 연산자 !변수명!
-delete 테이블명 where 컬럼명 연산자 !변수명!
-------------------------------
-3.select 컬럼명 
 4.into !변수명!
 1.from 테이블명
 2.where 컬럼명 연산자 !변수명!
-------------------------------


--PL/SQL 종류
1. function
2. procedure
3. trigger
4. package

	
	
--공통 문법
=> 정의 + 실행 = 결과물
=> 정의하여 DB에 영구적 저장(PL/SQL 이름 설정) + 필요시 여러번 실행(이름을 통해 호출)

DECLARE
- Optional
- Variables, cursors, user-defined exceptions
BEGIN
- Mandatory
- SQL Statements
- PL/SQL Statements
EXCEPTION
- Actions to perform when errors occur
END
- Mandatory
-------------------------------------------------
Declarative Section(선언부)
- 변수, 상수, CURSOR, USER_DEFINE Exception 선언
Executable Section(실행부)
- SQL, 반복분, 조건문 실행
- 실행부는 BEGIN으로 시작하고 END로 종료된다.
- 실행문은 프로그램 내용이 들어가는 부분으로서 필수적으로 사용되어야 한다.
Exception Handling Section(예외처리)
- 예외에 대한 처리.
- 일반적으로 오류를 정의하고 처리하는 부분으로 선택 사항이다.
-------------------------------------------------
DECLARE
연산 데이터, 연산 결과 메모리 저장
컴퓨터 메모리 저장값 = 변수(PL/SQL, JAVA, HTML,...)
변수선언문장 (statement);
 v_salary number := 20000; 초기화
 v_tax number[:=null];
 변수이름	  타입	할당(대입)연산 값;
1.변수이름 = _#$ +숫자+일반문자/30자/숫자시작x/키워드x
2.타입 : number, date, varchar2, boolean(T,F)
BEGIN
연산실행내용
출력실행내용
실행내용문장 (statement);
 +*-/ 가능
 DBMS_OUTPUT.PUT_LINE('출력내용'||100);
 V_TAX := V_SALARY*0.07 ;
--[EXCEPTION =BEGIN문장 오류 발생시 자동 실행]
END;
/
=> 정의 + 실행 = 결과물
=> 정의하여 DB에 영구적 저장(PL/SQL 이름 설정) + 필요시 여러번 실행(이름을 통해 호출)



---------------------------------------------------------------------------


-employees 테이블에서 사번이 100번인 사람의 salary 컬럼의 7% 세금으로 계산 조회 
pl/sql 블록
-급여 20000의 7% 세금 계산 출력
급여 20000에 대한 7% 세금 = xxxx
--sql 
select 20000, 20000*0.07
from dual;

--pl/sql
declare
v_salary number := 20000;
v_tax number;
begin
v_tax := v_salary*0.07;
dbms_output.put_line('급여 '||v_salary||'의 7% 세금= '||v_tax);
end;


-10000 값의 1.5% 세금 계산
DECLARE
V_SALARY NUMBER:= 10000;
V_TAX NUMBER := V_SALARY * 0.15;
BEGIN
DBMS_OUTPUT.PUT_LINE
('급여 '||V_SALARY||' 의 1.5% 세금 계산결과: '||V_TAX);
END;
/

-45000, 1111, 5000 account 테이블에 insert
declare
v_id number := 45000;
v_pw number := 1111;
v_balance number := 0;
begin
insert into account(acc_id, password, balance)
values (v_id, v_pw, v_balance);
commit;
end;
/


--employees 테이블에서 사번 100인 사원의 salary 칼럼의 7% 세금 계산 조회 pl/sql

declare
v_tax number ;
v_emp_id number := 200;
v_salary number ;
begin
select salary, salary*0.07
into v_salary, v_tax
from employees
where employee_id =v_emp_id;
dbms_output.put_line( v_salary||' 월급으로인해 사번 ' || v_emp_id||' 번의 세금 :'||v_tax|| ' 를 납부하셔야 합니다');
end;
/



--사번 200번인 사람의 급여를 사번 100번이 받는 급여로 수정
update employees
set salary = (사번 100번이 받는 급여)
where employee_id = 200;


update employees
set salary = v_salary
where employee_id = 200;

declare
v_tax number ;
v_emp_id number := 200;
v_salary number ;
begin
select salary, salary*0.07
into v_salary, v_tax
from employees
where employee_id =v_emp_id;
dbms_output.put_line( v_salary||' 월급으로인해 사번 ' || v_emp_id||' 번의 세금 :'||v_tax|| ' 를 납부하셔야 합니다');

update employees
set salary = v_salary
where employee_id = 200;
commit;

end;
/

==============================================================================



1.FUNCTION

오라클 내장함수 sysdate, max ,avg
오라클 사용자 함수 : 내장함수 기능이 아닌 다른 기능을 사용자가 정의
함수 = function: 함수의 결과는 단 1개의 값 
			  : 여러개 데이터가 함수 기능과 연관 조작되어 1개의 결과 리턴 pl/sql 종류
select round(123.456, 1) from dual; => 123.5
round(123.456, 0) => 123
round(123.456, -1) => 120

-필요 데이터를 외부로부터 전달받아서 기능을 적용하여 결과 1개 리턴
: 1개의 정의 DB 저장/ 여러번 호출 사용가능


--FUNCTION 문법
create or replace function 함수명(외부로부터 전달받을 변수=매개변수=parameter변수 !in!)
return 리턴값 타입-----------------------------필수 : 함수 리턴 결과 타입 알려줌
is											|
함수 내부 변수선언(지역변수)							|			
begin										|
실행내용문장;									|
return(리턴값=단 1개의 값만 리턴);-----------------필수 : 어떤 변수값 리턴
end;
/


--실행문법
EXECUTE:변수명 := 함수명(매개변수);

--SQLPLUS 변수 선언
VARIABLE 변수명 타입 ;(SQLPLUS 종료시 삭제)

--SELECT 문에서 사용 가능
SELECT 함수명(컬럼명) FROM 테이블명

--function 정보확인 = desc user_source
select text from user_source
where name='TAX_FUNC'
ORDER BY LINE;

--FUNCTION 삭제
drop function tax_func;


---------------------------------------------------------------------------



-10000의 세금 5% 세율 FUNCTION 
DECLARE
V_DATA NUMBER := 10000;
V_TAX NUMBER := 0.05;
V_RESULT NUMBER;
BEGIN
V_RESULT := V_DATa * V_TAX;
DBMS_OUTPUT.PUT_LINE('세금 = ' || V_RESULT);
END;
/

--(HR 계정객체(TABLE,VIEW,SEQ,...) 중복X + 이름규칙)
CREATE FUNCTION TAX_FUNC 
RETURN NUMBER------------------------------------ 함수 리턴 결과 타입 알려줌
IS												|
V_DATA NUMBER := 10000;							|
V_TAX NUMBER := 0.05;							|
V_RESULT NUMBER;
BEGIN											|
V_RESULT := V_DATa * V_TAX;						|
DBMS_OUTPUT.PUT_LINE('세금 = ' || V_RESULT);
return(v_result);-------------------------------- 어떤 변수값 리턴
END;
/


-- dbms_output.put_line() 설정
set serverout on;

--변수 result 선언
variable result number; 
-- RESULT 출력
print result;

--실행구문
execute:result:= tax_func;
print reult;

--FUNCTION 삭제
drop function tax_func;

-------------------------------------
select first_name, salary, tax_func(salary) from employees;

CREATE or replace FUNCTION TAX_FUNC(v_data in number)--System.in 같은 개념
RETURN NUMBER
IS												
V_TAX NUMBER := 0.05;							
V_RESULT NUMBER;
BEGIN											
V_RESULT := V_DATa * V_TAX;						
DBMS_OUTPUT.PUT_LINE('세금 = ' || V_RESULT);
return(v_result);
END;
/

CREATE or replace FUNCTION TAX_FUNC(v_data in number)--System.in 같은 개념
RETURN NUMBER
IS												
V_TAX NUMBER := 0.05;							
V_RESULT NUMBER;
BEGIN											
V_RESULT := V_DATa * V_TAX;	
return(v_result);
END;
/


execute:result:= tax_func(50000);
print result;

select first_name, salary, tax_func(salary) from employees;




--------------------------------------------

- function 생성(emp_date_func)
employees 테이블에서 매개변수로 입력 사번 사원의 입사월 조회하여 리턴 
variable hire_date varchar2;
execute :hire_date  := emp_date(100);
print hire_date;



CREATE OR REPLACE FUNCTION EMP_DATE(EMP_ID IN NUMBER)
RETURN NUMBER
IS
HIRE_D NUMBER;
BEGIN
SELECT TO_CHAR(HIRE_DATE,'MM')
INTO HIRE_D
FROM EMPLOYEES WHERE EMPLOYEE_ID = EMP_ID;
RETURN(HIRE_D);
END;
/

variable hire_date varchar2;
execute :hire_date  := emp_date(100);
print hire_date;



=============================================================================



2. procedure

FUNCTION : 매개변수 = 전달데이터변수 갯수 다양
			기능 수행 결과 1개 리턴
			
PROCEDURE : 매개변수 다양
			기능 수행 결과 리턴값X/ 출력 2개이상 가능



CREATE OR REPLACE 프로시져명(IN,IN,...,OUT,OUT,...)
-매개변수 = PARAMETER 변수( 이름 타입)
이름 [IN] | OUT | INOUT 타입
IS
지역변수 선언 (이름 타입) := 값(초기화)
타입
날짜/문자/정수/실수 + (TRUE,FALSE,NULL)
DATE/VARCHAR2/NUMBER + BOOLEAN

BEGIN

-PL/SQL			-호출환경
IN		<----	SQLPLUS/TOOL
OUT		---->	자바프로그램 호출
INOUT	<--->

END;


--SQLPLUS 변수 선언
VARIABLE 변수명 타입 ;(SQLPLUS 종료시 삭제)

--실행문법
EXECUTE 프로시져명(IN(매개변수값), :OUT(:SQLPLUS변수명));

--SELECT 문에서 사용 불가 => 출력값이 여러개
X SELECT 프로시져명(컬럼명) FROM 테이블명

--%TYPE 동등한 타입 가져오기

IS
V_DATA NUMBER; => V_DATA EMPLOYEES.SALARY%TYPE;
BEGIN
SELECT SALARY
INTO V_DATA
FROM EMPLOYEES
END;
/




		
---------------------------------------------------------------------------

create or replace PROCEDURE TAX_PROC (V_DATA IN NUMBER)
is
V_TAX := 0.05;
begin
DBMS_OUTPUT.PUT_LINE(V_DATA * V_TAX);
end;
/

create or replace PROCEDURE TAX_PROC (V_DATA IN NUMBER, V_RESULT OUT NUMBER)
is
V_TAX NUMBER:= 0.05;
begin
DBMS_OUTPUT.PUT_LINE(V_DATA * V_TAX);
V_RESULT := V_DATA * V_TAX;
end;
/
SHOW ERRORS;


VARIABLE P_RESULT NUMBER;
PRINT R_RESULT;

EXECUTE TAX_PROC(IN,:OUT);
EXECUTE TAX_PROC(10000,:P_RESULT);

--------------------------------------------

- procedure 생성(emp_insert_proc)
employees 테이블에 
사번 1000
성 홍
이름 길동
이메일 gil@kitri.com
직종 IT직종 (job_id : 'IT_PROG')
입사일 18/10/16

데이터 입력
단 사번, 성, 이름, 이메일은 실행시마다 변경될 수 있으므로 파라미터로 전달받는 것으로 생성
실행 완료시 '1000 번 사번 등록 완료' 출력


CREATE OR REPLACE PROCEDURE EMP_INSERT_PROC
(EMP_ID IN employees.employee_id%type, LAST_N IN employees.last_name%type, 
FIRST_N IN employees.first_name%type, EMA IN employees.email%type, 
SYSD IN employees.hire_date%type, JOBID IN employees.job_id%type)
IS
BEGIN
INSERT INTO EMPLOYEES (EMPLOYEE_ID, LAST_NAME, FIRST_NAME, EMAIL,HIRE_DATE,JOB_ID)
VALUES (EMP_ID, LAST_N, FIRST_N, EMA,SYSD,JOBID);
dbms_output.put_line(emp_id ||' 번 사번 등록 완료');
COMMIT;
END;
/
SHOW ERROR;

EXECUTE EMP_INSERT_PROC(1000,'홍','길동','GIL@KITRI.COM',SYSDATE,'IT_PROG');
EXECUTE EMP_INSERT_PROC(2000,'홍','길동','AIL@KITRI.COM',SYSDATE,'IT_PROG');
EXECUTE EMP_INSERT_PROC(3000,'홍','길동','BIL@KITRI.COM',SYSDATE,'IT_PROG');


======================================================


-- PL/SQL EXCEPTION 예외처리

 3.select 컬럼명 -----두타이아한
 4.into !변수명!------개입같야다
 1.from 테이블명
 2.where 컬럼명 연산자 !변수명!
 
 (PL/SQL SELECT~INTO 조회시 : 레코드 !1개만! 검색) - 2개 이상/ 0개 : 오류
 select SALARY from employees where employee_id >=200;


 1. EXCEPTION문구 이용 오류해결
 
 create or replace function|procedure 이름
 (매개변수들)
 is
 --begin
 실행시 오라클 지정 내장 오류 발생O : 문장 중지하고 EXCEPTION 이동 지시 실행
 실행시 오라클 지정 내장 오류 발생X : EXCEPTION 실행X
 
 --exception
 WHEN 오라클내장예외이름 THEN 실행문장;
 
 end;
 /

 263페이지 예외처리
 NO_DATA_FOUND : 0개 데이터 조회  
 TOO_MANY_ROWS2 : 2개 이상 데이터 조회 
 NOT_LOGGED_ON : 데이터베이스에 연결 상태를 판단
 VALUE_ERROR : 변수의 길이보다 큰 값을 저장하는 경우
 ZERO_DEVIDE : 열의 값을 0 값으로 나누는 경우
 INVAILD_CURSOR : 커서 선언의 SELECT 문에 대한 연산이 부적절한 경우
 DUP_VAL_ON_INDEX : UK INDEX가 설정된 열에 중복 값을 입력하는 경우
 
 -- 사용자 정의 예외 (User-Defined Exceptions)
 http://www.gurubee.net/lecture/1073
 
  - STEP 1 : 예외의 이름을 선언 (선언절)

  - STEP 2 : RAISE문을 사용하여 직접적으로 예외를 발생시킨다(실행절)

  - STEP 3 : 예외가 발생할 경우 해당 예외를 참조한다(예외절)
  
  create or replace procedure fact_proc
(v_param in number)
is
result number := 1;
v_pa number := v_param;
v_start number := 1;
error exception;

begin
if(v_param <=0) then
raise error;
end if;


for v_start in 1..v_pa
loop

result := v_start * result;
dbms_output.put_line(v_start||'! = '||result);

end loop;

exception
when error then raise_application_error
(-20000 , v_param|| ' : 팩토리얼 구할 수 없습니다');

end;
/
show error

 ------------------------------------------------------------
 
  PL/SQL 블럭 하나를 파일 하나로 저장하여 보관

CREATE OR REPLACE PROCEDURE EMP_SELECT_EXCEPTION
(NAME IN EMPLOYEES.FIRST_NAME%TYPE)

IS
FULL_NAME EMPLOYEES.FIRST_NAME%TYPE;

BEGIN
SELECT LAST_NAME || ',' || FIRST_NAME
INTO FULL_NAME
FROM EMPLOYEES WHERE FIRST_NAME = NAME;
DBMS_OUTPUT.PUT_LINE('조회사원 전체이름 = '|| full_name);

EXCEPTION
WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('존재하지 않는 사원입니다');
WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('중복 이름의 사원입니다');

END;
/

- @ - 저장한 명령어를 불러와서 실행시키는 명령어
	@ C:\Users\hushe\Desktop\ORACLE_DB\20181016\EMP_SELECT_EXCEPTION -- .SQL의 경우 확장자 넣지 않아도 된다.

 
 
 
============================================================================

sql 없는 기능(pl/sql의 특징) -변수선언 저장, 조건문, 반복문, 예외처리

1.조건문

--조건식 : boolean 형태 만족
 참, 거짓 : true, false
 if(salary is null)
 if(1=1)
 if(0=1)
=, !=(<>) , >, >= , is null , is not null, and , or, not
if(salary is null and commission_pct is null) 

--pl/sql 조건문1
if then else elsif end if

--pl/sql 조건문2
CASE WHEN ELSE ELSIF END CASE

----------------------------------------
if(조건식) then 
조건만족 실행문장1; 
조건만족 실행문장2;

end if;
----------------------------------
 if(조건식) 
 then 조건만족 실행문장1; 
 else 조건만족 실행문장2;

end if;
-----------------------------------
   if(조건식) 
 then 조건만족 실행문장1; 
 elsif then 조건1 불만족 조건 2실행문장;
 elsif then 조건2 불만족 조건 3실행문장;
 else 위 모든 조건 false 수행 문장;
end if;

------------------------------------
CASE
WHEN 조건식 THEN 만족 수행 문장;
WHEN 조건2 THEN 만족 수행 문장;
WHEN 조건3 THEN 만족 수행 문장;
ELSE 조건을 모두 만족하지 않는 경우 문장;
END CASE;
--케이스 에서 else는 필수다 없을시 예외발생



---------------------------------------------------------------------------
 
 -특정 사번 사원 급여 조회
 20000 이상 일경우 : 임원급입니다.
 15000 이상 일경우 : 부장급입니다.
 10000 이상 일경우 : 과장급입니다.
 나머지 : 사원급입니다.
 
 
 create or replace procedure print_emp_salary
(id in employees.employee_id%type)

is
result_salary employees.salary%type;

begin					
 select salary
 into result_salary
 from employees where employee_id = id;
	
 if(result_salary>=20000) then 
	dbms_output.put_line('임원급입니다');
 elsif(result_salary>=15000) then
	dbms_output.put_line('부장급입니다');
elsif(result_salary>=10000) then
	dbms_output.put_line('과장급입니다');
else 
	dbms_output.put_line('사원급입니다');
 end if;
 end;
 /
 
  execute print_emp_salary (100);
  

 
----------------------------------------------------------------------------


create or replace procedure print_emp_salary2
(id in employees.employee_id%type)

is
result_salary employees.salary%type;
result_out varchar2(100);
begin					
 select salary
 into result_salary
 from employees where employee_id = id;
	
CASE
WHEN result_salary>=20000 THEN result_out := '임원';
WHEN result_salary>=15000 THEN result_out := '부장';
WHEN result_salary>=10000 THEN result_out := '과장';
ELSE result_out := '사원';
END CASE;
dbms_output.put_line(result_out||' 급입니다.');

end;
/
 
execute print_emp_salary2 (100);

-----------------------------------------------------------------------



=============================================================================



2.반복문 


--반복문 구성

	loop   --> 최소 1번은 반복 실행이 필요할 경우
	반복실행문장
	반복횟수변화(v_su = v_su+1)
	exit when boolean(반복중단조건식);;
		= if(반복중단조건식) then exit; end if;
	end loop;

	-----------------------------------------

	for 변수 in 범위1.. 범위2 --> 유한횟수의 반복을 가질때
	loop
	반복실행 문장;
	필요없다!!!반복횟수변화(v_su = v_su+1)
	end loop;

	-------------------------------------------

	while 조건식(동안) --> 0번 이상 반복 실행이 필요할 경우
	loop
	반복실행문장;
	end loop;

	------------------------------------------


-- 1~10 정수 출력

create or replace procedure print_int
(v_min in number, v_max in number)
is
v_su number := v_min-1;
begin

loop
v_su := v_su+1;
dbms_output.put_line(v_su);
exit when v_su = v_max;
end loop;

end;
/
show error;


-------------------------------
짝수만 출력
create or replace procedure print_int
(v_min in number, v_max in number)
is
v_su number := v_min -1;
begin

loop
v_su := v_su+1;

if( mod(v_su,2)=0) then
dbms_output.put_line(v_su);
end if;

exit when v_su = v_max;
end loop;
end;
/
show error;

--or 컴퓨터에게 효율적인 방법을 생각해보라!!!!!!!
짝수만 출력
create or replace procedure print_int
(v_min in number, v_max in number)
is
v_su number := v_min -2;
begin

loop
v_su := v_su+2;

--if( mod(v_su,2)=0) then
dbms_output.put_line(v_su);
--end if;

exit when v_su = v_max;
end loop;
end;
/
show error;


--------------------------------------------------------------------------

--부서번호 10~270부서의 부서명 조회
-- 27번 반복: 부서번호 +10

create or replace procedure dept_find

is
dept_name departments.department_name%type;
v_su number;
max_dept number;


begin
select count(*) into max_dept from departments;

for v_su in 1..max_dept
loop
select department_name 
into dept_name --변수선언
from departments
where department_id = v_su*10; 
dbms_output.put_line(v_su*10||' , '||dept_name);

end loop;
end;
/
show error


---------------------------------------------------------------


create or replace procedure print_int_while
(v_min in number, v_max in number)
is
v_su number := v_min - 1 ;

begin
while v_su <v_max
loop

v_su := v_su + 1;
dbms_output.put_line(v_su);

end loop;

end;
/
show error;







==========================================================================






http://www.gurubee.net/lecture/1064

cursor 사용 : 반복문

1> 오라클 sql 작업 결과 저장 영역 입니다.
2> 프로그래머에 의해 선언되며 이름이 있는 cursor 정의 가능
3> 조회 결과 메모리 저장 영역 접근 참조 포인터

1. 선언 declare ( is 부분)
cursor 커서이름
is
select first_name from employees
where employee_id >= 300;
-----------------

2. 사용 --(begin 부분)
open cursor이름; 
loop

fetch cursor명
exit when cursor 내부 조회 데이터 없을 때
...출력...

end loop;
close cursor;

--전체 구성

	create proc
	is
		cursor 커서명
		is
		select * from departments where ...; 
		(pk의 경우 유니크 조건이 있어 커서 필요 없다.)
		
		면수명 타입;(fetch 한 데이터를 받을 변수)
		...
		...
		
	begin
		open 커서명;
		loop
		
		fetch 커서명 into 변수명1, 변수명2,... ;
		exit when 커서명%notfound; (커서의 변수)
		dbms_output.put_line(변수1);
		dbms_output.put_line(변수2);
		
		end loop;
		close 커서명;
	end;
	/

							____________
							|			|
							V 			^(no)
declare		> open		> fetch		> empty		> close
이름있는 sql	cursor활성화	커서의 현재		현재행의 존재	커서가 사용한
영역생성					데이터행을 해당	여부검사		자원을 해제
						변수에 넘긴다.	레코드가 없으면
									fetch하지 않음
									
--변수 타입

number			테이블명.컬럼명%type
varchar2		변수명%type
date			테이블명%rowtype -테이블의 모든 컬럼타입 가져온다
boolean	
		

--cursor의 속성값을 저장한 변수들

cursor명%rowcount 
cursor명%found 
cursor명%notfound  
cursor명%isopen 
		

===========================================================

--select employee_id from employees;

create or replace procedure emp_cursor1
is
v_id employees.employee_id%type;

cursor emp_id_cursor
is
select employee_id from employees;

begin

open emp_id_cursor;

 loop
 
  fetch emp_id_cursor into v_id;
  exit when emp_id_cursor%notfound;
  dbms_output.put_line(v_id);
 
 end loop;
 
close emp_id_cursor;

end;
/
show error 

exec emp_cursor1;

------------------------------------
--%rowtype
--select employee_id from employees;

create or replace procedure emp_cursor2
is
v_emp employees%rowtype;
v_cnt number := 0;

cursor emp_id_cursor
is
select * from employees;

begin

open emp_id_cursor;

 loop
 
  fetch emp_id_cursor into v_emp;
  exit when emp_id_cursor%notfound;
  dbms_output.put_line
  ('사번: '||v_emp.employee_id||
  '  이름: '|| v_emp.first_name||
  '  급여: '||v_emp.salary);
  v_cnt := v_cnt+1;
 
 end loop;
 dbms_output.put_line
  ('레코드 갯수= '|| emp_id_cursor%rowcount);
  dbms_output.put_line(v_cnt);
close emp_id_cursor;
if(emp_id_cursor%isopen) then
 dbms_output.put_line
  ('레코드 갯수= '|| emp_id_cursor%rowcount);
end if;

end;
/
show error 

exec emp_cursor2;	


===================================================================

http://blog.kjslab.com/20

--오라클 프로시저 커서 (CURSOR) 3가지 생성 방법.

1.커서의 내용을 미리 정의 해 놓고 사용하는 방법.

DECLARE
  CURSOR C_LIST IS
    SELECT MY_ID FROM MY_TABLE WHERE 조건;
BEGIN

  FOR I_ID IN C_LIST LOOP
    DBMS_OUTPUT.put_line(I_ID);
  END LOOP;
END;
비추천 
커서의 내용을 정할 때 select 문제 동적으로 parameter가 넘어가야 할 경우 사용이 불가능 하다. 
왜냐하면 --BEGIN 전에 정의하기 때문이다.


2.커서 변수를 미리 만들어 놓고 불러서 사용하는 방법.

DECLARE
	I_ID   VARCHAR2(100);		-- 변수 정의				
  C_LIST SYS_REFCURSOR;		-- 커서 정의
BEGIN
  OPEN C_LIST FOR
  SELECT MY_ID   
    FROM MY_TABLE
    WHERE 조건;
  LOOP					-- LOOP 돌기.
      FETCH C_LIST
      INTO  I_ID;			--  하나씩 변수에 넣기.
      EXIT WHEN C_LIST%NOTFOUND;	-- 더이상 없으면 끝내기.
      DBMS_OUTPUT.put_line(I_ID);    --  출력
  END LOOP;
  CLOSE C_LIST;
END;
재사용성이 있어서 나름 괜찮음. 
커서를 정의 한 뒤 그 때 그 때 커서의 내용을 채우는 방법이다.

3.동적으로 커서를 생성해서 사용하는 방법

DECLARE

BEGIN

  FOR C_LIST IN (SELECT MY_ID FROM MY_TABLE WHERE 조건) 
  LOOP
    DBMS_OUTPUT.put_line(C_LIST.I_ID);
  END LOOP;
END;
강추~!!
커서를 미리 정의 할 필요도 없고, 변수를 미리 만들어 놓을 필요도 없다.


======================================================



3. PACKAGE : emp 테이블 연관 procedure을 1개의 이름 구성 관리
--생성 실행 순서
1>패키지 선언 = 함수와 프로시져 포함 선언
create or replace package emp_pack
is
	procedure emp_salary_proc(id in number);
	function emp_dept_func(name in varchar2)
	return number;
end;
2>패키지 바디 구성
create or replace package body emp_pack
	create procedure emp_salary_proc(id in number)
	is
	begin
	end;
	create function emp_dept_func(name in varchar2)
	return number
	is
	begin
	end;
end;
3>패키지의 함수나 프로시져 수행
exec emp_pack.emp_salary_proc(100)

dbms_output   .   put_line(입력변수);--Sys.out.println();
오라클 내장패키지명  .   프로시져명(입력변수);
dbms_output.put(); --Sys.out.print();
dbms_output.new_line(); --



========================================================


4. TRIGGER
함수나 프로시져, 패키지 : 정의 + db생성 + 실행 + 결과확인

TRIGGER : 정의 + db생성 + 특정 조건이나 상태를 만족시 자동실행


--------------------------------------------------------

-- 생성

create or replace trigger 이름 -- (매개변수 줄 수 없다!!!) 자동실행 되기 때문에
before(|after) insert(|delete|update) on emp(테이블명)

declare
변수명 타입;
--for each row

begin
실행내용(emp 테이블에 insert 실행 직전 먼저 실행)
end;


--------------------------------------------------------


- employees 테이블에 신입 사원 등록한다.
300번 부서코드 부서 배치.
사번 500 , '신입', '이', 'new@kitri.com', 0102223333, sysdate, 'IT_PROG', 1000, null, 상사200, 부서300


insert into employees
values (500 , '신입', '이', 'new@kitri.com', 0102223333,
 sysdate, 'IT_PROG', 1000, null, 200, 300)
 >>>integrity constraint (HR.EMP_DEPT_FK) violated - parent key not
	
select constraint_name,
constraint_type,
table_name,
search_condition
from USER_CONSTRAINTS
where constraint_name = 'EMP_DEPT_FK';	
	
>> 300번 부서가 테이블에 존재하지 않아서 예외가 발생
따라서 300번 부서가 DEPARTMENTS 테이블에 INSERT 된 뒤에 신입사원 입력

create or replace trigger emp_insert_tri
--employees 테이블 insert 이전
before insert on employees

begin
  insert into departments values(300,'신생부서',100,1700);
  --commit; 불가하다!!!
end;
/
show error
	
	
>>
insert into employees
values (500 , '신입', '이', 'new@kitri.com', 0102223333,
 sysdate, 'IT_PROG', 1000, null, 200, 300);	
 
 >>
 insert into employees
values (501, '신입', '박', 'new2@kitri.com', 0102223333,
 sysdate, 'IT_PROG', 1000, null, 200, 300);	
	
	
>>300번 부서가 insert 때마다 추가 되는 예외 수정	
create or replace trigger emp_insert_tri
--employees 테이블 insert 이전
before insert on employees
declare
 cnt number;
 
begin
 select count(department_id)
 into cnt
 from departments
 where department_id = 300;
 
 if(cnt =0) then
  insert into departments values(300,'신생부서',100,1700);
  --commit; 불가하다!!!
 end if;
end;
/
show error
	
	
>> 부서가 없어서 입력 불가
insert into employees
values (502, '신입', '김', 'new3@kitri.com', 0102223333,
 sysdate, 'IT_PROG', 1000, null, 200, 400);	
	
>>:new.department_id , for each row
create or replace trigger emp_insert_tri
--employees 테이블 insert 이전
before insert on employees
for each row
declare
 cnt number;
 
begin
 select count(department_id)
 into cnt
 from departments
 where department_id = :new.department_id;
 
 if(cnt =0) then
  insert into departments values(:new.department_id,'신생부서',100,1700);
  --commit; 불가하다!!!
 end if;
end;
/
show error	
	
	
	
>>
insert into employees
values (503, '신입', '최', 'new4@kitri.com', 0102223333,
 sysdate, 'IT_PROG', 1000, null, 200, 401);	

 >>
insert into employees
values (504, '신입', '조', 'new5@kitri.com', 0102223333,
 sysdate, 'IT_PROG', 1000, null, 200, 401);	























