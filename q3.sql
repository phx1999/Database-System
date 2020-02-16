select count(*) as cnt from(
select distinct peopleid from credits c join movies m on c.movieid = m.movieid
where m.title like '%Avengers%' intersect
select c.peopleid from credits c join people p on c.peopleid = p.peopleid
where p.gender='F');