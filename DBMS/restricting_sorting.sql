select first_name,last_name ,salary from employees 
where salary not between 10000 and 15000;

 select first_name,last_name,department_id from employees where 
 department_id in (30,100) order by deparment__id ;
 
  select first_name,last_name,salary from employees where 
 department_id in (30,100) AND salary not between 10000 and 15000 ;
 
 select first_name ,last_name , hire_date from employees  
 where year(hire_date) = 1987;
 
 select first_name  from employees
 where first_name like "%b%"
 and first_name like "%c%";
 
 select last_name , job_id,salary from employees 
 where job_id in ('IT_PROG','SH_CLERK')
 and salary not in (4500,10000,15000);
 
 select last_name from employees where length(last_name)=6;
 
 select last_name from employees where last_name like"__e%";
 
 select job_id from employees group by job_id;
 
 select first_name,last_name,salary,(0.15*salary) as "PF" from employees;
 
 select * from employees where last_name in ('BLAKE','SCOTT', 'KING','FORD');