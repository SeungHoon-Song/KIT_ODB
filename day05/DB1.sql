SELECT table_name from user_tables;
--데이터베이스 관리자만 접근 가능한 객체, system이상(sys, dba)의 계정
select owner, table_name from dba_tables;