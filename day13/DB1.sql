SET serveroutput ON;

-- SELECT ��
--SELECT empno, ename
--    INTO vempno, vename
--    FROM emp
--    WHERE ename = '����';
    
-- Q) PL/SQL�� SELECT������ emp ���̺��� ��� ��ȣ�� �̸� ���

DECLARE
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
BEGIN
    SELECT empno, ename
    INTO vempno, vename
    FROM emp
    WHERE ename = '����';
    DBMS_OUTPUT.PUT_LINE('   ' || VEMPNO || '   ' || vename);
END;
/

SELECT * FROM emp;

-- ����ȣ�� job, mgr, deptno ���
DECLARE
    vename emp.ename%TYPE;
    vjob emp.job%TYPE;
    vmgr emp.mgr%TYPE;
    vdeptno emp.deptno%TYPE;
BEGIN
    SELECT ename, job, mgr, deptno
    INTO vename, vjob, vmgr, vdeptno
    FROM emp
    WHERE ename = '����ȣ';
    DBMS_OUTPUT.PUT_LINE('-----------------------');
    DBMS_OUTPUT.PUT_LINE(vename || '   ' || Vjob || '   ' || vmgr || '   ' || vdeptno);
END;
/

-- IF-THEN-END-IF
-- IF-THEN-ELSE-END IF
-- IF-THEN_ELSIF-ELSE-END IF

-- �μ� ��ȣ�� �μ��� �˾Ƴ���
DECLARE
    VEMPNO emp.empno%TYPE;
    vename emp.ename%TYPE;
    vdeptno emp.deptno%TYPE;
    vdname VARCHAR2(20) := NULL;
BEGIN
    SELECT empno, ename, deptno
    INTO vempno, vename, vdeptno
    FROM emp
    WHERE empno = 1001;
    
IF (vdeptno = 10) THEN
    vdname := '������';
    END IF;
IF (vdeptno = 20) THEN
    vdname := '������';
    END IF;
IF (vdeptno = 30) THEN
    vdname := '������';
    END IF;
IF (vdeptno = 40) THEN
    vdname := '�����';
    END IF;
DBMS_OUTPUT.PUT_LINE('-----------------------');
DBMS_OUTPUT.PUT_LINE(vempno || '   ' || vename || '   ' || vdeptno || '   ' || vdname);
END;
/

SELECT * FROM emp;
-- ������ ���� ���ϱ� (Ŀ�̼� ������ sal*12+comm �ƴϸ� sal*12)
DECLARE
    vename emp.ename%TYPE;
    vsal emp.sal%TYPE;
    vcomm emp.comm%TYPE;
    vasal NUMBER(7, 2);
BEGIN
    SELECT ename, sal, comm
    INTO vename, vsal, vcomm
    FROM emp
    WHERE ename = '����';
IF (vcomm IS NULL) THEN
    vasal := vsal*12;
ELSE
    vasal := vsal*12+vcomm;
    END IF;
DBMS_OUTPUT.PUT_LINE('-----------------------');
DBMS_OUTPUT.PUT_LINE(vename || '   ' || vsal || '   ' || vcomm || '   ' || vasal);
END;
/

-- ������ ��
DECLARE
  VEMP EMP%ROWTYPE;
  ANNSAL NUMBER(7,2);
BEGIN
  SELECT * INTO VEMP FROM EMP WHERE ENAME='����';
IF(VEMP.COMM IS NULL) THEN
   ANNSAL := VEMP.SAL * 12;
ELSE
   ANNSAL := VEMP.SAL * 12 + VEMP.COMM;
END IF;
  DBMS_OUTPUT.PUT_LINE('���  �̸�   ����');
  DBMS_OUTPUT.PUT_LINE('-----------------');
  DBMS_OUTPUT.PUT_LINE('  ' || VEMP.EMPNO || '  '  || VEMP.ENAME || '  ' || ANNSAL );
END;
/

-- ELSIF
DECLARE
   VEMPNO EMP.EMPNO%TYPE;
   VENAME EMP.ENAME%TYPE;
   VDEPTNO EMP.DEPTNO%TYPE;
   VDNAME VARCHAR2(20) := NULL;
BEGIN
  SELECT EMPNO, ENAME, DEPTNO
  INTO  VEMPNO,VENAME, VDEPTNO
  FROM EMP
  WHERE EMPNO = 1001;
  
  IF ( VDEPTNO = 10) THEN
     VDNAME := '�渮��';
  ELSIF ( VDEPTNO = 20) THEN
     VDNAME := '�λ��';
  ELSIF ( VDEPTNO = 30) THEN
     VDNAME := '������';
  ELSIF ( VDEPTNO = 40) THEN
     VDNAME := '�����';
  END IF;
  
  DBMS_OUTPUT.PUT_LINE(' ���   �̸�  �μ��� ');
  DBMS_OUTPUT.PUT_LINE('-------------------');
  DBMS_OUTPUT.PUT_LINE('  ' || VEMPNO || '  ' || VENAME || '   ' ||  VDNAME );
END;
/

-- �ݺ��� LOOP
DECLARE
BEGIN 
    FOR N IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE( N );
    END LOOP;
END;
/
-- 1 2 3 4 5 5ȸ ���� �Ǵ� �ݺ�����
DECLARE
    N NUMBER :=1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE ( N );
        N := N+1;
        IF N > 10 THEN
            EXIT;
        END IF;
    END LOOP;
END;
/

-- 1~100 �� 
DECLARE
    total NUMBER := 0;
BEGIN
    FOR n IN 1..100 LOOP
        DBMS_OUTPUT.PUT_LINE(n);
        total := total + n;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(total);
END;
/

DECLARE
    n NUMBER := 1;
    total NUMBER := 0;
BEGIN
    WHILE n <= 5 LOOP
    DBMS_OUTPUT.PUT_LINE(n);
    total := total + 1;
    n := n+1;
    END LOOP;
END;
/

-- ���� S_EMP���̺��� ���� ����� ������ �����̸� �޿��� 10%�λ��ϰ�, �׷��� ������ 5%�λ��Ű���� �Ѵ�.
--DECLARE
--    vcsal NUMBER(7,2);
--BEGIN
--    SELECT * INTO s_emp FROM emp;




-- ������ ��
CREATE TABLE s_emp
AS
SELECT * FROM emp;

SELECT * FROM s_emp;

DECLARE
    vemp s_emp%ROWTYPE;
    vdeptno s_emp.deptno%TYPE;
    vpercent NUMBER(2);
BEGIN
    SELECT deptno INTO vdeptno FROM dept WHERE dname LIKE ('%����%');
    SELECT * INTO vemp FROM s_emp WHERE ename = '����';
    
    IF vemp.deptno = vdeptno THEN
        vpercent := 10;
    ELSE
        vpercent := 5;
    END IF;
    
    UPDATE s_emp SET sal = sal + sal*vpercent/100 WHERE ename = '����';
    COMMIT;
END;
/

SELECT * FROM s_emp WHERE ename = '����';
--���� ���ν���
drop table emp01;

create table emp01
as
select * from emp;

select * from emp01;

--���� ���ν����� ����
--����� --> ������
CREATE OR REPLACE PROCEDURE DEL_ALL
IS
BEGIN
    DELETE FROM EMP01;
    COMMIT;
END;

--���� ���ν����� �����ϱ�
EXECUTE DEL_ALL;

INSERT INTO EMP01(EMPNO) VALUES(1);

SELECT * FROM EMP01;

--���� ���ν��� ��ȸ�ϱ�
DESC USER_SOURCE;

SELECT * FROM USER_SOURCE WHERE NAME IN ('DEL_ALL');

--���� ���ν����� �Ű�����
CREATE OR REPLACE PROCEDURE DEL_ENAME(VENAME EMP01.ENAME%TYPE)
IS
BEGIN
    DELETE FROM EMP01 WHERE ENAME LIKE VENAME;
    COMMIT;
END;

--�����ϱ�
EXECUTE DEL_ENAME('%��%');
EXECUTE DEL_ENAME('%��%');
SELECT * FROM EMP01;

--IN, OUT, INOUT�Ű�����
--���� ���ν����� ������ �� MODE�� 3���� �ִ�.
--IN : �����͸� ���� ���� �� ���δ�.
--OUT : ����� ����� �޾� �� �� ���
--INOUT : IN + OUT 

--1) IN �Ű�����
EXECUTE DEL_ENAME('%��%');

CREATE OR REPLACE PROCEDURE DEL_ENAME(VENAME IN EMP01.ENAME%TYPE)

--2) OUT �Ű�����
CREATE OR REPLACE PROCEDURE SEL_EMPNO 
    (VEMPNO IN EMP.EMPNO%TYPE,
    VENAME OUT EMP.ENAME%TYPE,
    VSAL OUT EMP.SAL%TYPE,
    VJOB OUT EMP.JOB%TYPE)
IS
BEGIN
    SELECT ENAME,SAL,JOB INTO VENAME, VSAL, VJOB FROM EMP WHERE EMPNO = VEMPNO;
END;

--�ٿ�� ��������
VARIABLE VAR_ENAME VARCHAR2(15);
VARIABLE VAR_SAL NUMBER;
VARIABLE VAR_JOB VARCHAR2(9);

--���� ���ν��� ����
EXECUTE SEL_EMPNO(1001,:VAR_ENAME,:VAR_SAL,:VAR_JOB);

--�ٿ�� ������ ���� ����ϱ�
PRINT VAR_ENAME
PRINT VAR_SAL
PRINT VAR_JOB
