create table TemporaryStaff(
StaffID int primary key,
StaffName varchar(50),
HireDate date
);


create table Departments(
DepartmentID int primary key,
DepartmentName varchar(50) not null unique
);

create table Employees(
EmployeeID int primary key,
FullName varchar(100) not null,
Email varchar(100) unique,
Salary decimal(10,2),
DepartmentID int
);


Alter table Employees 
Add PhoneNumber varchar(20);

Drop table TemporaryStaff;

Insert into Departments 
values (1, 'IT');

Insert into Departments 
values (2, 'HR');

Insert into Departments 
values (3, 'Finance');

select * from Departments;


Insert into Employees
values(1 ,'Ahmad Ali','ahmad@techworld.com',1200.00, 1 ,'0791111111');

Insert into Employees
values(2 ,'Sara Hassan','sara@techworld.com',950.00 , 2 ,'0792222222');

Insert into Employees
values(3 ,'Zaid Omar','zaid@techworld.com',1500.00 , 1, '0793333333');

Insert into Employees
values(4, 'Mona Khaled','mona@techworld.com', 800.00 , 3 ,'0794444444');

select * from Employees;

update Employees
set Salary=1350.00
where EmployeeID = 1;

delete from Employees
where EmployeeID=4;

select * from Employees;

select FullName , Salary from Employees;

select SUM(Salary) "TotalSalaries" from Employees;

select AVG(Salary) "AverageSalary" from Employees;

select MIN(Salary) "LowestSalary" , MAX(Salary) "HighestSalary" from Employees;

select COUNT(*) "TotalEmployees" from Employees;
