with source_data as (
    select 
        workorderid 
        , productid
        , orderqty
        , scrappedqty
        , startdate
        , enddate
        , duedate
        , scrapreasonid
        , modifieddate
    from {{ source('production', 'workorder') }}
)

select * 
from source_data
