Create Table If Not Exists Queries (
    Query_Name varchar(30), Result varchar(50), Position int, Rating int
);
Truncate Table Queries;
Insert Into Queries (Query_Name, Result, Position, Rating) Values (
    'Dog', 'Golden Retriever', '1', '5'
);
Insert Into Queries (Query_Name, Result, Position, Rating) Values (
    'Dog', 'German Shepherd', '2', '5'
);
Insert Into Queries (Query_Name, Result, Position, Rating) Values (
    'Dog', 'Mule', '200', '1'
);
Insert Into Queries (Query_Name, Result, Position, Rating) Values (
    'Cat', 'Shirazi', '5', '2'
);
Insert Into Queries (Query_Name, Result, Position, Rating) Values (
    'Cat', 'Siamese', '3', '3'
);
Insert Into Queries (Query_Name, Result, Position, Rating) Values (
    'Cat', 'Sphynx', '7', '4'
);

Select
    Query_Name,
    avg(Rating / Position / count(*)) As Quality,
    count(Case When Rating < 3 Then null End)
        As Poor_Query_Percentage
From Queries
Group By Query_Name
;
