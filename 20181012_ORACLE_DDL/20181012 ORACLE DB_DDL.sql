
6장 DATA  DATA DEFINITION LANG.(데이터 구조 정의어 = DB 객체 관련 SQL)



데이터베이스>다수 사용자(hr)>다수 테이블 > 다수 레코드(컬럼 구성)

ORACLE = RDB( Relational : 관계형 )
데이터 관계 테이블형태 구성

create table~ : 테이블 생성 SQL
alter table~ : 테이블 구조변경 SQL
drop table~ : 테이블 삭제 SQL









테이블이름 , 컬럼이름
1. 대소문자 구분 없다.
2. DB 저장시 대문자 저장(테이블이름 조회시 대문자)
3. 30자 까지 가능
4. 숫자, 문자, _$#, 구성가능
5. 숫자로 시작 불가능
6. SQL 예약어 이름으로 사용 불가능 CREATE TABLE
7. 공백X


(오라클 DB : 독자적 > 표준화)
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







1.EMP 테이블 생성 = 사원데이터
사원데이터 구성요소(COLUMN) = 사번, 이름 , 급여 , 입사일자, 부서명
EMP_ID : 사번 : 10자리 정수
NAME : 이름 : 하글 4자리(12byte)
SALARY : 급여 : 정수자리수8, 2 실수
INDATE : 입사일자
DEPT_NAME : 부서명

create table EMP(
EMP_ID number(10) not null
constraint pk_emp_id primary key,
NAME varchar2(20),
SALARY number(8,2),
INDATE date ,
DEPT_NAME varchar2(50));


2.DEPT 테이블
DEPT_ID : 부서코드 : NUMBER(5)
DEPT_NAME : 부서명 : VARCHAR2(50)
DEPT_MANAGER_ID : 부서장 사번 : 사번에 포함 : NUMBER(10)

create table DEPT(
DEPT_ID number(5) not null,
DEPT_NAME varchar2(50),
DEPT_MANAGER_ID number(10),
constraint pk_dept_id primary key (DEPT_ID));






1. 새롭게 생성
emp,dept 테이블 생성 = 데이터 구조정의

2. 기존 존재 테이블 복사 생성
-subquery 이용 테이블 생성
employees 테이블 : 107개
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

create table emp_none2
as
select * from employees
where 3=0;

-기존 테이블 컬럼추가, 컬럼삭제, 컬럼이름, 타입, 길이 변경
-- 구조변경
alter table 테이블명 


1.컬럼 추가
alter table 테이블명 add(컬럼명 타입(길이))
emp 테이블 성별 컬럼 : gender : number(1) 0/1 : varchar2 (6) f/m
alter table emp add(
GENDER varchar2(6));


2.컬럼 수정(데이터 존재 O/X)
alter table emp modify (gender number(1));

emp_copy 테이블에서 employee_id 컬럼 길이 3자리 변경
alter table emp_copy modify (employee_id number(3));
기존 컬럼에 데이터가 들어 있다면 서로 호환 되는 것 끼리만 데이터타입의 변경이 가능하다(거의 불가능)

-컬럼 이름 변경
alter table emp rename column 이전컬럼 to 새로운컬럼;
alter table emp rename column indate to hire_date;

3.컬럼 삭제
alter table emp drop column GENDER;
alter table emp drop (GENDER, , , );



1. 테이블명 수정
rename 이전테이블 to 새로운테이블 ;
rename 이전테이블 to 새로운테이블 ;

2. 테이블 삭제(복구불가)
drop table 테이블명;



===============================
-계정 생성(system 계정만 사용가능)
create user

conn system
project/1234
create user project identified by 1234;

grant connect, resource to project;





==================
제약 조건 constraint

emp : emp_id : 사번 : 사번중복불가 / not null
salary : 최저급여 1000/ 최대급여 10000 : 500입력 불가
gender : 0/1 , F/M
hire_date : 신입사원 입사일 sysdate : 명시 데이터가 없으면 오늘날짜 기본세팅

-제약조건 표현
constraint 제약조건이름(테이블명_컬럼_타입약자) 자약조건타입 부가조건

-제약조건 표현 종류
예외 default 기본값 설정(default sysdate)
1. primary key : UNIQUE+ NOT NULL
2. not null : 컬럼 값 존재(중복O)
3. unique : 컬럼 값 중복X(NULL O)
4. check(where절과 같음) : 사용자 정의 : 제약조건 외
5. foreign key : 다른 테이블 존재값 참조
*** 참조 사용 값 : unique/primary key 조건만 참조가능
즉 부모테이블이 uk/pk 자식테이블이 fk
EMP_CONST 테이블 : DEPT_NAME 컬럼
DEPT_CONST 테이블 : DEPT_NAME 컬럼 존재값 허용

dept_name varchar2(50) 
constraint emp_const_deptname_fk references dept_const(dept_name),

alter table (존재하는 컬럼에 제약조건 추가)
alter table 테이블명 add()
alter table 테이블명 modify()
alter table 테이블명 drop(column_name)
alter table table_name rename column old_column_name TO new_column_name;
alter table emp_const add constraint
emp_con_deptname_fk foreign key(dept_name)
references dept_const(dept_name)

drop table 삭제 후 / create table


--제약조건 확인 : USER_CONSTRAINTS
select * from dictionary; => 800개
desc user_constraints

select constraint_name,
constraint_type,
table_name,
search_condition
from USER_CONSTRAINTS
where table_name = 'EMP_CONST';

-- 제약조건 효력 : insert/update/delete





--dept_const 테이블
dept_id : number(5) : primary key
dept_name : varchar2(50) : not null
dept_manager_id : number(10) : emp_const테이블 emp_id컬럼 존재값만 허용


create table dept_const(
dept_id number(5) constraint dept_cont_id_pk primary key,
dept_name varchar2(50) constraint dept_const_name_nn not null ,
dept_manager_id number(10) 
constraint dept_const_manid_fk references emp_const(emp_id) );

-alter 사용시
alter table dept_const add constraint dept_const_manid_fk 
foreign key (dept_manager_id) references emp_const(emp_id);


--emp_const테이블

emp_id : number(10) : null x, unique
name : varchar2(20) : not null
salary : number(10,2) : low 20000
hire_date : date : 기본 sysdate
dept_name : varchar2(50) : 
gender : varchar2(6) : 'F'/'M' 만 가능


create table emp_const(
emp_id number(10) constraint emp_const_id_pk primary key,
name varchar2(20) constraint emp_const_name_nn not null,
salary number(10,2) constraint emp_const_slary_ck check (salary >=20000),
hire_date date default sysdate ,
dept_name varchar2(50) constraint emp_const_deptname_fk references dept_const(dept_name),
gender varchar2(6) constraint emp_const_gender_ck check(gender in ('F', 'M')),
);


부서 이름이 uk pk 조건이 아니어서 
pk인 id 값을 통해

1. emp_const 테이블 dept_name 컬럼 삭제
2. emp_const 테이블 dept_id 컬럼 추가
3. dept_id 컬럼은 dept_const 테이블의 dept_id 참조

alter table emp_const drop column dept_name;
alter table emp_const add dept_id number(5);
alter table emp_const add 
constraint emp_const_id_fk foreign key (dept_id)
references dept_const(dept_id);

1. emp_const 테이블 dept_name 컬럼 삭제
alter table emp_const drop column dept_name;

2. emp_const 테이블 dept_id 컬럼 추가
alter table emp_const add (dept_id number(5) );

3. dept_id 컬럼은 dept_const테이블의 dept_id참조
alter table emp_const add constraint
emp_const_dept_id foreign key(dept_id) references dept_const(dept_id));

2+3==>
alter table emp_const add
(dept_id number(5) constraint
emp_const_dept_id references dept_const(dept_id)
);

R foreign
P primary
U unique
C check, notnull(search_condition 컬럼 참조해서 구분)


fk :
1. 테이블 생성 제약조건 추가
2. 테이블 수정 제약조건 추가
alter table 테이블명 add constraint

-not null 예외적 제약 조건 삭제법
alter table 테이블명 modify 컬럼명 null;

-제약 조건 삭제법
alter table 테이블명 drop constraint 제약조건이름(emp_const_deptname_fk)


5장 dml (DATA MANIPULATION LANG.) 
생성 테이블 레코드 저장/수정/삭제
insert / update / delete

CRUD기능
CREATE / READ / UPDATE / DELETE
게시물 작성 - 게시물 저장 : INSERT
게시물 수정 : UPDATE
게시물 삭제 : DELETE
게시물 조회 : SELECT 


- insert into 테이블명(컬럼1, 2, 3)
values(값1, 2, 3);

- insert into 테이블명
values(값1, 2, 3);

- insert into 테이블명(컬럼1, 3)
values(값1, 3);

dept_const 테이블
10 인사부 null
20 총무부 null 
30 전산부 
40 교육부
50 영업부

insert into dept_const (dept_id, dept_name,dept_manager_id)
values ( 10, '인사부',null);
insert into dept_const 
values ( 20, '총무부',null);
insert into dept_const 
values ( 30, '전산부',null);
insert into dept_const 
values ( 40, '교육부',null);
insert into dept_const 
values ( 50, '영업부',null);
-제약조건 위반 예시
insert into dept_const 
values ( 60, null,null);
insert into dept_const 
values ( 50, '영업2부',null);
insert into dept_const 
values ( null, '영업2부',null);

select * from dept_const
commit;

-DEPARTMENTS 테이블에서 80번 부서의 
부서코드, 부서이름, 부서장 컬럼값을 DEPT_CONST 테이블에 저장

CREATE TABLE 테이블명
AS
SELECT~
=>테이블 생성 + 데이터 복사

INSERT INTO DEPT_CONST
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_ID = 80;
=>기존 테이블에 다른 테이블의 데이터 입력
=>FK 제약조건 위배 MANAGER_ID 145가 EMP_ID 145에 없다

INSERT INTO DEPT_CONST
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_ID = 90;
=>FK 제약조건 MAN_ID 100이 EMP_ID 100에 존재




emp_const 테이블
100 이사장 50000 '99/10/11' 50 'F'
200 박부장 40000 '05/10/11' 10 'M'
300 김과장 30000 '07/12/11' 10 'M'
400 최사원 20000 오늘 		  10 'F'
500 박신입 20000 default	  30 'M'

insert into emp_const (emp_id, name, salary, hire_date, dept_id, gender)
values (100, '이사장', 50000, '99/10/11', 50, 'F');
insert into emp_const (emp_id, name, salary, hire_date, dept_id, gender)
values (200, '박부장', 40000, '05/10/11', 10, 'M');
insert into emp_const (emp_id, name, salary, hire_date, dept_id, gender)
values (300, '김과장', 30000, '07/12/11', 10, 'M');
insert into emp_const (emp_id, name, salary, hire_date, dept_id, gender)
values (400, '최사원', 20000, sysdate , 10, 'F');
insert into emp_const (emp_id, name, salary, hire_date, dept_id, gender)
values (500, '박신입', 20000, DEFAULT , 30, 'M');
-DEFAULT 사용 예시
insert into emp_const (emp_id, name, salary, salary, gender)
values (600, '이신입', 20000, 'M');
-제약조건 위반 예시
insert into emp_const (emp_id, salary, salary, gender)
values (600, 20000, 'M');
insert into emp_const (emp_id, name, salary, salary, gender)
values (600, '이신입', 10000, 'M');
insert into emp_const (emp_id, name, salary, salary, gender)
values (600, '이신입', 20000, 'MALE');


--UPDATE
-레코드(여러개컬럼값) 일부 컬럼값 수정/삭제
update 테이블명 
set 수정컬럼명=수정값 [, 수정컬럼명2=수정값2]
[where 수정레코드추출조건식];

-dept_const 테이블 dept_manager_id 컬럼 
		null => 결정
부서장 나중에 결정 => 부서장 수정

dept_const 테이블 dept_manager_id 컬럼 null 값을 100사번으로 수정
update dept_const
set dept_manager_id = 100
where department_id is null; -- =null 은  'null'을 찾는 꼴

-최사원을 박신입의 부서로 이동 배치하자

update emp_const
set dept_id = (select dept_id from emp_const where name = '박신입')
where name ='최사원';

-최사원과 같은 월에 입사한 직원의 급여 10% 증가
update emp_const
set salary = salary + salary*0.1
where (select substr(hire_date,4,2) from emp_const) in
(select substr(hire_date, 4,2) from emp_const where name ='최사원');

update emp_const
set salary = salary*1.1
where to_char(hire_date,'mm') in
(select to_char(hire_date, 'mm') from emp_const where name ='최사원');


-인사부 소속 사원을 총무부 배치 변경
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



--delete

drop table 테이블명 > 복구불가
alter table 테이블명 drop colum 컬럼명 > 복구불가
alter table 테이블명 drop constraint 제약조건이름 > 복구불가

-테이블 구조 컬럼명, 제약조건 설정
데이터만 삭제 = 복구가능
delete 테이블명 [where 조건식];
--> 테이블 삭제 x , 데이터만 삭제된다

delete emp_const;
rollback; 복구

delete emp_const where emp_id=200;
>삭제 가능

1. delete emp_const where emp_id=100;
>삭제 불가 dept_const 에서 dept_manager_id 가 foreign key 로 사용하고 있다

1-1. delete dept_const where dept_manager_id =100;
>매니저 번호를 삭제한 후 사원 100 삭제가능

1-2. update dept_const set dept_manager_id =200
		where dept_manager_id = 100;
>매니저 번호를 200으로 변경 후 사원 100 삭제가능



2.제약조건을 변경함으로 100번 사원을 삭제할수 있게 한다
alter table dept_const
drop constraint dept_const_manid_fk;

alter table dept_const
add constraint dept_const_manid_fk
foreign key(dept_manager_id)
references emp_const(emp_id)
on delete cascade;

cascade연속적으로

delete emp_const where emp_id=100


create table / alter table / drop table
insert / update / delete
create view
create index
create sequence







