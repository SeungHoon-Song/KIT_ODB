--테이블 만들기
create table member(
        name varchar2(10) primary key,
        age number(3),
        weight number(3),
        height number(3),
        sex char(3));
drop table member;

--데이터 삽입
insert into member values('유관순',17,50,160,'여');
insert into member values('홍길동',20,60,175,'남');
insert into member values('이순신',20,60,180,'남');
insert into member values('이영미',30,55,165,'여');


insert into member values(?,?,?,?,?);
--데이터베이스에 확정(저장)
commit;

select * from member;
--"INSERT INTO member (name,age,height,weight,sex) VALUES(?,?,?,?,?)";
commit;