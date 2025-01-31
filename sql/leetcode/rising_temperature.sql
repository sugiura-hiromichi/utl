Create Table If Not Exists Weather (Id int, RecordDate date, Temperature int);
Truncate Table Weather;

Insert Into Weather (
    Id,
    RecordDate,
    Temperature) Values ('1',
'2015-01-01',
'10');
Insert Into Weather (
    Id,
    RecordDate,
    Temperature) Values ('2',
'2015-01-02',
'25');
Insert Into Weather (
    Id,
    RecordDate,
    Temperature) Values ('3',
'2015-01-03',
'20');
Insert Into Weather (
    Id,
    RecordDate,
    Temperature) Values ('4',
'2015-01-04',
'30');

Insert Into Weather (
    Id,
    RecordDate,
    Temperature) Values ('5',
'2015-01-06',
'31');

-- With Comparable As (
--     Select
--         Id,
--         Temperature,
--         lag(Temperature) Over (Order By RecordDate) As Lag_Tem,
--         RecordDate,
--         lag(RecordDate) Over (Order By RecordDate) As Lag_Rec
--     From Weather
-- )
--
-- Select Id
-- From Comparable
-- Where
--     date_sub(RecordDate, Interval 1 Day) = Lag_Rec
--     And Lag_Tem < Temperature
-- ;

-- Select W1.Id
-- From Weather As W1, Weather As W2
-- Where
--     datediff(W1.RecordDate, W2.RecordDate) = 1
--     And W1.Temperature > W2.Temperature
-- ;

Select Today.Id
From Weather As Today
Where
    Exists (
        Select 0
        From Weather As Yesterday
        Where
            datediff(Today.RecordDate, Yesterday.RecordDate) = 1
            And Today.Temperature > Yesterday.Temperature
    )
;
