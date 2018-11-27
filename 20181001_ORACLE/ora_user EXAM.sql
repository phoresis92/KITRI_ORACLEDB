
번호가 실행 순서!!!! 외우기!!!!

5 SELECT + COLLUM
1 FROM + 테이블명
2 WHERE + 조건문
3 GROUP BY + COLLUM
4 HAVING + 컬럼
6 ORDER BY + 순서



ora_user

select stu_name as 이름, stu_height as 키 from student
where stu_hegiht >= 170;
select distinct stu_dept from student;


ora_user2


select ename, job from emp
where sal >3000;

select ename, job from emp 
where job = 'SALESMAN'
and sal >= 1500;

월급이 2000~3000인 이름과 직책을 표시하시오
select ename, job from emp 
where sal <=3000
and sal >=2000;

select ename, job from emp 
where sal
between 2000 and 3000;

 

 

select distict job from emp
where sal <= 3000
and sal>=2000;

 

select ename,job from emp
where ename like '_A%';

 


SELECT ENAME,JOB FROM EMP
WHERE JOB IN ('MANAGER','SALESMAN');

SELECT ENAME,JOB FROM EMP
WHERE JOB ='MANAGER'OR JOB='SALESMAN';

 

이름이 A 시작하면서
직책이 clerk 이거나 salesman인 
사람의 이름과 사원번호, 월급을 표시

select ename,empno,sal from emp
where ename like 'A%'
and (job = 'CLERK' OR JOB = 'SALESMAN');


select ename,empno,sal from emp
where ename like 'A%'
and job in ('CLERK' , 'SALESMAN');

 

 

select ename, sal+comm from emp;

select ename, sal*1.1 from emp;

select ename, sal from emp
where comm is null;

select ename, sal from emp
where comm is not null;


커미션을 받지 않는 사람 중에 월급이 3000이하인 사람의
이름과 직책, 입사일을 표시하시오.


select ename, job, hiredate from emp
where comm is null
and sal <=3000
ORDER BY ename desc;

select ename, job, hiredate from emp
where comm is null
and sal <=3000
ORDER BY 2 desc;

 

1987년 이후에 입사한 직원의
이름과 직책, 입사일을 표시하시오


select ename, job, hiredate from emp
where hiredate >= '1987-01-01';