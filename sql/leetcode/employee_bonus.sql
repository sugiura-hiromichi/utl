Create Table If Not Exists Employee (
    EmpId int, Name varchar(255), Supervisor int, Salary int
);
Create Table If Not Exists Bonus (EmpId int, Bonus int);
Truncate Table Employee;
Insert Into Employee (EmpId, Name, Supervisor, Salary) Values (
    '3', 'Brad', NULL, '4000'
);
Insert Into Employee (EmpId, Name, Supervisor, Salary) Values (
    '1', 'John', '3', '1000'
);
Insert Into Employee (EmpId, Name, Supervisor, Salary) Values (
    '2', 'Dan', '3', '2000'
);
Insert Into Employee (EmpId, Name, Supervisor, Salary) Values (
    '4', 'Thomas', '3', '4000'
);
Truncate Table Bonus;
Insert Into Bonus (EmpId, Bonus) Values ('2', '500');
Insert Into Bonus (EmpId, Bonus) Values ('4', '2000');

Select E.Name, B.Bonus
From Employee As E Left Join Bonus As B On E.EmpId = B.EmpId
Where B.Bonus < 1000 Or B.Bonus Is NULL
;
