
DML : Data Manipulation Lang 
: INSERT 데이터 저장 / UPDATE 수정 / DELETE 삭제


===================================================================
--insert into
- insert into 테이블명(컬럼1, 2, 3)
values(값1, 2, 3);

- insert into 테이블명
values(값1, 2, 3);

- insert into 테이블명(컬럼1, 3)
values(값1, 3);


====================================================================



--UPDATE
-레코드(여러개컬럼값) 일부 컬럼값 수정/삭제
update 테이블명 
set 수정컬럼명=수정값 [, 수정컬럼명2=수정값2]
[where 수정레코드추출조건식];

update dept_const
set dept_manager_id = 100
where department_id is null; -- =null 은  'null'을 찾는 꼴

--인사부 소속 사원을 총무부 배치 변경
update emp_const
set dept_id = (총무부 부서코드 조회)
where dept_id = (인사부 부서코드 조회)

update emp_const
set dept_id = 
(select dept_id from dept_const where dept_name = '총무부')
where dept_id = 
(select dept_id from dept_const where dept_name = '인사부')

--설계도를 그린뒤 코드를 짜자 무턱대고 코드부터 손대면 및에 꼴 난다. 생각을 하라고
--틀린코드
update emp_const
set dept_name = '총무부'
where (name, dept_id) in
(select name, dept_id
from emp_const e, dept_cont d
where e.dept_id = d.dept_id
and d.dept_name = 인사부)


============================================================================

--delete

drop table 테이블명 > 복구불가
alter table 테이블명 drop colum 컬럼명 > 복구불가
alter table 테이블명 drop constraint 제약조건이름 > 복구불가

데이터만 삭제 = 복구가능
delete 테이블명 [where 조건식];
--> 테이블 삭제 x , 데이터만 삭제된다


0. delete emp_const where emp_id=200;
>삭제 가능

1. delete emp_const where emp_id=100;
>삭제 불가 dept_const 에서 dept_manager_id 가 foreign key 로 사용하고 있다

1-1. delete dept_const where dept_manager_id =100;
>매니저 번호를 삭제한 후 사원 100 삭제가능

1-2. update dept_const set dept_manager_id =200
		where dept_manager_id = 100;
>매니저 번호를 200으로 변경 후 사원 100 삭제가능


4. 이전 참조키 삭제
alter table emp_const drop constraint emp_const_dept_id_fk;

5. 참조키 설정 + on delete cascade 옵션추가
alter table emp_const add constraint emp_const_dept_id_fk
foreign key(dept_id) references dept_const(dept_id)
on delete cascade;

6. 이전 참조키 삭제
alter table dept_const drop constraint dept_const_manager_fk;

7. 참조키 설정 + on delete cascade 옵션추가
alter table dept_const
add constraint dept_const_manager_fk
foreign key(dept_manager_id) 
references emp_const(emp_id) 
on delete cascade;

cascade연속적으로

delete emp_const where emp_id=100










