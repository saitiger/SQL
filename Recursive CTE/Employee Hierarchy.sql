WITH recursive cte as 
(
  SELECT emp_id, emp_id as eh_emp_id 
  FROM Employee_Hierarchy
  UNION ALL
  SELECT cte.emp_id, eh.emp_id as eh_emp_id
  FROM cte
  JOIN Employee_Hierarchy eh ON cte.eh_emp_id = eh.reporting_id
)
SELECT cte.emp_id, eh.emp_id as eh_emp_id 
FROM cte
ORDER BY cte.emp_id, cte.eh_emp_id;
