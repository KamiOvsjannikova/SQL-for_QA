-- написать запрос, который выводит наибольшую скиду, которая существует

SELECT 
	MAX(discount) AS max_discount
FROM loyalty_programs;

-- написать запрос, который выводит кол-во программ лояльности

SELECT 
	COUNT(*) AS loyalty_program_count
FROM loyalty_programs;

-- написать запрос, который выводит наибольшую и наименьшую сумму скидки

SELECT 
	MAX(discount) AS max_discount, 
	MIN(discount) AS min_discount
FROM loyalty_programs;

-- написать запрос, который выводит разницу между максимальной и минимальной скидкой

SELECT 
	MAX(discount) - MIN(discount) 
    AS discount_difference
FROM loyalty_programs;

-- написать запрос, который выводит название программы лояльности с максимальной суммой скидки

SELECT 
	program_name
FROM loyalty_programs
WHERE discount = (SELECT MAX(discount) 
FROM loyalty_programs);

-- написать запрос, который выводит программы лояльности (все поля) у которых процент скидки больше средней

SELECT *
FROM loyalty_programs
WHERE discount > (SELECT AVG(discount) 
FROM loyalty_programs);

-- написать запрос, который выводит id программы лояльности и кол-во людей с этой программой

SELECT 
	loyalty_program_id, 
    COUNT(*) AS customer_count
FROM customers
WHERE loyalty_program_id IS NOT NULL
GROUP BY loyalty_program_id;

-- написать запрос, который выводит название программы лояльности и кол-во покупателей за которыми закреплена эта программа

SELECT
t1.program_name,
t2.cnt
FROM loyalty_programs t1
LEFT JOIN (
	SELECT
		t2.loyalty_program_id,
        count(t2.id) as cnt
        FROM customers t2
        WHERE t2.loyalty_program_id IS NOT NULL
        GROUP BY t2.loyalty_program_id
        ) t2
        ON t1.id = t2.loyalty_program_id;
        
-- доработать запрос таким образом, чтобы вывелись только те программы, у которых кол-во покупателей больше 3       

SELECT
t1.program_name,
t2.cnt
FROM loyalty_programs t1
LEFT JOIN (
	SELECT
		t2.loyalty_program_id,
        count(t2.id) as cnt
        FROM customers t2
        WHERE t2.loyalty_program_id IS NOT NULL
        GROUP BY t2.loyalty_program_id
        ) t2
        ON t1.id = t2.loyalty_program_id
        WHERE t2.cnt > 3;
-- группировка не по ключу, program_name могут быть одинаковыми
SELECT
    lp.program_name AS loyalty_program,
    COUNT(c.id) AS customer_count
FROM loyalty_programs lp
LEFT JOIN customers c ON lp.id = c.loyalty_program_id
GROUP BY lp.program_name
HAVING COUNT(c.id) > 3;

-- написать запрос, который выводит идентификатор программы лояльности в которой больше всего покупателей

SELECT
	loyalty_program_id
    FROM customers
    WHERE loyalty_program_id IS NOT NULL
    GROUP BY loyalty_program_id
    HAVING count(*) = (
		SELECT
			max(cnt) AS max_cnt
        FROM (
			SELECT
				count(*) AS cnt
            FROM customers
            WHERE loyalty_program_id IS NOT NULL
            GROUP BY loyalty_program_id
            ) t1);
            
-- написать запрос, который выводит customer_id покупателя с самым большим кол-вом заказов

SELECT
	customer_id,
    count(*) AS cnt
FROM orders
GROUP BY customer_id
HAVING count(*) =(
	SELECT
		max(cnt) AS max_cnt
	FROM (
		SELECT
			count(*) AS cnt
		FROM orders
        GROUP BY customer_id
        ) t1
        );
-- другой вариант:

SELECT
    customer_id,
    COUNT(id) AS order_count
FROM orders
GROUP BY customer_id
ORDER BY order_count DESC;

-- доработать прошлый запрос таким образом, чтобы выводились имя и фамилию покупателя

SELECT
	t1.first_name,
    t1.last_name,
    t2.cnt
    FROM customers t1
    INNER JOIN (
		SELECT
			customer_id,
            COUNT(*) AS cnt
            FROM orders
            GROUP BY customer_id
            HAVING count(*) = (
				SELECT
					max(cnt) AS max_cnt
				FROM (
					SELECT
						count(*) AS CNT
                        FROM orders
                        GROUP BY customer_id
                        ) t1
                        )
                        ) t2
                        ON t1.id = t2.customer_id;
                        
