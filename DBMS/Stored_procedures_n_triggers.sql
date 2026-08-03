-- stored procedures and triggers
DELIMITER /

CREATE PROCEDURE p_Update(
    IN p_employee_id INT,
    IN p_first_name VARCHAR(30),
    IN p_last_name VARCHAR(30),
    IN p_phone_number VARCHAR(20),
    IN p_hire_date DATE,
    IN p_salary DECIMAL(10,2),
    IN p_manager_id INT,
    IN p_department_id INT
)
BEGIN
    UPDATE employees 
    SET 
        first_name    = p_first_name, 
        last_name     = p_last_name,
        phone_number  = p_phone_number, 
        hire_date     = p_hire_date,
        salary        = p_salary,
        manager_id    = p_manager_id,
        department_id = p_department_id
    WHERE employee_id = p_employee_id; -- Crucial for targeting a single row
END /

DELIMITER ;

# calling the procedure
call insertion('28','Gunwant','Singh','8302473478',1500,32,44);
 drop procedure if exists p_update;
#Q3 Update procedure
DELIMITER /

CREATE PROCEDURE p_Update(
    IN p_employee_id int,
    IN p_first_name VARCHAR(30),
    IN p_last_name VARCHAR(30),
    IN p_phone_number VARCHAR(20),
    IN p_hire_date date,
    IN p_salary DECIMAL(10,2),
    IN p_manager_id INT,
    IN p_department_id INT
)
BEGIN
    update employees set 
                        first_name=p_first_name, 
                        last_name=p_last_name,
                        phone_number=p_phone_number, 
                        hire_date=p_hire_date,
                        salary=p_salary,
                        manager_id=p_manager_id,
                        department_id=p_department_id
                        where employee_id=p_employee_id;
END /

DELIMITER ;
#Q4 calling update procedure
call p_Update(100,'Guns','hada','123456789','2004-01-23',20000,2344,3);

#Q5procedure to delete an employee
delimiter %
drop procedure if exists p_delete%
create procedure p_delete(
			in p_employee_id int)
            begin
            if exists(select 1 from employees where employee_id=p_employee_id) then
            delete from employees where employee_id=p_employee_id;
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Row creation successful!';
            else 
            SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Row not found';
            end if;
            end %
delimiter ;
#Q6
call p_delete(102);
#Q7 trigger to log salary changes
delimiter /
create trigger LogSalaryChange
after update on employee_salary for each row
begin 
     insert into SalaryLog(employee_id,oldsalary,newsalary,changedate)
     values(old.employee_id,old.salary,new.salary,NOW());
end /
delimiter ;
#Q8 trigger for invalid salary change
DELIMITER //

CREATE TRIGGER preventInvalidSalary BEFORE UPDATE ON employee_salary FOR EACH ROW 
BEGIN      
    IF NEW.salary < 0 THEN          
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salary cannot be negative';
    END IF;
END //
DELIMITER ;

drop procedure if exists avg_salary;
DELIMITER /
create procedure avg_salary(in p_department_id int,out p_avg int)
begin 
    if p_department_id in (select department_id from employees) then 
	select avg(salary) into p_avg from employees 
    where department_id=p_department_id;
    else 
    signal sqlstate '45000' set message_text="invalid department id";
    end if;
end/
DELIMITER ;
set @avg_salary =0;
call avg_salary(90,@avg_salary);
select(@avg_salary);
#11 create trigger to update last modified date
delimiter //
CREATE TRIGGER last_modified BEFORE UPDATE ON employees FOR EACH ROW 
BEGIN      
    set new.last_modified=now();
END //
DELIMITER ;
#12 procedure to count employees
DELIMITER /
create procedure count_emp(in p_department_id int,out p_count int)
begin 
    if p_department_id in (select department_id from employees) then 
	select count(*) into p_count from employees 
    where department_id=p_department_id;
    else 
    signal sqlstate '45000' set message_text="invalid department id";
    end if;
end/
DELIMITER ;
#13
set @count_dept =0;
call count_emp(90,@count_dept);
select(@count_dept);
#14
delimiter //
create trigger prevent_deletion_active_emp before delete on employees
for each row
begin 
     if old.isActive=1 then 
     signal sqlstate '45000' set message_text='Active employee';
     end if;
     end//
delimiter ;
#15 procedure to calculate total salary by department
DELIMITER /
create procedure salary_dept(in p_department_id int,out p_sal int)
begin 
    if p_department_id in (select department_id from employees) then 
	select sum(salary) into p_sal from employees 
    where department_id=p_department_id;
    else 
    signal sqlstate '45000' set message_text="invalid department id";
    end if;
end/
DELIMITER ;
#16
set @p_sal =0;
call salary_dept(90,@p_sal);
select(@p_sal);
#17
delimiter //
create trigger enforcemaxsal before insert on employees for each row
begin 
if new.salary >100000 then 
signal sqlstate '45000' set message_text="salary exceedes max cap";
end if;
end //
delimiter ;
#18
DROP PROCEDURE IF EXISTS ArchiveOldEmployees;
DELIMITER //
CREATE PROCEDURE ArchiveOldEmployees()
BEGIN
    INSERT INTO ArchivedEmployees (employee_id, first_name, last_name, department_id, salary)
    SELECT employee_id, first_name, last_name, department_id, salary 
    FROM Employees 
    WHERE hire_date < NOW() - INTERVAL 1 YEAR;

    DELETE FROM Employees 
    WHERE hire_date < NOW() - INTERVAL 1 YEAR;
END //
DELIMITER ;
CALL ArchiveOldEmployees();

#Q20
delimiter //
create trigger logdeletion after delete on employees for each row begin 
INSERT INTO DeletedEmployeesLog (EmployeeID, Name, DepartmentID, Salary, DeletionDate)
    VALUES (OLD.employee_id, OLD.first_name, OLD.department_id, OLD.salary, NOW());
    end//
delimiter ;

    
            
