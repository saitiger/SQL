-- Solving problem to find hierarchy/querying hierarchical data 
WITH RECURSIVE emp_hierarchy AS (
    SELECT id, name, manager_id, designation, 1 AS lvl
    FROM emp_details 
    WHERE name = 'Asha'
    UNION
    SELECT E.id, E.name, E.manager_id, E.designation, H.lvl + 1 AS lvl
    FROM emp_hierarchy H
    JOIN emp_details E ON H.id = E.manager_id
)
SELECT * 
FROM emp_hierarchy;
