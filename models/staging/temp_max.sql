{{
    config(
        materialized = 'view'
    )
}}

SELECT
    station,
    date,
    value / 10.0 AS temperature_celsius,  -- Convert from tenths of degrees to degrees Celsius
    m_flag,
    q_flag,
    s_flag
FROM {{ ref('daily_ext') }}
WHERE element = 'TMAX'
ORDER BY station, date