
sql 없는 기능(pl/sql의 특징) -변수선언 저장, 조건문, 반복문, 예외처리

1.조건문

--조건식 : boolean 형태 만족
참, 거짓 : true, false
if(조건식:boolean) 
=, !=(<>) , >, >= , is null , is not null, and , or, not
if(1=1)
if(0=1)
if(salary is null and commission_pct is null) 

--pl/sql 조건문1
if then elsif else end if

--pl/sql 조건문2
CASE WHEN ELSE END CASE

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
다중조건식
if(조건식1) then 조건1만족 실행문장; 
elsif (조건2) then 조건1 불만족 조건 2실행문장;
elsif (조건3) then 조건2 불만족 조건 3실행문장;
else 위 모든 조건 false 수행 문장;
end if;

------------------------------------
CASE
WHEN 조건식1 THEN 조건1 만족 수행 문장;
WHEN 조건2 THEN 조건2 만족 수행 문장;
WHEN 조건3 THEN 조건3 만족 수행 문장;
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


























