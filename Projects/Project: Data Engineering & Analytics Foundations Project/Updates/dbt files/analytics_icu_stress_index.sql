-- models/analytics/weeklyhcdb/analytics_icu_stress_index.sql
-- Derived ICU stress index aligned with actual CORE schema

{{ config(
    materialized = 'table'
) }}

WITH daily AS (

    SELECT
        report_date,
        state,

        -- ICU capacity + occupancy
        total_staffed_adult_icu_beds,
        staffed_adult_icu_bed_occupancy,

        -- ICU utilization ratios
        adult_icu_bed_utilization,
        adult_icu_bed_covid_utilization

    FROM {{ ref('analytics_daily_state_summary') }}

),

icu_stress AS (

    SELECT
        report_date,
        state,

        total_staffed_adult_icu_beds,
        staffed_adult_icu_bed_occupancy,
        adult_icu_bed_utilization,
        adult_icu_bed_covid_utilization,

        -- Component 1: ICU Utilization Score (0–100)
        adult_icu_bed_utilization * 100
            AS icu_utilization_score,

        -- Component 2: COVID ICU Burden Score (0–100)
        CASE
            WHEN total_staffed_adult_icu_beds > 0 THEN
                (staffed_adult_icu_bed_occupancy::float
                 / total_staffed_adult_icu_beds::float) * 100
            ELSE 0
        END AS icu_covid_burden_score,

        -- Component 3: Capacity Tightness Score (0–100)
        CASE
            WHEN total_staffed_adult_icu_beds > 0 THEN
                (staffed_adult_icu_bed_occupancy::float
                 / total_staffed_adult_icu_beds::float) * 100
            ELSE 0
        END AS icu_capacity_tightness_score,

        -- Final ICU Stress Index (weighted blend)
        (
            (adult_icu_bed_utilization * 0.5) +
            (
                CASE
                    WHEN total_staffed_adult_icu_beds > 0 THEN
                        staffed_adult_icu_bed_occupancy::float
                        / total_staffed_adult_icu_beds::float
                    ELSE 0
                END * 0.3
            ) +
            (
                CASE
                    WHEN total_staffed_adult_icu_beds > 0 THEN
                        staffed_adult_icu_bed_occupancy::float
                        / total_staffed_adult_icu_beds::float
                    ELSE 0
                END * 0.2
            )
        ) * 100 AS icu_stress_index

    FROM daily

)

SELECT *
FROM icu_stress