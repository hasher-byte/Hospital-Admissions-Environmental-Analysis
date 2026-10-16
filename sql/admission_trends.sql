-- ====================================================
-- Admission Trends
-- ====================================================

-- Monthly Admissions (admission volume changes with month)
SELECT DATE_TRUNC('month', admission_date)::DATE AS admission_month, COUNT(*) AS total_admissions
FROM admissions_clean
WHERE admission_date IS NOT NULL
GROUP BY admission_month
ORDER BY admission_month;

-- Year-wise Admissions (total admissions across years)
SELECT EXTRACT(YEAR FROM admission_date) AS admission_year, COUNT(*) AS total_admissions
FROM admissions_clean
WHERE admission_date IS NOT NULL 
GROUP BY admission_year
ORDER BY admission_year;

-- Month-wise Admission Patterns (admission volume by calender months)
SELECT EXTRACT(MONTH FROM admission_date) AS month_number, TO_CHAR(admission_date, 'Month') AS month_name,
    COUNT(*) AS total_admissions
FROM admissions_clean
WHERE admission_date IS NOT NULL 
GROUP BY month_number, month_name
ORDER BY month_number, month_name;

-- Day-of-Week Admission Patterns (which days of the week have the highest admission volume)
SELECT EXTRACT(ISODOW FROM admission_date) AS weekday_number, TO_CHAR(admission_date, 'FMDay') AS weekday_name,
    COUNT(*) AS total_admissions
FROM admissions_clean
WHERE admission_date IS NOT NULL
GROUP BY weekday_number, weekday_name
ORDER BY weekday_number, weekday_name;

-- Admissions by Admission Type Over Time (monthly admissions across admission types to see how their volumes change over time)
SELECT DATE_TRUNC('month', admission_date)::DATE AS admission_month, type_of_admission_emergency_opd AS admission_type,
     COUNT(*) AS total_admissions
FROM admissions_clean
WHERE admission_date IS NOT NULL
GROUP BY admission_month, admission_type
ORDER BY admission_month, admission_type;

/* Note: DATE_TRUNC('month', admission_date)::DATE gives only date whereas 
DATE_TRUNC('month', admission_date) gives date and timestamp as well */