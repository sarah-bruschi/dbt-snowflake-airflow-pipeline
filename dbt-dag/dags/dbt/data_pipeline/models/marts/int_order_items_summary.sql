select 
    order_key
    ,sum(extended_price) gross_item_sales_amount
    ,sum(item_discount_amount) item_discount_amount
from 
    {{ ref('int_order_items') }}
group by 
    order_key