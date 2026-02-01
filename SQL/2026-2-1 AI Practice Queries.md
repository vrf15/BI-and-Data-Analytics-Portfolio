# AI Practice Queries — February 1, 2026

## Focus: Common Table Expressions (CTEs)

Today’s practice session is focused on **writing clear, well-structured SQL queries using Common Table Expressions (CTEs)**.

### Practice Method
- Copilot provides SQL prompts
- I write the appropriate query using proper formatting and best practices
- Immediate feedback is reviewed and incorporated

### Goals
- Strengthen CTE usage
- Improve SQL readability and organization
- Reinforce business-oriented query thinking
-----------------------------------------------------------------------------------------------------------------------------
### Problem — 2026-02-01 — #1
**Description:**  
Count 2024 encounters by provider specialty using a 2‑CTE pipeline.

**Tables:**  
- Encounters  
- Providers  

**Columns:**  
**Encounters**  
- encounter_id  
- patient_id  
- provider_id  
- encounter_date  
- encounter_type  
- diagnosis_code  

**Providers**  
- provider_id  
- provider_name  
- specialty  

**Requirements:**  
- CTE #1: Filter Encounters to 2024, keep provider_id  
- CTE #2: Join to Providers, group by specialty, count encounters  
- Final: Return specialty + encounter_2024_count, order DESC  

**Final SQL Solution: My Response**  
```sql
-- your query goes here
```

**Final SQL Solution: Correct Answer**  
```sql
WITH encounters_2024 AS (
    SELECT
        encounter_id,
        provider_id
    FROM Encounters
    WHERE
        encounter_date BETWEEN '2024-01-01' AND '2024-12-31'
),

specialty_counts AS (
    SELECT
        p.specialty,
        COUNT(e.encounter_id) AS encounter_2024_count
    FROM encounters_2024 e
    INNER JOIN Providers p
        ON e.provider_id = p.provider_id
    GROUP BY p.specialty
)

SELECT
    specialty,
    encounter_2024_count
FROM specialty_counts
ORDER BY encounter_2024_count DESC;
```

**Final SQL Solution: My Response**  
```sql
WITH encounters_2024 AS (
	SELECT
		e.provider_id
	FROM Encounters e
	WHERE
		encounter_date BETWEEN '2024-01-01' AND '2024-12-31'
),
specialty_counts AS (
	SELECT
		p.specialty,
		COUNT(e.encounter_id) AS specialty_count
	FROM Encounters e
	INNER JOIN Providers p
		ON e.provider_id = p.provider_id
	GROUP BY p.specialty
)
SELECT
	specialty_count,
	encounter_2024_count
ORDER BY count DESC;
```
**Final SQL Solution: Correct Answer**  
```sql
WITH encounters_2024 AS (
    SELECT
        encounter_id,
        provider_id
    FROM Encounters
    WHERE
        encounter_date BETWEEN '2024-01-01' AND '2024-12-31'
),

specialty_counts AS (
    SELECT
        p.specialty,
        COUNT(e.encounter_id) AS encounter_2024_count
    FROM encounters_2024 e
    INNER JOIN Providers p
        ON e.provider_id = p.provider_id
    GROUP BY p.specialty
)

SELECT
    specialty,
    encounter_2024_count
FROM specialty_counts
ORDER BY encounter_2024_count DESC;
```
INCORRECT
----------------------------------------------------------------------------------------------------------------------------### Problem — 2026-02-01 — #2
**Description:**  
Count abnormal 2024 lab results by patient gender using a 2‑CTE pipeline.

**Tables:**  
- LabResults  
- Patients  

**Columns:**  
**LabResults**  
- result_id  
- patient_id  
- test_name  
- result_value  
- result_flag  
- result_date  

**Patients**  
- patient_id  
- first_name  
- last_name  
- gender  
- date_of_birth  

**Requirements:**  
- CTE #1: Filter LabResults to abnormal 2024 results, keep patient_id + result_id  
- CTE #2: Join to Patients, group by gender, count abnormal results  
- Final: Return gender + abnormal_2024_count, order DESC  

---

**Final SQL Solution: My Response**  
```sql
WITH abnormal_2024 AS (
    SELECT
        result_flag,
        patient_id,
        result_id
    FROM LabResults
    WHERE
        result_date BETWEEN '2024-01-01' AND '2024-12-31'
        result_flag = 'Abnormal'
),
gender_counts AS (
    SELECT
        p.gender,
        COUNT(abnormal_2024) AS abnormal_2024_count
    FROM LabResults lr
    INNER JOIN Patients p
        ON  lr.patient_id = p.patient_id
    GROUP BY gender
)
SELECT
    p.gender,
    abnormal_2024_count
ORDER BY count DESC;
```

**Final SQL Solution: Correct Answer**  
```sql
WITH abnormal_2024 AS (
    SELECT
        patient_id,
        result_id
    FROM LabResults
    WHERE
        result_flag = 'Abnormal'
        AND result_date BETWEEN '2024-01-01' AND '2024-12-31'
),

gender_counts AS (
    SELECT
        p.gender,
        COUNT(a.result_id) AS abnormal_2024_count
    FROM abnormal_2024 a
    INNER JOIN Patients p
        ON a.patient_id = p.patient_id
    GROUP BY p.gender
)

SELECT
    gender,
    abnormal_2024_count
FROM gender_counts
ORDER BY abnormal_2024_count DESC;
```
INCORRECT
----------------------------------------------------------------------------------------------------------------------------

