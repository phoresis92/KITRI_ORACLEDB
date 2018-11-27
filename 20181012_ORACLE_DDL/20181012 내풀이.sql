1.
create table board(
rownumber number(5) constraint board_rownum_pk primary key,
title varchar2(100) constraint board_title_nn not null,
contents varchar2(4000),
writer varchar2(30) ,
post_date date,
password number(5),
hits number(10) constraint board_hits_ck check (hits>=0));

2.
create sequence board_rownum_seq
start with 1
increment by 1;

insert into board (rownumber,title, contents, writer, post_date,password, hits)
values (board_rownum_seq.nextval,'첫번째글제목', '첫번째글내용', '홍길동', sysdate, 1111, 0);

3.
insert into  board (rownumber,title, contents, writer, post_date,password, hits)
values (board_rownum_seq.nextval,'인어 아세요?', '허준재를 좋아합니다.', '심청이', sysdate, 2222, 0);
insert into  board (rownumber,title, contents, writer, post_date,password, hits)
values (board_rownum_seq.nextval,'공유', '도깨비입니다', '김신', sysdate, 3333, 0);
insert into  board (rownumber,title, contents, writer, post_date,password, hits)
values (board_rownum_seq.nextval,'보검복지부', '팬클럽입니다', '박보검', sysdate, 4444, 0);
insert into  board (rownumber,title, contents, writer, post_date,password, hits)
values (board_rownum_seq.nextval,'태후', '송혜교가 상대역입니다', '송중기', sysdate, 4444, 0);



4.
commit;

5.
update board
set hits = (select hits from board where rownumber = 1) + 1
where rownumber =1

6.
update board
set title= '수정 제목', contents='수정 내용', post_date= sysdate
where rownumber = 1;

7.
commit;

8.
delete board
where password = 4444;

9.
rollback;

10.
update board
set writer = '유시진'
where title = '태후';


select rownumber, title, 
to_char(post_date, 'mm-dd hh24:mi:ss')
from board;




=============view================

1.
create view LOCATIONS_NOT_AMERICAS
as
select location_id, street_address, postal_code, city, country_name, region_name
from locations l , countries c, regions r 
where region_name != 'Americas'
and l.country_id = c.country_id
and c.region_id = r.region_id;

select * from locations_not_americas;

2.
create view employees_marketing
as
select employee_id, first_name, last_name, email, phone_number, 
hire_date, job_id, salary, commission_pct, manager_id, department_id
from employees e, departments d
where department_name = 'Marketing'
and e.department_id = d.department_id;

select * from employees_marketing;

3.
create view employees_backup
as
select *
from employees
where salary >5000;

4. 
create view dept_sal_info
as
select e.department_id dept_id , department_name dept_name, count(*) num_emp,
max(salary) max_sal , min(salary) min_sal , trunc(avg(salary)) avg_sal , sum(salary) sum_sal
from employees e, departments d
where e.department_id = d.department_id
group by e.department_id, department_name
having count(*)>=1;

select * from dept_sal_info;


5.
create view emp_markle
as
select first_name, last_name, job_id, salary
from employees
where job_id =
(select job_id from employeees where last_name = 'Markle');

select * from emp_markle;

6.
create table member(
userid varchar2(30) constraint member_userid_pk primary key,
password varchar2(10) constraint member_password_nn not null,
name varchar2(30) constraint member_name_nn not null,
adress varchar2(100),
gender char(1) constraint member_gender_ck check (gender in('M','F')),
in_date date default sysdate,
phone_number varchar2(30) constraint member_phone_ck check(phone_number like '010%'),
email varchar2(30) constraint member_email_ck check (email like '%@%')
);

insert into member(userid,password,name,adress,gender,phone_number,email)
values('홍길동','aaa','홍길동','aaa@aaa.com','M','01012341234','aaa@aaa.com');
insert into member(userid,password,name,adress,gender,phone_number,email)
values('심청이','bbb','심청이','aaa@aaa.com','M','01012341234','aaa@aaa.com');
insert into member(userid,password,name,adress,gender,phone_number,email)
values('김신','ccc','김신','aaa@aaa.com','M','01012341234','aaa@aaa.com');
insert into member(userid,password,name,adress,gender,phone_number,email)
values('박보검','ddd','박보검','aaa@aaa.com','M','01012341234','aaa@aaa.com');
insert into member(userid,password,name,adress,gender,phone_number,email)
values('유시진','eee','유시진','aaa@aaa.com','M','01012341234','aaa@aaa.com');

7.
create table board(
rownumber number(5) constraint board_rownum_pk primary key,
title varchar2(100) constraint board_title_nn not null,
contents varchar2(4000),
writer varchar2(30) ,
post_date date,
password number(5),
hits number(10) constraint board_hits_ck check (hits>=0));

alter table board drop constraint board_rownum_pk;
1.alter table board add constraint boardnum_pk primary key (rownumber);

2.alter table board add constraint board_writer_fk foreign key (writer) 
references member(USERID);


 ALTER TABLE 테이블
           MODIFY (컬럼1 VARCHAR2(05)  DEFAULT 'N' NOT NULL,
                   컬럼2 NUMBER(08)    DEFAULT 0   NOT NULL,

                   컬럼3 DATE          DEFAULT SYSDATE NOT NULL);
				   
3.alter table board modify (post_date date default sysdate);

4.alter table board modify (hits number(10) default 0);


========inline view top-n subquery============
8.
select *
from(select rownum r, first_name, hire_date
from(select * from employees order by hire_date desc))
where r<=5;

9.
select *
from(select rownum r, first_name, commission_pct
from(select * from employees order by commission_pct desc nulls last))
where r between 4 and 6;


10.
select *
from(select rownum r, job_id
from(select job_id , count(*) from employees 
group by job_id order by count(*) desc))
where r<=3;
