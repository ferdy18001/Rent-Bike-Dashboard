--TOP LEVEL METRICS

--total jumlah perjalanan  yang terjadi
select count(tripduration) as total_perjalanan
from `bigquery-public-data.new_york_citibike.citibike_trips`
where tripduration is NOT NULL;

--rata rata durasi perjalanan
select avg(tripduration) as durasiperjalanan
from `bigquery-public-data.new_york_citibike.citibike_trips`
where tripduration is NOT NULL;

#rata rata jumlah perjalanan per hari
with perhari as (
select  date(starttime) as tanggal,
        count(starttime) as jumlah
from `bigquery-public-data.new_york_citibike.citibike_trips`
where starttime is NOT NULL
group by 1
order by 1
)
select avg (jumlah) as perjalananperhari
from perhari;

--rata rata jumlah sepeda yang digunakan perhari
with jumlah as (
select  count (distinct bikeid) as jumlah_sepeda, 
        date(starttime) as waktu
from `bigquery-public-data.new_york_citibike.citibike_trips`
where starttime is NOT NULL
group by 2
order by 2 ASC
) select cast(avg(jumlah_sepeda) as int) as jumlahsepeda
from jumlah;

--all summary (top metrics + detailed metrics)
SELECT  date(starttime) as tanggal,
        bikeid,
        tripduration,
        gender,
        count(*) as total_perjalanan,
        count (distinct bikeid) as jumlah_sepeda,  
        start_station_id,
        start_station_latitude,
        start_station_longitude,
	    birth_year,
	    name
FROM `bigquery-public-data.new_york_citibike.citibike_trips` as a
LEFT JOIN `bigquery-public-data.new_york_citibike.citibike_stations`as b
ON a.start_station_id = b.station_id
where start_station_id is NOT NULL
group by 1, 2, 3, 4, 7, 8, 9, 10, 11
order by 1 ASC