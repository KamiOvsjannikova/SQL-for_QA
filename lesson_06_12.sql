USE airport;
-- 1. Разделите самолеты на три класса по возрасту. 
-- Если самолет произведен раньше 2000 года, то отнесите его к классу 'Old'. 
-- Если самолет произведен между 2000 и 2010 годами включительно, то отнесите его к классу 'Mid'. 
-- Более новые самолеты отнесите к классу 'New'. 
-- Исключите из выборки дальнемагистральные самолеты с максимальной дальностью полета больше 10000 км. 
-- В выборке должны присутствовать два атрибута — side_number, age.

select
	side_number,
    case
		when production_year < 2000 then 'Old'
        when production_year between 2000 and 2010 then 'Mid'
        else 'New'
    end as age
from airliners
where range_ <= 10000;

-- 2. Разделите самолеты на ближне-, средне- и дальнемагистральные. 
-- Ближнемагистральными будем считать самолеты, дальность полета которых > 1000 км и <= 2500 км. 
-- Среднемагистральными — с дальностью полета > 2500 км и <= 6000 км. 
-- Дальнемагистральными — с дальностью полета > 6000 км. 
-- В выборке должно быть два столбца, где в первом указана модель самолета. 
-- Во втором, category, — категория, со значениями short-haul, medium-haul, long-haul (ближне-, средне- и дальнемагистральные соответственно). 
-- Если максимальная дальность полета <= 1000 км или данных о дальности полета нет, в category выведите 'UNDEFINED'.
-- В выборке должны присутствовать два атрибута — model_name, category.

select
	model_name,
    case
		when range_ > 1000 and range_ <= 2500 then 'short-haul'
        when range_ > 2500 and range_ <= 6000 then 'medium-haul'
        when range_ > 6000 then 'long-haul'
        else 'UNDEFINED'
    end as category
from airliners;

-- 3. Руководство авиакомпании снизило цены на билеты рейсов LL4S1G8PQW, 0SE4S0HRRU и JQF04Q8I9G. 
-- Скидка на билет экономкласса (Economy) составила 15%, на билет бизнес-класса (Business) — 10%, а на билет комфорт-класса (PremiumEconomy) — 20%. 
-- Определите цену билета в каждом сегменте с учетом скидки.
-- 
-- В выборке должны присутствовать три атрибута — id, trip_id, new_price.
select
	id,
    trip_id,
    case
		when service_class = 'Economy' then price * 0.85 -- 100% - 15% = 85% => 0.85
        when service_class = 'Business' then price * 0.9 -- 100 -10 = 90% =>0.9 
        when service_class = 'PremiumEconomy' then price * 0.8 -- 100-20 = 80% => 0.8
        else price
    end as new_price
from tickets
where trip_id in ('LL4S1G8PQW', '0SE4S0HRRU', 'JQF04Q8I9G');

-- 4. Руководство авиакомпании снизило цены на билеты рейсов OZAO28DLFP, 5QMWLJ4SOC и 8RF8OIOVFR. 
-- Скидка на билет экономкласса (Economy) составила 15%, на билет первого класса (FirstClass) — 10%, а на билет комфорт-класса (PremiumEconomy) — 20%.
-- Найдите затраты авиакомпании на акцию, то есть разность стоимости всех билетов и стоимости всех билетов с учетом скидки.
-- В выборке должен присутствовать один атрибут — expenses.

-- разность стоимости всех билетов и стоимости всех билетов с учетом скидки = сумма всех скидок
select
	sum(
		case
			when service_class = 'Economy' then price * 0.15
            when service_class = 'FirstClass' then price * 0.1
            when service_class = 'PremiumEconomy' then price * 0.2
        end
    ) as expenses
from tickets
where trip_id in ('OZAO28DLFP', '5QMWLJ4SOC', '8RF8OIOVFR');
