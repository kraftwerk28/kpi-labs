/*------------------------------*\
 * виконав: Амброс В. В., ІП-71 *
 * PostgreSQL v10.6             *
\*------------------------------*/

-- 1. Додати себе як співробітника компанії на позицію Intern.
INSERT INTO employees (
  "EmployeeID",
  "FirstName",
  "LastName",
  "Title",
  "TitleOfCourtesy",
  "BirthDate",
  "HireDate",
  "Address",
  "City",
  "Region",
  "PostalCode",
  "Country",
  "HomePhone")
VALUES (
  (SELECT max("EmployeeID") + 1),
  'Vsevolod',
  'Ambros',
  'Intern',
  'Mr.',
  '2000-05-28',
  '2018-11-01',
  'Yangelia, 20',
  'Kyiv',
  NULL,
  00000,
  'Ukraine',
  '(123) 456-7890'
);

-- 2. Змінити свою посаду на Director.
UPDATE employees
SET "Title" = 'Director'
WHERE ("FirstName" = 'Vsevolod' AND "LastName" = 'Ambros');

-- 3. Скопіювати таблицю Orders в таблицю OrdersArchive.
CREATE TABLE IF NOT EXISTS "OrdersArchive" AS TABLE orders;

-- 4. Очистити таблицю OrdersArchive.
TRUNCATE TABLE "OrdersArchive";

-- 5. Не видаляючи таблицю OrdersArchive, наповнити її інформацією повторно.
INSERT INTO "OrdersArchive" (
  SELECT *
  FROM orders
);

-- 6. З таблиці OrdersArchive видалити усі замовлення, що були зроблені
-- замовниками із Берліну.
DELETE FROM "OrdersArchive"
WHERE "CustomerID" IN (
  SELECT "CustomerID"
  FROM customers
  WHERE "City" = 'Berlin'
);

-- 7. Внести в базу два продукти з власним іменем та іменем групи.
INSERT INTO products (
  "ProductID",
  "ProductName",
  "Discontinued"
)
VALUES (
  (SELECT MAX("ProductID") FROM products) + 50,
  'Vsevolod',
  0
),
(
  (SELECT MAX("ProductID") FROM products) + 100,
  'ip-71',
  0
);

-- 8. Помітити продукти, що не фігурують в замовленнях, як такі,
-- що більше не виробляються.
UPDATE products
SET "Discontinued" = 1
WHERE "ProductID" IN (
  SELECT "ProductID" FROM products
  EXCEPT
  SELECT "ProductID" FROM order_details
);

-- 9. Видалити таблицю OrdersArchive.
DROP TABLE IF EXISTS "OrdersArchive";

-- 10. Видатили базу Northwind.
DROP DATABASE IF EXISTS northwind;
