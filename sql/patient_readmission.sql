-- ====================================================
-- Patient Readmission Analysis
-- ====================================================

-- One-Time vs Repeat Patients (patients with one or multiple admission records)
/* CTE -> mrd_no (patient) wise no. of visits; Main -> Categorize based on no. of visits and count it */
WITH patient_visits AS (
    SELECT mrd_no, COUNT(*) AS visits
    FROM admissions_clean
    GROUP BY mrd_no
)
SELECT (CASE WHEN visits = 1 THEN 'One-Time Patient' ELSE 'Repeat Patient' END) AS patient_category, 
    COUNT(*) AS total_patients, ROUND((COUNT(*)/SUM(COUNT(*)) OVER())*100, 2) AS contribution
FROM patient_visits
GROUP BY patient_category;

-- Admission Frequency Distribution (how many patients had 1, 2, 3, or more admissions)
/* CTE -> mrd_no (patient) wise no. of visits; Main -> No. of visits and its count */
WITH patient_visits AS (
    SELECT mrd_no, COUNT(*) AS visits
    FROM admissions_clean
    GROUP BY mrd_no
)
SELECT visits, COUNT(*) AS total_patients
FROM patient_visits
GROUP BY visits
ORDER BY visits;

-- Patients with the Most Admissions (patients with the highest number of admissions)
SELECT mrd_no, COUNT(*) AS visits
FROM admissions_clean
GROUP BY mrd_no
HAVING COUNT(*) > 10
ORDER BY visits DESC;

-- Repeat Admissions by Age Group (repeat-patient counts across age groups)
/* CTE -> mrd_no (patient) wise, agewise no. of visits; Outer -> Categorize age groups and count total and 
repeated visits (by filtering out no. of visits > 1) */
WITH patient_visits AS (
    SELECT mrd_no, MAX(age_num) AS age_num, COUNT(*) AS visits
    FROM admissions_clean
    GROUP BY mrd_no
)
SELECT (CASE WHEN age_num < 18 THEN '0-18' WHEN age_num BETWEEN 18 AND 29 THEN '18-29' WHEN age_num BETWEEN
    30 AND 44 THEN '30-44' WHEN age_num BETWEEN 45 AND 59 THEN '45-59' WHEN age_num BETWEEN 60 AND 75 THEN
	'60-75' ELSE '75+' END) AS age_group, 
    COUNT(*) AS total_patients, COUNT(*) FILTER(WHERE visits > 1) AS repeat_patients
FROM patient_visits
GROUP BY age_group
ORDER BY age_group;

-- Time Between Consecutive Admissions (no. of days between each patient's consecutive admissions)
/* Inner -> mrd_no, current and previous admission dates; Outer -> Diff. b/w current and previous dates 
by filtering out cases with no previous date i.e. One-Time admission */
SELECT mrd_no, admission_date, prev_admission_date, (admission_date - prev_admission_date) AS days_between_admissions
FROM(SELECT mrd_no, admission_date, 
        LAG(admission_date) OVER(PARTITION BY mrd_no ORDER BY admission_date) AS prev_admission_date
    FROM admissions_clean
    WHERE admission_date IS NOT NULL)
WHERE prev_admission_date IS NOT NULL
ORDER BY days_between_admissions;