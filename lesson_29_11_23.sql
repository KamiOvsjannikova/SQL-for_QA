-- ПРАКТИКА (БД shop)
use shop;

-- 1. Выведите список имен покупателей, продавцов и итоговую сумму заказа (amt).
-- В выборке должны присутствовать три атрибута — cname, sname, amt.

select
 t1.cname,
    t3.sname,
    t2.amt
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id
inner join sellers t3
on t2.sell_id = t3.sell_id;

-- 2. Выведите список имен покупателей и итоговую сумму всех заказов (amt).
-- В выборке должны присутствовать два атрибута — cname, amt_total.
select
 t1.cname,
    sum(t2.amt) as amt_total
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id
group by t1.cname;

-- 3. Выведите имена покупателей, которые совершили покупку, чья итоговая сумма превышает среднее значение цен в таблице(amt).
-- В выборке должно присутствовать два атрибута — cname, amt.
select
	t1.cname,
    t2.amt
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id
where t2.amt > (select avg(amt) from orders);

-- 4. Выведите имена только тех покупателей, которые сделали заказ. 
-- Предусмотрите в выборке также имена продавцов.
-- Примечание: покупатели и продавцы должны быть из разных городов.
-- В выборке должно присутствовать два атрибута — cname, sname.
select
	t1.cname,
    t3.sname
from customers t1
inner join orders t2
on t1.cust_id = t2.cust_id
inner join sellers t3
on t2.sell_id = t3.sell_id
where t1.city <> t3.city;

-- 5. Выведите имена всех продавцов. Предусмотрите также в выборке имена их боссов, сформировав атрибут boss_name.
-- Если у продавца нет босса, то в поле boss_name подставить null
-- В выборке должно присутствовать два атрибута — sname, boss_name.
select
 t1.sname,
    t2.sname as boss_name
from sellers t1
left join sellers t2
on t1.boss_id = t2.sell_id;

USE hr;
-- 1. Вывести имя/фамилию сотрудника и имя/фамилию его менеджера
-- В выборке должно быть 4 поля - employee_firstname, employee_lastname, manager_firstname, manager_lastname
select
 t1.first_name as employee_firstname,
    t1.last_name as employee_lastname,
    t2.first_name as manager_firstname,
    t2.last_name as manager_lastname
from employees t1
left join employees t2
on t1.manager_id = t2.employee_id;

-- Homework 
-- ДЗ (БД hr)
-- 1. Вывести имя/фамилию сотрудника, который зарабатывает больше своего менеджера (2 сотрудника)
SELECT 
    t1.first_name AS employee_firstname,
    t1.last_name AS employee_lastname,
    t2.first_name AS manager_firstname,
    t2.last_name AS manager_lastname
FROM Employees t1
JOIN Employees t2
ON t1.manager_id = t2.employee_id
WHERE t1.salary > t2.salary;
