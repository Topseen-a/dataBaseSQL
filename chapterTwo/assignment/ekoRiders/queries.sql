USE lagosRideAnalytics;

-- 1. Top 5 highest-rated drivers in Lagos
SELECT d.DriverID, d.Name, d.Rating
FROM Drivers d
JOIN Rides r ON d.DriverID = r.DriverID
JOIN Riders ri ON r.RiderID = ri.RiderID
WHERE ri.City = 'Lagos'
GROUP BY d.DriverID, d.Name, d.Rating
ORDER BY d.Rating DESC
LIMIT 5;

-- 2. Riders with more than 5 rides in the last 30 days in Lagos
SELECT ri.RiderID, ri.Name, COUNT(r.RideID) AS TotalRides
FROM Riders ri
JOIN Rides r ON ri.RiderID = r.RiderID
WHERE ri.City = 'Lagos'
GROUP BY ri.RiderID, ri.Name
HAVING COUNT(r.RideID) > 5;

-- 3. Total revenue for the past month for Lagos rides
SELECT SUM(p.Amount) AS TotalRevenue
FROM Payments p
JOIN Rides r ON p.RideID = r.RideID
JOIN Riders ri ON r.RiderID = ri.RiderID
WHERE ri.City = 'Lagos';

-- 4. Area in Lagos with the most rides
SELECT ri.City AS Area, COUNT(r.RideID) AS TotalRides
FROM Riders ri
JOIN Rides r ON ri.RiderID = r.RiderID
GROUP BY ri.City
ORDER BY TotalRides DESC
LIMIT 1;

-- 5. Driver with the highest revenue in Lagos
SELECT d.DriverID, d.Name,
       SUM(p.Amount) AS TotalRevenue
FROM Drivers d
JOIN Rides r ON d.DriverID = r.DriverID
JOIN Payments p ON r.RideID = p.RideID
JOIN Riders ri ON r.RiderID = ri.RiderID
WHERE ri.City = 'Lagos'
GROUP BY d.DriverID, d.Name
ORDER BY TotalRevenue DESC
LIMIT 1;

-- 6. Find rides where the fare is more than 50% higher or lower than the average fare
SELECT RideID, Fare,
       (SELECT AVG(Fare) FROM Rides) AS AverageFare
FROM Rides
WHERE Fare > 1.5 * (SELECT AVG(Fare) FROM Rides)
   OR Fare < 0.5 * (SELECT AVG(Fare) FROM Rides);
   
-- 7. Find riders in Lagos who rated their drivers less than 3 on average
SELECT ri.RiderID, ri.Name,
       AVG(r.Rating) AS AverageRating
FROM Riders ri
JOIN Rides r ON ri.RiderID = r.RiderID
WHERE ri.City = 'Lagos'
GROUP BY ri.RiderID, ri.Name
HAVING AVG(r.Rating) < 3;


-- 8. Find the top 5 Lagos neighborhoods with the highest average fare
SELECT ri.City AS Area,
       AVG(r.Fare) AS AverageFare
FROM Riders ri
JOIN Rides r ON ri.RiderID = r.RiderID
GROUP BY ri.City
ORDER BY AverageFare DESC
LIMIT 5;

-- 9. Drivers in Lagos who have not received any rides in the last 30 days
SELECT d.DriverID, d.Name
FROM Drivers d
LEFT JOIN Rides r ON d.DriverID = r.DriverID
WHERE r.RideID IS NULL;

-- 10. Rides in Lagos with the longest distance (top 5)
SELECT r.RideID,
       r.DistanceKM,
       r.DriverID,
       r.RiderID
FROM Rides r
ORDER BY r.DistanceKM DESC
LIMIT 5;

-- 11. Find the number of rides each driver in Lagos has had, sorted by the most rides
SELECT d.DriverID,
       d.Name,
       COUNT(r.RideID) AS TotalRides
FROM Drivers d
LEFT JOIN Rides r ON d.DriverID = r.DriverID
GROUP BY d.DriverID, d.Name
ORDER BY TotalRides DESC;

-- 12. Identify the payment methods used by Lagos riders for rides over ₦50,000
SELECT PaymentMethod,
       COUNT(*) AS NumberOfTransactions
FROM Payments
WHERE Amount > 50000
GROUP BY PaymentMethod;

-- 13. Find rides in Lagos with a duration longer than 2 hours
SELECT r.RideID,
       r.DriverID,
       r.RiderID,
       r.DistanceKM,
       r.Duration
FROM Rides r
WHERE r.Duration > 120;









