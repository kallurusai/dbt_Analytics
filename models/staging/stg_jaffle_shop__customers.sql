with raw_customers as (

    select
        customer_id,
        first_name,
        last_name,
        email,
        created_at
    from
        {{ source('dbt_ai', 'raw_customers') }}

),

staging_customers as (

    select
        customer_id,
        first_name,
        last_name,
        email,
        created_at
    from
        raw_customers

)

select
    *
from
    staging_customers