-- Create the user
CREATE USER task1
WITH PASSWORD 'OLAP';
-- ALTER USER task1
-- 	WITH PASSWORD 'OLAP';
-- create user TASK1
-- identified by "OLAP"
--   default tablespace USERS
--   temporary tablespace TEMP
--   profile DEFAULT;

-- Grant/Revoke role privileges
GRANT CONNECT ON DATABASE olap_lab1 TO task1;
GRANT ALL PRIVILEGES ON DATABASE olap_lab1 TO task1;
-- grant resource to TASK1;

-- Grant/Revoke system privileges
-- grant unlimited tablespace to TASK1;
