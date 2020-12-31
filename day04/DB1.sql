select * from member;
INSERT INTO member (name,age,weight,height,sex) VALUES('김경미',10,65,175,'여');

DELETE FROM member where name = '김명자';

UPDATE member SET age=18,weight=165,height=45,sex='여' WHERE name='유관순';

select * from member WHERE name = '유관순';

commit;