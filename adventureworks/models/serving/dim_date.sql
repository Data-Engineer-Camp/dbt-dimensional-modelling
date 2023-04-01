with stg_date as (
    select * from {{ ref('stg_date') }}
)
, transformed as (
    select 
        {{ dbt_utils.surrogate_key(['stg_date.date_day']) }} as date_key,
        *
    from stg_date
)

select * 
from transformed
