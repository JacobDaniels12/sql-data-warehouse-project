# Overview
The gold layer is the business-level data representation which is structured to support analytical and reporting use cases. It consists of dimension tables and fact tables for specific business metrics

## **1. gold.dim_customers**
- **purpose:** Stores customer level details enriched with demographic and geographic data
- **Columns:**

| Column Name | Data Type | Description |
| ----- | ----- | ----- |
|customer_key| INT | Surrogate key uniquely identifying each customer record in the dim table.|
|customer_id| INT | Unique numerical identifier assigned to each customer record.|
|customer_number| NVARCHAR(50) | Alphanumeric identifier representing the customer used for tracking and referencing.|
|first_name| NVARCHAR(50) | Customer first name as recorded in the system.|
|last_name| NVARCHAR(50) | Customer last name as recorded in the system.|
|country| NVARCHAR(50) | The country of residence for the customer (e.g., 'Canada').|
|marital_status| NVARCHAR(50) | The marital status of the customer (e.g., 'Married', 'Single').|
|gender| NVARCHAR(50) | The gender of the customer (e.g., 'Male','Female','n/a').|
|birthdate| DATE | The date of birth of the customer using the YYYY-MM-DD format (e.g., '1976-05-10').|
|create_date| DATE | The date the customer was recorded into the system (e.g., '2026-01-14').|


## **2. gold.dim_products**
- **purpose:** Stores details about the products and their attributes
- **Columns:**
| Column Name | Data Type | Description |
| ----- | ----- | ----- |
|product_key| INT | Surrogate key uniquely identifying each product record in the product dimension table.|
|product_id| INT | Unique numerical identifier assigned to each product record for internal tracking and referencing.|
|product_number| NVARCHAR(50) | Alphanumeric identifier representing the product used for categorization.|
|product_name| NVARCHAR(50) | Descriptive name as recorded in the system including type, color, and size.|
|category_id| NVARCHAR(50) | A unique identifier for the product's category, linking to it's higher level classification.|
|category| NVARCHAR(50) | A broad classification of the product (e.g., 'Bikes', 'Components') to group related products.|
|subcategory| NVARCHAR(50) | A more detailed classification of the product within the category such as product type (e.g.,'Road Bikes','Mountain Bikes'. |
|maintenance_required| NVARCHAR(50) | Indicates whether the product requires maintenance (e.g., 'Yes','No').|
|cost| INT | The cost or base price of the product, measured in monetary units|
|product_line| NVARCHAR(50) | The specific product line or series the product belongs to (e.g., 'Mountain', 'Road').|
|start_date| DATE | The date when the product became available for sale stored in YYYY-MM-DD format (e.g., '2003-07-01').|


## **3. gold.fact_sales**
- **purpose:** Stores transactional level sales data for analytical purposes
- **Columns:**
| Column Name | Data Type | Description |
| ----- | ----- | ----- |
|order_number| NVARCHAR(50) | A unique alphanumeric identifier for each sales order (e.g., 'SO43698').|
|product_key| INT | Surrogate key linking the order to the product dimension table.|
|customer_key| INT | Surrogate key linking the order to the customer dimension table.|
|order_date| DATE | The date that the order was placed in YYYY-MM-DD format.|
|shipping_date| DATE | The date that the order was shipped to the customer in YYYY-MM-DD format|.
|due_date| DATE | The date that the order payment was due in YYYY-MM-DD format.|
|sales_amount| INT | The total monetary value of the sale for the line item, in whole currency units (e.g., 25).|
|quantity| INT | The number of units of the product ordered for the line item|
|price| DATE | The price per unit of the product for the line item in whole currency units|









