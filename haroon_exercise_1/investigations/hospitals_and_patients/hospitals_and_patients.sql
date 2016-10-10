-- We find the correlation of HCAHPS score and our calculated Hospital score.
SELECT CORR(sr.hcahps_score, h.hospital_score)
FROM survey_results sr, hospitals h
WHERE hospital_score IS NOT NULL AND sr.hospital_id = h.hospital_id;