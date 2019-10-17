-- Creating PAYMENT_TYPE...
CREATE TABLE PAYMENT_TYPE
(
  id_type           INT NOT NULL,
  payment_type_name VARCHAR(128),
  description       VARCHAR(256)
);

COMMENT ON TABLE PAYMENT_TYPE
  IS 'Інформація про тип оплати.';
COMMENT ON COLUMN PAYMENT_TYPE.id_type
  IS 'Унікальний ідентифікатор типу оплати.';
COMMENT ON COLUMN PAYMENT_TYPE.payment_type_name
  IS 'Назва типу оплати.';
COMMENT ON COLUMN PAYMENT_TYPE.description
  IS 'Опис типу полати.';
ALTER TABLE PAYMENT_TYPE
  ADD CONSTRAINT PK_PAYMENT_TYPE PRIMARY KEY (ID_TYPE);

-- Creating POSITION...
CREATE TABLE POSITION
(
  id_position   INT          NOT NULL,
  position_name VARCHAR(128) NOT NULL,
  salary        INT,
  description   VARCHAR(1024)
)
;
COMMENT ON TABLE POSITION
  IS 'Опис посад.';
COMMENT ON COLUMN POSITION.id_position
  IS 'Унікальний ідентифікатор посади.';
COMMENT ON COLUMN POSITION.position_name
  IS 'Назва позиції.';
COMMENT ON COLUMN POSITION.salary
  IS 'Заробітна плата.';
COMMENT ON COLUMN POSITION.description
  IS 'Опис посади.';
ALTER TABLE POSITION
  ADD CONSTRAINT PK_POSITION PRIMARY KEY (ID_POSITION)
;

-- Creating STUFF...
CREATE TABLE STUFF
(
  id_stuff    INT NOT NULL,
  id_position INT NOT NULL,
  name        VARCHAR(64),
  surname     VARCHAR(64),
  phone       VARCHAR(64),
  address     VARCHAR(256),
  email       VARCHAR(64)
)
;
COMMENT ON TABLE STUFF
  IS 'Інфнормація про працюючий персонал.';
COMMENT ON COLUMN STUFF.id_stuff
  IS 'Інікальний ідентифікатор робітника.';
COMMENT ON COLUMN STUFF.id_position
  IS 'Ідентифікатор посади.';
COMMENT ON COLUMN STUFF.name
  IS 'Імя працівника.';
COMMENT ON COLUMN STUFF.surname
  IS 'Прізвище працівника.';
COMMENT ON COLUMN STUFF.phone
  IS 'Контактний номер телефону.';
COMMENT ON COLUMN STUFF.address
  IS 'Адреса працівника.';
COMMENT ON COLUMN STUFF.email
  IS 'Електронна поштова адреса.';
ALTER TABLE STUFF
  ADD CONSTRAINT PK_STUFF PRIMARY KEY (ID_STUFF)
;
ALTER TABLE STUFF
  ADD CONSTRAINT FK_STUFF_POSITION FOREIGN KEY (ID_POSITION)
    REFERENCES POSITION (ID_POSITION);

-- Creating INVOICE...
CREATE TABLE INVOICE
(
  id_invoice    INT NOT NULL,
  id_type       INT NOT NULL,
  id_stuff      INT NOT NULL,
  purchase_time DATE
)
;
COMMENT ON TABLE INVOICE
  IS 'Інформація про оплату.';
COMMENT ON COLUMN INVOICE.id_invoice
  IS 'Унікальний ідентифікатор оплати.';
COMMENT ON COLUMN INVOICE.id_type
  IS 'Ідентифікатор типу оплати.';
COMMENT ON COLUMN INVOICE.id_stuff
  IS 'Ідентифікатор працівника, що оформив оплату.';
COMMENT ON COLUMN INVOICE.purchase_time
  IS 'Час виконання оплати.';

-- TODO Параметры индексов

-- CREATE TABLESPACE REPO_DATA LOCATION '/usr/data/olap_lab_02';
CREATE INDEX FK_STUFF ON INVOICE (ID_STUFF);
CREATE INDEX FK_TYPE ON INVOICE (ID_TYPE);

ALTER TABLE INVOICE
  ADD CONSTRAINT PK_INVOICE PRIMARY KEY (ID_INVOICE);
ALTER TABLE INVOICE
  ADD CONSTRAINT FK_INVOICE_PAYMENT_TYPE FOREIGN KEY (ID_TYPE)
    REFERENCES PAYMENT_TYPE (ID_TYPE);
ALTER TABLE INVOICE
  ADD CONSTRAINT FK_INVOICE_STUFF FOREIGN KEY (ID_STUFF)
    REFERENCES STUFF (ID_STUFF);

-- Creating PRODUCT_TYPE...
CREATE TABLE PRODUCT_TYPE
(
  id_product_type   INT NOT NULL,
  product_type_name VARCHAR(128)
)
;
COMMENT ON TABLE PRODUCT_TYPE
  IS 'Інформація про типи продуктів.';
COMMENT ON COLUMN PRODUCT_TYPE.id_product_type
  IS 'Унікальний ідентифікатор типу продукту.';
COMMENT ON COLUMN PRODUCT_TYPE.product_type_name
  IS 'Назва типу продукту.';
ALTER TABLE PRODUCT_TYPE
  ADD CONSTRAINT PK_PRODUCT_TYPE PRIMARY KEY (ID_PRODUCT_TYPE)
;

-- Creating SUPPLIER...
CREATE TABLE SUPPLIER
(
  id_supplier   INT NOT NULL,
  supplier_name VARCHAR(128),
  supplier_info VARCHAR(1024)
)
;
COMMENT ON TABLE SUPPLIER
  IS 'Інформація про постачальників.';
COMMENT ON COLUMN SUPPLIER.id_supplier
  IS 'Унікальний ідентифікатор постачальника.';
COMMENT ON COLUMN SUPPLIER.supplier_name
  IS 'Назва постачальника.';
COMMENT ON COLUMN SUPPLIER.supplier_info
  IS 'Інфомація про постачальника. Адреса, контактний телефон.';
ALTER TABLE SUPPLIER
  ADD CONSTRAINT PK_SUPPLIER PRIMARY KEY (ID_SUPPLIER)
;

-- Creating UNIT...
CREATE TABLE UNIT
(
  id_unit     INT NOT NULL,
  unit_name   VARCHAR(128),
  description VARCHAR(512)
)
;
COMMENT ON COLUMN UNIT.description
  IS 'Опис одиниці виміру.';
ALTER TABLE UNIT
  ADD CONSTRAINT PK_UNIT PRIMARY KEY (ID_UNIT)
;

-- Creating PRODUCT...
CREATE TABLE PRODUCT
(
  id_product      INT          NOT NULL,
  id_product_type INT          NOT NULL,
  id_supplier     INT          NOT NULL,
  id_unit         INT          NOT NULL,
  product_name    VARCHAR(128) NOT NULL,
  description     VARCHAR(128),
  price           INTEGER
)
;
COMMENT ON TABLE PRODUCT
  IS 'Інофрмація про товари.';
COMMENT ON COLUMN PRODUCT.id_product
  IS 'Унікальний ідентифікатор товару.';
COMMENT ON COLUMN PRODUCT.id_product_type
  IS 'Ідентифікатор типу товару.';
COMMENT ON COLUMN PRODUCT.id_supplier
  IS 'Ідентифікатор постачальника.';
COMMENT ON COLUMN PRODUCT.product_name
  IS 'Назва товару.';
COMMENT ON COLUMN PRODUCT.description
  IS 'Опис товару.';
COMMENT ON COLUMN PRODUCT.price
  IS 'Ціна товару.';
ALTER TABLE PRODUCT
  ADD CONSTRAINT PK_PRODUCT PRIMARY KEY (ID_PRODUCT)
;
ALTER TABLE PRODUCT
  ADD CONSTRAINT FK_PROD_PROD_TYPE FOREIGN KEY (ID_PRODUCT_TYPE)
    REFERENCES PRODUCT_TYPE (ID_PRODUCT_TYPE);
ALTER TABLE PRODUCT
  ADD CONSTRAINT FK_PROD_SUPPLIER FOREIGN KEY (ID_SUPPLIER)
    REFERENCES SUPPLIER (ID_SUPPLIER);
ALTER TABLE PRODUCT
  ADD CONSTRAINT FK_PROD_UNIT FOREIGN KEY (ID_UNIT)
    REFERENCES UNIT (ID_UNIT);

-- Creating INVOICE_DETAIL...
CREATE TABLE INVOICE_DETAIL
(
  id_invoice  INT            NOT NULL,
  id_product  INT            NOT NULL,
  quantity    NUMERIC(10, 2) NOT NULL,
  description VARCHAR(500)
)
;
COMMENT ON TABLE INVOICE_DETAIL
  IS 'Оплата за продукти.';
COMMENT ON COLUMN INVOICE_DETAIL.quantity
  IS 'Кількість товару.';
COMMENT ON COLUMN INVOICE_DETAIL.description
  IS 'Опис придбання.';
ALTER TABLE INVOICE_DETAIL
  ADD CONSTRAINT PK_INVOICE_DETAIL PRIMARY KEY (ID_INVOICE, ID_PRODUCT)
;
ALTER TABLE INVOICE_DETAIL
  ADD CONSTRAINT FK_INVOICE_DET_INV FOREIGN KEY (ID_INVOICE)
    REFERENCES INVOICE (ID_INVOICE);
ALTER TABLE INVOICE_DETAIL
  ADD CONSTRAINT FK_INVOICE_DET_PRODUCT FOREIGN KEY (ID_PRODUCT)
    REFERENCES PRODUCT (ID_PRODUCT);

-- Creating TYPE_OPER...
CREATE TABLE TYPE_OPER
(
  id_oper_type INTEGER    NOT NULL,
  name_oper    VARCHAR(3) NOT NULL,
  description  VARCHAR(100)
)
;
COMMENT ON TABLE TYPE_OPER
  IS 'Довідник операцій.';
COMMENT ON COLUMN TYPE_OPER.id_oper_type
  IS 'ідентифікатор операції.';
COMMENT ON COLUMN TYPE_OPER.name_oper
  IS 'Назва операції.';
COMMENT ON COLUMN TYPE_OPER.description
  IS 'Опис типу операції.
';
ALTER TABLE TYPE_OPER
  ADD CONSTRAINT PK_TYPE_OPER PRIMARY KEY (ID_OPER_TYPE)
;

-- Creating STORE...
CREATE TABLE STORE
(
  id_store     INT         NOT NULL,
  id_product   INT         NOT NULL,
  shelf        VARCHAR(10) NOT NULL,
  date_oper    DATE        NOT NULL,
  id_oper_type INTEGER     NOT NULL,
  quantity     INT         NOT NULL
)
;
COMMENT ON TABLE STORE
  IS 'Інформація про склад';
COMMENT ON COLUMN STORE.id_store
  IS 'Унікальний ідентифікатор сховища.';
COMMENT ON COLUMN STORE.id_product
  IS 'Унікальний ідентифікатор продукту.
';
COMMENT ON COLUMN STORE.shelf
  IS 'Номер полиці складу.';
COMMENT ON COLUMN STORE.date_oper
  IS 'дата операції';
COMMENT ON COLUMN STORE.id_oper_type
  IS 'Тип опреції (in,out).';
COMMENT ON COLUMN STORE.quantity
  IS 'Кількітсь товару.';
ALTER TABLE STORE
  ADD CONSTRAINT PK_STORE PRIMARY KEY (ID_STORE)
;
ALTER TABLE STORE
  ADD CONSTRAINT FK_STORE_FK_STORE__TYPE_OPE FOREIGN KEY (ID_OPER_TYPE)
    REFERENCES TYPE_OPER (ID_OPER_TYPE);
ALTER TABLE STORE
  ADD CONSTRAINT FK_STORE_PROD FOREIGN KEY (ID_PRODUCT)
    REFERENCES PRODUCT (ID_PRODUCT);

-- Disabling triggers for PAYMENT_TYPE...
ALTER TABLE PAYMENT_TYPE
  DISABLE TRIGGER ALL;
-- Disabling triggers for POSITION...
ALTER TABLE POSITION
  DISABLE TRIGGER ALL;
-- Disabling triggers for STUFF...
ALTER TABLE STUFF
  DISABLE TRIGGER ALL;
-- Disabling triggers for INVOICE...
ALTER TABLE INVOICE
  DISABLE TRIGGER ALL;
-- Disabling triggers for PRODUCT_TYPE...
ALTER TABLE PRODUCT_TYPE
  DISABLE TRIGGER ALL;
-- Disabling triggers for SUPPLIER...
ALTER TABLE SUPPLIER
  DISABLE TRIGGER ALL;
-- Disabling triggers for UNIT...
ALTER TABLE UNIT
  DISABLE TRIGGER ALL;
-- Disabling triggers for PRODUCT...
ALTER TABLE PRODUCT
  DISABLE TRIGGER ALL;
-- Disabling triggers for INVOICE_DETAIL...
ALTER TABLE INVOICE_DETAIL
  DISABLE TRIGGER ALL;
-- Disabling triggers for TYPE_OPER...
ALTER TABLE TYPE_OPER
  DISABLE TRIGGER ALL;
-- Disabling triggers for STORE...
ALTER TABLE STORE
  DISABLE TRIGGER ALL;
-- Disabling foreign key constraints for STUFF...
-- TODO disable FK
-- alter table STUFF disable constraint FK_STUFF_POSITION;
-- Disabling foreign key constraints for INVOICE...
-- alter table INVOICE disable constraint FK_INVOICE_PAYMENT_TYPE;
-- alter table INVOICE disable constraint FK_INVOICE_STUFF;
-- Disabling foreign key constraints for PRODUCT...
-- alter table PRODUCT disable constraint FK_PROD_PROD_TYPE;
-- alter table PRODUCT disable constraint FK_PROD_SUPPLIER;
-- alter table PRODUCT disable constraint FK_PROD_UNIT;
-- Disabling foreign key constraints for INVOICE_DETAIL...
-- alter table INVOICE_DETAIL disable constraint FK_INVOICE_DET_INV;
-- alter table INVOICE_DETAIL disable constraint FK_INVOICE_DET_PRODUCT;
-- alter table STORE disable constraint FK_STORE_FK_STORE__TYPE_OPE;
-- Disabling foreign key constraints for STORE...
-- alter table STORE disable constraint FK_STORE_PROD;
-- Deleting STORE...
DELETE
FROM STORE;
COMMIT;
-- Deleting TYPE_OPER...
DELETE
FROM TYPE_OPER;
COMMIT;
-- Deleting INVOICE_DETAIL...
DELETE
FROM INVOICE_DETAIL;
COMMIT;
-- Deleting PRODUCT...
DELETE
FROM PRODUCT;
COMMIT;
-- Deleting UNIT...
DELETE
FROM UNIT;
COMMIT;
-- Deleting SUPPLIER...
DELETE
FROM SUPPLIER;
COMMIT;
-- Deleting PRODUCT_TYPE...
DELETE
FROM PRODUCT_TYPE;
COMMIT;
-- Deleting INVOICE...
DELETE
FROM INVOICE;
COMMIT;
-- Deleting STUFF...
DELETE
FROM STUFF;
COMMIT;
-- Deleting POSITION...
DELETE
FROM POSITION;
COMMIT;
-- Deleting PAYMENT_TYPE...
DELETE
FROM PAYMENT_TYPE;
COMMIT;
-- Loading PAYMENT_TYPE...
INSERT INTO PAYMENT_TYPE (id_type, payment_type_name, description)
VALUES (1, 'Готівковий розрахунок', NULL);
INSERT INTO PAYMENT_TYPE (id_type, payment_type_name, description)
VALUES (2, 'Безготівковий розрахонок', NULL);
COMMIT;
-- 2 records loaded
-- Loading POSITION...
INSERT INTO POSITION (id_position, position_name, salary, description)
VALUES (1, 'Продавець-касир', 3000, NULL);
INSERT INTO POSITION (id_position, position_name, salary, description)
VALUES (2, 'Охоронець', 5000, NULL);
INSERT INTO POSITION (id_position, position_name, salary, description)
VALUES (3, 'Менеджер відділу продажу', 7000, NULL);
INSERT INTO POSITION (id_position, position_name, salary, description)
VALUES (4, 'Кухар', 6000, NULL);
INSERT INTO POSITION (id_position, position_name, salary, description)
VALUES (5, 'Пекар', 6000, NULL);
COMMIT;
-- 5 records loaded
-- Loading STUFF...
INSERT INTO STUFF (id_stuff, id_position, name, surname, phone, address, email)
VALUES (1, 1, 'Aaron', 'Smih', '365-54-87', 'Київ', 'Smih@market.com');
INSERT INTO STUFF (id_stuff, id_position, name, surname, phone, address, email)
VALUES (2, 1, 'Adam', 'Thomas', '584-98-44', 'Київ', 'Thomas@market.com');
INSERT INTO STUFF (id_stuff, id_position, name, surname, phone, address, email)
VALUES (3, 1, 'Barry', 'Davies', '063-564-54-54', 'Київ', 'Davies@market.com');
INSERT INTO STUFF (id_stuff, id_position, name, surname, phone, address, email)
VALUES (4, 1, 'Basil', 'White', '097-347-44-99', 'Київ', 'White@market.com');
INSERT INTO STUFF (id_stuff, id_position, name, surname, phone, address, email)
VALUES (5, 1, 'Simon', 'Hughes', '050-54-21', 'Київ', 'Hughes@market.com');
INSERT INTO STUFF (id_stuff, id_position, name, surname, phone, address, email)
VALUES (6, 1, 'Carlton', 'Edwards', '546-21-64', 'Київ', 'Edwards@market.com');
INSERT INTO STUFF (id_stuff, id_position, name, surname, phone, address, email)
VALUES (7, 2, 'Sebastian', 'Green', '878-54-63', 'Київ', 'Green@market.com');
INSERT INTO STUFF (id_stuff, id_position, name, surname, phone, address, email)
VALUES (8, 3, 'Scott', 'Wood', '050-879-54-16', 'Київ', 'Wood@market.com');
INSERT INTO STUFF (id_stuff, id_position, name, surname, phone, address, email)
VALUES (9, 4, 'Galvin', 'Harris', '093-879-23-54', 'Київ', 'Harris@market.com');
INSERT INTO STUFF (id_stuff, id_position, name, surname, phone, address, email)
VALUES (10, 5, 'Bob', 'Martin', '097-213-54-69', 'Київ', 'Martin@market.com');
INSERT INTO STUFF (id_stuff, id_position, name, surname, phone, address, email)
VALUES (11, 4, 'Hunter', 'Anderson', '023-878-54-96', 'Виноградар', 'Anderson@market.com');
COMMIT;
-- 11 records loaded
-- Loading INVOICE...
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (3, 1, 5, to_date('12-09-2011 13:24:43', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (4, 1, 3, to_date('25-09-2011 08:57:03', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (5, 1, 5, to_date('01-08-2012 08:51:18', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (6, 2, 6, to_date('11-03-2013 15:41:48', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (7, 1, 1, to_date('16-02-2012 08:18:04', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (8, 1, 3, to_date('17-10-2012 21:40:40', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (9, 2, 5, to_date('24-12-2012 02:36:56', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (10, 2, 5, to_date('09-06-2013 08:45:01', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (11, 1, 3, to_date('27-09-2011 19:18:38', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (12, 2, 4, to_date('21-01-2014 14:06:15', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (13, 2, 2, to_date('01-10-2012 05:20:36', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (14, 2, 3, to_date('20-01-2014 20:42:28', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (15, 1, 2, to_date('11-08-2013 05:16:26', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (16, 1, 3, to_date('10-02-2012 13:18:18', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (17, 2, 5, to_date('07-02-2013 11:27:05', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (18, 1, 6, to_date('14-01-2012 20:16:22', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (19, 1, 5, to_date('29-10-2012 04:08:29', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (20, 1, 3, to_date('05-10-2012 21:25:57', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (21, 1, 3, to_date('28-05-2013 05:26:35', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (22, 2, 5, to_date('01-12-2013 10:50:08', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (23, 2, 1, to_date('03-11-2013 14:52:01', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (24, 1, 5, to_date('09-04-2013 07:57:24', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (25, 1, 4, to_date('17-07-2013 10:20:27', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (26, 2, 4, to_date('27-11-2011 18:32:05', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (27, 1, 4, to_date('03-08-2012 10:48:37', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (28, 2, 6, to_date('09-03-2012 01:03:23', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (29, 2, 4, to_date('11-11-2013 04:36:39', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (30, 1, 2, to_date('09-01-2014 15:44:54', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (31, 1, 2, to_date('06-05-2012 07:49:15', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (32, 2, 4, to_date('04-09-2013 08:14:46', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (33, 1, 2, to_date('22-07-2013 14:35:10', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (34, 1, 3, to_date('16-11-2013 11:03:24', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (35, 1, 6, to_date('23-02-2013 05:31:46', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (36, 2, 6, to_date('22-10-2012 18:44:39', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (37, 2, 4, to_date('25-01-2013 15:24:26', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (38, 2, 2, to_date('15-04-2013 15:05:48', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (39, 1, 2, to_date('03-12-2013 04:19:46', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (40, 1, 1, to_date('24-12-2013 09:58:12', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (41, 1, 3, to_date('17-05-2013 03:40:53', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (42, 2, 5, to_date('11-02-2013 12:47:52', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (43, 1, 3, to_date('07-02-2012 07:44:03', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (44, 1, 2, to_date('04-01-2014 12:02:39', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (45, 2, 2, to_date('04-05-2012 09:15:55', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (46, 2, 2, to_date('09-09-2011 01:36:13', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (47, 1, 3, to_date('20-01-2013 16:59:33', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (48, 1, 2, to_date('18-10-2012 18:56:28', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (49, 1, 4, to_date('08-12-2012 14:28:05', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (50, 2, 1, to_date('26-04-2012 12:57:33', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (51, 1, 2, to_date('09-09-2012 02:50:28', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (52, 1, 6, to_date('01-07-2013 23:05:28', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (53, 1, 3, to_date('14-01-2013 06:36:47', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (54, 1, 6, to_date('01-11-2013 21:10:02', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (55, 1, 3, to_date('22-09-2011 06:18:04', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (56, 2, 5, to_date('10-08-2012 18:36:02', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (57, 1, 3, to_date('05-02-2012 11:48:44', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (58, 1, 5, to_date('20-03-2013 01:55:39', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (59, 1, 3, to_date('25-05-2011 23:57:59', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (60, 2, 3, to_date('06-12-2011 01:10:27', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (61, 2, 4, to_date('04-09-2012 09:25:25', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (62, 1, 5, to_date('04-11-2013 07:53:38', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (63, 1, 2, to_date('16-05-2012 01:03:31', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (64, 1, 6, to_date('29-06-2013 13:55:40', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (65, 2, 4, to_date('21-08-2011 19:34:44', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (66, 1, 3, to_date('18-08-2013 01:02:38', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (67, 2, 3, to_date('21-06-2011 07:39:50', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (68, 1, 2, to_date('25-11-2011 06:15:42', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (69, 2, 4, to_date('16-09-2012 22:54:17', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (70, 1, 2, to_date('09-02-2013 09:00:59', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (71, 2, 3, to_date('13-12-2013 03:13:58', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (72, 2, 2, to_date('20-01-2012 21:15:45', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (73, 1, 5, to_date('03-04-2012 05:11:38', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (74, 1, 6, to_date('23-11-2011 16:14:37', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (75, 2, 2, to_date('08-07-2011 00:13:37', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (76, 2, 4, to_date('22-07-2013 06:06:43', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (77, 1, 3, to_date('28-10-2011 12:19:24', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (78, 2, 5, to_date('18-09-2012 23:39:35', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (79, 2, 6, to_date('26-04-2013 12:53:43', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (80, 1, 4, to_date('21-07-2011 10:57:36', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (81, 1, 2, to_date('20-03-2012 10:24:23', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (82, 2, 5, to_date('09-07-2013 08:47:30', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (83, 2, 2, to_date('28-02-2013 23:51:41', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (84, 2, 4, to_date('18-11-2012 16:35:27', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (85, 2, 5, to_date('17-07-2012 18:21:57', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (86, 2, 5, to_date('08-01-2012 09:26:12', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (87, 2, 3, to_date('21-08-2013 20:55:45', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (88, 1, 3, to_date('10-08-2011 12:11:45', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (89, 2, 4, to_date('23-02-2013 21:36:16', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (90, 1, 5, to_date('31-05-2011 16:34:18', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (91, 2, 4, to_date('20-07-2011 08:40:25', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (92, 1, 2, to_date('21-08-2011 03:48:55', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (93, 2, 4, to_date('16-06-2013 22:39:09', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (94, 1, 2, to_date('15-02-2013 06:37:04', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (95, 2, 3, to_date('14-06-2013 19:52:18', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (96, 1, 5, to_date('10-08-2012 09:27:01', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (97, 1, 4, to_date('06-02-2013 13:51:03', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (98, 1, 3, to_date('20-10-2013 03:10:14', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (99, 2, 2, to_date('13-12-2011 22:27:04', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (100, 1, 6, to_date('14-12-2011 11:37:45', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (1, 1, 4, to_date('12-02-2012 05:09:10', 'dd-mm-yyyy hh24:mi:ss'));
INSERT INTO INVOICE (id_invoice, id_type, id_stuff, purchase_time)
VALUES (2, 1, 5, to_date('14-10-2011 21:39:12', 'dd-mm-yyyy hh24:mi:ss'));
COMMIT;
-- 100 records loaded
-- Loading PRODUCT_TYPE...
INSERT INTO PRODUCT_TYPE (id_product_type, product_type_name)
VALUES (9, 'Кава');
INSERT INTO PRODUCT_TYPE (id_product_type, product_type_name)
VALUES (1, 'Солодощі');
INSERT INTO PRODUCT_TYPE (id_product_type, product_type_name)
VALUES (2, 'Концерви та пресерви');
INSERT INTO PRODUCT_TYPE (id_product_type, product_type_name)
VALUES (3, 'Молочні продукти');
INSERT INTO PRODUCT_TYPE (id_product_type, product_type_name)
VALUES (4, 'Сири');
INSERT INTO PRODUCT_TYPE (id_product_type, product_type_name)
VALUES (5, 'М`ясо');
INSERT INTO PRODUCT_TYPE (id_product_type, product_type_name)
VALUES (6, 'Ковбаси');
INSERT INTO PRODUCT_TYPE (id_product_type, product_type_name)
VALUES (7, 'Хлібо-булочні вироби');
COMMIT;
-- 8 records loaded
-- Loading SUPPLIER...
INSERT INTO SUPPLIER (id_supplier, supplier_name, supplier_info)
VALUES (1, 'ROSHEN', NULL);
INSERT INTO SUPPLIER (id_supplier, supplier_name, supplier_info)
VALUES (2, 'АВК', NULL);
INSERT INTO SUPPLIER (id_supplier, supplier_name, supplier_info)
VALUES (3, 'Киев-Конти', NULL);
INSERT INTO SUPPLIER (id_supplier, supplier_name, supplier_info)
VALUES (4, 'Nestle', NULL);
INSERT INTO SUPPLIER (id_supplier, supplier_name, supplier_info)
VALUES (5, 'Ferrero', NULL);
INSERT INTO SUPPLIER (id_supplier, supplier_name, supplier_info)
VALUES (6, 'Kraft Food', NULL);
INSERT INTO SUPPLIER (id_supplier, supplier_name, supplier_info)
VALUES (7, 'Словяночка', NULL);
INSERT INTO SUPPLIER (id_supplier, supplier_name, supplier_info)
VALUES (8, 'Простоквашино', NULL);
INSERT INTO SUPPLIER (id_supplier, supplier_name, supplier_info)
VALUES (9, 'Danone', NULL);
INSERT INTO SUPPLIER (id_supplier, supplier_name, supplier_info)
VALUES (10, 'Галичина', NULL);
INSERT INTO SUPPLIER (id_supplier, supplier_name, supplier_info)
VALUES (11, 'Геркулес', NULL);
INSERT INTO SUPPLIER (id_supplier, supplier_name, supplier_info)
VALUES (12, 'Наша Ряба', NULL);
INSERT INTO SUPPLIER (id_supplier, supplier_name, supplier_info)
VALUES (13, 'Сімейні ковбаси', NULL);
INSERT INTO SUPPLIER (id_supplier, supplier_name, supplier_info)
VALUES (14, 'Кременчуцький мясозавод', NULL);
INSERT INTO SUPPLIER (id_supplier, supplier_name, supplier_info)
VALUES (15, 'БКК', NULL);
INSERT INTO SUPPLIER (id_supplier, supplier_name, supplier_info)
VALUES (16, 'Київхліб', NULL);
COMMIT;
-- 16 records loaded
-- Loading UNIT...
INSERT INTO UNIT (id_unit, unit_name, description)
VALUES (1, 'кг', 'кілограм');
INSERT INTO UNIT (id_unit, unit_name, description)
VALUES (2, 'уп', 'упаковка');
INSERT INTO UNIT (id_unit, unit_name, description)
VALUES (3, 'п', 'пачка');
INSERT INTO UNIT (id_unit, unit_name, description)
VALUES (4, 'б', 'банка');
INSERT INTO UNIT (id_unit, unit_name, description)
VALUES (5, 'ящ', 'ящик');
INSERT INTO UNIT (id_unit, unit_name, description)
VALUES (6, 'шт', 'штук');
COMMIT;
-- 6 records loaded
-- Loading PRODUCT...
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (1, 1, 1, 6, 'Чорний шоколад з начинкою «LoungeBar ROSHEN» горіхове праліне', ' sweet', 5);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (2, 1, 1, 6, '«ROSHEN» білий з цілими лісовими горіхами', NULL, 10);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (3, 1, 1, 6, '«Есмеральда» шоколадна зі шматочками шоколадної глазурі', NULL, 10);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (5, 1, 2, 1, '"Королівський Шедевр" з горіховою начинкою та цілим фундуком', NULL, 65);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (6, 1, 2, 1, 'Трюфель молочний', NULL, 55);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (7, 1, 3, 1, 'Цукерки EsfeRo Crema', NULL, 78);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (8, 1, 4, 4, 'Nescafe Gold', NULL, 60);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (9, 3, 7, 2, 'Молоко', NULL, 12);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (10, 4, 7, 1, 'Сир російський', NULL, 65);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (11, 3, 7, 2, 'Кефір', NULL, 12);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (12, 3, 8, 2, 'Сир домашній', NULL, 15);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (13, 3, 8, 2, 'Ряженка', NULL, 15);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (14, 5, 12, 1, 'Курячі гомілки', NULL, 25);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (15, 5, 12, 1, 'Куряче філе', NULL, 30);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (16, 3, 10, 2, 'Йогурт', NULL, 15);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (17, 6, 13, 1, 'Ковбаса докторська', NULL, 100);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (18, 6, 13, 1, 'Ковбаса домашня', NULL, 120);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (19, 6, 13, 1, 'Салямі італійська', NULL, 170);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (20, 5, 14, 1, 'Балик', NULL, 98);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (21, 5, 14, 1, 'Буженіна', NULL, 95);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (22, 7, 15, 6, 'Хліб український', NULL, 4);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (23, 7, 15, 6, 'Хліб білоруський', NULL, 7);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (24, 7, 16, 6, 'Хліб білий', NULL, 3);
INSERT INTO PRODUCT (id_product, id_product_type, id_supplier, id_unit, product_name, description, price)
VALUES (4, 7, 16, 6, 'Паляниця', NULL, 3);
COMMIT;
-- 24 records loaded
-- Loading INVOICE_DETAIL...
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (2, 9, 3, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (3, 15, 10, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (4, 12, 6, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (5, 16, 10, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (6, 16, 2, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (7, 19, 3, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (8, 18, 5, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (9, 16, 3, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (10, 6, 9, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (11, 5, 5, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (12, 9, 8, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (13, 14, 3, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (14, 22, 9, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (15, 16, 5, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (16, 2, 8, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (17, 8, 4, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (18, 7, 4, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (19, 6, 8, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (20, 13, 5, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (21, 1, 2, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (22, 6, 2, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (23, 4, 9, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (24, 4, 5, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (25, 15, 1, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (26, 7, 7, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (27, 11, 3, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (28, 6, 9, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (29, 20, 4, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (30, 22, 4, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (31, 6, 6, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (32, 4, 11, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (33, 5, 10, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (34, 10, 11, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (35, 22, 4, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (36, 18, 8, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (37, 9, 5, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (38, 23, 4, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (39, 5, 6, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (40, 4, 3, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (41, 7, 3, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (42, 9, 2, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (43, 14, 4, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (44, 13, 3, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (45, 14, 3, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (46, 14, 6, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (47, 8, 8, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (48, 9, 3, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (49, 2, 7, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (50, 3, 1, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (51, 3, 10, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (52, 3, 10, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (53, 11, 3, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (54, 22, 7, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (55, 17, 5, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (56, 2, 2, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (57, 12, 4, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (58, 9, 9, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (59, 20, 7, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (60, 4, 8, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (61, 4, 10, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (62, 11, 3, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (63, 22, 2, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (64, 20, 5, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (65, 1, 2, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (66, 8, 4, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (67, 10, 3, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (68, 4, 8, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (69, 11, 4, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (70, 18, 4, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (71, 16, 6, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (72, 7, 1, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (73, 11, 10, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (74, 7, 2, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (75, 8, 6, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (76, 22, 3, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (77, 13, 7, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (78, 5, 1, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (79, 1, 10, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (80, 9, 6, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (81, 7, 3, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (82, 21, 2, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (83, 14, 3, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (84, 20, 10, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (85, 13, 2, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (86, 3, 6, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (87, 5, 5, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (88, 19, 7, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (89, 21, 8, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (90, 8, 3, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (91, 15, 8, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (92, 14, 6, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (93, 15, 6, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (94, 7, 5, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (95, 3, 6, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (96, 5, 8, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (97, 12, 7, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (98, 9, 3, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (99, 17, 2, NULL);
INSERT INTO INVOICE_DETAIL (id_invoice, id_product, quantity, description)
VALUES (100, 23, 11, NULL);
COMMIT;
-- 99 records loaded
-- Loading TYPE_OPER...
INSERT INTO TYPE_OPER (id_oper_type, name_oper, description)
VALUES (1, 'IN', 'Надходження до складу.');
INSERT INTO TYPE_OPER (id_oper_type, name_oper, description)
VALUES (2, 'OUT', NULL);
COMMIT;
-- 2 records loaded
-- Loading STORE...
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (1, 24, '7', to_date('22-05-2012 21:14:02', 'dd-mm-yyyy hh24:mi:ss'), 1, 9);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (2, 17, '15', to_date('16-11-2013 09:54:21', 'dd-mm-yyyy hh24:mi:ss'), 1, 5);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (3, 7, '13', to_date('20-05-2012 01:12:18', 'dd-mm-yyyy hh24:mi:ss'), 2, 1);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (4, 21, '14', to_date('08-08-2013 17:16:10', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (5, 15, '1', to_date('14-06-2012 18:34:32', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (6, 11, '15', to_date('01-09-2011 16:16:32', 'dd-mm-yyyy hh24:mi:ss'), 2, 8);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (7, 13, '17', to_date('26-11-2013 22:10:58', 'dd-mm-yyyy hh24:mi:ss'), 2, 8);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (8, 13, '9', to_date('20-04-2013 13:11:13', 'dd-mm-yyyy hh24:mi:ss'), 2, 9);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (9, 23, '11', to_date('01-01-2014 14:11:30', 'dd-mm-yyyy hh24:mi:ss'), 2, 4);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (10, 6, '12', to_date('01-08-2013 19:20:29', 'dd-mm-yyyy hh24:mi:ss'), 2, 8);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (11, 21, '7', to_date('28-09-2013 11:20:31', 'dd-mm-yyyy hh24:mi:ss'), 2, 10);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (12, 17, '15', to_date('05-03-2013 10:35:54', 'dd-mm-yyyy hh24:mi:ss'), 1, 5);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (13, 11, '6', to_date('15-05-2013 09:14:03', 'dd-mm-yyyy hh24:mi:ss'), 1, 5);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (14, 24, '4', to_date('18-12-2013 08:15:11', 'dd-mm-yyyy hh24:mi:ss'), 1, 10);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (15, 19, '14', to_date('15-02-2012 08:31:12', 'dd-mm-yyyy hh24:mi:ss'), 1, 4);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (16, 23, '5', to_date('09-08-2013 08:14:07', 'dd-mm-yyyy hh24:mi:ss'), 1, 5);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (17, 6, '12', to_date('16-07-2013 06:52:47', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (18, 13, '11', to_date('03-11-2011 16:10:13', 'dd-mm-yyyy hh24:mi:ss'), 1, 2);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (19, 23, '17', to_date('27-07-2012 07:36:18', 'dd-mm-yyyy hh24:mi:ss'), 1, 3);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (20, 10, '11', to_date('22-07-2013 14:19:40', 'dd-mm-yyyy hh24:mi:ss'), 2, 6);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (21, 5, '7', to_date('30-09-2011 15:17:05', 'dd-mm-yyyy hh24:mi:ss'), 1, 4);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (22, 7, '7', to_date('17-02-2013 18:08:34', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (23, 5, '20', to_date('21-07-2011 15:46:42', 'dd-mm-yyyy hh24:mi:ss'), 2, 1);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (24, 17, '16', to_date('12-11-2011 11:01:37', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (25, 3, '3', to_date('25-08-2011 00:42:06', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (26, 23, '2', to_date('23-05-2013 14:16:33', 'dd-mm-yyyy hh24:mi:ss'), 2, 2);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (27, 12, '9', to_date('01-09-2012 22:28:36', 'dd-mm-yyyy hh24:mi:ss'), 1, 10);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (28, 13, '17', to_date('28-09-2012 21:48:09', 'dd-mm-yyyy hh24:mi:ss'), 2, 10);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (29, 18, '15', to_date('29-11-2011 09:50:10', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (30, 24, '11', to_date('05-02-2013 19:44:18', 'dd-mm-yyyy hh24:mi:ss'), 1, 4);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (31, 1, '13', to_date('09-04-2013 08:10:42', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (32, 9, '7', to_date('15-08-2011 17:01:05', 'dd-mm-yyyy hh24:mi:ss'), 2, 10);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (33, 9, '16', to_date('19-01-2012 22:30:10', 'dd-mm-yyyy hh24:mi:ss'), 1, 3);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (34, 4, '10', to_date('05-01-2012 11:08:56', 'dd-mm-yyyy hh24:mi:ss'), 1, 1);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (35, 16, '11', to_date('14-08-2012 21:50:13', 'dd-mm-yyyy hh24:mi:ss'), 2, 8);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (36, 19, '3', to_date('05-12-2012 08:03:59', 'dd-mm-yyyy hh24:mi:ss'), 1, 3);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (37, 9, '2', to_date('21-08-2011 17:00:04', 'dd-mm-yyyy hh24:mi:ss'), 2, 8);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (38, 18, '15', to_date('30-05-2013 03:46:16', 'dd-mm-yyyy hh24:mi:ss'), 2, 7);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (39, 12, '4', to_date('02-05-2013 21:13:05', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (40, 23, '18', to_date('25-04-2013 18:03:30', 'dd-mm-yyyy hh24:mi:ss'), 2, 7);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (41, 24, '4', to_date('19-08-2011 01:21:17', 'dd-mm-yyyy hh24:mi:ss'), 2, 4);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (42, 20, '9', to_date('13-01-2013 02:08:47', 'dd-mm-yyyy hh24:mi:ss'), 1, 4);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (43, 13, '13', to_date('13-06-2011 08:57:10', 'dd-mm-yyyy hh24:mi:ss'), 2, 9);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (44, 3, '11', to_date('10-10-2012 14:13:29', 'dd-mm-yyyy hh24:mi:ss'), 1, 3);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (45, 21, '19', to_date('15-07-2011 19:21:25', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (46, 20, '10', to_date('19-12-2012 09:26:49', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (47, 12, '2', to_date('07-06-2012 18:06:56', 'dd-mm-yyyy hh24:mi:ss'), 2, 7);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (48, 16, '18', to_date('26-03-2013 19:05:52', 'dd-mm-yyyy hh24:mi:ss'), 1, 8);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (49, 2, '6', to_date('04-10-2012 06:46:01', 'dd-mm-yyyy hh24:mi:ss'), 2, 4);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (50, 10, '6', to_date('06-12-2011 18:02:35', 'dd-mm-yyyy hh24:mi:ss'), 1, 3);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (51, 4, '15', to_date('30-05-2013 03:46:16', 'dd-mm-yyyy hh24:mi:ss'), 2, 1);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (52, 17, '1', to_date('01-01-2013 00:11:03', 'dd-mm-yyyy hh24:mi:ss'), 2, 6);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (53, 13, '18', to_date('26-10-2012 17:35:00', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (54, 6, '6', to_date('07-10-2011 16:57:07', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (55, 20, '11', to_date('01-02-2012 09:12:51', 'dd-mm-yyyy hh24:mi:ss'), 2, 2);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (56, 6, '8', to_date('10-08-2013 00:45:12', 'dd-mm-yyyy hh24:mi:ss'), 1, 9);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (57, 2, '13', to_date('03-09-2013 06:33:48', 'dd-mm-yyyy hh24:mi:ss'), 1, 6);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (58, 13, '16', to_date('02-06-2012 08:04:54', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (59, 4, '9', to_date('22-06-2013 01:26:21', 'dd-mm-yyyy hh24:mi:ss'), 2, 5);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (60, 8, '10', to_date('26-12-2011 02:39:26', 'dd-mm-yyyy hh24:mi:ss'), 2, 4);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (61, 17, '3', to_date('03-03-2013 10:24:25', 'dd-mm-yyyy hh24:mi:ss'), 2, 8);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (62, 5, '19', to_date('18-05-2012 14:52:32', 'dd-mm-yyyy hh24:mi:ss'), 1, 2);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (63, 15, '2', to_date('07-01-2014 17:40:12', 'dd-mm-yyyy hh24:mi:ss'), 1, 10);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (64, 3, '9', to_date('28-05-2013 02:01:33', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (65, 21, '9', to_date('11-05-2013 08:12:40', 'dd-mm-yyyy hh24:mi:ss'), 1, 2);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (66, 7, '17', to_date('03-07-2013 08:02:53', 'dd-mm-yyyy hh24:mi:ss'), 1, 8);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (67, 13, '2', to_date('16-05-2013 14:11:38', 'dd-mm-yyyy hh24:mi:ss'), 1, 8);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (68, 19, '17', to_date('13-10-2013 16:33:00', 'dd-mm-yyyy hh24:mi:ss'), 1, 6);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (69, 16, '8', to_date('17-04-2012 19:22:57', 'dd-mm-yyyy hh24:mi:ss'), 1, 8);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (70, 3, '11', to_date('04-04-2012 01:19:20', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (71, 22, '8', to_date('26-07-2013 00:10:16', 'dd-mm-yyyy hh24:mi:ss'), 2, 5);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (72, 18, '7', to_date('03-08-2013 15:44:20', 'dd-mm-yyyy hh24:mi:ss'), 1, 1);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (73, 24, '10', to_date('17-03-2012 03:07:07', 'dd-mm-yyyy hh24:mi:ss'), 1, 6);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (74, 10, '17', to_date('14-10-2011 02:39:15', 'dd-mm-yyyy hh24:mi:ss'), 1, 1);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (75, 16, '3', to_date('03-05-2012 20:09:05', 'dd-mm-yyyy hh24:mi:ss'), 2, 10);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (76, 15, '11', to_date('24-12-2011 15:20:51', 'dd-mm-yyyy hh24:mi:ss'), 2, 2);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (77, 22, '15', to_date('04-07-2012 14:09:14', 'dd-mm-yyyy hh24:mi:ss'), 1, 8);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (78, 23, '17', to_date('12-06-2012 03:53:04', 'dd-mm-yyyy hh24:mi:ss'), 2, 9);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (79, 19, '16', to_date('09-07-2012 17:15:30', 'dd-mm-yyyy hh24:mi:ss'), 2, 8);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (80, 6, '16', to_date('16-10-2012 05:07:19', 'dd-mm-yyyy hh24:mi:ss'), 1, 9);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (81, 4, '4', to_date('18-12-2011 19:14:29', 'dd-mm-yyyy hh24:mi:ss'), 2, 6);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (82, 22, '20', to_date('22-02-2012 10:58:35', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (83, 21, '6', to_date('04-07-2011 07:41:05', 'dd-mm-yyyy hh24:mi:ss'), 2, 5);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (84, 19, '9', to_date('10-09-2012 18:24:29', 'dd-mm-yyyy hh24:mi:ss'), 2, 2);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (85, 8, '12', to_date('03-05-2012 21:03:34', 'dd-mm-yyyy hh24:mi:ss'), 2, 8);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (86, 11, '7', to_date('01-12-2012 07:43:31', 'dd-mm-yyyy hh24:mi:ss'), 1, 3);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (87, 13, '13', to_date('02-08-2011 01:53:09', 'dd-mm-yyyy hh24:mi:ss'), 2, 8);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (88, 11, '14', to_date('24-07-2012 01:06:20', 'dd-mm-yyyy hh24:mi:ss'), 1, 6);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (89, 5, '14', to_date('11-10-2011 08:11:48', 'dd-mm-yyyy hh24:mi:ss'), 2, 6);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (90, 7, '12', to_date('06-06-2011 19:11:55', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (91, 10, '3', to_date('16-11-2013 09:28:41', 'dd-mm-yyyy hh24:mi:ss'), 2, 7);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (92, 22, '12', to_date('21-10-2013 14:01:39', 'dd-mm-yyyy hh24:mi:ss'), 1, 9);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (93, 3, '11', to_date('12-02-2013 15:30:28', 'dd-mm-yyyy hh24:mi:ss'), 2, 9);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (94, 16, '14', to_date('09-06-2012 14:30:30', 'dd-mm-yyyy hh24:mi:ss'), 1, 7);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (95, 8, '12', to_date('10-07-2013 03:34:16', 'dd-mm-yyyy hh24:mi:ss'), 2, 7);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (96, 21, '17', to_date('15-07-2013 08:50:07', 'dd-mm-yyyy hh24:mi:ss'), 2, 1);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (97, 4, '14', to_date('30-08-2012 04:22:53', 'dd-mm-yyyy hh24:mi:ss'), 1, 1);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (98, 6, '11', to_date('05-09-2012 05:11:05', 'dd-mm-yyyy hh24:mi:ss'), 2, 9);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (99, 9, '15', to_date('11-12-2013 09:54:21', 'dd-mm-yyyy hh24:mi:ss'), 2, 3);
INSERT INTO STORE (id_store, id_product, shelf, date_oper, id_oper_type, quantity)
VALUES (100, 2, '8', to_date('11-08-2012 19:46:56', 'dd-mm-yyyy hh24:mi:ss'), 1, 8);
COMMIT;
-- 100 records loaded
-- TODO Enable FK
-- Enabling foreign key constraints for STUFF...
-- alter table STUFF enable constraint FK_STUFF_POSITION;
-- Enabling foreign key constraints for INVOICE...
-- alter table INVOICE enable constraint FK_INVOICE_PAYMENT_TYPE;
-- alter table INVOICE enable constraint FK_INVOICE_STUFF;
-- Enabling foreign key constraints for PRODUCT...
-- alter table PRODUCT enable constraint FK_PROD_PROD_TYPE;
-- alter table PRODUCT enable constraint FK_PROD_SUPPLIER;
-- alter table PRODUCT enable constraint FK_PROD_UNIT;
-- Enabling foreign key constraints for INVOICE_DETAIL...
-- alter table INVOICE_DETAIL enable constraint FK_INVOICE_DET_INV;
-- alter table INVOICE_DETAIL enable constraint FK_INVOICE_DET_PRODUCT;
-- Enabling foreign key constraints for STORE...
-- alter table STORE enable constraint FK_STORE_FK_STORE__TYPE_OPE;
-- alter table STORE enable constraint FK_STORE_PROD;
-- Enabling triggers for PAYMENT_TYPE...
ALTER TABLE PAYMENT_TYPE
  ENABLE TRIGGER ALL;
-- Enabling triggers for POSITION...
ALTER TABLE POSITION
  ENABLE TRIGGER ALL;
-- Enabling triggers for STUFF...
ALTER TABLE STUFF
  ENABLE TRIGGER ALL;
-- Enabling triggers for INVOICE...
ALTER TABLE INVOICE
  ENABLE TRIGGER ALL;
-- Enabling triggers for PRODUCT_TYPE...
ALTER TABLE PRODUCT_TYPE
  ENABLE TRIGGER ALL;
-- Enabling triggers for SUPPLIER...
ALTER TABLE SUPPLIER
  ENABLE TRIGGER ALL;
-- Enabling triggers for UNIT...
ALTER TABLE UNIT
  ENABLE TRIGGER ALL;
-- Enabling triggers for PRODUCT...
ALTER TABLE PRODUCT
  ENABLE TRIGGER ALL;
-- Enabling triggers for INVOICE_DETAIL...
ALTER TABLE INVOICE_DETAIL
  ENABLE TRIGGER ALL;
-- Enabling triggers for TYPE_OPER...
ALTER TABLE TYPE_OPER
  ENABLE TRIGGER ALL;
-- Enabling triggers for STORE...
ALTER TABLE STORE
  ENABLE TRIGGER ALL;

-- Done.
