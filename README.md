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

\COPY (select date_day,prior_date_day,next_date_day,prior_year_date_day,prior_year_over_year_date_day,day_of_week,day_of_week_name,day_of_month,day_of_year from date.stg_date where date_day < '2013-01-01' ) TO '/Users/jonathanneo/code/data-engineer-camp/dbt-dimensional-modelling/adventureworks/seeds/date/stg_date.csv' with (DELIMITER ',', FORMAT CSV, HEADER TRUE);


duckdb adventureworks.duckdb

show tables;

