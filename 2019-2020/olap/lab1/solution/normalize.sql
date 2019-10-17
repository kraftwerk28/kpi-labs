DROP TABLE staff CASCADE;
DROP TABLE products CASCADE;
DROP TABLE suppliers CASCADE;
DROP TABLE invoices CASCADE;
DROP TABLE shelves CASCADE;
DROP TABLE store CASCADE;
DROP TABLE ordered_books CASCADE;
DROP TABLE book_writes CASCADE;


DROP TYPE OP_TYPE;
CREATE TYPE OP_TYPE AS ENUM ('in', 'out');

DROP TYPE BINDING_TYPE;
CREATE TYPE BINDING_TYPE AS ENUM ('soft', 'hard', 'glossy');

DROP TYPE GENRE;
CREATE TYPE GENRE AS ENUM (
  'adventure',
  'novel',
  'thriller',
  'stories',
  'documentation',
  'sci-fi',
  'children''s'
);

CREATE TABLE IF NOT EXISTS staff (
  staff_id SERIAL PRIMARY KEY,
  staff_name VARCHAR(128),
  e_mail VARCHAR(128)
);

CREATE TABLE IF NOT EXISTS products (
  product_id SERIAL PRIMARY KEY,
  product_name VARCHAR(128),
  supplier_id INT,
  parent_product int DEFAULT NULL,
  sub_product INT DEFAULT NULL,
  price INT,
  binding_type BINDING_TYPE,
  genre GENRE
);

CREATE TABLE IF NOT EXISTS suppliers (
  supplier_id SERIAL PRIMARY KEY,
  supplier_name VARCHAR(128)
);

CREATE TABLE IF NOT EXISTS invoices (
  invoice_id  SERIAL PRIMARY KEY,
  product_id INT,
  invoice_date TIMESTAMP
);

CREATE TABLE IF NOT EXISTS shelves (
  shelf_id SERIAL PRIMARY KEY,
  shelf_number INT
);

CREATE TABLE IF NOT EXISTS store (
  staff_id INT,
  product_id INT,
  shelf_id INT,
  quantity INT NOT NULL DEFAULT 0,
  oper_type OP_TYPE NOT NULL DEFAULT 'out',
  store_date TIMESTAMP
);

CREATE TABLE IF NOT EXISTS authors (
  author_id SERIAL PRIMARY KEY,
  author_name VARCHAR(128),
  author_surname VARCHAR(128)
);

CREATE TABLE IF NOT EXISTS book_writes (
  author_id INT,
  product_id INT,
  FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ordered_books (
  product_id INT,
  invoice_id INT,
  FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
  FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id) ON DELETE CASCADE
);

-- ALTER TABLE products
--   ADD CONSTRAINT author_id_fk FOREIGN KEY (author_id) REFERENCES authors(author_id)

ALTER TABLE products
  ADD CONSTRAINT supplier_id_fk FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
  ON DELETE CASCADE;

ALTER TABLE products
  ADD CONSTRAINT sub_product_id_fk FOREIGN KEY (sub_product) REFERENCES products(product_id)
    ON DELETE CASCADE;

-- ALTER TABLE invoices
--   ADD CONSTRAINT product_id_fk FOREIGN KEY (product_id) REFERENCES products(product_id)
--   ON DELETE CASCADE;

ALTER TABLE store
  ADD CONSTRAINT staff_id_fk FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
  ON DELETE CASCADE;
ALTER TABLE store
  ADD CONSTRAINT product_id_fk FOREIGN KEY (product_id) REFERENCES products(product_id)
  ON DELETE CASCADE;
ALTER TABLE store
  ADD CONSTRAINT shelf_id_fk FOREIGN KEY (shelf_id) REFERENCES shelves(shelf_id)
  ON DELETE CASCADE;

-- ALTER TABLE prices
--   ADD CONSTRAINT price_id_fk FOREIGN KEY (product_id) REFERENCES products(product_id);
