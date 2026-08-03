select *,dense_RANK() over(order by salary desc) as rnk from employees; 

#running total by months
select month(sale_date) as month, sum(sum(amount)) over (order by month(sale_date)) as runnning_sales
from sales group by month(sale_date);

select Department_id,employee_id,salary 
,rank() over(partition by department_id order by salary) deptsalaryrank from employees
order by department_id; 

with employee_ranking as(select Department_id,employee_id,salary 
,rank() over(partition by department_id order by salary) as deptsalaryrank from employees)
select * from employee_ranking where deptsalaryrank<4;

select Department_id,employee_id,salary - avg(salary) over(partition by department_id) salary_diff from employees
order by department_id; 

select CustomerId,SaleDate,
first_value(sale_date) over (partition by CustomerId order by sale_date rows between unbounded preceding and unbounded following) as first_sales_date,
last_value(sale_date) over (partition by CustomerId order by sale_date desc rows between unbounded preceding and unbounded following) as last_sales_date
from sales;

select productid,amount,amount/sum(amount) over() * 100 from Sales;

with rankedsalaries as(select Department_id,employee_id,salary 
,row_number() over(partition by department_id order by salary) as RowNum,
count(*) over(partition by department_id) as totalcount from employees)
select department_id,avg(salary) as Median_salary from rankedSalaries 
where RowNum in ((TotalCount + 1) / 2, (TotalCount + 2) / 2) group by department_id;

SELECT EmployeeID,Salary,Salary - AVG(Salary) OVER () AS SalaryDifference FROM Employees;

select month,sales,cume_dist() over(order by sales) as cummulative_distribution from sales;

select employee_id,salary,ntile(100) over (order by salary) as percentile_rank from employees;

SELECT Month, Sales,LAG(Sales, 1) OVER (ORDER BY Month) AS PreviousMonthSales,LEAD(Sales, 1) OVER (ORDER BY Month) AS NextMonthSales
FROM MonthlySales;

select employee_id,salary,salary-lead(salary,1) over (order by employee_id) as salary_diff from employees;

SELECT sale_date,amount,
    CASE 
        WHEN MONTH(sale_date) IN (1, 2, 3) THEN 'Q1'
        WHEN MONTH(sale_date) IN (4, 5, 6) THEN 'Q2'
        WHEN MONTH(sale_date) IN (7, 8, 9) THEN 'Q3'
        WHEN MONTH(sale_date) IN (10, 11, 12) THEN 'Q4'
    END AS SalesQuarter,SUM(amount) OVER (ORDER BY sale_date) AS CumulativeSales FROM sales;

WITH RankedSales AS (
    SELECT Region, Sales,ROW_NUMBER() OVER (PARTITION BY Region ORDER BY Sales DESC) AS SalesRank fROM RegionalSales
)
SELECT Region, Sales fROM RankedSales WHERE SalesRank <= 5;

SELECT DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,SUM(amount) AS monthly_sales,AVG(SUM(amount)) OVER (ORDER BY DATE_FORMAT(sale_date, '%Y-%m') 
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS RollingAvg FROM sales
GROUP BY DATE_FORMAT(sale_date, '%Y-%m');

WITH DepartmentMaxSalaries AS (SELECT Department_ID,Employee_ID,Salary,RANK() OVER (PARTITION BY Department_ID ORDER BY Salary DESC) AS SalaryRank FROM Employees)
SELECT Department_ID,Employee_ID,Salary FROM DepartmentMaxSalaries WHERE SalaryRank = 1;