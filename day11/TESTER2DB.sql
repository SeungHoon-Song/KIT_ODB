--현재 사용자의 객체에 부여한 객체 권한
select * from user_tab_privs_made;

--현재 사용자의 객체에 부여된 객체 권한
select * from user_tab_privs_recd;

select sysdate, to_char(sysdate,'yyyy-mm-dd') from dual;