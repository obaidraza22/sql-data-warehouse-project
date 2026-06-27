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

\copy bronze.erp_loc_a101 FROM 'C:\Users\obaid\Downloads\sql-data-warehouse-project-main\datasets\source_erp\erp_loc_a101'
WITH (
    FORMAT csv,
    DELIMITER ',',
    HEADER true
);

\copy bronze.erp_px_cat_g1v2 FROM 'C:\Users\obaid\Downloads\sql-data-warehouse-project-main\datasets\source_erp\erp_px_cat_g1v2'
WITH (
    FORMAT csv,
    DELIMITER ',',
    HEADER true
);