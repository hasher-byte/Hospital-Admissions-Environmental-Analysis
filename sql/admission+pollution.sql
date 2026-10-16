-- ====================================================
-- Combined Admissions & Pollution Analysis
-- ====================================================
select * from admissions_pollution_analysis

-- Daily Admissions vs AQI (relation between higher AQI and higher hospital admission counts)
/* CTE -> For each date, average aqi and count (daily admissions); Main -> categorize aqi
and based on it find total admissions which gives no. of admissions for each category */
WITH daily AS (
    SELECT admission_date, ROUND(AVG(aqi_num), 2) AS avg_aqi, COUNT(*) AS admission_counts
    FROM admissions_pollution_analysis
    WHERE admission_date IS NOT NULL
    GROUP BY admission_date
)
SELECT (CASE WHEN avg_aqi <= 50 THEN 'Good'
    WHEN avg_aqi <= 100 THEN 'Satisfactory'
    WHEN avg_aqi <= 200 THEN 'Moderate'
    WHEN avg_aqi <= 300 THEN 'Poor'
    WHEN avg_aqi <= 400 THEN 'Very Poor'
    ELSE 'Severe' END) AS aqi_category, SUM(admission_counts) AS total_admissions
FROM daily
GROUP BY aqi_category
ORDER BY total_admissions DESC;

-- Monthly Admissions vs Pollution (how monthly admission count changes with average AQI and pollution)
SELECT DATE_TRUNC('month', admission_date)::DATE AS month, COUNT(*) AS total_admissions, ROUND(AVG(aqi_num),2) AS avg_aqi, 
    ROUND(AVG(pm25_num),2) AS avg_pm25, ROUND(AVG(pm10_num), 2) AS avg_pm10, ROUND(AVG(no2_num), 2) AS avg_no2
FROM admissions_pollution_analysis
WHERE admission_date IS NOT NULL
GROUP BY month
ORDER BY month;

-- Correlation Between Daily Admissions and AQI (statistical relationship between AQI and daily admission)
/* CTE -> For each date, average aqi and count (daily admissions); Main -> correlation (-ve) */
WITH daily AS (
    SELECT admission_date, ROUND(AVG(aqi_num), 2) AS avg_aqi, COUNT(*) AS admission_counts
    FROM admissions_pollution_analysis
    WHERE admission_date IS NOT NULL
    GROUP BY admission_date
)
SELECT ROUND(CORR(admission_counts, avg_aqi)::NUMERIC, 4) AS admissions_aqi_correlation
FROM daily;

-- Admissions vs PM2.5 (do days with higher PM2.5 readings tend to coincide with higher admission counts)
/* CTE -> For each date, average pm2.5 and count (daily admissions); Main -> correlation (-ve) */
WITH daily AS (
	SELECT admission_date,  ROUND(AVG(pm25_num), 2) AS pm25, COUNT(*) AS total_admissions
    FROM admissions_pollution_analysis
    WHERE admission_date IS NOT NULL
    GROUP BY admission_date
)
SELECT ROUND(CORR(total_admissions, pm25)::NUMERIC, 4) AS admissions_pm25_correlation
FROM daily;

/* Note: CORR() measures how two sets of numbers vary together. 
1 → perfect positive correlation (both increase together)
-1 → perfect negative correlation (one increases as the other decreases)
0 → no linear correlation */