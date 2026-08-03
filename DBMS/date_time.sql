SELECT DATE_FORMAT(CURDATE() - INTERVAL 3 MONTH, '%Y-%m-01') AS result;

select date_format(curdate()-interval 3 month,'%y-%m-01')-interval 1 day;

select distinct hire_date from employees where dayname(hire_date)='Monday';

select dayname(date_format(curdate(),'%y-01-01'));

select dayname(date_format(curdate(),'%y-12-31'));

select extract( year from curdate())-extract(year from str_to_date('2004-01-23','%Y-%m-%d')) as 'age';

SELECT DATE_FORMAT(CURDATE(),'%M %e, %Y' AS 'Current_date');
-- Specifies the desired format for the date: '%M' for full month name, '%e' for day of the month without leading zeros, and '%Y' for four-digit year.) 

SELECT DATE_FORMAT(CURDATE(),'%W %M %Y') AS 'Current_date';

SELECT DATE_FORMAT(CURDATE(),'%Y') AS 'Current_year';

select from_days(730677);

select first_name,hire_date from employees where hire_date
between '1987-06-01' and '1987-07-30';

SELECT DATE_FORMAT(now(),'%W %d th %M %Y %H:%m:%S') AS 'Current_date';

SELECT DATE_FORMAT(now(),' %d /%M /%Y ') AS 'Current_date';

SELECT DATE_FORMAT(now(),'%l:%i %p %b %e, %Y') AS 'Current_date';

select first_name,last_name from employees where monthname(hire_date)='June';

select year(hire_date) year_joined,count(*) from employees
group by year_joined having count(*)>10;

select first_name from employees where year(hire_date)=1987;

select m.department_id,m.first_name,m.salary from employees e join employees m on e.manager_id=m.employee_id
where year(curdate())-year(m.hire_date) >5;

select employee_id,last_name,hire_date,LAST_DAY(hire_date) from employees;

select first_name,hire_date,(year(curdate())-year(hire_date)) experience from employees;

SELECT YEAR(hire_date) AS year_joined, COUNT(*) AS total_hires FROM employees
GROUP BY YEAR(hire_date);