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

**Requirements:**  
- CTE #1: Filter Encounters to 2024, keep provider_id  
- CTE #2: Join to Providers, group by specialty, count encounters  
- Final: Return specialty + encounter_2024_count, order DESC  

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

