create user "Gunwant Singh"@'localhost' identified by "1234";

grant select,insert on employees to 'Gunwant Singh'@'localhost';

revoke insert on bootcamp.* from 'Gunwant Singh'@'localhost' ;

drop user 'Gunwant Singh'@'localhost';

create role 'db_reader';

grant 'db_reader' to 'Gunwant Singh'@'localhost';

revoke 'db_reader' from 'Gunwant Singh'@'localhost';

alter user 'Gunwant Singh'@'localhost' identified by 'password';

show grants for 'Gunwant Singh'@'localhost';

flush privileges;

grant all privileges on bootcamp.* to 'Gunwant Singh'@'localhost';

grant all privileges on bootcamp.* to 'Gunwant Singh'@'localhost' with grant option;

CREATE USER 'emma'@'192.168.1.100' IDENTIFIED BY 'Pass789';

CREATE USER 'emma'@'192.168.1.100' IDENTIFIED BY 'Pass789' require ssl;

RENAME USER 'emma'@'192.168.1.100' TO 'gunwant singh hada'@'%';

CREATE USER 'george'@'localhost' IDENTIFIED BY 'UserPass321';
GRANT SELECT ON SalesDB.Customers TO 'george'@'localhost';

REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'george'@'localhost';

SELECT User, Host FROM mysql.user; 

GRANT EXECUTE ON bootcamp.* TO 'george'@'localhost'; 