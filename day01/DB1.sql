show user;
-- 오라클 사용자계정
CREATE USER test1 IDENTIFIED BY test1234;

-- 역할 부여하기
GRANT connect, resource TO test1;
