
create user ora_user2 identified by ora_user2;
grant dba to ora_user2;
connect ora_user2;


번호가 실행 순서!!!! 외우기!!!!
5 SELECT + COLLUM
1 FROM + 테이블명
2 WHERE + 조건문
3 GROUP BY + COLLUM
4 HAVING + 컬럼
6 ORDER BY + 순서


create table dept(
deptno number(2)
constraint pk_dept primary key,
dname varchar2(14),
loc varchar2(13));



insert into dept values (10,'ACCOUNTING','NEW YORK');
insert into dept values (20,'RESEARCH','DALLAS');
insert into dept values (30,'SALES','CHICAGO');
insert into dept values (40,'OPERATIONS','BOSTON');


 

create table emp(
empno number(4)
constraint pk_emp primary key,
ename varchar2(10),
job varchar2(9),
mgr number(4),
hiredate date,
sal number(7,2),
comm number(7,2),
deptno number(2));


insert into emp values(7839,'KING','PRESIDENT',NULL,
to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
insert into emp values(7566,'JONES','MANAGER',7839,
to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
insert into emp values(7698,'BLAKE','MANAGER',7839,
to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
insert into emp values(7782,'CLARK','MANAGER',7839,
to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
insert into emp values(7788,'SCOTT','ANALYST',7566,
to_date('13-07-1987','dd-mm-yyyy'),3000,NULL,20);
insert into emp values(7902,'FORD','ANALYST',7566,
to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
insert into emp values(7499,'ALLEN','SALESMAN',7698,
to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
insert into emp values(7521,'WARD','SALESMAN',7698,
to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
insert into emp values(7654,'MARTIN','SALESMAN',7698,
to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
insert into emp values(7844,'TURNER','SALESMAN',7698,
to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
insert into emp values(7900,'JAMES','CLERK',7698,
to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
insert into emp values(7934,'MILLER','CLERK',7782,
to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);
insert into emp values(7369,'SMITH','CLERK',7902,
to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
insert into emp values(7876,'ADAMS','CLERK',7788,
to_date('13-07-1987','dd-mm-yyyy'),1100,NULL,20);



create table salgrade(
grade number(7,2),
losal number(7,2),
hisal number(7,2));


insert into salgrade values(1,700,1200);
insert into salgrade values(2,1201,1400);
insert into salgrade values(3,1401,2000);
insert into salgrade values(4,2001,3000);
insert into salgrade values(5,3001,9999);

