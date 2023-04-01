with source_data as (
    select
        productcategoryid
        , name
        , modifieddate
    from {{ source('production', 'productcategory') }}
)
select *
from source_data