# Social-to-Sales: Predictive E-Commerce Data Pipeline

### Project Overview
This project is a professional-grade **ELT (Extract, Load, Transform)** pipeline designed to identify the correlation between social media trends (TikTok, Meta, Snapchat) and Amazon sales throughput. By engineering a robust data infrastructure, this platform identifies actionable sales spikes, calculates the time-lag between "virality" and "conversion," and provides data-driven business intelligence.

**Goal:** To build a scalable data engineering portfolio demonstrating the orchestration of complex multi-source API ingestion, transformation, and statistical analysis.

---

## The Tech Stack

| Layer | Tool | Purpose |
| :--- | :--- | :--- |
| **Orchestration** | **Apache Airflow** | Workflow management and DAG scheduling. |
| **Ingestion (SaaS)** | **Airbyte** | Standardized connector management for APIs. |
| **Ingestion (Custom)** | **dlt (data load tool)** | Python-based schema-on-read for intricate/nested API data. |
| **Storage** | **PostgreSQL** | Relational Database Management System (RDBMS). |
| **Transformation** | **dbt (data build tool)** | SQL-based modeling, data testing, and documentation. |
| **Analytics** | **R / RStudio** | Statistical modeling (CCF, Granger Causality) and predictive testing. |

---

## Data Architecture (Medallion Framework)
The data pipeline follows a structured evolution from raw ingestion to high-level analytical modeling:



1. **RAW Layer (Bronze):** Untouched API responses. High-volume, schema-flexible storage designed for data recovery and auditing.
2. **STAGING Layer (Silver):** Initial cleanup. Standardizing column names, casting data types (e.g., ISO dates), and de-duplication.
3. **CORE Layer (Silver+):** The "Source of Truth." Here, social metrics and Amazon sales records are normalized and related through surrogate keys.
4. **ANALYTICS Layer (Gold):** Flattened, performant tables (Star Schema) keyed by `timestamp` and `product_id`. This layer is the primary source for the RStudio modeling environment.

---

## Engineering Highlights
* **Idempotent Pipelines:** Designed Airflow DAGs to ensure rerunning tasks prevents data duplication in the RAW layer.
* **Schema Evolution:** Leveraged **dlt** to handle changing API payloads without manual SQL schema updates.
* **Data Quality:** Implemented `dbt` test suites to catch null values or broken relationships before data reaches the ANALYTICS layer.
* **Time-Series Correlation:** Focused on calculating the **Lag-Time** ($L$) between Social Volume ($V$) and Sales ($S$) to determine predictive windows.

---

## Key Research Questions
The analytical layer aims to answer:
1. **The Lag Factor:** How many days/hours pass between a social trend peak and an Amazon sales spike?
2. **Channel Attribution:** Which platform (TikTok vs. Meta) has the highest correlation coefficient with Amazon throughput?
3. **Scalability:** Is the cost of API acquisition and data processing offset by the predictive accuracy for business betting?

---

## Repository Structure
```bash
├── airflow/               # DAG definitions and schedules
├── dbt/                   # SQL models (staging, core, analytics), schema.yml, and tests
├── dlt_scripts/           # Custom Python scripts for niche APIs
├── r_analytics/           # Statistical models, CCF plots, and predictive scripts
├── architecture_docs/     # System diagrams and schema maps
└── README.md
