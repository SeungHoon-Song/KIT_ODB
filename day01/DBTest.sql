-- �μ� ���̺� �����ϱ�
CREATE TABLE dept(  deptno number(2) CONSTRAINT PK_DEPT PRIMARY KEY,
                    dname varchar2(14), 
                    loc varchar2(13) );
-- ������̺� �����ϱ�                  
CREATE TABLE emp ( empno number(4) CONSTRAINT PK_EMP PRIMARY KEY,
                   ename varchar2(10),
                   job varchar2(9),
                   mgr number(4),
                   hiredate date,
                   sal number(7,2), 
                   comm number(7,2),
                   deptno number(2) CONSTRAINT FK_PK_DEPTNO REFERENCES PK_DEPT );
                   
-- �޿����̺� �����ϱ�
-- grade ���, losal �޿� ���Ѱ� hisal �޿����Ѱ�
CREATE TABLE salgrade(  grade number, losal number, hisal number);

-- �μ� ���̺� ���� ������ �ֱ�
INSERT INTO dept (deptno, dname, loc) VALUES (10,'�渮��','����');
INSERT INTO dept (deptno, loc, dname) VALUES (20, '��õ', '�λ��');
INSERT INTO dept VALUES (30,'������','����');
INSERT INTO dept VALUES (40,'�����','����');

-- �μ����̺�ȿ� �ִ� ���ڵ�(��)�� �˻��ϱ�
SELECT * FROM dept;

-- ��� ���̺� �ڷ� �����ϱ�
INSERT INTO emp VALUES(1001, '����', '���', 1013, TO_DATE('2007-03-01','yyyy-mm-dd'),3000,NULL,20);
INSERT INTO EMP VALUES(1002, '�ѿ���', '�븮', 1005, to_date('2007-04-02','yyyy-mm-dd'), 250,   80, 30);
INSERT INTO EMP VALUES(1003, '����ȣ', '����', 1005, to_date('2005-02-10','yyyy-mm-dd'), 500,  100, 30);
INSERT INTO EMP VALUES(1004, '�̺���', '����', 1008, to_date('2003-09-02','yyyy-mm-dd'), 600, NULL, 20);
INSERT INTO EMP VALUES(1005, '�ŵ���', '����', 1005, to_date('2005-04-07','yyyy-mm-dd'), 450,  200, 30);
INSERT INTO EMP VALUES(1006, '�嵿��', '����', 1008, to_date('2003-10-09','yyyy-mm-dd'), 480, NULL, 30);
INSERT INTO EMP VALUES(1007, '�̹���', '����', 1008, to_date('2004-01-08','yyyy-mm-dd'), 520, NULL, 10);
INSERT INTO EMP VALUES(1008, '���켺', '����', 1003, to_date('2004-03-08','yyyy-mm-dd'), 500,    0, 30);
INSERT INTO EMP VALUES(1009, '�ȼ���', '����', NULL, to_date('1996-10-04','yyyy-mm-dd'),1000, NULL, 20);
INSERT INTO EMP VALUES(1010, '�̺���', '����', 1003, to_date('2005-04-07','yyyy-mm-dd'), 500, NULL, 10);
INSERT INTO EMP VALUES(1011, '�����', '���', 1007, to_date('2007-03-01','yyyy-mm-dd'), 280, NULL, 30);
INSERT INTO EMP VALUES(1012, '������', '���', 1006, to_date('2007-08-09','yyyy-mm-dd'), 300, NULL, 20);
INSERT INTO EMP VALUES(1013, '������', '����', 1003, to_date('2002-10-09','yyyy-mm-dd'), 560, NULL, 20);
INSERT INTO EMP VALUES(1014, '���μ�', '���', 1006, to_date('2007-11-09','yyyy-mm-dd'), 250, NULL, 10);
INSERT INTO EMP VALUES(1017, '���̼�', '���', 1006, to_date('2020-12-29','yyyy-mm-dd'), 250, NULL, 10);
--comm�� null
INSERT INTO EMP VALUES(1018, '���̼�', '���', 1006, to_date('2020-12-29','yyyy-mm-dd'), 250, NULL, 10);
--��¥�� null
INSERT INTO EMP VALUES(1019, '���̼�', '���', 1006, null, 250, NULL, 10);
--���ڰ� null
INSERT INTO EMP VALUES(1020, NULL, '���', 1006, to_date('2020-12-29','yyyy-mm-dd'), 250, NULL, 10);
INSERT INTO EMP VALUES(1021, '���̼�', NULL, 1006, to_date('2020-12-29','yyyy-mm-dd'), 250, NULL, 10);

select comm, nvl(comm,0) from emp;
select hiredate, nvl(hiredate, to_date(sysdate, 'yyyy/mm/dd')) from emp;

select ename,nvl(ename,'ȫ�浿'), job, nvl(job,'���')from emp;

--nvl2 �Լ�
select ename, sal, comm, nvl2(comm, sal*12+comm, sal*12) ���� from emp;
--nullif �Լ�
select nullif('a','a'), nullif('c','b') from dual;  --������ null, �ٸ��� ù��° ��ȯ
select coalesce(NULL,'a','b','c','d') from dual;

select ename, deptno, decode(deptno,10,'�渮��',
                                    20,'�λ��',
                                    30,'������',
                                    40,'�����') dname from emp;
                                    
select ename, deptno,
    case when deptno = 10 then '�渮��'
        when deptno = 20 then '�λ��'
    end as dname
        from emp;


SELECT * FROM EMP;

INSERT INTO SALGRADE VALUES (1, 700,1200);
INSERT INTO SALGRADE VALUES (2, 1201,1400);
INSERT INTO SALGRADE VALUES (3, 1401,2000);
INSERT INTO SALGRADE VALUES (4, 2001,3000);
INSERT INTO SALGRADE VALUES (5, 3001,9999);

SELECT * FROM salgrade;

commit;

SELECT DISTINCT job as ���� FROM emp;

SELECT sal as ����, sal*0.03 as ���� FROM emp;

SELECT ename, comm, sal*12+comm as ����, NVL(comm,0),sal*12+NVL(comm,0) FROM emp;

-- || Concatentation ������ ����Ͽ��� �÷� ������ �� �ִ�. 
SELECT ename || '�� ������ ' || job || '�Դϴ�.' as ���� from emp;

-- where�� 
select * from emp;
-- ���� �˻�
select * from emp where sal>=500;

select * from emp where deptno <> 10;
-- ���� �˻�
select * from emp where ename='�ѿ���';
-- ��¥ �˻�    2005�� 1�� 1�� ������ �Ի��� ���
select * from emp where hiredate < TO_DATE ('2005/01/01','yyyy/mm/dd');
select * from emp where hiredate >= TO_DATE ('2005/01/01','yyyy/mm/dd');

-- �μ���ȣ�� 10�̰� ������ ������ ����� �̸���
select ename from emp where deptno=10 and job = '����';
select * from emp where not deptno=10 or job = '����';
-- �޿��� 400~500�� ��� and
select * from emp where sal>=400 and sal<=500;
-- �޿��� 400�̸��̰ų� 500�ʰ��� ���
select * from emp where sal<400 or sal>500;
-- �÷��� between ����1 and ����2  : �÷����� ����1�� ����2���̿� ������ ��
-- �޿��� 400~500�� ��� and
select * from emp where sal>=400 and sal<=500;
select*from emp where sal between 400 and 500;
-- in ~�ȿ�
-- comm�� 80�̰ų� 100�̰ų� 200�� ���
select * from emp where comm=80 or comm=100 or comm=200;
select * from emp where comm in(80,100,200);

-- in ~�ȿ�
-- comm�� 80�ƴϰų� 100�ƴϰų� 200 �ƴ� ���
select * from emp where comm != 80 and comm !=100 and comm !=200;
select * from emp where comm not in(80,100,200);

-- ������ġ ����ϰ� ��ġ�ϴ� �� �˻� like
-- ���ϵ� ī�� :     % : ���ڰ� ���ų� �ϳ� �̻��� � ���ڰ� �͵� �������.
--                  _ : �ϳ��� ���ڰ� � ���� �͵� �������.

select * from emp where ename like '%��%';
select * from emp where ename like '__��';

-- job���� '��'�� �����ϴ� �͸� ã��
select * from emp where job like '��%';

-- job���� '��'�� �������� �ʴ� ��� ã��
select * from emp where job not like '��%';
-- ���� �̾��� �ƴ� ��� ã��
select * from emp where ename not like '��%';

-- comm�� NULL�� ��� ã��
-- select * from emp where comm like null; (X)
select * from emp where comm is null;
-- ����߿��� �޿� �������� ����
select * from emp where job='���' order by sal;

-- �ֱٿ� �Ի��� ��� ������� ���� ������ ������
select * from emp where job !='����' order by hiredate desc;

-- ��� �̸��� �޿� �Ի����ڸ� ����ϱ�
select ename, sal ,hiredate from emp;
-- �μ���ȣ�� dno�� �μ����� dname�� '�μ���'���� ��Ī(as)�� �ٿ��� ����ϼ���(�μ����̺�)
select empno as dno, ename as �μ��� from emp;
-- ������̺� �����ϴ� ������ ������ ����� ������.
select distinct job from emp;
-- �޿��� 300������ ����� �����ȣ, ����̸�, �޿��� ����ϼ���
select empno, ename,sal from emp where sal<=300; 
-- �̸��� '����ȣ'�� ����� �����ȣ, �����, �޿��� ����ϼ���
select empno, ename, sal from emp where ename = '����ȣ';
-- �޿��� 250�̰ų� 300�̰ų� 500�� ������� �����ȣ, �����, �޿��� ���
select empno, ename, sal from emp where sal=250 or sal=300 or sal=500;
-- �޿��� 250�� 300�� 500�� �ƴ� ������� �˻��ϼ���
select * from emp where sal not in(250,300,500);
-- ����߿��� �̸��� '��'���� �����ϴ� ����� �̸��߿� '��'�� �����ϴ� ����� �����ȣ�� ����̸��� ����ϼ���
select empno,ename from emp where ename like '��%' or ename like'%��%';
-- ����ڰ� ���� ����� �˻��ϼ���
select * from emp where mgr is null;
-- ������̺��� �ڷḦ �Ի��� �������� �����Ͽ� �ֱٿ� �Ի��� ������ ���� ���� ����ϼ���(��, �����ȣ,�����,����,�Ի���) ���
select empno,ename,job,hiredate from emp order by hiredate desc;
-- �μ���ȣ�� ���� �����ȣ���� ����ϵ� ���� �μ� ���� ����� ����� ��� �Ի����� ���� ������ ������� ����ϼ���
select * from emp order by deptno asc, hiredate asc;
 
CREATE TABLE group_star(name varchar2(8));

insert into group_star values('A');
insert into group_star values('B');
insert into group_star values('C');
insert into group_star values('D');
insert into group_star values('E');
insert into group_star values('F');
insert into group_star values('G');
insert into group_star values('H');

select * from group_star;
delete from group_star where name='A';

CREATE TABLE single_star(name varchar2(8));
--'E'~'L'
insert into single_star values('E');
insert into single_star values('F');
insert into single_star values('G');
insert into single_star values('H');
insert into single_star values('I');
insert into single_star values('J');
insert into single_star values('K');
insert into single_star values('L');

-- ������
select * from group_star UNION select * from single_star;   --�ߺ� �ѹ���
select * from group_star UNION all select * from single_star;

-- ������
select * from group_star INTERSECT select * from single_star;

-- ������
select * from group_star minus select * from single_star;

-- 3�� ����Ŭ �Լ�
select 24*60 from dual; --������ �� ���̺� ������ dual
select * from dual;
select power(2,3) from dual; --2^3

select round(2.56,1) from dual; --�Ҽ��� ���ڸ����� �ݿø�

select mod(10,3) from dual; --������

select 'Welcome to Oracle', upper('Welcome to Oracle'), lower('Welcome to Oracle'),
        initcap('Welcome to Oracle') from dual;
        
select length('Welcome to Oracle') from dual;

select lengthb('Welcome to Oracle �ѱ�') from dual;  --����Ʈ��

select concat('ab') from dual;  --��ġ��

select substr('Welcome to Oracle',2,3) from dual;   --2��°���� 3�ڸ�ŭ
select substrb('Welcome to Oracle',2,3) from dual;
select substr('�ȳ��ϼ���!',2,3) from dual;
select substrb('�����ٶ󸶹�',7,6) from dual;    --�ѱ��� 3����Ʈ

select instr('�����ͺ��̽�','��',4,1) from dual; --instr�� �ѱ��ѱ���1����Ʈ / ���,ã�±���,������ġ,���° 
select instrb('�����ͺ��̽���','��',4,2) from dual;

-- ��¥�� <-> ������
select sysdate, to_char(sysdate,'yyyy-mm-dd, AM HH:MI:SS') from dual;   --sysdate ���糯¥
select to_date('2020/12/29','yyyy-mm-dd') from dual;

-- ������ <-> ������
select to_char(1234567890100,'L999,999,999.00') from dual;
select to_number('542') - to_number('500') from dual;
select to_char(542) from dual;

-- ��¥
select to_char(sysdate,'yyyy-mm-dd') from dual;
select to_char(hiredate, 'yyyy/mm/dd') as �Ի���1,
    to_char(trunc(hiredate, 'MONTH'),'yyyy/mm/dd') �Ի���2,
    to_char(round(hiredate, 'MONTH'), 'yyyy/mm/dd') �Ի���3,
    to_char(round(hiredate, 'D'), 'yyyy/mm/dd') �Ի���4
    from emp;

select ename, sysdate ����, to_char(hiredate,'yyyy/mm/dd') �Ի���,
        trunc(Months_between(sysdate, hiredate)) �ٹ��ϼ� from emp;
        
select ename, hiredate,to_char(add_months(hiredate,6), 'yyyy/mm/dd') �Ի�6������ from emp;

select to_char(sysdate, 'yyyy/mm/dd') ����,
        to_char(next_day(sysdate, 2),'yyyy/mm/dd') �Ͽ���  --�ý��� �������ĵ��� Wendesday ����
        from dual;

select ename, to_char(hiredate,'yyyy/mm/dd') �Ի���,
        to_char(last_day(hiredate),'yyyy/mm/dd') ��������¥
        from emp;
        
select * from emp;
--9���� �Ի��� ����� ����� ������ (SUBSTR)�Լ��� ����Ѵ�.
select * from emp where substr(hiredate,4,2)=09;
--2003�⵵�� �Ի��� ����� �˾Ƴ��� ���� �������� ������ ���� �ۼ��� �� �ֽ��ϴ�
select * from emp where substr(hiredate,1,2)=03;
-- ������ �̸��� '��'�� ������ ����� �˻��� ������ �սô�.
select * from emp where substr(ename,length(ename)) = '��';
-- �̹����� �̸��� �ι�° ���ڿ� '��'�� �ִ� ����� �˻��� ������
select * from emp where substr(ename,2,1)='��';

-- ���޿� ���� �޿��� �λ��ϵ��� �սô�. ������ '����'�� ����� 5%, '����'�� ����� 10%, 
--'�븮'�� ����� 13%, '���'�� ����� 20%�λ��մϴ�.
select ename, job, sal,decode(job,'����',sal+sal*0.05,
                            '����',sal+sal*0.1,
                            '�븮',sal+sal*0.13,
                            '���',sal+sal*0.2,
                            '����',sal) �λ�޿� from emp;
--�Ի��� ������ 2�ڸ�(YY), ���� ����(MON)���� ǥ���ϰ�, ������ ���(DY)�� �����Ͽ� ����Ͻÿ�.
select ename,to_char(hiredate,'yy')�Ի��Ͽ���,
                to_char(hiredate,'mm')�Ի��,
                to_char(hiredate,'dy')���� from emp;
select hiredate, to_char(hiredate, 'yy/mon/dd dy') from emp;

select sal, round(sal,-2) from emp;

--round(����, �ݿø��Ͽ� ������ �ڸ���) round(sal,3) 12300.7876 -round(sal,3)-> 12300.788
select round(12300.7876,-3) from dual;

--�׷��Լ�  count�� null�� �����ϰ� 
select count(job) from emp;
--select ename, max(sal) from emp;(X)   �μ����Ǿ ����Ͽ��� ����
select * from emp;

--�κ���
select deptno,sum(sal) from emp group by deptno;
select deptno,sum(sal) from emp where job='���' group by deptno;
-- 2000~2003���� �Ի��� ���
select job,sum(sal) from emp where substr (hiredate,1,2) in('00','01','02','03') group by job;

select deptno, avg(sal),max(sal),min(sal) from emp 
    where job='����'
    group by deptno 
    having avg(sal) >= 400  --having�� group by�� ���� ����
    order by deptno;


--��� ����� �޿��ְ��, ������, �Ѿ� �� ��� �޿��� ����Ͻÿ�. ��տ� ���ؼ��� ������ �ݿø��Ͻÿ�
select max(sal) Maximum,min(sal) Minimum,sum(sal) Sum,round(avg(sal)) Average from emp;
--count(*)�Լ��� �̿��Ͽ� ��� ������ ������� ����Ͻÿ�
select job,count(*) from emp group by job order by job asc; --count(*)�� ������ �÷�
--���� ���� �����Ͻÿ�
select count(*) from emp where job = '����';
--�޿� �ְ��, �޿� �������� ������ ����Ͻÿ�.
select max(sal),min(sal), max(sal)-min(sal)as ���� from emp;
--���޺� ����� ���� �޿��� ����Ͻÿ�. ���� �޿��� 500�̸��� �׷��� ���ܽ�Ű��, ����� �޿��� ���� ������������ �����Ͽ� ����Ͻÿ�
select job,min(sal) from emp group by job having min(sal)>=500 order by min(sal) desc;
--�� �μ��� ���� �μ���ȣ, �����, �μ����� ��� ��� ��� �޿��� ����Ͻÿ�. ��� �޿��� �Ҽ��� ��°�ڸ��� �ݿø��Ͻÿ�
select deptno,count(*),round(avg(sal),1) from emp group by deptno order by deptno;
--�� �μ��� ���� �μ���ȣ �̸�, ������, �����, �μ� ���� ��� ����� ��� �޿��� ����Ͻÿ�.
--��� �޿��� ������ �Ҽ��� ��° �ڸ��� �ݿø��Ͻÿ�.
select deptno,decode(deptno,10,'�渮��',
                     20,'�λ��',
                     30,'������',
                     40,'�����')as dname,
        decode(deptno,10,'����',
                      20,'��õ',
                      30,'����',
                      40,'����')as ����,
                count(*),round(avg(sal),1) from emp group by deptno order by deptno;












