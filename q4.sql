select p.first_name, p.surname from credits c inner join movies m on c.movieid = m.movieid
inner join people p on c.peopleid = p.peopleid
where m.year_released>2000 and p.gender='F' group by c.peopleid having count(*)>20;

