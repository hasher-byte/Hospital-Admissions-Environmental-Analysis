-- ====================================================
-- Patient Demographics
-- ====================================================

-- Admissions by Gender (admission counts across gender)
SELECT gender, COUNT(*) AS total_admissions
FROM admissions_clean
GROUP BY gender;

-- Admissions by Age Group (group patients into age bands to identify which age groups account for the most admissions)
SELECT (CASE WHEN age_num < 18 THEN '0-18' WHEN age_num BETWEEN 18 AND 29 THEN '18-29' WHEN age_num BETWEEN
    30 AND 44 THEN '30-44' WHEN age_num BETWEEN 45 AND 59 THEN '45-59' WHEN age_num BETWEEN 60 AND 75 THEN
	'60-75' ELSE '75+' END) AS age_group, COUNT(*) AS total_admissions
FROM admissions_clean
GROUP BY age_group
ORDER BY age_group ASC;

-- Average Age by Gender (average patient age across recorded gender)
SELECT gender, ROUND(AVG(age_num), 2) AS avg_age
FROM admissions_clean
GROUP BY gender;

-- Age Group by Gender (admissions across age groups and gender)
SELECT (CASE WHEN age_num < 18 THEN '0-18' WHEN age_num BETWEEN 18 AND 29 THEN '18-29' WHEN age_num BETWEEN
    30 AND 44 THEN '30-44' WHEN age_num BETWEEN 45 AND 59 THEN '45-59' WHEN age_num BETWEEN 60 AND 75 THEN
	'60-75' ELSE '75+' END) AS age_group, gender, COUNT(*) AS total_admissions
FROM admissions_clean
GROUP BY age_group, gender
ORDER BY age_group ASC, gender;

-- Admissions by Rural/Urban Category (recorded rural/urban categories and their admission counts)
SELECT rural, COUNT(*) AS total_admissions
FROM admissions_clean
GROUP BY rural;