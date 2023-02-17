-- 1.Which shippers do we have?
-- hint: We have a table  called Shippers. Return all the fields from all the shippers
SELECT * FROM Shippers;

-- 2.Certain fields from Categories
-- we only need data of CategoryName and Description
SELECT CategoryName,Description FROM Categories;

-- 3.Sales Respresentatives
-- we'd like to see just the FirstName, LastName, and HireDate of all the employees with Title of Sales Representatives. 
SELECT FirstName,LastName,HireDate 
FROM Employees
where Title='Sales Representative';

-- 4.Sales Representatives in the United States
-- Now we'd like to see the same columns as above, but only for those employees the have 
-- the title of sales Representative, and also are in the United States
SELECT FirstName,LastName,HireDate 
FROM Employees
where Title='Sales Representative' and Country='USA';

-- 5.Orders placed by specific EmployeeID
-- Show all the orders placed by a specific employee.
-- the EmployeeID for this Employee (Steven Buchanan) is 5.
SELECT * 
FROM Orders
WHERE EmployeeID=5;

-- 6.Suppliers and ContactTitles
-- in the Suppliers table, show the SupplierID, ContactName, and ContactTitle for those Suppliers
-- whose ContactTitle is not Marketing Manager
SELECT SupplierID, ContactName, ContactTitle
FROM Suppliers
WHERE Not ContactTitle = 'Marketing Manager';

SELECT SupplierID, ContactName, ContactTitle
FROM Suppliers
WHERE ContactTitle != 'Marketing Manager';

-- 7.Products with 'queso' in ProductName
-- In the Products table, we'd like to see the ProductID and ProductName for those products
-- where the ProductName includes the string 'queso'
SELECT ProductID, ProductName
FROM Products
WHERE  ProductName LIKE '%queso%';