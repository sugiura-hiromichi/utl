Create Table If Not Exists Project (Project_Id int, Employee_Id int);
Create Table If Not Exists Employee (
    Employee_Id int, Name varchar(10), Experience_Years int
);
Truncate Table Project;
Insert Into Project (Project_Id, Employee_Id) Values ('1', '1');
Insert Into Project (Project_Id, Employee_Id) Values ('1', '2');
Insert Into Project (Project_Id, Employee_Id) Values ('1', '3');
Insert Into Project (Project_Id, Employee_Id) Values ('2', '1');
Insert Into Project (Project_Id, Employee_Id) Values ('2', '4');
Truncate Table Employee;
Insert Into Employee (Employee_Id, Name, Experience_Years) Values (
    '1', 'Khaled', '3'
);
Insert Into Employee (Employee_Id, Name, Experience_Years) Values (
    '2', 'Ali', '2'
);
Insert Into Employee (Employee_Id, Name, Experience_Years) Values (
    '3', 'John', '1'
);
Insert Into Employee (Employee_Id, Name, Experience_Years) Values (
    '4', 'Doe', '2'
);

Select Distinct
    P.Project_Id,
    round(avg(E.Experience_Years) Over (Partition By P.Project_Id), 2)
        As Average_Years
From Project As P Left Join Employee As E Using (Employee_Id)
;
