
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

--PL/SQL 목록 보기(소스 확인) 조회

select name, text
from user_source
where name like 'EMP%'
ORDER BY NAME, LINE;

-- 실행문, 실행법
execute :변수명 := 함수명(in 매개변수값)
print 변수명;

execut 프로시져명 (in 매개변수값, :변수명)
print 변수명;


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
return(실행결과변수=단 1개의 값만 리턴);-----------------필수 : 어떤 변수값 리턴
end;
/


--실행문법
EXECUTE :변수명 := 함수명(매개변수);

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

==


CREATE OR REPLACE FUNCTION EMP_DATE_func(ID IN NUMBER)
RETURN varchar2
IS
result varchar2(10);
BEGIN
SELECT substr(HIRE_DATE,4,2)
INTO result
FROM EMPLOYEES WHERE EMPLOYEE_ID = ID;
RETURN(result);
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
변수명 타입
타입 : NUMBER, VARCHAR2 , DATE
		테이블명.컬럼명%TYPE(컬럼타입 참조)
		변수명%TYPE
	
V_N1 NUMBER;
V_N2 V_N1%TYPE;

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
 begin
 실행시 오라클 지정 내장 오류 발생O : 문장 중지하고 EXCEPTION 이동 지시 실행
 실행시 오라클 지정 내장 오류 발생X : EXCEPTION 실행X
 
 exception
 WHEN 오라클내장예외이름 THEN 실행문장;
 when outhers then 처리문장
 
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
 
 --------------------------------------------------------------------------
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
 

 ------------------------------------------------------------------------------
 
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




























 2. 여러건 레코드 검색시 여러 레코드를 1개 변수에 저장 가능 => CURSOR!












