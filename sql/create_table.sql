-- 1. Admission table
CREATE TABLE admissions_raw (
sno TEXT,
mrd_no TEXT,
doa TEXT,
dod TEXT,
age TEXT,
gender TEXT,
rural TEXT,
type_of_admission_emergency_opd TEXT,
month_year TEXT,
duration_of_stay TEXT,
duration_of_intensive_unit_stay TEXT,
outcome TEXT,
smoking TEXT,
alcohol TEXT,
dm TEXT,
htn TEXT,
cad TEXT,
prior_cmp TEXT,
ckd TEXT,
hb TEXT,
tlc TEXT,
platelets TEXT,
glucose TEXT,
urea TEXT,
creatinine TEXT,
bnp TEXT,
raised_cardiac_enzymes TEXT,
ef TEXT,
severe_anaemia TEXT,
anaemia TEXT,
stable_angina TEXT,
acs TEXT,
stemi TEXT,
atypical_chest_pain TEXT,
heart_failure TEXT,
hfref TEXT,
hfnef TEXT,
valvular TEXT,
chb TEXT,
sss TEXT,
aki TEXT,
cva_infract TEXT,
cva_bleed TEXT,
af TEXT,
vt TEXT,
psvt TEXT,
congenital TEXT,
uti TEXT,
neuro_cardiogenic_syncope TEXT,
orthostatic TEXT,
infective_endocarditis TEXT,
dvt TEXT,
cardiogenic_shock TEXT,
shock TEXT,
pulmonary_embolism TEXT,
chest_infection TEXT
);

SELECT * FROM admissions_raw;
SELECT COUNT(*) FROM admissions_raw;


-- 2. Mortality table
CREATE TABLE mortality_raw(
sno TEXT,
mrd TEXT,
age TEXT,
gender TEXT,
rural_urban TEXT,
date_of_brought_dead TEXT
);

SELECT * FROM mortality_raw;
SELECT COUNT(*) FROM mortality_raw;


-- 3. Pollution table
CREATE TABLE pollution_raw(
date TEXT,
aqi TEXT,
pm25_avg TEXT,
pm25_min TEXT,
pm25_max TEXT,
pm10_avg TEXT,
pm10_min TEXT,
pm10_max TEXT,
no2_avg TEXT,
no2_min TEXT,
no2_max TEXT,
nh3_avg TEXT,
nh3_min TEXT,
nh3_max TEXT,
so2_avg TEXT,
so2_min TEXT,
so2_max TEXT,
co_avg TEXT,
co_min TEXT,
co_max TEXT,
ozone_avg TEXT,
ozone_min TEXT,
ozone_max TEXT,
prominent_pollutent TEXT,
max_temp TEXT,
min_temp TEXT,
humidity TEXT
);

SELECT * FROM pollution_raw;
SELECT COUNT(*) FROM pollution_raw;


-- 4. admissions_pollution_analysis; After cleaning (converting column datatype) of tables
CREATE TABLE admissions_pollution_analysis AS
SELECT
    a.*,
    p.aqi_num,
    p.pm25_num,
    p.pm10_num,
    p.no2_num,
    p.max_temp_num,
    p.min_temp_num,
    p.humidity_num
FROM admissions_clean AS a LEFT JOIN pollution_clean AS p
ON a.admission_date = p.pollution_date_clean;

SELECT COUNT(*) FROM admissions_pollution_analysis;


-- Summary
SELECT 'Admissions' AS dataset, COUNT(*) AS rows_count
FROM admissions_raw
UNION ALL
SELECT 'Mortality' AS dataset, COUNT(*) AS rows_count
FROM mortality_raw
UNION ALL
SELECT 'Pollution' AS dataset, COUNT(*) AS rows_count
FROM pollution_raw;