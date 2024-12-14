WITH UniqueSubmissionDates AS (
    SELECT DISTINCT SUBMISSION_DATE 
    FROM SUBMISSIONS
)
SELECT 
    S1.SUBMISSION_DATE,
    (
        -- Count of unique hackers submitting consecutively
        SELECT COUNT(DISTINCT HACKER_ID)  
        FROM SUBMISSIONS S2  
        WHERE S2.SUBMISSION_DATE = S1.SUBMISSION_DATE 
        AND (
            SELECT COUNT(DISTINCT S3.SUBMISSION_DATE) 
            FROM SUBMISSIONS S3 
            WHERE S3.HACKER_ID = S2.HACKER_ID 
              AND S3.SUBMISSION_DATE < S1.SUBMISSION_DATE
        ) = DATEDIFF(S1.SUBMISSION_DATE, '2016-03-01')
    ) AS ConsecutiveHackers,
    
    (
        -- Find the top hacker for the day (most submissions)
        SELECT HACKER_ID 
        FROM SUBMISSIONS S2 
        WHERE S2.SUBMISSION_DATE = S1.SUBMISSION_DATE 
        GROUP BY HACKER_ID 
        ORDER BY 
            COUNT(SUBMISSION_ID) DESC, 
            HACKER_ID 
        LIMIT 1
    ) AS TopHackerId,
    
    (
        -- Get the name of the top hacker
        SELECT NAME 
        FROM HACKERS 
        WHERE HACKER_ID = TopHackerId
    ) AS TopHackerName

FROM 
    UniqueSubmissionDates S1
GROUP BY 
    S1.SUBMISSION_DATE;
