with address_table as (
    select *
    from {{ ref('stg_person__address') }}
),

stateprovince as (
    select *
    from {{ ref('stg_person__stateprovince') }}
),

countryregion as (
    select *
    from {{ ref('stg_person__countryregion') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['address_id']) }} as address_key,
    address_table.address_id,
    address_table.city,
    address_table.postcode,
    stateprovince.state as state_name,
    countryregion.country_name
from address_table
left join stateprovince on address_table.state_province_id = stateprovince.state_province_id
left join countryregion on stateprovince.country_code = countryregion.country_code
