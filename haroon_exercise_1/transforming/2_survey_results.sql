--	Create survey_results table with hospital id, their base HCAHPS score and HCAHPS consistency score
DROP TABLE survey_results;
CREATE TABLE survey_results AS 
SELECT provider_id AS hospital_id, hcahps_base, hcahps_consistency
FROM survey_responses_schema;

-- 	Add column to find total HCAHPS score
ALTER TABLE survey_results ADD COLUMNS (hcahps_score int);

INSERT OVERWRITE TABLE survey_results
SELECT hospital_id,
CASE hcahps_base
WHEN "Not Available" THEN NULL
ELSE hcahps_base
END,
CASE hcahps_consistency
WHEN "Not Available" THEN NULL
ELSE hcahps_consistency
END,
hcahps_base + hcahps_consistency
FROM survey_results;

-- 	Change score columns to integer values
ALTER TABLE survey_results CHANGE hcahps_score hcahps_score int;
ALTER TABLE survey_results CHANGE hcahps_consistency hcahps_consistency int;
