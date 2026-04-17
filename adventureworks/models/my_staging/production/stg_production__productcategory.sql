SELECT 
    productcategoryid as product_category_id,
    "name" as product_classification
FROM {{ source('production', 'productcategory') }}