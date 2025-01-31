Create Table If Not Exists Students (Student_Id int, Student_Name varchar(20));
Create Table If Not Exists Subjects (Subject_Name varchar(20));
Create Table If Not Exists Examinations (
    Student_Id int, Subject_Name varchar(20)
);
Truncate Table Students;
Insert Into Students (Student_Id, Student_Name) Values ('1', 'Alice');
Insert Into Students (Student_Id, Student_Name) Values ('2', 'Bob');
Insert Into Students (Student_Id, Student_Name) Values ('13', 'John');
Insert Into Students (Student_Id, Student_Name) Values ('6', 'Alex');
Truncate Table Subjects;
Insert Into Subjects (Subject_Name) Values ('Math');
Insert Into Subjects (Subject_Name) Values ('Physics');
Insert Into Subjects (Subject_Name) Values ('Programming');
Truncate Table Examinations;
Insert Into Examinations (Student_Id, Subject_Name) Values ('1', 'Math');
Insert Into Examinations (Student_Id, Subject_Name) Values ('1', 'Physics');
Insert Into Examinations (Student_Id, Subject_Name) Values ('1', 'Programming');
Insert Into Examinations (Student_Id, Subject_Name) Values ('2', 'Programming');
Insert Into Examinations (Student_Id, Subject_Name) Values ('1', 'Physics');
Insert Into Examinations (Student_Id, Subject_Name) Values ('1', 'Math');
Insert Into Examinations (Student_Id, Subject_Name) Values ('13', 'Math');
Insert Into Examinations (Student_Id, Subject_Name) Values (
    '13', 'Programming'
);
Insert Into Examinations (Student_Id, Subject_Name) Values ('13', 'Physics');
Insert Into Examinations (Student_Id, Subject_Name) Values ('2', 'Math');
Insert Into Examinations (Student_Id, Subject_Name) Values ('1', 'Math');

With Patterns As (
    Select Distinct
        St.Student_Id,
        St.Student_Name,
        Su.Subject_Name
    From Students As St, Subjects As Su
),

Counts As (
    Select
        Subject_Name,
        Student_Id,
        count(Subject_Name)
            Over (Partition By Student_Id, Subject_Name)
            As Attended_Exams
    From Examinations
)

Select Distinct
    P.Student_Id,
    P.Student_Name,
    P.Subject_Name,
    coalesce(C.Attended_Exams, 0) As Attended_Exams
From Patterns As P
Left Join
    Counts As C
    On P.Subject_Name = C.Subject_Name And P.Student_Id = C.Student_Id
Order By P.Student_Id, P.Subject_Name
;
