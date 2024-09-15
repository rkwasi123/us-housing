# US Household Income Data Cleaning

# Database Selection Queries	
SELECT * 
FROM us_project.us_household_income;

SELECT * 
FROM us_project.us_household_income_statistics;

# Renaming Columns
ALTER TABLE us_project.us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;

# Record Counting 
SELECT COUNT(id)
FROM us_project.us_household_income;

SELECT COUNT(id)
FROM us_project.us_household_income_statistics;


# Identifying Duplicates
SELECT id, COUNT(id)
FROM us_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1
;

# Selecting all duplicate records by using a window function with ROW_NUMBER:
SELECT*
FROM(
SELECT row_id,
id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
FROM us_project.us_household_income
) duplicates
WHERE row_num > 1
;

# Removing Duplicates based on the row_id
DELETE FROM us_household_income
WHERE row_id IN (
	SELECT row_id
	FROM(
		SELECT row_id,
		id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
		FROM us_project.us_household_income
		) duplicates
	WHERE row_num > 1)
;

#Distinct Values Query
	
SELECT DISTINCT State_Name
FROM us_project.us_household_income
ORDER BY 1
;

# Updating Records
	
UPDATE us_project.us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';

UPDATE us_project.us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';

#Data Filtering and Sorting
	
SELECT *
from us_project.us_household_income
WHERE County = 'Autauga County'
ORDER BY 1
;

UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont'
;

#Record Grouping
	
SELECT Type, COUNT(Type)
FROM us_project.us_household_income
GROUP BY Type
;

#Correct the Type values to maintain consistency:
	
UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;

#Handling NULL and Zero Values
	
SELECT State_Name, ALand, AWater
FROM us_project.us_household_income
WHERE (ALand = 0 OR ALand = '' OR ALand IS NULL)
#AND ALand = 0 OR ALand = '' OR ALand IS NULL
;
