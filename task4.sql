/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [OrderId]
      ,[CustomerId]
      ,[Orderstatus]
      ,[OrderDate]
      ,[RequiredDate]
      ,[ShippedDate]
      ,[StoreId]
      ,[StaffId]
  FROM [BikeStoresDB].[Sales].[Orders]
  -- stored procedure:-
  create procedure selectAllOrders(@customerId int)
  as
  begin
  select*from Sales.Customers where CustomerId= @customerId
  end

  drop procedure selectAllOrders;

EXEC selectAllOrders @customerId = 3;
  

  -- stored procedure with output parameter:-
CREATE or alter PROCEDURE GetCustomerphone
   @CustomerID INT,
   @phone varchar(255) OUT
AS
BEGIN
   SELECT @phone = Phone FROM Sales.Customers WHERE CustomerId = @CustomerID
END



DECLARE @phoneNo varchar(255) 
EXEC GetCustomerphone @CustomerID =5 , @phone= @phoneNo OUTPUT
SELECT @phoneNo AS PhoneNo;

drop procedure GetCustomerphone;

select * from Sales.Customers;
-- SQL prg to check wheater the given num is positive or negative or zero : -


CREATE PROCEDURE checker
  @Number INT
AS
BEGIN
  IF @Number > 0
    PRINT 'The number is positive.'
  ELSE IF @Number < 0
    PRINT 'The number is negative.'
  ELSE
    PRINT 'The number is zero.'
END

EXEC checker @Number = 10;

exec checker @Number = -1;

exec checker @Number = 0;


--Update SalesReport stored proc to take year as input and display Year and total sales using PRINT statement

CREATE PROCEDURE SalesReport
  @Year INT
AS
BEGIN
  DECLARE @TotalSales DECIMAL(10, 2)

  SELECT @TotalSales = SUM(SalesAmount)
  FROM Sales
  WHERE YEAR(OrderDate) = @Year

  PRINT 'Sales Report for Year ' + CAST(@Year AS VARCHAR(4))
  PRINT 'Total Sales: ' + CAST(@TotalSales AS VARCHAR(10))
END
