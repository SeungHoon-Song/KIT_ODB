drop table emp01;
--컬럼레벨 방식의 제약조건
CREATE TABLE emp01 (
    empno number(4) primary key,
    ename varchar2(10) not null,
    job varchar2(9) unique,
    deptno number(2) references dept(deptno));
    
--테이블 레벨 방식의 제약조건
drop table emp02;
CREATE table emp02 (
    empno number(4),
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2),
    primary key(empno),
    unique(job),
    foreign key(deptno) references dept(deptno));

--복합키     
drop table member01;
CREATE TABLE member01(
    name varchar2(10),
    address varchar2(30),
    phone varchar2(16),
    CONSTRAINT member01_name_phone_pk PRIMARY KEY(name, phone));
    
desc member01;
--입력하기 정상
INSERT INTO member01 VALUES ('a','seoul','123');
INSERT INTO member01 VALUES ('b','seoul','123');
INSERT INTO member01 VALUES ('a','seoul','1234');
--복합키 제약조건에 의한 오류
INSERT INTO member01 VALUES ('a','seoul','123');

CREATE TABLE member02(
    name varchar2(10),
    address varchar2(30),
    phone varchar2(16),
    CONSTRAINT member02_name_phone_pk PRIMARY KEY (name,address,phone));
    
--정상 입력하기
INSERT INTO member02 VALUES('a','seoul','123');
INSERT INTO member02 VALUES('al','seoul','123');

drop table emp01;

create table emp01(
    empno number(4),
    ename varchar2(10),
    job varchar2(9),
    deptno number(2));
    
--제약 조건 검색하기
SELECT * from user_constraints where table_name in('EMP01');

--제약 조건을 추가하기
ALTER TABLE emp01
 ADD CONSTRAINT emp01_empno_pk Primary key(empno);
 
--외래키로 추가 deptno
ALTER TABLE emp01
 ADD CONSTRAINT emp01_deptno_fk FOREIGN KEY(deptno) REFERENCES DEPT(deptno);

--NOT NULL은 Modify로 변경하기
ALTER TABLE emp01
    MODIFY ename CONSTRAINT emp01_ename_nn not null;

--제약 조건 제거
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
--emp테이블의 외래키로써 삭제할 수 없다.
DELETE FROM dept WHERE deptno=10;
--삭제하려면 1) emp테이블의 외래키 조건을 삭제, 2) 비활성화
SELECT * from user_CONSTRAINTS WHERE table_name in ('EMP');

drop table dept01;
CREATE TABLE dept01(
    deptno number(2) constraint dept01_deptno_pk primary key,
    dname varchar2(14),
    loc varchar2(13));

insert into dept01 values (10,'경리부','서울');
insert into dept01 values (20,'인사부','인천');

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
    
insert into emp01 values(1000,'허준','사원',10);
select * from emp01;
--dpetno 삭제안됨 왜? 외래키 관계이기 때문
delete from dept01 where deptno=10;

--비활성하기
--외래키 관계의 테이블에서 비활성화해줌
ALTER TABLE emp01
    disable CONSTRAINT emp01_deptno_fk;
--dpetno 삭제됨
delete from dept01 where deptno=10;

select * from dept01;

--활성화하기
--외래키 관계의 테이블에서 활성화해줌
--에러 발생: emp01안에 데이터중에서 deptno 10이있음
ALTER TABLE emp01
    ENABLE CONSTRAINT emp01_deptno_fk;
    
select * from emp01;
select * from dept01;

insert into dept01 values (10,'경리부','서울');

--외래키 관계가 활성화 되어 있기 때문에 삭제가 안됨
delete from dept01 where deptno=10;

--부모테이블의 기본키 제약 조건을 비활성화 시키기
--오류 발생 : 자식 테이블의 외래키로 쓰이기 때문에 비활성화 할 수 없다.
ALTER TABLE dept01
    disable primary key;
--cascade를 사용하여서 자식 테이블도 비활성화
alter table dept01
    disable primary key cascade;

select * from user_constraints where table_name in ('DEPT01','EMP01');
--활성화 해줄 때는 부모의 기본키
alter table dept01
    enable primary key;
   
--오류 발생 : 부서테이블의 기본키는 사원테이블의 외래키에서 참조하기 때문에 제약조건을 삭제할 수 없다.
alter table dept01
    drop primary key;
--해결 방법
--dept01 테이블의 기본키 제약조건 삭제, emp01 테이블의 외래키 제약조건도 모두 삭제함
alter table dept01
    drop primary key cascade;
select * from user_constraints where table_name in ('DEPT01','EMP01');

--1) 직원 테이블 employee 테이블
CREATE TABLE  employee01(
    emp_no number(4),
    emp_name varchar2(20),
    salary  number(6),
    birthday  date);
--2) 프로젝트 테이블 project테이블
CREATE TABLE  project01(
     pro_no number(4),
     pro_content varchar2(100),
     start_date  date,
     finish_date date);
--3) 특기(specialty)  테이블을 생성
CREATE TABLE  specialty01(
     emp_no number(4),
     specialty   varchar2(20));
--4) 담당 테이블 assign
CREATE TABLE assign01(
   emp_no   number(4),
   pro_no    number(4));
--5)  위에 처럼 테이블을 생성하훈 아래 표의 제약 조건을 추가합니다.
--직원 테이블 기본키 추가
ALTER TABLE employee01
 ADD CONSTRAINT employee01_emp_no_pk PRIMARY KEY(emp_no);
--프로젝트 테이블 기본키 추가
ALTER TABLE project01
 ADD CONSTRAINT project01_pro_no_pk PRIMARY KEY(pro_no);
--특기 테이블 기본키 추가
ALTER TABLE specialty01
 ADD CONSTRAINT specialty01_empnospecialty_pk PRIMARY KEY(emp_no,specialty);
--특기 테이블 외래키 추가
ALTER TABLE specialty01
 ADD CONSTRAINT specialty01_emp_no_fk FOREIGN KEY(emp_no) REFERENCES employee01(emp_no);
--담당 테이블 기본키 추가
ALTER TABLE assign01
 ADD CONSTRAINT assign01_emp_no_pro_no_pk PRIMARY KEY(emp_no,pro_no);
--담당 테이블 외래키 추가
ALTER TABLE assign01
 ADD CONSTRAINT assign01_emp_no_fk FOREIGN KEY(emp_no) REFERENCES employee01(emp_no);
--담당 테이블 외래키 추가
ALTER TABLE assign01
 ADD CONSTRAINT assign01_pro_no_fk FOREIGN KEY(pro_no) REFERENCES project01(pro_no);

select * from user_constraints where table_name in('EMPLOYEE01','PROJECT01','SPECIALTY01','ASSIGN01');

select * from emp;  --21개
select * from dept; --4개

select * from emp where ename = '이문세';
select * from dept where deptno = 10;

--Cross join : 전체 집합 레코드 수  = 테이블 레코드수 X 테이블2 레코드수
select emp.empno,ename,emp.deptno,dname from emp, dept where ename='김사랑';

--Equi join : 제일 많이 사용하는 조인 방법
select empno, ename, emp.deptno, dept.deptno dname from emp, dept where emp.deptno = dept.deptno;
--수행 순서
--from emp, dept --> WHERE emp.deptno = dept.deptno --> empno, ename, emp.deptno, dept.deptno dname

--이문세의 이름과 소속 부서 출력하기
--출력 형태 이문세 경리부
SELECT ename, dname FROM emp,dept WHERE emp.deptno = dept.deptno and ename = '이문세';

--컬럼명의 모호성 해결 - 테이블명.컬럼명
select ename, emp.deptno, dname from emp, dept where emp.deptno = dept.deptno and ename = '이문세';

--테이블명에 별칭 붙이기 FROM 테이블명1 별칭, 테이블명2 별칭 
select e.ename, d.dname, d.deptno from emp e, dept d where e.deptno = d.deptno and e.ename = '이문세';

--Non-Equi join
--급여테이블
select * from salgrade;
--급여의 등급은 총 5등급으로 나누어져 있다.
select * from emp;
select ename, sal, grade from emp, salgrade where sal between losal and hisal;

insert into salgrade values(0,0,699);
delete from salgrade where grade=0;

--ename, dname, sal, grade
select ename, dname, sal, grade from emp e, dept d, salgrade s
    where e.deptno = d.deptno and e.sal between s.losal and s.hisal order by grade desc;
    
--SELF JOIN
select empno,ename, mgr from emp;
--출력 결과 ENAME, MNAME 김사랑 박중훈
select e1.ename as "사원이름",e2.ename as "매니저 이름" from emp e1, emp e2 where e1.mgr = e2.empno;
select * from emp;

--ANSI Inner join
select * from emp, dept where emp.deptno = dept.deptno;
--같은거
select * from emp inner join dept on emp.deptno = dept.deptno;

SELECT ename, dname FROM emp,dept WHERE emp.deptno = dept.deptno and ename = '이문세';
--같은거
SELECT ename, dname FROM emp INNER JOIN dept ON emp.deptno = dept.deptno and ename = '이문세';


select * from emp;
select * from dept;

select * from emp full outer join dept on emp.deptno = dept.deptno;
select * from emp left outer join dept on emp.deptno = dept.deptno;
select * from emp right outer join dept on emp.deptno = dept.deptno;









