alter table countries  rename country_new;

alter table locations add region_id int; 

alter table locations add region_id int first;

alter table locations add region_id int after state_province;

alter table locations modify country_id int;

alter table locations drop city;

alter table locations change state_province state varchar(25);

alter table locations add primary key (location_id) ;
 
alter table locations add primary key (location_id,country_id);

alter table locations drop primary key ;

alter table job_histry add foreign key (job_id) references jobs(job_id);

alter table job_histry add constraint fk_job_id foreign key (job_id) references jobs(job_id);

alter table job_histry add index indx_job_id(job_id); 

alter table job_histry drop index indx_job_id ;


 
 
