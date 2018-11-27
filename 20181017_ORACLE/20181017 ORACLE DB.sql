parameter : pl/sql 블록 외부 전달 받거나 전달 하는변수
pl/sql => db "영구적" 저장 : drop

select name, text
from user_source
where name like 'EMP%'
ORDER BY NAME, LINE;


execute :변수명 := 함수명(in 매개변수값)
print 변수명;

execut 프로시져명 (in 매개변수값, :변수명)
print 변수명;


===================================================

-반복문 

loop 
반복 실행 문장;
exit when boolean(반복중단조건식);
	= if(반복중단조건식) then exit; end if;
end loop;

sql 없는 기능(pl/sql의 특징) -변수선언 저장, 조건문, 반복문, 예외처리


-1~10 정수 출력

create or replace procedure print_int

is
v_su number :=0;

begin
loop
v_su := v_su+1;
dbms_output.put_line(v_su);
exit when v_su := 10;
end loop;

end;
/
show error;

-----------------------------------------
create or replace procedure print_int
(v_max in number)
is
v_su number :=0;

begin
loop
v_su := v_su+1;
dbms_output.put_line(v_su);
exit when v_su := v_max;
end loop;

end;
/
show error;
------------------------------------------
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


=======================================================================

반복문2 : 1~10 정수 출력

for 변수명 in 1..10
loop 
반복 실행 문장;
end loop;


create or replace procedure print_int_for
(v_min in number, v_max in number)
is
v_su number ;

begin
for v_su in v_min..v_max
loop
dbms_output.put_line(v_su);

end loop;

end;
/
show error;

----------------------------------
select department_id from departments;
--부서번호 10~270부서의 부서명 조회
-- 27번 반복: 부서번호 +10
select department_id 
into dept_name --변수선언
from departments
where department_id =10;


create or replace procedure dept_find

is
dept_name departments.department_name%type;
id number;


begin
dbms_output.put_line('!!dept_id'||' , '||'dept_name!!');
for id in 1..27
loop
select department_name 
into dept_name --변수선언
from departments
where department_id = id*10;

dbms_output.put_line(id*10||' , '||dept_name);

end loop;
end;
/
show error

--

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


=================================================================== break
http://192.168.16.84:9090/oracle/
-반복문 3

loop   --> 최소 1번은 반복 실행이 필요할 경우
반복실행문장
반복횟수변화(v_su = v_su+1)
exit when 조건식;
end loop;

for 변수 in 범위1.. 범위2 --> 유한횟수의 반복을 가질때
loop
반복실행 문장;
필요없다!!!반복횟수변화(v_su = v_su+1)
end loop;

while 조건식(동안) --> 0번 이상 반복 실행이 필요할 경우
loop
반복실행문장;
end loop;


---------------------------
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


pl/sql
변수
조건문
반복문


--loop / for / while 모두 해보기
-1~10까지의 정수 총합 구하기 parameter 받아서 구하기
출력
1까지 총합 1
2까지 총합 3
3까지 총합 6
10  =   55

create or replace procedure sum_pa
(v_param in number)
is
result number := 0;
v_cal number := v_param;

begin
while v_cal >0
loop
result := result + v_cal;
v_cal := v_cal -1;

dbms_output.put_line(result);

end loop;
end;
/
show error 

exec sum_pa(10);

-------------------------------------
create or replace procedure sum_pa
(v_param in number)

is
result number:=0;
v_lop number;

begin
for v_lop in 1..v_param
loop
result := result + v_lop;
dbms_output.put_line(v_lop||'까지 총합 = '||result);
end loop;

end;
/
show error 

exec sum_pa(10);
=====================================================
- 5!(factorial) 구하기 : 입력변수 1개 ( 음수나 0에 값을 입력시 '-5 : 팩토리얼 구할 수 없습니다')
FACT_PROC(5) --> 5!
1! = ?
2! = ?
3! = ?

5! = ?

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

exec fact_proc(5);



==============================================================
- 구구단 2단 출력하기 : (나아가서 9단까지 구하는 법)
2*1 = 
2*2 = 

2*9 =


create or replace procedure multiple
(v_param in number)
is
sta_num number := v_param;
incre_num number := 1;
result number ;

begin

loop
result := sta_num * incre_num;
dbms_output.put_line(sta_num||' * '||incre_num||' = '||result);
incre_num := incre_num + 1;

exit when incre_num =10;
end loop;

end;
/
show error

exec multiple(2);


===========================

연산자 우선순위 priority

- 2- 9단 출력


create or replace procedure gugu2_9
is
 v_num number;
 v_dan number;
begin
 
  for v_dan in 2..9
  loop
   for v_num in 1..9
   loop
   dbms_output.put_line(v_dan||' * '|| v_num ||' = '|| v_dan*v_num);
   end loop;
  end loop;

end;
/
show error

exec gugu2_9;



==========================================================================
http://www.gurubee.net/lecture/1064

cursor 사용 : 반복문

1> 오라클 sql 작업 결과 저장 영역 입니다.
2> 프로그래머에 의해 선언되며 이름이 있는 cursor 정의 가능

1. 선언 declare ( is 부분)
cursor 커서이름
is
select first_name from employees
where employee_id >= 300;
-----------------

--2. 사용 (begin 부분)
open cursor이름; 
loop

fetch cursor명
exit when cursor 내부 조회 데이터 없을 때
...출력...

end loop;
close cursor;
							____________
							|			|
							V 			^(no)
declare		> open		> fetch		> empty		> close
이름있는 sql	cursor활성화	커서의 현재		현재행의 존재	커서가 사용한
영역생성					데이터행을 해당	여부검사		자원을 해제
						변수에 넘긴다.	레코드가 없으면
									fetch하지 않음
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



====================================================================














