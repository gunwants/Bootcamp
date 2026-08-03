select first_name as "First Name",last_name as "Last Name" from employees;

select distinct department_id from employees;

select  * from employees order by first_name desc;

select first_name,last_name,salary,(salary*0.15) as "PF" from employees;

select employee_id,first_name,last_name,salary from employees order by salary;

select sum(salary) from employees;

select max(salary),min(salary) from employees;

select avg(salary),count(*) from employees;

select count(employee_id) from employees;

select count(distinct job_id) from employees;

select upper(first_name) from employees;

select substring(first_name,1,3) from employees;

select(171*214+625);

select concat(first_name," ",last_name) from employees;

select trim(first_name) from employees;

select length(first_name),length(last_name) from employees;

select * from employees 
where first_name regexp '[0-9]';

select * from employees limit 10;

select *,(salary/12) as "monthly salary"from employees;
