# learning in 10 , 12 substring_index(string,delimiter,count) , instr[it is used to get first occurence in the string
#substring(column , starting,no. of char)
#group_concat:used with group by to concat all related column in a particular group,
#LPAD,RPAD (column name,n,'padding character') used to pad the string

select job_id,group_concat(employee_id,' ') as 'emp_id' from employees 
group by job_id;

update employees set phone_number = replace(phone_number,'124','999') where phone_number like'%124%';

select * from employees  where length(first_name)>=8;

select job_id,LPAD(min_salary,7,'0') as 'Minimum Salary',LPAD(max_salary,7,'0') as 'Maximum Salary' from employees;

select  concat(email,'@example.com') as 'email' from employees;

select employee_id,first_name, mid(hire_date,6,2) as 'Hire month' from employees;

SELECT EMPLOYEE_ID, left(EMAIL, LENGTH(EMAIL) - 3) AS EMAIL_ID FROM employees;  

select first_name from employees where first_name=binary upper (first_name);

select right(phone_number,4) as 'last 4 digit'from employees;

select substring_index(street_address,' ',-1) as "last word" from locations;

select * from locations order by length(street_address);

select substring_index(job_title,' ',-1) as "first word" from jobs;

select first_name,last_name from employees where last_name like '__c%';

select first_name,length(first_name) from employees where first_name like 'A%' or first_name like 'J%'and first_name like 'M%'
order by first_name;
#alternative approach 
SELECT first_name AS "First Name", LENGTH(first_name) AS "Length" from employees where left(first_name,1) in ('A','M','J') order by first_name;

select first_name,LPAD(salary,10,'$') as 'Salary' from employees;

select left(first_name,8),repeat('$',floor(salary/1000)) as 'salary' from employees 
order by salary desc;

select employee_id,first_name,last_name,hire_date from employees where 
day(hire_date)=7 or month(hire_date)=7; 
