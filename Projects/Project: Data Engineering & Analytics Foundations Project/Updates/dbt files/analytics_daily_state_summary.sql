-- models/analytics/weeklyhcdb/analytics_daily_state_summary.sql
-- Daily state-level summary aligned with actual CORE schema

{{ config(
    materialized = 'table'
) }}

WITH core AS (

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

        -- ICU metrics (adult + pediatric)
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

    FROM {{ ref('core_hhs_hospital_capacity_facility') }}

)

SELECT *
FROM core