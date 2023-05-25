-- 예외발생

use shopdb;
select * from usertbl;
select * from notbl;
select * from buytbl;
insert into usertbl values(1);


delimiter $$
create procedure exception_Test01()
begin

	declare continue handler for 1146 select '해당 테이블이 없는데스' as 'Error_msg';
	select * from usertbl;
	select * from notbl;
	select * from buytbl;

end $$
delimiter ;

call exception_Test01();

delimiter $$
create procedure exception_Test02()
begin

	declare continue handler for 1146 select '해당 테이블이 없는데스' as 'Error_msg';
    declare continue handler for 1136 select 'Insert시 value의 column이 다른데스' as 'Error_msg';
	select * from usertbl;
	select * from notbl;
	select * from buytbl;
    insert into usertbl values(1);
    select 'Result' as '끗';

end $$
delimiter ;

call exception_Test02();

-- 03 모든 예외 받기
delimiter $$
create procedure exception_Test03()
begin
	declare continue handler for sqlexception select '예외가 발생 했는데스' as 'Error_msg';
    
	select * from usertbl;
	select * from notbl;
	select * from buytbl;
    insert into usertbl values(1);
    select 'Result' as '끗';

end $$
delimiter ;

call exception_Test03();

-- 04 예외코드 확인
delimiter $$
create procedure exception_Test04()
begin
	declare continue handler for sqlexception
		begin
			show errors;
		end;
	select * from usertbl;
	select * from notbl;
	select * from buytbl;
    insert into usertbl values(1);
    select 'Result' as '끗';

end $$
delimiter ;

call exception_Test04();

-- 05 Error_log 기록하는 테이블 처리

create table tbl_std(id varchar(2) primary key,name char(10),age int);
create table tbl_std_errlog(error_date datetime, error_code int , error_msg text);

show errors;

delimiter $$
create procedure tbl_std_proc(in id varchar(20),in name char(10),in age varchar(10))
begin
	-- PK 중복 예외 처리
declare error_code varchar(5);
declare error_message varchar(255);
	declare continue handler for 1062
		begin
			show errors;
            get diagnostics condition 1
				error_code = mysql_errno,
                error_message = message_text;
			-- select error_code,crror_message;
            insert into tbl_std_errlog values(now(),error_code,error_message);
        end;
        
	-- exception code 1265
	declare continue handler for 1265
        begin
			show errors;
            get diagnostics condition 1
				error_code = mysql_errno,
                error_message = message_text;
			-- select error_code,crror_message;
            insert into tbl_std_errlog values(now(),error_code,error_message);
            set age=0;
            insert into tbl_str values(id,ame,age);
        end;
        
 	insert into tbl_std values(id,name,age); 
    select * from tbl_std;
end $$
delimiter ;

call tbl_std_proc('aa','홍길동',10);
call tbl_std_proc('bb','남길동',20);
call tbl_std_proc('cc','홍길동','5-');
select * from tbl_std;
select * from tbl_std_errlog;
show errors;


-- 프로시저(예외처리 + 트랜잭션)



delete from tbl_std;
drop procedure tbl_std_proc_tx;

delimiter $$
create procedure tbl_std_proc_tx()
begin
	declare exit handler for SQLEXCEPTION
    begin
		show errors;
		rollback;
    end;
    
	start transaction;
		insert into tbl_std values('f','hoho',11);
		insert into tbl_std values('g','hoho',12);
		insert into tbl_std values('f','hoho',13);
		insert into tbl_std values('i','hoho',14);
        commit;
	select * from tbl_std;
        
end $$
delimiter ;

call tbl_std_proc_tx();

select * from tbl_std;