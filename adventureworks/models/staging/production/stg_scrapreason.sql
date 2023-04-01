with source_data as ( 
    select 
        scrapreasonid
        , name 
    from {{ source('production', 'scrapreason') }}
)

select * 
from source_data
