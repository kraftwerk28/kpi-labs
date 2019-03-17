-- PostgreSQL v10.6
-- Амброс Всеволод, ІП-71, лаб. #1

-- Вивести за допомогою команди SELECT своє прізвище, ім’я та по-батькові на
-- екран.
SELECT
  'Ambros' AS "FirstName",
  'Vsevolod' AS "LastName",
  'Volodymyrovych' AS "Patronymic";

-- Вибрати всі дані з таблиці Products
SELECT *
FROM products;

-- Обрати всі назви продуктів з тієї ж таблиці, продаж яких припинено.
SELECT "ProductName"
FROM products
WHERE "Discontinued" = 1;

-- Вивести всі міста клієнтів уникаючи дублікатів.
SELECT DISTINCT "City"
FROM customers;

-- Вибрати всі назви компаній-постачальників в порядку зворотньому алфавітному.
SELECT "CompanyName"
FROM suppliers
ORDER BY "CompanyName" DESC;

-- Отримати всі деталі замовлень, замінивши назви стовбчиків на їх порядковий
-- номер.
SELECT
  "OrderID" AS "1",
  "ProductID" AS "2",
  "UnitPrice" AS "3",
  "Quantity" AS "4",
  "Discount" AS "5"
FROM order_details;

-- Вивести всі контактні імена клієнтів, що починаються з першої літери вашого
-- прізвища, імені, по-батькові.
SELECT "ContactName"
FROM customers
WHERE "ContactName" ILIKE 'a%'
  OR "ContactName" ILIKE 'v%';

-- Показати усі замовлення, в адресах доставки яких є пробіл.
SELECT *
FROM orders
WHERE "ShipAddress" LIKE '% %';

-- Вивести назви тих продуктів, що починаються на знак % або _, а закінчуються
-- на останню літеру вашого імені.
SELECT "ProductName"
FROM products
WHERE "ProductName" ILIKE '\%%v'
  OR "ProductName" ILIKE '\_%v';
