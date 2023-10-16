USE test;
-- id - число - автоинкремент
-- title - уникальное название задачи 
-- status - значение N/Y 
-- price - от 0 до 200

-- добавить 5 задач

CREATE TABLE tasks (
	id integer PRIMARY KEY AUTO_INCREMENT, 
    title varchar (128) UNIQUE,
    status varchar (128) check (status IN ('N', 'Y')), -- mozmo char(1)
    price integer CHECK (price BETWEEN 0 AND 200)
);

insert into tasks (title, status, price) 
	values 
	('Tasks 1', 'Y', 100);
insert into tasks (title, status, price) 
	values 
	('Tasks 2', 'N', 110);
insert into tasks (title, status, price) 
	values 
	('Tasks 3', 'Y', 120);
insert into tasks (title, status, price) 
	values 
	('Tasks 4', 'N', 130);
insert into tasks (title, status, price) 
	values 
	('Tasks 5', 'N', 140);
    
    SELECT * FROM tasks;
    
    -- у задачи с id 2 изменить status на "N"
    UPDATE tasks
    SET status = 'N'
    WHERE id = 2; 
    
     SELECT * FROM tasks;
     
     
     -- указать price = 150 для задачи с title Task#125
     
	UPDATE tasks
    SET price = 150
    WHERE title = 'Tasks 5';
    
     SET SQL_SAFE_UPDATES = 0; -- otkluchili eto 0 ,  a 1 eto vkl
    
     SELECT * FROM tasks;
     
     -- увеличить цену задачи 'Task#123' на 10 процентов
	UPDATE tasks
    SET price = price * 1.1
    WHERE title = 'Tasks 1';
      SELECT * FROM tasks;
      
-- уменьшить цену задачи в два раза , которые еще не выполнены
      
UPDATE TASKS
SET price = price / 2
WHERE status = 'N';
  SELECT * FROM tasks;
  
  USE hr;
  
  SELECT * FROM employees;
SELECT * FROM departments;

 -- высети имя и фамилию сотрудника и название департамената
SELECT
	first_name,
    last_name,
    department_name
FROM employees  
INNER JOIN  departments
ON employees.department_id = departments.department_id;
   
   -- высети имя и фамилию сотрудника и название департамената
SELECT
	employees.first_name,
    employees.last_name,
    departments.department_name,
    departments.department_id, -- нужно указать откуда берем, поэтому нужно писать название таблицы.
    employees.description 
FROM employees  
INNER JOIN  departments
ON employees.department_id = departments.department_id;
  
  SELECT
	employees.first_name,
    employees.last_name,
    employees.salary - employees.salary * employees.commission_pct AS salary,
    departments.department_name,
    departments.department_id, -- нужно указать откуда берем, поэтому нужно писать название таблицы.
    employees.description 
FROM employees  
INNER JOIN  departments
ON employees.department_id = departments.department_id;


  SELECT
	t1.first_name,
    t1.last_name,
    t1.salary - t1.salary * t1.commission_pct AS new_salary,
    t2.department_name,
    t2.department_id -- нужно указать откуда берем, поэтому нужно писать название таблицы.
FROM employees  t1
INNER JOIN  departments t2
ON t1.department_id = t2.department_id;

SELECT 
COALESCE(commission_pct, 0) AS new_commission_pct, -- в котром встречается нал, а второе значение 0, если нал. если не нал, то подставялет ту комиссиюу, которая есть. 
commission_pct
 FROM employees;

 SELECT
	t1.first_name,
    t1.last_name,
    t1.salary - t1.salary * COALESCE(commission_pct, 0) AS new_salary,
    t2.department_name,
    t2.department_id 
FROM employees  t1
INNER JOIN  departments t2
ON t1.department_id = t2.department_id;

SELECT * FROM departments;

-- вывести имя, фамилию и зарплату сотрудника, а так же название его должности
 SELECT
	t1.first_name,
    t1.last_name,
    t1.salary,
    t2.job_title
FROM employees  t1
INNER JOIN  jobs t2
ON t1.job_id = t2.job_id;

-- написать запрос, который выводит название департамента и название города, в котором он находится
SELECT
	t1.department_name,
    t2.city
FROM departments t1
INNER JOIN  locations t2
ON t1.location_id = t2.location_id;

-- написать запрос, который выводит название департамента и название города, в котором он находится London 
SELECT
	t1.department_name,
    t2.city
FROM departments t1
INNER JOIN  locations t2
ON t1.location_id = t2.location_id
WHERE t2.city = 'London'; 

-- вывести названия департаментов, в которых есть сотрудники с зарплатой выше 12000
SELECT distinct
	t2.department_name
FROM employees t1
INNER JOIN  departments t2
ON t1.department_id = t2.department_id
WHERE t1.salary > 12000
