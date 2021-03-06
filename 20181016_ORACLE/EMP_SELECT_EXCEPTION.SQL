CREATE OR REPLACE PROCEDURE EMP_SELECT_EXCEPTION
(NAME IN EMPLOYEES.FIRST_NAME%TYPE)

IS
FULL_NAME EMPLOYEES.FIRST_NAME%TYPE;

BEGIN
SELECT LAST_NAME || ',' || FIRST_NAME
INTO FULL_NAME
FROM EMPLOYEES WHERE FIRST_NAME = NAME;
DBMS_OUTPUT.PUT_LINE('조회사원 전체이름 = '|| full_name);

EXCEPTION
WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('존재하지 않는 사원입니다');
WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('중복 이름의 사원입니다');

END;
/