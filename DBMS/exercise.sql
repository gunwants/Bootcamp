select ProductName, QuantityPerUnit from products;

select ProductID , ProductName 
from products where discontinued="False" order by ProductName ;

select ProductID , ProductName 
from products where discontinued=1 order by ProductName ;

select max(price) as Max , min(price) as min from products;

select * from products where price < 20;

select * from products where price  between 15 and 25;

select * from products where price > (select avg(price) from products);

SELECT * FROM (SELECT *,RANK() OVER (ORDER BY UnitPrice DESC) AS rnk FROM products) AS sub WHERE rnk < 10;

select count(ProduuctName) from products group by Discontinued;

select * from products where (((Discountinued)=False) and ((UnitsInStock)<UnitsOnOrder));

