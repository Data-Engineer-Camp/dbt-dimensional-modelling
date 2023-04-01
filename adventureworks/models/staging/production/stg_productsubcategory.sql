with source_data as (
    select
        productsubcategoryid
        , productcategoryid
        , name
        , modifieddate
    from {{ source('production', 'productsubcategory') }}
)
select *
from source_data