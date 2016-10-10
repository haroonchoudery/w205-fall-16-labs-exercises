-- 	Create procedures table from effective_care_schema table
--	Include average score variable for each procedure as well as the standard deviation for the scores of each procedure
DROP TABLE procedures;
CREATE TABLE procedures AS
SELECT measure_id AS procedure_id, measure_name AS procedure_name, AVG(score) as mean_score, stddev_samp(score) as std
FROM effective_care_schema
GROUP BY measure_id, measure_name;

--	Add procedure_uom (Procedure Unit of Measurement) column to classify the unit of measurement for each procedure
ALTER TABLE procedures ADD COLUMNS (procedure_uom string);

INSERT OVERWRITE TABLE procedures
SELECT procedure_id, procedure_name, mean_score, std,
CASE procedure_id
WHEN "AMI_10" THEN "percent"
WHEN "AMI_2" THEN "percent"
WHEN "AMI_7a" THEN "percent"
WHEN "AMI_8a" THEN "percent"
WHEN "CAC_1" THEN "percent"
WHEN "CAC_2" THEN "percent"
WHEN "CAC_3" THEN "percent"
WHEN "HF_1" THEN "percent"
WHEN "HF_2" THEN "percent"
WHEN "HF_3" THEN "percent"
WHEN "IMM_2" THEN "percent"
WHEN "IMM_3_FAC_ADHPCT" THEN "percent"
WHEN "OP_2" THEN "percent"
WHEN "OP_22" THEN "percent"
WHEN "OP_23" THEN "percent"
WHEN "OP_4" THEN "percent"
WHEN "OP_6" THEN "percent"
WHEN "OP_7" THEN "percent"
WHEN "PC_01" THEN "percent"
WHEN "PN_6" THEN "percent"
WHEN "SCIP_CARD_2" THEN "percent"
WHEN "SCIP_INF_1" THEN "percent"
WHEN "SCIP_INF_10" THEN "percent"
WHEN "SCIP_INF_2" THEN "percent"
WHEN "SCIP_INF_3" THEN "percent"
WHEN "SCIP_INF_4" THEN "percent"
WHEN "SCIP_INF_9" THEN "percent"
WHEN "SCIP_VTE_2" THEN "percent"
WHEN "STK_1" THEN "percent"
WHEN "STK_10" THEN "percent"
WHEN "STK_2" THEN "percent"
WHEN "STK_3" THEN "percent"
WHEN "STK_4" THEN "percent"
WHEN "STK_5" THEN "percent"
WHEN "STK_6" THEN "percent"
WHEN "STK_8" THEN "percent"
WHEN "VTE_1" THEN "percent"
WHEN "VTE_2" THEN "percent"
WHEN "VTE_3" THEN "percent"
WHEN "VTE_4" THEN "percent"
WHEN "VTE_5" THEN "percent"
WHEN "VTE_6" THEN "percent"
WHEN "ED_1b" THEN "time"
WHEN "ED_2b" THEN "time"
WHEN "OP_1" THEN "time"
WHEN "OP_3b" THEN "time"
WHEN "OP_5" THEN "time"
WHEN "OP_18b" THEN "time"
WHEN "OP_20" THEN "time"
WHEN "OP_21" THEN "time"
WHEN "EDV" THEN "volume"
ELSE NULL
END AS procedure_uom
FROM procedures;
