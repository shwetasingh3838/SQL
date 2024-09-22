
SELECT C.CustomerID, C.FirstName, C.LastName, SUM(O.TotalAmount) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY TotalSpent DESC
LIMIT 10;

select * from monthlysales;




CREATE VIEW MonthlySalesSummary AS
SELECT 
    DATE_FORMAT(o.OrderDate, '%Y-%m') AS Month,
    SUM(od.Quantity * od.PriceAtTimeOfOrder) AS TotalSales,
    AVG(od.Quantity * od.PriceAtTimeOfOrder) AS AverageSales
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE o.OrderDate >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY DATE_FORMAT(o.OrderDate, '%Y-%m');





DELIMITER //
CREATE PROCEDURE UpdateProductPrices(IN percentageIncrease DECIMAL(5, 2))
BEGIN
    -- Update product prices based on the percentage increase
    UPDATE Products
    SET Price = Price * (1 + (percentageIncrease / 100));
    
    -- Select updated product details to report changes
    SELECT ProductID, ProductName, Price
    FROM Products;
END //

DELIMITER ;



 *Orders Table*: Index on CustomerID to optimize joins between Orders and Customers.
- *OrderDetails Table*: Index on OrderID and ProductID to optimize joins.
- *Products Table*: Index on CategoryID and StockQuantity for faster queries related to stock and categories.