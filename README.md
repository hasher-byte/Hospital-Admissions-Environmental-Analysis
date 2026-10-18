# Healthcare and Climate Analytics

The project uses hospital admissions, mortality, and environmental datasets related to Hero DMC Heart Institute to analyze patient demographics, admission patterns, hospital outcomes, and air pollution trends.


## Project Overview

This project analyzes hospital admissions data to identify trends and patterns in patient demographics, admission outcomes, length of stay, readmissions, mortality records, and environmental conditions.

The analysis uses Excel Power Query, PostgreSQL, SQL, and Tableau Public and follows a complete data analytics workflow:

**Data Loading → Data Cleaning → Data Validation → SQL Analysis → Data Visualization → Business Insights**


## Dataset

The dataset was obtained from Kaggle:

**Hospital Admissions Data — Two Year Hospital Admissions and Discharge Data from Hero DMC Heart Institute**

🔗 [Kaggle Dataset](https://www.kaggle.com/datasets/ashishsahani/hospital-admissions-data/data)

**Dataset Files**

| File | Description |
|---|---|
| `HDHI Admission data.csv` | Patient demographics, admission details, clinical information, outcomes, and length of stay |
| `HDHI Mortality Data.csv` | Recorded mortality information |
| `HDHI Pollution Data.csv` | Air quality, particulate matter, temperature, and humidity measurements |
| `table_headings.csv` | Data dictionary containing column descriptions |


## Tools & Technologies

- Microsoft Excel
- Power Query
- PostgreSQL
- SQL
- Tableau 
- Git & GitHub


## Analysis

- Hospital KPI Analysis — total admissions, identified patients, average age, length of stay, and ICU utilization
- Admission Trends — monthly and yearly admission patterns, weekday trends, and admission type analysis
- Patient Demographics — age groups, gender distribution, and rural/urban categories
- Admission Outcomes — outcome distribution and comparisons across admission types
- Length of Stay & ICU Utilization — stay duration, ICU utilization, and operational patterns
- Patient Readmission — one-time vs repeat patients, admission frequency, and time between recorded admissions
- Mortality Analysis — recorded mortality trends, demographic patterns, patient matching, and data quality checks
- Pollution & Weather Analysis — AQI, PM2.5, PM10, NO2, temperature, and humidity trends
- Combined Analysis — comparisons between hospital admission volume and recorded environmental conditions


## Key Insights

- Used Power Query to investigate whether dataset records could be combined or not.
- Analyzed hospital admission trends to understand changes in recorded admission volume over time.
- Examined the distribution of admissions across age groups, genders, admission types, and recorded outcomes.
- Investigated patient admission frequency to identify patterns in repeat visits.
- Evaluated length of stay and ICU utilization across patient and admission categories.
- Examined mortality records and assessed the limitations of matching mortality records with hospital admissions.
- Identified changes in AQI and particulate pollution levels across the study period.
- Explored whether daily admission volumes vary alongside recorded pollution levels without assuming a causal relationship.


## Project Structure
```
Healthcare and Climate Analytics
│
├── data
│   ├── HDHI Admission data.csv
│   ├── HDHI Mortality Data.csv
│   ├── HDHI Pollution Data.csv
│   └── table_headings.csv
│
├── tableau_data
│   ├── monthly_admissions.csv
│   ├── patient_demographics.csv
│   ├── admission_outcomes.csv
│   └── monthly_pollution.csv
│ 
├── excel
│   └── Hospital_Admissions_Data_Preparation.xlsx
│
├── sql
│   ├── create_table.sql
│   ├── data_cleaning.sql
│   ├── kpi_analysis.sql
│   ├── admission_trends.sql
│   ├── admission_outcome.sql
│   ├── patient_demographics.sql
│   ├── patient_readmission.sql
│   ├── stay_icu_duartion.sql
│   ├── mortality_analysis.sql
│   ├── pollution_analysis.sql
│   ├── admission+pollution.sql
│   └── outputs_tableau.sql
│
├── tableau
│   ├── Hospital Admissions & Environmental Analysis.twb
│   └── Hospital Admissions & Environmental Analysis.png
│
├── documentation
│   └── Hospital Admissions Data Documentation.docx
│
└── README.md
```


## Tableau Dashboard

The Tableau Public dashboard combines key findings from the SQL analysis into a single visual interface.

**Dashboard components:**

- Monthly Hospital Admissions
- Admissions by Age Group and Gender
- Admission Outcomes
- Monthly Average AQI
- Monthly PM2.5 and PM10 Trends

**KPI cards:**

- Total Admissions
- Average Patient Age
- Average Length of Stay
- Average AQI

**Dashboard Preview:**

<img width="1880" height="804" alt="Hospital Admissions   Environmental Analysis" src="https://github.com/user-attachments/assets/9dc53ef5-08a2-4e1c-a575-7e599425184f" />


## ▶️ How to Run

### 1. Clone the repository
git clone https://github.com/hasher-byte/Hospital-Admissions-Environmental-Analysis.git

### 2. Navigate to the project directory
cd Hospital-Admissions-Environmental-Analysis

### 3. Open the Excel workbook
In Excel, open the Power Query workbook to review the data preparation and transformation process.

### 4. Set up PostgreSQL
Create the hospital_admissions_analytics database and import the required datasets into PostgreSQL.

Run the SQL scripts in the appropriate order to prepare the cleaned tables, perform analysis, and create the Tableau-ready views.

### 5. Open the Tableau workbook
Open the .twb file in Tableau Public or a compatible Tableau application.

Update the data-source paths if required. Ensure that the required CSV files or extracts are available.

Alternatively, view the published Tableau Public dashboard using the link below.

🔗 Tableau Public Dashboard: [https://public.tableau.com/views/HospitalAdmissionsEnvironmentalAnalysis_/HospitalAdmissionsEnvironmentalAnalysis?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link]


## 👨‍💻 Author

**Harshit Singh**\
Aspiring Data Analyst\
✉️ Email: harshitsingh0801@gmail.com\
🔗 [LinkedIn](https://www.linkedin.com/in/harshit-singh-a08b681bb/)
