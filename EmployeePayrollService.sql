-- UC1 -- Create A payroll_service Database
create database payroll_service;
use payroll_service;

-- UC2 -- Create A employee_payroll Table
create table employee_payroll(
	  
	Name varchar(255),
	Salary float,
	StartDate date);

-- UC3 -- Create employee_payroll data as part of CURD operation 
insert into employee_payroll(Name, Salary, StartDate) values 
	("Aman", 50000.00, '2017-02-11'),
	("Samarth", 60000.00, '2016-01-03'),
	("Aarya", 40000.00, '2018-07-10'),
	("Jaya", 80000.00, '2009-08-12');
    
-- UC4 -- Retrieve employee_payroll data
select * from employee_payroll;

-- UC5 -- Retrive Salary data of particular employee and in particular Date range
select Salary from employee_payroll where Name="Aman";
select * from employee_payroll where StartDate between cast('2018-01-01' as date) and DATE(now());

-- UC6 -- Add Gender to employee_payroll Table and Update the Rows to reflect the correct Employee Gender
alter table employee_payroll add Gender char(1);
update employee_payroll set Gender= 'M' where Name = "Aman" or Name = "Samarth";
update employee_payroll set Gender= 'F' where Name = "Aarya" or Name = "Jaya";

-- UC7 -- Ability to find Sum, Average, Min, Max and Number of male and female employees
select sum(Salary) as SumSalary,Gender from employee_payroll group by Gender;
select avg(Salary) as AvgSalary,Gender from employee_payroll group by Gender; 
select max(Salary) as MaxSalary,Gender from employee_payroll group by Gender; 
select min(Salary) as MinSalary,Gender from employee_payroll group by Gender; 
select count(Name) as EmployeeCount,Gender from employee_payroll group by Gender;

-- UC8 -- Add Employee Phone, Department(not null), Address (using default values)
select * from employee_payroll;
alter table employee_payroll add Phone bigint;
update employee_payroll set Phone = 1234567890; 
update employee_payroll set Phone = 1234569874 where ID IN (2,4); 
alter table employee_payroll add Address varchar(100) not null default 'Bangalore';
alter table employee_payroll add Department varchar(250) default 'IT';

-- UC9 -- Extend table to have Basic Pay, Deductions, Taxable Pay, Income Tax, Net Pay.
alter table employee_payroll RENAME COLUMN Salary to BasicPay; 
alter table employee_payroll add Deductions float not null default 1000.00;
alter table employee_payroll add TaxablePay float not null default 0.00;
alter table employee_payroll add IncomeTax float not null default 2000.00;
alter table employee_payroll add NetPay float not null default 0.00;
update employee_payroll set NetPay = (BasicPay-Deductions-TaxablePay-IncomeTax);
select * from employee_payroll;

-- UC10 -- Two departments for same employee
insert into employee_payroll (Name, BasicPay, StartDate, Gender, Phone, Address, Department, Deductions, TaxablePay, IncomeTax, NetPay)
			values ("Sam", 50000.00, '2017-02-11', 'M', 7894561230, 'Bangalore', 'S&M',1000.00, 59000.00, 2000.00,0.00);
update employee_payroll set NetPay = (BasicPay - Deductions - IncomeTax);

-- UC11 -- Create A table Employee_Department
create table employee_department (
	DepartmentID int NOT NULL  Primary Key,
	EmployeeID int Not Null ,
	Foreign Key (EmployeeID)
	References employee_payroll(ID),
	Department varchar(100)
);
select * from employee_department;