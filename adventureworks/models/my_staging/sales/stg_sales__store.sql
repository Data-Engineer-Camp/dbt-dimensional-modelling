SELECT 
    businessentityid as business_entity_id, 
    storename as store_name, 
    salespersonid as sales_person_id
FROM {{ source('sales', 'store') }}