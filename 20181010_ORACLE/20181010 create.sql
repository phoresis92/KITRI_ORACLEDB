
--non equi join
-employees 급여 등급 매기는 테이블
create table salgrade
(grade number(2),
lowsalary number(8,2),
hisalary number(8,2));


insert into salgrade values(1,1000,5000);
insert into salgrade values(2,5001,10000);
insert into salgrade values(3,10001,15000);
insert into salgrade values(4,15001,20000);
insert into salgrade values(5,20001,99999);

commit; rollback;