-- Работа с датой и временем

-- Типы данных

-- DATE - содержит информацию о дате в формате 'YYYY-MM-DD'
-- TIME - содержит информацию о времени в формате 'HH:MM:SS'
-- DATETIME - содержит информацию о дате и времени в формате 'YYYY-MM-DD HH:MM:SS'
-- YEAR - содержит информацию о годе в формате 'YYYY'


-- Функции для работы с датой и временем (https://www.w3schools.com/sql/func_mysql_curdate.asp)

-- now() - возвращает текущие дату и время

select now() as now;

-- curdate() - возвращает текущую дату

select curdate() as today;

-- curtime() - возвращает текущее время

select curtime() as curtime;


-- weekday() - возвращает порядковый номер дня недели
-- 0 = Monday, 1 = Tuesday, 2 = Wednesday, 3 = Thursday, 4 = Friday, 5 = Saturday, 6 = Sunday

select weekday('2023-12-13') as today; -- 2

-- dayofweek() - возвращает порядковый номер дня недели
-- 1 = Sunday, 2 = Monday, 3 = Tuesday, 4 = Wednesday, 5 = Thursday, 6 = Friday, 7 = Saturday

select dayofweek('2023-12-13') as today; -- 4

-- dayname() - возвращает название дня недели

select dayname('2023-12-13') as today; -- Wednesday

-- month() - возвращает порядковый номер месяца (1-12)

select month('2023-12-13') as cur_month; -- 12

-- monthname() - возвращает название месяца (January-December)

select monthname('2023-12-13') as cur_month; -- December

-- year() - возвращает год

select year('2023-12-13') as cur_year; -- 2023



-- ПРАКТИКА (БД shop)

use shop;

-- 1. Найти покупки, которые были сделаны в марте 
-- Вывести: order_id, odate

select
	order_id,
    odate
from orders
where month(odate) = 3;

select
	order_id,
    odate
from orders
where monthname(odate) = 'March';


-- 2. Найти покупки, которые были совершены в промежуток между 30/04/2022 и 14/06/2022 (вкл)
-- Вывести: order_id, odate

select
	order_id,
    odate
from orders
where date(odate) between '2022-04-30' and '2022-06-14';


-- 3. Вывести order_id, odate (в формате 15th June 2022)

select
	order_id,
    date_format(odate, "%D %M %Y")
from orders;


-- 4. Найти количество покупок, совершенных в июне 2022 года

select
	count(*) as june_cnt
from orders
where month(odate) = 6 and year(odate) = 2022;

select
	count(*) as june_cnt
from orders
where monthname(odate) = 'June' and year(odate) = 2022;

select
	count(*) as june_cnt
from orders
where odate between '2022-06-01' and '2022-06-30';


-- 5. Вывести минимальный рейтинг покупателя среди сделавших заказ в марте 2022 года
-- Вывести min_rating

select
	min(t1.rating) as min_rating
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id
where month(odate) = 3 and year(odate) = 2022;


-- 6. Вывести продавцов, оформивших заказ на наибольшую сумму в период с марта 2022 по май 2022
-- Вывести: sell_id, odate, amt

select
	sell_id,
    odate,
    amt
from orders
where amt = (
	select
		max(amt)
	from orders
	where odate between '2022-03-01' and '2022-05-31'
);