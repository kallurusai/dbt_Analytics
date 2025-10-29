with customers as (

     select * from {{ ref('stg_jaffle_shop__customers') }}

),

orders as ( 

    select * from {{ ref('stg_jaffle_shop__orders') }}

),

customer_orders as (

    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        sum(total_cost) as total_amount
        

    from orders

    group by 1

),

customer_tiers as (

    select
        customer_id,
        case
            when total_amount >= 1000 then 'gold'
            when total_amount >= 500 then 'silver'
            else 'bronze'
        end as tier

    from customer_orders

),


final as(
    select
        customers.customer_id,
        CONCAT(customers.first_name, ' ', customers.last_name) AS full_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce (customer_orders.number_of_orders, 0) 
        as number_of_orders,
        customer_tiers.tier

    from customers

    left join customer_orders using (customer_id) 
    left join customer_tiers using (customer_id)

)

select * from final