{{
    config(
        materialized = 'table'
    )
}}
select
d.* exclude obs_time,
to_time(replace('0000', '2400', obs_time), 'HH24MI') as obs_time
from {{ source('ghcn', 'daily') }} d