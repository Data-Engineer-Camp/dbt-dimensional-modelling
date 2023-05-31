## Part 7: Consume dimensional model

Finally, we can consume our dimensional model by connecting to our data warehouse to our Business Intelligence (BI) tools such as Tableau, Power BI, and Looker. 

Most modern BI tools have a built-in semantic layer that supports relationships between tables, which is required if we want to consume the dimensional models directly without any additional data transformation. 

In Looker for example, we can define relationships using [LookML](https://cloud.google.com/looker/docs/what-is-lookml): 

```yaml
explore: fct_order {
  join: dim_user {
    sql_on: ${fct_order.user_key} = ${dim_user.user_key} ;;
    relationship: many_to_one
  }
}
```

If your BI tool doesn’t have a semantic layer that supports relationships, then you will have to reflect that relationship by creating a One Big Table (OBT) that joins the fact table against all of its dimension tables. 

```sql
with f_sales as (
    select * from {{ ref('fct_sales') }}
),

d_customer as (
    select * from {{ ref('dim_customer') }}
),

d_credit_card as (
    select * from {{ ref('dim_credit_card') }}
),

d_address as (
    select * from {{ ref('dim_address') }}
),

d_order_status as (
    select * from {{ ref('dim_order_status') }}
),

d_product as (
    select * from {{ ref('dim_product') }}
),

d_date as (
    select * from {{ ref('dim_date') }}
)

select
    {{ dbt_utils.star(from=ref('fct_sales'), relation_alias='f_sales', except=[
        "product_key", "customer_key", "creditcard_key", "ship_address_key", "order_status_key", "order_date_key"
    ]) }},
    {{ dbt_utils.star(from=ref('dim_product'), relation_alias='d_product', except=["product_key"]) }},
    {{ dbt_utils.star(from=ref('dim_customer'), relation_alias='d_customer', except=["customer_key"]) }},
    {{ dbt_utils.star(from=ref('dim_credit_card'), relation_alias='d_credit_card', except=["creditcard_key"]) }},
    {{ dbt_utils.star(from=ref('dim_address'), relation_alias='d_address', except=["address_key"]) }},
    {{ dbt_utils.star(from=ref('dim_order_status'), relation_alias='d_order_status', except=["order_status_key"]) }},
    {{ dbt_utils.star(from=ref('dim_date'), relation_alias='d_date', except=["date_key"]) }}
from f_sales
left join d_product on f_sales.product_key = d_product.product_key
left join d_customer on f_sales.customer_key = d_customer.customer_key
left join d_credit_card on f_sales.creditcard_key = d_credit_card.creditcard_key
left join d_address on f_sales.ship_address_key = d_address.address_key
left join d_order_status on f_sales.order_status_key = d_order_status.order_status_key
left join d_date on f_sales.order_date_key = d_date.date_key
```

```sql obt
select * from marts.obt_sales
```


In the OBT above, we perform joins between the fact and dimension tables using the surrogate keys. 

Using `dbt_utils.star()`, we select all columns except the surrogate key columns since the surrogate keys don't hold any meaning besides being useful for the joins. 

We can then build the OBT by running `dbt run`. Your dbt DAG should now look like this: 

## BI as Code

Alternatively, you can use a BI tool like Evidence, where you can define relationships between tables using SQL. 

### Product Analysis

```sql product
select * from marts.fct_sales
left join marts.dim_product on fct_sales.product_key = dim_product.product_key
left join marts.dim_date on fct_sales.order_date_key = dim_date.date_key
```

```sql monthly_sales_by_category
select
    date_trunc('month', date_day) as month,
    product_category_name,
    sum(revenue) as revenue_usd0k
from ${product}
group by 1, 2 
order by 1, 3
```

<DataTable data={monthly_sales_by_category}/>

<BarChart data={monthly_sales_by_category} series=product_category_name/>

## Location Analysis

```sql address
select * from marts.fct_sales
left join marts.dim_address on fct_sales.ship_address_key = dim_address.address_key
```

```sql sales_by_city_top10
select
    city_name,
    country_name,
    sum(revenue) as revenue_usd0k
from ${address}
group by 1,2
order by 3 desc
limit 10
```

The top 10 cities by sales are:

{#each sales_by_city_top10 as city}

- {city.city_name}, {city.country_name} (<Value data={city} column=revenue_usd0k/>)

{/each}


```sql sales_by_state
select
    state_name,
    sum(revenue) as revenue_usd0k
from ${address}
where country_name = 'United States'
group by 1
order by 2 desc
```

<USMap 
    data={sales_by_state} 
    title="Sales by State"
    state=state_name 
    value=revenue_usd0k
/>

![](/img/dbt-dag.png)`

*Final dbt DAG*

Congratulations, you have reached the end of this tutorial. If you want to learn more, please see the learning resources below on dimensional modelling. 

## Learning resources

- [Kimball group learning resources](https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/dimensional-modeling-techniques/)
- [The Data Warehouse toolkit book](https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/books/data-warehouse-dw-toolkit/)
- [dbt discourse on whether dimensional modelling is still relevant](https://discourse.getdbt.com/t/is-kimball-dimensional-modeling-still-relevant-in-a-modern-data-warehouse/225)
- [dbt glossary on dimensional modelling](https://docs.getdbt.com/terms/dimensional-modeling)

If you have any questions about the material, please reach out to me on dbt slack (@Jonathan Neo), or on [LinkedIn](https://www.linkedin.com/in/jonneo/). 

*Author's note: The materials in this article were created by [Data Engineer Camp](https://dataengineercamp.com/), a 16-week data engineering bootcamp for professionals looking to transition to data engineering and analytics engineering. The article was written by Jonathan Neo, with editorial and technical guidance from [Kenny Ning](https://www.linkedin.com/in/kenny-ning/) and editorial review from [Paul Hallaste](https://www.linkedin.com/in/paulhallaste/) and [Josh Devlin](https://www.linkedin.com/in/josh-devlin/).*

[&laquo; Previous](part07-consume-model.md)
`