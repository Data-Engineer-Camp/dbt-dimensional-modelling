# dbt-dimensional-modelling


psql -h localhost -d adventureworks -p 5432 -U postgres

\COPY (select * from person.stg_address) TO '/Users/jonathanneo/code/data-engineer-camp/dbt-dimensional-modelling/adventureworks/seeds/stg_address.csv' with (DELIMITER ',', FORMAT CSV, HEADER TRUE);

\COPY (select * from person.stg_person) TO '/Users/jonathanneo/code/data-engineer-camp/dbt-dimensional-modelling/adventureworks/seeds/person/stg_person.csv' with (DELIMITER ',', FORMAT CSV, HEADER TRUE);

\COPY (select * from person.stg_countryregion) TO '/Users/jonathanneo/code/data-engineer-camp/dbt-dimensional-modelling/adventureworks/seeds/person/stg_countryregion.csv' with (DELIMITER ',', FORMAT CSV, HEADER TRUE);

\COPY (select * from person.stg_stateprovince) TO '/Users/jonathanneo/code/data-engineer-camp/dbt-dimensional-modelling/adventureworks/seeds/person/stg_stateprovince.csv' with (DELIMITER ',', FORMAT CSV, HEADER TRUE);


duckdb dbt.duckdb

show tables;

