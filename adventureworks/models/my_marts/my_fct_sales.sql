with salesorderheader as (
    select
        sales_order_id,
        customer_id,
        credit_card_id,
        shipping_address_id,
        order_status_code,
        order_date
    from {{ ref('stg_sales__salesorderheader') }}
),

salesorderdetail as (
    select
        sales_order_id,
        sales_order_detail_id,
        product_id,
        order_quantity,
        sale_price,
        sale_price * order_quantity as revenue
    from {{ ref('stg_sales__salesorderdetail') }}
),

my_dim_product as (
    select product_key, product_id
    from {{ ref('my_dim_product') }}
),

my_dim_customer as (
    select customer_key, customer_id
    from {{ ref('my_dim_customer') }}
),

my_dim_address as (
    select address_key, address_id
    from {{ ref('my_dim_address') }}
),

my_dim_date as (
    select date_id
    from {{ ref('my_dim_date') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['salesorderdetail.sales_order_id', 'salesorderdetail.sales_order_detail_id']) }} as sales_key,
    my_dim_product.product_key,
    my_dim_customer.customer_key,
    my_dim_address.address_key,
    my_dim_date.date_id                            as order_date_id,
    salesorderdetail.sales_order_id,
    salesorderdetail.sales_order_detail_id,
    salesorderheader.order_status_code,
    salesorderdetail.sale_price,
    salesorderdetail.order_quantity,
    salesorderdetail.revenue
from salesorderdetail
inner join salesorderheader 
    on salesorderdetail.sales_order_id = salesorderheader.sales_order_id
left join my_dim_product 
    on salesorderdetail.product_id = my_dim_product.product_id
left join my_dim_customer 
    on salesorderheader.customer_id = my_dim_customer.customer_id
left join my_dim_address 
    on salesorderheader.shipping_address_id = my_dim_address.address_id
left join my_dim_date 
    on salesorderheader.order_date = my_dim_date.date_id