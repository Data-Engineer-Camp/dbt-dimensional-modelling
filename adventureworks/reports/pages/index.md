# Welcome to Evidence!

Build polished data products with SQL and Markdown.

## Inspect the tables

There are two tables in the sales schema that catch our attention. These two tables can be used to create the fact table for the sales process: 

### Sales Header Information

- The `sales.salesorderheader` table contains information about the credit card used in the order, the shipping address, and the customer. Each record in this table represents an order header that contains one or more order details.


```sql salesorderheader
select * from sales.salesorderheader limit 10; 
```

<DataTable data={salesorderheader} />


### Sales Detail Information

- The `sales.salesorderdetail` table contains information about the product that was ordered, and the order quantity and unit price, which we can use to calculate the revenue. Each record in this table represents a single order detail.

```sql salesorderdetail
select * from sales.salesorderdetail limit 10; 
```

<DataTable data={salesorderdetail} />
