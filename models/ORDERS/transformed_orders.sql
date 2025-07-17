
WITH base_orders AS (
  SELECT
    order_id,
    customer_id,
    order_date,
    product_name,
    quantity,
    price,
    status
  FROM {{ source('bigquery_source', 'orders') }}
),

transformed_orders AS (
  SELECT
    order_id,
    customer_id,
    order_date,
    product_name,
    quantity,
    price,
    status,
    -- calculated column
    quantity * price AS total_amount,
    
    -- normalize status to lowercase
    LOWER(status) AS order_status
  FROM base_orders
)

SELECT * FROM transformed_orders
