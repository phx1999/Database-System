create trigger tri
    before insert on cars
    for each row when (new.color is null and new.city is null)
    execute procedure che();