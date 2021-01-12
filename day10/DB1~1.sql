create sequence dept_deptno_seq
    start with 10
    increment by 10;

desc user_sequences;
select * from user_sequences where sequence_name in ('SAMPLE_SEQ');

--nextVal : 다음 값
select dept_deptno_seq.nextVal from dual;
--currVal : 현재 값
select dept_deptno_seq.currVal from dual;

create sequence sample_seq;

select sample_seq.nextVal from dual;
select sample_seq.currVal from dual;

--활용하기
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
    values( emp_seq.nextVal, '홍길동',sysdate);

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
--인덱스 현황 보기
select * from user_ind_columns;

drop table emp01;
create table emp01
as
select * from emp;

--emp인덱스 확인
--emp01 인덱스 확인
select * from user_ind_columns where table_name in ('EMP01');

--emp01에 데이터 삽입
insert into emp01 select * from emp01;
insert into emp01 (empno, ename) values(2222,'syj');
set timing on
select distinct empno, ename from emp01 where ename='syj';

--인덱스 생성
create index idx_emp01_ename
    on emp01(ename);
    
--인덱스 제거
drop index idx_emp01_ename;
--삽입, 삭제, 수정할때 인덱스 했을 때 경과시간, 인덱스 안 붙였을 때 경과시간

drop table dept01;
create table dept01
as
select * from dept where deptno=100;

desc dept01;

insert into dept01 values(10,'인사과','서울');
insert into dept01 values(20,'총무과','대전');
insert into dept01 values(30,'교육팀','대전');

select * from dept01;

--고유 인덱스 지정하기
--인덱스 컬럼의 데이터가 unique의 제한 조건이 만족
create unique index idx_dept01_deptno
    on dept01(deptno);
    
create unique index idx_dept01_dname
    on dept01(dname);

create unique index idx_dept01_loc
    on dept01(loc);    --(X)

--비고유 인덱스 만들기
create index idx_dept01_loc
    on dept01(loc);

--인덱스 모두 삭제하기
drop index idx_dept01_dname;

--결합인덱스
create index idx_dept01_deptno_dname
    on dept01(deptno, dname);

select * from user_ind_columns where table_name in ('DEPT01');

--deptno 인덱스 생성 --> dname인덱스 생성 --> 결합인덱스 생성해보기 (O)
--결합인덱스 생성해보기 --> deptno인덱스 생성 --> dname인덱스 생성

--함수기반 인덱스
create index idx_emp01_annsal
    on emp01(sal*12);
    
drop index idx_emp01_annsal;

select * from user_ind_columns where table_name in ('EMP01');    

select * from emp01 where sal*12>=3600;

--인덱스 수정하기
--인덱스를 생성된 후에 새로운 행이 추가되거나 삭제될 수 있다.
--이때 인덱스로 사용된 컬럼 값이 변경될 수도 있습니다.
--이럴 경우 본 테이블의 자료 추가,삭제,변경 작업이 일어날때 해당 테이블에 걸린 인덱스의 내용도 함께 수정되어야 합니다.
--이때 사용합니다.
alter index dix_dept01_deptno rebuild;


--1. 부서 번호를 생성하는 시퀀스 객체를 생성하여 시퀀스 객체를 이용하여 부서 번호를 자동으로 생성하도록 해보세요.
--1) 부서테이블에 부서 번호를 자동으로 부여하기 위해서 부서 테이블을 생성합니다.
create table dept_ex(
    deptno number(4) primary key,
    dname varchar2(15),
    loc varchar2(15));
--2) 생성된 부서 테이블에 기본키 제약 조건이 설정되었는지 살펴 보기
select * from user_constraints where table_name in ('DEPT_EX');
--3) 부서 번호를 저장하는 deptno 컬럼을 기본키로 설정하였으므로 중복된 값을 가질 수 없습니다.
--새로운 row를 추가할 때마다 시퀀스에 의해서 부서 번호가 자동으로 부여되도록 하기
create sequence dept_ex_seq
        start with 100
        increment by 10
        maxvalue 2000;
--4) 사원 정보 삽입해 보기
insert into dept_ex values (dept_ex_seq.nextval, '인사과','서울');

select * from dept_ex;
--2. 사원테이블의 직급 인덱스를 생성하기
create index idx_emp01_job
    on emp01(job);

