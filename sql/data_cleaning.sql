-- ====================================================
-- Data Cleaning
-- ====================================================

/* Admissions */
-- Confirming for NULL values
SELECT COUNT(*) - COUNT(doa) FROM admissions_raw;
SELECT COUNT(*) - COUNT(dod) FROM admissions_raw;
SELECT TO_DATE(doa, 'DD/MM/YYYY') FROM admissions_raw; --error

-- Cleaned table from raw table
CREATE TABLE admissions_clean AS
SELECT *,
    (CASE WHEN TRIM(doa) ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' AND SPLIT_PART(TRIM(doa), '/', 1)::int > 12
    THEN TO_DATE(TRIM(doa), 'DD/MM/YYYY')
    WHEN TRIM(doa) ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' AND SPLIT_PART(TRIM(doa), '/', 2)::int > 12
    THEN TO_DATE(TRIM(doa), 'MM/DD/YYYY')
    ELSE NULL
    END) AS admission_date,
	
    (CASE WHEN TRIM(dod) ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' AND SPLIT_PART(TRIM(dod), '/', 1)::int > 12
    THEN TO_DATE(TRIM(dod), 'DD/MM/YYYY')
    WHEN TRIM(dod) ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' AND SPLIT_PART(TRIM(dod), '/', 2)::int > 12
    THEN TO_DATE(TRIM(dod), 'MM/DD/YYYY')
    ELSE NULL
    END) AS discharge_date,

    CASE WHEN TRIM(age) ~ '^[0-9]+$'
    THEN TRIM(age)::INTEGER END AS age_num,

    CASE WHEN TRIM(duration_of_stay) ~ '^[0-9]+$'
    THEN TRIM(duration_of_stay)::INTEGER END AS stay_days,

    CASE WHEN TRIM(duration_of_intensive_unit_stay) ~ '^[0-9]+$'
    THEN TRIM(duration_of_intensive_unit_stay)::INTEGER END AS icu_days

FROM admissions_raw;


/* Mortality */
-- Confirming for NULL values
SELECT COUNT(*) - COUNT(age) FROM mortality_raw;
SELECT COUNT(*) - COUNT(date_of_brought_dead) FROM mortality_raw;

-- Cleaned table from raw table
CREATE TABLE mortality_clean AS
SELECT *,
    CASE WHEN TRIM(age) ~ '^[0-9]+$'
    THEN TRIM(age)::INTEGER END AS age_num,

    (CASE WHEN TRIM(date_of_brought_dead) ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' AND SPLIT_PART(TRIM(date_of_brought_dead), '/', 1)::int > 12
    THEN TO_DATE(TRIM(date_of_brought_dead), 'DD/MM/YYYY')
    WHEN TRIM(date_of_brought_dead) ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' AND SPLIT_PART(TRIM(date_of_brought_dead), '/', 2)::int > 12
    THEN TO_DATE(TRIM(date_of_brought_dead), 'MM/DD/YYYY')
    ELSE NULL
    END) AS death_date_clean

FROM mortality_raw;


/* Pollution */
-- Confirming for NULL values
SELECT COUNT(*) - COUNT(aqi), COUNT(*) - COUNT(pm25_avg), COUNT(*) - COUNT(pm10_avg), COUNT(*) - COUNT(no2_avg),
    COUNT(*) - COUNT(max_temp), COUNT(*) - COUNT(min_temp), COUNT(*) - COUNT(humidity) 
FROM pollution_raw;

-- Cleaned table from raw table
CREATE TABLE pollution_clean AS
SELECT *, 
    (CASE WHEN TRIM(date) ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' AND SPLIT_PART(TRIM(date), '/', 1)::int > 12
    THEN TO_DATE(TRIM(date), 'DD/MM/YYYY')
    WHEN TRIM(date) ~ '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' AND SPLIT_PART(TRIM(date), '/', 2)::int > 12
    THEN TO_DATE(TRIM(date), 'MM/DD/YYYY')
    ELSE NULL
    END) AS pollution_date_clean,
    
    CASE WHEN TRIM(aqi) ~ '^[0-9]+(\.[0-9]+)?$'
    THEN TRIM(aqi)::NUMERIC END AS aqi_num,

    CASE WHEN TRIM(pm25_avg) ~ '^[0-9]+(\.[0-9]+)?$'
    THEN TRIM(pm25_avg)::NUMERIC END AS pm25_num,

    CASE WHEN TRIM(pm10_avg) ~ '^[0-9]+(\.[0-9]+)?$'
    THEN TRIM(pm10_avg)::NUMERIC END AS pm10_num,

    CASE WHEN TRIM(no2_avg) ~ '^[0-9]+(\.[0-9]+)?$'
    THEN TRIM(no2_avg)::NUMERIC END AS no2_num,

    CASE WHEN TRIM(max_temp) ~ '^-?[0-9]+(\.[0-9]+)?$'
    THEN TRIM(max_temp)::NUMERIC END AS max_temp_num,

    CASE WHEN TRIM(min_temp) ~ '^-?[0-9]+(\.[0-9]+)?$'
    THEN TRIM(min_temp)::NUMERIC END AS min_temp_num,

    CASE WHEN TRIM(humidity) ~ '^[0-9]+(\.[0-9]+)?$'
    THEN TRIM(humidity)::NUMERIC END AS humidity_num

FROM pollution_raw;