select
    order_id,
    customer_id,
    order_date,
    total_cost

from  {{ source('dbt_ai', 'raw_orders') }}