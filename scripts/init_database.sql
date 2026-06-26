-- ==============================================================================================
                -- CREATING DATABASE AND SCHEMAS
                -- First dropping the database if it exists and then creating a new one. Then creating the three schemas: bronze, silver, and gold.
-- ==============================================================================================

DROP DATABASE if EXISTS datawarehouse; -- Dropping the database

CREATE DATABASE datawarehouse; -- Creating the database

CREATE SCHEMA IF NOT EXISTS bronze; -- Creating the bronze schema

CREATE SCHEMA IF NOT EXISTS silver; -- Creating the silver schema

CREATE SCHEMA IF NOT EXISTS gold; -- Creating the gold schema