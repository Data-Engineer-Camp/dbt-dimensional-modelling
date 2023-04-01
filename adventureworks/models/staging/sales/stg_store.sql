with source_data as (
    select
        businessentityid
        , name as storename
        , salespersonid
        , modifieddate
    from {{ source('sales', 'store') }}
)
select *
from source_data