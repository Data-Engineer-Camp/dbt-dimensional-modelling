with stg_customer as (
    select 
        customerid
        , personid
        , storeid
    from {{ref('stg_customer')}}
)

, stg_person as (
    select
        businessentityid
        -- Adopted function concat() to concatenate first, middle and lastnames
        , concat(coalesce(firstname,''),' ',coalesce(middlename,''),' ',coalesce(lastname,'')) as fullname
    from {{ref('stg_person')}}
)

, stg_store as (
    select
        businessentityid as storebusinessentityid
        , storename
    from {{ref('stg_store')}}
)

, transformed as (
    select
    {{ dbt_utils.surrogate_key(['stg_customer.customerid']) }} as customer_key -- surrogate key: https://github.com/dbt-labs/dbt-utils#surrogate_key-source    
    , stg_customer.customerid
    , stg_person.businessentityid
    , stg_person.fullname
    , stg_store.storebusinessentityid
    , stg_store.storename
    from stg_customer
    left join stg_person on stg_customer.personid = stg_person.businessentityid
    left join stg_store on stg_customer.storeid = stg_store.storebusinessentityid
)
select *
from transformed
