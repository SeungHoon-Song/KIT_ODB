create sequence dept_deptno_seq
    start with 10
    increment by 10;

desc user_sequences;
select * from user_sequences where sequence_name in ('SAMPLE_SEQ');

--nextVal : ���� ��
select dept_deptno_seq.nextVal from dual;
--currVal : ���� ��
select dept_deptno_seq.currVal from dual;

create sequence sample_seq;

select sample_seq.nextVal from dual;
select sample_seq.currVal from dual;

--Ȱ���ϱ�
drop sequence emp_seq;
create sequence emp_seq
    start with 1010
    increment by 10
    maxvalue 1500;
    
drop table emp01;

create table emp01(
    empno number(4) primary key,
    name varchar(10),
    hiredate date);
    
select * from user_constraints where table_name in ('EMP01');

insert into emp01
    values( emp_seq.nextVal, 'ȫ�浿',sysdate);

select emp_seq.currVal from dual;

select * from emp01;

delete from emp01;
--1010 1020 1030 ~ 1500

alter sequence emp_seq
    increment by 200
    maxvalue 2000
    cycle
    cache 10;

desc user_ind_columns;
--�ε��� ��Ȳ ����
select * from user_ind_columns;

drop table emp01;
create table emp01
as
select * from emp;

--emp�ε��� Ȯ��
--emp01 �ε��� Ȯ��
select * from user_ind_columns where table_name in ('EMP01');

--emp01�� ������ ����
insert into emp01 select * from emp01;
insert into emp01 (empno, ename) values(2222,'syj');
set timing on
select distinct empno, ename from emp01 where ename='syj';

--�ε��� ����
create index idx_emp01_ename
    on emp01(ename);
    
--�ε��� ����
drop index idx_emp01_ename;
--����, ����, �����Ҷ� �ε��� ���� �� ����ð�, �ε��� �� �ٿ��� �� ����ð�

drop table dept01;
create table dept01
as
select * from dept where deptno=100;

desc dept01;

insert into dept01 values(10,'�λ��','����');
insert into dept01 values(20,'�ѹ���','����');
insert into dept01 values(30,'������','����');

select * from dept01;

--���� �ε��� �����ϱ�
--�ε��� �÷��� �����Ͱ� unique�� ���� ������ ����
create unique index idx_dept01_deptno
    on dept01(deptno);
    
create unique index idx_dept01_dname
    on dept01(dname);

create unique index idx_dept01_loc
    on dept01(loc);    --(X)

--����� �ε��� �����
create index idx_dept01_loc
    on dept01(loc);

--�ε��� ��� �����ϱ�
drop index idx_dept01_dname;

--�����ε���
create index idx_dept01_deptno_dname
    on dept01(deptno, dname);

select * from user_ind_columns where table_name in ('DEPT01');

--deptno �ε��� ���� --> dname�ε��� ���� --> �����ε��� �����غ��� (O)
--�����ε��� �����غ��� --> deptno�ε��� ���� --> dname�ε��� ����

--�Լ���� �ε���
create index idx_emp01_annsal
    on emp01(sal*12);
    
drop index idx_emp01_annsal;

select * from user_ind_columns where table_name in ('EMP01');    

select * from emp01 where sal*12>=3600;

--�ε��� �����ϱ�
--�ε����� ������ �Ŀ� ���ο� ���� �߰��ǰų� ������ �� �ִ�.
--�̶� �ε����� ���� �÷� ���� ����� ���� �ֽ��ϴ�.
--�̷� ��� �� ���̺��� �ڷ� �߰�,����,���� �۾��� �Ͼ�� �ش� ���̺� �ɸ� �ε����� ���뵵 �Բ� �����Ǿ�� �մϴ�.
--�̶� ����մϴ�.
alter index dix_dept01_deptno rebuild;


--1. �μ� ��ȣ�� �����ϴ� ������ ��ü�� �����Ͽ� ������ ��ü�� �̿��Ͽ� �μ� ��ȣ�� �ڵ����� �����ϵ��� �غ�����.
--1) �μ����̺� �μ� ��ȣ�� �ڵ����� �ο��ϱ� ���ؼ� �μ� ���̺��� �����մϴ�.
create table dept_ex(
    deptno number(4) primary key,
    dname varchar2(15),
    loc varchar2(15));
--2) ������ �μ� ���̺� �⺻Ű ���� ������ �����Ǿ����� ���� ����
select * from user_constraints where table_name in ('DEPT_EX');
--3) �μ� ��ȣ�� �����ϴ� deptno �÷��� �⺻Ű�� �����Ͽ����Ƿ� �ߺ��� ���� ���� �� �����ϴ�.
--���ο� row�� �߰��� ������ �������� ���ؼ� �μ� ��ȣ�� �ڵ����� �ο��ǵ��� �ϱ�
create sequence dept_ex_seq
        start with 100
        increment by 10
        maxvalue 2000;
--4) ��� ���� ������ ����
insert into dept_ex values (dept_ex_seq.nextval, '�λ��','����');

select * from dept_ex;
--2. ������̺��� ���� �ε����� �����ϱ�
create index idx_emp01_job
    on emp01(job);

