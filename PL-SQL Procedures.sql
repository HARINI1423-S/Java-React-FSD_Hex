create database FSD_Hex;
use FSD_Hex;

-- create tables
create table employee(  id int primary key auto_increment,
name varchar(255) not null,
branch varchar(255),department varchar(255),salary double default 0);

desc employee;
INSERT INTO EMPLOYEE (id, name, branch, department, salary) VALUES
(1, 'Amit Sharma', 'Mumbai', 'HR', 75000.00),
(2, 'Priya Patel', 'Delhi', 'IT', 82000.50),
(3, 'Rajesh Kumar', 'Bangalore', 'Finance', 90000.75),
(4, 'Neha Verma', 'Mumbai', 'HR', 78000.25),
(5, 'Vikram Singh', 'Delhi', 'IT', 85000.00),
(6, 'Anjali Gupta', 'Bangalore', 'Finance', 92000.40),
(7, 'Manish Tiwari', 'Mumbai', 'HR', 76000.90),
(8, 'Kavita Reddy', 'Chennai', 'IT', 89000.30),
(9, 'Arjun Nair', 'Bangalore', 'Finance', 94000.20),
(10, 'Sneha Iyer', 'Chennai', 'HR', 77000.10),
(11, 'Suresh Pillai', 'Mumbai', 'IT', 81000.60),
(12, 'Divya Menon', 'Delhi', 'Finance', 93000.80),
(13, 'Ravi Shankar', 'Chennai', 'HR', 74000.55),
(14, 'Pooja Deshmukh', 'Bangalore', 'IT', 86000.95),
(15, 'Karan Mehta', 'Mumbai', 'Finance', 97000.70),
(16, 'Meera Joshi', 'Delhi', 'HR', 73000.15),
(17, 'Akash Bansal', 'Chennai', 'IT', 88000.45),
(18, 'Rohan Agarwal', 'Delhi', 'Finance', 95000.60),
(19, 'Swati Saxena', 'Bangalore', 'HR', 72000.85),
(20, 'Vivek Choudhary', 'Chennai', 'Finance', 96000.90);

SELECT * FROM employee;

/* create procedure */

delimiter $$;
create procedure proc_list_employee()
BEGIN
select * from employee;
END;

/* To Call procedures */
CALL proc_list_employee;

/* To see the list of procedures */
show procedure STATUS where db='FSD_Hex';

-- PL SQL
/* Proc-2 Displaying by branch */
-- INPUT(IN)
delimiter  $$
create procedure proc_emp_by_branch(IN pbranch varchar(255))
BEGIN
	SELECT * FROM employee where branch = pbranch;
END;
drop procedure proc_emp_by_branch;
CALL proc_emp_by_branch('mumbai');

/* Proc 3 OUT Paramater */
drop procedure proc_out_percentage;
delimiter $$
create procedure proc_out_percentage(IN p_Total_Marks double,IN p_Marks_Scored double,OUT p_percentage double)
BEGIN
	if p_Total_Marks < p_Marks_Scored THEN
    SET p_percentage=0;
    else
	 SET p_percentage=(p_Marks_Scored/p_Total_Marks)*100;
     END IF;
END;

SET @p_percentage=0;
CALL proc_out_percentage(600,565,@p_percentage);
CALL proc_out_percentage(600,665,@p_percentage);
select @p_percentage AS "Percentage";

/* Compute Consumption bill by taking units and rate as per below calculation 
For First 200 units: rate=8
For above 200 units: rate=10
if units less than 10,we take it as 25 units which is a base
procedure should give final bill value */

Delimiter $$
create procedure proc_bill(IN p_units double,OUT p_finalbill double)
BEGIN
	IF p_units < 10 THEN
		SET p_finalbill=25*8;
	ELSEIF p_units <=200 THEN
		SET p_finalbill=p_units*8;
    ELSE
		SET p_finalbill=(200*8)+((p_units - 200)*10);
	END IF;
END ;
SET @p_finalbill=0;
CALL proc_bill(600,@p_finalbill);
CALL proc_bill(200,@p_finalbill);
CALL proc_bill(6,@p_finalbill);
select @p_finalbill AS "Final Bill amount";

/* Proc 4: procdeure to give increments 
to employees based on their branches
 input->dept,percentage
 update salary accordingly
 */
 delimiter $$
 create procedure proc_salary_inc(IN p_department varchar(255),IN p_percentage double)
BEGIN
    update employee
    SET salary=salary+(salary *(p_percentage/100))
    where department=p_department;
END;
SET SQL_SAFE_UPDATES = 0;

CALL proc_salary_inc("HR",2);


/* Loops : Basic Loops,While Loops */

-- Proc to display number in loop

drop procedure proc_genratenum_loop;
delimiter $$
create procedure proc_genratenum_loop(IN num INT)
BEGIN
	declare i INT default 1;
    declare result varchar(255) default "";
	lb1 :LOOP  -- labelling the loops
		SET result=concat(result," ",i);
        SET i=i+1;
        -- LOOP TERMINATION CONDITION
     IF i > num THEN
		LEAVE lb1;
     END IF;
	END LOOP lb1;
    select result;
END;
CALL proc_genratenum_loop(5);


-- proc for while loop

delimiter $$
create procedure proc_genratenum_while(IN num INT)
BEGIN
	declare i INT default 1;
    declare result varchar(255) default " ";
    
    while i<=num DO
    SET result=concat(result," ",i);
    SET i=i+1;
    END while;
    select result;
END;
CALL proc_genratenum_while(8);

/* Proc : Fetchh all ids from the table that satisfy given criteria of dept */

delimiter $$
create procedure proc_fetch_id()
BEGIN
	declare i INT default 0;
    declare count_value INT;
    declare empid INT;
    select count(*) into count_value from employee;
    while i<count_value  DO
		select id into empid from employee limit i,1;
        SELECT CONCAT('Row ', i + 1, ': ID = ', empid) AS Output;
        SET i=i+1;
     END while;   
END;
drop procedure proc_fetch_id;
CALL proc_fetch_id();


/*  procdeure to give increments 
to employees based on their branches
 input->dept,percentage
 update salary accordingly
 
 Fetch all id form table satisfies dept criteria 1,4,7,9,13,17
 since i am inside loop
 I can call update on these ids and increment salary
 */
 
 delimiter $$
 create procedure proc_updatesalary(IN p_dept varchar(255),IN p_inc INT)
 BEGIN
	declare i INT default 0;
    declare emp_id INT default 0;
    declare total_idcount INT default 0;
    
    -- getting total employee count
    select count(*) as total_idcount
    from employee WHERE department=p_dept;
   
   -- getting the particular row to update
   while i <= total_idcount DO
    select id into emp_id from 
    employee WHERE department=p_dept LIMIT i,1;
    
    -- updating salary
    UPDATE employee
    SET salary=salary +(salary *(p_inc/100))
    WHERE id=emp_id;
    
    SET i=i+1;
    
    END WHILE;
    
 END;
 drop procedure proc_updatesalary;
 CALL proc_updatesalary("HR",10);
 
 /* 3 types of parameters IN,OUT,INOUT */
 -- INOUT
 -- Proc : to return salary of employee bades on the emp_id
 
 delimiter $$
 create procedure using_inout(INOUT myvar varchar(255))
 BEGIN
	select salary into myvar from employee where id=myvar;
 END;
 SET @X=1;
 CALL using_inout(@X);
 select @X;
 
 