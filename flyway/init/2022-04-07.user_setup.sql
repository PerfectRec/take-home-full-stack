-- this script should be run for any newly provisioned live DB in AWS such that the application user
-- is established. the live application expects this user to exist.

-- create admin role
CREATE ROLE admin CREATEDB;
GRANT CONNECT ON DATABASE perfectrec TO admin;

-- grant access to all existing tables and views in public schema
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO admin;

-- grant access to all future tables and views in public schema
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO admin;

-- create user for www. don't forget to provision the user credentials into AWS Secrets Manager.
CREATE USER www WITH PASSWORD '<PASSWORD_HERE>';
GRANT admin TO www;
ALTER USER www WITH CREATEDB;
