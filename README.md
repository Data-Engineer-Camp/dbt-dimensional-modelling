# dbt-dimensional-modelling

## Getting started 

Setting up 

```
dbt deps 
dbt build 
```

Querying 

```
duckdb tmp/adventureworks.duckdb
show tables;
select * from serving.fct_sales; 
```
