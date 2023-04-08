with stg_salesorderheader as (
    select 
        distinct(creditcardid)
    from {{ref('salesorderheader')}}
    where creditcardid is not null
)

, stg_creditcard as (
    select *
    from {{ref('creditcard')}}
)

, transformed as (
    select 
        {{ dbt_utils.surrogate_key(['stg_salesorderheader.creditcardid']) }} as creditcard_key -- surrogate key	
        , stg_salesorderheader.creditcardid
        , stg_creditcard.cardtype
    from stg_salesorderheader 
    left join stg_creditcard on stg_salesorderheader.creditcardid = stg_creditcard.creditcardid
)

select *
from transformed