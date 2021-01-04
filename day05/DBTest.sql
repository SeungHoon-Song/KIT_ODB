CREATE TABLE employee (emp_no number(4) PRIMARY KEY,
                        emp_name varchar2(20) not null,
                        salary number(6),
                        birthday date);

drop table employee;

CREATE TABLE employee (emp_no number(4) not null,
                        emp_name varchar2(20) not null,
                        salary number(6),
                        birthday date,
                        CONSTRAINT employee_PK PRIMARY KEY(emp_no));
drop table specialty;

--specialty ���̺� �����
--2���� primary key ���� ��� (����Ŭ���� �Ϻ� ����)
CREATE TABLE specialty (emp_no Number(4) not null,
                        specialty varchar2(20) not null,
                        CONSTRAINT specialty_PK PRIMARY KEY(emp_no, specialty),
                        CONSTRAINT specialty_FK FOREIGN KEY(emp_no) REFERENCES employee(emp_no));

--project ���̺� �����
CREATE TABLE project (pro_no number(4) not null,
                    pro_content varchar2(100) not null,
                    start_date date,
                    finish_date date,
                    CONSTRAINT project_PK PRIMARY KEY(pro_no));
desc project;                 
--assign ���̺� �����    
CREATE TABLE assign (emp_no number(4) not null,
                    pro_no number(4) not null,
                    CONSTRAINT assign_PK PRIMARY KEY(emp_no,pro_no),
                    CONSTRAINT assign_FK FOREIGN KEY(emp_no) REFERENCES employee(emp_no),
                    CONSTRAINT assign_FK1 FOREIGN KEY(pro_no) REFERENCES project(pro_no));
desc assign;

--ppt 107
CREATE TABLE emp01(
        empno number(4),
        ename varchar2(14),
        sal number(7,3));
        
--���� ���̺��� ���� ����
desc emp01;

--���̺� �����ϱ�(�߰�-add, ����-modify, ����-drop column)
--���̺��� �÷��� �߰��ϱ�

alter table emp01
    add (birth date);
    
ALTER TABLE emp01
    ADD(memo varchar2(100));
    
--���̺� �÷� �����ϱ�
ALTER TABLE emp01
    MODIFY(ename varchar2(30));
DESC emp01;

--memo�� 50���� �����ϱ�
ALTER TABLE emp01
    modify(memo varchar2(50));
desc emp01;

--sal number(5)�� �����ϱ�
ALTER TABLE emp01
    MODIFY(sal number(5));
desc emp01;

--���̺��� �÷��� �����ϱ�
ALTER TABLE emp01
    DROP COLUMN memo;

ALTER TABLE emp01
    DROP COLUMN birth;

ALTER TABLE emp01
    SET UNUSED (empno);
desc emp01;
ALTER TABLE emp01
    DROP UNUSED COLUMNS;

--���̺���� RENAME
RENAME emp01 TO emp02;

desc emp02;

--���̺� �����
drop table emp02;

INSERT INTO emp02(ename,sal) VALUES('ȫ�浿',100);
INSERT INTO emp02(ename,sal) VALUES('ȫ�浿2',200);

SELECT * FROM emp02;

--���̺��� �ڷ�(���ڵ�) �����
TRUNCATE TABLE emp02;
desc emp02;

--������ ��ųʸ�
SELECT table_name from USER_TABLES;

SELECT owner,table_name from ALL_tables;
--����Ŭ �����ͺ��̽��� ��� ���̺��� ������ �� �� �ִ�.
select * from all_tables;

--1. ���� ǥ�� ��õ� ��� dept_mission���̺��� �����ϱ�
CREATE TABLE dept_mission(DNO number(2),
                        DNAME varchar2(14),
                        LOC varchar2(13));
desc dept_mission;
--2. ���� ǥ�� ��õ� ��� emp_mission ���̺��� �����ϱ�
CREATE TABLE emp_mission(ENO number(4),
                        ENAME varchar2(10),
                        DNO number(2));
desc emp_mission;
--3. �� �̸��� ������ �� �ֵ��� emp_mission ���̺��� �����Ͻÿ�
ALTER TABLE emp_mission
    modify(ENAME varchar(50));
--4. emp_mission ���̺��� ����(����)�Ͻÿ�
DROP TABLE emp_mission;
desc emp_mission;
--5. dept_mission ���̺��� DNAME �÷��� �����Ͻÿ�
ALTER TABLE dept_mission
    DROP COLUMN DNAME;
desc dept_mission;
--6. dept_mission���̺��� LOC�÷��� UNUSED�� ǥ���Ͻÿ�
ALTER TABLE dept_mission
    SET UNUSED (LOC);
desc dept_mission;
--7. dept_mission ���̺��� UNUSED�÷��� �����Ͻÿ�
ALTER TABLE dept_mission
    DROP UNUSED COLUMNS;
--8. dept_mission�� depatrment�� �̸����� �����Ͻÿ�
RENAME dept_mission to department;
desc department;