-- 1. Показати ранг кожного товару у групі/категорії (відповідно до зменшення ціни
-- в групі). Запит реалізувати через функції rank() та dense_rank(). Порівняти
-- результати виконання. Крім того сформуйте запит без використання аналітичних
-- функцій.
SELECT product_name,
       rank() OVER (
           PARTITION BY pr.id_product_type
           ORDER BY price DESC
           ) "Rank of price"
FROM product pr;

SELECT product_name,
       dense_rank() OVER (
           PARTITION BY pr.id_product_type
           ORDER BY price DESC
           ) "Dense rank of price"
FROM product pr;


SELECT product_name,
       (
           SELECT count(*) + 1
           FROM product pp
           WHERE pp.id_product_type = p.id_product_type
             AND pp.price > p.price
       )
FROM product p;

-- 2. За допомогою аналітичного SQL сформуйте запит для виведення списку із трьох
-- найдешевших товарів у кожній групі. Крім того сформуйте запит без
-- використання аналітичних функцій.

WITH ranked_price AS (
    SELECT product_type_name "Group",
           product_name      "Name",
           rank() OVER (
               PARTITION BY product_type_name ORDER BY price
               )             rp
    FROM product pr
             JOIN product_type pt ON pr.id_product_type = pt.id_product_type
)
SELECT *
FROM ranked_price
WHERE rp <= 3;

WITH ranked_price AS (
    SELECT product_type_name,
           product_name,
           (
               SELECT count(*) + 1
               FROM product pp
               WHERE pp.id_product_type = pr.id_product_type
                 AND pp.price > pr.price
           ) rp
    FROM product pr
             JOIN product_type pt ON pr.id_product_type = pt.id_product_type
)
SELECT *
FROM ranked_price
WHERE rp <= 3;

-- 3. F1 – продукти по яким здійснюються продажі, f2 – номер місяця, f3 –
-- продажі по товару за певний місяць 2012 року, f4 – продажі по товару за
-- певний місяць 2013 року, f5 – наростаючий підсумок продажів по товару за
-- певний місяць 2012 року, f5 – наростаючий підсумок продажів по товару за
-- певний місяць 2013 року.

WITH invoice_2012_2013 AS (
    SELECT *
    FROM (
             SELECT inv.id_invoice,
                    date_part('year', purchase_time)  purchase_year,
                    date_part('month', purchase_time) purchase_month,
                    id_product,
                    quantity
             FROM invoice inv
                      JOIN invoice_detail inv_d
                           ON inv.id_invoice = inv_d.id_invoice
         ) i
    WHERE purchase_year IN (2012, 2013)
),
     invoice_2012 AS (
         SELECT *
         FROM invoice_2012_2013
         WHERE purchase_year = 2012
     ),
     invoice_2013 AS (
         SELECT *
         FROM invoice_2012_2013
         WHERE purchase_year = 2013
     ),
     all_income AS (
         SELECT product_name,
                product_type_name,
                inv_all.purchase_month,
                sum(inv_2012.quantity * price) AS income_2012,
                sum(inv_2013.quantity * price) AS income_2013
         FROM product p
                  JOIN invoice_2012_2013 inv_all
                       ON p.id_product = inv_all.id_product
                  JOIN product_type pt
                       ON pt.id_product_type = p.id_product_type
                  LEFT JOIN invoice_2012 inv_2012
                            ON inv_all.id_invoice = inv_2012.id_invoice
                                AND inv_all.id_product = inv_2012.id_product
                  LEFT JOIN invoice_2013 inv_2013
                            ON inv_all.id_invoice = inv_2013.id_invoice
                                AND inv_all.id_product = inv_2013.id_product
         GROUP BY product_name, product_type_name, inv_all.purchase_month
     )
SELECT *,
       sum(income_2012) OVER (
           PARTITION BY product_name
           ORDER BY purchase_month
           ) income_2012,
       sum(income_2013) OVER (
           PARTITION BY product_name
           ORDER BY purchase_month
           ) income_2013
FROM all_income;

-- 4. Показати, які товари по кожній групі мають найбільші та найменші продажі.
-- Крім того сформуйте запит без використання аналітичних функцій.
WITH pr AS (
    SELECT id_product_type,
           p.id_product,
           product_name,
           sum(quantity * price) AS income
    FROM product p
             JOIN invoice_detail id
                  ON p.id_product = id.id_product
    GROUP BY p.id_product
),
     max_product AS (
         SELECT product_type_name,
                product_name,
                income,
                first_value(income) OVER (
                    PARTITION BY pt.id_product_type
                    ORDER BY income
                    ) AS min_sales,
                last_value(income) OVER (
                    PARTITION BY pt.id_product_type
                    ORDER BY income
                    ) AS max_sales
         FROM pr
                  JOIN product_type pt
                       ON pr.id_product_type = pt.id_product_type
     )
SELECT product_type_name,
       product_name,
       income
FROM max_product
WHERE income = max_sales
   OR income = min_sales;

-- 5. По кожному товару підрахувати кількість товарів, у яких вартість вища від
-- даного товару у діапазоні від 5 до 10 включно. Наприклад якщо прайс
-- товару 6, то знайти кількість товарів, у яких діапазон прайсів від 11 до 16.
SELECT product_name,
       price,
       count(*) OVER (
           ORDER BY price
           RANGE BETWEEN 5 FOLLOWING
               AND 10 FOLLOWING
           )
FROM product;


-- 6. По кожному товару вивести першу(f3) та останню(f4) дату продажів по
-- кожному місяцю, cуму продажів (f5), відсоток від річної суми(f6).
WITH ext_invoice AS (
    SELECT *,
           date_part('year', purchase_time)  AS year_of_purchase,
           date_part('month', purchase_time) AS month_of_purchase
    FROM invoice
),
     prd AS (SELECT p.id_product,
                    year_of_purchase,
                    sum(quantity * price) AS year_income
             FROM product p
                      JOIN invoice_detail id
                           ON p.id_product = id.id_product
                      JOIN ext_invoice ei ON id.id_invoice = ei.id_invoice
             GROUP BY p.id_product, year_of_purchase)
SELECT product_name,
       ei.year_of_purchase,
       month_of_purchase,
       first_value(purchase_time) OVER (
           PARTITION BY product_name, ei.year_of_purchase, month_of_purchase
           ORDER BY purchase_time
           )                                     first_purchase,
       first_value(purchase_time) OVER (
           PARTITION BY product_name, ei.year_of_purchase, month_of_purchase
           ORDER BY purchase_time DESC
           )                                     last_purchase,
       sum(quantity * price)                     month_income,
       sum(quantity * price) / year_income * 100 month_to_year_income
FROM product p
         JOIN invoice_detail id
              ON p.id_product = id.id_product
         JOIN ext_invoice ei
              ON id.id_invoice = ei.id_invoice
         JOIN prd yp ON p.id_product = yp.id_product AND ei.year_of_purchase = yp.year_of_purchase
GROUP BY product_name,
         ei.year_of_purchase,
         month_of_purchase,
         purchase_time,
         year_income;

-- 7. За допомогою ROLLUP та CUBE виведіть проміжні суми продажу по групам
-- товарів.
SELECT product_type_name,
       product_name,
       sum(quantity * price)
FROM product p
         JOIN product_type pt
              ON p.id_product_type = pt.id_product_type
         JOIN invoice_detail id
              ON p.id_product = id.id_product
GROUP BY
    ROLLUP (product_type_name, product_name)
ORDER BY product_type_name, product_name;

SELECT product_type_name,
       date_part('year', purchase_time),
       sum(quantity * price)
FROM product p
         JOIN product_type pt
              ON p.id_product_type = pt.id_product_type
         JOIN invoice_detail id
              ON p.id_product = id.id_product
         JOIN invoice i
              ON id.id_invoice = i.id_invoice
GROUP BY
    CUBE (product_type_name, date_part('year', purchase_time))
ORDER BY product_type_name;
