-- Create Hospitals entity, with hospital ID, hospital name, and hospital state
DROP TABLE hospitals;
CREATE TABLE hospitals AS 
SELECT provider_id AS hospital_id, hospital_name, state
FROM hospitals_schema;

-- Add column to hospitals to add up all rankings from the hospital_procedures table and divide by the number of rankings. This will be the total hospital score. Lower scores are better.
ALTER TABLE hospitals ADD COLUMNS (hospital_score DOUBLE);

INSERT OVERWRITE TABLE hospitals
SELECT h.hospital_id, h.hospital_name, h.state, SUM(hp.procedure_rank) / COUNT(hp.procedure_rank)
FROM hospitals h LEFT JOIN hospital_procedures hp ON (h.hospital_id = hp.hospital_id)
GROUP BY h.hospital_id, h.hospital_name, h.state;
