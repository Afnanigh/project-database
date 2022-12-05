drop table Doctor cascade constraints;
create table Doctor (
doc_name varchar2(20) not null,
doc_id char(10) ,
constraint doc_pk primary key(doc_id));

 drop table Paitent cascade constraints;
create table Paitent (
pa_name varchar2(10) not null,
blood_type varchar2(3), 
File_no number(4) not null,
date_of_birth date,
doc_id char(10),
liver_id char(4),
constraint pa_pk primary key(File_no),
constraint pa_fk foreign key(doc_id) REFERENCES Doctor(doc_id));




drop table Liver cascade constraints;
create table Liver(
liver_size number(4) check(liver_size <=10),
liver_lope varchar2(20),
liver_id char(4),
constraint liver_pk primary key(liver_id));


drop table Donor cascade constraints;
create table Donor(
don_name varchar2(20),
File_no_Don number(4),
date_of_birth_don date,
blood_type_don varchar2(3),
liver_id char(4),
constraint don_pk primary key(File_no_Don),
constraint don_fk foreign key(liver_id) REFERENCES Liver(liver_id));


drop table Surgery cascade constraints;
create table Surgery(
surgery_num number(10),
surgery_result varchar(100),
surgery_date date,
surgery_time varchar(8),
constraint surgery_pk primary key(surgery_num));

drop table Make cascade constraints;
create table Make(
File_no number(4),
doc_id char(10),
surgery_num number(10),
constraint make_pk1 primary key(doc_id,File_no,surgery_num),
constraint make_fk1 foreign key(File_no) REFERENCES Paitent(File_no),
constraint make_fk2 foreign key(doc_id) REFERENCES Doctor(doc_id),
constraint make_fk3 foreign key(surgery_num) REFERENCES Surgery(surgery_num)on delete set null);

-------------------
insert into doctor values('Dr.ahmed','9875711') ;
insert into doctor values ('Dr.mohammed','4467900');
insert into doctor values ('Dr.samar','7720550');

insert into Paitent values ('Bader','AB',2234,'20/10/2002','9875711','0034');
insert into Paitent values ('leena','A+',3422,'23/1/1994','9875711','0401');
insert into Paitent values ('mona','A+',7233,'27/5/2001','7720550','1001');

insert into Liver values(8,'Right lope of liver','0034');
insert into Liver values(10,'left lope of liver','0401');
insert into Liver values(6,'left lope of liver','1001');

insert into Donor values('Assaf',0074,'23/1/1997','AB','0034');
insert into Donor values('salma',0099,'09/7/1991','A+','0401');
insert into Donor values('waad',0012,'01/11/2000','A+','1001');

insert into surgery values(100986530,'The surgery was done successfully','12/5/2021','08:30:09');
insert into surgery values(119900044,'Surgery completed successfully, under observation due to bile duct leak','09/9/2020','23:07:54');
insert into surgery values(110009467,'The liver transplant surgery was not successful, because the donors liver was damaged','22/6/2018','04:28:09');

insert into make values(2234,'9875711',100986530);
insert into make values(3422,'9875711',119900044);
insert into make values(7233,'7720550',110009467);

alter table Paitent add constraint pt_fk foreign key(liver_id) REFERENCES Liver(liver_id);

--display the name of the paitent is file_no is 2234
select pa_name
from paitent
where file_no ='2234';

--List all information of dr.samar
select * 
from doctor 
where doc_name='Dr.samar';

--delete donor who is blood type AB
delete from donor 
where blood_type_don  ='AB';

--how many donor in donor TABLE
select count (*)
from donor ;

--List the liver size min for each liver size
select liver_size , min(liver_size)
from liver
GROUP by liver_size;

--find if any of the doctor make two surgery 
select doc_id ,count (*)
from make 
GROUP by doc_id 
having count(*) =2;