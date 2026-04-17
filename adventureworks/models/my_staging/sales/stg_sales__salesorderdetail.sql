SELECT 
   salesorderid as sales_order_id, 
   orderqty as order_quantity, 
   salesorderdetailid as sales_order_detail_id, 
   unitprice as sale_price, 
   specialofferid as promotion_id, 
   productid as product_id, 
   unitpricediscount as discount_in_decimal
FROM {{ source('sales', 'salesorderdetail') }}