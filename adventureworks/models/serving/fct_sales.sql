with stg_salesorderheader as (
    select
        salesorderid
        , customerid
        , creditcardid
        , shiptoaddressid
        , status as order_status
        , cast(orderdate as date) as orderdate
    from {{ ref('salesorderheader') }} 
)
, stg_salesorderdetail as (
    select
        salesorderid
        , salesorderdetailid
        , productid
        , orderqty
        , unitprice
        , unitprice * orderqty  as  revenue_wo_taxandfreight
    from {{ref('salesorderdetail')}}
)

, final as (
    select
        {{ dbt_utils.surrogate_key(['stg_salesorderdetail.salesorderid', 'salesorderdetailid'])  }} sales_key
        , {{ dbt_utils.surrogate_key(['productid']) }} as product_key
        , {{ dbt_utils.surrogate_key(['customerid']) }} as customer_key 
        , {{ dbt_utils.surrogate_key(['creditcardid']) }} as creditcard_key
        , {{ dbt_utils.surrogate_key(['shiptoaddressid']) }} as ship_address_key
        , {{ dbt_utils.surrogate_key(['order_status']) }} as order_status_key
        , {{ dbt_utils.surrogate_key(['orderdate']) }} as order_date_key
        , stg_salesorderdetail.salesorderid
        , stg_salesorderdetail.salesorderdetailid
        , stg_salesorderdetail.unitprice
        , stg_salesorderdetail.orderqty
        , stg_salesorderdetail.revenue_wo_taxandfreight
    from stg_salesorderdetail
    left join stg_salesorderheader on stg_salesorderdetail.salesorderid = stg_salesorderheader.salesorderid
)

select *
from final
