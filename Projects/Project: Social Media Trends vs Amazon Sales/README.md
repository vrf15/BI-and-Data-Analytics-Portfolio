# Social-to-Sales: Predictive E-Commerce Data Pipeline

### Project Overview

Hello!

One of my friends was recently describing their manufacturing business, and we came up with the idea of implementing data analytics and engineering principles into their practices. We plan on creating dashboards that closely monitor trends in social media that specifically correlate with spikes in Amazon sales.

I'm personally very interested in this project because it requires robust data engineering principles to create and maintain. I also have to draw from data scientific principles by using statistical modeling to correlate the measures we obtain from the APIs monitoring social media trends with the APIs monitoring Amazon throughput. Finally, once we find useful measures to draw from and accurately predict the spikes, we'll see if it is feasible to create business directives from this.

I think the biggest hurdle so far is finding public APIs that monitor trends in social media platforms and identifying measures that can accurately, quickly, and repeatedly predict the spikes. Some of my personal worries are categorizing trends by types and identifying items that are affiliated with them. It will be easier once a lot of the incoming measures are tested to draw for moore insightful conclusions. I suspect that we will have to divide trends into categories (memes, entertainment, drama, etc.) and identify which items spike up in Amazon based off of the categories.

---

## The Tech Stack

| Layer | Tool | Purpose |
| :--- | :--- | :--- |
| **Orchestration** | **Apache Airflow** | Scheduling |
| **Ingestion (SaaS)** | **Airbyte** | Standardized API management |
| **Ingestion (Custom)** | **dlt (data load tool)** | API pulls by python scripts (reserved for tricky API pulls). |
| **Storage & IDE** | **PostgreSQL + DBeaver** | Primary server + SQL IDE. |
| **Transformation** | **dbt (data build tool)** | Data transformation and documentation. |
| **Modeling** | **R / RStudio** | Statistical modeling and predictive testing. |
| **BI & Visualization** | **Power BI / Tableau** | Dashboards creation for monitoring (mainly for my client) |
| **Ad-hoc Auditing** | **Microsoft Excel** | Manual checks performed by me |

---

## Data Architecture (Medallion Framework)

SCHEMAS
1. RAW       -> All of my data indigestion goes here
2. STAGING   -> Where the data is validated
3. CORE      -> Further clean up
4. ANALYTICS -> Will mostly be comprised of data formatted towards R-Studios at first, but will eventually have finalized data sets for dashboard creation.

---

## Engineering Highlights
* **Automated Pipelines**
* **dbt Transformations and Documentations**
* **BI Integration**
* **Holistic Approach**

---

## Key Research Questions
Questions I am most interested in answering:

1. How long does it take to see an Amazon spike after something trends on social media? Can we beat this lag time?
2. Which platform (TikTok vs Meta, for example) shows the highest correlation coefficient with Amazon throughput?
3. How can we create dashboards to drive my friends' business?
   
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



## Privacy & Compliance Disclosure
Findings & Data: Due to the proprietary nature of the findings and API credentials, the raw data, sensitive API keys, and specific business directives are excluded from this public repository. This repo serves as a technical showcase of architecture and pipeline logic.

Ethics & Legality: This project is built with a strict adherence to data privacy and terms of service. All data ingestion methods utilized in this project are strictly public, legal, and compliant with the respective platform's API documentation and Terms of Service. No unauthorized data extraction or "black-hat" scraping methods are employed.

## Security and Data Privacy
To protect proprietary business intelligence and sensitive credentials, this repository follows industry-standard security protocols:

* **Environment Variables:** All API keys and database credentials are managed via `.env` files and are never hard-coded into scripts.
* **Credential Masking:** A `.gitignore` configuration ensures that local configuration files (e.g., `profiles.yml`, `.env`) and raw data files (`.csv`, `.json`) are never committed to the version history.
* **Data Anonymization:** While the pipeline architecture is public, the underlying sales figures and specific product categories are anonymized or replaced with synthetic data to protect business directives.
* **Credential Rotation:** In the event of a security audit, all keys are rotated to ensure the integrity of the production environment.
