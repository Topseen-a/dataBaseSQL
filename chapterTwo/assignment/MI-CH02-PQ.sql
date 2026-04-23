-- A
SELECT * FROM ITEM;
SELECT * FROM SHIPMENT;
SELECT * FROM SHIPMENT_ITEM;

-- B
SELECT ShipmentID, ShipperName, ShipperInvoiceNumber
FROM SHIPMENT;

-- C
SELECT ShipmentID, ShipperName, ShipperInvoiceNumber
FROM SHIPMENT
WHERE InsuredValue > 10000;

-- D
SELECT ShipmentID, ShipperName, ShipperInvoiceNumber
FROM SHIPMENT
WHERE ShipperName LIKE 'AB%';

-- E
SELECT ShipmentID, ShipperName, ShipperInvoiceNumber, ArrivalDate
FROM SHIPMENT
WHERE MONTH(DepartureDate) = 12;

-- F
SELECT ShipmentID, ShipperName, ShipperInvoiceNumber, ArrivalDate
FROM SHIPMENT
WHERE DAY(DepartureDate) = 10;

-- G
SELECT MAX(InsuredValue) AS MaximumInsuredValue,
		MIN(InsuredValue) AS MinimumInsuredValue
FROM SHIPMENT;

-- H
SELECT AVG(InsuredValue) AS AvgValue
FROM SHIPMENT;

-- I
SELECT COUNT(*) AS TotalShipments
FROM SHIPMENT;

-- J
SELECT ItemID, Description, Store,
       LocalCurrencyAmount * ExchangeRate AS USCurrencyAmount
FROM ITEM;

-- K
SELECT City, Store
FROM ITEM
GROUP BY City, Store;

-- L
SELECT City, Store, COUNT(*) AS PurchaseCount
FROM ITEM
GROUP BY City, Store;

-- M
SELECT ShipperName, ShipmentID, DepartureDate
FROM SHIPMENT
WHERE ShipmentID IN (
    SELECT ShipmentID
    FROM SHIPMENT_ITEM
    WHERE Value >= 1000
)
ORDER BY ShipperName ASC, DepartureDate DESC;

-- N
SELECT DISTINCT s.ShipperName, s.ShipmentID, s.DepartureDate
FROM SHIPMENT s
JOIN SHIPMENT_ITEM si ON s.ShipmentID = si.ShipmentID
WHERE si.Value >= 1000
ORDER BY s.ShipperName ASC, s.DepartureDate DESC;

-- O
SELECT ShipperName, ShipmentID, DepartureDate
FROM SHIPMENT
WHERE ShipmentID IN (
    SELECT si.ShipmentID
    FROM SHIPMENT_ITEM si
    WHERE si.ItemID IN (
        SELECT ItemID
        FROM ITEM
        WHERE City = 'Singapore'
    )
)
ORDER BY ShipperName ASC, DepartureDate DESC;

-- P
SELECT DISTINCT s.ShipperName, s.ShipmentID, s.DepartureDate
FROM SHIPMENT s, SHIPMENT_ITEM si, ITEM i
WHERE s.ShipmentID = si.ShipmentID
AND si.ItemID = i.ItemID
AND i.City = 'Singapore'
ORDER BY s.ShipperName ASC, s.DepartureDate DESC;

-- Q
SELECT DISTINCT s.ShipperName, s.ShipmentID, s.DepartureDate
FROM SHIPMENT s
JOIN SHIPMENT_ITEM si ON s.ShipmentID = si.ShipmentID
JOIN ITEM i ON si.ItemID = i.ItemID
WHERE i.City = 'Singapore'
ORDER BY s.ShipperName ASC, s.DepartureDate DESC;

-- R
SELECT s.ShipperName, s.ShipmentID, s.DepartureDate, si.Value
FROM SHIPMENT s
JOIN SHIPMENT_ITEM si ON s.ShipmentID = si.ShipmentID
WHERE si.ItemID IN (
    SELECT ItemID
    FROM ITEM
    WHERE City = 'Singapore'
)
ORDER BY s.ShipperName ASC, s.DepartureDate DESC;

-- S
SELECT s.ShipperName, s.ShipmentID, s.DepartureDate, si.Value
FROM SHIPMENT s
LEFT JOIN SHIPMENT_ITEM si ON s.ShipmentID = si.ShipmentID
LEFT JOIN ITEM i ON si.ItemID = i.ItemID
ORDER BY si.Value ASC, s.ShipperName ASC, s.DepartureDate DESC;