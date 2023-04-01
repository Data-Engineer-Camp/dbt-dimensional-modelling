with stg_address as (
    select *
    from {{ref('stg_address')}}
)

, stg_stateprovince as (
    select *
    from {{ref('stg_stateprovince')}}
)

, stg_countryregion as (
    select *
    from {{ref('stg_countryregion')}}
)

, transformed as (
    select
        {{ dbt_utils.surrogate_key(['stg_address.addressid']) }}  as address_key
        , stg_address.addressid 
        , stg_address.city as city_name
        , stg_stateprovince.state_name
        , stg_countryregion.country_name
    from stg_address
    left join stg_stateprovince on stg_address.stateprovinceid = stg_stateprovince.stateprovinceid
    left join stg_countryregion on stg_stateprovince.countryregioncode = stg_countryregion.countryregioncode 
)

select *
from transformed
