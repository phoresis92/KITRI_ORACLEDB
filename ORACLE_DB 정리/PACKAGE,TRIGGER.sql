
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
for each row --when employees.employee_id>=300; 도 가능
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

-- fro each row
 행 트리거 : 컬럼의 각각의 행의 데이터 행 변화가 생길때마다 실행되며, 
 그 데이터 행의 실제값을 제어할 수 있다.

 문장 트리거 : 트리거 사건에 의해 단 한번 실행되며, 
 컬럼의 각 데이터 행을 제어 할 수 없다.

 FOR EACH ROW : 이 옵션이 있으면 행 트리거가 된다
	
	
>>
insert into employees
values (503, '신입', '최', 'new4@kitri.com', 0102223333,
 sysdate, 'IT_PROG', 1000, null, 200, 401);	

 >>
insert into employees
values (504, '신입', '조', 'new5@kitri.com', 0102223333,
 sysdate, 'IT_PROG', 1000, null, 200, 401);	



















