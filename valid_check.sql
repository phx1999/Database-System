create or replace function che()
returns trigger
as $$
    declare
        car_n varchar(12);
        s varchar(4);
        b BOOLEAN;
        CHA VARCHAR(8);
        COLOR VARCHAR(6);
        i int;
    begin
        car_n=new.car_num;
        s=substr(car_n,0,3);
        b=TRUE;
        if (s='粤A')
            then new.city='GUANG ZHOU';
        elseif (s='粤B')
            then new.city='SHEN ZHEN';
        elseif (s='粤C')
            then new.city='ZHU HAI';
        elseif (s='粤D')
            then new.city='SHAN TOU';
        elseif (s='粤E')
            then new.city='FO SHAN';
        elseif (s='粤F')
            then new.city='SHAO GUAN';
        elseif (s='粤G')
            then new.city='ZHAN JIANG';
        ELSE
            b=FALSE;
        END IF ;
        CHA=SUBSTR(car_n,3);
        if (CHAR_LENGTH(CHA)=5)
            THEN COLOR='BLUE';
            i=1;
            while i<=5 loop
                s=substr(CHA,i,1);
                if ((ascii(s)<=47) or (ascii(s)>=58 and ascii(s)<=64)
                    or (ascii(s)>=91))
                then b=false;
                end if;
                i=i+1;
            end loop;
        elseif (CHAR_LENGTH(CHA)=6)
            then color='GREEN';
            if not(substr(cha,1,1)='F' or substr(CHA,1,1)='D')
                then b=false;
            end if;
            i=2;
            while i<=6 loop
                s=substr(CHA,i,1);
                if ((ascii(s)<=47) or (ascii(s)>=58 and ascii(s)<=64)
                    or (ascii(s)>=91))
                then b=false;
                end if;
                i=i+1;
            end loop;
        else b=false;
        end if ;
        if (b)
            then new.car_num=car_n;
            new.color=color;
        else new=null;
        end if ;
        return new;
    end;
    $$ language plpgsql;