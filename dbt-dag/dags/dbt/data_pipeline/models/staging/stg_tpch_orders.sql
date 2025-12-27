select 
    o_orderkey order_key
    ,o_custkey customer_key
    ,o_orderstatus status_code
    ,o_totalprice total_price
    ,o_orderdate order_date
from 
{{source('tpch', 'orders')}}