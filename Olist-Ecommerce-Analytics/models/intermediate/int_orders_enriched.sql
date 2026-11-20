select
    o.order_id,
    o.customer_id,
    c.customer_unique_id,
    c.city  as customer_city,
    c.state as customer_state,
    o.order_status,
    o.purchased_at,
    o.delivered_at,
    o.estimated_delivery_at,

    -- days from purchase to delivery (empty if not delivered yet)
    date_diff(date(o.delivered_at), date(o.purchased_at), day) as delivery_days,

    -- true if delivered after the promised date
    case
        when o.delivered_at is null then null
        when o.delivered_at > o.estimated_delivery_at then true
        else false
    end as is_late,

    p.total_payment,
    r.review_score
from {{ ref('stg_orders') }} o
left join {{ ref('stg_customers') }} c
    on o.customer_id = c.customer_id
left join {{ ref('int_payments_per_order') }} p
    on o.order_id = p.order_id
left join {{ ref('int_reviews_per_order') }} r
    on o.order_id = r.order_id