CREATE TABLE Functions (
    X INT,
    Y INT
);

INSERT INTO Functions (X, Y) VALUES
(20, 20),
(20, 25),
(21, 25),
(25, 26),
(26, 20);


SELECT F1.X, F1.Y
FROM Functions F1
INNER JOIN Functions F2
ON F1.X = F2.Y AND F2.X = F1.Y
WHERE F1.X <= F1.Y;

SELECT F1.X, F1.Y
FROM Functions F1
WHERE EXISTS (
    SELECT 1
    FROM Functions F2
    WHERE F1.X = F2.Y AND F1.Y = F2.X
)
AND F1.X <= F1.Y;

SELECT DISTINCT f1.X, f1.Y
FROM Functions f1
JOIN Functions f2 ON f1.X = f2.Y AND f1.Y = f2.X
WHERE f1.X <= f1.Y
ORDER BY f1.X;

SELECT F1.X, F1.Y
FROM Functions F1
WHERE EXISTS (
    SELECT 1
    FROM Functions F2
    WHERE F1.X = F2.Y AND F1.Y = F2.X
)
AND F1.X <= F1.Y;


SELECT X, Y, COUNT(*) AS count
FROM Functions
GROUP BY X, Y
ORDER BY count DESC;


SELECT DISTINCT
    f1.X,
    f1.Y
FROM
    Functions f1
JOIN
    Functions f2 ON f1.X = f2.Y AND f1.Y = f2.X
WHERE
    f1.X <= f1.Y -- To avoid duplicate pairs and handle X=Y cases
ORDER BY
    f1.X;

select * from Functions


SELECT
    F1.X,
    F1.Y
FROM
    Functions F1
INNER JOIN
    Functions F2 ON F1.X = F2.Y AND F1.Y = F2.X
WHERE
    F1.X <= F1.Y
GROUP BY
    F1.X,
    F1.Y
HAVING (COUNT(*) > 1 AND F1.X = F1.Y) OR (F1.X <> F1.Y)
ORDER BY
    F1.X;



WITH CTE AS (
  SELECT X, Y, ROW_NUMBER() OVER (ORDER BY X, Y) AS rn
  FROM Functions
)
SELECT DISTINCT f1.X, f1.Y
FROM CTE f1
JOIN CTE f2
  ON f1.X = f2.Y AND f1.Y = f2.X
WHERE f1.rn <> f2.rn    
  AND f1.X <= f1.Y      
ORDER BY f1.X, f1.Y;
