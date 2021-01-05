--ppt 118 DML ������ ���۾�
CREATE TABLE dept01(
    deptno number(4),
    dname varchar2(14),
    loc varchar2(13));

--��ü ���� �� �Է��ϱ�
INSERT INTO dept01 (deptno,dname,loc) VALUES (10,'�渮��','����');
INSERT INTO dept01 (loc,dname,deptno) VALUES ('��õ','�����',20);
INSERT INTO dept01 (loc,dname,deptno) VALUES (10,'�����','100');

--�����ϱ� ���� ������� �ڷḦ �ֱ�
INSERT INTO dept01 VALUES (30,'������','�λ�');
--INSERT INTO dept01 VALUES ('��õ','�����',20);(X)

SELECT * FROM dept01;

--NULL�� ���Ͽ� �Է��ϱ�
INSERT INTO dept01 VALUES(40,'�λ��',NULL);
INSERT INTO dept01 VALUES(50,'�λ��','');
INSERT INTO dept01(deptno,dname) VALUES(50,'�λ��');

--���̺� �����
drop TABLE emp02;
--���̺� �����
CREATE TABLE emp02(
    empno number(4),
    ename varchar2(10),
    job varchar2(9),
    hiredate date,
    deptno number(2));    
--���̺� ��������
DESC emp02;
--������ �����ϱ�
INSERT INTO emp02 VALUES (1001,'����','���','2021/01/05',20);
INSERT INTO emp02 VALUES (1002,'�ѿ���','�븮',to_date('2021/01/10','YYYY/MM/DD'),10);
--�ý��ۿ��� ���ó�¥�� ��¥�� �ڷḦ �ֱ�
INSERT INTO emp02 VALUES (1003,'�ְ���','���',SYSDATE,30);
--���̺� �ڷ� �˻��ϱ�
SELECT * FROM emp02;

SELECT * FROM dept01;
--������ �����ϱ� UPDATE
UPDATE dept01 
    SET dname='�����'
    WHERE deptno = 10;
    
--deptno 50�� ��� '�ѹ���', ���� '����'
UPDATE dept01
    SET dname = '�ѹ���',loc = '����'
    WHERE deptno = 50;

--loc�� ��� ����� �ٲٱ�
UPDATE dept01
    SET loc = '����';

UPDATE dept01
    SET deptno = deptno + 1000;
--���� ó������ �ǵ��� ��  ó���� insert�ߴ� �ڷ� ����
rollback;
--DB�� ����(������) rollback �ȵ�
commit;
SELECT * FROM dept01;

--������ �����ϱ�(��, ���ڵ�, Ʃ��)
DELETE dept01 where loc = '�λ�';
--����� 1020�� ���ڵ� ����
DELETE dept01 where deptno = 1020 AND dname = '�����';
DELETE dept01;
rollback;

--1. ������ ��� ������ �����ϴ� employee03���̺��� �����մϴ�. �� ���̺��� �����Ǿ����� Ȯ���ϱ�
CREATE TABLE employee03(
    empno number(4) not null,
    ename varchar2(20),
    job varchar2(20),
    sal number(7,3));
desc employee03;
--2. ������ ���̺� ������ ���� ������(�� 5��)�� �߰��մϴ�. �߰��� �����͸� ���� NULL���� ���� ���ڸ� ���� ���� �������� Ȯ���� �� �ֽ��ϴ�.
INSERT INTO employee03 VALUES (1000,'ȫ�浿','���',100);
INSERT INTO employee03 VALUES (1010,'�̼���','�븮',150);
INSERT INTO employee03 VALUES (1020,'ȫ����','����',200);
INSERT INTO employee03 VALUES (1030,'�ڰ��','�븮',150);
INSERT INTO employee03 VALUES (1040,'�躴��',null,50);
INSERT INTO employee03 VALUES (1050,'���μ�',null,35);
select * from employee03;
--3. ���̺� ����� ��� �� �޿��� 200�̸��� ������� �޿��� 50�� �λ��Ͻÿ�
UPDATE employee03
    SET sal=sal+50
    WHERE job='���' AND sal<200;
--4. ������ �������� ���� ����� �����ϼ���
DELETE FROM employee03 WHERE job IS NULL;


DESC user_constraints;

--ppt 126
--�ش� DB���� ���̺� ���� �������� ��Ȳ���� �� �� �ִ�.
select owner, constraint_name, constraint_type from user_constraints;

select * from user_constraints;

--NOT NULL��������
insert into emp02
    values (null,null,'���',sysdate,20);

desc emp02;
drop table emp02;

create table emp02(
    empno number(4) not null,
    ename varchar2(10) not null,
    job varchar2(9),
    hiredate date,
    deptno number(2));

--�°� ������ ���� ����
insert into emp02
    values (1010,'�λ��','���',sysdate,30);
insert into emp02
    values (1010,'�λ��',null,null,null);
--Ʋ���� ������ ���� ����
insert into emp02
    values (1010,'','���',sysdate,20);
    
insert into emp02
    values (1010,null,'���',sysdate,20);

insert into emp02 (empno,job,hiredate,deptno)
    values (1010,'���',sysdate,20);

select * from emp02;



--������ ���� ����ϴ� UNIQUE���� ����
CREATE TABLE emp03(
    empno number(4) UNIQUE,
    enmae varchar2(10) not null,
    job varchar2(9),
    deptno number(2));

desc emp03;
select * from user_constraints where table_name = 'EMP03';
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'emp03'; --�����Ͱ� ��ҹ��ڱ���

--���������� �����͸� �����ϱ�
INSERT INTO emp03 VALUES (1010,'ȫ�浿','���',10);
INSERT INTO emp03 VALUES (1020,'�̼���','���',20);
INSERT INTO emp03 VALUES (null,'�̼���','���',20);
--����Ű ����� �Է� �ȵǰ� �ϱ�
INSERT INTO emp03 VALUES (null,'������','�븮',30);
select * from emp03;

--���� ���ǿ� ��Ī�� �ο��ϱ�
--�̿�о� : ���������� �������� ����ؾ� �Ǵ� ���, �������� �Ͻ�����
CREATE TABLE emp04(
    empno number(4) CONSTRAINT emp04_empno_UK UNIQUE,
    enmae varchar2(10) CONSTRAINT emp04_ename_NN NOT null,
    job varchar2(9),
    deptno number(2));
    
    
select * from user_constraints where table_name = 'EMP04';
select * from user_constraints where table_name = 'EMP03';

--PRIMARY ��������
CREATE TABLE emp05(
    empno number(4) CONSTRAINT emp05_empno_PK primary key,
    ename varchar2(10) CONSTRAINT emp05_ename_NN Not null,
    job varchar2(9),
    deptno number(2));
    
--�������� ������ �ֱ�
INSERT INTO emp05 VALUES (1010,'a','���',10);
--Primary key�� ����ǰ� �Է�
--UNIQUE ����
INSERT INTO emp05 VALUES (1010,'a','���',10);
--Not null ����
INSERT INTO emp05 VALUES (null,'a','���',10);
--���� ���� ���� ����
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, R_CONSTRAINT_NAME, TABLE_NAME 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME in ('EMP05');
    
--FOREIGN KEY��������
CREATE TABLE emp06(
    empno number(4) CONSTRAINT emp06_empno_PK Primary key,
    ename varchar2(10) CONSTRAINT emp06_ename_NN NOT null,
    job varchar2(9),
    deptno number(2) CONSTRAINT emp06_deptno_FK REFERENCES DEPT(deptno));
    
--dept ���̺��� ���� ������
desc dept;
--dept ���̺��� �������� ������
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME IN ('DEPT');
--dept ���̺��� �ڷ� �˻�
SELECT * FROM dept;
--emp06���̺� �ڷḦ ���� �Է��ϱ�
INSERT INTO emp06 VALUES (1010,'ȫ�浿','���',10);
INSERT INTO emp06 VALUES (1020,'ȫ�浿','���',30);
--�ܷ�Ű�� ����ǰ� �ڷ� �ֱ�
INSERT INTO emp06 VALUES (1030,'ȫ�浿','���',60);  --���� : ����? dept ���̺� deptno�� ���� 60�� ��� �ֱ� ������

desc dept;
--emp07���̺��� ����� �ܷ�Ű�� loc�� ���- ����(�θ����̺��� �⺻Ű�� �ƴϱ� ����)
CREATE TABLE emp07(
    empno number(4) CONSTRAINT emp07_empno_pk Primary key,
    ename varchar2(10) CONSTRAINT emp07_ename_nn not null,
    job varchar2(9),
    deptno number(2),
    loc varchar2(13) CONSTRAINT emp07_loc_FK REFERENCES DEPT(loc));

select constraint_name, table_name, column_name from user_cons_columns;

--CHECK ���� ����
CREATE TABLE emp07(
    empno number(4) CONSTRAINT emp07_empno_PK primary key,
    ename varchar2(10) CONSTRAINT emp07_ename_NN not null,
    sal number(7,2) CONSTRAINT emp07_sal_ck CHECK(sal between 500 and 5000),
    gender varchar2(1) CONSTRAINT emp07_gender_ck CHECK(gender in('M','m','F','f')));
--���� �Է�
INSERT INTO emp07 VALUES (1010,'ȫ�浿',1000,'M');
--���� �Է�
--sal���� ����
INSERT INTO emp07 VALUES (1010,'ȫ�浿',100,'M');
--gender���� ����
INSERT INTO emp07 VALUES (1030,'ȫ�浿',1000,'K');

--default ���� ����
create table dept01(
    deptno number(2) CONSTRAINT dept01_deptno_pk primary key,
    dname varchar2(14),
    loc varchar2(13) default '����');

--�����Է�
insert into dept01 values(10, '�λ��', '��õ');
--loc �����ؼ� �Է��ϱ�
insert into dept01(deptno, dname) values(20,'�����');

select * from dept01;

--���� ���� ����� ��� : 1. �÷����� ��������, 2. ���̺� ���� ��� ��������(����Ű, alter table�� ���������� ���߿� �߰����ٶ�)

--��� �÷� ���� ���� ����
CREATE TABLE emp01(
    empno number(4) Primary key,
    ename varchar2(10) not null,
    job varchar2(9) UNIQUE,
    deptno number(2) REFERENCES dept(deptno));
    
--������ ���� ����� ���� �����ϱ�
CREATE TABLE emp02(
    empno number(4),
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2),
    CONSTRAINT emp02_empno_pk PRIMARY KEY(empno),
    CONSTRAINT emp02_job_uk UNIQUE(job),
    CONSTRAINT emp02_deptno_fk FOREIGN KEY(deptno) REFERENCES dept(deptno));
    

CREATE TABLE emp03(
    empno number(4),
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2),
    PRIMARY KEY(empno),
    UNIQUE(job),
    FOREIGN KEY(deptno) REFERENCES dept(deptno));
    
--user_constraints ������ ��ųʸ�
--emp01, emp02, emp03 ���̺��� ���������� �˻�
select * from user_constraints where table_name in ('EMP01','EMP02','EMP03');

--�⺻Ű�� ����Ű�� �����ϴ� ���
--�̸��� ��ȭ��ȣ�� �����Ͽ� �⺻Ű�� �����ϱ�
CREATE TABLE member01 (
    name varchar2(10),
    address varchar2(30),
    phone varchar2(16),
    CONSTRAINT member01_name_phne_pk PRIMARY KEY(name,phone));

--�Է��ϱ�
insert into member01 values ('a','seoul','123');
insert into member01 values ('b','seoul','123');

select * from member01;





