--출력해 주는 내용을 화면에 보여주기 위해 환경설정 변경하기
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO');
    DBMS_OUTPUT.PUT_LINE('DBMS');
END;

DECLARE
    VEMPNO NUMBER(4);
    VENAME VARCHAR2(10);
BEGIN
    VEMPNO := 1001;
    VENAME := '김사랑';
    DBMS_OUTPUT.PUT_LINE('  사   번   이   름');
    DBMS_OUTPUT.PUT_LINE('-------------------');
    DBMS_OUTPUT.PUT_LINE('  '||VEMPNO||'    '||VENAME);
END;

--스카라변수 : SQL에서 사용하던 자료형과 거의 유사함, 숫자인 경우 NUMBER, 문자형 VARCHAR2
    --VEMPNO NUMBER(4);
--래퍼런스 변수 : 이전에 선언된 다른 변수 또는 데이터베이스 컬럼에 맞추어 변수를 선언하기 위해 %TYPE속성을 사용할 수 있다.
    --변수명 테이블명.컬럼명%TYPE
    --VEMPNO EMP.EMPNO%TYPE;
--%TYPE속성을 사용하여 선언한 VEMPNO변수는 해당 테이블(EMP)의 해당 컬럼(EMPNO)의 자료형과 크기를 그대로 참조해서 정의합니다.\
--%ROWTYPE변수 : 특정테이블의 로우단위로 참조해서 레퍼런스 변수 선언하기
    --VEMP EMP%ROWTYPE;
    --EMP테이블의 한행 전체에 대한 변수