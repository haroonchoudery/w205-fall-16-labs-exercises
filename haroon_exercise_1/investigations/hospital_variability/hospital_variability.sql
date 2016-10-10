-- Find variance for the standardization score for each procedure. This gives us an accurate estimation of the procedures with the most variability.
-- The reason we take the variance of standardization and not scores is to negate the effect of magnitudes in our values.
SELECT p.procedure_name, variance(hp.standardized) as var
FROM hospital_procedures hp, procedures p
WHERE hp.procedure_id = p.procedure_id
GROUP BY p.procedure_name
ORDER BY var DESC
LIMIT 10;