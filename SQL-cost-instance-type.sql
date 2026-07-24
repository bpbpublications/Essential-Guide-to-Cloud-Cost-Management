SELECT 
     product_instance_type,
     SUM(line_item_unblended_cost) AS ec2_cost
     FROM your_athena_db.cur-table-name
     WHERE line_item_product_code = 'AmazonEC2'
       AND line_item_line_item_type = 'Usage'
       AND bill_billing_period_start_date >= DATE 'yyyy-mm-dd'
       AND bill_billing_period_start_date < DATE 'yyyy-mm-dd'
     GROUP BY product_instance_type
     ORDER BY ec2_cost DESC;
