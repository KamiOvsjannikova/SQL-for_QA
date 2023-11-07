USE hr;
SELECT * FROM employees;

SELECT 
   max(salary) AS max_salary, -- max znachenie
   min(salary) AS min_salary, -- min znachenie
   sum(salary) AS sum_salary, -- summarnoe znachenie
   avg(salary) AS avg_salary, -- srednee znachenie
   count(salary) AS count_salary -- kol-vo ne NULL znachenie v etom pole
FROM employees;

-- 1) найти самую большую зп среди сотрудников из IT_PROG
SELECT 
   max(salary) AS max_salary -- max znachenie
FROM employees
WHERE job_id  = 'IT_PROG';

-- 2) найти дельту между самой большой и самой маленькой зарплатами
SELECT 
   max(salary) -  min(salary) AS delta
FROM employees;

SELECT 
    *
FROM employees
WHERE salary = (SELECT max(salary) FROM employees); -- сначала в скобках отрабатывает хатем только внешний запрос (всегда возвращаетс одно поле, это будет знак = ) А если много , то это будет IN

-- подзапросы
-- 1. в качестве условия
-- 2. в качестве источника данных

-- 3) вывести имя и фамилию сотрудников, которые получают зп больше средней
SELECT
	first_name,
    last_name
FROM employees
WHERE salary > (SELECT avg(salary) FROM employees);

-- 4) написать запрос, который выводит имя и фамилию сотрудника с самой большой зп и сотрудника с самой маленькой зп
SELECT
	first_name,
    last_name
FROM employees
WHERE salary = (SELECT max(salary) FROM employees)
OR salary = (SELECT min(salary) FROM employees);

-- соеденение в одну группу
USE hr;
SELECT
	department_id,
    max(salary) AS max_salary
FROM employees
GROUP BY department_id;

-- 5) найти среднюю зп для каждого job_id и вывести job_id и avg_salary
USE hr;
SELECT
	job_id,
    avg(salary) AS avg_salary
FROM employees
GROUP BY job_id;

-- 2. в качестве источника данных
-- 6) вывести job_title и avg_salary у него
USE hr;
SELECT
	t1.job_title,
    t2.avg_salary
FROM jobs t1
INNER JOIN (
SELECT
	job_id,
    avg(salary) AS avg_salary
    FROM employees
    GROUP BY job_id
) t2
ON t1.job_id = t2.job_id;

-- 7) вывести максимальную и минимальную зп для кадого департамента вывести department_name, max_salary, min_salary

USE hr;
 SELECT 
 t1.department_name,
 t2.min_salary,
 t2.max_salary
FROM departments t1
INNER JOIN(
	SELECT 
    department_id,
    MAX(salary) AS max_salary,
	MIN(salary) AS min_salary
FROM employees
group by  department_id
) t2
ON t1. department_id = t2.department_id;

USE shop2;
-- найти самый дорогой продукт, вывести его название
SELECT 
	name
FROM products
WHERE price = ( SELECT max(price) FROM products);

-- найти самый дорогой продукт среди тех, которых нет в наличии, вывести его название
SELECT 
	*
FROM products
WHERE price = (SELECT max(price) FROM products WHERE in_stoke = 'N')
AND  in_stoke = 'N';

-- написать запрос, который выводит ORDER_id и общую сумму данного заказа SELECT * FROM order_details / SELECT * FROM products
SELECT 
	t1.order_id,
    sum(t1.product_count * t2.price) AS order_price
FROM order_details t1
INNER JOIN products t2
ON t1.product_id = t2.id
GROUP BY t1.order_id;

-- написать запрос, который выводит customer_id всех покупателей и общую сумму заказа покупателя
USE shop2;
SELECT 
	t3.customer_id, 
	sum(t1.product_count * t2.price) AS order_price
FROM order_details t1
	INNER JOIN products t2
	ON t1.product_id = t2.id
    INNER JOIN orders t3
	ON t1.order_id = t3.id
GROUP BY t3.customer_id;