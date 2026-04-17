with product as (
    select * 
    from {{ ref('stg_production__product') }}
),
product_category as (
    select * 
    from {{ ref('stg_production__productcategory') }}
),
product_subcategory as (
    select *
    from {{ ref('stg_production__productsubcategory') }} 
)

select 
    {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_key,
    product.product_id,
    product.product_name, 
    product.product_code,
    product_category.product_classification,
    product_subcategory.product_type,
    product.product_quality,
    product.product_line,
    product.product_color,
    product.product_weight,
    product.weight_unit,
    product.is_product_for_sale, 
    product.is_product_made_inhouse,
    product.manufacturing_time,
    product.product_manufacturing_cost, 
    product.retail_price,
    product.product_first_available_date
from product
left join product_subcategory on product.product_subcategory_id = product_subcategory.product_subcategory_id
left join product_category on product_category.product_category_id = product_subcategory.product_category_id