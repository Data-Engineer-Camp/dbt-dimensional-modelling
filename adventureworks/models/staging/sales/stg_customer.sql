with source_data as (
    select
        customerid
        , personid
        , storeid
        , territoryid
    from {{ source('sales', 'customer') }}
)
select *
from source_data	