# 2026‑02‑11 — Project Update 1  
Data Engineering & Analytics Foundations Project

## Changelog

### 1. Notes Structure Created
A dedicated `project_notes.sql` file was created in DBeaver with simple, scalable headers:
- Core Metrics
- Category Analysis
- Region Analysis
- Customer Analysis
- Time Series Trends
- Other Observations

This establishes a clean documentation workflow consistent with enterprise standards.

---

### 2. Core Metrics Extracted
Using `staging.superstore`, the following metrics were computed and recorded in raw form:

- Total Sales ($): 2,297,201.00  
- Total Profit ($): 286,397.02  
- Total Quantity (units): 37,873  
- Total Orders (count of order rows): 9,994  
- Total Customers (unique customers): 793  
- Avg Discount: 0.15620272163297978787  
- Avg Profit Margin: 0.12031015495827499863  

These values form the baseline for all future analysis.

---

### 3. Workflow Roles Clarified
- **AI Assistant:** proposes next steps, provides SQL, maintains structure.  
- **Human Analyst:** executes queries, validates results, interprets findings.

This process mirrors a real analytics engineering collaboration.

---

### 4. Dimensional Analysis Phase Identified
The next analytical phase will focus on category, region, and segment breakdowns to understand business performance across dimensions.
