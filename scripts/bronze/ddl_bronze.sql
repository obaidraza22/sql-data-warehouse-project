-- ==============================================================================================
-- Purpose of this script is to create the bronze layer tables in the bronze schema. 
        -- DEFINING THE BRONZE LAYER TABLES
        -- Dropping the tables if they already exist and creating new ones, total of 6 tables in the bronze layer: crm_cus_info, crm_prd_info, crm_sales_details, erp_cust_az12, loc_a101, and px_cat_g1v2.

-- WARNING: This script will drop the tables if they already exist, so be cautious when running it in a production environment.
-- ==============================================================================================

DROP TABLE IF EXISTS bronze.crm_cus_info;

CREATE TABLE bronze.crm_cus_info (
    cst_id int,
    cst_key varchar,
    cst_firstname varchar(50),
    cst_lastname varchar(50),
    cst_marital_status varchar(50),
    cst_gndr varchar(50),
    cst_create_date DATE
);

DROP TABLE IF EXISTS bronze.crm_prd_info;

CREATE TABLE bronze.crm_prd_info (
    prd_id int,
    prd_key varchar(50),
    prd_nm varchar(50),
    prd_cost int,
    prd_line varchar(50),
    prd_start_dt DATE,
    prd_end_dt DATE
);

DROP TABLE IF EXISTS bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details (
    sls_ord_num varchar(50),
    sls_prd_key varchar(50),
    sls_cust_id int,
    sls_order_dt int,
    sls_ship_dt int,
    sls_due_dt int,
    sls_sales int,
    sls_quantity int,
    sls_price int
);

DROP TABLE IF EXISTS bronze.erp_cust_az12;

CREATE TABLE bronze.erp_cust_az12 (cid varchar(50), bdate DATE, gen varchar(50));

DROP TABLE IF EXISTS bronze.loc_a101;

CREATE TABLE bronze.loc_a101 (cid varchar(50), cntry varchar(50));

DROP TABLE IF EXISTS bronze.px_cat_g1v2;

CREATE TABLE bronze.px_cat_g1v2 (
    id varchar(50),
    cat varchar(50),
    subcat varchar(50),
    maintenance varchar(50)
);