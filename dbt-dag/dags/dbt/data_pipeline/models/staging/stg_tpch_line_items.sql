select 
{{
    dbt_utils.generate_surrogate_key([
        'l_orderkey',
        'l_linenumber'
    ]
    )
}} order_item_key
    ,l_orderkey order_key
    ,l_partkey part_key
    ,l_linenumber line_number
    ,l_quantity quantity
    ,l_extendedprice extended_price
    ,l_discount discount_percentage
    ,l_tax tax_rate
from 
{{ source('tpch', 'lineitem') }}