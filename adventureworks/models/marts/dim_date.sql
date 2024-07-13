with stg_date as (
    select * from {{ ref('date') }}
)

select
    {{ tsql_utils.sqlserver__generate_surrogate_key(['stg_date.date_day']) }} as date_key,
    *
from stg_date
