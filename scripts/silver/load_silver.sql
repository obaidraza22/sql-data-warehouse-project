-- Purpose: Load data from bronze layer to silver layer with transformations and cleaning
-- This script truncates and populates the silver layer tables with cleaned and transformed data from the bronze layer

TRUNCATE TABLE silver.crm_cus_info
INSERT INTO silver.crm_cus_info (
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date
)
	SELECT 
		cst_id,
		cst_key,
		TRIM(cst_firstname) cst_firstname,
		TRIM(cst_lastname) cst_lastname,
		CASE 
			WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
			WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
			ELSE 'n/a'
		END cst_marital_status,
		CASE
			WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
			WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
			ELSE 'n/a'
		END cst_gndr,
		cst_create_date
	FROM
	(SELECT 
		*,
		ROW_NUMBER() OVER (PARTITION BY cci.cst_id ORDER BY cci.cst_create_date DESC) flag_last
	FROM bronze.crm_cus_info cci 
	WHERE cst_id IS NOT NULL
	)
	WHERE flag_last = 1

TRUNCATE TABLE silver.crm_prd_info
INSERT INTO silver.crm_prd_info (
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
)
	SELECT
		cpi.prd_id,
		REPLACE(SUBSTRING(cpi.prd_key, 1, 5), '-', '_') cat_id,
		SUBSTRING(cpi.prd_key, 7, LENGTH(cpi.prd_key)) prd_key,
		TRIM(cpi.prd_nm) prd_nm,
		COALESCE(cpi.prd_cost, 0) AS prd_cost,
		CASE
			WHEN UPPER(TRIM(cpi.prd_line)) = 'M' THEN 'Mountain'
			WHEN UPPER(TRIM(cpi.prd_line)) = 'R' THEN 'Road'
			WHEN UPPER(TRIM(cpi.prd_line)) = 'S' THEN 'Other Sales'
			WHEN UPPER(TRIM(cpi.prd_line)) = 'T' THEN 'Touring'
			ELSE 'n/a'
		END
		prd_line,
		cpi.prd_start_dt,
		LEAD(cpi.prd_start_dt ) OVER (PARTITION BY cpi.prd_key ) - 1 prd_end_dt
	FROM bronze.crm_prd_info cpi 

TRUNCATE TABLE silver.crm_sales_details
INSERT INTO silver.crm_sales_details (
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	sls_ord_dt,
	sls_ship_dt,
	sls_due_dt,
	sls_sales,
	sls_quantity,
	sls_price
)
	SELECT
		csd.sls_ord_num,
		csd.sls_prd_key,
		csd.sls_cust_id,
		CASE
			WHEN csd.sls_order_dt = 0 OR LENGTH(csd.sls_order_dt::TEXT) != 8 THEN NULL
			ELSE csd.sls_order_dt::TEXT::DATE 
		END sls_ord_dt
		,
		CASE
			WHEN csd.sls_ship_dt = 0 OR LENGTH(csd.sls_ship_dt::TEXT) != 8 THEN NULL
			ELSE csd.sls_ship_dt::TEXT::DATE 
		END sls_ship_dt
		,
		CASE
			WHEN csd.sls_due_dt = 0 OR LENGTH(csd.sls_due_dt::TEXT) != 8 THEN NULL
			ELSE csd.sls_due_dt::TEXT::DATE 
		END sls_due_dt
		,
		CASE
			WHEN csd.sls_sales IS NULL OR csd.sls_sales <= 0 OR csd.sls_sales != csd.sls_quantity * ABS(csd.sls_price) THEN csd.sls_quantity * ABS(csd.sls_price )
			ELSE sls_sales
		END sls_sales,
		csd.sls_quantity,
		CASE
			WHEN csd.sls_price IS NULL OR csd.sls_price <= 0 THEN csd.sls_price / NULLIF(csd.sls_quantity, 0)
			ELSE csd.sls_price 
		END
	FROM bronze.crm_sales_details csd 

TRUNCATE TABLE silver.erp_cust_az12
INSERT INTO silver.erp_cust_az12 (
	cid,
	bdate,
	gen
)
	SELECT
		CASE
			WHEN eca.cid LIKE 'NAS%' THEN SUBSTRING(eca.cid, 4, LENGTH(eca.cid))
			ELSE eca.cid
		END cid,
		CASE
			WHEN eca.bdate > '2010-01-01' THEN NULL
			ELSE eca.bdate
		END bdate,
		CASE 
			WHEN eca.gen = 'Male' OR eca.gen = 'M' THEN 'Male'
			WHEN eca.gen = 'Female' OR eca.gen = 'F' THEN 'Female'
			ELSE NULL
		END gen
	FROM bronze.erp_cust_az12 eca  

TRUNCATE TABLE silver.erp_loc_a101
INSERT INTO silver.erp_loc_a101 (
	cid,
	cntry
)
	SELECT
		REPLACE(ela.cid, '-', ''),
		CASE
			WHEN TRIM(ela.cntry) = 'DE' THEN 'Germany'
			WHEN TRIM(ela.cntry) IN ('US', 'USA') THEN 'United States'
			WHEN TRIM(ela.cntry) = '' OR ela.cntry IS NULL THEN 'n/a'
			ELSE ela.cntry
		END entry
	FROM bronze.erp_loc_a101 ela 

TRUNCATE TABLE silver.erp_px_cat_g1v2
INSERT INTO silver.erp_px_cat_g1v2 (
	id,
	cat,
	subcat,
	maintenance
)
	SELECT
		epcgv.id,
		epcgv.cat,
		epcgv.subcat,
		epcgv.maintenance 
	FROM bronze.erp_px_cat_g1v2 epcgv 