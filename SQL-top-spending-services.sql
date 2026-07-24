SELECT 
    line_item_product_code AS Service,
    ROUND(SUM(line_item_unblended_cost), 2) AS Service_cost,
    DATE_FORMAT(bill_billing_period_start_date, '%Y-%m') AS BillingMonth
FROM your_athena_db.cur20_table
WHERE bill_billing_period_start_date >= DATE '2024-12-01'  -- Start Date
    AND bill_billing_period_start_date < DATE '2025-01-15'  -- End Date
    AND line_item_unblended_cost > 0
GROUP BY 
    line_item_product_code,
    DATE_FORMAT(bill_billing_period_start_date, '%Y-%m')
HAVING 
    SUM(line_item_unblended_cost) > 0
ORDER BY  
    BillingMonth,
    Service_cost DESC
LIMIT 10;
