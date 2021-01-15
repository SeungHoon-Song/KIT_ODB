select * from emp;
--1번
select max(sal+nvl(comm,0)) "MAX",min(sal+nvl(comm,0))"MIN", 
    round(avg(sal+nvl(comm,0)),1)"AVG"from emp;

--2번
insert into emp(empno,deptno,ename,sal) values(1000,10,'이경자',3000);
insert into emp(empno,deptno,ename,sal) values(2000,10,'최병민',4000);

--3번
update emp set sal=sal+sal*0.1;

--4번
commit;     --모든 작업들을 정상처리하겠다는 확정 명령어
rollback;   --트랙잭션 처리 과정에서 발생한 변경사항 취소 명령어

--5번
--데이터 무결성 제약조건이란 테이블에 부적절한 자료가 입력되는 것을 방지하기 위해서 테이블을 생성할 때 각 컬럼에 대해서 정의하는 여러 가지 규칙
--NOT NULL : NULL 허용하지 않는다.
--UNIQUE : 중복된 값을 허용하지 않는다.
--PRIMARY KEY : NULL을 허용하지 않고 중복된 값을 허용하지 않는다.
--FOREUGN KEY : 참조되는 테이블의 컬럼의 값이 존재하면 허용한다.
--CHECK : 저장 가능한 데이터 값의 범위나 조건을 지정하여 설정한 값만 허용

--6번
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

--7번
select * from emp;
select * from dept;
select ename, sal from emp where deptno=(select deptno from dept where dname = '영업부');

--8번
select e.ename, e.hiredate from emp e,dept d where e.deptno = d.deptno and d.dname = '경리부';

--9번
select e.ename, e.sal from emp e, dept d where e.deptno = d.deptno and d.loc = '인천';

--10번
create sequence deptno_seq
increment by 500
start with 2000
minvalue 2000
maxvalue 5000
cycle
cache 6;

select deptno_seq.nextval from dual;

--11번
--Equi Join : 동일 칼럼을 기준으로 조인
select * from emp, dept where emp.deptno = dept.deptno;
--Non-Equi Join : 동일 칼럼이 없이 다른 조건을 사용하여 조인
select e.ename, e.sal, s.grade from emp e, salgrade s where sal >= losal and sal <= hisal;
--Outer Join : 조인 조건에 만족하지 않는 행도 나타냄
select * from emp full outer join dept on emp.deptno = dept.deptno;
select * from emp left outer join dept on emp.deptno = dept.deptno;
select * from emp right outer join dept on emp.deptno = dept.deptno;
--Self Join : 한 테이블 내에서 조인합니다.
select empno,ename, mgr from emp;
select e1.ename as "사원이름",e2.ename as "매니저 이름" from emp e1, emp e2 where e1.mgr = e2.empno;


