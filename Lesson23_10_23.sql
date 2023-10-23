-- вывести все локации, которые находятся в Италии, Японии и Индии

SELECT
    l.location_id,
    c.country_name
FROM locations l
JOIN countries c ON l.country_id = c.country_id
WHERE c.country_name IN ('Italy', 'Japan', 'India');

select * from departments;
select * from employees;




-- manager_id - employee_id сотрудника, который является менеджером
-- вывести название департамента и имя 
-- и фамилию менеджера (manager_first_name, manager_last_name)
select 
	e.first_name as manager_first_name,
    e.last_name as manager_last_name,
    d.department_name 
from employees e
inner join departments d on e.employee_id = d.manager_id;





-- вывести названия департаментов, которые находятся в Италии
select 
	t1.department_name,
    t3.country_name
from departments t1
inner join locations t2 on t1.location_id = t2.location_id
inner join countries t3  on t2.country_id = t3.country_id
where t3.country_name = 'Italy';

select 
	t1.first_name,
    t1.last_name,
    t2.department_name
from employees t1 
left join departments t2 
on t1.department_id = t2.department_id;    


select* from departments;
select * from locations;
	
    
-- вывести все локации (location_id и city) и название департамента 
-- если департамента в данной локации нет, то вывести null

SELECT
    l.location_id AS Location,
    l.city AS City,
    d.department_name AS Department_name
FROM locations l
LEFT JOIN departments d ON l.location_id = d.location_id;

SELECT
    l.location_id AS Location,
    l.city AS City,
coalesce(d.department_name, 'Нет департмента') AS Department_name
FROM locations l
LEFT JOIN departments d ON l.location_id = d.location_id;


SELECT
    l.location_id AS Location,
    l.city AS City,
	t2.department_name
full FROM locations l
LEFT JOIN departments t2 ON l.location_id = t2.location_id;


select 
	first_name,
    last_name
from employees
where job_id = 'IT_PROG'  
union all
select
	first_name,
	last_name
from employees
where job_id = 'SA_MAN';



SELECT
    l.location_id AS Location,
    l.city AS City,
    d.department_name AS Department_name
FROM locations l
LEFT JOIN departments d ON l.location_id = d.location_id
UNION
SELECT
    l.location_id AS Location,
    l.city AS City,
    d.department_name AS Department_name
FROM locations l
RIGHT JOIN departments d ON l.location_id = d.location_id;


SELECT
    l.location_id AS Location,
    l.city AS City,
    d.department_name AS Department_name
FROM locations l
inner JOIN departments d ON 1=1;




select * from customers;
select * from loyalty_programs;
select * from order_details;
select * from orders;
select * from products;
select * from suppliers;


-- вывести всех клиентов (имя и фамилию) и процент скидки, который у них есть
-- если скидки нет, вывести 0

SELECT
    t1.first_name,
    t1.last_name,
    coalesce(  t2.discount,0) as discount
FROM customers t1
left join loyalty_programs t2 
on t1.loyalty_program_id = t2.id;

-- написать запрос, который выводит название товара и все возможные цены 
-- в зависимости от програмы лояльности. 
-- в выборке должны быть поля 
-- name - название продукта 
-- program_name - название программы лояльности
-- price - цена с учетом скидки

SELECT
    t1.name,
    t2.program_name,
    round(t1.price -t1.price / 100 * t2.discount ,2)as price 
FROM products t1
inner join loyalty_programs t2;
