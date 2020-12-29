-- 부서 테이블 생성하기
CREATE TABLE dept(  deptno number(2) CONSTRAINT PK_DEPT PRIMARY KEY,
                    dname varchar2(14), 
                    loc varchar2(13) );
-- 사원테이블 생성하기                  
CREATE TABLE emp ( empno number(4) CONSTRAINT PK_EMP PRIMARY KEY,
                   ename varchar2(10),
                   job varchar2(9),
                   mgr number(4),
                   hiredate date,
                   sal number(7,2), 
                   comm number(7,2),
                   deptno number(2) CONSTRAINT FK_PK_DEPTNO REFERENCES PK_DEPT );
                   
-- 급여테이블 생성하기
-- grade 등급, losal 급여 하한값 hisal 급여상한값
CREATE TABLE salgrade(  grade number, losal number, hisal number);

-- 부서 테이블에 샘플 데이터 넣기
INSERT INTO dept (deptno, dname, loc) VALUES (10,'경리부','서울');
INSERT INTO dept (deptno, loc, dname) VALUES (20, '인천', '인사부');
INSERT INTO dept VALUES (30,'영업부','용인');
INSERT INTO dept VALUES (40,'전산부','수원');

-- 부서테이블안에 있는 레코드(행)을 검색하기
SELECT * FROM dept;

-- 사원 테이블 자료 삽입하기
INSERT INTO emp VALUES(1001, '김사랑', '사원', 1013, TO_DATE('2007-03-01','yyyy-mm-dd'),3000,NULL,20);
INSERT INTO EMP VALUES(1002, '한예슬', '대리', 1005, to_date('2007-04-02','yyyy-mm-dd'), 250,   80, 30);
INSERT INTO EMP VALUES(1003, '오지호', '과장', 1005, to_date('2005-02-10','yyyy-mm-dd'), 500,  100, 30);
INSERT INTO EMP VALUES(1004, '이병헌', '부장', 1008, to_date('2003-09-02','yyyy-mm-dd'), 600, NULL, 20);
INSERT INTO EMP VALUES(1005, '신동협', '과장', 1005, to_date('2005-04-07','yyyy-mm-dd'), 450,  200, 30);
INSERT INTO EMP VALUES(1006, '장동건', '부장', 1008, to_date('2003-10-09','yyyy-mm-dd'), 480, NULL, 30);
INSERT INTO EMP VALUES(1007, '이문세', '부장', 1008, to_date('2004-01-08','yyyy-mm-dd'), 520, NULL, 10);
INSERT INTO EMP VALUES(1008, '감우성', '차장', 1003, to_date('2004-03-08','yyyy-mm-dd'), 500,    0, 30);
INSERT INTO EMP VALUES(1009, '안성기', '사장', NULL, to_date('1996-10-04','yyyy-mm-dd'),1000, NULL, 20);
INSERT INTO EMP VALUES(1010, '이병헌', '과장', 1003, to_date('2005-04-07','yyyy-mm-dd'), 500, NULL, 10);
INSERT INTO EMP VALUES(1011, '조향기', '사원', 1007, to_date('2007-03-01','yyyy-mm-dd'), 280, NULL, 30);
INSERT INTO EMP VALUES(1012, '강혜정', '사원', 1006, to_date('2007-08-09','yyyy-mm-dd'), 300, NULL, 20);
INSERT INTO EMP VALUES(1013, '박중훈', '부장', 1003, to_date('2002-10-09','yyyy-mm-dd'), 560, NULL, 20);
INSERT INTO EMP VALUES(1014, '조인성', '사원', 1006, to_date('2007-11-09','yyyy-mm-dd'), 250, NULL, 10);
INSERT INTO EMP VALUES(1017, '조이서', '사원', 1006, to_date('2020-12-29','yyyy-mm-dd'), 250, NULL, 10);
--comm이 null
INSERT INTO EMP VALUES(1018, '조이서', '사원', 1006, to_date('2020-12-29','yyyy-mm-dd'), 250, NULL, 10);
--날짜가 null
INSERT INTO EMP VALUES(1019, '조이서', '사원', 1006, null, 250, NULL, 10);
--문자가 null
INSERT INTO EMP VALUES(1020, NULL, '사원', 1006, to_date('2020-12-29','yyyy-mm-dd'), 250, NULL, 10);
INSERT INTO EMP VALUES(1021, '조이서', NULL, 1006, to_date('2020-12-29','yyyy-mm-dd'), 250, NULL, 10);

select comm, nvl(comm,0) from emp;
select hiredate, nvl(hiredate, to_date(sysdate, 'yyyy/mm/dd')) from emp;

select ename,nvl(ename,'홍길동'), job, nvl(job,'사원')from emp;

--nvl2 함수
select ename, sal, comm, nvl2(comm, sal*12+comm, sal*12) 연봉 from emp;
--nullif 함수
select nullif('a','a'), nullif('c','b') from dual;  --같으면 null, 다르면 첫번째 반환
select coalesce(NULL,'a','b','c','d') from dual;

select ename, deptno, decode(deptno,10,'경리부',
                                    20,'인사과',
                                    30,'영업부',
                                    40,'전산부') dname from emp;
                                    
select ename, deptno,
    case when deptno = 10 then '경리부'
        when deptno = 20 then '인사부'
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

SELECT DISTINCT job as 직위 FROM emp;

SELECT sal as 본봉, sal*0.03 as 세금 FROM emp;

SELECT ename, comm, sal*12+comm as 연봉, NVL(comm,0),sal*12+NVL(comm,0) FROM emp;

-- || Concatentation 연산자 사용하여서 컬럼 연결할 수 있다. 
SELECT ename || '의 직급은 ' || job || '입니다.' as 직급 from emp;

-- where절 
select * from emp;
-- 숫자 검색
select * from emp where sal>=500;

select * from emp where deptno <> 10;
-- 문자 검색
select * from emp where ename='한예슬';
-- 날짜 검색    2005년 1월 1일 이전에 입사한 사람
select * from emp where hiredate < TO_DATE ('2005/01/01','yyyy/mm/dd');
select * from emp where hiredate >= TO_DATE ('2005/01/01','yyyy/mm/dd');

-- 부서번호가 10이고 직급이 과장인 사람의 이름만
select ename from emp where deptno=10 and job = '과장';
select * from emp where not deptno=10 or job = '과장';
-- 급여가 400~500인 경우 and
select * from emp where sal>=400 and sal<=500;
-- 급여가 400미만이거나 500초과인 경우
select * from emp where sal<400 or sal>500;
-- 컬럼명 between 숫자1 and 숫자2  : 컬럼명이 숫자1과 숫자2사이에 있으면 참
-- 급여가 400~500인 경우 and
select * from emp where sal>=400 and sal<=500;
select*from emp where sal between 400 and 500;
-- in ~안에
-- comm이 80이거나 100이거나 200인 사원
select * from emp where comm=80 or comm=100 or comm=200;
select * from emp where comm in(80,100,200);

-- in ~안에
-- comm이 80아니거나 100아니거나 200 아닌 사원
select * from emp where comm != 80 and comm !=100 and comm !=200;
select * from emp where comm not in(80,100,200);

-- 유사일치 비슷하게 일치하는 것 검색 like
-- 와일드 카드 :     % : 문자가 없거나 하나 이상의 어떤 문자가 와도 상관없다.
--                  _ : 하나의 문자가 어떤 값이 와도 상관없다.

select * from emp where ename like '%이%';
select * from emp where ename like '__성';

-- job에서 '사'로 시작하는 것만 찾기
select * from emp where job like '사%';

-- job에서 '사'로 시작하지 않는 사람 찾기
select * from emp where job not like '사%';
-- 성이 이씨가 아닌 사람 찾기
select * from emp where ename not like '이%';

-- comm이 NULL인 사람 찾기
-- select * from emp where comm like null; (X)
select * from emp where comm is null;
-- 사원중에서 급여 오름차순 정렬
select * from emp where job='사원' order by sal;

-- 최근에 입사한 사람 순서대로 조건 사장을 제외한
select * from emp where job !='사장' order by hiredate desc;

-- 사원 이름과 급여 입사일자만 출력하기
select ename, sal ,hiredate from emp;
-- 부서번호는 dno로 부서명은 dname은 '부서명'으로 별칭(as)를 붙여서 출력하세요(부서테이블)
select empno as dno, ename as 부서명 from emp;
-- 사원테이블에 존재하는 직급의 종류만 출력해 보세요.
select distinct job from emp;
-- 급여가 300이하인 사원의 사원번호, 사원이름, 급여를 출력하세요
select empno, ename,sal from emp where sal<=300; 
-- 이름이 '오지호'인 사원의 사원번호, 사원명, 급여를 출력하세요
select empno, ename, sal from emp where ename = '오지호';
-- 급여가 250이거나 300이거나 500인 사원들의 사원번호, 사원명, 급여를 출력
select empno, ename, sal from emp where sal=250 or sal=300 or sal=500;
-- 급여가 250도 300도 500도 아닌 사원들을 검색하세요
select * from emp where sal not in(250,300,500);
-- 사원중에는 이름이 '김'으로 시작하는 사람과 이름중에 '기'를 포함하는 사원의 사원번호와 사원이름을 출력하세요
select empno,ename from emp where ename like '김%' or ename like'%기%';
-- 상급자가 없는 사원을 검색하세요
select * from emp where mgr is null;
-- 사원테이블의 자료를 입사일 기준으로 정렬하여 최근에 입사한 직원을 가장 먼저 출력하세요(단, 사원번호,사원명,직급,입사일) 출력
select empno,ename,job,hiredate from emp order by hiredate desc;
-- 부서번호가 빠른 사원번호부터 출력하되 같은 부서 내의 사원을 출력할 경우 입사한지 가장 오래된 사원부터 출력하세요
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

-- 합집합
select * from group_star UNION select * from single_star;   --중복 한번만
select * from group_star UNION all select * from single_star;

-- 교집합
select * from group_star INTERSECT select * from single_star;

-- 차집합
select * from group_star minus select * from single_star;

-- 3장 오라클 함수
select 24*60 from dual; --마땅히 쓸 테이블 없을때 dual
select * from dual;
select power(2,3) from dual; --2^3

select round(2.56,1) from dual; --소수점 한자리까지 반올림

select mod(10,3) from dual; --나머지

select 'Welcome to Oracle', upper('Welcome to Oracle'), lower('Welcome to Oracle'),
        initcap('Welcome to Oracle') from dual;
        
select length('Welcome to Oracle') from dual;

select lengthb('Welcome to Oracle 한글') from dual;  --바이트수

select concat('ab') from dual;  --합치기

select substr('Welcome to Oracle',2,3) from dual;   --2번째부터 3자만큼
select substrb('Welcome to Oracle',2,3) from dual;
select substr('안녕하세요!',2,3) from dual;
select substrb('가나다라마바',7,6) from dual;    --한글은 3바이트

select instr('데이터베이스','이',4,1) from dual; --instr은 한글한글자1바이트 / 대상,찾는글자,시작위치,몇번째 
select instrb('데이터베이스이','이',4,2) from dual;

-- 날짜형 <-> 문자형
select sysdate, to_char(sysdate,'yyyy-mm-dd, AM HH:MI:SS') from dual;   --sysdate 현재날짜
select to_date('2020/12/29','yyyy-mm-dd') from dual;

-- 숫자형 <-> 문자형
select to_char(1234567890100,'L999,999,999.00') from dual;
select to_number('542') - to_number('500') from dual;
select to_char(542) from dual;

-- 날짜
select to_char(sysdate,'yyyy-mm-dd') from dual;
select to_char(hiredate, 'yyyy/mm/dd') as 입사일1,
    to_char(trunc(hiredate, 'MONTH'),'yyyy/mm/dd') 입사일2,
    to_char(round(hiredate, 'MONTH'), 'yyyy/mm/dd') 입사일3,
    to_char(round(hiredate, 'D'), 'yyyy/mm/dd') 입사일4
    from emp;

select ename, sysdate 오늘, to_char(hiredate,'yyyy/mm/dd') 입사일,
        trunc(Months_between(sysdate, hiredate)) 근무일수 from emp;
        
select ename, hiredate,to_char(add_months(hiredate,6), 'yyyy/mm/dd') 입사6개월후 from emp;

select to_char(sysdate, 'yyyy/mm/dd') 오늘,
        to_char(next_day(sysdate, 2),'yyyy/mm/dd') 일요일  --시스템 국가형식따라 Wendesday 오류
        from dual;

select ename, to_char(hiredate,'yyyy/mm/dd') 입사일,
        to_char(last_day(hiredate),'yyyy/mm/dd') 마지막날짜
        from emp;
        
select * from emp;
--9월에 입사한 사원을 출력해 보세요 (SUBSTR)함수를 사용한다.
select * from emp where substr(hiredate,4,2)=09;
--2003년도에 입사한 사원을 알아내기 위한 쿼리문은 다음과 같이 작성할 수 있습니다
select * from emp where substr(hiredate,1,2)=03;
-- 다음은 이름이 '기'로 끝나는 사람을 검색해 보도록 합시다.
select * from emp where substr(ename,length(ename)) = '기';
-- 이번에는 이름의 두번째 글자에 '동'이 있는 사원을 검색해 보세요
select * from emp where substr(ename,2,1)='동';

-- 직급에 따라 급여를 인상하도록 합시다. 직급이 '부장'인 사원은 5%, '과장'인 사원은 10%, 
--'대리'인 사원은 13%, '사원'인 사원은 20%인상합니다.
select ename, job, sal,decode(job,'부장',sal+sal*0.05,
                            '과장',sal+sal*0.1,
                            '대리',sal+sal*0.13,
                            '사원',sal+sal*0.2,
                            '사장',sal) 인상급여 from emp;
--입사일 연도는 2자리(YY), 월은 숫자(MON)으로 표시하고, 요일은 약어(DY)로 지정하여 출력하시오.
select ename,to_char(hiredate,'yy')입사일연도,
                to_char(hiredate,'mm')입사월,
                to_char(hiredate,'dy')요일 from emp;
select hiredate, to_char(hiredate, 'yy/mon/dd dy') from emp;

select sal, round(sal,-2) from emp;

--round(숫자, 반올림하여 나오는 자리수) round(sal,3) 12300.7876 -round(sal,3)-> 12300.788
select round(12300.7876,-3) from dual;

--그룹함수  count는 null은 제외하고 
select count(job) from emp;
--select ename, max(sal) from emp;(X)   부속질의어를 사용하여서 구함
select * from emp;

--부분합
select deptno,sum(sal) from emp group by deptno;
select deptno,sum(sal) from emp where job='사원' group by deptno;
-- 2000~2003사이 입사한 사람
select job,sum(sal) from emp where substr (hiredate,1,2) in('00','01','02','03') group by job;

select deptno, avg(sal),max(sal),min(sal) from emp 
    where job='부장'
    group by deptno 
    having avg(sal) >= 400  --having은 group by에 대한 조건
    order by deptno;


--모든 사원의 급여최고액, 최저액, 총액 및 평균 급여를 출력하시오. 평균에 대해서는 정수로 반올림하시오
select max(sal) Maximum,min(sal) Minimum,sum(sal) Sum,round(avg(sal)) Average from emp;
--count(*)함수를 이용하여 담당 업무별 사원수를 출력하시오
select job,count(*) from emp group by job order by job asc; --count(*)은 임의의 컬럼
--과장 수를 나열하시오
select count(*) from emp where job = '과장';
--급여 최고액, 급여 최저액의 차액을 출력하시오.
select max(sal),min(sal), max(sal)-min(sal)as 차액 from emp;
--직급별 사원의 최저 급여을 출력하시오. 최저 급여가 500미만인 그룹은 제외시키고, 결과를 급여에 대한 내림차순으로 정렬하여 출력하시오
select job,min(sal) from emp group by job having min(sal)>=500 order by min(sal) desc;
--각 부서에 대한 부서번호, 사원수, 부서내의 모든 사원 평균 급여를 출력하시오. 평균 급여는 소수점 둘째자리로 반올림하시오
select deptno,count(*),round(avg(sal),1) from emp group by deptno order by deptno;
--각 부서에 대해 부서번호 이름, 지역명, 사원수, 부서 내의 모든 사원의 평균 급여를 출력하시오.
--평균 급여는 정수로 소수점 둘째 자리로 반올림하시오.
select deptno,decode(deptno,10,'경리부',
                     20,'인사부',
                     30,'영업부',
                     40,'전산부')as dname,
        decode(deptno,10,'서울',
                      20,'인천',
                      30,'용인',
                      40,'수원')as 지역,
                count(*),round(avg(sal),1) from emp group by deptno order by deptno;












