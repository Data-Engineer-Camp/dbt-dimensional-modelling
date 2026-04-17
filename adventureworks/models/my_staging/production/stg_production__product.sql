select
    productid as product_id,
    name as product_name,
    finishedgoodsflag as is_product_for_sale,
    class as product_quality,
    makeflag as is_product_made_inhouse,
    productnumber as product_code,
    productmodelid as product_model_id,
    weightunitmeasurecode as weight_unit,
    standardcost as product_manufacturing_cost,
    productsubcategoryid as product_subcategory_id,
    listprice as retail_price,
    daystomanufacture as manufacturing_time,
    productline as product_line,
    color as product_color,
    cast(sellstartdate as date) as product_first_available_date, 
    weight as product_weight
from {{ source('production', 'product') }}