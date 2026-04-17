select
    stateprovinceid as state_province_id,
    countryregioncode as country_code,
    name as state,
    territoryid as territory_id, 
    stateprovincecode as state_code
from {{ source('person', 'stateprovince') }}