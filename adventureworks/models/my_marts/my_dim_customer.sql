with customer as (
    select *
    from {{ ref('stg_sales__customer') }}
),

person as (
    select
        business_entity_id,
        customer_name
    from {{ ref('stg_person__person') }}
),

store as (
    select *
    from {{ ref('stg_sales__store') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_key,
    customer.customer_id,
    customer.territory_id,
    person.customer_name,
    store.store_name,
    store.sales_person_id
from customer
left join person on customer.person_id = person.business_entity_id
left join store on customer.store_id = store.business_entity_id
