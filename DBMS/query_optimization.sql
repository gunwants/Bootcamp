explain select * from employees where salary>(select avg(salary) from employees) and employee_id=108;

alter table employees add index idx_sal(salary);

select * from employees where salary>1000;

alter table employees drop index idx_sal;

alter table employees add index idx_com(job_id,manager_id);

explain select * from employees e join departments d on e.department_id=d.department_id; 

explain select * from employees limit 10;

SELECT * FROM employees FORCE INDEX (idx_com) WHERE employee_id = 23;

explain select * from employees where salary>(select avg(salary) from employees) and employee_id=108;

select employee_id,hire_date from employees where employee_id =23;

select * from employees where hire_date between curdate()-interval 3 month and  curdate();

explain select sum(salary) from employees group by department_id;

explain select * from employees order by salary limit 3;

SELECT * FROM employees e FORCE INDEX (idx_com) join departments d on e.department_id=d.department_id ;

select employee_id,count(employee_id) as emp_id from employees group by department_id;

explain select * from employees where salary>(
select avg(salary) from employees);

select * from employees order by hire_date;

explain select * from employees where year(hire_date)=2026;

alter table employees add join_year int as (year(hire_date)) stored ,
add index idx_year (join_year);

explain SELECT dt.department_id, dt.total_employees
FROM (
    SELECT department_id, COUNT(*) AS total_employees
    FROM employees
    GROUP BY department_id
) AS dt
WHERE dt.department_id > 90;