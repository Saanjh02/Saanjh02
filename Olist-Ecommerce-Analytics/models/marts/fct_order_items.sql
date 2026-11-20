select
    concat(i.order_id, '-', cast(i.order_item_id as string)) as order_item_key,
    i.order_id,
    i.order_item_id,
    i.product_id,
    i.seller_id,
    o.customer_unique_id,
    date(o.purchased_at) as purchase_date,
    o.order_status,
    o.is_late,
    o.delivery_days,
    i.price,
    i.freight_value
from {{ ref('stg_order_items') }} i
left join {{ ref('int_orders_enriched') }} o
    on i.order_id = o.order_id