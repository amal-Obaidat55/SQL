Create table AccessCards (
CardID int primary key,
CardName varchar(50) not null unique,
EmployeeID int Foreign Key References Employees(EmployeeID)
);

Create Table Projects(
ProjectID int Primary Key,
ProjectName varchar(100) not null
)

Create Table EmployeeProjects(
EmpID int Foreign Key References Employees(EmployeeID),
ProID int Foreign Key References Projects(ProjectID),
PRIMARY KEY (EmpID, ProID)
)

Alter Table EmployeeProjects
Add AssignedDate date;


Insert into AccessCards
values (1,'Card 101',1) ,(2,'Card 102',2),(3,'Card 103',3);

Select * from Employees

Insert into Projects
values (1,'AI & Security Training'),(2,'Cloud Migration')

Insert into EmployeeProjects 
values (1,1,'2026-10-29')

Insert into EmployeeProjects 
values (1,2,'2026-10-29')

Insert into EmployeeProjects 
values (2,1,'2026-10-29')

Insert into EmployeeProjects 
values (3,2,'2026-10-29')

Select * from EmployeeProjects

Select FullName , Salary , DepartmentName from Employees
Inner Join Departments
On Employees.EmployeeID = Departments.DepartmentID

Select * from Employees
Left Join Departments
On Employees.EmployeeID = Departments.DepartmentID

Select FullName ,CardName from Employees
Inner Join AccessCards
On Employees.EmployeeID = AccessCards.EmployeeID

Select FullName , ProjectName , AssignedDate from Employees
Inner join EmployeeProjects 
On Employees.EmployeeID = EmployeeProjects.EmpID  
Inner join Projects 
On Projects.ProjectID = EmployeeProjects.ProID  


Select DepartmentID ,Sum(Salary) "TotalSalary" , Count(*) "EmployeeCount"
from Employees
Group by DepartmentID

Select DepartmentID , Avg(Salary) "AvgSalary"
from Employees
Group by DepartmentID
Having Avg(Salary) > 1000

Select * from Employees 
where Salary > (select Avg(Salary) from Employees )

Create view vw_EmployeeDetails
As 
Select EmployeeID , FullName , Email ,DepartmentName
from Employees
Inner Join Departments
on Employees.DepartmentID= Departments.DepartmentID

select * from vw_EmployeeDetails

Create Procedure sp_GetEmployeesByDepartment 
@DeptID int 
As begin
Select * from Employees
where DepartmentID = @DeptID
End;

EXEC sp_GetEmployeesByDepartment @DeptID=2;

Create Table EmployeeAudit (AuditID int Primary Key Identity(1,1),
EmployeeID INT,
Action VARCHAR(50),
ActionDate DATETIME
);

Create Trigger trigger1
on Employees
After Delete 
As Begin 
Insert into EmployeeAudit 
Select EmployeeID , 'Delete' , GETDATE()
From deleted

End;

Insert into Employees
values (5,'Amal Obaidat','amal@gmail.com',900,2,'0777777777')

Delete from Employees
Where EmployeeID = 5;

Select * from EmployeeAudit