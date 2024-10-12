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

-- Tablolardan bazý datalarý sileceðiz ama ana tablolarý etkilememek için temp table'da yapacaðýz iþlemleri

SELECT * into #tmpOrders FROM Orders
SELECT * into #tmpOrderDetails FROM [Order Details]

SELECT * FROM #tmpOrders
SELECT * FROM #tmpOrderDetails

-- Eþleþmeyen data elde etmek için: 
-- OrderId yokken OrderDetail yer almasý için
DELETE #tmpOrders WHERE OrderID IN (10248, 10249, 10250)
-- OrderId varken OrderDetail olmamasý için
DELETE #tmpOrderDetails WHERE OrderID IN (10251, 10252, 10253)
*/
 
-- INNER JOIN: Her iki tabloda eþleþen kayýtlarý getirir 
SELECT * into #tmpOrders FROM Orders
SELECT * into #tmpOrderDetails FROM [Order Details]

SELECT O.OrderID, O.OrderDate, OD.ProductID, OD.Quantity, OD.UnitPrice, OD.Discount
FROM #tmpOrders O INNER JOIN #tmpOrderDetails OD
ON O.OrderID = OD.OrderID
WHERE O.OrderID = 10273 -- 10248'i bulamazdý örneðin

SELECT O.*, OD.*
FROM #tmpOrders O INNER JOIN #tmpOrderDetails OD
ON O.OrderID = OD.OrderID
WHERE O.OrderID IN (10273, 10248,10249,10250,10251,10252,10253, 10255)

-- LEFT OUTER JOIN: Birinci tabloda olan tüm kayýtlarý ikinci tabloda eþleþen kayýt olmasa da getir.
SELECT * FROM #tmpOrders -- ORDER BY OrderID demen gerekebilir

SELECT O.OrderID, O.OrderDate, OD.ProductID, OD.Quantity, OD.UnitPrice, OD.Discount
FROM #tmpOrders O LEFT JOIN #tmpOrderDetails OD
ON O.OrderID = OD.OrderID
ORDER BY OrderID

-- RIGHT OUTER JOIN: Ýkinci tabloda olan tüm kayýtlarý birinci tabloda eþleþen kayýt olmasa da getir.
SELECT * FROM #tmpOrderDetails

SELECT O.OrderID, O.OrderDate, OD.*
FROM #tmpOrders O RIGHT JOIN #tmpOrderDetails OD
ON O.OrderID = OD.OrderID

-- FULL OUTER JOIN: Her iki tabloda eþleþen eþleþmeyen tüm kayýtlarý getirir.
SELECT O.OrderID, OD.*
FROM #tmpOrders O FULL OUTER JOIN #tmpOrderDetails OD
ON O.OrderID = OD.OrderID
ORDER BY O.OrderID

DROP TABLE #tmpOrders
DROP TABLE #tmpOrderDetails

-- ÝKÝ TABLO INNER JOIN
SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM Employees

SELECT C.CustomerID, C.CompanyName, C.ContactTitle, O.OrderID, O.OrderDate
FROM Customers C INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
WHERE C.CustomerID = 'ALFKI'
ORDER BY O.OrderID

-- ÜÇ TABLO INNER JOIN
SELECT C.CustomerID, C.CompanyName, C.ContactTitle, O.OrderID, O.OrderDate, E.EmployeeID, E.FirstName, E.LastName
FROM Customers C 
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN Employees E ON O.EmployeeID = E.EmployeeID
WHERE C.CustomerID = 'ALFKI'

-- DÖRT TABLO INNER JOIN
SELECT C.CustomerID, C.CompanyName, C.ContactName, O.OrderID, O.OrderDate, E.EmployeeID, E.FirstName, E.LastName, OD.ProductID, OD.Quantity, OD.UnitPrice, OD.Discount
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
INNER JOIN Employees E ON O.EmployeeID = E.EmployeeID
INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
WHERE C.CustomerID = 'ALFKI'

-- BEÞ TABLO INNER JOIN
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

-- INNER JOIN Farklý Bir Kullaným:
SELECT O.*, OD.*, C.*
FROM Orders O, [Order Details] OD, Customers C
WHERE O.OrderID = OD.OrderID AND O.CustomerID = C.CustomerID AND C.CustomerID = 'ALFKI'

-- CROSS JOIN: Aralarýnda bir iliþki bulunmayan tablolardan özet kayýt kümesi oluþturmak için kullanýlýr. Kartezyen çarpým gibi çalýþýr.
SELECT * FROM Region
SELECT * FROM Categories

SELECT R.*, CAT.*
FROM Region R CROSS JOIN Categories CAT

