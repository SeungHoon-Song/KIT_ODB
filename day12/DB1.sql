--����� �ִ� ������ ȭ�鿡 �����ֱ� ���� ȯ�漳�� �����ϱ�
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
    VENAME := '����';
    DBMS_OUTPUT.PUT_LINE('  ��   ��   ��   ��');
    DBMS_OUTPUT.PUT_LINE('-------------------');
    DBMS_OUTPUT.PUT_LINE('  '||VEMPNO||'    '||VENAME);
END;

--��ī�󺯼� : SQL���� ����ϴ� �ڷ����� ���� ������, ������ ��� NUMBER, ������ VARCHAR2
    --VEMPNO NUMBER(4);
--���۷��� ���� : ������ ����� �ٸ� ���� �Ǵ� �����ͺ��̽� �÷��� ���߾� ������ �����ϱ� ���� %TYPE�Ӽ��� ����� �� �ִ�.
    --������ ���̺��.�÷���%TYPE
    --VEMPNO EMP.EMPNO%TYPE;
--%TYPE�Ӽ��� ����Ͽ� ������ VEMPNO������ �ش� ���̺�(EMP)�� �ش� �÷�(EMPNO)�� �ڷ����� ũ�⸦ �״�� �����ؼ� �����մϴ�.\
--%ROWTYPE���� : Ư�����̺��� �ο������ �����ؼ� ���۷��� ���� �����ϱ�
    --VEMP EMP%ROWTYPE;
    --EMP���̺��� ���� ��ü�� ���� ����