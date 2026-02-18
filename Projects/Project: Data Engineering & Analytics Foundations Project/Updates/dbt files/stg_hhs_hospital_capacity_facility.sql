{{ config(materialized='view') }}

with source as (

    select
        *
    from {{ source('weeklyhcdb', 'hhs_hospital_capacity_facility_raw') }}


),

cleaned as (

    select
        -- Dates
        (payload ->> 'date')::date as report_date,

        -- Strings
        payload ->> 'state' as state,
        payload ->> 'geocoded_state' as geocoded_state,

        -- Numeric fields (clean commas + empty strings)
        nullif(replace(payload ->> 'inpatient_beds', ',', ''), '')::int as inpatient_beds,
        nullif(replace(payload ->> 'inpatient_beds_used', ',', ''), '')::int as inpatient_beds_used,
        nullif(replace(payload ->> 'inpatient_beds_used_covid', ',', ''), '')::int as inpatient_beds_used_covid,

        nullif(replace(payload ->> 'all_pediatric_inpatient_beds', ',', ''), '')::int as all_pediatric_inpatient_beds,
        nullif(replace(payload ->> 'all_pediatric_inpatient_bed_occupied', ',', ''), '')::int as all_pediatric_inpatient_bed_occupied,

        nullif(replace(payload ->> 'total_staffed_adult_icu_beds', ',', ''), '')::int as total_staffed_adult_icu_beds,
        nullif(replace(payload ->> 'staffed_adult_icu_bed_occupancy', ',', ''), '')::int as staffed_adult_icu_bed_occupancy,

        nullif(replace(payload ->> 'total_staffed_pediatric_icu_beds', ',', ''), '')::int as total_staffed_pediatric_icu_beds,
        nullif(replace(payload ->> 'staffed_pediatric_icu_bed_occupancy', ',', ''), '')::int as staffed_pediatric_icu_bed_occupancy,

        -- Percentages (floats)
        nullif(replace(payload ->> 'adult_icu_bed_utilization', ',', ''), '')::float as adult_icu_bed_utilization,
        nullif(replace(payload ->> 'inpatient_beds_utilization', ',', ''), '')::float as inpatient_beds_utilization,
        nullif(replace(payload ->> 'percent_of_inpatients_with_covid', ',', ''), '')::float as percent_of_inpatients_with_covid,
        nullif(replace(payload ->> 'adult_icu_bed_covid_utilization', ',', ''), '')::float as adult_icu_bed_covid_utilization,
        nullif(replace(payload ->> 'inpatient_bed_covid_utilization', ',', ''), '')::float as inpatient_bed_covid_utilization,

        -- Deaths
        nullif(replace(payload ->> 'deaths_covid', ',', ''), '')::int as deaths_covid,
        nullif(replace(payload ->> 'hospital_onset_covid', ',', ''), '')::int as hospital_onset_covid,
        nullif(replace(payload ->> 'previous_day_deaths_influenza', ',', ''), '')::int as previous_day_deaths_influenza,
        nullif(replace(payload ->> 'previous_day_deaths_covid_and_influenza', ',', ''), '')::int as previous_day_deaths_covid_and_influenza,

        -- Staffing shortages
        nullif(replace(payload ->> 'critical_staffing_shortage_today_yes', ',', ''), '')::int as critical_staffing_shortage_today_yes,
        nullif(replace(payload ->> 'critical_staffing_shortage_today_no', ',', ''), '')::int as critical_staffing_shortage_today_no,
        nullif(replace(payload ->> 'critical_staffing_shortage_today_not_reported', ',', ''), '')::int as critical_staffing_shortage_today_not_reported,

        nullif(replace(payload ->> 'critical_staffing_shortage_anticipated_within_week_yes', ',', ''), '')::int as critical_staffing_shortage_anticipated_within_week_yes,
        nullif(replace(payload ->> 'critical_staffing_shortage_anticipated_within_week_no', ',', ''), '')::int as critical_staffing_shortage_anticipated_within_week_no,
        nullif(replace(payload ->> 'critical_staffing_shortage_anticipated_within_week_not_reported', ',', ''), '')::int as critical_staffing_shortage_anticipated_within_week_not_reported

    from source
)

select *
from cleaned
