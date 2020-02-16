select year_released, count(*) as cnt from movies
where country='us'
and year_released between 2000 and 2015
group by year_released order by cnt desc limit 1;