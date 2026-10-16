-- ====================================================
-- Admission Type & Outcome Analysis
-- ====================================================

-- Admissions by Admission Type (most common admission types)
SELECT type_of_admission_emergency_opd AS admission_type, COUNT(*) AS total_admissions
FROM admissions_clean
GROUP BY admission_type
ORDER BY total_admissions DESC;

-- Admissions by Outcome (number and percentage of admissions in each recorded outcome category)
SELECT outcome, COUNT(*) AS total_admissions, ROUND((COUNT(*)/SUM(COUNT(*)) OVER())*100, 2) AS percentage
FROM admissions_clean
GROUP BY outcome
ORDER BY percentage DESC;

-- Outcome Percentage Within Each Admission Type (percentage of each admission type that falls into each recorded outcome)
SELECT type_of_admission_emergency_opd AS admission_type, outcome, COUNT(*) AS total_admissions, 
    ROUND((COUNT(*)/SUM(COUNT(*)) OVER(PARTITION BY type_of_admission_emergency_opd))*100, 2) AS percentage
FROM admissions_clean
GROUP BY admission_type, outcome
ORDER BY admission_type, percentage DESC;

-- Admission Type by Year (admission types across years)
SELECT type_of_admission_emergency_opd AS admission_type, EXTRACT(YEAR FROM admission_date) AS admission_year,
    COUNT(*) AS total_admissions
FROM admissions_clean
WHERE admission_date IS NOT NULL
GROUP BY admission_type, admission_year
ORDER BY admission_type, admission_year;