select location_id,street_address,city,state_province,country_name from locations l
join countries c on l.country_id=c.country_id;

SELECT first_name,last_name,department_id,department_name 
FROM employees JOIN departments USING (department_id);

select first_name , last_name,job_id,department_id,department_name from employees e
join departments d using (department_id) join locations l using (location_id)
where l.city='London';

select e.employee_id,concat(e.first_name," ",e.last_name) "name",e.manager_id,concat(m.first_name," ",m.last_name) "Manager_name" from employees e
join employees m on e.manager_id=m.employee_id;

select concat(e.first_name," ",e.last_name) , e.hire_date from employees e where 
e.hire_date>(select hire_date from employees where last_name='Jones');

select d.department_name,count(*) from employees e
join departments d using (department_id)
group by d.department_name;

select employee_id,job_name,(end_date-start_date) as "days" from job_history
where department_id=90;

select e.first_name,e.department_id,m.first_name,d.department_name from employees e 
join employees m on e.manager_id=m.employee_id join departments d on d.department_id=e.department_id;

select d.department_name,e.first_name,l.city from departments d join employees e on d.manager_id=e.employee_id join 
locations l using (location_id);

select j.job_title,avg(e.salary) from employees e join
jobs j on e.job_id=j.job_id
group by j.job_title;

select j.job_title,e.first_name,(e.salary-j.min_salary)  as "diffrence" from employees e join
jobs j on e.job_id=j.job_id;

select jh.* from job_history jh join 
employees e on jh.employee_id=e.employee_id
 where e.salary>10000;
 
 select d.DEPARTMENT_NAME,Concat(m.first_name," ",m.last_name) as "Name",m.hire_date,m.salary from employees e join employees m
 on e.manager_id=m.employee_id join departments d on e.department_id=d.department_id  where datediff(current_date(),m.hire_date)/365>15;




