
게시물 저장 테이블
게시물 번호
게시물 제목
게시물 내용
작성자
글암호
작성일
조회수

회원가입정보 저장 테이블
회원 id
암호
이름
이메일
폰번호

상품정보 저장 테이블
상품코드
상품이름
가격
재고량
판매량
상세정보
이미지파일명

장바구니 테이블
장바구니 번호
회원아이디
상품코드
수량
총금액
장바구니 생성일

결제 테이블
결제코드
장바구니 번호
결제종류
결제일

192.168.16.84:9090/oracle/

DDL

create table
alter table 
add 컬럼추가, drop 컬럼삭제, modify 타입(길이) 수정, rename 컬럼이름,
-제약조건 : 데이터의 무결성 보장
add constraint 제약조건명 제약조건타입 부가조건(check, foreign key)
drop constraint 제약조건명
drop table
foreign key 다른테이블 primary key 제약조건 설정 컬럼 존재값 참조
부모컬럼 : 참조당함
자식컬럼 : 참조한다
부모컬럼 데이터 삭제시 문제 발생 가능

DML

insert
update
delete

DCL : admin 계정만 사용
create user name identified by pass ;
grant connect, resource(일반유저 생성) to username; 

-SUBQUERY 이용가능


tcl :
트랜잭션 : 여러 단일 작업으로 이루어진 논리적 업무 단위
ex)
a to b 계좌이체작업 : 논리적 1개
- but 단위로 나누게 되면-*
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

===================
create table account(
acc_id number(10) constraint acc_id_pk primary key,
password number(10),
balance(잔액) number(10,2));

insert into account
values (1001,1111,10000);
insert into account
values (2001,2222,0);

commit;

계좌정보 : 레코드
레코드 수정 2개 sql : 모두 완료 되어야 커밋

트랜잭션 : 여러 단일 작업 구성 논리적 업무 단위
 = 여러 sql 구성 작업 단위
 따라서 1개 sql 오류 발생시 실행하지 않는다.
 
 2개 sql 실행이 문제 없이 실행 : 2개 sql 실행 이후 commit;
 1sql 싱행완료 but 2sql 실행 안됨 = 1sql 실행 복구 rollback;
 
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

쇼핑몰 : 장바구니 물건 저장 ( = 장바구니 테이블 insert)
		결제(=결제 테이블 insert + 장바구니 테이블 delete)
 
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

--주의사항!!!
1.ddl 실행 이전 dml문장 : commit/rollback 설정
2.트랜잭션 진행중인 dml 다른 session 사용 불가능(lock : 다른 session 멈춤)


트랜잭션의 단위는 각각의 개인이 결정해야한다 규칙이 있지 않다.





====================================================================


ddl : db 객체 정의 명령
--객체 : 데이터 저장 구조 타입 : 데이터 저장집합
1.TABLE : 행과 열의 2차원 형태. 데이터 저장소
2.VIEW : TABLE에서 추출한 일부 데이터를 QUERY 형태로 저장한 가상의 테이블이름
3.INDEX : 검색 객체
4.SEQUENCE : 자동 숫자 생성 객체

TABLE : 실제컬럼구조 직접 정의
VIEW : 가상테이블
 
-create view 뷰이름 as subquery;
-create[or replace] view 뷰이름 as subquery;

-drop view 뷰이름;

-select * from user_views;
5. employees 테이블(동일) 접근 권한 부서별 다르게(인사부, 총무부)

주의사항
1. 그룹함수, 연산 수식(=실제 존재컬럼명x) alias 설정
2. 실제 존재컬럼명 뷰 생성 : alias 선택적
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





create table A (.....);
A 테이블 컬럼 구조 메모리 저장;

create table B 
as
select * from emp;
B 테이블 emp 컬럼 구조 복사 메모리 저장;
(emp, b 테이블 존재)




===================================================
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



============================================================

SEQUENCE : 테이블 UNIQUE, NOT NULL 조건 만족 데이터가 숫자일 경우 자동 증가/감소값 생성 객체(게시물)
(사번, 학번, 주민번호, 사회보장번호, 여권번호)

desc user_sequences
select sequence_name, increment_by, max_value, min_value, cycle_flag
from user_sequences
where SEQUENCE_name = 'EMP_SEQ';

create sequence 시퀀스명; // 1부터 시작, 1씩 증가
[start with 10]
[increment by 5]
[maxvalue 50]
[cycle || nocycle]

create sequence emp_seq;

create sequence emp2_seq
start with 10
increment by 5
maxvalue 30;


--특정 테이블 전용으로 sequence 사용 한다. 타 테이블에 사용 하면 일정한 숫자 증가를 얻을 수 없다.



emp_seq.nextval 컬럼
emp_seq.currval 컬럼 
시퀀스명.nextval(next value) : 다음 증가값
시퀀스명.currval(current value) : 현재 증가최종값

select emp_seq.currval from dual;
select emp_seq.nextval from dual; => 1값 생성 시작, 현재값 + 1

alter sequence

ALTER SEQUENCE sequence_name
    [INCREMENT BY n]
    [MAXVALUE n | NOMAXVALUE]
    [MINVALUE n | NOMINVALUE]
    [CYCLE | NOCYCLE]
    [CACHE | NOCACHE]


drop sequence


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
pl/sql : 
procedural language extention to 
structured query language;

sql : 함수 연산자 조회 테이블 생성 저장 .....
저장하여 사용하고 싶을 때 
=>pl/sql 블럭 (1개 블록지정: 변수형태, 조건문(선택sql다르게), 반복문)
	1번에 1개 sql 실행 가능

sql : dml,tcl 문장 그대로 사용 + pl/sql 변수 사용
	ddl,dcl : pl/sql 사용x
		create table a
		drop table a
	




==========================
오라클 : 출력
DBMS_OUTPUT.PUT_LINE(출력내용);
출력 전제조건 설정 : SET SERVEROUT ON;

DECLARE
연산 데이터, 연산 결과 메모리 저장
컴퓨터 메모리 저장값 = 변수(PL/SQL, JAVA, HTML,...)
변수선언문장 (statement);
 v_salary number := 20000;
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
[EXCEPTION]
END;
/


============================
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











- 공통 문법
declare
 변수선언문장
begin
 실행내용문장
end;
/
1.sql + 변수선언 + 조건문 + 반복문
	dml, tcl + select into






1. function
2. procedure
3. trigger
4. package







