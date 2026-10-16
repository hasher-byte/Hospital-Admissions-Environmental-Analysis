-- ====================================================
-- Length of Stay & ICU Utilisation
-- ====================================================

SELECT stay_days, icu_days FROM admissions_clean;
SELECT COUNT(*) - COUNT(stay_days), COUNT(*) - COUNT(icu_days) FROM admissions_clean;

-- Average Length of Stay by Outcome (average hospital stay duration across recorded outcomes)
SELECT outcome, COUNT(*) AS total_admissions, ROUND(AVG(stay_days), 2) AS average_stay_days
FROM admissions_clean
GROUP BY outcome
ORDER BY average_stay_days DESC;

-- Average Length of Stay by Admission Type (admission types with longer average hospital stays)
SELECT type_of_admission_emergency_opd AS admission_type, COUNT(*) AS total_admissions, ROUND(AVG(stay_days), 2) AS average_stay_days
FROM admissions_clean
GROUP BY admission_type
ORDER BY average_stay_days DESC;

-- Length of Stay by Age Group (average stay duration across patient age groups)
SELECT (CASE WHEN age_num < 18 THEN '0-18' WHEN age_num BETWEEN 18 AND 29 THEN '18-29' WHEN age_num BETWEEN
    30 AND 44 THEN '30-44' WHEN age_num BETWEEN 45 AND 59 THEN '45-59' WHEN age_num BETWEEN 60 AND 75 THEN
	'60-75' ELSE '75+' END) AS age_group, ROUND(AVG(stay_days), 2) AS average_stay_days
FROM admissions_clean
GROUP BY age_group
ORDER BY age_group;

-- ICU Utilisation by Outcome (total and average recorded ICU days across outcome)
SELECT outcome, SUM(icu_days) AS total_icu_days, ROUND(AVG(icu_days), 2) AS average_icu_days
FROM admissions_clean
GROUP BY outcome
ORDER BY average_icu_days DESC;

-- ICU Utilisation by Admission Type (ICU duration variation across admission types)
SELECT type_of_admission_emergency_opd AS admission_type, SUM(icu_days) AS total_icu_days, ROUND(AVG(icu_days), 2) AS average_icu_days
FROM admissions_clean
GROUP BY admission_type
ORDER BY average_icu_days DESC;

-- Length-of-Stay Distribution (group admissions into stay-duration bands)
SELECT (CASE WHEN stay_days BETWEEN 1 AND 3 THEN '1-3 Days' WHEN stay_days BETWEEN 4 AND 7 THEN '4-7 Days'
    WHEN stay_days BETWEEN 8 AND 14 THEN '8-14 Days' ELSE '15+ Days' END) AS stay_group, COUNT(*) AS total_admissions
FROM admissions_clean
GROUP BY stay_group
ORDER BY stay_group;

