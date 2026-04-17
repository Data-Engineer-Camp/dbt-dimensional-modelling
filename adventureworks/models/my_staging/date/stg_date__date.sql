    select 
        cast(date_day as date) as date_id,
        cast(prior_date_day as date) as previous_day_date,
        cast(next_date_day as date) as the_day_after_date,
        cast(prior_year_date_day as date) as previous_year_date,
        cast(prior_year_over_year_date_day as date) as previous_year_week_day_date,
        day_of_week,
        day_of_week_name as day_of_week_name,
        day_of_month,
        day_of_year
     from {{ source('date', 'date') }}
