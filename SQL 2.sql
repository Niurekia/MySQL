-- 01 Group by
use shopdb;
--  sum()
select userid, sum(amount) from buytbl group by userID;
select userid, sum(amount*price) from buytbl group by userID;
select userid, sum(amount*price) as '구매총액'  from buytbl group by userID;

-- avg() 
select userid, avg(amount) from buytbl group by userID;
select userid, truncate(avg(amount),2) from buytbl group by userID;-- select userid, round(avg(amount),1) from buytbl group by userID;

-- maX(), min()
select max(height) from usertbl;
select min(height) from usertbl;
-- 가장 큰 키와 가장 작은 키를 가지는 유저의 모든 열값을 출력
select * from usertbl where height=
(select max(height) from usertbl) or height=(select min(height) from usertbl);

-- count()
select count(*) from usertbl;
select count(mobile1) from usertbl;

-- 1 buytbl에서 userid 별로 구매량(amount)의 합을 출력하세요
select userid,sum(amount) from buytbl group by userid;

-- 2 usertbl에서의 키의 평균값
select truncate(avg(height),2) from usertbl;

-- 3 buytbl에서 최대구매량과 최소 구매량을 userid와 함께 출력
select userid,max(amount),min(amount) from buytbl group by userid;


-- 4 buytbl의 groupname의 개수를 출력
select count(groupname) from buytbl;
select * from buytbl where groupname is null;
select * from buytbl where groupname is not null;

-- classicmodels 의 db에서의 문제
use classicmodels;

-- 1 customers의 테이블의 city를 그룹으로 creditLimit의 평균을 구하셈
select city,avg(creditlimit) from customers group by city;

-- 2 orderdetails테이블의 orderNumber를 기준으로 quantityOrdered의 총합을 츌력
select ordernumber,sum(quantityordered) from orderdetails group by ordernumber;

-- 3 products 테이블의 productVendor를 그룹으로 quantityInStock의 총합을 출력
select productvendor,sum(quantityinstock) from products group by productvendor;


-- 02 Group by + Having

-- buytbl에서 usereid 별로 amount 총합
select userid as '아이디',sum(amount) as '총량' from buytbl group by userid having sum(amount)>=5;

select * from buytbl;
select groupname,sum(amount) from buytbl group by groupname having sum(amount)>=5;

select addr as '주소',avg(height) as '평균키' from usertbl group by addr having avg(height)>=175;

-- 03 Rollup
select num,groupname,sum(price*amount) from buytbl group by groupname,num with rollup;

select * from usertbl;
select userid,addr,avg(height) as '평균키' from usertbl group by addr,userid with rollup;

select groupname,sum(price*amount) from buytbl group by groupname with rollup;
select addr,round(avg(height),1) as '평균키' from usertbl group by addr with rollup;


-- 1 prodName별로 그룹화 한뒤 userID /prodName /price*amount 순으로 출력될 수 있도록 설정
select * from buytbl;
select userid,prodname,sum(price*amount) from buytbl group by prodname,userid;

-- 2 1번 명령어에서 price*amount 값이 1000이상인 행만 출력
select userid,prodname,sum(price*amount) from buytbl group by prodName,userid having sum(price*amount)>=1000;

-- 3 price 가격이 가장 큰 행과 작은 행의 userid,prodName, price를 출력
select distinct userid,prodname,price from buytbl  where price=(select max(price) from buytbl) or price=(select min(price) from buytbl);

-- 4 다음 행중에 그룹네임이 있는 행만 출력
select * from buytbl where groupname is not null;

-- 5 prodName 별로 총합을 구해보세요(Roll up 사용)
select num,prodname,sum(price*amount) from buytbl group by prodname,num with rollup;
