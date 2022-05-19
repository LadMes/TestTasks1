CREATE TABLE Accounts
(
	CounterpartyID int PRIMARY KEY IDENTITY(1,1),
	[Name] varchar(255),
	IsActive bit
)

CREATE TABLE Trans
(
	TransID int PRIMARY KEY,
	TransDate date,
	RcvID int,
	SndID int,
	AssetID int,
	Quantity numeric (19, 8)
)

INSERT Accounts VALUES('Иванов', 1)
INSERT Accounts VALUES('Петров', 0)
INSERT Accounts VALUES('Сидоров', 1)

INSERT Trans VALUES(1, '2012-01-01', 1, 2, 1, 100)
INSERT Trans VALUES(2, '2012-01-02', 1, 3, 2, 150)
INSERT Trans VALUES(3, '2012-01-03', 3, 1, 1, 300)
INSERT Trans VALUES(4, '2012-01-04', 2, 1, 3, 50)

--1)
WITH TransWithRank AS
(
  SELECT DISTINCT RcvID, DENSE_RANK() OVER(PARTITION BY RcvID ORDER BY AssetID ASC) AS Rank
  FROM Trans
), TransWithRankAndCount AS
(
  SELECT DISTINCT RcvID, COUNT(Rank) OVER(PARTITION BY RcvID) AS Cnt
  FROM TransWithRank
)
SELECT CounterpartyID, Name, Cnt
FROM Accounts
JOIN TransWithRankAndCount
ON CounterpartyID = RcvID
WHERE IsActive = 1 AND Cnt > 1


--2)
WITH TransWithSUM AS
(
	SELECT RcvID, AssetID, SUM(Quantity) OVER(PARTITION BY RcvID, AssetID) AS Quantity
	FROM Trans
)
SELECT CounterpartyID, Name, AssetID, Quantity
FROM Accounts
JOIN TransWithSUM
ON CounterpartyID = RcvID
WHERE IsActive = 1


--3)
WITH TransAVGByDay AS
(
	SELECT DISTINCT RcvID, DAY(TransDate) AS TransDay, AVG(Quantity) OVER(PARTITION BY DAY(TransDate)) AS Oborot
	FROM Trans
)
SELECT CounterpartyID, Name, Oborot
FROM Accounts
JOIN TransAVGByDay
ON CounterpartyID = RcvID


--4)
WITH TransAVGByMonth AS
(
	SELECT DISTINCT RcvID, MONTH(TransDate) AS TransMonth, AVG(Quantity) OVER(PARTITION BY MONTH(TransDate)) AS Oborot
	FROM Trans
)
SELECT CounterpartyID, Name, Oborot
FROM Accounts
JOIN TransAVGByMonth
ON CounterpartyID = RcvID
