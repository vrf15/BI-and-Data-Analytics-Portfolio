-- models/analytics/weeklyhcdb/analytics_weekly_summary.sql
-- Weekly aggregated hospital capacity and COVID metrics by state

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

weekly AS (

    SELECT
        DATE_TRUNC('week', report_date) AS week_start_date,
        state,

        -- Weekly inpatient metrics
        SUM(inpatient_beds) AS inpatient_beds_total,
        SUM(inpatient_beds_used) AS inpatient_beds_used_total,
        SUM(inpatient_beds_used_covid) AS inpatient_beds_used_covid_total,
        AVG(inpatient_beds_utilization) AS inpatient_beds_utilization_avg,
        AVG(percent_of_inpatients_with_covid) AS percent_inpatients_covid_avg,
        AVG(inpatient_bed_covid_utilization) AS inpatient_bed_covid_utilization_avg,
        AVG(pct_inpatient_beds_used) AS pct_inpatient_beds_used_avg,

        -- Weekly pediatric inpatient metrics
        SUM(all_pediatric_inpatient_beds) AS pediatric_inpatient_beds_total,
        SUM(all_pediatric_inpatient_bed_occupied) AS pediatric_inpatient_beds_occupied_total,

        -- Weekly ICU metrics
        SUM(total_staffed_adult_icu_beds) AS staffed_adult_icu_beds_total,
        SUM(staffed_adult_icu_bed_occupancy) AS staffed_adult_icu_bed_occupancy_total,
        SUM(total_staffed_pediatric_icu_beds) AS staffed_pediatric_icu_beds_total,
        SUM(staffed_pediatric_icu_bed_occupancy) AS staffed_pediatric_icu_bed_occupancy_total,
        AVG(adult_icu_bed_utilization) AS adult_icu_bed_utilization_avg,
        AVG(adult_icu_bed_covid_utilization) AS adult_icu_bed_covid_utilization_avg,
        AVG(pct_adult_icu_occupied) AS pct_adult_icu_occupied_avg,

        -- Weekly COVID metrics
        SUM(hospital_onset_covid) AS hospital_onset_covid_total,

        -- Weekly deaths
        SUM(deaths_covid) AS deaths_covid_total,
        SUM(previous_day_deaths_influenza) AS deaths_influenza_total,
        SUM(previous_day_deaths_covid_and_influenza) AS deaths_covid_and_influenza_total

    FROM daily
    GROUP BY
        DATE_TRUNC('week', report_date),
        state

)

SELECT *
FROM weekly