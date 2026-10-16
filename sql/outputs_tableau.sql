-- ====================================================
-- Prepare SQL outputs for Tableau
-- ====================================================

-- Create a monthly admissions view (How does hospital admission volume change month by month?)
CREATE OR REPLACE VIEW tableau_monthly_admissions AS
SELECT DATE_TRUNC('month', admission_date)::DATE AS month, COUNT(*) AS total_admissions, ROUND(AVG(age_num), 1) 
    AS average_age, ROUND(AVG(stay_days), 1) AS average_length_of_stay
FROM admissions_clean
WHERE admission_date IS NOT NULL
GROUP BY month
ORDER BY month;

-- Create a patient demographics view (Which age groups and genders account for the most admissions)
CREATE OR REPLACE VIEW tableau_patient_demographics AS
SELECT (CASE WHEN age_num < 18 THEN '0-18' WHEN age_num BETWEEN 18 AND 29 THEN '18-29' WHEN age_num BETWEEN
    30 AND 44 THEN '30-44' WHEN age_num BETWEEN 45 AND 59 THEN '45-59' WHEN age_num BETWEEN 60 AND 74 THEN 
	'60-74' ELSE '75+' END) AS age_category, gender, COUNT(*) AS total_admissions
FROM admissions_clean
GROUP BY age_category, gender
ORDER BY age_category, gender;

-- Create an outcomes view (What outcomes are recorded for hospital admissions?)
CREATE OR REPLACE VIEW tableau_admission_outcome AS
SELECT outcome, COUNT(*) AS total_admissions, ROUND((COUNT(*)/SUM(COUNT(*)) OVER())*100, 2) AS percentage_of_admissions
FROM admissions_clean
GROUP BY outcome
ORDER BY total_admissions DESC;

-- Create a monthly pollution view (How do air quality and particulate pollution change over time?)
CREATE OR REPLACE VIEW tabeau_monthly_pollution AS
SELECT DATE_TRUNC('month', pollution_date_clean)::DATE AS month, ROUND(AVG(aqi_num), 2) AS average_aqi, 
    ROUND(AVG(pm25_num), 2) AS average_pm25, ROUND(AVG(pm10_num), 2) AS average_pm10, ROUND(AVG(no2_num), 2) AS average_no2
FROM pollution_clean
WHERE pollution_date_clean IS NOT NULL
GROUP BY month
ORDER BY month;

-- Verify the views
SELECT * FROM tableau_monthly_admissions;
SELECT * FROM tableau_patient_demographics;
SELECT * FROM tableau_admission_outcome;
SELECT * FROM tabeau_monthly_pollution;
