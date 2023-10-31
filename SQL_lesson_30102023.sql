use shop_2;

-- написать запрос, который выводит название товара и название поставщика

SELECT 
	t1.name AS Product_Name, 
    t2.name AS Supplier_Name
FROM Products t1
INNER JOIN Suppliers t2
ON t1.supplier_ID = t2.ID;

-- написать запрос, который выводит название товара и название поставщика
-- вывести только те товары, которых больше 30 штук

SELECT 
	t1.name AS Product_Name, 
    t2.name AS Supplier_Name
FROM Products t1
INNER JOIN Suppliers t2
ON t1.supplier_ID = t2.ID
WHERE t1.amount > 30;

-- вывести названия поставщиков у которых в списке поставляемых продуктов есть продукт с 
-- кол-вом больше 30.

SELECT distinct
    t2.name AS Supplier_Name
FROM Products t1
INNER JOIN Suppliers t2
ON t1.supplier_ID = t2.ID
WHERE t1.amount > 30;


SELECT * FROM customers;

SELECT * FROM loyalty_programs;

-- написать запрос, который выводит покупателей (имя и фамилию) 
-- у которых скидка от 10 до 20 процентов (включительно)

SELECT 
	t1.first_name, 
	t1.last_name
FROM Customers t1
INNER JOIN loyalty_programs t2
ON t1.loyalty_program_id = t2.id
WHERE t2.discount BETWEEN 10 AND 20;

-- написать запрос, который выводит покупателей (имя и фамилию) 
-- у которых скидка от 10 до 20 процентов (включительно) или ее нет вовсе

SELECT 
	t1.first_name, 
	t1.last_name
FROM Customers t1
LEFT JOIN loyalty_programs t2
ON t1.loyalty_program_id = t2.id
WHERE t2.discount BETWEEN 10 AND 20
OR t2.id IS NULL;

-- написать запрос, который выводит покупателей (имя и фамилию) 
-- у которых скидка от 10 до 20 процентов (включительно) или ее нет вовсе
-- вывести имя и фамилию покупателя и размер скидки

SELECT 
	t1.first_name, 
	t1.last_name,
    COALESCE(t2.discount, 0) AS discount
FROM Customers t1
LEFT JOIN loyalty_programs t2
ON t1.loyalty_program_id = t2.id
WHERE t2.discount BETWEEN 10 AND 20
OR t2.id IS NULL;

SELECT * FROM products;

SELECT * FROM order_details;

-- написать запрос, который выводит название продуктов, которые ни разу не заказывались 
SELECT 
	t1.name AS Product_Name
FROM Products t1
LEFT JOIN order_details t2
ON t1.id = t2.product_id
WHERE t2.id IS NULL;
-- если товар отсутствует в таблице order_details значит его еще ниразу не заказывали


-- написать запрос, который выводит имя и фамилию покупателя, у которых нет заказов

SELECT 
	t1.first_name, 
    t1.last_name
FROM Customers t1
LEFT JOIN Orders t2
ON t1.id = t2.customer_id
WHERE t2.id IS NULL;
-- по принцыпу предыдущей задачи, если покупатель отсутствует в таблице order_details значит он ничего не заказывал


-- написать запрос, который выводит имя и фамилию покупателя и идентификаторы продуктов, которые он заказал

SELECT 
	t1.first_name, 
    t1.last_name,
    t3.product_id
FROM Customers t1
LEFT JOIN orders t2
ON t1.id = t2.customer_id
LEFT JOIN order_details t3
ON t2.id = t3.order_id;


-- написать запрос, который выводит имя и фамилию покупателя и название продукта, который он заказал

SELECT 
	t1.first_name, 
    t1.last_name,
    t3.product_id
FROM Customers t1
LEFT JOIN orders t2
ON t1.id = t2.customer_id
LEFT JOIN order_details t3
ON t2.id = t3.order_id
LEFT JOIN products t4
ON t3.product_id = t4.id;


-- написать запрос, который выводит имя и фамилию покупателя и названия продукта, 
-- из только оплаченных заказов

SELECT 
	t1.first_name, 
    t1.last_name,
    t3.product_id
FROM Customers t1
LEFT JOIN orders t2
ON t1.id = t2.customer_id
AND t2.paid_flg = 'Y'
LEFT JOIN order_details t3
ON t2.id = t3.order_id
LEFT JOIN products t4
ON t3.product_id = t4.id;


-- написать запрос, который выводит название товара и название программы лояльности 
-- при которых цена будет меньше 30.

SELECT 
	t1.Name, 
    t2.program_Name
FROM Products t1
INNER JOIN Loyalty_Programs t2 
ON 1 = 1
WHERE t1.price - t1.price / 100 * t2.discount < 30;


-- написать запрос, который выводит название тех поставщиков и их номера телефона 
-- в списке поставляемых товаров которых есть товары, которые ни разу 
-- не заказывались.

SELECT distinct
	t3.name AS supplier_name,
    T3.phone
FROM products t1
LEFT JOIN order_details t2
ON t1.id = t2.product_id
LEFT JOIN suppliers t3
ON t1.supplier_id = t3.id
WHERE t2.id IS NULL;







