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
WHERE Title='Sales Representative';

-- 4.Sales Representatives in the United States
-- Now we'd like to see the same columns as above, but only for those employees the have 
-- the title of sales Representative, and also are in the United States
SELECT FirstName,LastName,HireDate 
FROM Employees
WHERE Title='Sales Representative' and Country='USA';

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

-- 8. orders shipping to france or belgium
-- looking at the Orders table, there's a field called shipCountry.
-- write a query that shows the OrderID, CustomerID, and ShipCountry for the Orders 
-- where the ShipCountry is either france or Belgium
SELECT OrderID, CustomerID,ShipCountry 
FROM Orders 
WHERE ShipCountry = 'France' OR ShipCountry = 'Belgium'; 

-- 9. Orders shipping to any country in Latin America
-- we want to show all the orders from any Latin American country.
-- just use this list of latin american countries that happen to be  in the Orders table
-- Brazil Mexico Argentina Venezuela
-- my way
SELECT OrderID, CustomerID,ShipCountry 
FROM Orders
WHERE ShipCountry = 'Brazil' OR ShipCountry = 'Mexico' OR ShipCountry = 'Argentina' OR ShipCountry = 'Venezuela';

-- new way
SELECT OrderID, CustomerID,ShipCountry 
FROM Orders
WHERE ShipCountry in('Brazil','Mexico','Argentina','Venezuela'); 

-- 10.Employess, in order of age
-- for all the employees in the Employees table, show the 
-- FirstName, LastName, Title, BrithDate
-- Order the result by Birthday, so we have the oldest employees first
SELECT FirstName, LastName, Title, BirthDate
FROM Employees
ORDER BY BirthDate

-- 11. showing only the Date with a DateTimefield
-- in the output of the query above, showing the Employees in order of 
-- Birthdate, we see the time of the BirthDatefield, which we don't want.
-- Show only the date portion of the BirthDate field
SELECT FirstName, LastName, Title, cast(BirthDate as date) Birthday
FROM Employees
ORDER BY BirthDate

-- 12. Employees Full Name
-- show the FirstName and LastName columns from the Employees table,
-- and then create a new columncalled FullName, showing FirstName and LastName
-- joined together in one column, with a space in-between
SELECT (FirstName + ' ' +LastName) as FullName
FROM Employees

-- 13. OrderDetails amount per line item
-- in the OrderDetails table, we have the fields UnitPrice and Quantity.
-- create a new field, TotalPrice, that multiplies these two together.
-- we'll ignore the Discount field for now
-- In addition, show the OrderID, ProductID, UnitPrice, and
-- Quantity. Order by OrderID and ProductID.
SELECT OrderID, ProductID, UnitPrice, Quantity, (UnitPrice * Quantity) AS TotalPrice
FROM OrderDetails
ORDER BY OrderID & ProductID

-- 14. how many customers?
-- how many customers do we have in the customers table? 
-- show one value only, and don't reply and don't reply on 
-- getting the recordcount at end of a resultset
SELECT COUNT(CustomerID) AS TotalCustomers FROM Customers

-- 15. when was the first order?
-- show the date of the first order ever made in the orders table
SELECT Top 1 OrderDate AS FirstOrder FROM Orders

-- 16. countries where there are customers
-- show a list of countries where the Northwind customers
SELECT Distinct country FROM Customers

-- NEW WAY
SELECT country FROM Customers GROUP BY country

-- 17. Contact titles for customers
-- show a list of all the diffrent values in the Customers 
-- table for ContactTitles. Also include a count for each ContactTitle.
SELECT ContactTitle, COUNT(ContactTitle) AS ContactTitles
FROM Customers GROUP BY ContactTitle

-- 18. products with associated supplier names
-- We???d like to show, for each product, the associated Supplier. 
-- Show the ProductID, ProductName, and the CompanyName of the Supplier. 
-- Sort by ProductID. This question will introduce what may be a new concept,
-- the Join clause in SQL. The Join clause is used to join
-- two or more relational database tables together in a logical way.
-- Here???s a data model of the relationship between Products and Suppliers.
SELECT p.ProductID, p.ProductName, s.CompanyName
FROM Products p JOIN Suppliers s ON p.CategoryID = s.SupplierID

-- 19. Orders and the Shipper that was used
-- We???d like to show a list of the Orders that were made,
-- including the Shipper that was used. Show the OrderID, 
-- OrderDate (date only), and CompanyName of the Shipper, and sort by OrderID.
-- In order to not show all the orders (there???s more than 800), 
-- show only those rows with an OrderID of less than 10300.
SELECT OrderID, cast(o.OrderDate AS date), s.CompanyName
FROM Orders o JOIN Shippers s ON o.ShipVia = s.ShipperID
Where o.OrderID < 10300
Order By o.OrderID

-- Intermediate Problems
-- 20. Categories, and the total products in each category
-- For this problem, we???d like to see the total number of
-- products in each category. Sort the results by the total
-- number of products, in descending order.
SELECT c.CategoryName, COUNT(p.ProductID)TotalProducts
FROM Categories c JOIN products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName
ORDER BY COUNT(p.ProductID) DESC 

-- 21. Total customers per country/city
-- In the Customers table, show the total number of
-- customers per Country and City.
SELECT c.Country, c.City, COUNT(c.City) TotalCustomers
FROM Customers c
GROUP BY c.Country, c.City
ORDER BY COUNT(c.City) DESC

-- 22. Products that need reordering
-- What products do we have in our inventory that should be
-- reordered? For now, just use the fields UnitsInStock and
-- ReorderLevel, where UnitsInStock is less than the
-- ReorderLevel, ignoring the fields UnitsOnOrder and
-- Discontinued.
-- Order the results by ProductID.
SELECT ProductID, ProductName,UnitsInStock,ReorderLevel
FROM Products
WHERE UnitsInStock < ReorderLevel

-- 23. Products that need reordering, continued
-- Now we need to incorporate these fields???UnitsInStock,
-- UnitsOnOrder, ReorderLevel, Discontinued???into our
-- calculation. We???ll define ???products that need reordering???
-- with the following:
-- UnitsInStock plus UnitsOnOrder are less than or
-- equal to ReorderLevel
-- The Discontinued flag is false (0).
SELECT ProductID, ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
FROM Products
WHERE UnitsInStock + UnitsOnOrder <= ReorderLevel and Discontinued = 0

-- 24. Customer list by region
-- A salesperson for Northwind is going on a business trip
-- to visit customers, and would like to see a list of all
-- customers, sorted by region, alphabetically.
-- However, he wants the customers with no region (null in
-- the Region field) to be at the end, instead of at the top,
-- where you???d normally find the null values. Within the
-- same region, companies should be sorted by CustomerID.
SELECT T.CustomerID, T.CompanyName, T.Region
FROM ( SELECT CustomerID, CompanyName, Region,
CASE WHEN Region is null THEN 1 ELSE 0 END AS SortField
FROM Customers) AS T
ORDER BY T.SortField, T.Region, T.CustomerID

-- 25. High freight charges
-- Some of the countries we ship to have very high freight
-- charges. We'd like to investigate some more shipping
-- options for our customers, to be able to offer them lower
-- freight charges. Return the three ship countries with the
-- highest average freight overall, in descending order by
-- average freight

SELECT TOP 3 ShipCountry, AVG(Freight) AverageFreight 
FROM Orders
GROUP BY ShipCountry
ORDER BY AverageFreight DESC

--26. High freight charges - 2015
--We're continuing on the question above on high freight
--charges. Now, instead of using all the orders we have, we
--only want to see orders from the year 2015.
SELECT TOP 3 ShipCountry, AVG(Freight) AverageFreight 
FROM Orders
WHERE YEAR(OrderDate) = 2015
GROUP BY ShipCountry
ORDER BY AVG(Freight) DESC


-- template
-- SELECT
-- FROM
-- WHERE
-- ORDER BY
-- GROUP BY