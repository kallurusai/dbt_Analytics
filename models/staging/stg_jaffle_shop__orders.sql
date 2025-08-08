select
    id as order_id,
    customer as customer_id,
    ordered_at as order_date,
    store_id

from  {{ source('dbt_ai', 'raw_orders') }}