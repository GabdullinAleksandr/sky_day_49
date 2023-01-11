

-- Название компании заказчика (company_name из табл. customers) и ФИО сотрудника,
-- работающего над заказом этой компании (см таблицу employees), когда и заказчик
-- и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания
-- United Package (company_name в табл shippers)
select cu.company_name,
	concat(em.last_name, ' ', em.first_name)
from orders as ord
	join employees as em ON em.employee_id = ord.employee_id
	join customers as cu ON cu.customer_id = ord.customer_id
	join shippers as sh on sh.shipper_id = ord.ship_via
where cu.city = 'London' and em.city = 'London' and sh.company_name = 'United Package'


-- Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях
-- Dairy Products и Condiments. Отсортировать результат по возрастанию количества оставшегося товара.
SELECT pr.product_name,
	pr.units_in_stock,
	s.contact_name,
	s.phone
from products as pr
	join suppliers as s ON s.supplier_id = pr.supplier_id
	JOIN categories as ca ON ca.category_id = pr.category_id
where pr.discontinued <> 1 and pr.units_in_stock < 25 and (ca.category_name = 'Dairy Products' or ca.category_name = 'Condiments')
order by pr.units_in_stock

-- Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
select cu.company_name
from customers as cu
	full join orders as ord USING(customer_id)
where ord.customer_id is null

-- уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц
-- см в колонке quantity табл order_details)
select product_name from products
where exists (
	select 1 from order_details where products.product_id = order_details.product_id and quantity = 10
)

