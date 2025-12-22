with stations as (
    select
        station_id,
        station_name
    from {{ ref('stations_ext') }}
), tmax as (
    select
        station,
        date_trunc('month', date) as month,
        round(avg(temperature_celsius),2) as avg_tmax_celsius
    from {{ ref('temp_max') }} d
    group by station, month
), tmin as (
    select
        station,
        date_trunc('month', date) as month,
        round(avg(temperature_celsius),2) as avg_tmin_celsius
    from {{ ref('temp_min') }} d
    group by station, month
)
select
    s.station_name,
    tmax.month,
    tmax.avg_tmax_celsius,
    tmin.avg_tmin_celsius,
    round((tmax.avg_tmax_celsius + tmin.avg_tmin_celsius) / 2, 2) as avg_temp_celsius
from tmax
join tmin on tmax.station = tmin.station and tmax.month = tmin.month
left join stations s on tmax.station = s.station_id
order by tmax.station, tmax.month