/*
--------------------------------------------------------------------------------------------------------------
Quality Checks
--------------------------------------------------------------------------------------------------------------
Script Purpose:
    This script performs a variety of quality checks for data consistency, accuracy, and standardization
    across the 'silver' schema. It includes checks for:
    - Null or duplicate primary keys
    - Unwanted spaces in string fields (trimming)
    - Data standardization and consistency
    - Invalid date ranges and orders
    - Data consistency between related fields

Usage notes:
    - Run these checks after loading silver layer tables.
    - Investigate and resolve any discrepancies found during the data quality checks
--------------------------------------------------------------------------------------------------------------
*/

--------------------------------------------------------------------------------------------------------------
--Checks for 'silver.crm_cust_info'
--------------------------------------------------------------------------------------------------------------

--Check for Nulls or Duplicates in Primary Key
--Expectation: No Result

SELECT
  cst_id, count(*) as unique_cnt
FROM silver.crm_cust_info
group by cst_id
having count(*) > 1 OR cst_id IS NULL;

--Checking for unwanted spaces
--Expectation: no results
SELECT cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);


--Data Standardization & Consistency
SELECT  DISTINCT(cst_gndr)
FROM silver.crm_cust_info;

SELECT  DISTINCT(cst_marital_status)
FROM silver.crm_cust_info;

SELECT * FROM silver.crm_cust_info;

--------------------------------------------------------------------------------------------------------------
--Checks for 'silver.prd_info'
--------------------------------------------------------------------------------------------------------------

--Check for Nulls or Duplicates in Primary Key
--Expectation: No Result

SELECT
  prd_id, count(*) as unique_cnt
FROM silver.crm_prd_info
group by prd_id
having count(*) > 1 OR prd_id IS NULL;

--Checking for unwanted spaces
--Expectation: no results
SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

--Data Standardization & Consistency
SELECT  DISTINCT(prd_line)
FROM silver.crm_prd_info;

--Check for invalid date orders
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

SELECT *
FROM silver.crm_prd_info

--------------------------------------------------------------------------------------------------------------
--Checks for 'silver.crm_sales_details'
--------------------------------------------------------------------------------------------------------------
--Check for invalid dates
SELECT
  NULLIF(sls_order_dt,0) sls_order_dt
FROM silver.crm_sales_details
WHERE sls_order_dt <= 0 OR LEN(sls_order_dt) != 8 OR sls_order_dt > 20500101 OR sls_order_dt < 19000101;

--CHECK FOR INVALID DATE ORDERS
SELECT
  *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt;

--Check data consistency between sales, quantity, and price
-- Sales = Quantity * Price
-- Values must not be null, zero, or negative

SELECT DISTINCT
  sls_sales,
  sls_quantity,
  sls_ord_num,
  sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <=0 OR sls_quantity <=0 OR sls_price <=0
ORDER BY sls_sales, sls_quantity, sls_price;

--------------------------------------------------------------------------------------------------------------
--Checks for 'silver.erp_cust_az12'
--------------------------------------------------------------------------------------------------------------
--Identify out of range dates
SELECT DISTINCT
  bdate
FROM silver.erp_cust_az12
WHERE bdate < '1925-01-01' OR bdate > GETDATE()

--Data standardization and consistency
SELECT DISTINCT gen
FROM silver.erp_cust_az12

SELECT * FROM silver.erp_cust_az12

--------------------------------------------------------------------------------------------------------------
--Checks for 'silver.erp_loc_a101'
--------------------------------------------------------------------------------------------------------------
SELECT
  cid
FROM silver.erp_loc_a101

SELECT
  cst_key
FROM silver.crm_cust_info

SELECT DISTINCT cntry 
FROM silver.erp_loc_a101
ORDER BY cntry

SELECT * FROM silver.erp_loc_a101

--------------------------------------------------------------------------------------------------------------
--Checks for 'silver.erp_px_cat_g1v2' NOT NEEDED. No transformations required from Bronze to Silver layer tables
--------------------------------------------------------------------------------------------------------------

