--Stage 2
Create Table Departments(
DepartmentID int Primary Key,
DepartmentName varchar(100) not null Unique,
);

Create Table Students(
StudentID int Primary Key ,
FullName varchar(100) not null,
Email varchar(100) unique,
GPA decimal(3,2),
DepartmentID int Foreign Key References Departments(DepartmentID)
);

Create Table StudentProfile(
ProfileID int Primary Key,
StudentID int Foreign Key References Students(StudentId),
SAddress varchar(200),
EmergencyPhone varchar(20)
);

Create Table Courses(
CourseID int Primary Key,
CourseName varchar(100) not null,
Credit int , 
DepartmentID int Foreign Key References Departments(DepartmentID)
);

Create Table StudentCourses (
StudentID int Foreign Key References Students(StudentID),
CourseID int Foreign Key References Courses(CourseID),
EnrollmentDate date default GETDATE(),
Primary Key(StudentID,CourseID)
);

Drop Table StudentCourses;

Alter Table Students
Add Age int; 


--Stage 3
Insert Into Departments
Values (1, 'Computer Science'),
(2, 'Software Engineering'),
(3, 'Business Administration');


Insert Into Students
Values (101,'Ali Smadi','ali@coursehub.com',3.80,1,22),
(102,'Omar Ahmed','omar@coursehub.com',2.90,1,21),
(103,'Laila Hassan','laila@coursehub.com',3.50,2,23),
(104,'Tariq Zaid','tariq@coursehub.com',2.10,3,20);


Insert Into StudentProfile
Values (1, 101, 'Amman, Jordan', '0791111111'),
(2, 102, 'Irbid, Jordan', '0792222222'),
(3, 103, 'Zarqa, Jordan', '0793333333');


Insert Into Courses
Values (201, 'Database Systems', 3, 1),
(202, 'Web Development', 3, 1),
(203, 'Software Architecture', 3, 2);


Insert Into StudentCourses
Values
(101,201,'2026-10-30'),
(101,202,'2026-10-30'),
(102,201,'2026-10-30'),
(103,203,'2026-10-30');

Select * from Students
Select * from StudentProfile 
Select * from Departments
Select * from Courses
Select * from StudentCourses


--Stage 4
Select FullName, GPA , DepartmentName 
From Students
Inner Join Departments
On Students.DepartmentID = Departments.DepartmentID;

Select DepartmentName , FullName 
From Students
Left Join Departments
On Students.DepartmentID = Departments.DepartmentID;

Select FullName, SAddress , EmergencyPhone 
From Students
Inner Join StudentProfile
On Students.StudentID = StudentProfile.StudentID;

Select FullName, CourseName , EnrollmentDate
From Students
Inner Join Courses
On Students.DepartmentID = Courses.DepartmentID
Inner Join StudentCourses
On Students.StudentID = StudentCourses.StudentID


--Stage 5
Select Count(*) "TotalStudents", AVG(GPA) "AverageGPA" , MAX(GPA) "HighestGPA",
MIN(GPA) "LowestGPA"
From Students

Select DepartmentID , AVG(GPA) "AverageGPA", Count(*) "TotalStudents"
From Students
Group by DepartmentID;


Select DepartmentID , AVG(GPA) "AverageGPA"
From Students
Group by DepartmentID
Having AVG(GPA) > 3.00;

Select DepartmentID , Count(*) "TotalStudents"
From Students
Where GPA >= 2.50
Group by DepartmentID
Having Count(*)>1;


--Stage 6
EXEC sp_helpindex 'Students' 
--StudentID

Create NonClustered Index IX_Students_Email
On Students(Email)


--Stage 7
Select * From Students
Where GPA > (Select AVG(GPA) From Students)

Create View vw_StudentAcademicDetails
As 
Select StudentID , FullName , GPA , DepartmentName
From Students
Inner Join Departments
ON Students.DepartmentID = Departments.DepartmentID;

Select * from vw_StudentAcademicDetails;

Create Procedure sp_GetStudentsByDepartment 
@DeptID int 
As 
Begin 
Select * From Students
Where DepartmentID = @DeptID;
End;

EXEC sp_GetStudentsByDepartment @DeptID = 1;
