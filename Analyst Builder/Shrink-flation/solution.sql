SELECT 
    product_name, 
    ROUND((100.0 * (new_size - original_size) / original_size)::NUMERIC, 2) Size_Change_Percentage,
    ROUND((100.0 * (new_price - original_price) / original_price)::NUMERIC, 2) Price_Change_Percentage,
    CASE 
        WHEN original_size > new_size AND original_price <= new_price THEN 'True' 
        ELSE 'False' 
    END Shrinkflation_Flag
FROM products
ORDER BY 1
