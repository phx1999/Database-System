select year_no, city, concat(round(numgreen1 * 100.0 / numblue),'%') as percentage
from ( select year_no, city, coalesce(numgreen, 0)--处理null
    as numgreen1, numblue
         from (select a.year_no, a.city, b.numblue, c.numgreen
               from (select year_no, city, count(*) from cars group by year_no, city) a
                        left join (select year_no, city, count(color) as numblue
                                   from cars where color = 'BLUE'
                                   group by year_no, city) b
                                  on (b.year_no = a.year_no and b.city = a.city)
                        left join (select year_no, city, count(color) as numgreen
                                   from cars where color = 'GREEN'
                                   group by year_no, city) c
                                  on (b.year_no = c.year_no and b.city = c.city)
              ) d
     ) e
where city in (
    select city from (select city, count(*) as cnt
                from cars group by city ORDER BY cnt desc  limit 2) g1)order by year_no, city;