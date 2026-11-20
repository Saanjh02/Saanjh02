with ranked as (
    select
        customer_unique_id,
        customer_city,
        customer_state,
        purchased_at,
        order_id,
        row_number() over (
            partition by customer_unique_id
            order by purchased_at desc
        ) as rn
    from {{ ref('int_orders_enriched') }}
),

totals as (
    select
        customer_unique_id,
        min(purchased_at)        as first_order_at,
        count(distinct order_id) as total_orders
    from ranked
    group by customer_unique_id
)

select
    r.customer_unique_id,
    r.customer_city  as city,
    r.customer_state as state,
    t.first_order_at,
    t.total_orders,
    t.total_orders > 1 as is_repeat_customer
from ranked r
join totals t using (customer_unique_id)
where r.rn = 1