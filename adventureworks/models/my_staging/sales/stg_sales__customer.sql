SELECT 
    customerid as customer_id, 
    personid as person_id, 
    storeid as store_id, 
    territoryid as territory_id
FROM {{ source('sales', 'customer') }}