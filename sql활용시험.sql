select * from emp;
--1��
select max(sal+nvl(comm,0)) "MAX",min(sal+nvl(comm,0))"MIN", 
    round(avg(sal+nvl(comm,0)),1)"AVG"from emp;

--2��
insert into emp(empno,deptno,ename,sal) values(1000,10,'�̰���',3000);
insert into emp(empno,deptno,ename,sal) values(2000,10,'�ֺ���',4000);

--3��
update emp set sal=sal+sal*0.1;

--4��
commit;     --��� �۾����� ����ó���ϰڴٴ� Ȯ�� ��ɾ�
rollback;   --Ʈ����� ó�� �������� �߻��� ������� ��� ��ɾ�

--5��
--������ ���Ἲ ���������̶� ���̺� �������� �ڷᰡ �ԷµǴ� ���� �����ϱ� ���ؼ� ���̺��� ������ �� �� �÷��� ���ؼ� �����ϴ� ���� ���� ��Ģ
--NOT NULL : NULL ������� �ʴ´�.
--UNIQUE : �ߺ��� ���� ������� �ʴ´�.
--PRIMARY KEY : NULL�� ������� �ʰ� �ߺ��� ���� ������� �ʴ´�.
--FOREUGN KEY : �����Ǵ� ���̺��� �÷��� ���� �����ϸ� ����Ѵ�.
--CHECK : ���� ������ ������ ���� ������ ������ �����Ͽ� ������ ���� ���

--6��
create table dept(
    deptno number(4) primary key,
    dname varchar2(10) not null,
    tel varchar2(20)
    ); 
    
create table student(
    stuno number(4) primary key,
    profno number(4),
    deptno number(4),
    classno number(4),
    stuname varchar2(10) not null,
    resinum varchar2(20),
    grade number(2),
    addr varchar2(50),
    tel varchar2(20),
    email varchar2(20),
    picture varchar2(50),
    constraint student_prono_fk references prof(profno),
    constraint student_deptno_fk references dept(deptno),
    constraint student_classno_fk references class(classno));

create table prof(
    profno number(4) primary key,
    deptno number(4),
    classno number(4),
    resinum varchar2(20),
    addr varchar2(50),
    profname varchar2(10) not null,
    tel varchar2(20),
    email varchar2(20),
    picture varchar2(50),
    constraint prof_deptno_fk references dept(deptno),
    constraint prof_classno_fk references class(classno));

--7��
select * from emp;
select * from dept;
select ename, sal from emp where deptno=(select deptno from dept where dname = '������');

--8��
select e.ename, e.hiredate from emp e,dept d where e.deptno = d.deptno and d.dname = '�渮��';

--9��
select e.ename, e.sal from emp e, dept d where e.deptno = d.deptno and d.loc = '��õ';

--10��
create sequence deptno_seq
increment by 500
start with 2000
minvalue 2000
maxvalue 5000
cycle
cache 6;

select deptno_seq.nextval from dual;

--11��
--Equi Join : ���� Į���� �������� ����
select * from emp, dept where emp.deptno = dept.deptno;
--Non-Equi Join : ���� Į���� ���� �ٸ� ������ ����Ͽ� ����
select e.ename, e.sal, s.grade from emp e, salgrade s where sal >= losal and sal <= hisal;
--Outer Join : ���� ���ǿ� �������� �ʴ� �൵ ��Ÿ��
select * from emp full outer join dept on emp.deptno = dept.deptno;
select * from emp left outer join dept on emp.deptno = dept.deptno;
select * from emp right outer join dept on emp.deptno = dept.deptno;
--Self Join : �� ���̺� ������ �����մϴ�.
select empno,ename, mgr from emp;
select e1.ename as "����̸�",e2.ename as "�Ŵ��� �̸�" from emp e1, emp e2 where e1.mgr = e2.empno;


