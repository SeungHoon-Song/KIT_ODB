--Ʈ���� ����
--��) ���̺� �����͸� �Է��� �� �ִ� �ð� �����ϱ�
--1. ����� ���̺� �����
CREATE TABLE T_ORDER ( NO NUMBER, ORD_CODE VARCHAR2(10), OR_DATE DATE);
--2. ������ ���̺� �����͸� �Է��� �� �Է½ð��� 13:00 ~ 18:00�� ��츸 �Է��� ����ϰ� �� �� �ð��� ���� ������
--�߻���Ű�� Ʈ���Ÿ� �����
CREATE OR REPLACE TRIGGER T_ORDER
BEFORE INSERT ON T_ORDER
BEGIN
    IF(TO_CHAR(SYSDATE, 'HH24:MI') NOT BETWEEN '13:00' AND '15:00') THEN
    RAISE_APPLICATION_ERROR(-20100,'���ð��� �ƴմϴ�');
    END IF;
END;

--3. �ý����� ��¥ Ȯ���ϱ�
SELECT SYSDATE FROM DUAL;
--4. �����غ���
INSERT INTO T_ORDER VALUES(3,'C100',SYSDATE);

SELECT * FROM T_ORDER;

--Ʈ���� ����2
--��) ���̺� �Էµ� ������ ���� �����ϰ� �װ��̿ܿ��� ������ �߻���Ű�� Ʈ���Ÿ� �����մϴ�. (�෹�� Ʈ����)
--��ǰ�ڵ尡 'C100'���� ��ǰ�� �Էµ� ��� �Է��� ����ϰ� ������ ��ǰ�� ��� ������ �߻���Ű�� Ʈ���Ÿ� �ۼ��մϴ�.
--1. Ʈ���� �����ϱ�
CREATE OR REPLACE TRIGGER T_ORDER2
    BEFORE INSERT ON T_ORDER
    FOR EACH ROW
    BEGIN
        IF(:NEW.ORD_CODE) NOT IN ('C200') THEN
        RAISE_APPLICATION_ERROR(-20200,'��ǰ�ڵ尡 Ʋ���ϴ�!');
        END IF;
END;

INSERT INTO T_ORDER VALUES (4,'C100',SYSDATE);

INSERT INTO T_ORDER VALUES (5,'C200',SYSDATE);

--Ʈ���� ����3
--��) ��� ��ǰ�� Ʈ���Ű� �۵��Ǵ� ���� �ƴ϶� ORD_CODE�� 'C500'�� ��ǰ�� ���ؼ��� 19:30~19:35�б�����
--�Էµǵ��� ����ϴ� Ʈ���Ÿ� ����ϴ�.
--'C500'�̿��� �ٸ� ��ǰ �ڵ�� �ð��� ������� ���������� �Է��� �˴ϴ�.
--1. Ʈ���� �����ϱ�
CREATE OR REPLACE TRIGGER T_ORDER3
    BEFORE INSERT ON T_ORDER
    FOR EACH ROW
    WHEN (NEW.ORD_CODE = 'C500')
    BEGIN
        IF(TO_CHAR(SYSDATE,'HH24:MI')NOT BETWEEN '14:00' AND '14:10') THEN
        RAISE_APPLICATION_ERROR(-20300,'C500��ǰ�� �Է���� �ð��� �ƴմϴ�.');
        END IF;
END;

INSERT INTO T_ORDER VALUES(5,'C500',SYSDATE);

DROP TRIGGER T_ORDER2;

--Ʈ���� ����4
--��) �޿������� �ڵ����� �߰��ϴ� Ʈ���� �ۼ��ϱ�
--1. �޿� ���̺�(SAL01) �����
DROP TABLE SAL01;

CREATE TABLE SAL01(
    SALNO NUMBER(4) PRIMARY KEY,
    SAL NUMBER(7,2),
    EMPNO NUMBER(4) REFERENCES EMP02(EMPNO));

DROP TABLE EMP02;

CREATE TABLE EMP02(
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(20),
    JOB VARCHAR2(20));
    
--2. �޿���ȣ�� �ڵ� �����ϴ� ������ �����ϱ�
CREATE SEQUENCE SAL01_SALNO_SEQ;

--3. Ʈ���� �ۼ��ϱ�
CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON EMP02
FOR EACH ROW
BEGIN
    INSERT INTO SAL01 VALUES(SAL01_SALNO_SEQ.NEXTVAL,100,:NEW.EMPNO);
END;

--4. ������̺� �ο찡 �߰��Ǹ� �ڵ����� ������ Ʈ���Ű� �����˴ϴ�.
INSERT INTO EMP02 VALUES (100,'B','����');
SELECT * FROM EMP02;
SELECT * FROM SAL01;

--��) �޿������� �ڵ� �߰��ϴ� Ʈ���� �����ϱ�
DROP TRIGGER TRG_02;


--------------------------------------------
--INSERT Ʈ���� �ۼ��ϱ�
--1. ����� ���̺� �����
--1) ��ǰ ���̺�
CREATE TABLE ��ǰ(
    ��ǰ�ڵ� CHAR(6) PRIMARY KEY,
    ��ǰ�� VARCHAR2(12) NOT NULL,
    ������ VARCHAR2(12),
    �Һ��ڰ��� NUMBER(8),
    ������ NUMBER DEFAULT 0);
    
--2) �԰� ���̺� �����ϱ�
CREATE TABLE �԰�(
    �԰��ȣ NUMBER(6) PRIMARY KEY,
    ��ǰ�ڵ� CHAR(6) REFERENCES ��ǰ(��ǰ�ڵ�),
    �԰����� DATE DEFAULT SYSDATE,
    �԰���� NUMBER(6),
    �԰�ܰ� NUMBER(8),
    �԰�ݾ� NUMBER(8));
    
--3) �ڷ� ����
INSERT INTO ��ǰ VALUES('A00001','��Ź��','LG',200,0);
INSERT INTO ��ǰ VALUES('A00002','��ǻ��','LG',700,0);
INSERT INTO ��ǰ VALUES('A00003','�����','�Ｚ',600,0);

--4) �԰� ���̺� ��ǰ�� �ԷµǸ� �԰������ ��ǰ���̺��� ��� ������ �߰��ϴ� Ʈ���Ÿ� �ۼ�
--(1) �԰� Ʈ���� �����ϱ�
CREATE OR REPLACE TRIGGER TRG_04
    AFTER INSERT ON �԰�
    FOR EACH ROW
BEGIN
    UPDATE ��ǰ SET ������ = ������ + :NEW.�԰����
    WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
END;

--5) Ʈ���Ÿ� �����Ų �� �԰� ���̺� ���� �߰��մϴ�. �԰� ���̺��� ���� ��ǰ ���̺��� ��� ������ ������� Ȯ���� �� �ֽ��ϴ�.
--(1) ��ǰ �԰��ϱ�
INSERT INTO �԰� (�԰��ȣ, ��ǰ�ڵ�, �԰����, �԰�ܰ�, �԰�ݾ�) VALUES (1,'A00001',5,320,1600);
--(2) �԰����̺� ��ȸ�ϱ�
SELECT * FROM �԰�;
--(3) ��ǰ ���� ��ȸ�ϱ�
SELECT * FROM ��ǰ;
--(4) �԰����̺� ��ǰ�� �ԷµǸ� �ڵ����� ��ǰ ���̺��� ��� ������ �����ϰ� �˴ϴ�. �԰� ���̺� �Ǵٸ� ��ǰ�� �Է��մϴ�.
