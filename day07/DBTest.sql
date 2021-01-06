drop table emp01;
--�÷����� ����� ��������
CREATE TABLE emp01 (
    empno number(4) primary key,
    ename varchar2(10) not null,
    job varchar2(9) unique,
    deptno number(2) references dept(deptno));
    
--���̺� ���� ����� ��������
drop table emp02;
CREATE table emp02 (
    empno number(4),
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2),
    primary key(empno),
    unique(job),
    foreign key(deptno) references dept(deptno));

--����Ű     
drop table member01;
CREATE TABLE member01(
    name varchar2(10),
    address varchar2(30),
    phone varchar2(16),
    CONSTRAINT member01_name_phone_pk PRIMARY KEY(name, phone));
    
desc member01;
--�Է��ϱ� ����
INSERT INTO member01 VALUES ('a','seoul','123');
INSERT INTO member01 VALUES ('b','seoul','123');
INSERT INTO member01 VALUES ('a','seoul','1234');
--����Ű �������ǿ� ���� ����
INSERT INTO member01 VALUES ('a','seoul','123');

CREATE TABLE member02(
    name varchar2(10),
    address varchar2(30),
    phone varchar2(16),
    CONSTRAINT member02_name_phone_pk PRIMARY KEY (name,address,phone));
    
--���� �Է��ϱ�
INSERT INTO member02 VALUES('a','seoul','123');
INSERT INTO member02 VALUES('al','seoul','123');

drop table emp01;

create table emp01(
    empno number(4),
    ename varchar2(10),
    job varchar2(9),
    deptno number(2));
    
--���� ���� �˻��ϱ�
SELECT * from user_constraints where table_name in('EMP01');

--���� ������ �߰��ϱ�
ALTER TABLE emp01
 ADD CONSTRAINT emp01_empno_pk Primary key(empno);
 
--�ܷ�Ű�� �߰� deptno
ALTER TABLE emp01
 ADD CONSTRAINT emp01_deptno_fk FOREIGN KEY(deptno) REFERENCES DEPT(deptno);

--NOT NULL�� Modify�� �����ϱ�
ALTER TABLE emp01
    MODIFY ename CONSTRAINT emp01_ename_nn not null;

--���� ���� ����
ALTER TABLE emp01
    DROP CONSTRAINT emp01_ename_nn;
    
ALTER TABLE emp01
    DROP CONSTRAINT emp01_deptno_fk;

ALTER TABLE emp01
    DROP CONSTRAINT emp01_empno_pk;

ALTER TABLE emp01
    DROP primary key;

SELECT * from dept;
SELECT * from emp;
--emp���̺��� �ܷ�Ű�ν� ������ �� ����.
DELETE FROM dept WHERE deptno=10;
--�����Ϸ��� 1) emp���̺��� �ܷ�Ű ������ ����, 2) ��Ȱ��ȭ
SELECT * from user_CONSTRAINTS WHERE table_name in ('EMP');

drop table dept01;
CREATE TABLE dept01(
    deptno number(2) constraint dept01_deptno_pk primary key,
    dname varchar2(14),
    loc varchar2(13));

insert into dept01 values (10,'�渮��','����');
insert into dept01 values (20,'�λ��','��õ');

select * from dept01;

drop table emp01;
create table emp01(
    empno number(4),
    ename varchar2(10) constraint emp01_ename_nn not null,
    job varchar2(9),
    deptno number(2),
    constraint emp01_empno_pk primary key(empno),
    constraint emp01_job_uk unique(job),
    constraint emp01_deptno_fk foreign key(deptno) references dept01(deptno));
    
insert into emp01 values(1000,'����','���',10);
select * from emp01;
--dpetno �����ȵ� ��? �ܷ�Ű �����̱� ����
delete from dept01 where deptno=10;

--��Ȱ���ϱ�
--�ܷ�Ű ������ ���̺��� ��Ȱ��ȭ����
ALTER TABLE emp01
    disable CONSTRAINT emp01_deptno_fk;
--dpetno ������
delete from dept01 where deptno=10;

select * from dept01;

--Ȱ��ȭ�ϱ�
--�ܷ�Ű ������ ���̺��� Ȱ��ȭ����
--���� �߻�: emp01�ȿ� �������߿��� deptno 10������
ALTER TABLE emp01
    ENABLE CONSTRAINT emp01_deptno_fk;
    
select * from emp01;
select * from dept01;

insert into dept01 values (10,'�渮��','����');

--�ܷ�Ű ���谡 Ȱ��ȭ �Ǿ� �ֱ� ������ ������ �ȵ�
delete from dept01 where deptno=10;

--�θ����̺��� �⺻Ű ���� ������ ��Ȱ��ȭ ��Ű��
--���� �߻� : �ڽ� ���̺��� �ܷ�Ű�� ���̱� ������ ��Ȱ��ȭ �� �� ����.
ALTER TABLE dept01
    disable primary key;
--cascade�� ����Ͽ��� �ڽ� ���̺� ��Ȱ��ȭ
alter table dept01
    disable primary key cascade;

select * from user_constraints where table_name in ('DEPT01','EMP01');
--Ȱ��ȭ ���� ���� �θ��� �⺻Ű
alter table dept01
    enable primary key;
   
--���� �߻� : �μ����̺��� �⺻Ű�� ������̺��� �ܷ�Ű���� �����ϱ� ������ ���������� ������ �� ����.
alter table dept01
    drop primary key;
--�ذ� ���
--dept01 ���̺��� �⺻Ű �������� ����, emp01 ���̺��� �ܷ�Ű �������ǵ� ��� ������
alter table dept01
    drop primary key cascade;
select * from user_constraints where table_name in ('DEPT01','EMP01');

--1) ���� ���̺� employee ���̺�
CREATE TABLE  employee01(
    emp_no number(4),
    emp_name varchar2(20),
    salary  number(6),
    birthday  date);
--2) ������Ʈ ���̺� project���̺�
CREATE TABLE  project01(
     pro_no number(4),
     pro_content varchar2(100),
     start_date  date,
     finish_date date);
--3) Ư��(specialty)  ���̺��� ����
CREATE TABLE  specialty01(
     emp_no number(4),
     specialty   varchar2(20));
--4) ��� ���̺� assign
CREATE TABLE assign01(
   emp_no   number(4),
   pro_no    number(4));
--5)  ���� ó�� ���̺��� �������� �Ʒ� ǥ�� ���� ������ �߰��մϴ�.
--���� ���̺� �⺻Ű �߰�
ALTER TABLE employee01
 ADD CONSTRAINT employee01_emp_no_pk PRIMARY KEY(emp_no);
--������Ʈ ���̺� �⺻Ű �߰�
ALTER TABLE project01
 ADD CONSTRAINT project01_pro_no_pk PRIMARY KEY(pro_no);
--Ư�� ���̺� �⺻Ű �߰�
ALTER TABLE specialty01
 ADD CONSTRAINT specialty01_empnospecialty_pk PRIMARY KEY(emp_no,specialty);
--Ư�� ���̺� �ܷ�Ű �߰�
ALTER TABLE specialty01
 ADD CONSTRAINT specialty01_emp_no_fk FOREIGN KEY(emp_no) REFERENCES employee01(emp_no);
--��� ���̺� �⺻Ű �߰�
ALTER TABLE assign01
 ADD CONSTRAINT assign01_emp_no_pro_no_pk PRIMARY KEY(emp_no,pro_no);
--��� ���̺� �ܷ�Ű �߰�
ALTER TABLE assign01
 ADD CONSTRAINT assign01_emp_no_fk FOREIGN KEY(emp_no) REFERENCES employee01(emp_no);
--��� ���̺� �ܷ�Ű �߰�
ALTER TABLE assign01
 ADD CONSTRAINT assign01_pro_no_fk FOREIGN KEY(pro_no) REFERENCES project01(pro_no);

select * from user_constraints where table_name in('EMPLOYEE01','PROJECT01','SPECIALTY01','ASSIGN01');

select * from emp;  --21��
select * from dept; --4��

select * from emp where ename = '�̹���';
select * from dept where deptno = 10;

--Cross join : ��ü ���� ���ڵ� ��  = ���̺� ���ڵ�� X ���̺�2 ���ڵ��
select emp.empno,ename,emp.deptno,dname from emp, dept where ename='����';

--Equi join : ���� ���� ����ϴ� ���� ���
select empno, ename, emp.deptno, dept.deptno dname from emp, dept where emp.deptno = dept.deptno;
--���� ����
--from emp, dept --> WHERE emp.deptno = dept.deptno --> empno, ename, emp.deptno, dept.deptno dname

--�̹����� �̸��� �Ҽ� �μ� ����ϱ�
--��� ���� �̹��� �渮��
SELECT ename, dname FROM emp,dept WHERE emp.deptno = dept.deptno and ename = '�̹���';

--�÷����� ��ȣ�� �ذ� - ���̺��.�÷���
select ename, emp.deptno, dname from emp, dept where emp.deptno = dept.deptno and ename = '�̹���';

--���̺�� ��Ī ���̱� FROM ���̺��1 ��Ī, ���̺��2 ��Ī 
select e.ename, d.dname, d.deptno from emp e, dept d where e.deptno = d.deptno and e.ename = '�̹���';

--Non-Equi join
--�޿����̺�
select * from salgrade;
--�޿��� ����� �� 5������� �������� �ִ�.
select * from emp;
select ename, sal, grade from emp, salgrade where sal between losal and hisal;

insert into salgrade values(0,0,699);
delete from salgrade where grade=0;

--ename, dname, sal, grade
select ename, dname, sal, grade from emp e, dept d, salgrade s
    where e.deptno = d.deptno and e.sal between s.losal and s.hisal order by grade desc;
    
--SELF JOIN
select empno,ename, mgr from emp;
--��� ��� ENAME, MNAME ���� ������
select e1.ename as "����̸�",e2.ename as "�Ŵ��� �̸�" from emp e1, emp e2 where e1.mgr = e2.empno;
select * from emp;

--ANSI Inner join
select * from emp, dept where emp.deptno = dept.deptno;
--������
select * from emp inner join dept on emp.deptno = dept.deptno;

SELECT ename, dname FROM emp,dept WHERE emp.deptno = dept.deptno and ename = '�̹���';
--������
SELECT ename, dname FROM emp INNER JOIN dept ON emp.deptno = dept.deptno and ename = '�̹���';


select * from emp;
select * from dept;

select * from emp full outer join dept on emp.deptno = dept.deptno;
select * from emp left outer join dept on emp.deptno = dept.deptno;
select * from emp right outer join dept on emp.deptno = dept.deptno;









