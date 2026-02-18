-- models/analytics/weeklyhcdb/analytics_state_rolling_7day.sql
-- 7-day rolling averages aligned with actual CORE schema

{{ config(
    materialized = 'table'
) }}

WITH daily AS (

    SELECT
        report_date,
        state,

        -- Inpatient metrics
        inpatient_beds,
        inpatient_beds_used,
        inpatient_beds_used_covid,
        inpatient_beds_utilization,
        percent_of_inpatients_with_covid,
        inpatient_bed_covid_utilization,
        pct_inpatient_beds_used,

        -- Pediatric inpatient
        all_pediatric_inpatient_beds,
        all_pediatric_inpatient_bed_occupied,

        -- ICU metrics
        total_staffed_adult_icu_beds,
        staffed_adult_icu_bed_occupancy,
        total_staffed_pediatric_icu_beds,
        staffed_pediatric_icu_bed_occupancy,
        adult_icu_bed_utilization,
        adult_icu_bed_covid_utilization,
        pct_adult_icu_occupied,

        -- COVID metrics
        hospital_onset_covid,

        -- Deaths
        deaths_covid,
        previous_day_deaths_influenza,
        previous_day_deaths_covid_and_influenza

    FROM {{ ref('analytics_daily_state_summary') }}

),

rolling AS (

    SELECT
        state,
        report_date,

        -- Rolling inpatient metrics
        AVG(inpatient_beds) OVER (
            PARTITION BY state
            ORDER BY report_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS inpatient_beds_7day_avg,

        AVG(inpatient_beds_used) OVER (
            PARTITION BY state
            ORDER BY report_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS inpatient_beds_used_7day_avg,

        AVG(inpatient_beds_utilization) OVER (
            PARTITION BY state
            ORDER BY report_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS inpatient_beds_utilization_7day_avg,

        -- Rolling ICU metrics
        AVG(total_staffed_adult_icu_beds) OVER (
            PARTITION BY state
            ORDER BY report_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS staffed_adult_icu_beds_7day_avg,

        AVG(staffed_adult_icu_bed_occupancy) OVER (
            PARTITION BY state
            ORDER BY report_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS staffed_adult_icu_bed_occupancy_7day_avg,

        AVG(adult_icu_bed_utilization) OVER (
            PARTITION BY state
            ORDER BY report_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS adult_icu_bed_utilization_7day_avg,

        -- Rolling COVID metrics
        AVG(inpatient_beds_used_covid) OVER (
            PARTITION BY state
            ORDER BY report_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS inpatient_covid_7day_avg,

        AVG(hospital_onset_covid) OVER (
            PARTITION BY state
            ORDER BY report_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS hospital_onset_covid_7day_avg,

        -- Rolling deaths
        AVG(deaths_covid) OVER (
            PARTITION BY state
            ORDER BY report_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS deaths_covid_7day_avg

    FROM daily

)

SELECT *
FROM rolling