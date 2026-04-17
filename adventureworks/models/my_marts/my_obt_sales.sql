with sales as (
    select * from {{ ref('my_fct_sales') }}
),

product as (
    select * from {{ ref('my_dim_product') }}
),

customer as (
    select * from {{ ref('my_dim_customer') }}
),

my_address as (
    select * from {{ ref('my_dim_address') }}
),

my_date as (
    select * from {{ ref('my_dim_date') }}
)

select
    {{ dbt_utils.star(from=ref('my_fct_sales'), relation_alias='sales', except=["product_key", "customer_key", "address_key", "order_date_id"]) }},
    {{ dbt_utils.star(from=ref('my_dim_product'), relation_alias='product', except=["product_key"]) }},
    {{ dbt_utils.star(from=ref('my_dim_customer'), relation_alias='customer', except=["customer_key"]) }},
    {{ dbt_utils.star(from=ref('my_dim_address'), relation_alias='my_address', except=["address_key"]) }},
    {{ dbt_utils.star(from=ref('my_dim_date'), relation_alias='my_date', except=["date_id"]) }}
from sales
left join product on sales.product_key = product.product_key
left join customer on sales.customer_key = customer.customer_key
left join my_address on sales.address_key = my_address.address_key
left join my_date on sales.order_date_id = my_date.date_id