select
    order_id,
    sum(payment_value)           as total_payment,
    count(*)                     as payment_rows,
    max(payment_installments)    as max_installments
from {{ ref('stg_order_payments') }}
group by order_id