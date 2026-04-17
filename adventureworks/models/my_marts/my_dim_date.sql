with date_table as (
    select *
    from {{ ref('stg_date__date') }}
)

select 
    date_table.date_id,
    date_table.previous_day_date,
    date_table.the_day_after_date,
    date_table.previous_year_date,
    date_table.previous_year_week_day_date,
    date_table.day_of_week,
    date_table.day_of_week_name,
    date_table.day_of_month,
    date_table.day_of_year
from date_table
