-- 1. Створити базу даних з ім’ям, що відповідає вашому
-- прізвищу англійською мовою.
CREATE DATABASE ambros;

-- 2. Створити в новій базі таблицю Student з атрибутами StudentId, SecondName,
-- FirstName, Sex. Обрати для них оптимальний тип даних в вашій СУБД.
CREATE TABLE IF NOT EXISTS ambros.public."Student" (
  "StudentId" INT,
  "SecondName" VARCHAR,
  "FirstName" VARCHAR,
  "Sex" CHAR(1)
);

-- 3. Модифікувати таблицю Student.
-- Атрибут StudentId має стати первинним ключем.
ALTER TABLE ambros.public."Student"
ADD PRIMARY KEY ("StudentId");

-- 4. Модифікувати таблицю Student. Атрибут StudentId повинен
-- заповнюватися автоматично починаючи з 1 і кроком в 1.
CREATE SEQUENCE studentid_seq START 1  INCREMENT 1;

ALTER TABLE ambros.public."Student"
ALTER COLUMN "StudentId"
SET DEFAULT nextval('studentid_seq');

-- 5. Модифікувати таблицю Student. Додати необов’язковий
-- атрибут BirthDate за відповідним типом даних.
ALTER TABLE "Student"
ADD COLUMN "BirthDate" DATE;

-- 6. Модифікувати таблицю Student. Додати атрибут CurrentAge,
-- що генерується автоматично на базі існуючих в таблиці даних.
ALTER TABLE "Student"
ADD COLUMN IF NOT EXISTS "CurrentAge" smallint;

CREATE OR REPLACE FUNCTION calc_age()
  RETURNS TRIGGER
AS $$
  BEGIN
    NEW."CurrentAge" = date_part('year', age(NEW."BirthDate"))::SMALLINT;
    RETURN NEW;
  END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER CALCULATE_AGE
BEFORE INSERT OR UPDATE ON "Student"
FOR EACH ROW EXECUTE PROCEDURE calc_age();

-- 7. Реалізувати перевірку вставлення даних.
-- Значення атрибуту Sex може бути тільки ‘m’ та ‘f’.
ALTER TABLE "Student"
ADD CONSTRAINT sexcheck CHECK ("Sex" = 'm' OR "Sex" = 'f');

-- 8. В таблицю Student додати себе та двох «сусідів» у списку групи.
INSERT INTO "Student"
("SecondName", "FirstName", "Sex")
VALUES ('Ambros', 'Vsevolod', 'm'),
       ('Antosev', 'Oleksandr', 'm'),
       ('Fedorovych', 'Illya', 'm');

-- 9. Створити  представлення vMaleStudent та vFemaleStudent,
-- що надають відповідну інформацію.
CREATE VIEW "vMaleStudent" AS
  SELECT * FROM "Student"
  WHERE "Sex" = 'm';

CREATE VIEW "vFemaleStudent" AS
  SELECT * FROM "Student"
  WHERE "Sex" = 'f';

-- 10. Змінити тип даних первинного ключа на
-- TinyInt (або SmallInt) не втрачаючи дані.
ALTER TABLE "Student"
ALTER COLUMN "StudentId" TYPE SMALLINT;
