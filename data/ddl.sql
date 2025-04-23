-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- File: /home/irisowner/dev/data/ddl.sql
-- IRIS SQL DDL Export
-- Date: 23 Apr 2025 08:52:34
-- Export of: ROLES TABLES/VIEWS PRIVILEGES
-- From Namespace: USER
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- Export of all Role definitions --

-- Export of all Definitions and Privileges for schema 'dc_Sample' --

CREATE TABLE dc_Sample.Person(
    %PUBLICROWID,
    Company    VARCHAR(50),
    DOB        DATE,
    Name       VARCHAR(-1),
    Phone      VARCHAR(-1),
    Title      VARCHAR(50)
)
GO

CREATE INDEX DOBIndex ON dc_Sample.Person(DOB)
GO

