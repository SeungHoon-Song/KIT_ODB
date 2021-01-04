CREATE TABLE employee (emp_no number(4) PRIMARY KEY,
                        emp_name varchar2(20) not null,
                        salary number(6),
                        birthday date);

drop table employee;

CREATE TABLE employee (emp_no number(4) not null,
                        emp_name varchar2(20) not null,
                        salary number(6),
                        birthday date,
                        CONSTRAINT employee_PK PRIMARY KEY(emp_no));
drop table specialty;

--specialty 테이블 만들기
--2개의 primary key 갖을 경우 (오라클에서 일부 지원)
CREATE TABLE specialty (emp_no Number(4) not null,
                        specialty varchar2(20) not null,
                        CONSTRAINT specialty_PK PRIMARY KEY(emp_no, specialty),
                        CONSTRAINT specialty_FK FOREIGN KEY(emp_no) REFERENCES employee(emp_no));

--project 테이블 만들기
CREATE TABLE project (pro_no number(4) not null,
                    pro_content varchar2(100) not null,
                    start_date date,
                    finish_date date,
                    CONSTRAINT project_PK PRIMARY KEY(pro_no));
desc project;                 
--assign 테이블 만들기    
CREATE TABLE assign (emp_no number(4) not null,
                    pro_no number(4) not null,
                    CONSTRAINT assign_PK PRIMARY KEY(emp_no,pro_no),
                    CONSTRAINT assign_FK FOREIGN KEY(emp_no) REFERENCES employee(emp_no),
                    CONSTRAINT assign_FK1 FOREIGN KEY(pro_no) REFERENCES project(pro_no));
desc assign;

--ppt 107
CREATE TABLE emp01(
        empno number(4),
        ename varchar2(14),
        sal number(7,3));
        
--만든 테이블의 구조 보기
desc emp01;

--테이블 수정하기(추가-add, 변경-modify, 삭제-drop column)
--테이블의 컬럼을 추가하기

alter table emp01
    add (birth date);
    
ALTER TABLE emp01
    ADD(memo varchar2(100));
    
--테이블 컬럼 변경하기
ALTER TABLE emp01
    MODIFY(ename varchar2(30));
DESC emp01;

--memo를 50으로 변경하기
ALTER TABLE emp01
    modify(memo varchar2(50));
desc emp01;

--sal number(5)로 변경하기
ALTER TABLE emp01
    MODIFY(sal number(5));
desc emp01;

--테이블의 컬럼을 삭제하기
ALTER TABLE emp01
    DROP COLUMN memo;

ALTER TABLE emp01
    DROP COLUMN birth;

ALTER TABLE emp01
    SET UNUSED (empno);
desc emp01;
ALTER TABLE emp01
    DROP UNUSED COLUMNS;

--테이블명을 RENAME
RENAME emp01 TO emp02;

desc emp02;

--테이블 지우기
drop table emp02;

INSERT INTO emp02(ename,sal) VALUES('홍길동',100);
INSERT INTO emp02(ename,sal) VALUES('홍길동2',200);

SELECT * FROM emp02;

--테이블의 자료(레코드) 지우기
TRUNCATE TABLE emp02;
desc emp02;

--데이터 딕셔너리
SELECT table_name from USER_TABLES;

SELECT owner,table_name from ALL_tables;
--오라클 데이터베이스의 모든 테이블의 정보를 볼 수 있다.
select * from all_tables;

--1. 다음 표에 명시된 대로 dept_mission테이블을 생성하기
CREATE TABLE dept_mission(DNO number(2),
                        DNAME varchar2(14),
                        LOC varchar2(13));
desc dept_mission;
--2. 다음 표에 명시된 대로 emp_mission 테이블을 생성하기
CREATE TABLE emp_mission(ENO number(4),
                        ENAME varchar2(10),
                        DNO number(2));
desc emp_mission;
--3. 긴 이름을 저장할 수 있도록 emp_mission 테이블을 수정하시오
ALTER TABLE emp_mission
    modify(ENAME varchar(50));
--4. emp_mission 테이블을 제거(삭제)하시오
DROP TABLE emp_mission;
desc emp_mission;
--5. dept_mission 테이블에서 DNAME 컬럼을 제거하시오
ALTER TABLE dept_mission
    DROP COLUMN DNAME;
desc dept_mission;
--6. dept_mission테이블에서 LOC컬럼을 UNUSED로 표시하시오
ALTER TABLE dept_mission
    SET UNUSED (LOC);
desc dept_mission;
--7. dept_mission 테이블에서 UNUSED컬럼을 제거하시오
ALTER TABLE dept_mission
    DROP UNUSED COLUMNS;
--8. dept_mission을 depatrment란 이름으로 변경하시오
RENAME dept_mission to department;
desc department;