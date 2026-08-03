use bootcamp;
create table countries(country_id varchar(20),country_name varchar(20),region_id varchar(5) not null ); 

create table if not exists countries(country_id varchar(15),country_name varchar(15) , region_id varchar(3));

create table dub_countries like countries; #this create the structure for the duplicate table same as countires

create table if not exists dub_countries as select * from countries; # this also copies the data or original table to the duplicate table

create table countries(country_id varchar(20),country_name varchar(20),region_id varchar(5) not null ); # to set a constraint of one parameter to not null

create table jobs( job_id varchar(10),job_title varchar(15),min_salary decimal(4,0),max_salary decimal(4,0), check (max_salary<2500)); # here we are using check to ensure that the max salary remains within the upper limit

create table job_histry( employee_id varchar(10),start_date date,end_date date ,check(end_date like '--/--/----'), job_id varchar(5),depanrtment_id varchar(10));

create table countries(country_id varchar(10),country_name varchar(10),region_id varchar(5),unique(country_id)); # the unique condition determines that the ciuntry_id remains distinct

create table jobs(job_id varchar(10),job_title varchar(15) default("blank"),min_salary decimal(5,2) default(8000),max_salary decimal(5,2) default(null));

create table countries(country_id varchar(20) unique Primary key not null,country_name varchar(20),region_id varchar(5) not null); 

create table countries(country_id varchar(20) unique auto_increment,country_name varchar(20),region_id varchar(5) not null); #auto increment increases the values by one step as default if we do not specify any value in it

create table countries(country_id varchar(20),country_name varchar(20),region_id varchar(5),primary key(country_id,region_id)); # we can create a composite primary key, this will result in a unique combination of the participant columns of composite keys

create table job_history(employee_id varchar(16) unique,start_date date,end_date date,job_id varchar(10) ,department_id varchar(10), foreign key(job_id) references jobs(job_id)); # Here we are declaring the forign key with referances

create table employees_rec(employee_id varchar(15) unique,first_name varchar(15),last_name varchar(15),email varchar(30),phone_number char(10),hire_date date,job_id char(5),salary int,commission decimal(2,2),manager_id varchar(5),department_id varchar(5),foreign key(department_id,manager_id)references departments(department_id,manager_id));
drop table employees_rec;
create table employees_rec(employee_id varchar(15) unique,first_name varchar(15),last_name varchar(15),email varchar(30),phone_number char(10),hire_date date,job_id char(5),salary int,commission decimal(2,2),manager_id varchar(5),department_id varchar(5),foreign key(department_id)references departments(department_id),foreign key(job_id)references jobs(job_id));
drop table employees_rec;
create table employees_rec(employee_id varchar(15) unique,first_name varchar(15),last_name varchar(15),email varchar(30),phone_number char(10),hire_date date,job_id char(5),salary int,commission decimal(2,2),manager_id varchar(5),department_id varchar(5),foreign key(job_id)references jobs(job_id)
 on delete cascade on update restrict)engine=InnoDB;
# here we are declaring innodb as the engine for transactional support
create table employees_rec(employee_id varchar(15) unique,first_name varchar(15),last_name varchar(15),email varchar(30),phone_number char(10),hire_date date,job_id char(5),salary int,commission decimal(2,2),manager_id varchar(5),department_id varchar(5),foreign key(job_id)references jobs(job_id)
 on delete set null on update set null)engine=InnoDB;
# here we are declaring innodb as the engine for transactional support
create table employees_rec(employee_id varchar(15) unique,first_name varchar(15),last_name varchar(15),email varchar(30),phone_number char(10),hire_date date,job_id char(5),salary int,commission decimal(2,2),manager_id varchar(5),department_id varchar(5),foreign key(job_id)references jobs(job_id)
 on delete no action on update no action)engine=InnoDB;
# here we are declaring innodb as the engine for transactional support