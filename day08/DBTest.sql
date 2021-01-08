CREATE TABLE emp08
as 
select * from emp where deptno = 100;

create table dept02
as 
select * from dept where loc='a';

desc dept02;
--데이터 삽입
insert into dept02 values(50,'보안부','서울');
insert into dept02 select * from dept;
select * from dept02;

alter table dept02
    add memo varchar2(10);
desc dept02;

insert into dept02 select * from dept;  --구조 다르면 에러

create table dept03(
    deptno01 number(2),
    dname1 varchar2(14),
    locl varchar2(13));
--두개 테이블의 구조가 같은데 컬럼명이 다르면 삽입된다.
insert into dept03 select * from dept;
select * from dept03;

--두개 테이블의 구조가 다르면 1. 적으면 dept04  2. 많으면 dept05
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

--두개 테이블의 구조 순서(loc, dname, deptno)가 다르고 컬럼의 내용이 같을때
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
--문 20번 부서의 지역명을 40번 부서의 지역명으로 바꾸시오 (20번 부서 인천 --> 수원)
update dept03 set loc = '수원' where deptno=20;

update dept03 set loc = (select loc from dept03 where deptno=40) where deptno=20;
rollback;

select * from dept03 where deptno=20;
select loc from dept03 where deptno=40;

select * from emp02;
select * from dept;
--문 사원테이블에서 '영업부'인 사원 삭제하기
select deptno from dept where dname = '영업부';

delete from emp02 where deptno = (select deptno from dept where dname = '영업부');



-- 부서 테이블 제거하기
DROP TABLE EMP;
-- 사원 테이블 제거하기
DROP TABLE DEPT;
-- 급여 테이블 제거하기
DROP TABLE SALGRADE;
-- 부서 테이블 제거하기
DROP TABLE EMPLOYEE;
-- 사원 테이블 제거하기
DROP TABLE DEPARTMENT;
-- 급여 테이블 제거하기
DROP TABLE SALGRADE;



-- 부서 테이블 생성하기
CREATE TABLE DEPT(
DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
DNAME VARCHAR2(14),
LOC VARCHAR2(13) ) ;

desc dept;

-- 사원 테이블 생성하기
CREATE TABLE EMP_1( 
EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
MGR NUMBER(4),
HIREDATE DATE,
SAL NUMBER(7,2),
COMM NUMBER(7,2),
DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT);

-- 급여 테이블 생성하기
CREATE TABLE SALGRADE_1(
GRADE NUMBER,
LOSAL NUMBER,
HISAL NUMBER );

-- 사원 테이블에 샘플 데이터 추가하기
INSERT INTO DEPT VALUES(10, '경리부', '서울');
INSERT INTO DEPT VALUES(20, '인사부', '인천');
INSERT INTO DEPT VALUES(30, '영업부', '용인'); 
INSERT INTO DEPT VALUES(40, '전산부', '수원');

-- 부서 테이블에 샘플 데이터 추가하기
INSERT INTO EMP_1 VALUES(1001, '김사랑', '사원', 1013, to_date('2007-03-01','yyyy-mm-dd'), 300, NULL, 20);
INSERT INTO EMP_1 VALUES(1002, '한예슬', '대리', 1005, to_date('2007-04-02','yyyy-mm-dd'), 250, 80, 30);
INSERT INTO EMP_1 VALUES(1003, '오지호', '과장', 1005, to_date('2005-02-10','yyyy-mm-dd'), 500, 100, 30);
INSERT INTO EMP_1 VALUES(1004, '이병헌', '부장', 1008, to_date('2003-09-02','yyyy-mm-dd'), 600, NULL, 20);
INSERT INTO EMP_1 VALUES(1005, '신동협', '과장', 1005, to_date('2005-04-07','yyyy-mm-dd'), 450, 200, 30);
INSERT INTO EMP_1 VALUES(1006, '장동건', '부장', 1008, to_date('2003-10-09','yyyy-mm-dd'), 480, NULL, 30);
INSERT INTO EMP_1 VALUES(1007, '이문세', '부장', 1008, to_date('2004-01-08','yyyy-mm-dd'), 520, NULL, 10);
INSERT INTO EMP_1 VALUES(1008, '감우성', '차장', 1003, to_date('2004-03-08','yyyy-mm-dd'), 500, 0, 30);
INSERT INTO EMP_1 VALUES(1009, '안성기', '사장', NULL, to_date('1996-10-04','yyyy-mm-dd'),1000, NULL, 20);
INSERT INTO EMP_1 VALUES(1010, '이병헌', '과장', 1003, to_date('2005-04-07','yyyy-mm-dd'), 500, NULL, 10);
INSERT INTO EMP_1 VALUES(1011, '조향기', '사원', 1007, to_date('2007-03-01','yyyy-mm-dd'), 280, NULL, 30);
INSERT INTO EMP_1 VALUES(1012, '강혜정', '사원', 1006, to_date('2007-08-09','yyyy-mm-dd'), 300, NULL, 20);
INSERT INTO EMP_1 VALUES(1013, '박중훈', '부장', 1003, to_date('2002-10-09','yyyy-mm-dd'), 560, NULL, 20);
INSERT INTO EMP_1 VALUES(1014, '조인성', '사원', 1006, to_date('2007-11-09','yyyy-mm-dd'), 250, NULL, 10);

?

-- 급여 테이블에 샘플 데이터 추가하기
INSERT INTO SALGRADE_1 VALUES (1, 700,1200);
INSERT INTO SALGRADE_1 VALUES (2, 1201,1400);
INSERT INTO SALGRADE_1 VALUES (3, 1401,2000);
INSERT INTO SALGRADE_1 VALUES (4, 2001,3000);
INSERT INTO SALGRADE_1 VALUES (5, 3001,9999);
COMMIT;

select * from emp_1;
select * from dept;
--2. 경리부에서 근무하는 사원의 이름과 입사일을 출력하기
select ename, hiredate from emp_1, dept where emp_1.deptno = dept.deptno and dname = '경리부';
--3. ANSI JOIN을 사용하여 인천에서 근무하는 사원이름과 급여을 출력하기
select e.ename, e.sal from emp_1 e inner join dept d on e.deptno = d.deptno and d.loc = '인천';
--4. 사원 테이블과 부서 테이블을 조인하여 사원이름과 부서번호, 부서명을 출력하시오
select e.ename, d.deptno, d.dname from emp_1 e inner join dept d on e.deptno = d.deptno;
--5. 경리부 부서 소속 사원의 이름과 입사일을 출력하시오
select ename, hiredate from emp_1, dept where emp_1.deptno = dept.deptno and dname = '경리부';
--6. 직급이 과장인 사원이 이름, 부서명을 출력하시오
select e.ename, d.dname from emp_1 e, dept d where e.deptno = d.deptno and e.job='과장';
--7. 직속상관이 감우성인 사원들의 이름과 직급을 출력하시오
select work.ename, work.job, manager.ename from emp_1 work, emp_1 manager where work.mgr = manager.empno and manager.ename='감우성';
--8. 감우성과 동일한 근무지에서 근무하는 사원의 이름을 출력하시오
select work.ename, friend.ename from emp_1 work, emp_1 friend where work.deptno = friend.deptno and work.ename='감우성' and friend.ename <> '감우성';





select * from student;
select * from department;
select * from professor;
select * from emp2;
select * from dept2;
--1. Student 테이블과 department테이블을 사용하여 'Anthony  Hopkins'학생과 전공(deptno1)이 동일한 학생들의 이름과 전공1 이름을 출력하시오
SELECT s.name "STUD_NAME" , d.dname "DEPT_NAME" FROM student s , department d
WHERE s.deptno1=d.deptno and s.deptno1 = ( SELECT deptno1 FROM student WHERE name='Anthony Hopkins') ;
--2. professor테이블과 department테이블을 조회하여 'Meg Ryan'교수보다 나중에 입사한 사람의 이름과 입사일 학과명을 출력하세요
select p.name, p.hiredate, d.dname from professor p, department d where p.deptno = d.deptno and hiredate > (select hiredate from professor where name = 'Meg Ryan');
--3. student 테이블에서 전공1이 201번인 학과의 평균 몸무게보다 몸무게가 많은 학생들의 이름과 몸무게를 출력하세요
select name, weight from student where weight > (select avg(weight) from student where deptno1=201);
--4. emp2테이블을 사용하여 전체 직원 중 'Section Head'직급의 최소 연봉자보다 연봉이 높은 사람의 이름과 직급 연봉을 출력하시오.
--단 연봉 출력 형식은 천단위 구분기호와 $표시를 하세요.
select name, position, to_char(pay, '$999,999,999') as "연봉" from emp2
    where pay > any (select pay from emp2 where position = 'Section head');
select name, position, to_char(pay, '$999,999,999') as "연봉" from emp2
    where pay > (select min(pay) from emp2 where position = 'Section head');
--5. student테이블을 조회하여 전체 학생 중에서 체중이 2학년 체중에서 가장 적게 나가는 학생보다 몸무게가 적은 학생의 이름과 학년과 몸무게를 출력하세요.
select name, weight from student where weight < (select min(weight) from student where grade=2);
--6. emp2테이블과 dept2테이블을 조회하여 각 부서별 평균 연봉을 구하고 그중에서 평균 연봉이 가장 적은 부서의 평균 연봉보다 적게 받는 직원들의 부서명, 직원명, 연봉을 출력하세요.
select d.dname, e.name, to_char(pay,'$999,999,999') from emp2 e, dept2 d
    where e.deptno = d.dcode and e.pay < all (select avg(pay) from emp2 group by deptno);
--7. professor테이블과 department테이블을 조회하여 각 학과별로 입사일이 가장 오래된 교수의 교수번호와 이름, 학과명을 출력하세요.(입사일 순으로 오름차순 정렬하세요)
select p.profno, p.name, p.hiredate, d.dname from professor p, department d 
    where p.deptno=d.deptno and (p.deptno,p.hiredate) in (select deptno, min(hiredate) from professor group by deptno)
    order by p.hiredate;
--8. emp2 테이블을 조회하여 직급별로 해당 직급에서 최대 연봉을 받는 직원의 이름과 직급, 연봉을 출력하세요. 연봉순으로 오름차순 정렬하세요.
select name,position, to_char(pay,'$999,999,999') from emp2
    where (position, pay) in (select position, max(pay) from emp2 group by position);




--서브쿼리 문제
--1. 서브 쿼리를 이용하여 "영업부"에서 근무하는 모든 사원의 이름과 급여를 출력하라
select ename, sal from emp_1
    where deptno = (select deptno from dept where dname = '영업부');
--2. 서브쿼리를 사용하여 emp06에 emp테이블의 모든 데이터를 추가합니다.
create table emp06
as select * from emp_1;
--3. emp06 테이블에 저장된 사원 정보 중 과장들의 최소 급여보다 많은 급여를 받는 사원들의 이름과 급여와 직급을 출력하되 과장은 출력하지 않게
select ename, sal from emp_1
    where sal > any (select sal from emp_1 where job = '과장') and job <> '과장';
--4. emp06 테이블에 저장된 사원 정보 중 인천에 위치한 부서에 소속된 사원들의 급여를 100인상하는 SQL문을 작성하시오
select * from emp06 where deptno=20;
update emp06 set sal = sal+100 where deptno in (select deptno from dept where loc='인천');
--5. emp06테이블에서 경리부에 소속된 사원들만 삭제하는 SQL문을 작성하시오
delete from emp06 where deptno = (select deptno from dept where dname='경리부');
--6. '이문세'와 같은 부서에 근무하는 사원의 이름과 부서번호를 출력하는 SQL문을 작성하시오.
select ename, deptno from emp_1 where deptno = (select deptno from emp_1 where ename = '이문세') and ename <> '이문세';
--7. '이문세'와 동일한 직급을 가진 사원을 출력하는 SQL문을 완성하시오.
select * from emp_1 where job = (select job from emp_1 where ename = '이문세');
--8. '이문세'의 급여와 동일하거나 더 많이 받는 사원명과 급여를 출력하는 SQL문을 완성하시오
select ename, sal from emp_1 where sal >= (select sal from emp_1 where ename='이문세');
--9. '인천'에서 근무하는 사원의 이름, 부서번호를 출력하는 SQL문을 완성하시오
select ename, deptno from emp_1 where deptno = (select deptno from dept where loc = '인천');
--10. 직속상관이 감우성인 사원의 이름과 급여를 출력하는 SQL문을 완성하시오
select ename, sal, mgr from emp_1 where mgr = (select empno from emp_1 where ename = '감우성');
--11. 부서별로 가장 급여를 많이 받는 사원의 정보 (사원번호, 사원이름, 급여, 부서번호)를 출력하는 SQL문을 완성하시오.
select empno, ename, sal, deptno from emp_1 e where sal = (select max(sal) from emp_1 where deptno = e.deptno)
    order by deptno;
--12. 직급(JOB)이 과장인 사원이 속한 부서의 부서번호와 부서명, 지역을 출력하시오
select * from dept where deptno in (select deptno from emp_1 where job='과장');
--13. 과장보다 급여를 많이 받은 사원들의 이름과 급여와 직급을 출력하되 과장은 출력하지 않는 SQL문을 완성하시오.
select ename, sal, job from emp_1 where sal > all (select sal from emp_1 where job = '과장');
