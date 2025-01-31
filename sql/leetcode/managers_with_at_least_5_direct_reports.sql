Create Table If Not Exists Employee (
    Id int, Name varchar(255), Department varchar(255), ManagerId int
);
Truncate Table Employee;
Insert Into Employee (
    Id,
    Name,
    Department,
    ManagerId) Values ('101',
'John',
'A',
NULL); Insert Into Employee (Id,
Name,
Department,
ManagerId) Values ('102',
'Dan',
'A',
'101'); Insert Into Employee (Id,
Name,
Department,
ManagerId) Values ('103',
'James',
'A',
'101'); Insert Into Employee (Id,
Name,
Department,
ManagerId) Values ('104',
'Amy',
'A',
'101'); Insert Into Employee (Id,
Name,
Department,
ManagerId) Values ('105',
'Anne',
'A',
'101'); Insert Into Employee (Id,
Name,
Department,
ManagerId) Values ('106',
'Ron',
'B',
'101');

Select E1.Name
From Employee E1 Join Employee E2 On E1.Id = E2.ManagerId
Group By E1.Id
Having count(E2.ManagerId) > 4
;
