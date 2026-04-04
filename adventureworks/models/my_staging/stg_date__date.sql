    select 
        date_day as date,
        prior_date_day as previous_day_date,
        next_date_day as the_day_after_date,
        prior_year_date_day as previous_year_date,
        prior_year_over_year_date_day as previous_year_week_day_date,
        day_of_week,
        day_of_week_name as week_day,
        day_of_month as month,
        day_of_year
     from date.date