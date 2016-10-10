-- We group all hospital_score values for each state in the Hospitals entity. We then rank from lowest to highest, getting our top 10 states by score.
SELECT state, SUM(hospital_score) / COUNT(hospital_score) AS ranking
FROM hospitals
WHERE hospital_score IS NOT NULL
GROUP BY state
ORDER BY ranking ASC
LIMIT 10;