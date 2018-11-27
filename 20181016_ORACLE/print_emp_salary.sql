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