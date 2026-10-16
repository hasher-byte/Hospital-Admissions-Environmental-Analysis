-- ====================================================
-- Pollution & Weather Analysis
-- ====================================================
SELECT COUNT(*) - COUNT(pollution_date_clean) FROM pollution_clean;

-- Daily Air Quality Index (AQI) Overview (average, minimum, and maximum recorded AQI)
SELECT ROUND(AVG(aqi_num), 2) AS avg_aqi, MIN(aqi_num) AS min_aqi, MAX(aqi_num) AS max_aqi
FROM pollution_clean;

-- Monthly Average AQI (months with the highest and lowest average AQI)
SELECT EXTRACT(MONTH FROM pollution_date_clean) AS months, ROUND(AVG(aqi_num), 2) AS avg_aqi
FROM pollution_clean
WHERE pollution_date_clean IS NOT NULL
GROUP BY months
ORDER BY months;

-- Pollution Category Distribution (classify AQI readings into broad categories)
SELECT (CASE WHEN aqi_num <= 50 THEN 'Good'
    WHEN aqi_num <= 100 THEN 'Satisfactory'
    WHEN aqi_num <= 200 THEN 'Moderate'
    WHEN aqi_num <= 300 THEN 'Poor'
    WHEN aqi_num <= 400 THEN 'Very Poor'
    ELSE 'Severe' END) AS aqi_category, COUNT(*) AS days_recorded
FROM pollution_clean
GROUP BY aqi_category
ORDER BY days_recorded DESC;

-- Monthly PM2.5 and PM10 Trends (monthly average PM2.5 and PM10 concentrations)
SELECT EXTRACT(MONTH FROM pollution_date_clean) AS months, TO_CHAR(pollution_date_clean, 'Month') As name, 
    ROUND(AVG(pm25_num),2) AS avg_pm25, ROUND(AVG(pm10_num), 2) AS avg_pm10
FROM pollution_clean
WHERE pollution_date_clean IS NOT NULL
GROUP BY months, name
ORDER BY months, name;

-- Monthly NO2 Trend (monthly average NO2 concentration)
SELECT EXTRACT(MONTH FROM pollution_date_clean) AS months, TO_CHAR(pollution_date_clean, 'Month') As name, 
    ROUND(AVG(no2_num),2) AS avg_no2
FROM pollution_clean
WHERE pollution_date_clean IS NOT NULL
GROUP BY months, name
ORDER BY months, name;

-- Temperature and Humidity Patterns (average maximum temperature, minimum temperature, and humidity)
SELECT DATE_TRUNC('month', pollution_date_clean)::DATE AS months, ROUND(AVG(max_temp_num), 2) AS avg_max_temp, 
    ROUND(AVG(min_temp_num), 2) AS avg_min_temp, ROUND(AVG(humidity_num), 2) AS avg_humidity
FROM pollution_clean
WHERE pollution_date_clean IS NOT NULL
GROUP BY months
ORDER BY months;

-- Days with the Highest AQI (dates with the worst recorded AQI)
SELECT pollution_date_clean AS date, aqi_num, pm25_num, pm10_num, no2_num
FROM pollution_clean
WHERE pollution_date_clean IS NOT NULL
ORDER BY aqi_num DESC
LIMIT 10;

-- Annual Pollution Comparison (average AQI and pollutant levels across years)
SELECT EXTRACT(YEAR FROM pollution_date_clean) AS year, ROUND(AVG(aqi_num),2) AS avg_aqi, 
    ROUND(AVG(pm25_num),2) AS avg_pm25, ROUND(AVG(pm10_num), 2) AS avg_pm10, ROUND(AVG(no2_num), 2) AS avg_no2
FROM pollution_clean
WHERE pollution_date_clean IS NOT NULL
GROUP BY year
ORDER BY year;