{{
    config(
        materialized = 'table'
    )
}}
select
s.*,
ST_MAKEPOINT(longitude, latitude) as geo_point,
substring(station_id, 1, 2) as country_code
from {{ source('ghcn', 'stations') }} s