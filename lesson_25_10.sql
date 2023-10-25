-- ПРАКТИКА (БД HR)
-- 1. Вывести имя, фамилию всех сотрудников и название департаментов, в которых они работают. 
-- Если отсутствует название департамента, то там будет null

USE hr;
SELECT
	t1.first_name,
    t1.last_name,
    t2.department_name
FROM employees t1
left JOIN departments t2
ON t1.department_id = t2.department_id;

-- 2. Вывести названия департаментов, в которых никто не работает
SELECT
	t1.department_name
FROM departments t1
left JOIN employees t2
ON t1.department_id = t2.department_id
WHERE t2.employee_id IS NULL;
