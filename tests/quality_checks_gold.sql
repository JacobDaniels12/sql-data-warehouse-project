/*
-- ==================================================================
Quality Checks
-- ==================================================================
Script Purpose:
    This script will perform quality checks to validate integrity, consistency, and accuracy of the Gold layer. The checks will ensure:
    - Unique surrogate keys in the dimension tables.
    - Referential integrity between fact and dimension tables.
    - Validation of relationships in the data model.

Usage notes:
    - Run these checks after data loading of the silver layer.
    - Investigat and resolve any discrepancies found during the data checks.
*/

-- ==================================================================
--Checking 'gold.dim_customers'
-- ==================================================================
--Check for uniqueness of customer key in gold.dim_customers
--expectation is NO RESULTS

SELECT
  customer_key,
  COUNT(*) AS dupe_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;


-- ==================================================================
--Checking 'gold.product_key'
-- ==================================================================
--Check for uniqueness of product key in gold.dim_products
--expectation is NO RESULTS

SELECT
  product_key,
  COUNT(*) AS dupe_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;


-- ==================================================================
--Checking 'gold.fact_sales'
-- ==================================================================

--Check the data model connectivity between fact and dimensions
SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL;
