-- =============================================================================
-- Bronze Layer Data Loading
----------------------------

-- Purpose:
-- Loads raw CSV files into the Bronze layer tables of the data warehouse.
--------------------------------------------------------------------------

-- Notes:
-- 1. This script uses the psql '\copy' command, which reads files from the
--    local machine. It cannot be executed from DBeaver's SQL editor.
-- 2. Update the CSV file paths to match your local environment before running.
-- 3. Existing data is truncated before loading to prevent duplicate records.
-----------------------------------------------------------------------------

-- Execution:
-- Run this script using the PostgreSQL psql client.
-- =============================================================================

CREATE PROCEDURE load_bronze()
LANGUAGE plpgsql
AS $$
BEGIN
    TRUNCATE TABLE bronze.crm_cus_info;
    TRUNCATE TABLE bronze.crm_prd_info;
    TRUNCATE TABLE bronze.crm_sales_details;
    TRUNCATE TABLE bronze.erp_cust_az12;
    TRUNCATE TABLE bronze.erp_loc_a101;
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;

    \copy bronze.crm_cus_info FROM 'C:\Users\obaid\Downloads\sql-data-warehouse-project-main\datasets\source_crm\crm_cus_info.csv'
    WITH (
        FORMAT csv,
        DELIMITER ',',
        HEADER true
    );

    \copy bronze.crm_prd_info FROM 'C:\Users\obaid\Downloads\sql-data-warehouse-project-main\datasets\source_crm\crm_prd_info.csv'
    WITH (
        FORMAT csv,
        DELIMITER ',',
        HEADER true
    );

    \copy bronze.crm_sales_details FROM 'C:\Users\obaid\Downloads\sql-data-warehouse-project-main\datasets\source_crm\crm_sales_details.csv'
    WITH (
        FORMAT csv,
        DELIMITER ',',
        HEADER true
    );

    \copy bronze.erp_cust_az12 FROM 'C:\Users\obaid\Downloads\sql-data-warehouse-project-main\datasets\source_erp\erp_cust_az12.csv'
    WITH (
        FORMAT csv,
        DELIMITER ',',
        HEADER true
    );

    \copy bronze.erp_loc_a101 FROM 'C:\Users\obaid\Downloads\sql-data-warehouse-project-main\datasets\source_erp\erp_loc_a101.csv'
    WITH (
        FORMAT csv,
        DELIMITER ',',
        HEADER true
    );

    \copy bronze.erp_px_cat_g1v2 FROM 'C:\Users\obaid\Downloads\sql-data-warehouse-project-main\datasets\source_erp\erp_px_cat_g1v2.csv'
    WITH (
        FORMAT csv,
        DELIMITER ',',
        HEADER true
    );
END;
&&;