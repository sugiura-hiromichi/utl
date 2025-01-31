Create Table If Not Exists Signups (User_Id int, Time_Stamp datetime);
Create Table If Not Exists Confirmations (
    User_Id int, Time_Stamp datetime, Action enum('confirmed', 'timeout')
);
Truncate Table Signups;
Insert Into Signups (User_Id, Time_Stamp) Values ('3', '2020-03-21 10:16:13');
Insert Into Signups (User_Id, Time_Stamp) Values ('7', '2020-01-04 13:57:59');
Insert Into Signups (User_Id, Time_Stamp) Values ('2', '2020-07-29 23:09:44');
Insert Into Signups (User_Id, Time_Stamp) Values ('6', '2020-12-09 10:39:37');
Truncate Table Confirmations;
Insert Into Confirmations (User_Id, Time_Stamp, Action) Values (
    '3', '2021-01-06 03:30:46', 'timeout'
);
Insert Into Confirmations (User_Id, Time_Stamp, Action) Values (
    '3', '2021-07-14 14:00:00', 'timeout'
);
Insert Into Confirmations (User_Id, Time_Stamp, Action) Values (
    '7', '2021-06-12 11:57:29', 'confirmed'
);
Insert Into Confirmations (User_Id, Time_Stamp, Action) Values (
    '7', '2021-06-13 12:58:28', 'confirmed'
);
Insert Into Confirmations (User_Id, Time_Stamp, Action) Values (
    '7', '2021-06-14 13:59:27', 'confirmed'
);
Insert Into Confirmations (User_Id, Time_Stamp, Action) Values (
    '2', '2021-01-22 00:00:00', 'confirmed'
);
Insert Into Confirmations (User_Id, Time_Stamp, Action) Values (
    '2', '2021-02-28 23:59:59', 'timeout'
);

Select
    S.User_Id,
    round(
        count(C.Action = 'timeout') Over (Partition By S.User_Id) / count(*), 2
    ) As Confirmation_Rate
From Signups As S, Confirmations As C
Group By S.User_Id, C.Action
;
