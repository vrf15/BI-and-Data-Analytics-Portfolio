# 2026-02-16 — Project Update 2
Data Engineering & Analytics Foundations Project

## Changelog

### 1. Core & Analytics Schemas Reset
All manually created Superstore tables in the CORE and ANALYTICS schemas were deleted.
These tables were originally created outside of dbt and are now being retired to ensure:

- reproducibility
- version-controlled transformations
- clean lineage
- dbt-managed table creation

This aligns the project with analytics engineering best practices and prepares the environment for dbt-driven modeling.

---

### 2. Staging Model Finalized (`stg_superstore`)
The staging model for the Superstore dataset was completed and now includes:

- standardized data types
- consistent naming conventions
- a clean field selection
- a reliable, analytics-ready dataset

The model sources from `2026_2_10_superstore` and prepares the data for downstream dimensional modeling.
This staging layer will feed upcoming CORE models such as:

- `dim_customers`
- `dim_products`
- `fct_sales`

---

### 3. Transition to dbt-Managed Modeling
With manual tables removed and the staging layer established, the project is now positioned to:

- build all CORE models through dbt
- enforce documentation and testing
- maintain a clean RAW → STAGING → CORE → ANALYTICS pipeline
- support future semantic modeling and BI integration

This marks the shift from exploratory SQL toward a structured analytics engineering workflow.

### DBT stg.sql code below
```sql
WITH source AS (

    SELECT
        *
    FROM {{ source('superstore', '2026_2_10_superstore') }}

),

renamed AS (

    SELECT
        order_id::TEXT          AS order_id,
        order_date::DATE        AS order_date,
        ship_date::DATE         AS ship_date,
        ship_mode::TEXT         AS ship_mode,

        customer_id::TEXT       AS customer_id,
        customer_name::TEXT     AS customer_name,
        segment::TEXT           AS segment,

        country::TEXT           AS country,
        city::TEXT              AS city,
        state::TEXT             AS state,
        postal_code::TEXT       AS postal_code,
        region::TEXT            AS region,

        product_id::TEXT        AS product_id,
        category::TEXT          AS category,
        sub_category::TEXT      AS sub_category,
        product_name::TEXT      AS product_name,

        sales::NUMERIC          AS sales,
        quantity::INTEGER       AS quantity,
        discount::NUMERIC       AS discount,
        profit::NUMERIC         AS profit
    FROM source

)

SELECT
    *
FROM renamed;
```

# 2026-02-16 — Project Update RESET
Data Engineering & Analytics Foundations Project

## Changelog

---

### 1. Database Reset for Future Automation & Healthcare BI
The previous development database was fully deleted and rebuilt from scratch.  
This reset was intentional and serves several long-term goals:

- eliminate legacy tables created outside dbt  
- remove inconsistent schemas accumulated during experimentation  
- ensure a clean, reproducible environment  
- prepare for automated ingestion pipelines  
- streamline future healthcare BI dashboard development  

This fresh start aligns the project with analytics engineering best practices and sets the foundation for a fully automated RAW → STAGING → CORE → ANALYTICS workflow.

---

### 2. First Healthcare Staging Model Completed (`stg_hhs_hospital_capacity_facility`)
The staging model for the **HHS Hospital Capacity (Facility-Level)** dataset is now fully implemented.

Key features include:

- JSONB extraction from the raw payload  
- standardized data types across all fields  
- null-safe numeric casting using `nullif()`  
- comma-stripping for formatted numbers  
- consistent naming conventions  
- a clean, analytics-ready column set  

The model sources from:

- `raw_weeklyhcdb.hhs_hospital_capacity_facility_raw`

This staging layer will feed upcoming CORE models focused on:

- hospital capacity  
- ICU utilization  
- pediatric and adult bed metrics  
- staffing shortages  
- COVID-related admissions and deaths  

These models will ultimately support **weekly healthcare BI dashboards**.

---

### 3. Environment Stabilized & dbt Execution Path Finalized
The project now runs consistently using the Python 3.11 dbt installation:

