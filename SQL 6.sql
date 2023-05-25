create table if not exists tbl_test(
	no int primary key,
    name varchar(20),
    age int,
    gender char(1)
);
delete from tbl_test;
insert into tbl_test values(1,'aa',66,'M');
insert into tbl_test values(2,'bb',66,'M');
insert into tbl_test values(3,'cc',66,'M');
select * from tbl_test;
commit;


START TRANSACTION;
savepoint s1;
	insert into tbl_test values(4,'dd',66,'M');
	insert into tbl_test values(5,'ee',66,'M'); 
	insert into tbl_test values(6,'ff',66,'M'); 
    rollback to s1;
    savepoint s2;
    insert into tbl_test values(7,'gg',66,'M');
	insert into tbl_test values(8,'hh',66,'M');
    savepoint s3;
	insert into tbl_test values(9,'ii',66,'M');
    insert into tbl_test values(10,'jj',66,'M');
    
select * from tbl_test;
rollback to s2;





-- select * from tbl_test;

-- DELIMITER $$
-- create procedure TX_Test()
-- begin
-- 	declare continue handler for SQLEXCEPTION
--     begin
-- 		show errors;
--     end;
--     insert into tbl_test values(6,'aa',66,'M');
--     insert into tbl_test values(7,'bb',66,'M');
--     insert into tbl_test values(8,'cc',66,'M');
-- end $$
-- DELIMITER ;


-- call TX_Test();
-- show procedure status;