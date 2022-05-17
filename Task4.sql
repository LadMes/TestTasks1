CREATE TABLE tblPeriod
(
	PeriodID int PRIMARY KEY,
	Value int
)

INSERT tblPeriod VALUES(1, 10)
INSERT tblPeriod VALUES(3, 10)
INSERT tblPeriod VALUES(5, 20)
INSERT tblPeriod VALUES(6, 20)
INSERT tblPeriod VALUES(7, 30)
INSERT tblPeriod VALUES(9, 40)
INSERT tblPeriod VALUES(10, 40)

WITH PeriodWithRowNumber AS
(
	SELECT *, ROW_NUMBER() OVER(PARTITION BY Value ORDER BY Value ASC) AS RowNumber
	FROM tblPeriod
)
SELECT PeriodID, Value
FROM PeriodWithRowNumber
WHERE RowNumber = 1

WITH PeriodWithRowNumber AS
(
	SELECT *, ROW_NUMBER() OVER(PARTITION BY Value ORDER BY Value ASC) AS RowNumber
	FROM tblPeriod
)
DELETE
FROM PeriodWithRowNumber
WHERE RowNumber <> 1
SELECT PeriodID, Value FROM tblPeriod
