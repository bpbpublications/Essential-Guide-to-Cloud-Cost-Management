SELECT 
      line_item_product_code AS service,
      line_item_usage_account_id AS account_id,
      DATE_FORMAT(line_item_usage_start_date,'%Y-%m-%d') AS date, 
      line_item_usage_type AS usage_type, 
      product_from_location AS from_location, 
      product_to_location AS to_location, 
      product_product_family, 
      line_item_resource_id AS resource_id, 
      SUM(CAST(line_item_usage_amount AS DOUBLE)) AS sum_line_item_usage_amount,
      SUM(CAST(line_item_unblended_cost AS DECIMAL(16,8))) AS sum_line_item_unblended_cost
FROM  {your_cur_database.your_cur_table}
WHERE 
    line_item_usage_start_date >= CAST('YYYY-MM-DD 00:00:00' AS TIMESTAMP) 
    AND line_item_usage_start_date < CAST('YYYY-MM-DD 00:00:00' AS TIMESTAMP)  
    AND product_product_family IN ('Data Transfer', 'DT-Data Transfer')
    AND line_item_line_item_type = 'Usage'    
GROUP BY 
    line_item_product_code,
    line_item_usage_account_id,
    DATE_FORMAT(line_item_usage_start_date, '%Y-%m-%d'),
    line_item_resource_id,
    line_item_usage_type,
    product_from_location,
    product_to_location,
    product_product_family
ORDER BY 
    sum_line_item_unblended_cost DESC
