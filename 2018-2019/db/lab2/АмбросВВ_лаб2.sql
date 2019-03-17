-- PostgreSQL v10.6
-- Амброс В. В., ІП-71

-- I.
-- Необхідно знайти кількість рядків в таблиці, що містить більше
-- ніж 2147483647 записів. Напишіть код для MS SQL Server та ще однієї СУБД
-- (на власний вибір).
-- MS SQL syntax: SELECT COUNT_BIG(*) FROM so_big_table;
SELECT COUNT(*) FROM so_big_table;

-- Підрахувати довжину свого прізвища за допомогою SQL.
SELECT length('Ambros');

-- У рядку з своїм прізвищем, іменем, та по-батькові замінити пробіли
-- на знак ‘_’ (нижнє підкреслення).
SELECT regexp_replace('Ambros Vsevolod Volodymyrovych', ' +', '_', 'g');

-- Створити генератор імені електронної поштової скриньки, що шляхом
-- конкатенації об’єднував би дві перші літери з колонки імені, та чотири перші
-- літери з колонки прізвища користувача, що зберігаються в базі даних, а також
-- домену з вашим прізвищем.
SELECT left("FirstName", 2) || left("LastName", 4) ||
  '@' || 'Амброс' AS email FROM employees;

-- За допомогою SQL визначити, в який день тиждня ви народилися.
SELECT extract(ISODOW FROM to_date('28.05.2000', 'DD.MM.YYYY')) AS day_of_week;

-- II.
-- Вивести усі данні по продуктам, їх категоріям, та постачальникам,
-- навіть якщо останні з певних причин відсутні.
SELECT * FROM products
INNER JOIN categories ON categories."CategoryID" = products."CategoryID"
LEFT JOIN suppliers ON suppliers."SupplierID" = products."SupplierID";

-- Показати усі замовлення, що були зроблені в квітні 1988 року
-- та не були відправлені.
SELECT * FROM orders
WHERE extract(YEAR FROM "OrderDate") = 1998 AND extract(MONTH FROM "OrderDate") = 4
AND "ShippedDate" IS NULL;

-- Відібрати усіх працівників, що відповідають за північний регіон.
-- SELECT * FROM region;
-- SELECT * FROM employees;
SELECT DISTINCT ON (emp."EmployeeID") emp.*
FROM employees AS emp
  JOIN employeeterritories et ON et."EmployeeID" = emp."EmployeeID"
  JOIN territories ter ON ter."TerritoryID" = et."TerritoryID"
  JOIN region ON region."RegionID" = ter."RegionID"
WHERE "RegionDescription" = 'Northern';

-- Вирахувати загальну вартість з урахуванням знижки усіх замовлень,
-- що були здійснені на непарну дату.
SELECT sum(od."UnitPrice" * od."Quantity" * (1 - od."Discount")) AS "total"
FROM orders AS o
JOIN order_details od ON od."OrderID" = o."OrderID"
WHERE cast(extract(DAY FROM o."OrderDate") AS INT) % 2 != 0;

-- Знайти адресу відправлення замовлення з найбільшою ціною (враховуючи усі
-- позиції замовлення, їх вартість, кількість, та наявність знижки).
SELECT "ShipCountry", "ShipCity", "ShipAddress",
  "ShipPostalCode", "Total" AS "Price"
FROM orders AS o
JOIN (
  SELECT "OrderID", ("UnitPrice" * "Quantity" * (1 - "Discount"))
    AS "Total"
  FROM order_details
) AS od ON od."OrderID" = o."OrderID"
WHERE "Total" = (
  SELECT max(od."UnitPrice" * "Quantity" * (1 - od."Discount"))
  FROM orders AS o
    JOIN order_details od ON od."OrderID" = o."OrderID"
);
