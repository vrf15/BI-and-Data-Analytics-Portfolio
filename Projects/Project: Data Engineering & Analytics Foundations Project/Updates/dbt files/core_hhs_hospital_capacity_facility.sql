{{ config(materialized='table') }}

with base as (

    select
        report_date,
        state,
        geocoded_state,

        inpatient_beds,
        inpatient_beds_used,
        inpatient_beds_used_covid,

        all_pediatric_inpatient_beds,
        all_pediatric_inpatient_bed_occupied,

        total_staffed_adult_icu_beds,
        staffed_adult_icu_bed_occupancy,

        total_staffed_pediatric_icu_beds,
        staffed_pediatric_icu_bed_occupancy,

        adult_icu_bed_utilization,
        inpatient_beds_utilization,
        percent_of_inpatients_with_covid,
        adult_icu_bed_covid_utilization,
        inpatient_bed_covid_utilization,

        deaths_covid,
        hospital_onset_covid,
        previous_day_deaths_influenza,
        previous_day_deaths_covid_and_influenza,

        critical_staffing_shortage_today_yes,
        critical_staffing_shortage_today_no,
        critical_staffing_shortage_today_not_reported,
        critical_staffing_shortage_anticipated_within_week_yes,
        critical_staffing_shortage_anticipated_within_week_no,
        critical_staffing_shortage_anticipated_within_week_not_reported

    from {{ ref('stg_hhs_hospital_capacity_facility') }}

),

derived as (

    select
        *,
        
        case 
            when inpatient_beds > 0 
            then inpatient_beds_used::float / inpatient_beds 
        end as pct_inpatient_beds_used,

        case 
            when total_staffed_adult_icu_beds > 0 
            then staffed_adult_icu_bed_occupancy::float / total_staffed_adult_icu_beds 
        end as pct_adult_icu_occupied

    from base
)

select *
from derived
