### Project Overview

For this project, I will be working with a software engineer in creating multiple portfolios on yield-generating vaults. We will be using different strategies based on historical analysis on vault data. In doing so, we can actively test multiple portfolio profiles based off of our statistical findings.

I am mainly in charge of creating end-to-end pipelines starting from data ingestion, to data transformation (within dbt), to statistic crunching (within R Studio), and finally, into a live dashboard. I will be listing the programs I will be using below. Tools may change as the project evolves, particularly to incorporate near-live data feeds.

I will be maintaining the data pipelines upon creation, add new ones connections and remove old sources as we see fit.

---

## Programs

| Layer | Tool | 
| :--- | :--- | 
| **Orchestration** | **Apache Airflow** | 
| **Ingestion (SaaS)** | **Airbyte** | 
| **Ingestion (Custom)** | **dlt (data load tool)** | 
| **Storage & IDE** | **PostgreSQL + DBeaver** | 
| **Transformation** | **dbt (data build tool)** |
| **Modeling** | **R / RStudio** | 
| **BI & Visualization** | **Power BI / Tableau** | 
| **Manual Data-Validation** | **Microsoft Excel** |

---

## Data Architecture (Medallion Framework)

SCHEMAS
1. RAW       
2. STAGING   
3. CORE      
4. ANALYTICS 

---

## Engineering Highlights
* **Automated Pipelines**
* **dbt Transformations and Documentations**
* **BI Integration**
* **Holistic Approach**
   
---

## Repository Structure
```bash
├── airflow/              
├── dbt/                   
├── dlt_scripts/          
├── r_analytics/           
├── dashboards/            
├── architecture_docs/    
└── README.md
```



## Privacy & Compliance Disclosure
Findings & Data: 
Due to the proprietary nature of the findings and API credentials, the raw data, sensitive API keys, and specific business directives are excluded from this public repository. This repo serves as a technical showcase of architecture and pipeline logic.

Ethics & Legality: 
This project is built with a strict adherence to data privacy and terms of service. All data ingestion methods utilized in this project are strictly public, legal, and compliant with the respective platform's API documentation and Terms of Service. No unauthorized data extraction or "black-hat" scraping methods are employed.

## Security and Data Privacy
To protect proprietary business intelligence and sensitive credentials, this repository follows industry-standard security protocols:

* **Environment Variables:** All API keys and database credentials are managed via `.env` files and are never hard-coded into scripts.
* **Credential Masking:** A `.gitignore` configuration ensures that local configuration files (e.g., `profiles.yml`, `.env`) and raw data files (`.csv`, `.json`) are never committed to the version history.
* **Data Anonymization:** While the pipeline architecture is public, the underlying sales figures and specific product categories are anonymized or replaced with synthetic data to protect business directives.
* **Credential Rotation:** In the event of a security audit, all keys are rotated to ensure the integrity of the production environment.
