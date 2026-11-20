with items as (
    select
        order_id,
        count(*)           as items_count,
        sum(price)         as items_revenue,
        sum(freight_value) as freight_total
    from {{ ref('stg_order_items') }}
    group by order_id
)

select
    o.order_id,
    o.customer_unique_id,
    date(o.purchased_at) as purchase_date,
    o.order_status,
    o.purchased_at,
    o.delivered_at,
    o.estimated_delivery_at,
    o.delivery_days,
    o.is_late,
    o.review_score,
    o.total_payment,
    i.items_count,
    i.items_revenue,
    i.freight_total
from {{ ref('int_orders_enriched') }} o
left join items i
    on o.order_id = i.order_id