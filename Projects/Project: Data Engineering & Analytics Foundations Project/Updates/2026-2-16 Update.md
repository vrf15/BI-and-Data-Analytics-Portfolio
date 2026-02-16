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
