CREATE TABLE projects (
id INTEGER PRIMARY KEY,
title VARCHAR(100),
start_date DATETIME,
end_date DATETIME,
budget FLOAT
);

INSERT INTO projects (id, title, start_date, end_date, budget) VALUES
(1, 'Website Redesign', '2024-01-01', '2024-02-15', 50000),
(2, 'Mobile App Phase 1', '2024-02-15', '2024-04-01', 75000),
(3, 'Database Migration', '2024-04-01', '2024-05-15', 60000),
(4, 'Cloud Integration', '2024-03-01', '2024-04-15', 45000),
(5, 'Security Audit', '2024-05-15', '2024-06-30', 30000);

"""
Write a query to return pairs of projects where the end date of one project matches the start date of another project.
"""

SELECT 
    p2.title AS project_title_end,
    p1.title AS project_title_start,
    DATE(p2.end_date) AS date
FROM 
    projects p1
JOIN 
    projects p2 ON DATE(p1.start_date) = DATE(p2.end_date)
WHERE 
    p1.id <> p2.id;
