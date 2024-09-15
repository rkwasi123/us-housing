SQL Operations on us_project.us_household_income Database
This document provides a detailed explanation of the SQL operations performed on the us_project.us_household_income and us_project.us_household_income_statistics tables. These operations include selecting data, identifying duplicates, deleting records, updating values, and more.

Table of Contents
Database Selection Queries
Renaming Columns
Record Counting
Identifying Duplicates
Removing Duplicates
Distinct Values Query
Updating Records
Data Filtering and Sorting
Record Grouping
Handling NULL and Zero Values


1. Database Selection Queries
#Fetch all records from us_household_income and us_household_income_statistics:

SELECT * 
FROM us_project.us_household_income;

SELECT * 
FROM us_project.us_household_income_statistics;

2. Renaming Columns
#The column ï»¿id in us_household_income_statistics is renamed to id:

ALTER TABLE us_project.us_household_income_statistics 
RENAME COLUMN `ï»¿id` TO `id`;

3. Record Counting
#Count the total number of records in both tables:

SELECT COUNT(id)
FROM us_project.us_household_income;

SELECT COUNT(id)
FROM us_project.us_household_income_statistics;

4. Identifying Duplicates
#Identify duplicate records in the us_household_income table based on id:

SELECT id, COUNT(id)
FROM us_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1;

#Select all duplicate records by using a window function with ROW_NUMBER:

sql
Copy code
SELECT *
FROM (
    SELECT row_id, id, ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) row_num
    FROM us_project.us_household_income
) duplicates
WHERE row_num > 1;

5. Removing Duplicates
#Remove duplicate records from us_household_income based on the row_id:

DELETE FROM us_household_income
WHERE row_id IN (
    SELECT row_id
    FROM (
        SELECT row_id, id, ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) row_num
        FROM us_project.us_household_income
    ) duplicates
    WHERE row_num > 1
);

6. Distinct Values Query
#Fetch a distinct list of state names from us_household_income:

SELECT DISTINCT State_Name
FROM us_project.us_household_income
ORDER BY 1;

7. Updating Records
#Update state names where there are discrepancies in the case:

UPDATE us_project.us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';

UPDATE us_project.us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';

#Update incorrect place names based on the county and city:

UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont';

Data Filtering and Sorting
#Select records from us_household_income where the county is Autauga County and order them:

SELECT *
FROM us_project.us_household_income
WHERE County = 'Autauga County'
ORDER BY 1;

9. Record Grouping
#Group records by Type and count the number of occurrences:

SELECT Type, COUNT(Type)
FROM us_project.us_household_income
GROUP BY Type;

#Correct the Type values to maintain consistency:

UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs';

10. Handling NULL and Zero Values
#Select records where ALand is either 0, empty, or NULL:

SELECT State_Name, ALand, AWater
FROM us_project.us_household_income
WHERE (ALand = 0 OR ALand = '' OR ALand IS NULL);

Notes:
The above SQL queries aim to clean and organize data in the us_project.us_household_income and us_project.us_household_income_statistics tables.
Duplicate records are handled by identifying and removing them.
Updates focus on correcting discrepancies in values, particularly state names and place information.
Grouping and counting operations help analyze the distribution of data types.
