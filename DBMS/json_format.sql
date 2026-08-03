insert into products (ProductID,ProductName,Details,Price)
values (134,'Smartphone','{"brand": "TechCorp", "model": "X100", "specs": {"ram": "4GB", "storage": "64GB"}}',1500);

select ProductId,json_extract( Details , '$.model') from products;

update products set details = json_set(Details,'$.brand','Sonata')
where json_extract(Details,'$.brand')='TechCorp'; 

select ProductId,json_valid( Details) from products;

select ProductId,json_extract( Details , '$.specs.ram') from products;

select json_merge_preserve( '{"brand": "TechCorp", "model": "X100"}',
'{"color": "black", "warranty": "2 years"}') as mergedJson;

alter table products add column brand varchar(50) GENERATED ALWAYS AS (JSON_UNQUOTE(JSON_EXTRACT(Details, '$.brand'))) STORED;

select ProductID , json_object(
'ProductName',ProductName,
'Price',Price,
'InStock',InStock) as ProductJson from products;

update products set details = json_set(Details,'$.brand','Sonata','$.warranty','5 years')
where json_extract(Details,'$.brand')='TechCorp';

select json_keys(details) from products;

select * from products where json_contains(details,'{"color": "red"}');

update products set details=json_remove(details,'$.warranty');

update products set details=json_replace(details,'$.warranty','5 years');

select json_length(details) from products;

CREATE TABLE UserProfiles (UserID INT PRIMARY KEY,UserName VARCHAR(100),Settings JSON);

UPDATE Products SET Reviews = JSON_ARRAY_APPEND(Reviews, '$', 'Excellent product!') WHERE ProductName = 'Smartphone';

SELECT JSON_ARRAYAGG(JSON_OBJECT('ProductID', ProductID,'ProductName', ProductName,'Price', Price)) AS ProductsJSON FROM Products;

SELECT ProductName,JSON_UNQUOTE(JSON_EXTRACT(Details, '$.brand')) AS Brand FROM Products;

select * from products where json_valid(details)=1;