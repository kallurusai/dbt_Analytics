select
    c1 as customer_id,
    c2 as full_name

from {{ source('dbt_ai', 'raw_customers') }}