select
    p.product_id,
    coalesce(t.product_category_name_english, 'unknown') as category,
    p.product_photos_qty,
    p.product_weight_g
from {{ ref('stg_products') }} p
left join {{ ref('stg_category_translation') }} t
    on p.product_category_name = t.product_category_name