-- Effective Care Table
DROP TABLE effective_care_schema;
CREATE EXTERNAL TABLE effective_care_schema (
provider_id int,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county string,
phone string,
condition string,
measure_id string,
measure_name string,
score int,
sample int,
footnote string,
measure_start string,
measure_end string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care';

-- Hospitals Table
DROP TABLE hospitals_schema;
CREATE EXTERNAL TABLE hospitals_schema (
provider_id int,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county string,
phone string,
hospital_type string,
hospital_ownership string,
emergency_services string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospitals';

-- Measures Table
DROP TABLE measures_schema;
CREATE EXTERNAL TABLE measures_schema (
measure_name string,
measure_id string,
measure_start_quarter string,
measure_start string,
measure_end_quarter string,
measure_end string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/measures';

-- Readmissions Table
DROP TABLE readmissions_schema;
CREATE EXTERNAL TABLE readmissions_schema (
provider_id int,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county string,
phone string,
measure_name string,
measure_id string,
compared_to_nat string,
denominator int,
score float,
low_estimate float,
high_estimate float,
footnote string,
measure_start string,
measure_end string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions';

-- Survey Responses Table
DROP TABLE survey_responses_schema;
CREATE EXTERNAL TABLE survey_responses_schema (
provider_id int,
hospital_name string,
address string,
city string,
state string,
zip_code string,
county string,
comm_with_nurses_achievement string,
comm_with_nurses_improvement string,
comm_with_nurses_dimension string,
comm_with_doctors_achievement string,
comm_with_doctors_improvement string,
comm_with_doctors_dimension string,
response_achievement string,
response_improvement string,
response_dimension string,
pain_achievement string,
pain_improvement string,
pain_dimension string,
comm_about_medicine_achievement string,
comm_about_medicine_improvement string,
comm_about_medicine_dimension string,
cleanliness_quietness_achievement string,
cleanliness_quietness_improvement string,
cleanliness_quietness_dimension string,
discharge_info_achievement string,
discharge_info_improvement string,
discharge_info_dimension string,
overall_achievement string,
overall_improvement string,
overall_dimension string,
hcahps_base int,
hcahps_consistency int
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
"separatorChar" = ",",
"quoteChar" = '"',
"escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/survey_responses';