SELECT 
    creditcardid as credit_card_id, 
    cardtype as card_type
FROM {{ source('sales', 'creditcard') }}