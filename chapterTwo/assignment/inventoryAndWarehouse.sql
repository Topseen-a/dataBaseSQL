-- Write an SQL statement to display the SKU, SKU_Description, WarehouseID, WarehouseCity, and WarehouseState for all items stored in the Atlanta, Bangor, or Chicago warehouse. Do not use the IN keyword.
SELECT i.SKU, i.SKU_Description, w.WarehouseID, w.WarehouseCity, w.WarehouseState FROM INVENTORY i, WAREHOUSE w WHERE i.WarehouseID = w.WarehouseID AND (w.WarehouseCity = 'Atlanta' OR w.WarehouseCity = 'Bangor' OR w.WarehouseCity = 'Chicago');

-- Write an SQL statement to display the SKU, SKU_Description, WarehouseID, WarehouseCity, and WarehouseState for all items stored in the Atlanta, Bangor, or Chicago warehouse. Use the IN keyword.
SELECT i.SKU, i.SKU_Description, w.WarehouseID, w.WarehouseCity, w.WarehouseState FROM INVENTORY i JOIN WAREHOUSE w ON i.WarehouseID = w.WarehouseID WHERE w.WarehouseCity IN ('Atlanta', 'Bangor', 'Chicago');

-- Write an SQL statement to display the SKU, SKU_Description, WarehouseID, WarehouseCity, and WarehouseState of all items not stored in the Atlanta, Bangor, or Chicago warehouse. Do not use the NOT IN keyword.
SELECT i.SKU, i.SKU_Description, w.WarehouseID, w.WarehouseCity, w.WarehouseState FROM INVENTORY i JOIN WAREHOUSE w ON i.WarehouseID = w.WarehouseID WHERE w.WarehouseCity <> 'Atlanta' AND w.WarehouseCity <> 'Bangor' AND w.WarehouseCity <> 'Chicago';

-- Write an SQL statement to display the SKU, SKU_Description, WarehouseID, WarehouseCity, and WarehouseState of all items not stored in the Atlanta, Bangor, or Chicago warehouse. Use the NOT IN keyword.
SELECT i.SKU, i.SKU_Description, w.WarehouseID, w.WarehouseCity, w.WarehouseState FROM INVENTORY i JOIN WAREHOUSE w ON i.WarehouseID = w.WarehouseID WHERE w.WarehouseCity NOT IN ('Atlanta', 'Bangor', 'Chicago');

-- Write an SQL statement to produce a single column called ItemLocation that combines the SKU_Description, the phrase “is located in,” and WarehouseCity. Do not be concerned with removing leading or trailing blanks.
SELECT CONCAT(i.SKU_Description, ' is located in ', w.WarehouseCity) AS ItemLocation FROM INVENTORY i JOIN WAREHOUSE w ON i.WarehouseID = w.WarehouseID;

-- Write an SQL statement to show the SKU, SKU_Description, and WarehouseID for all items stored in a warehouse managed by ‘Lucille Smith’. Use a subquery.
SELECT SKU, SKU_Description, WarehouseID FROM INVENTORY WHERE WarehouseID IN (SELECT WarehouseID FROM WAREHOUSE WHERE Manager = 'Lucille Smith');

-- Write an SQL statement to show the SKU, SKU_Description, and WarehouseID for all items stored in a warehouse managed by ‘Lucille Smith’. Use a join, but do not use JOIN ON syntax.
SELECT i.SKU, i.SKU_Description, i.WarehouseID FROM INVENTORY i, WAREHOUSE w WHERE i.WarehouseID = w.WarehouseID AND w.Manager = 'Lucille Smith';

-- Write an SQL statement to show the WarehouseID and average QuantityOnHand of all items stored in a warehouse managed by ‘Lucille Smith’. Use a subquery.
SELECT WarehouseID, AVG(QuantityOnHand) AS AvgQuantityOnHand FROM INVENTORY WHERE WarehouseID IN ( SELECT WarehouseID FROM WAREHOUSE WHERE Manager = 'Lucille Smith') GROUP BY WarehouseID;

-- Write an SQL statement to show the WarehouseID and average QuantityOnHand of all items stored in a warehouse managed by ‘Lucille Smith’. Use a join using JOIN ON syntax.
SELECT i.WarehouseID, AVG(i.QuantityOnHand) AS AvgQuantityOnHand FROM INVENTORY i, WAREHOUSE w WHERE i.WarehouseID = w.WarehouseID AND w.Manager = 'Lucille Smith' GROUP BY i.WarehouseID;

-- Write an SQL statement to show the WarehouseID, WarehouseCity, WarehouseState, Manager, SKU, SKU_Description, and QuantityOnHand of all items stored in a ware- house managed by ‘Lucille Smith’. Use a join using JOIN ON syntax.
SELECT w.WarehouseID, w.WarehouseCity, w.WarehouseState, w.Manager, i.SKU, i.SKU_Description, i.QuantityOnHand FROM WAREHOUSE w JOIN INVENTORY i ON w.WarehouseID = i.WarehouseID WHERE w.Manager = 'Lucille Smith';

-- Write an SQL statement to show the WarehouseID, WarehouseCity, WarehouseState, Manager, SKU, SKU_Description, and QuantityOnHand of all items stored in a warehouse managed by ‘Lucille Smith’. Use a join using JOIN ON syntax.
SELECT w.WarehouseID, w.WarehouseCity, w.WarehouseState, w.Manager, i.SKU, i.SKU_Description, i.QuantityOnHand FROM WAREHOUSE w JOIN INVENTORY i ON w.WarehouseID = i.WarehouseID WHERE w.Manager = 'Lucille Smith';

-- Write an SQL statement to display the WarehouseID, the sum of QuantityOnOrder, and the sum of QuantityOnHand, grouped by WarehouseID and QuantityOnOrder. Name the sum of QuantityOnOrder as TotalItemsOnOrder and the sum of QuantityOnHand as TotalItemsOnHand. Use only the INVENTORY table in your SQL statement.
SELECT WarehouseID, QuantityOnOrder, SUM(QuantityOnOrder) AS TotalItemsOnOrder, SUM(QuantityOnHand) AS TotalItemsOnHand FROM INVENTORY GROUP BY WarehouseID, QuantityOnOrder;

-- Explain why you cannot use a subquery in your answer to Review Question 2.52.
-- You cannot use a subquery for review because the problem is not about filtering or selecting specific rows first, but about aggregation across the entire INVENTORY table grouped by categories.

-- Explain how subqueries and joins differ.
-- Subqueries and joins both combine data from tables, but they do it in very different ways and at different stages of query processing.

-- Write an SQL statement to join WAREHOUSE and INVENTORY and include all rows of WAREHOUSE in your answer, regardless of whether they have any INVENTORY. Include all columns of both tables, but do not repeat the join column.
SELECT w.*, i.* FROM WAREHOUSE w LEFT JOIN INVENTORY i ON w.WarehouseID = i.WarehouseID;













