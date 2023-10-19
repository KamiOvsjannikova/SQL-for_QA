CREATE DATABASE shop;

USE shop;

CREATE TABLE SELLERS(
       SELL_ID    INTEGER, 
       SNAME   VARCHAR(20), 
       CITY    VARCHAR(20), 
       COMM    NUMERIC(2, 2),
             BOSS_ID  INTEGER
);
                                            
CREATE TABLE CUSTOMERS(
       CUST_ID    INTEGER, 
       CNAME   VARCHAR(20), 
       CITY    VARCHAR(20), 
       RATING  INTEGER
);

CREATE TABLE ORDERS(
       ORDER_ID  INTEGER, 
       AMT     NUMERIC(7,2), 
       ODATE   DATE, 
       CUST_ID    INTEGER,
       SELL_ID    INTEGER 
);

INSERT INTO SELLERS VALUES(201,'Олег','Москва',0.12,202);
INSERT INTO SELLERS VALUES(202,'Лев','Сочи',0.13,204);
INSERT INTO SELLERS VALUES(203,'Арсений','Владимир',0.10,204);
INSERT INTO SELLERS VALUES(204,'Екатерина','Москва',0.11,205);
INSERT INTO SELLERS VALUES(205,'Леонид ','Казань',0.15,NULL);


INSERT INTO CUSTOMERS VALUES(301,'Андрей','Москва',100);
INSERT INTO CUSTOMERS VALUES(302,'Михаил','Тула',200);
INSERT INTO CUSTOMERS VALUES(303,'Иван','Сочи',200);
INSERT INTO CUSTOMERS VALUES(304,'Дмитрий','Ярославль',300);
INSERT INTO CUSTOMERS VALUES(305,'Руслан','Москва',100);
INSERT INTO CUSTOMERS VALUES(306,'Артём','Тула',100);
INSERT INTO CUSTOMERS VALUES(307,'Юлия','Сочи',300);


INSERT INTO ORDERS VALUES(101,18.69,'2022-03-10',308,207);
INSERT INTO ORDERS VALUES(102,5900.1,'2022-03-10',307,204);
INSERT INTO ORDERS VALUES(103,767.19,'2022-03-10',301,201);
INSERT INTO ORDERS VALUES(104,5160.45,'2022-03-10',303,202);
INSERT INTO ORDERS VALUES(105,1098.16,'2022-03-10',308,207);
INSERT INTO ORDERS VALUES(106,75.75,'2022-04-10',304,202); 
INSERT INTO ORDERS VALUES(107,4723,'2022-05-10',306,201);
INSERT INTO ORDERS VALUES(108,1713.23,'2022-04-10',302,203);
INSERT INTO ORDERS VALUES(109,1309.95,'2022-06-10',304,203);
INSERT INTO ORDERS VALUES(110,9891.88,'2022-06-10',306,201);

-- 1. Выведите список имен покупателей, которые совершили покупку. 
-- Предусмотрите в выборке номер заказа.
-- В выборке должно присутствовать два атрибута — cname, order_id.

-- что нужно вывести? какие поля?
-- в каких таблицах есть нужные поля? 
-- как эти таблицы между собой соединить?
SELECT
	t1.cname,
	t2.order_id
FROM customers t1
INNER JOIN orders t2
ON t1.cust_id = t2.cust_id;

-- 2. Интернет-магазину необходимо заполнить отчет по продажам товаров. 
-- Выведите список имен покупателей, которые совершили покупку, а также ее итоговую сумму.
-- В выборке должно присутствовать два атрибута — cname, amt.
SELECT
	t1.cname,
	t2.amt
FROM customers t1
INNER JOIN orders t2
ON t1.cust_id = t2.cust_id;

-- 3. Выведите список имен покупателей, продавцов и итоговую сумму заказа.
-- В выборке должны присутствовать три атрибута — cname, sname, amt.

SELECT
	t1.cname,
    t3.sname,
	t2.amt
FROM customers t1
INNER JOIN orders t2
ON  t1.cust_id = t2.cust_id
INNER JOIN sellers t3
ON  t2.sell_id = t3.sell_id;

-- ДЗ (БД shop)
-- 1. Выведите список заказов, сумму, а также имена продавцов.
-- В выборке должны присутствовать три атрибута — order_id, sname, amt.

USE shop;
SELECT
	t1.order_id, 
    t2.sname, 
    t1.amt
FROM orders t1
INNER JOIN sellers t2
ON t1.sell_id = t2.sell_id;

-- 2. Выведите имена покупателей, которые совершили покупку на сумму больше 1000 условных единиц.
-- В выборке должно присутствовать два атрибута — cname, amt.

USE shop;
SELECT
	t1.cname,
    t2.amt
FROM customers t1
INNER JOIN orders t2
ON t1.cust_id = t2.cust_id
WHERE t2.amt > 1000;

-- *3. Выведите имена покупателей, которые сделали заказ. 
-- Предусмотрите в выборке также имена продавцов.
-- Примечание: покупатели и продавцы должны быть из разных городов.
-- В выборке должно присутствовать два атрибута — cname, sname.

USE shop;
SELECT
	t1.cname,
	t3.sname
FROM customers t1
INNER JOIN orders t2
ON t1.cust_id = t2.cust_id
INNER JOIN sellers t3
ON t2.sell_id = t3.sell_id
WHERE t1.city <> t3.city;


