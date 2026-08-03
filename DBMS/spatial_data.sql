create table locations2( id int auto_increment primary key,
name varchar(50) ,
location point not null ,
spatial index(location) -- here we are using spatial index to boost quering for loacation parammeter
);

insert into locations2 (id , name , location)
values (234,'Alpha',ST_GeomFromText('POINT(-73.54884 40.67854)'));

insert into locations2 (id,name,location) values(235,'beta',ST_GeomFromText('POINT(-70.2 46.5)'));

select ST_Distance(p1.location,p2.location) from 
(select * from locations2 where id=234) p1 ,(select * from locations2 p2 where id=235) p2;

SELECT *, ST_Distance(location, ST_GeomFromText('POINT(-73.33 20)')) AS distance FROM locations2;

select name from locations2 where st_distance(location,st_geomfromtext('POINT(25 25)')) <20;

SELECT *,ST_Within(ST_GeomFromText('POINT(-73.97 40.78)'),ST_GeomFromText('POLYGON((-73.99 40.77, -73.95 40.77, -73.95 40.79, -73.99 40.79, -73.99 40.77))')) AS isWithin;

alter table locations2 add spatial index(location);

update locations2 set location = st_geomfromtext('point(72.4444 40.756)')
where name = 'centeral park';

SET SQL_SAFE_UPDATES = 0;
delete from locations2 WHERE ST_Distance(location, ST_GeomFromText('POINT(-73.985130 40.758896)')) > 5000; 

select name,ST_AsText(location) as  locationWKT from locations2;

SELECT name,ST_Distance(location, ST_GeomFromText('POINT(-73.98 40.78)')) AS distance
FROM locations2 ORDER BY distance ASC LIMIT 1;

CREATE TABLE GeoData (id INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(100),location POINT NOT NULL SRID 0,area POLYGON not null SRID 0,SPATIAL INDEX(location),SPATIAL INDEX(area));
 
INSERT INTO GeoData (name, location, area) VALUES ('Central Park Area',ST_GeomFromText('POINT(-73.968 40.784)', 0),ST_GeomFromText('POLYGON((-73.981 40.768, -73.958 40.768, -73.958 40.800, -73.981 40.800, -73.981 40.768))', 0));
 
SELECT name FROM GeoData WHERE ST_Intersects(area, ST_GeomFromText('POLYGON((-73.970 40.770, -73.960 40.770, -73.960 40.780, -73.970 40.780, -73.970 40.770))', 0));
 
 select name,ST_Area(area) as areasize from GeoData;
 
 select name,ST_Perimeter(area) as perimeter from GeoData;
 
select name,ST_Buffer(location,0.01) as bufferzone from Locations2;

select name,ST_SRID(location,4326) as transformedLocation from locations2;

insert into locations2(name,location) values('Times Square',ST_GeomFromText('POINT(-73.98 40.7)',4326));

SELECT name FROM locations2 WHERE MBRContains(ST_GeomFromText('POLYGON((40 -74, 41 -74, 41 -73, 40 -73, 40 -74))', 4326),location);

select name , ST_SRID(location) as SRID from locations2;

