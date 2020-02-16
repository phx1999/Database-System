select first_name,surname from
credits c inner join people p on c.peopleid = p.peopleid
inner join movies m on c.movieid = m.movieid
where p.born between 1910 and 1932 and c.credited_as='A'
group by c.peopleid having count(*)=(
SELECT MAX(mycount)
FROM (
select c.peopleid,count(*) as mycount from
credits c inner join people p on c.peopleid = p.peopleid
inner join movies m on c.movieid = m.movieid
where p.born between 1910 and 1932 and c.credited_as='A'
  group by c.peopleid
  )
  );
