# dbt-dimensional-modelling


psql -h localhost -d adventureworks -p 5432 -U postgres

\COPY (select * from person.address where modifieddate < '2012-01-01') TO '/Users/jonathanneo/code/data-engineer-camp/dbt-dimensional-modelling/adventureworks/seeds/address.csv' with (DELIMITER ',', FORMAT CSV, HEADER TRUE);

\COPY (select * from person.stg_person where modifieddate < '2012-01-01') TO '/Users/jonathanneo/code/data-engineer-camp/dbt-dimensional-modelling/adventureworks/seeds/person/stg_person.csv' with (DELIMITER ',', FORMAT CSV, HEADER TRUE);

\COPY (select * from person.stg_countryregion) TO '/Users/jonathanneo/code/data-engineer-camp/dbt-dimensional-modelling/adventureworks/seeds/person/stg_countryregion.csv' with (DELIMITER ',', FORMAT CSV, HEADER TRUE);

\COPY (select * from person.stg_stateprovince) TO '/Users/jonathanneo/code/data-engineer-camp/dbt-dimensional-modelling/adventureworks/seeds/person/stg_stateprovince.csv' with (DELIMITER ',', FORMAT CSV, HEADER TRUE);

\COPY (select * from production.stg_product) TO '/Users/jonathanneo/code/data-engineer-camp/dbt-dimensional-modelling/adventureworks/seeds/production/stg_product.csv' with (DELIMITER ',', FORMAT CSV, HEADER TRUE);

\COPY (select * from production.stg_productcategory) TO '/Users/jonathanneo/code/data-engineer-camp/dbt-dimensional-modelling/adventureworks/seeds/production/stg_productcategory.csv' with (DELIMITER ',', FORMAT CSV, HEADER TRUE);

\COPY (select * from production.stg_productsubcategory) TO '/Users/jonathanneo/code/data-engineer-camp/dbt-dimensional-modelling/adventureworks/seeds/production/stg_productsubcategory.csv' with (DELIMITER ',', FORMAT CSV, HEADER TRUE);

\COPY (select * from sales.stg_customer) TO '/Users/jonathanneo/code/data-engineer-camp/dbt-dimensional-modelling/adventureworks/seeds/sales/stg_customer.csv' with (DELIMITER ',', FORMAT CSV, HEADER TRUE);

\COPY (select * from sales.stg_salesorderdetail) TO '/Users/jonathanneo/code/data-engineer-camp/dbt-dimensional-modelling/adventureworks/seeds/sales/stg_salesorderdetail.csv' with (DELIMITER ',', FORMAT CSV, HEADER TRUE);

\COPY (select * from sales.stg_salesorderheader) TO '/Users/jonathanneo/code/data-engineer-camp/dbt-dimensional-modelling/adventureworks/seeds/sales/stg_salesorderheader.csv' with (DELIMITER ',', FORMAT CSV, HEADER TRUE);

\COPY (select * from sales.stg_salesreason) TO '/Users/jonathanneo/code/data-engineer-camp/dbt-dimensional-modelling/adventureworks/seeds/sales/stg_salesreason.csv' with (DELIMITER ',', FORMAT CSV, HEADER TRUE);

\COPY (select * from sales.stg_store) TO '/Users/jonathanneo/code/data-engineer-camp/dbt-dimensional-modelling/adventureworks/seeds/sales/stg_store.csv' with (DELIMITER ',', FORMAT CSV, HEADER TRUE);

stg_store

duckdb dbt.duckdb

show tables;

