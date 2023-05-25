use shopdb;

create table tbl_copy_buytbl(select * from buytbl);

select * from tbl_copy_buytbl;
desc tbl_copy_buytbl;

delete from tbl_copy_buytbl where num>=6;

insert into tbl_copy_buytbl(num,userid,prodname,groupname,price,amount) values(8,'aaa','운동화','의류',1000,2),(9,'bbb','운동화','의류',1000,2),(10,'ccc','운동화','의휴',1000,2),(11,'ddd','운동화','의휴',1000,2);

select * from tbl_copy_buytbl;

-- 02 insert 시 auto_increment

create table tbl_test
(

id int primary key auto_increment,
name varchar(20),
addr varchar(100)
);

desc tbl_test;

insert into tbl_test(id,name,addr) values(null,'홍길동','대구');
select * from tbl_test;

delete from tbl_test;

-- auto_increment 초기화
alter table tbl_test auto_increment=0;
commit;
insert into tbl_test(id,name,addr) values(null, '홍길동','대구');
select * from tbl_test;