/*
    This script creates the physical tables for the Gold Layer (Star Schema).Each dimension uses an IDENTITY(1,1) column to provide a stable Surrogate Key that survives across full-load cycles.
*/

-- 1. Create Dimension: gold.dim_customers
IF OBJECT_ID('gold.dim_customers', 'U') IS NOT NULL
    DROP TABLE gold.dim_customers;
GO
CREATE TABLE gold.dim_customers (
    customer_key      INT IDENTITY(1,1), /* Stable Surrogate Key */
    customer_id       INT NOT NULL, /* Natural Key from Silver */
    customer_number   NVARCHAR(50),
    first_name        NVARCHAR(50),
    last_name         NVARCHAR(50),
    country           NVARCHAR(50),
    marital_status    NVARCHAR(50),
    gender            NVARCHAR(50),
    birthdate         DATE,
    create_date       DATE,
    dwh_create_date   DATETIME2 DEFAULT GETDATE(),
    CONSTRAINT pk_gold_dim_customers PRIMARY KEY (customer_key)
);
GO

-- 2. Create Dimension: gold.dim_products
IF OBJECT_ID('gold.dim_products', 'U') IS NOT NULL
    DROP TABLE gold.dim_products;
GO
CREATE TABLE gold.dim_products (
    product_key       INT IDENTITY(1,1), /* Stable Surrogate Key */
    product_id        INT NOT NULL, /* Natural Key from Silver */
    product_number    NVARCHAR(50),
    product_name      NVARCHAR(50),
    category_id       NVARCHAR(50),
    category          NVARCHAR(50),
    subcategory       NVARCHAR(50),
    maintenance       NVARCHAR(50),
    cost              INT,
    product_line      NVARCHAR(50),
    start_date        DATE,
    dwh_create_date   DATETIME2 DEFAULT GETDATE(),
    CONSTRAINT pk_gold_dim_products PRIMARY KEY (product_key)
);
GO

-- 3. Create Fact Table: gold.fact_sales
IF OBJECT_ID('gold.fact_sales', 'U') IS NOT NULL
    DROP TABLE gold.fact_sales;
GO
CREATE TABLE gold.fact_sales (
    order_number      NVARCHAR(50),
    product_key       INT, /* Links to gold.dim_products.product_key */
    customer_key      INT, /* Links to gold.dim_customers.customer_key */
    order_date        DATE, /*first 3 columns making composite key*/
    shipping_date     DATE,
    due_date          DATE,
    sales_amount      INT,
    quantity          INT,
    price             INT,
    dwh_create_date   DATETIME2 DEFAULT GETDATE()
);
GO
