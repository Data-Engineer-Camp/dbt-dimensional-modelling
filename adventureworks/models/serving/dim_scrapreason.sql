with stg_scrapreason as (
    select 
        {{ dbt_utils.surrogate_key(['scrapreasonid']) }} as scrapreason_key
        , scrapreasonid 
        , name 
    from {{ ref('stg_scrapreason') }}
) 

select * 
from stg_scrapreason
