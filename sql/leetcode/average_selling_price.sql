Create Table If Not Exists Prices (
    Product_Id int, Start_Date date, End_Date date, Price int
);
Create Table If Not Exists UnitsSold (
    Product_Id int, Purchase_Date date, Units int
);
Truncate Table Prices;
Insert Into Prices (Product_Id, Start_Date, End_Date, Price) Values (
    '1', '2019-02-17', '2019-02-28', '5'
);
Insert Into Prices (Product_Id, Start_Date, End_Date, Price) Values (
    '1', '2019-03-01', '2019-03-22', '20'
);
Insert Into Prices (Product_Id, Start_Date, End_Date, Price) Values (
    '2', '2019-02-01', '2019-02-20', '15'
);
Insert Into Prices (Product_Id, Start_Date, End_Date, Price) Values (
    '2', '2019-02-21', '2019-03-31', '30'
);
Truncate Table UnitsSold;
Insert Into UnitsSold (Product_Id, Purchase_Date, Units) Values (
    '1', '2019-02-25', '100'
);
Insert Into UnitsSold (Product_Id, Purchase_Date, Units) Values (
    '1', '2019-03-01', '15'
);
Insert Into UnitsSold (Product_Id, Purchase_Date, Units) Values (
    '2', '2019-02-10', '200'
);
Insert Into UnitsSold (Product_Id, Purchase_Date, Units) Values (
    '2', '2019-03-22', '30'
);

Select
    P.Product_Id,
    round(sum(P.Price * coalesce(U.Units, 0)) / sum(coalesce(U.Units, 1)), 2)
        As Average_Price
From Prices As P Left Join UnitsSold As U Using (Product_Id)
Where
    U.Purchase_Date Is null Or
    U.Purchase_Date Between P.Start_Date And P.End_Date
Group By P.Product_Id
;
