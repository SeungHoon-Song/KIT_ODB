CREATE TABLE emp08
as 
select * from emp where deptno = 100;

create table dept02
as 
select * from dept where loc='a';

desc dept02;
--������ ����
insert into dept02 values(50,'���Ⱥ�','����');
insert into dept02 select * from dept;
select * from dept02;

alter table dept02
    add memo varchar2(10);
desc dept02;

insert into dept02 select * from dept;  --���� �ٸ��� ����

create table dept03(
    deptno01 number(2),
    dname1 varchar2(14),
    locl varchar2(13));
--�ΰ� ���̺��� ������ ������ �÷����� �ٸ��� ���Եȴ�.
insert into dept03 select * from dept;
select * from dept03;

--�ΰ� ���̺��� ������ �ٸ��� 1. ������ dept04  2. ������ dept05
create table dept04(
    deptno number(1),
    dname varchar2(10));
insert into dept04 select * from dept;
select * from dept04;

create table dept05(
    deptno number(3),
    dname varchar2(15),
    loc varchar2(14),
    sal number(15));
insert into dept05 select * from dept;
select * from dept05;

--�ΰ� ���̺��� ���� ����(loc, dname, deptno)�� �ٸ��� �÷��� ������ ������
create table dept06(
    loc varchar2(13),
    dname varchar2(14),
    deptno number(2));
insert into dept06 select * from dept;  --(X)
insert into dept06 select loc,dname,deptno from dept;   --(O)
select * from dept06;

drop table dept03;
create table dept03
as
select * from dept;

select * from dept03;
--�� 20�� �μ��� �������� 40�� �μ��� ���������� �ٲٽÿ� (20�� �μ� ��õ --> ����)
update dept03 set loc = '����' where deptno=20;

update dept03 set loc = (select loc from dept03 where deptno=40) where deptno=20;
rollback;

select * from dept03 where deptno=20;
select loc from dept03 where deptno=40;

select * from emp02;
select * from dept;
--�� ������̺��� '������'�� ��� �����ϱ�
select deptno from dept where dname = '������';

delete from emp02 where deptno = (select deptno from dept where dname = '������');



-- �μ� ���̺� �����ϱ�
DROP TABLE EMP;
-- ��� ���̺� �����ϱ�
DROP TABLE DEPT;
-- �޿� ���̺� �����ϱ�
DROP TABLE SALGRADE;
-- �μ� ���̺� �����ϱ�
DROP TABLE EMPLOYEE;
-- ��� ���̺� �����ϱ�
DROP TABLE DEPARTMENT;
-- �޿� ���̺� �����ϱ�
DROP TABLE SALGRADE;



-- �μ� ���̺� �����ϱ�
CREATE TABLE DEPT(
DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
DNAME VARCHAR2(14),
LOC VARCHAR2(13) ) ;

desc dept;

-- ��� ���̺� �����ϱ�
CREATE TABLE EMP_1( 
EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
MGR NUMBER(4),
HIREDATE DATE,
SAL NUMBER(7,2),
COMM NUMBER(7,2),
DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT);

-- �޿� ���̺� �����ϱ�
CREATE TABLE SALGRADE_1(
GRADE NUMBER,
LOSAL NUMBER,
HISAL NUMBER );

-- ��� ���̺� ���� ������ �߰��ϱ�
INSERT INTO DEPT VALUES(10, '�渮��', '����');
INSERT INTO DEPT VALUES(20, '�λ��', '��õ');
INSERT INTO DEPT VALUES(30, '������', '����'); 
INSERT INTO DEPT VALUES(40, '�����', '����');

-- �μ� ���̺� ���� ������ �߰��ϱ�
INSERT INTO EMP_1 VALUES(1001, '����', '���', 1013, to_date('2007-03-01','yyyy-mm-dd'), 300, NULL, 20);
INSERT INTO EMP_1 VALUES(1002, '�ѿ���', '�븮', 1005, to_date('2007-04-02','yyyy-mm-dd'), 250, 80, 30);
INSERT INTO EMP_1 VALUES(1003, '����ȣ', '����', 1005, to_date('2005-02-10','yyyy-mm-dd'), 500, 100, 30);
INSERT INTO EMP_1 VALUES(1004, '�̺���', '����', 1008, to_date('2003-09-02','yyyy-mm-dd'), 600, NULL, 20);
INSERT INTO EMP_1 VALUES(1005, '�ŵ���', '����', 1005, to_date('2005-04-07','yyyy-mm-dd'), 450, 200, 30);
INSERT INTO EMP_1 VALUES(1006, '�嵿��', '����', 1008, to_date('2003-10-09','yyyy-mm-dd'), 480, NULL, 30);
INSERT INTO EMP_1 VALUES(1007, '�̹���', '����', 1008, to_date('2004-01-08','yyyy-mm-dd'), 520, NULL, 10);
INSERT INTO EMP_1 VALUES(1008, '���켺', '����', 1003, to_date('2004-03-08','yyyy-mm-dd'), 500, 0, 30);
INSERT INTO EMP_1 VALUES(1009, '�ȼ���', '����', NULL, to_date('1996-10-04','yyyy-mm-dd'),1000, NULL, 20);
INSERT INTO EMP_1 VALUES(1010, '�̺���', '����', 1003, to_date('2005-04-07','yyyy-mm-dd'), 500, NULL, 10);
INSERT INTO EMP_1 VALUES(1011, '�����', '���', 1007, to_date('2007-03-01','yyyy-mm-dd'), 280, NULL, 30);
INSERT INTO EMP_1 VALUES(1012, '������', '���', 1006, to_date('2007-08-09','yyyy-mm-dd'), 300, NULL, 20);
INSERT INTO EMP_1 VALUES(1013, '������', '����', 1003, to_date('2002-10-09','yyyy-mm-dd'), 560, NULL, 20);
INSERT INTO EMP_1 VALUES(1014, '���μ�', '���', 1006, to_date('2007-11-09','yyyy-mm-dd'), 250, NULL, 10);

?

-- �޿� ���̺� ���� ������ �߰��ϱ�
INSERT INTO SALGRADE_1 VALUES (1, 700,1200);
INSERT INTO SALGRADE_1 VALUES (2, 1201,1400);
INSERT INTO SALGRADE_1 VALUES (3, 1401,2000);
INSERT INTO SALGRADE_1 VALUES (4, 2001,3000);
INSERT INTO SALGRADE_1 VALUES (5, 3001,9999);
COMMIT;

select * from emp_1;
select * from dept;
--2. �渮�ο��� �ٹ��ϴ� ����� �̸��� �Ի����� ����ϱ�
select ename, hiredate from emp_1, dept where emp_1.deptno = dept.deptno and dname = '�渮��';
--3. ANSI JOIN�� ����Ͽ� ��õ���� �ٹ��ϴ� ����̸��� �޿��� ����ϱ�
select e.ename, e.sal from emp_1 e inner join dept d on e.deptno = d.deptno and d.loc = '��õ';
--4. ��� ���̺�� �μ� ���̺��� �����Ͽ� ����̸��� �μ���ȣ, �μ����� ����Ͻÿ�
select e.ename, d.deptno, d.dname from emp_1 e inner join dept d on e.deptno = d.deptno;
--5. �渮�� �μ� �Ҽ� ����� �̸��� �Ի����� ����Ͻÿ�
select ename, hiredate from emp_1, dept where emp_1.deptno = dept.deptno and dname = '�渮��';
--6. ������ ������ ����� �̸�, �μ����� ����Ͻÿ�
select e.ename, d.dname from emp_1 e, dept d where e.deptno = d.deptno and e.job='����';
--7. ���ӻ���� ���켺�� ������� �̸��� ������ ����Ͻÿ�
select work.ename, work.job, manager.ename from emp_1 work, emp_1 manager where work.mgr = manager.empno and manager.ename='���켺';
--8. ���켺�� ������ �ٹ������� �ٹ��ϴ� ����� �̸��� ����Ͻÿ�
select work.ename, friend.ename from emp_1 work, emp_1 friend where work.deptno = friend.deptno and work.ename='���켺' and friend.ename <> '���켺';





select * from student;
select * from department;
select * from professor;
select * from emp2;
select * from dept2;
--1. Student ���̺�� department���̺��� ����Ͽ� 'Anthony  Hopkins'�л��� ����(deptno1)�� ������ �л����� �̸��� ����1 �̸��� ����Ͻÿ�
SELECT s.name "STUD_NAME" , d.dname "DEPT_NAME" FROM student s , department d
WHERE s.deptno1=d.deptno and s.deptno1 = ( SELECT deptno1 FROM student WHERE name='Anthony Hopkins') ;
--2. professor���̺�� department���̺��� ��ȸ�Ͽ� 'Meg Ryan'�������� ���߿� �Ի��� ����� �̸��� �Ի��� �а����� ����ϼ���
select p.name, p.hiredate, d.dname from professor p, department d where p.deptno = d.deptno and hiredate > (select hiredate from professor where name = 'Meg Ryan');
--3. student ���̺��� ����1�� 201���� �а��� ��� �����Ժ��� �����԰� ���� �л����� �̸��� �����Ը� ����ϼ���
select name, weight from student where weight > (select avg(weight) from student where deptno1=201);
--4. emp2���̺��� ����Ͽ� ��ü ���� �� 'Section Head'������ �ּ� �����ں��� ������ ���� ����� �̸��� ���� ������ ����Ͻÿ�.
--�� ���� ��� ������ õ���� ���б�ȣ�� $ǥ�ø� �ϼ���.
select name, position, to_char(pay, '$999,999,999') as "����" from emp2
    where pay > any (select pay from emp2 where position = 'Section head');
select name, position, to_char(pay, '$999,999,999') as "����" from emp2
    where pay > (select min(pay) from emp2 where position = 'Section head');
--5. student���̺��� ��ȸ�Ͽ� ��ü �л� �߿��� ü���� 2�г� ü�߿��� ���� ���� ������ �л����� �����԰� ���� �л��� �̸��� �г�� �����Ը� ����ϼ���.
select name, weight from student where weight < (select min(weight) from student where grade=2);
--6. emp2���̺�� dept2���̺��� ��ȸ�Ͽ� �� �μ��� ��� ������ ���ϰ� ���߿��� ��� ������ ���� ���� �μ��� ��� �������� ���� �޴� �������� �μ���, ������, ������ ����ϼ���.
select d.dname, e.name, to_char(pay,'$999,999,999') from emp2 e, dept2 d
    where e.deptno = d.dcode and e.pay < all (select avg(pay) from emp2 group by deptno);
--7. professor���̺�� department���̺��� ��ȸ�Ͽ� �� �а����� �Ի����� ���� ������ ������ ������ȣ�� �̸�, �а����� ����ϼ���.(�Ի��� ������ �������� �����ϼ���)
select p.profno, p.name, p.hiredate, d.dname from professor p, department d 
    where p.deptno=d.deptno and (p.deptno,p.hiredate) in (select deptno, min(hiredate) from professor group by deptno)
    order by p.hiredate;
--8. emp2 ���̺��� ��ȸ�Ͽ� ���޺��� �ش� ���޿��� �ִ� ������ �޴� ������ �̸��� ����, ������ ����ϼ���. ���������� �������� �����ϼ���.
select name,position, to_char(pay,'$999,999,999') from emp2
    where (position, pay) in (select position, max(pay) from emp2 group by position);




--�������� ����
--1. ���� ������ �̿��Ͽ� "������"���� �ٹ��ϴ� ��� ����� �̸��� �޿��� ����϶�
select ename, sal from emp_1
    where deptno = (select deptno from dept where dname = '������');
--2. ���������� ����Ͽ� emp06�� emp���̺��� ��� �����͸� �߰��մϴ�.
create table emp06
as select * from emp_1;
--3. emp06 ���̺� ����� ��� ���� �� ������� �ּ� �޿����� ���� �޿��� �޴� ������� �̸��� �޿��� ������ ����ϵ� ������ ������� �ʰ�
select ename, sal from emp_1
    where sal > any (select sal from emp_1 where job = '����') and job <> '����';
--4. emp06 ���̺� ����� ��� ���� �� ��õ�� ��ġ�� �μ��� �Ҽӵ� ������� �޿��� 100�λ��ϴ� SQL���� �ۼ��Ͻÿ�
select * from emp06 where deptno=20;
update emp06 set sal = sal+100 where deptno in (select deptno from dept where loc='��õ');
--5. emp06���̺��� �渮�ο� �Ҽӵ� ����鸸 �����ϴ� SQL���� �ۼ��Ͻÿ�
delete from emp06 where deptno = (select deptno from dept where dname='�渮��');
--6. '�̹���'�� ���� �μ��� �ٹ��ϴ� ����� �̸��� �μ���ȣ�� ����ϴ� SQL���� �ۼ��Ͻÿ�.
select ename, deptno from emp_1 where deptno = (select deptno from emp_1 where ename = '�̹���') and ename <> '�̹���';
--7. '�̹���'�� ������ ������ ���� ����� ����ϴ� SQL���� �ϼ��Ͻÿ�.
select * from emp_1 where job = (select job from emp_1 where ename = '�̹���');
--8. '�̹���'�� �޿��� �����ϰų� �� ���� �޴� ������ �޿��� ����ϴ� SQL���� �ϼ��Ͻÿ�
select ename, sal from emp_1 where sal >= (select sal from emp_1 where ename='�̹���');
--9. '��õ'���� �ٹ��ϴ� ����� �̸�, �μ���ȣ�� ����ϴ� SQL���� �ϼ��Ͻÿ�
select ename, deptno from emp_1 where deptno = (select deptno from dept where loc = '��õ');
--10. ���ӻ���� ���켺�� ����� �̸��� �޿��� ����ϴ� SQL���� �ϼ��Ͻÿ�
select ename, sal, mgr from emp_1 where mgr = (select empno from emp_1 where ename = '���켺');
--11. �μ����� ���� �޿��� ���� �޴� ����� ���� (�����ȣ, ����̸�, �޿�, �μ���ȣ)�� ����ϴ� SQL���� �ϼ��Ͻÿ�.
select empno, ename, sal, deptno from emp_1 e where sal = (select max(sal) from emp_1 where deptno = e.deptno)
    order by deptno;
--12. ����(JOB)�� ������ ����� ���� �μ��� �μ���ȣ�� �μ���, ������ ����Ͻÿ�
select * from dept where deptno in (select deptno from emp_1 where job='����');
--13. ���庸�� �޿��� ���� ���� ������� �̸��� �޿��� ������ ����ϵ� ������ ������� �ʴ� SQL���� �ϼ��Ͻÿ�.
select ename, sal, job from emp_1 where sal > all (select sal from emp_1 where job = '����');
