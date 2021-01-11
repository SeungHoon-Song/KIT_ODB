create table emp_copy
as
SELECT * from emp;

select * from emp_copy; --������ ���̺�

create view emp_view30
as
--dptno 30�� ����� ���, �̸�, �μ���ȣ�� �˻�
select empno, ename, deptno from emp where deptno=30;
select * from emp_view30;

select * from course;
select * from course where cou_id=20;

create view course_view_20(cou_id, cou_name)
as
select cou_id, cou_name from course where cou_id=20;

select * from course_view_20;

desc user_views;

select view_name, text from user_views;

--���� ���ۼ���
--1. ��� ���� ����
select * from course_view_20;
--2. ���� text�÷��ȿ� �ڷ��� select���� �����մϴ�.
--3. �������� ������ ��ȸ
--4. �������� ������ ��ȸ
--5. 1���� ����� ������

--�並 ����ϴ� ����
--1. �� ������, ���� ���� �������� ��� �����
--2. ���ȿ� ����

--�並 ����� ���
--1. select��
--2. insert������ ��ȿ� ������ �߰�
select * from emp_view30;
insert into emp_view30 values(2222,'bbbb',30);  --��ȿ� ������ �ֱ�
--������ �����ʹ�? �߰� �Ǿ���.
select * from emp;
--view�� ������ �����ϱ� aaaa�� ����� deptno 40���� ����
update emp_view30 set ename='cccc' where empno = '2222';
--view���̺��� �̿��Ͽ� ������ ���� aaaa�� ��� �����ϱ�
delete from emp_view30 where empno = '2222';
delete from emp_view30 where empno = '1002';
commit;

create view emp_view_dept
as
select e.empno, e.ename, e.sal, e.deptno, d.dname, d.loc from emp_copy e, dept d
    where e.deptno = d.deptno;

select * from emp_view_dept;
--view ���̺��� text ���� ����
desc user_views;
select * from user_views where view_name='EMP_VIEW_DEPT';

select * from emp;

create view emp_view
as
select empno,ename,job,mgr,hiredate,deptno from emp;

--���� �����ͺ��̽����� ��� �� ����
select * from user_views;

--�並 �����ϱ�
drop view emp_view_dept;
select * from emp_view_dept;

drop view course_view_20;

create or replace view emp_view30
as
select empno, ename,sal,comm, deptno from emp where deptno=30;

create view emp_view30
as
select empno, ename,deptno from emp_copy where deptno=30;

select * from user_views;


--FORCE �������̺��� ��� �並 ���� �� ���� ������� �ʴ´�.
--NOFORCE �������̺��� �־�� �並 ����� �� default �Դϴ�.
--���� ���̺�
desc employees;

create or replace force view employees_view
as
select empno, ename, deptno from employees where deptno=30;
select * from employees_view;

--WITH CHECK OPTION : where�� �ִ� �÷��� �������� ���ϵ��� ��
create or replace view emp_view30
as
select empno, ename,sal,comm, deptno from emp where deptno=30;

select * from emp_view30;
select * from emp;
update emp_view30 set deptno=30 where sal>=400;

create or replace view emp_view30
as
select empno, ename,sal,comm, deptno from emp where deptno=30
with check option;
--
update emp_view30 set comm=100 where empno=1002;
update emp_view30 set ename='ȫ�浿' where sal>250;
--update emp_view30 set deptno=20 where sal>250;(X)


select * from member;
--view �����
--no,name,passwd,id
create or replace view view_member_a1234
as
select no,name,passwd,id from member where passwd='a1234' and no = 1001 with check option;

--update�ϱ�
--���� ���� ��
update view_member_a1234 set name = 'aaa';
update view_member_a1234 set id = 'qqq';
--���� ���� �� ��? with check option
update view_member_a1234 set passwd = 'b1212';
update view_member_a1234 set no = 1008;

select * from view_member_a1234;


--��� �÷��� �б�� �����ϱ� with read only
create or replace view view_read30
as
select * from emp_copy where deptno=30 with read only;
select * from view_read30;
update view_read30 set ename='ȫ�浿'  where deptno=30;
insert into view_read30(empno,ename) values(1020,'����');
delete from view_read30 where deptno=30;

create or replace view view_hire
as
select empno, ename, hiredate from emp order by hiredate;

create or replace view view_hire
as
select rownum,empno,ename,hiredate from view_hire where rownum<=5;


--�ζ��� ���? 
--SQL�� ���ο� �並 �����ϰ� �̸� ���̺�ó�� ����ϴ� ��
--�ٸ� �������� ����� �ʿ� ���� �ش� SQL������ �ʿ��� VIEW�� ��� ���ŷ��� �並 �������� ����
--SQL ������ FROM ���� view�� ���������� �ٷ� ��� ����ϴ� ��

--�� emp, dept���̺��� ��ȸ�Ͽ� �μ���ȣ�� �μ��� �ִ�޿� �� �μ����� ����ϱ�
SELECT  e.deptno, d.dname, e.sal FROM (Select deptno, max(sal) sal from emp group by deptno) e, dept d;

--�� �ζ��� ��� �Ի����� ���� ��� 5�� ����ϱ�
select rownum, ve.empno, ve.ename, ve.hiredate 
    from (select empno, ename, hiredate from emp order by hiredate) ve
    where rownum<=5;
--1�ܰ� ��� �����
create view vv
as
select empno, ename, hiredate from emp order by hiredate;

--2�ܰ� �信�� �˻��Ѵ�
select rownum, empno,ename,hiredate 
    from vv
    where rownum<=5;
--> �ζ��� ��
select rownum, empno,ename,hiredate 
    from (select empno, ename, hiredate from emp order by hiredate)
    where rownum<=5;
    
--1. ��� ���̺��� �⺻ ���̺�� �Ͽ� �μ��� �ִ� �޿��� �ּұ޿��� ����ϴ� �並 SAL_VIEW�� �̸����� �ۼ��Ͻÿ�
select * from emp;
select * from dept;

create or replace view sal_view
as
select d.dname,max(e.sal) as "max_sal",min(e.sal) as "min_sal" from emp e,dept d where e.deptno = d.deptno group by d.dname;

select * from sal_view;
--2. �ζ��� �並 ����Ͽ� �޿��� ���� �޴� ������� 3�� ����Ͻÿ�
select rownum as RANKING,empno,ename,sal
    from (select empno, ename, sal from emp_copy where sal is not null order by sal desc)
    where rownum<=3;
--3. professor���̺�� department���̺��� �����Ͽ� ������ȣ�� �����̸�, �Ҽ� �а��̸��� ��ȸ�ϴ� view�� �����Ͻÿ�. view �̸��� v_prof_dept2�� �ϼ���
create or replace view v_prof_dept2
as
select p.profno,p.name,d.dname from professor p, department d where p.deptno = d.deptno;

select * from v_prof_dept2;
--4. inline view�� ����Ͽ� student���̺�� departmant���̺��� ����Ͽ� �а����� �л����� �ִ�Ű�� �ִ� ������, �а� �̸��� ����ϼ���.
select * from student;

select s.max_height,s.max_weight,d.dname
    from(select deptno1,max(height) as max_height,max(weight) as max_weight from student
    group by deptno1)s, department d
    where s.deptno1 = d.deptno;
--5. student���̺�� departmemt���̺��� ����Ͽ� �а� �̸�, �а��� �ִ�Ű, �а����� ���� Ű�� ū �л����� �̸��� Ű�� inline view�� ����Ͽ� ����ϼ���.
select d.dname, a.max_height, s.name, s.height
    from (select deptno1, max(height) as max_height from student group by deptno1) a,
    student s, department d where s.deptno1 = a.deptno1 and s.height = a.max_height and s.deptno1 = d.deptno;
--6. student���̺��� �л��� Ű�� ���� �г��� ��� Ű���� ū �л����� �г�� �̸� Ű, �ش� �г��� ���Ű�� ����ϵ� inline view�� ����ؼ� ����ϼ���.(�г� �÷����� �������� �����ؼ� ����ϼ���)
select s.grade, s.name, s.height, a.avg_height
    from(select grade,avg(height) as avg_height from student group by grade)a,student s
    where a.grade = s.grade and s.height > a.avg_height order by grade; --order by grade,a.grade,s.grade �� ����    
--7. professor���̺��� ��ȸ�Ͽ� �������� �޿� ������ �̸��� �޿��� ����Ͻÿ�. �� �޿� ������ �޿��� ���� ������� 1~5������ ����ϼ���
select rownum as ranking,name,pay
    from(select name,pay from professor order by 2 desc)
    where rownum<=5;
--8. ���� ���̺��� ���� ��ȣ�� �����ϵ� 3�Ǿ� �и��ؼ� �޿� �հ�� �޿� ����� ����ϼ���
select num,profno,name,pay,sum(pay),round(avg(pay),1)
    from(select profno, name, pay, rownum num from professor)
    group by ceil(num/3), rollup((profno,name,pay,num))
    order by ceil(num/3);

--ROLLUP �Լ�
--ROLLUP�� ������ Grouping Columns �� List �� Subtotal �� �����ϱ� ���� ���Ǿ����ϴ�.
--Grouping Columns �� ���� N �̶�� ���� �� N + 1 Level �� Subtotal �� �����˴ϴ�.

--ǥ�� ���� ��ü �࿡ ���ؼ�
SELECT dname, job, count(*), sum(sal) from emp, dept
   where dept.deptno = emp.deptno group by dname, job;

-- dname���� ��� job�� subtotal  
SELECT dname, job, count(*), sum(sal) from emp, dept
   where dept.deptno = emp.deptno group by dname, job
    order by dname, job;

--�׷캰�� subtotal�� ���� �� �ִ�. 
SELECT dname, job, count(*), sum(sal) from emp, dept
   where dept.deptno = emp.deptno group by rollup(dname, job);   
