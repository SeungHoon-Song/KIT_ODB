select * from member;
INSERT INTO member (name,age,weight,height,sex) VALUES('����',10,65,175,'��');

DELETE FROM member where name = '�����';

UPDATE member SET age=18,weight=165,height=45,sex='��' WHERE name='������';

select * from member WHERE name = '������';

commit;