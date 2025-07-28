/*NorthWindDB - CTE */
CREATE TABLE CityData (
    CityID INT PRIMARY KEY,
    CityName VARCHAR(100)
);


CREATE TABLE CityRoutes (
    RouteID INT PRIMARY KEY,
    SourceCityID INT,
    DestinationCityID INT,
    Distance INT,
    FOREIGN KEY (SourceCityID) REFERENCES CityData(CityID),
    FOREIGN KEY (DestinationCityID) REFERENCES CityData(CityID)
);


INSERT INTO CityData (CityID, CityName) VALUES
(1, 'Chennai'),
(2, 'Bangalore'),
(3, 'Hyderabad'),
(4, 'Pune'),
(5, 'Mumbai'),
(6, 'Nagpur');


INSERT INTO CityRoutes (RouteID, SourceCityID, DestinationCityID, Distance) VALUES
(101, 3, 1, 630),   -- Hyderabad -> Chennai
(102, 3, 2, 570),   -- Hyderabad -> Bangalore
(103, 2, 4, 850),   -- Bangalore -> Pune
(104, 1, 5, 1330),  -- Chennai -> Mumbai
(105, 4, 5, 150),   -- Pune -> Mumbai
(106, 5, 6, 810);   -- Mumbai -> Nagpur

/*
select * from CityRoutes;
select * from CityData;
*/
WITH Recursive Destinations AS (
    SELECT
        RouteID,
        SourceCityID,
        DestinationCityID,
        CAST(CityName AS VARCHAR(20)) AS Route,
        Distance
    FROM CityRoutes CR
    INNER JOIN CityData CD ON CR.SourceCityID = CD.CityID

    UNION ALL

    SELECT
        CR.RouteID,
        CR.SourceCityID,
        CR.DestinationCityID,
       CAST(R.Route || ' -> ' || CD.CityName AS VARCHAR(20)),

        R.Distance + CR.Distance
    FROM Destinations R
    INNER JOIN CityRoutes CR ON R.DestinationCityID = CR.SourceCityID
    INNER JOIN CityData CD ON CR.DestinationCityID = CD.CityID
)
SELECT Route, Distance
FROM Destinations
WHERE SourceCityID = 2; 
