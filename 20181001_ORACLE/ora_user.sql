
create user ora_user identified by ora_user;
grant dba to ora_user;
connect ora_user;



번호가 실행 순서!!!! 외우기!!!!
5 SELECT + COLLUM
1 FROM + 테이블명
2 WHERE + 조건문
3 GROUP BY + COLLUM
4 HAVING + 컬럼
6 ORDER BY + 순서




create table student(
stu_no char(9),
stu_name varchar2(12),
stu_dept varchar2(20),
stu_grade number(1),
stu_class char(1),
stu_gender char(1),
stu_height number(5,2),
stu_weight number(5,2),
constraint p_stu_no primary key(stu_no));

 
create table subject(
sub_no char(3),
sub_name varchar2(30),
sub_prof varchar2(12),
sub_grade number(1),
sub_dept varchar2(20),
constraint p_sub_no primary key(sub_no));

 
create table enrol(
sub_no char(3),
stu_no char(9),
enr_grade number(3),
constraint p_course primary key(sub_no,stu_no));
 

 

insert into student values(20153075,'옥한빛','기계',1,'c','m',177,80);
insert into student values(20153088,'이태연','기계',1,'c','f',162,50);
insert into student values(20143054,'유가인','기계',2,'c','f',154,47);
insert into student values(20152088,'조민우','전기전자',1,'c','m',188,90);
insert into student values(20142021,'심수정','전기전자',2,'a','f',168,45);
insert into student values(20132003,'박희철','전기전자',3,'b','m',null,63);
insert into student values(20151062,'김인중','컴퓨터정보',1,'b','m',166,67);
insert into student values(20141007,'진현무','컴퓨터정보',2,'a','m',174,64);
insert into student values(20131001,'김종헌','컴퓨터정보',3,'c','m',null,72);
insert into student values(20131025,'옥성우','컴퓨터정보',3,'a','f',172,63);


insert into subject values('111','데이터베이스','이재영',2,'컴퓨터정보');
insert into subject values('110','자동제어','정순정',2,'전기전자');
insert into subject values('109','자동화설계','박민영',3,'기계');
insert into subject values('101','컴퓨터개론','강종영',3,'컴퓨터정보');
insert into subject values('102','기계공작법','김태영',1,'기계');
insert into subject values('103','기초전자실험','김유석',1,'전기전자');
insert into subject values('104','시스템분석설계','강석현',3,'컴퓨터정보');
insert into subject values('105','기계요소설계','김명성',1,'기계');
insert into subject values('106','전자회로시험','최영민',3,'전기전자');
insert into subject values('107','CAD응용실습','구봉규',2,'기계');
insert into subject values('108','소프트웨어공학','권민성',1,'컴퓨터정보');

insert into enrol values('101','20131001',80);
insert into enrol values('104','20131001',56);
insert into enrol values('106','20132003',72);
insert into enrol values('103','20152088',45);
insert into enrol values('101','20131025',65);
insert into enrol values('104','20131025',65);
insert into enrol values('108','20151062',81);
insert into enrol values('107','20143054',41);
insert into enrol values('102','20153075',66);
insert into enrol values('105','20153075',56);
insert into enrol values('102','20153088',61);
insert into enrol values('105','20153088',78);