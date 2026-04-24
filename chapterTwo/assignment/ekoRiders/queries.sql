USE lagosRideAnalytics;

-- 1. Top 5 highest-rated drivers in Lagos
SELECT DriverID, Name, Rating
FROM Drivers
ORDER BY Rating DESC
LIMIT 5;

-- 2. Riders with more than 5 rides in the last 30 days in Lagos
SELECT r.RiderID, r.Name, COUNT(rd.RideID) AS TotalRides
FROM Riders r
JOIN Rides rd ON r.RiderID = rd.RiderID
GROUP BY r.RiderID, r.Name
HAVING COUNT(rd.RideID) > 5;

-- 3. Total revenue for the past month for Lagos rides
SELECT SUM(Amount) AS TotalRevenue
FROM Payments;

-- 4. Area in Lagos with the most rides
SELECT r.City AS Area, COUNT(rd.RideID) AS TotalRides
FROM Riders r
JOIN Rides rd ON r.RiderID = rd.RiderID
GROUP BY r.City
ORDER BY TotalRides DESC
LIMIT 1;

-- -- 5. Driver with the highest revenue in Lagos
SELECT d.DriverID, d.Name, SUM(p.Amount) AS TotalRevenue
FROM Drivers d
JOIN Rides r ON d.DriverID = r.DriverID
JOIN Payments p ON r.RideID = p.RideID
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
SELECT r.RiderID, r.Name, AVG(rd.Rating) AS AverageRating
FROM Riders r
JOIN Rides rd ON r.RiderID = rd.RiderID
GROUP BY r.RiderID, r.Name
HAVING AVG(rd.Rating) < 3;

-- 8. Find the top 5 Lagos neighborhoods with the highest average fare
SELECT r.City AS Area, AVG(rd.Fare) AS AverageFare
FROM Riders r
JOIN Rides rd ON r.RiderID = rd.RiderID
GROUP BY r.City
ORDER BY AverageFare DESC
LIMIT 5;

-- 9. Drivers in Lagos who have not received any rides in the last 30 days
SELECT d.DriverID, d.Name
FROM Drivers d
LEFT JOIN Rides r ON d.DriverID = r.DriverID
WHERE r.RideID IS NULL;

-- 10. Rides in Lagos with the longest distance (top 5)
SELECT RideID, DistanceKM, DriverID, RiderID
FROM Rides
ORDER BY DistanceKM DESC
LIMIT 5;

-- 11. Find the number of rides each driver in Lagos has had, sorted by the most rides
SELECT DriverID, COUNT(*) AS TotalRides
FROM Rides
GROUP BY DriverID
ORDER BY TotalRides DESC;

-- 12. Identify the payment methods used by Lagos riders for rides over ₦50,000
SELECT PaymentMethod, COUNT(*) AS NumberOfTransactions
FROM Payments
WHERE Amount > 50000
GROUP BY PaymentMethod;

-- 13. Find rides in Lagos with a duration longer than 2 hours
SELECT RideID, Duration, DriverID
FROM Rides
WHERE Duration > 120;









