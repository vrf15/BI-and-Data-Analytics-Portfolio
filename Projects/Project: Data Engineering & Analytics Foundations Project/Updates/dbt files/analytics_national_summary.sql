-- models/analytics/weeklyhcdb/analytics_national_summary.sql
-- National-level daily summary aggregated from state-level metrics

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
        previous_day_deaths_covid_and_influenza,

        -- Staffing shortages
        critical_staffing_shortage_today_yes,
        critical_staffing_shortage_today_no,
        critical_staffing_shortage_today_not_reported,
        critical_staffing_shortage_anticipated_within_week_yes,
        critical_staffing_shortage_anticipated_within_week_no,
        critical_staffing_shortage_anticipated_within_week_not_reported

    FROM {{ ref('analytics_daily_state_summary') }}

),

national AS (

    SELECT
        report_date,

        -- Inpatient totals
        SUM(inpatient_beds) AS inpatient_beds_total,
        SUM(inpatient_beds_used) AS inpatient_beds_used_total,
        SUM(inpatient_beds_used_covid) AS inpatient_beds_used_covid_total,
        AVG(inpatient_beds_utilization) AS inpatient_beds_utilization_avg,
        AVG(percent_of_inpatients_with_covid) AS percent_inpatients_covid_avg,
        AVG(inpatient_bed_covid_utilization) AS inpatient_bed_covid_utilization_avg,
        AVG(pct_inpatient_beds_used) AS pct_inpatient_beds_used_avg,

        -- Pediatric inpatient totals
        SUM(all_pediatric_inpatient_beds) AS pediatric_inpatient_beds_total,
        SUM(all_pediatric_inpatient_bed_occupied) AS pediatric_inpatient_beds_occupied_total,

        -- ICU totals
        SUM(total_staffed_adult_icu_beds) AS staffed_adult_icu_beds_total,
        SUM(staffed_adult_icu_bed_occupancy) AS staffed_adult_icu_bed_occupancy_total,
        SUM(total_staffed_pediatric_icu_beds) AS staffed_pediatric_icu_beds_total,
        SUM(staffed_pediatric_icu_bed_occupancy) AS staffed_pediatric_icu_bed_occupancy_total,
        AVG(adult_icu_bed_utilization) AS adult_icu_bed_utilization_avg,
        AVG(adult_icu_bed_covid_utilization) AS adult_icu_bed_covid_utilization_avg,
        AVG(pct_adult_icu_occupied) AS pct_adult_icu_occupied_avg,

        -- COVID metrics
        SUM(hospital_onset_covid) AS hospital_onset_covid_total,

        -- Deaths
        SUM(deaths_covid) AS deaths_covid_total,
        SUM(previous_day_deaths_influenza) AS deaths_influenza_total,
        SUM(previous_day_deaths_covid_and_influenza) AS deaths_covid_and_influenza_total,

        -- Staffing shortages
        SUM(critical_staffing_shortage_today_yes) AS staffing_shortage_today_yes_total,
        SUM(critical_staffing_shortage_today_no) AS staffing_shortage_today_no_total,
        SUM(critical_staffing_shortage_today_not_reported) AS staffing_shortage_today_not_reported_total,
        SUM(critical_staffing_shortage_anticipated_within_week_yes) AS staffing_shortage_week_yes_total,
        SUM(critical_staffing_shortage_anticipated_within_week_no) AS staffing_shortage_week_no_total,
        SUM(critical_staffing_shortage_anticipated_within_week_not_reported) AS staffing_shortage_week_not_reported_total

    FROM daily
    GROUP BY report_date

)

SELECT *
FROM national