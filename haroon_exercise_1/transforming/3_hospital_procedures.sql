--	Create hospital_procedures_null table, which pulls columns from procedures and effective_care_schema
DROP TABLE hospital_procedures_null;
CREATE TABLE hospital_procedures_null AS 
SELECT e.provider_id AS hospital_id, e.measure_id AS procedure_id, e.score, p.mean_score, p.std, p.procedure_uom
FROM procedures p JOIN effective_care_schema e ON (p.procedure_id = e.measure_id);

ALTER TABLE hospital_procedures_null CHANGE score score INT; 

-- Add standardized column, which will normalize the score by using the following formula: (score - mean score) / standard deviation
ALTER TABLE hospital_procedures_null ADD COLUMNS (standardized DOUBLE);

INSERT OVERWRITE TABLE hospital_procedures_null
SELECT hospital_id, procedure_id, score, mean_score, std, procedure_uom, (score - mean_score) / std
FROM hospital_procedures_null;

-- Create hospital_procedures table, which pulls relevant columns from hospital_procedures_null table, excluding NULL values
DROP TABLE hospital_procedures;
CREATE TABLE hospital_procedures
AS SELECT hospital_id, procedure_id, score, standardized
FROM hospital_procedures_null 
WHERE score is not NULL;

--	Add procedure_rank, which gives the dense-rank of the standardized score for each hospital for each given procedure.
--	For percent values, the ranks will ascend as the standardized score descends. For time values, the ranks will ascend as the standardized score ascends.
ALTER TABLE hospital_procedures ADD COLUMNS (procedure_rank INT);

INSERT OVERWRITE TABLE hospital_procedures
SELECT hospital_id, hp.procedure_id, score, standardized,
CASE procedure_uom
WHEN "percent" THEN dense_rank() over (PARTITION BY hp.procedure_id ORDER BY standardized DESC)
WHEN "time" THEN dense_rank() over (PARTITION BY hp.procedure_id ORDER BY standardized ASC)
ELSE NULL
END procedure_rank
FROM hospital_procedures hp JOIN procedures p ON (hp.procedure_id = p.procedure_id);