-- ====================================================
-- KPI Analysis
-- ====================================================

-- Total Admissions (15757)
SELECT COUNT(*) AS total_admissions
FROM admissions_clean;

-- Unique Patients (12244)
SELECT COUNT(DISTINCT mrd_no) AS unique_patients
FROM admissions_clean;

-- Average Patient Age (61.4)
SELECT ROUND(AVG(age_num), 1) AS average_age
FROM admissions_clean;

-- Average Length of Stay (6.4 days)
SELECT ROUND(AVG(stay_days), 1) AS average_stay_days
FROM admissions_clean;

-- Average ICU Days (3.8 days)
SELECT ROUND(AVG(icu_days), 1) AS average_icu_days
FROM admissions_clean;

-- Admissions by Gender (M=9990, F=5767)
SELECT gender, COUNT(*) AS total_admissions
FROM admissions_clean
GROUP BY gender;

-- Admissions by Admission Type (O=4833, E=10924)
SELECT type_of_admission_emergency_opd AS admission_type, COUNT(*) AS total_admissions
FROM admissions_clean
GROUP BY admission_type;

-- Admissions by Outcome
SELECT outcome, COUNT(*) AS total_admissions, ROUND((COUNT(*)/SUM(COUNT(*)) OVER())*100, 2) AS percentage
FROM admissions_clean
GROUP BY outcome
ORDER BY percentage DESC;

-- Unresolved Admission Dates (6335)
SELECT COUNT(*) AS unresolved_admission_dates
FROM admissions_clean 
WHERE admission_date IS NULL;

-- Unresolved Discharge Dates (6439)
SELECT COUNT(*) AS unresolved_discharge_dates
FROM admissions_clean 
WHERE discharge_date IS NULL;

-- Repeat Patients (2598)
SELECT COUNT(*) AS repeat_patients
FROM(SELECT mrd_no, COUNT(*) AS visits
    FROM admissions_clean
    GROUP BY mrd_no)
WHERE visits > 1;