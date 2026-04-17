select
    businessentityid as business_entity_id,
    concat(coalesce(title, ''), ' ', coalesce(firstname, ''), ' ', coalesce(middlename, ''), ' ', coalesce(lastname, '')) as customer_name,
    persontype as person_type
from {{ source('person', 'person') }}