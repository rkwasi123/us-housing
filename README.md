# 🏠 US Household Income Data Cleaning Project
This project involves comprehensive SQL operations on the us_project.us_household_income and us_project.us_household_income_statistics tables. It focuses on cleaning and preparing the data for meaningful analysis by removing duplicates, correcting values, renaming columns, and handling inconsistencies.

## 📚 Table of Contents
## 📂 Database Selection

📝 Renaming Columns

🔢 Record Counting

🧬 Identifying Duplicates

❌ Removing Duplicates

🔍 Distinct Values Query

✏️ Updating Records

🔎 Data Filtering and Sorting

📊 Record Grouping

⚠️ Handling NULL and Zero Values

🧾 Notes

📂 Database Selection
Fetch all records from the primary and statistics tables:

```
sql
SELECT * FROM us_project.us_household_income;
SELECT * FROM us_project.us_household_income_statistics;
```
##📝 Renaming Columns
Fix column name encoding issues:
```
sql
ALTER TABLE us_project.us_household_income_statistics 
RENAME COLUMN ï»¿id TO id;
```
🔢 Record Counting
Total number of records in each table:
```
sql
SELECT COUNT(id) FROM us_project.us_household_income;
SELECT COUNT(id) FROM us_project.us_household_income_statistics;
```
🧬 Identifying Duplicates
Check for duplicate IDs:
```
sql
SELECT id, COUNT(id)
FROM us_project.us_household_income
GROUP BY id
HAVING COUNT(id) > 1;
Using window function to list duplicates:

sql
SELECT *
FROM (
  SELECT row_id, id, 
         ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) AS row_num
  FROM us_project.us_household_income
) duplicates
WHERE row_num > 1;
```
❌ Removing Duplicates
Remove duplicates based on row_id:
```
sql
DELETE FROM us_household_income
WHERE row_id IN (
  SELECT row_id
  FROM (
    SELECT row_id, id,
           ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) AS row_num
    FROM us_project.us_household_income
  ) duplicates
  WHERE row_num > 1
);
```
🔍 Distinct Values Query
Fetch unique state names:
```
sql
SELECT DISTINCT State_Name
FROM us_project.us_household_income
ORDER BY 1;
```
✏️ Updating Records
Correct state names:
```
sql
UPDATE us_project.us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia';

UPDATE us_project.us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama';
Correct place names based on city and county:

sql
UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County' AND City = 'Vinemont';
```
🔎 Data Filtering and Sorting
Filter and order records by county:
```
sql
SELECT *
FROM us_project.us_household_income
WHERE County = 'Autauga County'
ORDER BY 1;
```
📊 Record Grouping
Group and count by place Type:
```
sql
SELECT Type, COUNT(Type)
FROM us_project.us_household_income
GROUP BY Type;
```
Standardize values in the Type column:
```
sql
UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs';
```
⚠️ Handling NULL and Zero Values
Identify records with zero or null ALand values:

```
sql
SELECT State_Name, ALand, AWater
FROM us_project.us_household_income
WHERE ALand = 0 OR ALand = '' OR ALand IS NULL;
```

##🧾 Notes
This data cleaning process ensures consistency and accuracy in the dataset.

Redundant records are eliminated, and inconsistencies in naming are corrected.

The dataset is now ready for reliable analytical tasks and visualization efforts.
