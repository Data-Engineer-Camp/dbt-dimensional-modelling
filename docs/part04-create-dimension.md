## Part 4: Create the dimension tables

Let's first create `dim_product` . The other dimension tables will use the same steps that we’re about to go through. 

### Step 1: Create model files

Let’s create the new dbt model files that will contain our transformation code. Under [adventureworks/models/marts](../adventureworks/models/marts) , create two files: 

- `dim_product.sql` : This file will contain our SQL transformation code.
- `dim_product.yml` : This file will contain our documentation and tests for `dim_product` .

```
adventureworks/models/
└── marts
    ├── dim_product.sql
    ├── dim_product.yml
```

### Step 2: Fetch data from the upstream tables

In `dim_product.sql`, you can select data from the upstream tables using Common Table Expressions (CTEs). 

```sql
with stg_product as (
    select *
    from {{ ref('product') }}
),

stg_product_subcategory as (
    select *
    from {{ ref('productsubcategory') }}
),

stg_product_category as (
    select *
    from {{ ref('productcategory') }}
)

... 
```

We use the `ref` function to reference the upstream tables and create a [Directed Acyclic Graph (DAG)](https://docs.getdbt.com/terms/dag) of the dependencies. 

### Step 3: Perform the joins

Next, perform the joins between the CTE tables using the appropriate join keys. 

```sql
...

select
    ... 
from stg_product
left join stg_product_subcategory on stg_product.productsubcategoryid = stg_product_subcategory.productsubcategoryid
left join stg_product_category on stg_product_subcategory.productcategoryid = stg_product_category.productcategoryid
```

### Step 4: Create the surrogate key

[Surrogate keys](https://www.kimballgroup.com/1998/05/surrogate-keys/) provide consumers of the dimensional model with an easy-to-use key to join the fact and dimension tables together, without needing to understand the underlying business context. 

There are several approaches to creating a surrogate key: 

- **Hashing surrogate key**: a surrogate key that is constructed by hashing the unique keys of a table (e.g. `md5(key_1, key_2, key_3)` ).
- **Incrementing surrogate key**: a surrogate key that is constructed by using a number that is always incrementing (e.g. `row_number()`).
- **Concatenating surrogate key**: a surrogate key that is constructed by concatenating the unique key columns (e.g. `concat(key_1, key_2, key_3)` ).

We are using arguably the easiest approach which is to perform a hash on the unique key columns of the dimension table. This approach removes the hassle of performing a join with dimension tables when generating the surrogate key for the fact tables later. 

To generate the surrogate key, we use a dbt macro that is provided by the `dbt_utils` package called `generate_surrogate_key()` . The generate surrogate key macro uses the appropriate hashing function from your database to generate a surrogate key from a list of key columns (e.g. `md5()`, `hash()`). Read more about the [generate_surrogate_key macro](https://docs.getdbt.com/blog/sql-surrogate-keys). 

```sql
...

select
    {{ dbt_utils.generate_surrogate_key(['stg_product.productid']) }} as product_key, 
    ... 
from stg_product
left join stg_product_subcategory on stg_product.productsubcategoryid = stg_product_subcategory.productsubcategoryid
left join stg_product_category on stg_product_subcategory.productcategoryid = stg_product_category.productcategoryid
```

### Step 5: Select dimension table columns

You can now select the dimension table columns so that they can be used in conjunction with the fact table later. We select columns that will help us answer the business questions identified earlier. 

```sql
...

select
    {{ dbt_utils.generate_surrogate_key(['stg_product.productid']) }} as product_key, 
    stg_product.productid,
    stg_product.name as product_name,
    stg_product.productnumber,
    stg_product.color,
    stg_product.class,
    stg_product_subcategory.name as product_subcategory_name,
    stg_product_category.name as product_category_name
from stg_product
left join stg_product_subcategory on stg_product.productsubcategoryid = stg_product_subcategory.productsubcategoryid
left join stg_product_category on stg_product_subcategory.productcategoryid = stg_product_category.productcategoryid
```

### Step 6: Choose a materialization type

You may choose from one of the following materialization types supported by dbt: 

- View
- Table
- Incremental

It is common for dimension tables to be materialized as `table` or `view` since the data volumes in dimension tables are generally not very large. In this example, we have chosen to go with `table`, and have set the materialization type for all dimensional models in the `marts` schema to `table` in `dbt_project.yml` 

```sql
models:
  adventureworks:
    marts:
      +materialized: table
      +schema: marts
```

### Step 7: Create model documentation and tests

Alongside our `dim_product.sql` model, we can populate the corresponding `dim_product.yml` file to document and test our model. 

```yaml
version: 2

models:
  - name: dim_product
    columns:
      - name: product_key 
        description: The surrogate key of the product
        tests:
          - not_null
          - unique
      - name: productid 
        description: The natural key of the product
        tests:
          - not_null
          - unique
      - name: product_name 
        description: The product name
        tests:
          - not_null
```

### Step 8: Build dbt models

Execute the [dbt run](https://docs.getdbt.com/reference/commands/run) and [dbt test](https://docs.getdbt.com/reference/commands/run) commands to run and test your dbt models: 

```
dbt run && dbt test 
```

We have now completed all the steps to create a dimension table. We can now repeat the same steps to all dimension tables that we have identified earlier. Make sure to create all dimension tables before moving on to the next part. 

[&laquo; Previous](part03-identify-fact-dimension.md) [Next &raquo;](part05-create-fact.md)
