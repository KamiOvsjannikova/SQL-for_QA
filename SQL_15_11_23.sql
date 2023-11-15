-- 2. Найти средний возраст покупателей в каждой из стран
SELECT 
	country,
	avg(age) as avg_age
FROM Customers
group by country;

USE hr;
-- 1. Найти самую высокую зарплату в каждом департаменте. 
-- Вывести айди департамента и самую высокую зарплату в этом департаменте
SELECT 
	department_id,
	max(salary) AS max_salary
FROM employees
group by department_id;

-- 2. Найти самую высокую зарплату в каждом департаменте. 
-- Вывести название департамента и самую высокую зарплату в этом департаменте
SELECT 
	t2.department_name,
	max(t1.salary) AS max_salary
FROM employees t1
INNER JOIN departments t2
ON t1.department_id = t2.department_id
group by t2.department_name;

--  Найти средний возраст покупателей в каждой из стран. Но вывести только те страны, в которых средний возраст больше или равен 25
select
	country,
	avg(age) as avg_age
from customers
group by country
having avg_age >= 25; -- вывести только те страны, в которых средний возраст больше или равен 25 potomuchto etogo net v uze suw.table

-- 3. Найти департаменты, в которых работает более 10 сотрудников
-- Вывести айди департамента и кол-во сотрудников в нем
SELECT 
	department_id,
    -- count(employee_id) AS employee_cnt -- count ne NULL schitaet
    count(*) AS employees_cnt
FROM employees 
GROUP BY department_id
HAVING employees_cnt > 10;

-- 4. Найти департаменты, в которых работает более 10 сотрудников
-- Вывести название департамента и кол-во сотрудников в нем

SELECT 
	t2.department_name,
    count(t1.employee_id) AS employee_cnt
FROM departments t2
INNER JOIN employees t1 
ON t1.department_id = t2.department_id
GROUP BY t2.department_name
HAVING count(t1.employee_id) > 10;

select
	t2.department_name,
    count(*) as employees_cnt
from employees t1
inner join departments t2
on t1.department_id = t2.department_id
group by t2.department_name
having employees_cnt > 10;


SELECT
	 t2.department_name,
	 t1.employee_count
from (
	 select 
	  department_id, 
	  COUNT(employee_id) AS employee_count
	 FROM employees
	 GROUP BY department_id
	 HAVING COUNT(employee_id) > 10
) t1
INNER JOIN departments t2
ON t1.department_id = t2.department_id;

-- 5. Найти сотрудников (имя/фамилия), которые зарабатывают больше всего в своем департаменте
-- найти самую большую зп в каждом департаменте 

select
 department_id,
    max(salary) as max_salary
from employees
group by department_id;

-- под каждую макс зп подставить имя сотрудника с такой зп

select
	 t1.first_name,
	 t1.last_name,
	 t1.salary,
	 t2.max_salary
from employees t1
inner join (
	 select
	  department_id,
	  max(salary) as max_salary
	 from employees
	 group by department_id
) t2
on t1.department_id = t2.department_id
where t1.salary = t2.max_salary;