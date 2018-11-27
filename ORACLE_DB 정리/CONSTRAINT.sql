
--제약조건 표현 : 데이터의 무결성 보장
constraint 제약조건이름(테이블명_컬럼_타입약자) 제약조건타입 부가조건
R foreign
P primary
U unique
C check, notnull(search_condition 컬럼 참조해서 구분)

--제약조건 표현 종류
예외 default 기본값 설정(default sysdate)
1. primary key : UNIQUE+ NOT NULL
2. not null : 컬럼 값 존재(중복O)
3. unique : 컬럼 값 중복X(NULL O)
4. check(where절과 같음) : 사용자 정의 : 제약조건 외
5. foreign key : 다른 테이블 존재값 참조
*** 참조 사용 값 : unique/primary key 조건만 참조가능
즉 부모테이블이 uk/pk 자식테이블이 fk

부모컬럼 : 참조당함
자식컬럼 : 참조한다
부모컬럼 데이터 삭제시 문제 발생 가능

-- alter table 사용 (구조변경)
alter table (존재하는 컬럼에 제약조건 추가)
alter table 테이블명 add() -테이블에 컬럼추가
-alter table 테이블명 add(컬럼명 타입(길이))
alter table 테이블명 modify() -컬럼 데이터타입 수정
alter table 테이블명 drop column() -테이블에 컬럼 삭제
alter table 테이블명 rename column() -컬럼명 변경
alter table emp_const add constraint -기존컬럼에 제약조건 추가
emp_con_deptname_fk foreign key(dept_name)
references dept_const(dept_name)

ALTER TABLE 테이블명
ADD CONSTRAINT 제약조건명 제약조건 (컬럼명);

alter table emp_const 
add constraint emp_const_hire_date_df 
default sysdate for hire_date;



--제약조건 확인 =>select * from dictionary =>desc user_constraints;

select constraint_name,
constraint_type,
table_name,
search_condition
from USER_CONSTRAINTS
where table_name = 'EMP_CONST';

-디폴트 값 찾기 find default

 SELECT column_name, data_default, data_type, nullable
 FROM user_tab_cols
 WHERE table_name = UPPER('table_name')  
 AND column_name = UPPER('col_name')


-- 제약조건 효력 : insert/update/delete



--부서 이름이 uk pk 조건이 아니어서 pk인 id 값을 통해 fk 제약 조건을 만들어낸다.
1. emp_const 테이블 dept_name 컬럼 삭제
alter table emp_const drop column dept_name;

2. emp_const 테이블 dept_id 컬럼 추가
alter table emp_const add (dept_id number(5) ); -- dept_const 와 같은 date type으로 설정해야한다.

3. dept_id 컬럼은 dept_const테이블의 dept_id참조
alter table emp_const add constraint
emp_const_dept_id foreign key(dept_id) references dept_const(dept_id));

2+3==>
alter table emp_const add
(dept_id number(5) constraint
emp_const_dept_id references dept_const(dept_id)
);

-- 테이블 수정 제약조건 추가
alter table 테이블명 add constraint

--제약 조건 삭제법
alter table 테이블명 drop constraint 제약조건이름(emp_const_deptname_fk)

--not null 예외적 제약 조건 삭제법
alter table 테이블명 modify constraint


