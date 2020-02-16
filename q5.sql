select continent,count(*) from
(select distinct country_code,c.continent
from countries c left join movies m on c.country_code = m.country
except
select distinct country,c2.continent
from movies m2 left join countries c2 on m2.country = c2.country_code)
group by continent
;