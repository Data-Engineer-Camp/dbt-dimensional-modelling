with source_data as (
    select
        stateprovinceid
        , countryregioncode
        , modifieddate
        , rowguid
        , name as state_name
        , territoryid
        , isonlystateprovinceflag
        , stateprovincecode
    from {{ source('person', 'stateprovince') }}
)
select *
from source_data