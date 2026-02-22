# Social-to-Sales: Predictive E-Commerce Data Pipeline

### Project Overview
This project is a professional-grade **ELT (Extract, Load, Transform)** pipeline designed to identify the correlation between social media trends (TikTok, Meta, Snapchat) and Amazon sales throughput. By engineering a robust data infrastructure, this platform will identify actionable sales spikes, calculate the time-lag between "virality" and "conversion," and provide data-driven business intelligence.

**Goal:** To build a scalable data engineering portfolio demonstrating the orchestration of complex multi-source API ingestion, transformation, and multi-tool visualization.

---

## The Tech Stack

| Layer | Tool | Purpose |
| :--- | :--- | :--- |
| **Orchestration** | **Apache Airflow** | Workflow management and DAG scheduling. |
| **Ingestion (SaaS)** | **Airbyte** | Standardized connector management for APIs. |
| **Ingestion (Custom)** | **dlt (data load tool)** | Python-based schema-on-read for intricate/nested API data. |
| **Storage & IDE** | **PostgreSQL + DBeaver** | Primary RDBMS managed via DBeaver for SQL development/querying. |
| **Transformation** | **dbt (data build tool)** | SQL-based modeling (Staging -> Core -> Analytics) and documentation. |
| **Modeling** | **R / RStudio** | Statistical modeling (CCF, Granger Causality) and predictive testing. |
| **BI & Visualization** | **Power BI / Tableau** | Executive dashboards for trend monitoring and sales forecasting. |
| **Ad-hoc Auditing** | **Microsoft Excel** | Rapid data validation and financial "sanity checks" of API outputs. |

---

## Data Architecture (Medallion Framework)
The data pipeline follows a structured evolution from raw ingestion to high-level analytical modeling, managed and queried through **DBeaver**:

1. **RAW Layer (Bronze):** Untouched API responses. This layer focuses on high-volume, schema-flexible storage designed for data recovery and auditing.
2. **STAGING Layer (Silver):** Initial cleanup via **dbt**. Processes include standardizing column names, casting data types (e.g., ISO dates), and de-duplication. **Excel** is utilized at this stage for manual data quality audits.
3. **CORE Layer (Silver+):** The "Source of Truth." Social metrics and Amazon sales records are normalized and related through surrogate keys to ensure data integrity.
4. **ANALYTICS Layer (Gold):** Flattened, performant tables (Star Schema). This layer feeds **RStudio** for deep statistics and **Power BI/Tableau** for real-time trend visualization.

---

## Engineering Highlights
* **SQL Development:** Use of **DBeaver** for database administration, ER diagram generation, and complex query optimization.
* **Idempotent Pipelines:** Airflow DAGs are designed to ensure rerunning tasks prevents data duplication in the RAW layer.
* **Schema Evolution:** Leveraging **dlt** to handle changing API payloads without requiring manual SQL schema updates.
* **BI Integration:** Development of relational models in **Power BI and Tableau** to visualize the "Lag-Time" between social virality and Amazon conversion.
* **Data Quality:** Implementation of `dbt` test suites to catch null values and broken relationships before data reaches the ANALYTICS layer.

---

## Key Research Questions
The analytical layer aims to answer:
1. **The Lag Factor:** How many days or hours pass between a social trend peak and an Amazon sales spike?
2. **Channel Attribution:** Which platform (TikTok vs. Meta) shows the highest correlation coefficient with Amazon throughput?
3. **Visual Predictive Analysis:** Can a dashboard be built to flag "Buy" or "Sell" signals based on real-time social sentiment?

---

## Repository Structure
```bash
├── airflow/               # DAG definitions and schedules
├── dbt/                   # SQL models (staging, core, analytics), schema.yml, and tests
├── dlt_scripts/           # Custom Python scripts for niche APIs
├── r_analytics/           # Statistical models and CCF plots
├── dashboards/            # Power BI (.pbix) and Tableau workbook references
├── architecture_docs/     # ER diagrams (exported from DBeaver) and system maps
└── README.md
```

_Findings & Data: Due to the proprietary nature of the findings and API credentials, the raw data, sensitive API keys, and specific business directives are excluded from this public repository. This repo serves as a technical showcase of architecture and pipeline logic.

Ethics & Legality: This project is built with a strict adherence to data privacy and terms of service. All data ingestion methods utilized in this project are strictly public, legal, and compliant with the respective platform's API documentation and Terms of Service. No unauthorized data extraction or "black-hat" scraping methods are employed._
