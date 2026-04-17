SELECT 
    productsubcategoryid as product_subcategory_id, 
    productcategoryid as product_category_id, 
    "name" as product_type
FROM {{ source('production', 'productsubcategory') }}