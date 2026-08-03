SET SQL_SAFE_UPDATES = 0; #1
start transaction;
update employees set salary=salary+100;
commit;
#2
start transaction;
update employees set salary=salary*1.1;
rollback;
#3
set transaction isolation level read committed;
start transaction;
select * from employees where salary > 2000;
commit;
#4
set transaction isolation level serializable;
start transaction;
select * from employees where salary > 2000;
commit;
#6
start transaction;
update employees set salary =salary*1.1 where department_id= 2;
rollback;
#7
start transaction;

update employees set salary = salary*1.1 where department_id =2;

savepoint before_bonus;

update employees 
set salary = salary+1000
where department_id=2;

rollback to before_bonus;

commit;
#8
start transaction;

update employees set salary = salary * 1.1 
where department_id = 2;

set transaction isolation level read uncommitted;
start transaction;
select * from employees where department_id =2 ;
commit;
rollback;
#9
start transaction;
select * from employees where departmennt_id = 2;
start transaction;
update employees set salary=salary*1.1 where department_id=2;
commit;
select * from employees where department_id=2;
commit;
#10
start transaction ;
select *from employees where department_id=2; 
start transaction;
insert into employees(employee_id,first_name,department_id,salary) values(23,'Andraj katrpy',2,5000);
commit;
select*from employees where department_id=2;
commit;
#11
start transaction;
select * from employees where department_id=2 for update;
update employees set salary=salary*1.1 where department_id=12;
commit;
#12
start transaction;
select * from employees where department_id lock in share mode;
commit;
#13
start transaction;
select salary from employees where employee_id =1 ;
update employees set salary =50000+1000 where employee_id=1;
commit;
start transaction;
select salary from employees where employee_id = 1;
commit;
start transaction;
select salary from employees where employee_id=1;
update employees set salary=50000+2000 where employee_id=1;
commit;
#14
start transaction;
update accounts set balance=balance-1000 where account_id=1;
rollback;

update accounts set balance =balance +1000 where account_id=2;
commit;
#15
start transaction;
insert into employees(employee_id,first_name,department_id) values(1,'Kamilla',2);
rollback;
#16
set transaction isolation level repeatable read;
start transaction;
select * from employees where department_id=2;
commit;
#17
start transaction;
update employees set salary=salary*1.1 where department_id=2;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
start transaction;
select * from employees where department_id=2;
commit;
rollback;
#18
start transaction;
update account set balance = balance-1000 where account_id =1 ;
update transaction set amount=1000 where transaction_id=1;
commit;
#19
set transaction isolation level serializable;
start transaction;
select * from employees where department_id=2;
commit;
#20
start transaction;
update employees set salary = salary*1.1 where department_id=2;
commit;
