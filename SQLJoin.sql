------------------------
-- SQL JOIN STRUCTURE --
------------------------
-- 1. Inner Join
-- 2. Left (Outer) Join
-- 3. Right (Outer) Join
-- 4. Full Outer Join
-- 5. Cross Join

/*
SELECT * FROM Orders WHERE OrderID = 10248
SELECT * FROM [Order Details] WHERE OrderID = 10248

-- Tablolardan baz� datalar� silece�iz ama ana tablolar� etkilememek i�in temp table'da yapaca��z i�lemleri

SELECT * into #tmpOrders FROM Orders
SELECT * into #tmpOrderDetails FROM [Order Details]

SELECT * FROM #tmpOrders
SELECT * FROM #tmpOrderDetails

-- E�le�meyen data elde etmek i�in: 
-- OrderId yokken OrderDetail yer almas� i�in
DELETE #tmpOrders WHERE OrderID IN (10248, 10249, 10250)
-- OrderId varken OrderDetail olmamas� i�in
DELETE #tmpOrderDetails WHERE OrderID IN (10251, 10252, 10253)
*/
 
-- INNER JOIN: Her iki tabloda e�le�en kay�tlar� getirir 
SELECT * into #tmpOrders FROM Orders
SELECT * into #tmpOrderDetails FROM [Order Details]

SELECT O.OrderID, O.OrderDate, OD.ProductID, OD.Quantity, OD.UnitPrice, OD.Discount
FROM #tmpOrders O INNER JOIN #tmpOrderDetails OD
ON O.OrderID = OD.OrderID
WHERE O.OrderID = 10273 -- 10248'i bulamazd� �rne�in

SELECT O.*, OD.*
FROM #tmpOrders O INNER JOIN #tmpOrderDetails OD
ON O.OrderID = OD.OrderID
WHERE O.OrderID IN (10273, 10248,10249,10250,10251,10252,10253, 10255)

-- LEFT OUTER JOIN: Birinci tabloda olan t�m kay�tlar� ikinci tabloda e�le�en kay�t olmasa da getir.
SELECT * FROM #tmpOrders -- ORDER BY OrderID demen gerekebilir

SELECT O.OrderID, O.OrderDate, OD.ProductID, OD.Quantity, OD.UnitPrice, OD.Discount
FROM #tmpOrders O LEFT JOIN #tmpOrderDetails OD
ON O.OrderID = OD.OrderID
ORDER BY OrderID

-- RIGHT OUTER JOIN: �kinci tabloda olan t�m kay�tlar� birinci tabloda e�le�en kay�t olmasa da getir.
SELECT * FROM #tmpOrderDetails

SELECT O.OrderID, O.OrderDate, OD.*
FROM #tmpOrders O RIGHT JOIN #tmpOrderDetails OD
ON O.OrderID = OD.OrderID

-- FULL OUTER JOIN: Her iki tabloda e�le�en e�le�meyen t�m kay�tlar� getirir.
SELECT O.OrderID, OD.*
FROM #tmpOrders O FULL OUTER JOIN #tmpOrderDetails OD
ON O.OrderID = OD.OrderID
ORDER BY O.OrderID

DROP TABLE #tmpOrders
DROP TABLE #tmpOrderDetails

-- �K� TABLO INNER JOIN
SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM Employees

SELECT C.CustomerID, C.CompanyName, C.ContactTitle, O.OrderID, O.OrderDate
FROM Customers C INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
WHERE C.CustomerID = 'ALFKI'
ORDER BY O.OrderID

-- �� TABLO INNER JOIN
SELECT C.CustomerID, C.CompanyName, C.ContactTitle, O.OrderID, O.OrderDate, E.EmployeeID, E.FirstName, E.LastName
FROM Customers C 
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN Employees E ON O.EmployeeID = E.EmployeeID
WHERE C.CustomerID = 'ALFKI'

-- D�RT TABLO INNER JOIN
SELECT C.CustomerID, C.CompanyName, C.ContactName, O.OrderID, O.OrderDate, E.EmployeeID, E.FirstName, E.LastName, OD.ProductID, OD.Quantity, OD.UnitPrice, OD.Discount
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN Employees E ON O.EmployeeID = E.EmployeeID
INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE C.CustomerID = 'ALFKI'

-- BE� TABLO INNER JOIN
SELECT 
C.CustomerID, C.CompanyName, C.ContactName, 
O.OrderID, O.OrderDate, 
E.EmployeeID, E.FirstName, E.LastName, 
OD.ProductID, OD.Quantity, OD.UnitPrice, OD.Discount,
P.ProductName
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN Employees E ON O.EmployeeID = E.EmployeeID
INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
INNER JOIN Products P ON OD.ProductID = P.ProductID
WHERE C.CustomerID = 'ALFKI'

-- ALTI TABLO INNER JOIN
SELECT 
C.CustomerID, C.CompanyName, C.ContactName, 
O.OrderID, O.OrderDate, 
E.EmployeeID, E.FirstName, E.LastName, 
OD.ProductID, OD.Quantity, OD.UnitPrice, OD.Discount,
P.ProductName,
CAT.CategoryName, CAT.Description
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN Employees E ON O.EmployeeID = E.EmployeeID
INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
INNER JOIN Products P ON OD.ProductID = P.ProductID
INNER JOIN Categories CAT ON P.CategoryID = CAT.CategoryID
WHERE C.CustomerID = 'ALFKI'

-- INNER JOIN Farkl� Bir Kullan�m:
SELECT O.*, OD.*, C.*
FROM Orders O, [Order Details] OD, Customers C
WHERE O.OrderID = OD.OrderID AND O.CustomerID = C.CustomerID AND C.CustomerID = 'ALFKI'

-- CROSS JOIN: Aralar�nda bir ili�ki bulunmayan tablolardan �zet kay�t k�mesi olu�turmak i�in kullan�l�r. Kartezyen �arp�m gibi �al���r.
SELECT * FROM Region
SELECT * FROM Categories

SELECT R.*, CAT.*
FROM Region R CROSS JOIN Categories CAT

