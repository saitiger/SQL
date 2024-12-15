WITH parent_child_count AS 
(
SELECT parent_id,COUNT(*) num_of_children
FROM
parent_child_relationships
GROUP BY 1  
)
SELECT f.name Parent_Name, p.num_of_children
FROM
parent_child_count p 
JOIN 
family_members f 
ON 
p.parent_id = f.member_id
ORDER BY 2 DESC
LIMIT 3
