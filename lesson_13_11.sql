USE shop2;
-- 1. найти кол-во покупателей мужского и женского пола  поля: gender cnt
SELECT gender, 
	countproducts(id) AS cnt -- COUNT(id): Это функция агрегирования, которая подсчитывает количество непустых значений в столбце id.
    -- AS cnt: Это синтаксис для присвоения псевдонима (alias) результату подсчета. В данном случае, результат подсчета будет доступен по имени cnt в результирующем наборе.
	FROM customers
GROUP BY gender; -- potomu chto po polju gender

USE shop2;
-- 2. найти общую сумму продуктов для каждого поставщика. на какую сумму какой поставшик поставил товаров 
-- поля: 
-- supplier_id
-- total_sum
SELECT 
	supplier_id,
	sum(price * amount) AS total_sum
    FROM products
group by supplier_id;

-- 3. сформировать запрос, который выводит имя поставщика и сумму поставленных товаров
SELECT 
	t1.name,
	coalesce(t2.total_sum, 0) AS total_sum -- coalesce  total sum =NULL, esli NE NULL, to vernjot to znachenie , chto v total sum
    FROM suppliers t1
LEFT JOIN (
	SELECT 
    supplier_id,
    sum(price * amount) AS total_sum
    FROM products
   group by supplier_id
   ) t2
   ON t1.id = t2.supplier_id
   
-- 4. написать запрос, который выведет самую большую сумму товаров, поставленных одним поставщиком
 SELECT
	max(total_sum) AS max_total_sum
 FROM (
	SELECT
		sum(price * amount) AS total_sum
    FROM products
	group by supplier_id
)t1;
  
 -- 5.  написать запрос, который выводит supplier_id с максимальным total_sum
SELECT
		*
FROM (
	SELECT
	   supplier_id, 
	   sum(price * amount) as total_sum 
	FROM products
	group by supplier_id   
) t1
WHERE total_sum = (
	SELECT
		max(total_sum) AS max_total_sum
	FROM (
		SELECT
           sum(price * amount) AS total_sum
           FROM products
           group by supplier_id) t1
);
		
-- HAVING - rabotaet posle agregazii
-- 5.  написать запрос, который выводит supplier_id с максимальным total_sum

-- 1 найти максиамльное total_sum
-- SELECT
		-- max(total_sum) AS max_total_sum
	-- FROM (
		-- SELECT
			-- sum(price * amount) AS total_sum
		-- FROM products
        -- GROUP BY supplier_id
        -- ) t1
-- 2 найти суммы поставок каждого поставщика 
-- SELECT
			-- supplier_id,
			-- sum(price * amount) AS total_sum
		-- FROM products
       -- GROUP BY supplier_id
SELECT
	supplier_id
FROM products
GROUP BY supplier_id
HAVING sum(price * amount) = (
	SELECT
		max(total_sum) AS max_total_sum
	FROM (
		SELECT
			sum(price * amount) AS total_sum
		FROM products
        GROUP BY supplier_id
        ) t1
	);

-- 6. написать запрос, который выводит customer_id с максимальным кол-вом заказов
-- max kol-vo zakazov
-- kol-vo zakazov u kazdogo pokupatelja
SELECT
	customer_id
FROM orders
GROUP BY customer_id
HAVING count(id) = (
	SELECT
		max(orders_cnt) AS max_order_cnt
	FROM (
	SELECT
		count(id) AS orders_cnt
	FROM orders
	GROUP BY customer_id
	) t1
);

-- 7. написать запрос, который выводит имя и фамилию покупателя и кол-во его заказов
SELECT
	t1.first_name,
    t1.last_name,
    COALESCE(t2.cnt, 0) AS cnt
FROM customers t1
LEFT Join (
	SELECT
		customer_id,
        count(id) AS cnt
	FROM orders
    GROUP BY customer_id
) t2
ON t1.id = t2.customer_id; 

-- 8. написать запрос, который выводит имя и фамилию покупателя и кол-во его не оплаченных заказов
SELECT
	t1.first_name,
    t1.last_name,
    COALESCE(t2.cnt, 0) AS not_paid_cnt
FROM customers t1
LEFT Join (
	SELECT
		customer_id,
        count(id) AS cnt
	FROM orders
    WHERE paid_flg = 'N'
    GROUP BY customer_id
) t2
ON t1.id = t2.customer_id; 

-- 9. написать запрос, который выводит имя и фамилию покупателя 
-- кол-во его не оплаченных заказов
-- кол-во его оплаченных заказов
SELECT
	t1.first_name,
    t1.last_name,
    COALESCE(t2.cnt, 0) AS not_paid_cnt,
	COALESCE(t2.cnt, 0) AS paid_cnt
FROM customers t1
LEFT Join (
	SELECT
		customer_id,
        count(id) AS cnt
	FROM orders
    WHERE paid_flg = 'N'
    GROUP BY customer_id
) t2
ON t1.id = t2.customer_id
LEFT Join (
	SELECT
		customer_id,
        count(id) AS cnt
	FROM orders
    WHERE paid_flg = 'N'
    GROUP BY customer_id
) t3
ON t1.id = t3.customer_id; 
