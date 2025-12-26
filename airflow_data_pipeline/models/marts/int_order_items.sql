select 
line_item.order_item_key
,line_item.part_key
,line_item.line_number
,line_item.extended_price
,orders.order_key
,orders.customer_key
,orders.order_date
,{{discounted_amount(
    'line_item.extended_price', 
    'line_item.discount_percentage'
    ) }} item_discount_amount
from 
{{ ref('stg_tpch_orders') }} orders 
join
{{ref('stg_tpch_line_items') }} line_item 
    on orders.order_key = line_item.order_key
order by 
orders.order_date