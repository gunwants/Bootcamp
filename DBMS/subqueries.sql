
select Concat(first_name," ",last_name) name,salary from employees 
where salary>(select salary from employees where last_name ='Bull');

select Concat(first_name," ",last_name) name from employees where department_id=
(select department_id from departments where department_name='IT');

select Concat(e.first_name," ",e.last_name) name from employees e 
join departments d on e.department_id = d.department_id join locations l on d.location_id=l.location_id
where e.manager_id in (select employee_id from employees where department_id in (select department_id from departments where location_id in
(select location_id from locations where country_id='US')));

select Concat(first_name," ",last_name) name from employees where employee_id in (select manager_id from employees);

select Concat(first_name," ",last_name) name from employees where salary > (select avg(salary) from employees);

select Concat(first_name," ",last_name) name , salary from employees where salary = (select min(salary) from jobs where jobs.job_id=employees.job_id);

select Concat(first_name," ",last_name) name , salary from employees where salary>
(select avg(salary) from employees) and department_id=(select department_id from departments where department_name='IT');

select Concat(first_name," ",last_name) name , salary from employees
where salary > (select salary from employees where last_name='bell');

select Concat(first_name," ",last_name) name , salary from employees where salary = (select min(salary) from jobs where jobs.job_id=employees.job_id);

select Concat(first_name," ",last_name) name , salary from employees e
where salary > (select avg(salary) from employees f  group by department_id); 

select Concat(first_name," ",last_name) name , salary from employees where 
salary>(SELECT salary FROM employees WHERE job_id = 'SH_CLERK')
order by salary;

select Concat(first_name," ",last_name) name from employees b 
where not exists (select 'X' from employees a where a.manager_id=b.employee_id);

select employee_id,first_name,last_name, (select d.department_name from departments d where 
e.department_id=d.department_id) dept_name from employees e ;

select e.employee_id , e.first_name , e.last_name,e.salary from employees e
where e.salary>(select avg(salary) from departments d where e.department_id=d.department_id);

 SELECT * FROM (
    SELECT *, ROW_NUMBER() OVER (order by employee_id) AS r_num 
    FROM employees
) temp WHERE r_num % 2 = 0;

SELECT * FROM (
    SELECT *, rank() OVER (order by salary desc) AS r_num 
    FROM employees
) temp where r_num=5;

SELECT * FROM (
    SELECT *, Rank() OVER (order by salary) AS r_num 
    FROM employees
) temp where r_num=4;

select * from (
select *,DENSE_RANK() OVER(order by employee_id) as r_num from employees ) temp
where  r_num > (select count(*) from employees ) -10;

select department_id,department_name from departments d where 
not exists (select 'X' department_id from employees e where d.department_id = e.department_id);

with ranked_list as(
select *, dense_rank() over(order by salary desc) as r_num from employees)
select * from ranked_list where r_num<=3;

with ranked_list as(
select *, dense_rank() over(order by salary) as r_num from employees)
select * from ranked_list where r_num<=3;

select e1.salary from employees e1
where N= (select count(distinct(e2.salary)) from employees e2 where e2.salary>= e1.salary);