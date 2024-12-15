-- Solving problem to find hierarchy/querying hierarchical data 

-- Finding All Employees for Given Mananger
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

-- Finding All Managers for Given Employee 
WITH RECURSIVE emp_hierarchy AS (
    SELECT id, name, manager_id, designation, 1 AS lvl
    FROM emp_details 
    WHERE name = 'David'
    UNION
    SELECT E.id, E.name, E.manager_id, E.designation, H.lvl + 1 AS lvl
    FROM emp_hierarchy H
    JOIN emp_details E ON H.manager_id = E.id
)
SELECT H2.id AS emp_id, 
       H2.name AS emp_name, 
       E2.name AS manager_name, 
       H2.lvl AS level
FROM emp_hierarchy H2
JOIN emp_details E2 ON E2.id = H2.manager_id;
