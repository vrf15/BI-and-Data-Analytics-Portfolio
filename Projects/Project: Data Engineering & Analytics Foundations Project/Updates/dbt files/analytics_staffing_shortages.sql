-- models/analytics/weeklyhcdb/analytics_staffing_shortages.sql
-- State-level staffing shortage indicators aligned with actual CORE schema

{{ config(
    materialized = 'table'
) }}

WITH daily AS (

    SELECT
        report_date,
        state,

        -- Staffing shortages (current)
        critical_staffing_shortage_today_yes,
        critical_staffing_shortage_today_no,
        critical_staffing_shortage_today_not_reported,

        -- Staffing shortages (anticipated within a week)
        critical_staffing_shortage_anticipated_within_week_yes,
        critical_staffing_shortage_anticipated_within_week_no,
        critical_staffing_shortage_anticipated_within_week_not_reported

    FROM {{ ref('analytics_daily_state_summary') }}

),

derived AS (

    SELECT
        report_date,
        state,

        -- Raw counts
        critical_staffing_shortage_today_yes,
        critical_staffing_shortage_today_no,
        critical_staffing_shortage_today_not_reported,
        critical_staffing_shortage_anticipated_within_week_yes,
        critical_staffing_shortage_anticipated_within_week_no,
        critical_staffing_shortage_anticipated_within_week_not_reported,

        -- Derived indicators
        CASE
            WHEN critical_staffing_shortage_today_yes > 0 THEN 1
            ELSE 0
        END AS has_staffing_shortage_today,

        CASE
            WHEN critical_staffing_shortage_anticipated_within_week_yes > 0 THEN 1
            ELSE 0
        END AS has_staffing_shortage_anticipated

    FROM daily

)

SELECT *
FROM derived