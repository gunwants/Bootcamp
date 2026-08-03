UPDATE employees SET email='not available';

update employees set email='not available',commission_pct=0.10;

update employees set email='not available',commission_pct=0.10 where department-id=110;

update employees set email='not available' where department_id = 80 and commission_pct<0.2;

update employees  set email='not available' where deparment_id in (select demparment_id from departments where department_name='Accounting');

update employees set salary=8000 where employee_id = 105 and salary<5000;

update employees set job_id="SH_CLERK" where employee_id=118 and department_id=30 and job_id not like "SH%";

update employees set salary=
case department_id
when 40 then salary + (salary*0.25)
when 90 then salary + (salary*0.15)
when 110 then salary +(salary*0.10)
else salary
end
where department_id in (40,90,110);

update employees set salary=(salary*1.2),commission_pct=(commission_pct+0.10) where job_id="PU_CLERK";
update jobs set min_salary=min_salary+2000,
max_salary=max_salary+2000
where job_id in ("PU_CLERK");