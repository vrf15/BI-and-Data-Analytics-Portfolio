-- models/analytics/weeklyhcdb/analytics_state_rankings.sql
-- State-level rankings for key hospital capacity and COVID metrics

{{ config(
    materialized = 'table'
) }}

WITH daily AS (

    SELECT
        report_date,
        state,

        -- Inpatient metrics
        inpatient_beds_utilization,
        inpatient_beds_used,
        inpatient_beds_used_covid,

        -- ICU metrics
        adult_icu_bed_utilization,
        staffed_adult_icu_bed_occupancy,
        total_staffed_adult_icu_beds,

        -- COVID metrics
        percent_of_inpatients_with_covid,
        inpatient_bed_covid_utilization,
        adult_icu_bed_covid_utilization,

        -- Deaths
        deaths_covid

    FROM {{ ref('analytics_daily_state_summary') }}

),

ranked AS (

    SELECT
        report_date,
        state,

        -- Inpatient utilization ranking
        inpatient_beds_utilization,
        RANK() OVER (
            PARTITION BY report_date
            ORDER BY inpatient_beds_utilization DESC
        ) AS inpatient_utilization_rank,

        -- ICU utilization ranking
        adult_icu_bed_utilization,
        RANK() OVER (
            PARTITION BY report_date
            ORDER BY adult_icu_bed_utilization DESC
        ) AS icu_utilization_rank,

        -- COVID inpatient burden ranking
        inpatient_beds_used_covid,
        RANK() OVER (
            PARTITION BY report_date
            ORDER BY inpatient_beds_used_covid DESC
        ) AS covid_inpatient_rank,

        -- ICU COVID burden ranking
        adult_icu_bed_covid_utilization,
        RANK() OVER (
            PARTITION BY report_date
            ORDER BY adult_icu_bed_covid_utilization DESC
        ) AS icu_covid_rank,

        -- Deaths ranking
        deaths_covid,
        RANK() OVER (
            PARTITION BY report_date
            ORDER BY deaths_covid DESC
        ) AS deaths_rank

    FROM daily

)

SELECT *
FROM ranked