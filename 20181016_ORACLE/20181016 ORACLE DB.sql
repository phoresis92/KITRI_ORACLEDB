



SQL : 한번에 1개의 SQL 실행
MAIN QUERY (SUBQUERY) MAIN 이주로 2개라 볼 수 없다
1번에 여러개 SQL 실행할 수 있는 블럭 구조 생성 INSERT SELECT UPDATE ...

PL/SQL
1. 한번에 여러개 SQL 실행 블럭 구조
2. SQL 실행결과를 변수에 저장 가능 = 메로리 공간 데이터 값 저장
3. 조건문
4. 반복문

-기본 블럭 구조
DECLARE
변수 선언
변수 이름 타입 :=(대입연산자) [초기화값(변수 최초저장 값)][:=NULL 생략];
BEGIN
1번에 여러개 SQL 실행 블럭 구조
INSERT
SELECT
UPDATE
...
EX)실행문장 : 오류 = SQL 실행X

DDL, DCL : 사용불가
DML, TCL : 그대로 사용가능
SELECT : INTO 추가 문법 변형

[EXCEPTION =BEGIN문장 오류 발생시 자동 실행]
END;
/
=> 정의 + 실행 = 결과물
=> 정의하여 DB에 영구적 저장(PL/SQL 이름 설정) + 필요시 여러번 실행(이름을 통해 호출)


--PL/SQL 종류
1. function
2. procedure
3. trigger
4. package

==========================================================================

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
return 리턴값 타입-----------------------------필수
is
함수 내부 변수선언(지역변수)
begin
실행내용문장;
return(리턴값=단 1개의 값만 리턴);-----------------필수
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
EX)
user_tables
user_views
user_sequences
user_source


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
지역변수 (이름 타입) := 값(초기화)
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

--SELECT 문에서 사용 불가
X SELECT 프로시져명(컬럼명) FROM 테이블명

		
			
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

======================================================

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


------------------------------------

지역변수 선언
날짜/문자/정수/실수 + (TRUE,FALSE,NULL)
DATE/VARCHAR2/NUMBER + BOOLEAN

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

------------------------------
FUNCTION / PROCEDURE
매개변수 MODE : IN / OUT / INOUT 생략시 IN
매개변수 + 지역변수(IS~) 타입지정: 

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



================================================================BREAKE

-------------------------------
-3.select 컬럼명 -----두타이아한
 4.into !변수명!------개입같야다
 1.from 테이블명
 2.where 컬럼명 연산자 !변수명!
 
 (PL/SQL SELECT~INTO 조회시 : 레코드 !1개만! 검색) - 2개 이상/ 0개 : 오류
 select SALARY from employees where employee_id >=200;
 
 
 1. 오류해결
 
 create or replace function|procedure 이름
 (매개변수들)
 is
 begin
 실행시 오라클 지정 내장 오류 발생O : 문장 중지하고 EXCEPTION 이동 지시 실행
 실행시 오라클 지정 내장 오류 발생X : EXCEPTION 실행X
 
 exception
 WHEN 오라클내장예외이름 
 THEN 실행문장;
 
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
	@ C:\Users\hushe\Desktop\EMP_SELECT_EXCEPTION -- .SQL의 경우 확장자 넣지 않아도 된다.
 
 
 
 
 
 2. 여러건 레코드 검색시 여러 레코드를 1개 변수에 저장 가능 => CURSOR!
 
 
 
-------------------------------


1.조건문
-100번 사원 급여 조회하여 5000 이상이면 출력o
					5000 미만이면 출력x

if(조건식) then 
조건만족 실행문장1; 
조건만족 실행문장2;

end if;

create or replace procedure print_emp_salary
(id in employees.employee_id%type)

is
result_salary employees.salary%type;

begin					
 select salary
 into result_salary
 from employees where employee_id = id;
 
 if(result_salary>=5000) then 
	dbms_output.put_line(result_salary);
 end if;
 end;
 /
 
 execute print_emp_salary (100);
 
 --------------------------------
 -5000 이상 만족하지 못하면 (미만이면 급여 + 1000 출력)
 
create or replace procedure print_emp_salary
(id in employees.employee_id%type)

is
result_salary employees.salary%type;

begin					
 select salary
 into result_salary
 from employees where employee_id = id;
	
 if(result_salary>=5000) then 
	dbms_output.put_line(result_salary);
 else
	dbms_output.put_line(result_salary);
	dbms_output.put_line(result_salary+1000);
 end if;
 end;
 /
 
  execute print_emp_salary (100);
 

 if(조건식) 
 then 조건만족 실행문장1; 
 else 조건만족 실행문장2;

end if;
 
 
 ------------------------------
 
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
  
  
   if(조건식) 
 then 조건만족 실행문장1; 
 elsif then 조건1 불만족 조건 2실행문장;
 elsif then 조건2 불만족 조건 3실행문장;
 else 위 모든 조건 false 수행 문장;
end if;
 
 
 --------------------------
 
 조건식 : boolean 형태 만족
 참, 거짓 : true, false
 if(salary is null)
 if(1=1)
 if(0=1)
=, !=(<>) , >, >= , is null , is not null, and , or, not

if(salary is null and commission_pct is null) 



1. 
pl/sql 조건문1
if then else elsif end if

pl/sql 조건문2
CASE WHEN ELSE ELSIF END CASE


CASE
WHEN 조건식 THEN 만족 수행 문장;
WHEN 조건2 THEN 만족 수행 문장;
WHEN 조건3 THEN 만족 수행 문장;
ELSE 조건을 모두 만족하지 않는 경우 문장;
END CASE;
--케이스 에서 else는 필수다 없을시 예외발생



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


----------------------------------------------------------------------

-커미션 받는 사원이 있다면
연봉 : 급여에 12배 + 급여*12*커미션
-커미션 받지 못하는 사원이 있다면
연봉 : 급여*12
func/proc 선택적 : emp_year_sal 이름
emp_year_sal(사번) : 출력결과 연봉


create or replace procedure emp_year_sal
(id in employees.employee_id%type)
is
emp_sal employees.salary%type;
emp_commi employees.commission_pct%type;
sal_out varchar2(30);
begin

select salary
into emp_sal
from employees where employee_id = id;

select commission_pct
into emp_commi
from employees where employee_id = id;

if(emp_commi is not null) then
sal_out := emp_sal*12 + emp_sal*12*emp_commi;
else
sal_out := emp_sal*12;
end if;
dbms_output.put_line(sal_out || ',' || emp_sal || ',' || nvl(emp_commi,0));

end;
/

exec emp_year_sal (100);

-----------------------------------------------------------------
- employees 테이블에서 특정 사원의 사번 입력시
부서번호를 조회하여 다음과 같은 조건으로 부서명을 만들어
(departments 테이블이 없다고 가정하고 풀이하라)

부서번호      부서명 
10~50         인사부소속
60, 80, 100   교육부소속 
나머지        영업부소속

다음의 형식으로 출력하라

사번  부서번호  부서명
100     10      인사부소속      


create or replace function emp_dept_name
(id in employees.employee_id%type)
return varchar2
is
emp_dept employees.department_id%type;
dept_out varchar2(4000);
begin

select department_id
into emp_dept
from employees where employee_id = id;

case
when emp_dept >= 10 and emp_dept<= 50 then dept_out :='인사부소속';
when emp_dept = 60 then dept_out :='교육부소속';
when emp_dept = 80 then dept_out :='교육부소속';
when emp_dept = 100 then dept_out :='교육부소속';
else dept_out :='영업부소속';
end case;
return (id ||' , '|| emp_dept ||' , '|| dept_out);

end;
/
show error;


variable result varchar2(4000);
set serverout on;
execute :result := emp_dept_name(100);


-
- -------------------------------------------------------------
사번 , 성, 이메일, 입사일, 직종코드를 입력받아서
해당 직종코드가 jobs 테이블에 존재하고 
해당 사번이 employees  테이블에 존재하면 
해당 사번의 성, 이메일, 입사일, 직종코드를 변경하고
해당 사번이 employees  테이블에 존재하지 않으면
새로운 사원으로 저장.
이 때 해당 직종코드가 jobs 테이블에 존재하지 않으면 
jobs 테이블에 입력받은직종코드 : 'NEW_JOB' : 0 : 0 입력
하는 pl/sql 블록 정의

111 홍 HONG@KITRI1.COM SYSDATE IT_PROG--> EMPLOYEES INSERT
100 홍 HONG1@KITRI1.COM SYSDATE IT_PROG--> EMPLOYEES UPDATE
222 홍 HONG1@KITRI1.COM SYSDATE IT_MAN--> JOBS INSERT
JOBS : JOB_ID : JOB_TITLE : MIN_SALARY : MAX_SALARY
       
-ans



CREATE OR REPLACE PROCEDURE EMP_NEW_INSERT
(ID EMPLOYEES.EMPLOYEE_ID%TYPE,
NAME EMPLOYEES.LAST_NAME%TYPE,
EMAIL EMPLOYEES.EMAIL%TYPE,
INDATE EMPLOYEES.HIRE_DATE%TYPE,
V_JOB_ID EMPLOYEES.JOB_ID%TYPE)

IS
 JOB_ID_CNT NUMBER;--1/0
 EMP_ID_CNT NUMBER;--1/0
BEGIN

--DBMS_OUTPUT.PUT_LINE('직종입력'||JOB_ID);


SELECT COUNT(*) 
INTO JOB_ID_CNT
FROM JOBS
WHERE JOB_ID = V_JOB_ID;

DBMS_OUTPUT.PUT_LINE('직종발견'||JOB_ID_CNT);

IF(JOB_ID_CNT = 1) 
    THEN 
      SELECT COUNT(EMPLOYEE_ID)
      INTO EMP_ID_CNT
      FROM EMPLOYEES
      WHERE EMPLOYEE_ID = ID;

      DBMS_OUTPUT.PUT_LINE('사번발견'||EMP_ID_CNT);
      
      IF(EMP_ID_CNT = 1)
      THEN
       UPDATE EMPLOYEES
       SET LAST_NAME = NAME , EMAIL = EMAIL , 
       HIRE_DATE = INDATE, JOB_ID = V_JOB_ID
       WHERE EMPLOYEE_ID = ID;    
      ELSE 
       INSERT INTO EMPLOYEES
       (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
        VALUES(ID, NAME, EMAIL, INDATE, V_JOB_ID);
      END IF;
 
    ELSE 
     INSERT INTO JOBS VALUES(V_JOB_ID, 'NEW_JOB', 0, 0); 
END IF;
 COMMIT;
END;
/
SHOW ERRORS;


EXEC EMP_NEW_INSERT(111,  '홍',  'HONG@KITRI1.COM', SYSDATE,  'IT_PROG');
-- EMPLOYEES UPDATE

EXEC EMP_NEW_INSERT(999,  '홍', 'HONG1@KITRI1.COM', SYSDATE, 'IT_PROG');
-- EMPLOYEES INSERT

EXEC EMP_NEW_iNSERT(222, '홍', 'HONG2@KITRI1.COM',  SYSDATE, 'IT_MAN');
-- JOBS INSERT



   1-1. 직종 코드 존재 TRUE :ID 입력값  EMPLOYEES 테이블 존재 확인
        1-1-1. 사번 존재 TRUE : --> update

        1-1-2. 사번 x FALSE : --> insert

   1-2. 직종코드 x FALSE : --> jobs table insert
2. COMMIT;


