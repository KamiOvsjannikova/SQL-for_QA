-- Агрегация 
-- 1. Найти максимальный возраст среди покупателей
select
 max(age) as max_age
from customers;

-- 2. Найти минимальный возраст среди покупателей
select
 min(age) as min_age
from customers;

-- 3. Найти средний возраст среди покупателей
select
 avg(age) as avg_age
from customers;

-- 4. Найти сумму возрастов среди покупателей
select
 sum(age) as sum_age
from customers;

-- 5. Найти количество покупателей в таблице
select
 count(*) as customers_cnt
from customers;
/*
update customers
set age = null
where customer_id = 5;
*/

-- 6. Найти покупателей (имя, фамилия, возраст) с самым маленьким возрастом
-- 6. Найти покупателей (имя, фамилия, возраст), чей возраст равен минимальному
select
 first_name,
    last_name,
    age
from customers
where age = (select min(age) from customers);


USE hr;
-- 1. Найти сотрудников (имя, фамилию, зп), которые зарабатывают больше всех в компании
SELECT
	first_name,
    last_name,
    salary
FROM employees
WHERE salary = (SELECT max(salary) FROM employees);

-- 2. Найти сотрудников (имя, фамилию, зп), которые зарабатывают меньше среднего по компании и работают в департаментах 90, 60, 80, 100
SELECT
	first_name,
    last_name,
    salary
FROM employees
WHERE salary < (SELECT avg(salary) FROM employees)
AND department_id IN (90, 60, 80, 100);

-- 3. Найти сотрудников (имя, фамилию, зп), которые зарабатывают меньше среднего по компании 
-- и работают в департаментах 'Executive', 'IT', 'Sales', 'Finance'
SELECT
	t1.first_name,
    t1.last_name,
    t1.salary
FROM employees t1
INNER JOIN departments t2
on t1.department_id = t2.department_id 
WHERE t1.salary < (SELECT avg(salary) FROM employees)
AND t2.department_name IN ('Executive', 'IT', 'Sales', 'Finance');


-- 4. Вывести сотрудников (имя, фамилия, должность), которые работают на следующих должностях 'Finance Manager', 'Programmer', 'Sales Manager'
SELECT
	t1.first_name,
    t1.last_name,
    t2.job_title
FROM employees t1
INNER JOIN jobs t2
on t1.job_id = t2.job_id 
WHERE t2.job_title IN ('Finance Manager', 'Programmer', 'Sales Manager');
