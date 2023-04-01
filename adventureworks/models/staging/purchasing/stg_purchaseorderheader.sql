with source_data as (
    select
        *
    from {{ source('purchasing', 'purchaseorderheader') }}
)
select *
from source_data
