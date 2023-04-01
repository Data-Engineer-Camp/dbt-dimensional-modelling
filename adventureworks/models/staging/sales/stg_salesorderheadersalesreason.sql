with source_data as (
    select
        salesorderid
        , modifieddate
        , salesreasonid
    from {{ source('sales', 'salesorderheadersalesreason') }}
)
select *
from source_data