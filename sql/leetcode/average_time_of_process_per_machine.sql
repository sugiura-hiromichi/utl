Create Table If Not Exists Activity (
    Machine_Id int,
    Process_Id int,
    Activity_Type enum('start', 'end'),
    Timestamp float
);
Truncate Table Activity;
Insert Into Activity (
    Machine_Id, Process_Id, Activity_Type, Timestamp
) Values ('0', '0', 'start', '0.712'),
('0', '0', 'end', '1.52'),
('0', '1', 'start', '3.14'),
('0', '1', 'end', '4.12'),
('1', '0', 'start', '0.55'),
('1', '0', 'end', '1.55'),
('1', '1', 'start', '0.43'),
('1', '1', 'end', '1.42'),
('2', '0', 'start', '4.1'),
('2', '0', 'end', '4.512'),
('2', '1', 'start', '2.5'),
('2', '1', 'end', '5')
;

Select
    S.Machine_Id,
    ROUND(AVG(E.Timestamp - S.Timestamp), 3) As Processing_Time
From Activity S
Join Activity E On E.Machine_Id = S.Machine_Id
Where S.Activity_Type = 'start' And E.Activity_Type = 'end'
Group By S.Machine_Id
;
