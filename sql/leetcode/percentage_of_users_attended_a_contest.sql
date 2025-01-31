Create Table If Not Exists Users (User_Id int, User_Name varchar(20));
Create Table If Not Exists Register (Contest_Id int, User_Id int);
Truncate Table Users;
Insert Into Users (User_Id, User_Name) Values ('6', 'Alice');
Insert Into Users (User_Id, User_Name) Values ('2', 'Bob');
Insert Into Users (User_Id, User_Name) Values ('7', 'Alex');
Truncate Table Register;
Insert Into Register (Contest_Id, User_Id) Values ('215', '6');
Insert Into Register (Contest_Id, User_Id) Values ('209', '2');
Insert Into Register (Contest_Id, User_Id) Values ('208', '2');
Insert Into Register (Contest_Id, User_Id) Values ('210', '6');
Insert Into Register (Contest_Id, User_Id) Values ('208', '6');
Insert Into Register (Contest_Id, User_Id) Values ('209', '7');
Insert Into Register (Contest_Id, User_Id) Values ('209', '6');
Insert Into Register (Contest_Id, User_Id) Values ('215', '7');
Insert Into Register (Contest_Id, User_Id) Values ('208', '7');
Insert Into Register (Contest_Id, User_Id) Values ('210', '2');
Insert Into Register (Contest_Id, User_Id) Values ('207', '2');
Insert Into Register (Contest_Id, User_Id) Values ('210', '7');

Select Distinct
    R.Contest_Id,
    round(
        count(R.User_Id) Over (Partition By R.Contest_Id) / U.Count * 100,
        2
    ) As Percentage
From Register As R Left Join (
    Select count(User_Id) Over () As Count, User_Id
    From Users
) As U Using (User_Id)
Order By Percentage Desc, Contest_Id
;
