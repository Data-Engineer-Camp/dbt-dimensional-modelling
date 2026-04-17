select 
    countryregioncode as country_code,
    name as country_name
from {{ source('person', 'countryregion') }}   