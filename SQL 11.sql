use shopdb;

delimiter $$
create procedure proc1()
begin
 -- 변수 선언
	declare var1 int;
    set var1 = 100;
    if var1 = 100 
		then select 'var1 은 100입니다 ';
    else
		select 'var1 은 100이 아닙니다 ';
	end if;
    
end $$

delimiter ;


show procedure status;
show create procedure proc1;

call proc1();


-- 02
delimiter $$
create procedure proc2(in param int)
begin
 -- 변수 선언
	
    if param = 100 
		then select 'param 은 100입니다 ';
    else
		select 'param 은 100이 아닙니다 ';
	end if;
    
end $$

delimiter ;

call proc2(100);

-- 03

select * from buytbl;

delimiter $$
create procedure proc3(in amt int)
begin
 -- 변수 선언
	
    select * from buytbl where amount >=amt;
    
end $$

delimiter ;

call proc3(3);


-- 04

delimiter $$
create procedure proc4()
begin
 -- 변수 선언
	declare avg_amount int;
    set avg_amount=(select avg(amount) from buytbl);
    select *,if(amount>=avg_amount,'평균이상','평균이하') as '구매량 평균' from buytbl;
    
end $$

delimiter ;

call proc4();

-- 05
-- usertbl에서 출생년도를 입력받아 해당 출생년도보다 나이가 많은 항만 출력
-- birthyear열을 이용
-- 프로시저명 : older (in param int)

delimiter $$
create procedure older(in b_y int)
begin
 select * from usertbl where birthyear>=b_y;
	
    
end $$

delimiter ;
call older(1900);

-- 06 근태일 , 가입일로부터 지난일 구하기

select curdate(); -- 현재 날짜
select now();	-- 현재 날짜 시간
select curtime();	-- 현재 시간
select *,ceil(datediff(curdate(),mDate)/365) from usertbl;

-- 가입한지 12년이 초과한 user는 삭제

select *,if((ceil(datediff(curdate(),mDate)/365))>12,'삭제','유지') from usertbl;

create table c_usertbl(select *from usertbl);
select * from usertbl;

delimiter $$

create procedure delete_user(in del int)
begin
	select *,if((ceil(datediff(curdate(),mDate)/365))>12,'삭제','유지') from usertbl;
	delete from c_usertbl where ceil(datediff(curdate(),mDate)/365)>del;
    
end $$

delimiter ;

call delete_user(12);
select *from c_usertbl;



select mdate,year(mdate),month(mdate),day(mdate) from usertbl;

select mdate,birthyear,year(curdate()) from usertbl;

-- 0000년을 기준으로 현재 까지의 일수
select to_days(curdate());

-- 만 나이 계산 ('YYYY-MM-DD')
select *, DATE(CONCAT(birthyear, '-01-01')) from usertbl; 
select *,to_days( DATE(CONCAT(birthyear, '-01-01')) ) from usertbl;

select *,((to_days(curdate()) - to_days( DATE(CONCAT(birthyear, '-01-01'))))/365) from usertbl;
select *,
ceil((to_days(curdate()) - to_days( DATE(CONCAT(birthyear, '-01-01'))))/365) as '나이(만)' 
from usertbl;

-- 07 나이 계산
-- ceil : 올림, round : 반올림 floor : 내림
delimiter $$
create procedure add_age()
begin
	select U.userid,name,birthyear,prodname,price*amount,
    floor((to_days(curdate()) - to_days( DATE(CONCAT(birthyear, '-01-01'))))/365) as '나이(만)' 
    from usertbl U
	inner join buytbl B
	on U.userid=B.userid;
end$$

delimiter ;
call add_age();

-- 08 두개 인자 받기
delimiter $$
create procedure proc08(in b int,in h int)
begin
	select * from usertbl where birthYear>=b and height>=h;
end $$

delimiter ;

call proc08(1950,170);

-- 09

-- select *, 
-- case 
-- 	when amount>=10 then 'VIP'
--     when amount>=5 then '우수고객'
--     when amount>=1 then '일반고객'
--     else '구매없음'
-- end as 'Grade'
-- from buytbl;

delimiter $$

create procedure proc09(in n1 int,in n2 int,in n3 int)
begin
	select *, 
case 
	when amount>=n1 then 'VIP'
    when amount>=n2 then '우수고객'
    when amount>=n3 then '일반고객'
    else '구매없음'
end as 'Grade'
from buytbl;
end $$;

delimiter ;

call proc09(10,5,1);



