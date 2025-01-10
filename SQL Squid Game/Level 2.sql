SELECT FLOOR(0.9*(SELECT COUNT(*) FROM player WHERE status = 'alive' AND isinsider = 'false')) desired_amount,
FLOOR(0.9*(SELECT COUNT(*) FROM player WHERE status = 'alive' AND isinsider = 'false'))<=amount is_sufficient
FROM 
rations                       
