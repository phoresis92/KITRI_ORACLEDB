
DDL : Data Definition Lang 
: CREATE TABLE 데이터 구조의 정의 / ALTER TABLE 변경 / DROP TABLE 삭제

=====================================================================
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









