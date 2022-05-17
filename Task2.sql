CREATE TABLE tblBook
(
	BookID int NOT NULL PRIMARY KEY IDENTITY(1,1),
	Name nvarchar(50)
)

CREATE TABLE tblBookInLibrary
(
	BookID int FOREIGN KEY REFERENCES tblBook(BookID),
	[Date] date
)

INSERT tblBook VALUES('Война и мир')
INSERT tblBook VALUES('Преступление и наказание')
INSERT tblBook VALUES('Мастер и Маргарита')
INSERT tblBook VALUES('Тихий дон')
INSERT tblBookInLibrary VALUES(1, '2006-05-01')
INSERT tblBookInLibrary VALUES(3, '2004-07-05')

--1)
SELECT Name,
	CASE
		WHEN '2005-02-01' <= tblBookInLibrary.Date
		THEN Date
		ELSE NULL
	END AS Date
FROM tblBook
LEFT JOIN tblBookInLibrary
ON tblBook.BookID = tblBookInLibrary.BookID

--2)
SELECT Name, Date
FROM tblBook
LEFT JOIN tblBookInLibrary
ON tblBook.BookID = tblBookInLibrary.BookID
WHERE ('2005-02-01' <= tblBookInLibrary.Date 
       OR tblBookInLibrary.Date IS NULL)
