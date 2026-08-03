select count(distinct job_id) from employees;

select sum(salary) from employees;

select min(salary) from employees;

select max(salary) from employees where job_id='IT_PROG';

select avg(salary),count(*) from employees
where department_id=90;

select max(salary),min(salary),sum(salary),avg(salary) from employees;

select job_id,count(*) from employees 
group by job_id;

select (max(salary)-min(salary)) as Difference from employees;

select manager_id,salary from employees where salary=min(salary);

select department_id,sum(salary) from employees 
group by department_id;

select avg(salary) from employees where job_id <> 'IT_PROG';

select max(salary),min(salary),sum(salary),avg(salary) from employees where department_id=90
group by job_id;

select job_id,max(salary) from employees group by job_id
having max(salary) >= 4000; 

select avg(salary) from employees 
group by department_id 
having count(*) >10;