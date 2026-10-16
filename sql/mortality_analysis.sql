-- ====================================================
-- Mortality Analysis
-- ====================================================

-- Total Mortality Records (359)
SELECT COUNT(*) AS total_mortality_records
FROM mortality_clean;

-- Mortality Records by Gender (gender distribution of mortality records)
SELECT gender, COUNT(*) AS total_records
FROM mortality_clean
GROUP BY gender
ORDER BY total_records DESC;

-- Mortality Records by Age Group (which age groups account for the highest mortality records)
SELECT (CASE WHEN age_num < 18 THEN '0-18' WHEN age_num BETWEEN 18 AND 29 THEN '18-29' WHEN age_num BETWEEN
    30 AND 44 THEN '30-44' WHEN age_num BETWEEN 45 AND 59 THEN '45-59' WHEN age_num BETWEEN 60 AND 75 THEN
	'60-75' ELSE '75+' END) AS age_group, COUNT(*) AS total_records
FROM mortality_clean
GROUP BY age_group
ORDER BY total_records DESC;

-- Mortality Records by Year (how recorded mortality dates are distributed across years)
SELECT EXTRACT(YEAR FROM death_date_clean) AS death_year, COUNT(*) AS total_records
FROM mortality_clean
WHERE death_date_clean IS NOT NULL
GROUP BY death_year
ORDER BY death_year;

-- Mortality Records by Month (months with the highest and lowest number of mortality dates)
SELECT DATE_TRUNC('month', death_date_clean) AS death_month, COUNT(*) AS total_records
FROM mortality_clean
WHERE death_date_clean IS NOT NULL
GROUP BY death_month
ORDER BY death_month;

-- Duplicate MRD Numbers (MRD numbers that appear multiple times in the mortality dataset)
SELECT mrd, COUNT(*) AS record_count
FROM mortality_clean
GROUP BY mrd
HAVING COUNT(*) > 1
ORDER BY record_count DESC;

-- Mortality Records with Missing or Invalid MRD Numbers 
SELECT mrd 
FROM mortality_clean 
WHERE mrd IS NULL OR mrd !~ '^[0-9]{5,6}$';

-- Mortality Records with Unresolved Death Dates (death date could not be converted into a valid date)
SELECT COUNT(*) AS unresolved_death_dates
FROM mortality_clean
WHERE death_date_clean IS NULL;