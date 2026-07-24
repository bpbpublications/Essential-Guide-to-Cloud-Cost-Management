SELECT 
    line_item_resource_id AS bucket_name,
    ROUND(SUM(line_item_unblended_cost), 2) AS total_cost,
    DATE_FORMAT(bill_billing_period_start_date, '%Y-%m') AS billing_month
FROM your_athena_db.cur20_table
WHERE line_item_product_code = 'AmazonS3'
    AND bill_billing_period_start_date >= DATE '2024-01-01'
    AND bill_billing_period_start_date < DATE '2025-01-15'
GROUP BY 
    line_item_resource_id,
    DATE_FORMAT(bill_billing_period_start_date, '%Y-%m')
HAVING 
    SUM(line_item_unblended_cost) > 0
ORDER BY 
    total_cost DESC
LIMIT 20
