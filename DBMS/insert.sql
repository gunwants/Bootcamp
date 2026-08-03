insert into countries values("ABC123","Indian","783");

insert into countries(country_id,country_name) values("GSH234","Pakistan");

create table country_new as select * from countries;

insert into countries(region_id) values(null);

insert into countries values("abs567","africa","231"),
("aus567","south africa","631");

insert into countries select * from country_new;

create table if not exists job (job_id varchar(20) unique,job_name varchar(30),head_count int);

CREATE TABLE IF NOT EXISTS countries ( 
COUNTRY_ID integer NOT NULL,
COUNTRY_NAME varchar(40) NOT NULL,
REGION_ID integer NOT NULL,
PRIMARY KEY (COUNTRY_ID,REGION_ID)
);
CREATE TABLE IF NOT EXISTS countries ( 
COUNTRY_ID integer unique auto_increment,
COUNTRY_NAME varchar(40) NOT NULL,
REGION_ID integer NOT NULL,
PRIMARY KEY (COUNTRY_ID,REGION_ID)
);
CREATE TABLE IF NOT EXISTS countries ( 
COUNTRY_ID integer unique auto_increment,
COUNTRY_NAME varchar(40) default "N/a",
REGION_ID integer NOT NULL,
PRIMARY KEY (COUNTRY_ID,REGION_ID)
);

CREATE TABLE job_history ( 
EMPLOYEE_ID integer NOT NULL PRIMARY KEY, 
JOB_ID integer NOT NULL, 
DEPARTMENT_ID integer DEFAULT NULL, 
FOREIGN KEY (job_id) REFERENCES jobs(job_id)
);

CREATE TABLE IF NOT EXISTS employees ( 
EMPLOYEE_ID integer NOT NULL PRIMARY KEY, 
FIRST_NAME varchar(20) DEFAULT NULL, 
LAST_NAME varchar(25) NOT NULL, 
JOB_ID varchar(10) NOT NULL, 
SALARY decimal(8,2) DEFAULT NULL, 
MANAGER_ID integer DEFAULT NULL, 
DEPARTMENT_ID integer DEFAULT NULL, 
FOREIGN KEY(DEPARTMENT_ID,MANAGER_ID) 
REFERENCES  departments(DEPARTMENT_ID,MANAGER_ID)
);

CREATE TABLE IF NOT EXISTS employees ( 
EMPLOYEE_ID integer NOT NULL PRIMARY KEY, 
FIRST_NAME varchar(20) DEFAULT NULL, 
LAST_NAME varchar(25) NOT NULL, 
DEPARTMENT_ID integer DEFAULT NULL, 
FOREIGN KEY(DEPARTMENT_ID) 
REFERENCES  departments(DEPARTMENT_ID),
JOB_ID integer NOT NULL, 
FOREIGN KEY(JOB_ID) 
REFERENCES  jobs(JOB_ID),
SALARY decimal(8,2) DEFAULT NULL
);
