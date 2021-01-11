create table emp_copy
as
SELECT * from emp;

select * from emp_copy; --물리적 테이블

create view emp_view30
as
--dptno 30인 사원의 사번, 이름, 부서번호를 검색
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

--뷰의 동작순서
--1. 사람 쿼리 수행
select * from course_view_20;
--2. 뷰의 text컬럼안에 자료인 select문을 수행합니다.
--3. 물리적인 데이터 조회
--4. 물리적인 데이터 조회
--5. 1으로 결과를 리턴함

--뷰를 사용하는 이유
--1. 긴 쿼리문, 많이 쓰는 쿼리문을 뷰로 만들기
--2. 보안에 유리

--뷰를 만드는 방법
--1. select문
--2. insert문으로 뷰안에 데이터 추가
select * from emp_view30;
insert into emp_view30 values(2222,'bbbb',30);  --뷰안에 데이터 넣기
--물리적 데이터는? 추가 되었다.
select * from emp;
--view로 데이터 수정하기 aaaa인 사람의 deptno 40으로 수정
update emp_view30 set ename='cccc' where empno = '2222';
--view테이블을 이용하여 데이터 삭제 aaaa인 사람 삭제하기
delete from emp_view30 where empno = '2222';
delete from emp_view30 where empno = '1002';
commit;

create view emp_view_dept
as
select e.empno, e.ename, e.sal, e.deptno, d.dname, d.loc from emp_copy e, dept d
    where e.deptno = d.deptno;

select * from emp_view_dept;
--view 테이블에서 text 내용 보기
desc user_views;
select * from user_views where view_name='EMP_VIEW_DEPT';

select * from emp;

create view emp_view
as
select empno,ename,job,mgr,hiredate,deptno from emp;

--현재 데이터베이스에서 모든 뷰 보기
select * from user_views;

--뷰를 삭제하기
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


--FORCE 기존테이블이 없어도 뷰를 만들 때 거의 사용하지 않는다.
--NOFORCE 물리테이블이 있어야 뷰를 만드는 것 default 입니다.
--없는 테이블
desc employees;

create or replace force view employees_view
as
select empno, ename, deptno from employees where deptno=30;
select * from employees_view;

--WITH CHECK OPTION : where에 있는 컬럼을 변경하지 못하도록 함
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
update emp_view30 set ename='홍길동' where sal>250;
--update emp_view30 set deptno=20 where sal>250;(X)


select * from member;
--view 만들기
--no,name,passwd,id
create or replace view view_member_a1234
as
select no,name,passwd,id from member where passwd='a1234' and no = 1001 with check option;

--update하기
--오류 없는 것
update view_member_a1234 set name = 'aaa';
update view_member_a1234 set id = 'qqq';
--오류 나는 것 왜? with check option
update view_member_a1234 set passwd = 'b1212';
update view_member_a1234 set no = 1008;

select * from view_member_a1234;


--모든 컬럼을 읽기로 변경하기 with read only
create or replace view view_read30
as
select * from emp_copy where deptno=30 with read only;
select * from view_read30;
update view_read30 set ename='홍길동'  where deptno=30;
insert into view_read30(empno,ename) values(1020,'김명수');
delete from view_read30 where deptno=30;

create or replace view view_hire
as
select empno, ename, hiredate from emp order by hiredate;

create or replace view view_hire
as
select rownum,empno,ename,hiredate from view_hire where rownum<=5;


--인라인 뷰란? 
--SQL문 내부에 뷰를 정의하고 이를 테이블처럼 사용하는 것
--다른 쿼리에서 사용할 필요 없이 해당 SQL에서만 필요한 VIEW일 경우 번거럽게 뷰를 생성하지 말고
--SQL 문장의 FROM 절에 view의 서브쿼리를 바로 적어서 사용하는 것

--문 emp, dept테이블을 조회하여 부서번호와 부서별 최대급여 및 부서명을 출력하기
SELECT  e.deptno, d.dname, e.sal FROM (Select deptno, max(sal) sal from emp group by deptno) e, dept d;

--문 인라인 뷰로 입사일이 빠른 사람 5명만 출력하기
select rownum, ve.empno, ve.ename, ve.hiredate 
    from (select empno, ename, hiredate from emp order by hiredate) ve
    where rownum<=5;
--1단계 뷰로 만든다
create view vv
as
select empno, ename, hiredate from emp order by hiredate;

--2단계 뷰에서 검색한다
select rownum, empno,ename,hiredate 
    from vv
    where rownum<=5;
--> 인라인 뷰
select rownum, empno,ename,hiredate 
    from (select empno, ename, hiredate from emp order by hiredate)
    where rownum<=5;
    
--1. 사원 테이블을 기본 테이블로 하여 부서별 최대 급여와 최소급여을 출력하는 뷰를 SAL_VIEW란 이름으로 작성하시오
select * from emp;
select * from dept;

create or replace view sal_view
as
select d.dname,max(e.sal) as "max_sal",min(e.sal) as "min_sal" from emp e,dept d where e.deptno = d.deptno group by d.dname;

select * from sal_view;
--2. 인라인 뷰를 사용하여 급여를 많이 받는 순서대로 3명만 출력하시오
select rownum as RANKING,empno,ename,sal
    from (select empno, ename, sal from emp_copy where sal is not null order by sal desc)
    where rownum<=3;
--3. professor테이블과 department테이블을 조인하여 교수번호와 교수이름, 소속 학과이름을 조회하는 view를 생성하시오. view 이름은 v_prof_dept2로 하세요
create or replace view v_prof_dept2
as
select p.profno,p.name,d.dname from professor p, department d where p.deptno = d.deptno;

select * from v_prof_dept2;
--4. inline view를 사용하여 student테이블과 departmant테이블을 사용하여 학과별로 학생들의 최대키와 최대 몸무게, 학과 이름을 출력하세요.
select * from student;

select s.max_height,s.max_weight,d.dname
    from(select deptno1,max(height) as max_height,max(weight) as max_weight from student
    group by deptno1)s, department d
    where s.deptno1 = d.deptno;
--5. student테이블과 departmemt테이블을 사용하여 학과 이름, 학과별 최대키, 학과별로 가장 키가 큰 학생들의 이름과 키를 inline view를 사용하여 출력하세요.
select d.dname, a.max_height, s.name, s.height
    from (select deptno1, max(height) as max_height from student group by deptno1) a,
    student s, department d where s.deptno1 = a.deptno1 and s.height = a.max_height and s.deptno1 = d.deptno;
--6. student테이블에서 학생의 키가 동일 학년의 평균 키보다 큰 학생들의 학년과 이름 키, 해당 학년의 평균키를 출력하되 inline view를 사용해서 출력하세요.(학년 컬럼으로 오름차순 정렬해서 출력하세요)
select s.grade, s.name, s.height, a.avg_height
    from(select grade,avg(height) as avg_height from student group by grade)a,student s
    where a.grade = s.grade and s.height > a.avg_height order by grade; --order by grade,a.grade,s.grade 다 가능    
--7. professor테이블을 조회하여 교수들의 급여 순위와 이름과 급여을 출력하시오. 단 급여 순위는 급여가 많은 사람부터 1~5위까지 출력하세요
select rownum as ranking,name,pay
    from(select name,pay from professor order by 2 desc)
    where rownum<=5;
--8. 교수 테이블을 교수 번호로 정렬하되 3건씩 분리해서 급여 합계와 급여 평균을 출력하세요
select num,profno,name,pay,sum(pay),round(avg(pay),1)
    from(select profno, name, pay, rownum num from professor)
    group by ceil(num/3), rollup((profno,name,pay,num))
    order by ceil(num/3);

--ROLLUP 함수
--ROLLUP에 지정된 Grouping Columns 의 List 는 Subtotal 을 생성하기 위해 사용되어집니다.
--Grouping Columns 의 수를 N 이라고 했을 때 N + 1 Level 의 Subtotal 이 생성됩니다.

--표준 집계 전체 행에 대해서
SELECT dname, job, count(*), sum(sal) from emp, dept
   where dept.deptno = emp.deptno group by dname, job;

-- dname별로 모든 job의 subtotal  
SELECT dname, job, count(*), sum(sal) from emp, dept
   where dept.deptno = emp.deptno group by dname, job
    order by dname, job;

--그룹별로 subtotal을 구할 수 있다. 
SELECT dname, job, count(*), sum(sal) from emp, dept
   where dept.deptno = emp.deptno group by rollup(dname, job);   
