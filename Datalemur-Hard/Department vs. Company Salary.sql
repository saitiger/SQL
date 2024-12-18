WITH company_avg AS 
(
SELECT payment_date,AVG(amount) as company_sal_avg
FROM
salary
WHERE payment_date = '03/31/2024'
GROUP BY payment_date
),
monthly_dept_avg
AS
(
SELECT 
e.department_id,s.payment_date,
AVG(s.amount) as dept_avg
FROM 
employee e
JOIN 
salary s 
ON 
e.employee_id = s.employee_id
WHERE s.payment_date = '03/31/2024'
GROUP BY 1,2
)
SELECT 
m.department_id,
TO_CHAR(c.payment_date, 'MM-YYYY') AS payment_date,
MAX(CASE WHEN company_sal_avg<dept_avg THEN 'higher' 
WHEN company_sal_avg>dept_avg THEN 'lower'
ELSE 'same' END) comparison
FROM 
company_avg c 
JOIN
monthly_dept_avg m
ON 
c.payment_date = m.payment_date
GROUP BY 1,2
