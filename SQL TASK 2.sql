--- SQL TASK 2
--- 1. Creating my database:
CREATE DATABASE PRACTICE;

--- 2. Using the created database (This can also be selected manually)
USE PRACTICE;

--- 3. Importing the dataset: The dataset "employee_review" was already saved on my computer. This was imported into the Practice database. I refreshed the database and ensured the table appeared

/* PROBLEM STATEMENT:
==> FIND THE JOB TITLE IN THE "SOFTWARE DEVELOPMENT DEPARTMENT" THAT HAS A "WORK LIFE BALANCE" RATING GREATER THAN 4 AND A "SALARY AND BENEFIT" RATING GREATER THAN 4.5

==> USING THE 'CASE' STATEMENT, CREATE A NEW COLUMN THAT SPECIFIES EVERYTHING GREATER THAN 4 FOR THE WHOLE QUALITIES AS "EXCELLENT", HAVING ATLEAST TWO QUALITIES GREATER THAN 3 AS "GOOD" AND EVERY OTHER THING AS "POOR"
*/

--- 4. Selecting the employee_review table to have an overview of the columns and rows, and check if there are null values. 
SELECT * FROM EMPLOYEE_REVIEW;

--- 5. Checking for NULLS in specific columns: 
SELECT DISTINCT work_life_balance FROM EMPLOYEE_REVIEW
SELECT DISTINCT salary_and_benefits FROM EMPLOYEE_REVIEW
SELECT DISTINCT skill_development FROM EMPLOYEE_REVIEW
SELECT DISTINCT job_security FROM EMPLOYEE_REVIEW
SELECT DISTINCT career_growth FROM EMPLOYEE_REVIEW
SELECT DISTINCT work_satisfaction FROM EMPLOYEE_REVIEW
SELECT DISTINCT overall_rating FROM EMPLOYEE_REVIEW

--- 6. Selecting only rows with NULL values in the work_life_balance and salary_and_benefits columns to have an overview of how many rows have NULL values.
SELECT work_life_balance FROM EMPLOYEE_REVIEW WHERE work_life_balance IS NULL;
SELECT salary_and_benefits FROM EMPLOYEE_REVIEW WHERE salary_and_benefits IS NULL;

--- 7. Counting the number of rows in the dataset: We have a total of 26,993 rows in the dataset.
SELECT DISTINCT COUNT (*) FROM EMPLOYEE_REVIEW;

--- 8. Finding the average rating for both the work_life_balance and salary_and_benefits columns:
SELECT ROUND(AVG(work_life_balance), 0) FROM EMPLOYEE_REVIEW;
SELECT ROUND(AVG(salary_and_benefits), 0) FROM EMPLOYEE_REVIEW;

--- 9. Replacing the NULL values in both the work_life_balance and salary_and_benefits columns with the average rating:
SELECT DISTINCT REPLACE(work_life_balance, NULL, 4) FROM EMPLOYEE_REVIEW 
WHERE work_life_balance IS NULL;
SELECT DISTINCT REPLACE(salary_and_benefits, NULL, 3) FROM EMPLOYEE_REVIEW 
WHERE salary_and_benefits IS NULL;

--- 10. Updating the employee_review table to reflect this change:
UPDATE EMPLOYEE_REVIEW
SET work_life_balance = 4
WHERE work_life_balance IS NULL; 

UPDATE EMPLOYEE_REVIEW
SET salary_and_benefits = 3
WHERE salary_and_benefits IS NULL;

/* Checking to see that the above syntax worked as expected*/
SELECT work_life_balance FROM EMPLOYEE_REVIEW WHERE work_life_balance IS NULL;
SELECT salary_and_benefits FROM EMPLOYEE_REVIEW WHERE salary_and_benefits IS NULL;

SELECT work_life_balance FROM EMPLOYEE_REVIEW;
SELECT salary_and_benefits FROM EMPLOYEE_REVIEW;

--- 11. Fixing the NULL values in other rating columns by calculating the averages and updating the employee_review table for text and numerical data:
SELECT ROUND(AVG(skill_development), 0) FROM EMPLOYEE_REVIEW;
SELECT ROUND(AVG(job_security), 0) FROM EMPLOYEE_REVIEW;
SELECT ROUND(AVG(career_growth), 0) FROM EMPLOYEE_REVIEW;
SELECT ROUND(AVG(work_satisfaction), 0) FROM EMPLOYEE_REVIEW;

UPDATE EMPLOYEE_REVIEW
SET skill_development = 4
WHERE skill_development IS NULL; 

UPDATE EMPLOYEE_REVIEW
SET job_security = 4
WHERE job_security IS NULL;

UPDATE EMPLOYEE_REVIEW
SET career_growth = 4
WHERE career_growth IS NULL; 

UPDATE EMPLOYEE_REVIEW
SET work_satisfaction = 3
WHERE work_satisfaction IS NULL; 

/* Replacing NULL row values in text columns*/
UPDATE EMPLOYEE_REVIEW
SET Title = 'unspecified'
WHERE Title IS NULL; 

UPDATE EMPLOYEE_REVIEW
SET Place = 'unspecified'
WHERE Place IS NULL; 

UPDATE EMPLOYEE_REVIEW
SET Job_type = 'unspecified'
WHERE Job_type IS NULL; 

UPDATE EMPLOYEE_REVIEW
SET Department = 'unspecified'
WHERE Department IS NULL; 

UPDATE EMPLOYEE_REVIEW
SET Date = 'missing'
WHERE Date IS NULL; 

SELECT * FROM EMPLOYEE_REVIEW;

--- 12. Answering problem statement 1:
/*==> FIND THE JOB TITLES IN THE "SOFTWARE DEVELOPMENT DEPARTMENT" THAT HAVE A "WORK LIFE BALANCE" RATING GREATER THAN 4 AND A "SALARY AND BENEFIT" RATING GREATER THAN 4.5
*/
SELECT Title, Department, work_life_balance, salary_and_benefits FROM EMPLOYEE_REVIEW
WHERE Department = 'Software Development Department';

SELECT Title, Department, work_life_balance, salary_and_benefits FROM EMPLOYEE_REVIEW 
WHERE Department = 'Software Development Department' AND
work_life_balance > 4 AND salary_and_benefits > 4.5;

SELECT DISTINCT Title, Department, work_life_balance, salary_and_benefits FROM EMPLOYEE_REVIEW 
WHERE Department = 'Software Development Department' AND
work_life_balance > 4 AND salary_and_benefits > 4.5;

SELECT TOP 3 Title FROM EMPLOYEE_REVIEW
WHERE Department = 'Software Development Department' AND
work_life_balance > 4 AND salary_and_benefits > 4.5;

--- 13. Answering problem statement 2:
/* ==> USING THE 'CASE' STATEMENT, CREATE A NEW COLUMN THAT SPECIFIES EVERYTHING GREATER THAN 4 FOR THE WHOLE QUALITIES AS "EXCELLENT", HAVING ATLEAST TWO QUALITIES GREATER THAN 3 AS "GOOD" AND EVERY OTHER THING AS "POOR"
--- The qualities being evaluated are overall_rating, work_life_balance, skill_development, salary_and_benefits, job_security, career_growth, and  work_satisfaction
--- Create a new column that returns the classification 'Excellent' when every quality is greater than 4,
--- If at least 2 of these ratings are greater than 3, classify as 'Good',
--- Otherwise classify as 'Poor'. Title the new column "Remark" 
*/
SELECT *,
    CASE
        WHEN 
            (CASE WHEN overall_rating > 3 AND overall_rating <= 4 THEN 1 ELSE 0 END +
             CASE WHEN work_life_balance > 3 AND work_life_balance <= 4 THEN 1 ELSE 0 END +
             CASE WHEN skill_development > 3 AND skill_development <= 4 THEN 1 ELSE 0 END +
             CASE WHEN salary_and_benefits > 3 AND salary_and_benefits <= 4 THEN 1 ELSE 0 END +
             CASE WHEN job_security > 3 AND job_security <= 4 THEN 1 ELSE 0 END +
             CASE WHEN career_growth > 3 AND career_growth <= 4 THEN 1 ELSE 0 END +
             CASE WHEN work_satisfaction > 3 AND work_satisfaction <= 4 THEN 1 ELSE 0 END) >= 2
        THEN 'Good'
        WHEN 
            (overall_rating > 4 AND work_life_balance > 4 AND skill_development > 4 AND 
             salary_and_benefits > 4 AND job_security > 4 AND career_growth > 4 AND work_satisfaction > 4)
        THEN 'Excellent'
        ELSE 'Poor'
    END AS Remark
FROM EMPLOYEE_REVIEW;


/*ALTER TABLE employee_review
DROP COLUMN Remark;

SELECT *
FROM employee_review;*/




--- 14. Altering the employee_review table to add the column "Remark" and update the rows with the corresponding classifications:
ALTER TABLE EMPLOYEE_REVIEW ADD Remark VARCHAR(50);
SELECT * FROM EMPLOYEE_REVIEW

UPDATE EMPLOYEE_REVIEW
SET Remark = CASE
        WHEN 
            (CASE WHEN overall_rating > 3 AND overall_rating <= 4 THEN 1 ELSE 0 END +
             CASE WHEN work_life_balance > 3 AND work_life_balance <= 4 THEN 1 ELSE 0 END +
             CASE WHEN skill_development > 3 AND skill_development <= 4 THEN 1 ELSE 0 END +
             CASE WHEN salary_and_benefits > 3 AND salary_and_benefits <= 4 THEN 1 ELSE 0 END +
             CASE WHEN job_security > 3 AND job_security <= 4 THEN 1 ELSE 0 END +
             CASE WHEN career_growth > 3 AND career_growth <= 4 THEN 1 ELSE 0 END +
             CASE WHEN work_satisfaction > 3 AND work_satisfaction <= 4 THEN 1 ELSE 0 END) >= 2
        THEN 'Good'
        WHEN 
            (overall_rating > 4 AND work_life_balance > 4 AND skill_development > 4 AND 
             salary_and_benefits > 4 AND job_security > 4 AND career_growth > 4 AND work_satisfaction > 4)
        THEN 'Excellent'
        ELSE 'Poor'
    END

SELECT * FROM EMPLOYEE_REVIEW