use shopdb;

-- -------------------------------
-- View
-- -------------------------------
-- Select 의 조회 결과를 반복적으로 사용해야 할때 마치 테이블처럼 사용하는 문법
-- 가상테이블

select * from usertbl;
select * from buytbl;

create view view_usertbl
as 
select *,concat(mobile1,'-',mobile2) 
from usertbl 
where addr in ('서울','경기','경남');

select * from view_usertbl;
select * from view_usertbl where height >=175;

-- 확인
show tables;
select * from information_schema.views;


create view view_user_buytbl
as
select usertbl.userid,name,addr,sum(price*amount) as TotalPayment
from usertbl
inner join buytbl
on usertbl.userid=buytbl.userid
group by usertbl.userid;

select * from view_user_buytbl;

select * from view_user_buytbl where Totalpayment>=100; -- group by 귀찮으니 view로 만들어서 where로



-- customers employeeNumber 
-- inner join>view
use classicmodels;

create view view_classicmodels
as
select distinct employees.officeCode,employeenumber,reportsTo 
from employees
inner join offices on offices.officeCode=employees.officeCode
inner join customers on salesRepEmployeeNumber=employeeNumber; 

select * from view_classicmodels; -- 확인

drop view view_classicmodels; -- 삭제

