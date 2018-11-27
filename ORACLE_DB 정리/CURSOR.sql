
http://www.gurubee.net/lecture/1064

cursor 사용 : 반복문

1> 오라클 sql 작업 결과 저장 영역 입니다.
2> 프로그래머에 의해 선언되며 이름이 있는 cursor 정의 가능
3> 조회 결과 메모리 저장 영역 접근 참조 포인터

1. 선언 declare ( is 부분)
cursor 커서이름
is
select first_name from employees
where employee_id >= 300;
-----------------

2. 사용 --(begin 부분)
open cursor이름; 
loop

fetch cursor명
exit when cursor 내부 조회 데이터 없을 때
...출력...

end loop;
close cursor;

--전체 구성

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

							____________
							|			|
							V 			^(no)
declare		> open		> fetch		> empty		> close
이름있는 sql	cursor활성화	커서의 현재		현재행의 존재	커서가 사용한
영역생성					데이터행을 해당	여부검사		자원을 해제
						변수에 넘긴다.	레코드가 없으면
									fetch하지 않음
									
--변수 타입

number			테이블명.컬럼명%type
varchar2		변수명%type
date			테이블명%rowtype -테이블의 모든 컬럼타입 가져온다
boolean	
		

--cursor의 속성값을 저장한 변수들

cursor명%rowcount 
cursor명%found 
cursor명%notfound  
cursor명%isopen 
		

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

------------------------------------
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


===================================================================

http://blog.kjslab.com/20

--오라클 프로시저 커서 (CURSOR) 3가지 생성 방법.

1.커서의 내용을 미리 정의 해 놓고 사용하는 방법.

DECLARE
  CURSOR C_LIST IS
    SELECT MY_ID FROM MY_TABLE WHERE 조건;
BEGIN

  FOR I_ID IN C_LIST LOOP
    DBMS_OUTPUT.put_line(I_ID);
  END LOOP;
END;
비추천 
커서의 내용을 정할 때 select 문제 동적으로 parameter가 넘어가야 할 경우 사용이 불가능 하다. 
왜냐하면 BEGIN 전에 정의하기 때문이다.


2.커서 변수를 미리 만들어 놓고 불러서 사용하는 방법.

DECLARE
	I_ID   VARCHAR2(100);		-- 변수 정의				
  C_LIST SYS_REFCURSOR;		-- 커서 정의
BEGIN
  OPEN C_LIST FOR
  SELECT MY_ID   
    FROM MY_TABLE
    WHERE 조건;
  LOOP					-- LOOP 돌기.
      FETCH C_LIST
      INTO  I_ID;			--  하나씩 변수에 넣기.
      EXIT WHEN C_LIST%NOTFOUND;	-- 더이상 없으면 끝내기.
      DBMS_OUTPUT.put_line(I_ID);    --  출력
  END LOOP;
  CLOSE C_LIST;
END;
재사용성이 있어서 나름 괜찮음. 
커서를 정의 한 뒤 그 때 그 때 커서의 내용을 채우는 방법이다.

3.동적으로 커서를 생성해서 사용하는 방법

DECLARE

BEGIN

  FOR C_LIST IN (SELECT MY_ID FROM MY_TABLE WHERE 조건) 
  LOOP
    DBMS_OUTPUT.put_line(C_LIST.I_ID);
  END LOOP;
END;
강추~!!
커서를 미리 정의 할 필요도 없고, 변수를 미리 만들어 놓을 필요도 없다.

























