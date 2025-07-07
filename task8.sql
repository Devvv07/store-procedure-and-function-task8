create database task_db;

use task_db;

create table student(student_id int primary key,
s_name varchar(20) not null,
program varchar(15),
phone_no bigint unique,
gender varchar(8));

insert into student values(01,"ganesh","bsc",6435273623,"male");
insert into student values(02,"laxmi","bca",6587634567,"female");
insert into student values(03,"kartik","cse",9876432156,"male");
insert into student values(04,"dev","bsc",6953273623,"male");

select * from student;

#procedure

delimiter //

create procedure add_or_update_student(
in p_id int,
in p_name varchar(20),
in p_prog varchar(15),
in p_phone bigint,
in p_gender varchar(8),
out p_msg varchar(50))
begin
if exists (select 1 from student where student_id = p_id) then
update student
set s_name = p_name,
program = p_prog,
phone_no = p_phone,
gender = p_gender
where student_id = p_id;
set p_msg = CONCAT('Student ', p_id, ' updated successfully');
else
insert into student(student_id, s_name, program, phone_no, gender)
values(p_id, p_name, p_prog, p_phone, p_gender);
set p_msg = CONCAT('Student ', p_id, ' inserted successfully');
end if;
end;
//

delimiter ;

call add_or_update_student(05, 'Sneha', 'bcom', 9123456780, 'female', @p_msg);

SELECT @p_msg;

drop procedure sp_add_or_update_student;

#function

delimiter //

create function fn_count_by_program(p_prog VARCHAR(15))
returns int deterministic
begin
declare cnt int;
select count(*) into cnt
from student
where program = p_prog;
return cnt;
end;
//

delimiter ;

SELECT fn_count_by_program('bsc') AS bsc_students;

drop procedure sp_add_or_update_student;
