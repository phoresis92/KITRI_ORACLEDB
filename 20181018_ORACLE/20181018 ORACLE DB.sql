- cursor : 조회 결과 메모리 저장 영역 접근 참조 포인터
		-변수가 아니다. 커서 레코드 검색하여 변수에 저장(반복)
		
	1. 조회 결과 저장 cursor 선언
	2. cursor 열기 : 
	3. cursor fetch 데이터 조회 - 변수 저장 : --loop
	4. cursor 닫기
	
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
	

-----------------------------------------------------------

--%rowtype
--select employee_id from employees;

create or replace procedure emp_cursor2
is
v_emp employees%rowtype;

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
 
 end loop;
 
close emp_id_cursor;

end;
/
show error 

exec emp_cursor2;


--------------------------------------------------------
	
	
변수 타입

number			테이블명.컬럼명%type
varchar2		변수명%type
date			테이블명%rowtype -테이블의 모든 컬럼타입 가져온다
boolean			
	
	
	
==========================================

	
	
	
cursor의 속성값을 저장한 변수들

cursor명%rowcount 
cursor명%found 
cursor명%notfound  
cursor명%isopen 

	
--------------------------------
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
	
	
============================================================================


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

============================================================================
4. TRIGGER
함수나 프로시져, 패키지 : 정의 + db생성 + 실행 + 결과확인

TRIGGER : 정의 + db생성 + 특정 조건이나 상태를 만족시 자동실행

create or replace trigger 이름 -- (매개변수 줄 수 없다!!!) 자동실행 되기 때문에
before(|after) insert(|delete|update) on emp(테이블명)

declare
변수명 타입;
--for each row

begin
실행내용(emp 테이블에 insert 실행 직전 먼저 실행)
end;

	
	
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
	
	
	
	
	
function / procedure 생성 / 실행 가능
package / trigger 이해 수준 --자바에서도 처리가능	
	
	
	
	
	
	
	
	
	
	
	
	