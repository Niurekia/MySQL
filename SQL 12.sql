use shopdb;

delimiter $$
create procedure while01()

begin
-- 탈출/조건식에 사용되는 변수 선언&초기값 설정
	declare i int;
    set i=1;
    -- 반복에 사용되는 조건식(i<=10) 지정
	while i<=10 do
		select 'hello world';
        set i=i+1; -- 반복문을 벗어나기 위한 연산처리
    end while;
end $$;
delimiter ;

call while01;


-- while02

create table tbl_googoodan(dan int,i int, result int);

delimiter $$
create procedure while02()
begin
	declare dan int;
    declare i int;
    set dan = 2;
    set i=1;
    while i<=9 do
		insert into tbl_googoodan values(dan,i,dan*i);
		set i=i+1;
    end while;
end $$
delimiter ;
call while02();
select * from tbl_googoodan;

-- while 03
drop procedure while03;
delimiter $$
create procedure while03(in d int)
begin
    declare i int;
    set i=1;
    insert into tbl_googoodan(dan) values(d);
    while i<=9 do
		insert into tbl_googoodan values(d,i,d*i);
		set i=i+1;
    end while;
end $$
delimiter ;

delete from tbl_googoodan;
call while03(9);
select * from tbl_googoodan;

-- 2단 9단까지 저장
-- 오름차순 구구단 or 내림차순 구구단