Entities : 
1. Customers
   
2. Food Company (Restraunt/Cafe/Food Truck)
   
3. Driver
   
4. Orders
   
5. Payments

Customers : 
a. User_ID (UUID) 
b. User_name 
b. User_primary_address 
d. Other_address_list
e. Phone_number
f. Email_id
g. User_rating 

Food Company: 
a. Company_ID 
b. Company_name
c. Menu
d. Company_address
e. Phone_number
f. Company_rating 

Driver: 
a. Driver_ID
b. Driver_Name 
c. Driver_rating 
d. Driver_phone_number
-- e. Driver_home_address # Optional field 
f. Driver_vehicle_details 
g. Driver_email_id
h. Availability 

Orders
a. Order_id
b. Order_value
c. Order_items
d. Driver_ID
e. User_ID
f. Company_ID
g. Order_address
h. Order_timestamp

Payments 
a. Payment_ID
b. Payment_type 
c. Payment_timestamp
d. Order_ID
e. Payment_amount 
