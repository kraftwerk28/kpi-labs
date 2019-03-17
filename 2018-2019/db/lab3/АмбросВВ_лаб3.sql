-- 1. Використовуючи SELECT двічі, виведіть на екран своє ім’я,
-- прізвище та по-батькові одним результуючим набором.
SELECT 'Ambros' as "FullName"
UNION ALL
SELECT 'Vsevolod Volodymyrovych';


-- 2. Порівнявши власний порядковий номер в групі з набором із
-- всіх номерів в групі, вивести на екран ;-) якщо він менший
-- за усі з них, або :-D в протилежному випадку.
WITH ip_71 AS (
  SELECT generate_series(1, 31) as student_id
)
SELECT (CASE WHEN 1 < ALL (SELECT student_id FROM ip_71)
  THEN ';-)'
  ELSE ':-D'
END) AS emoji;

-- 3. Не використовуючи таблиці, вивести на екран прізвище та
-- ім’я усіх дівчат своєї групи за вийнятком тих, хто має спільне
-- ім’я з студентками іншої групи.
WITH ip_71_female AS (
  SELECT 'Diana' AS first_name, 'Boloteniuk' AS last_name
  UNION
  SELECT 'Anastasia', 'Kaspruk'
  UNION
  SELECT 'Olga', 'Orel'
)
SELECT * FROM ip_71_female
WHERE first_name IN (
  SELECT first_name FROM ip_71_female
  EXCEPT (
    SELECT 'Oleksandra'
    UNION
    SELECT 'Vladyslava'
    UNION
    SELECT 'Viktoria'
    UNION
    SELECT 'Kateryna'
    UNION
    SELECT 'Olesya'
    UNION
    SELECT 'Sofiya'
  )
);

-- 4. Вивести усі рядки з таблиці Numbers (Number INT).
-- Замінити цифру від 0 до 9 на її назву літерами.
-- Якщо цифра більше, або менша за названі, залишити її без змін.
WITH numbers (number) AS (
  SELECT * FROM generate_series(1, 10) as num
)
SELECT number, (
CASE
  WHEN number = 0 THEN 'Zero'
  WHEN number = 1 THEN 'One'
  WHEN number = 2 THEN 'Two'
  WHEN number = 3 THEN 'Three'
  WHEN number = 4 THEN 'Four'
  WHEN number = 5 THEN 'Five'
  WHEN number = 6 THEN 'Six'
  WHEN number = 7 THEN 'Seven'
  WHEN number = 8 THEN 'Eight'
  WHEN number = 9 THEN 'Nine'
  ELSE CAST(number AS TEXT)
END)
AS pronouncement
FROM numbers;


-- 5. Навести приклад синтаксису декартового об’єднання для вашої СУБД.
WITH
  table_1 AS ( SELECT generate_series(1, 5) AS t1),
  table_2 AS ( SELECT generate_series(1, 3) AS t2)
SELECT * FROM (table_1 CROSS JOIN table_2);


-- 1. Вивисти усі замовлення та їх службу доставки. В залежності від
-- ідентифікатора служби доставки, переіменувати її на таку, що відповідає
-- вашому імені, прізвищу, або по-батькові.
SELECT * FROM orders
LEFT JOIN (
  SELECT "ShipperID", CASE
    WHEN "ShipperID" = 1 THEN 'Ambros'
    WHEN "ShipperID" = 2 THEN 'Vsevolod'
    WHEN "ShipperID" = 3 THEN 'Volodymyrovych'
    ELSE "CompanyName"
  END AS "CompanyName" FROM shippers
) as shipper_edited
ON orders."ShipVia" = shipper_edited."ShipperID";

-- 2. Вивести в алфавітному порядку усі країни, що фігурують в адресах
-- клієнтів, працівників, та місцях доставки замовлень.
SELECT "Country" FROM customers
UNION
SELECT "ShipCountry" FROM orders
UNION
SELECT "Country" FROM employees
ORDER BY "Country" ASC;


-- 3. Вивести прізвище та ім’я працівника, а також кількість замовлень,
-- що він обробив за перший квартал 1998 року.
SELECT "LastName", "FirstName", COUNT("OrderID") AS orders_count FROM employees
JOIN orders USING("EmployeeID")
WHERE extract(YEAR FROM "OrderDate") = 1998
  AND extract(QUARTER FROM "OrderDate") = 1
GROUP BY "EmployeeID";


-- 4. Використовуючи СTE знайти усі замовлення, в які входять продукти,
-- яких на складі більше 100 одиниць, проте по яким немає максимальних знижок.
WITH order_ids AS (
  SELECT order_details."OrderID"
  FROM order_details
  JOIN products USING ("ProductID")
  WHERE (products."UnitsInStock" > 100
    AND order_details."Discount" NOT IN (
    SELECT MAX("Discount")
    FROM order_details
    )
  )
)
SELECT *
FROM orders
WHERE "OrderID" IN (SELECT * FROM order_ids);

-- 5. Знайти назви усіх продуктів, що не продаються в південному регіоні.
SELECT DISTINCT "ProductName" AS "product_not_south" FROM products
JOIN order_details USING ("ProductID")
JOIN orders USING ("OrderID")
JOIN employeeterritories USING ("EmployeeID")
JOIN territories USING ("TerritoryID")
JOIN region rg USING ("RegionID")
WHERE rg."RegionDescription" <> 'Southern';
