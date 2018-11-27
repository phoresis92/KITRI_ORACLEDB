DCL : Data Control Lang 
: GRANT 데이터 사용 권한 부여 / REVOKE 삭제
>사용자 생성 / 접속 테이블생성권한 : User(hr,SCOTT)X/admin(system)O관리계정만 사용가능


DCL : admin 계정만 사용
create user name identified by pass ;
grant connect, resource(일반유저 생성) to username; 


--SCOTT계정 생성
conn /as sysdba
@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\scott.sql
conn SCOTT/TIGER
desc emp;
select * from emp;)

--HR 계정 생성
conn /as sysdba;
alter user hr account unlock;
alter user hr identified by hr;

-- sysdba 접속
conn /as sysdba

-- user 생성
create user 유저명 identified by 비밀번호;

-- user 조회
select * from all_user;
select * from dba_user;

--dba 권한 주기
grant dba to 유저명;
grant connect, resource to project;

--user delete 유저삭제
drop user aaa cascade;



============================================================================

TCL : Transaction Crontrol Lang 
: COMMIT / ROLLBACK 데이터 트랜젝션 제어
>트랜잭션 : 여러 단일 작업으로 이루어진 논리적 업무 단위

 = 여러 sql 구성 작업 단위
 따라서 1개 sql 오류 발생시 실행하지 않는다.
 
  2개 sql 실행이 문제 없이 실행 : 2개 sql 실행 이후 commit;
 1sql 싱행완료 but 2sql 실행 안됨 = 1sql 실행 복구 rollback;


ex)
a to b 계좌이체작업 : 논리적 1개
- but 단위로 나누게 되면
1> a 계좌 출금
2> b 계좌 입금

if)
1> a 계좌 출금		완료
-------------은행 서버 다운(이전 완료 1번 작업 원상태 복구)
2> b 계좌 입금		미완료
-------------계좌이체작업완료

트랜잭션 내부 포함 모든 단일 작업
all		완료 
or 
nothing 원상태 복구

계좌정보 : 레코드
레코드 수정 2개 sql : 모두 완료 되어야 커밋


===============================================

create table account(
acc_id number(10) constraint acc_id_pk primary key,
password number(10),
balance(잔액) number(10,2));

insert into account
values (1001,1111,10000);
insert into account
values (2001,2222,0);

commit;

===============================================


select : 조회 : 데이터에 변화가 없기 때문에 커밋 롤백 x
ddl : 자동 commit;
dml : 커밋 롤백 처리해야한다.
 
drop rollback 불가
delete rollback 가능

트랜잭션 언제 시작 종료 하는가
db client tool 시작 - 트랜잭션 시작
insert
update
delete		commit / rollback - 트랜잭션 종료
자동 트랜잭션 시작
insert
update
delete		commit / rollback - 트랜잭션 종료
....
sql plus : 종료시 자동 commit
sql developer : 종료시 커밋/롤백 선택



1001 계좌에서 2001 계좌 5000원 이체
1> 1001계좌 5000원 출금 = 잔액 변경
update account
set balance = balance -5000
where acc_id = 1001;
2>2001계좌 5000 입금 = 잔액 변경
update account
set balance =+ 5000
where acc_id = 2001;
3>완료
commit; --트랜잭션 종료
--트랜잭션 시작
4>insert into account values(3001,3333,50000);
select * from account;
-- 현재 insert 영구적 저장x : 임시 메모리 저장 : 
--같은 session 확인가능, 다른 session 확인불가
commit; --트랜잭션 종료 ( 결과 db 반영하고 트랜잭션 종료)
--트랜잭션 시작
delete account where acc_id = 3001;
rollback; -- 트랜잭션 종료 ( sql 결과 취소 후 트랜잭션 종료)

=============================================================================

--데이터 로킹 (Lock)

-주의사항!!!
1 ddl 실행 이전 dml문장 : commit/rollback 설정
	-DDL은 입력과 동시에 자동 COMMIT 된다.
2. 트랜잭션 진행중인 dml 다른 session 사용 불가능(lock : 다른 session 멈춤)
3. 트랜잭션의 단위는 각각의 개인이 결정해야한다 규칙이 있지 않다.

--자바 + sql : sql 실행 멈춤상황 예시 ( lock )
--트랜잭션 시작
--sql developer 에서 밑 sql 입력
update account
set balance = balance*1.1
where acc_id = 3001;
--sqlplus에서 밑 sql 입력
update account 
set balance = balance+10000 
where acc_id = 3001;
--sqlplus 멈춤 ( lock 이 걸려있다)
--sql developer 에서 밑 sql 입력
rollback; -- sqlplus에서 lock 이 해제 된다
--sqlplus에서 밑 sql 입력
rollback; -- sql developer 락 해제


--트랜잭션 시작
--sql developer 에서 밑 sql 입력
update account
set balance = balance*1.1
where acc_id = 3001;

create table transactiontest (a number(1)); -- 자동 커밋

--sqlplus에서 밑 sql 입력
update account 
set balance = balance+10000 
--lock 이 걸려 있지 않다 왜냐 create table(ddl)명령으로 인해 자동 커밋


===================================================================












