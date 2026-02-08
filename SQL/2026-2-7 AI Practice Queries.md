# AI Practice Queries — February 7, 2026

## Focus: Window Functions (CTEs → Sequencing → Analytic Logic)

Today’s practice session shifts into **window function mastery**, building on your existing foundation of filtering and CTE pipelines. The emphasis is on understanding how analytic functions like `ROW_NUMBER()`, `RANK()`, and `LAG()` operate across partitions, enabling patient‑level sequencing, timeline construction, and Revenue Integrity analytics.

Window functions allow you to analyze patterns **within groups** (such as per‑

---

### Problem — 2026-02-07 — Window Functions #1
**Description:**  
Use a CTE to filter charges, then apply `ROW_NUMBER()` to create a chronological sequence of charges per patient.

**Tables:**  
- Charges  

**CTE Requirements:**  
- charge_date BETWEEN '2024-01-01' AND '2024-12-31'  
- status = 'Posted'  
- charge_amount > 0  
- cpt_code IN ('71045', '80053', '99213')  
- charge_date IS NOT NULL  

**Window Function Requirements:**  
- ROW_NUMBER() OVER (PARTITION BY patient_id ORDER BY charge_date ASC) AS row_num  

---

## Final SQL Solution: My Response
```sql
WITH posted2024 AS (
    SELECT *
    FROM Charges
    WHERE 
        charge_date BETWEEN '2024-01-01' AND '2024-12-31'
        AND status = 'POSTED'
        AND charge_amount > 0
        AND cpt_code IN ('71045','80053','99213')
    ROW_NUMBER() over patient_id
    ORDER BY charge_date ASC
)

SELECT
    patient_id,
    charge_id,
    cpt_code,
    charge_date,
    row_num
FROM posted2024;
```

---

## Final SQL Solution: Correct Answer
```sql
WITH posted2024 AS (
    SELECT *
    FROM Charges
    WHERE 
        charge_date BETWEEN '2024-01-01' AND '2024-12-31'
        AND status = 'Posted'
        AND charge_amount > 0
        AND cpt_code IN ('71045','80053','99213')
        AND charge_date IS NOT NULL
)

SELECT
    patient_id,
    charge_id,
    cpt_code,
    charge_date,
    ROW_NUMBER() OVER (
        PARTITION BY patient_id
        ORDER BY charge_date ASC
    ) AS row_num
FROM posted2024;
```

---

## Feedback
- Window functions must be in the SELECT list, not inside the CTE filter.  
- Must use full syntax: `ROW_NUMBER() OVER (PARTITION BY … ORDER BY …)`  
- Added missing `charge_date IS NOT NULL` filter.  
- Corrected status to `'Posted'` for consistency.  

---

