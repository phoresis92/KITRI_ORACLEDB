

1. 새롭게 생성
emp,dept 테이블 생성 = 데이터 구조정의


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



--부서 이름이 uk pk 조건이 아니어서 pk인 id 값을 통해
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





















