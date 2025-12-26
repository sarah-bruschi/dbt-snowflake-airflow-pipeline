select 
line_item.order_item_key
,line_item.part_key
,line_item.line_number
,orders.order_key
,orders.customer_key
,orders.order_date
from 
{{ ref('stg_tpch_orders') }} orders 
join
{{ref('stg_tpch_line_items') }} line_item 
    on orders.order_key = line_item.order_key
order by 
orders.order_date