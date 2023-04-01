with source_data as (
    select
        salesreasonid
        , name as reason_name
        , reasontype
        , modifieddate
    from {{ source('sales', 'salesreason') }}
)
select *
from source_data