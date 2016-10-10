-- Rank all hospital_scores from lowest to highest, limiting to 10 entries. These are our top 10 hospitals that have at least 5 scores.
SELECT hp.hospital_id, h.hospital_name, h.hospital_score, SUM(score), AVG(score), COUNT(score) count
FROM hospitals h JOIN hospital_procedures hp ON (h.hospital_id = hp.hospital_id)
WHERE h.hospital_score IS NOT NULL AND score > 5
GROUP BY hp.hospital_id, h.hospital_name, h.hospital_score
HAVING count > 5
ORDER BY h.hospital_score ASC LIMIT 10;
