--CREATE DATABASE --
CREATE DATABASE OnlineBookstore;


--create table  BOOKS TABLE1--
DROP TABLE IF EXISTS Books;
CREATE TABLE Books(
Book_id INT PRIMARY KEY,
Title VARCHAR(100) NOT NULL,
Author VARCHAR(100),
Genre VARCHAR(100),
Published_year INT,
Price NUMERIC(10,2),
Stock INT
);

SELECT * FROM Books;


COPY Books(Book_id, Title, Author, Genre, Published_year, Price, Stock)
FROM 'C:\Program Files\PostgreSQL\18\data\Books.csv'
DELIMITER ','
CSV HEADER;

--DATE STYLE--
SET datestyle = 'ISO, MDY';

--CREATE TABLE CUSTOMERS TABLE2 --

CREATE TABLE customers(
Customer_id INT PRIMARY KEY,
Name VARCHAR(100) NOT NULL,
Email VARCHAR(100),
Phone INT, 
City VARCHAR(100),
Country VARCHAR(100)
);

SELECT * FROM customers;

--import csv table2--
COPY customers(Customer_id, Name, Email, Phone, City, Country)
FROM 'C:\Program Files\PostgreSQL\18\data\Customers.csv'
DELIMITER ','
CSV HEADER;

--DATE STYLE--
SET datestyle = 'ISO, MDY';

DROP TABLE customers_table2;


--CREATE TABLE 
CREATE TABLE Orders(
Order_id INT PRIMARY KEY, 
Customer_id INT REFERENCES Customers(Customer_id),
Books_id INT REFERENCES Books(Book_id),
Order_date DATE, 
Quantity INT,
Total_amount NUMERIC(10,2)
);

SELECT * FROM Orders;

DROP TABLE Orders;

--IMPORT CSV FILE TABLE3 --
COPY Orders (Order_id, Customer_id, Books_id, Order_date, Quantity, Total_amount)
FROM 'C:\Program Files\PostgreSQL\18\data\Orders.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM Books;
SELECT * FROM customers;
SELECT * FROM Orders;


--QUE 1 RETRIVE ALL BOOKS IN THE 'FICTION' GENRE--

SELECT * FROM Books
WHERE Genre = 'Fiction';

--QUE 2 FIND BOOKS PUNLISHED AFTER THE YEAR 1950--

SELECT * FROM Books
WHERE published_year > 1950;

--QUE 3 LIST ALL CUSTOMERS FROM CANADA--

SELECT * FROM customers
WHERE country = 'Canada';

--QUE 4 SHOW ORDERS PLACED IN NOV 2023--

SELECT * FROM Orders
WHERE Order_Date BETWEEN  '11/01/2023' AND '11/30/2023';

--QUE 5 RETRIVE THE TOTAL STOCK OF BOOKS AVAILABLE --

SELECT SUM(Stock) AS Total_Stock
FROM Books;

--QUE 6 FIND THE DETAILS OF THE MOST EXPENSIVE BOOKS--

SELECT * FROM Books
WHERE Price = (SELECT MAX(Price)
FROM Books);

--QUE 7 SHOW ALL CUSTOMERS WHOS ORDER MORE THAN 1 QUANTITY OF BOOK--

SELECT c.Customer_id, c.Name, c.Email, c.Phone, c.City, c.Country, o.Quantity
FROM customers c
JOIN
orders o
ON c.customer_id = o.customer_id
WHERE o.Quantity >1;

--QUE 8 RETRIVE ALL ORDERS WHERE THE TOTAL AMOUNT EXCEEDS $20--

SELECT * FROM Orders
WHERE Total_Amount > 20;

--	QUE 9 LIST ALL GENRE AVAILABLE IN THE BOOKS TABLE--

SELECT DISTINCT Genre
FROM Books;

-- QUE 10 FIND THE BOOK WITH LOWEST STOCK--

SELECT * FROM Books
WHERE stock = (SELECT MIN(Stock)
FROM Books);

--QUE 11 CALCULATE TOTAL REVENUE GENERATED FROM ALL ORDERS--

SELECT SUM(Total_amount) AS Total_revenue
FROM Orders;

--QUE 12 RETRIVE THE TOTAL NUMBER OF BOOKS SOLD FOR EACH GENRE --

SELECT b.genre, SUM(o.Quantity) AS Total_books_sold
FROM Books b
JOIN
Orders o
ON b.book_id = o.books_id
GROUP BY genre;

--QUE 13 FIND THE AVERAGE PRICE OF BOOKS IN THE 'FANTASY' GENRE

SELECT AVG(price) AS AVG_PRICE
FROM Books
WHERE genre = 'Fantasy';

--QUE 14 LIST CUSTOMERS WHO HAVE PLACE ATLEAST 2 ORDERS--

SELECT 
    c.Customer_id, 
    c.Name, 
	c.Email,
    COUNT(o.quantity) AS Total_Orders_Placed
FROM Customers c
JOIN 
Orders o
ON c.Customer_id = o.Customer_id
GROUP BY c.Customer_id, c.Name, c.Email
HAVING COUNT(o.quantity) >= 2;

--QUE 15 FIND THE MOST FREQUANTLY ORDER BOOK--

SELECT b.book_id, b.title, b.author,
COUNT(o.quantity) AS Times_ordered
FROM books b
JOIN
orders o
ON b.book_id = o.books_id
GROUP BY b.book_id, b.title, b.author
ORDER BY Times_ordered DESC
LIMIT 1;

--QUE 16 SHOW THE TOP 3 MOST EXPENSIVE BOOKS OF 'FANTASY' GENRE

SELECT * FROM Books
WHERE Genre = 'Fantasy'
ORDER BY price DESC
LIMIT 3;

--QUE 17 RETRIVE THE TOTAL QUANTITY OF BOOKS SOLD BY EACH AUTHOR --

SELECT 
    b.Author, 
    SUM(o.Quantity) AS Total_Books_Sold
FROM Books b
JOIN Orders o ON b.Book_id = o.Books_id
GROUP BY b.Author
ORDER BY Total_Books_Sold DESC;

--QUE 18 LIST THE CITIES WHERE CUSTOMERS WHO SPENT OVER $30 ARE LOCATED--

SELECT DISTINCT c.City, c.customer_id
FROM Customers c
JOIN Orders o ON c.Customer_id = o.Customer_id
WHERE o.Total_amount > 30;

--QUE 19 FIND THE CUSTOMERS WHO SPENT THE MOST ON ORDERS--

SELECT 
    c.Customer_id, 
    c.Name, 
    c.Email, 
    SUM(o.Total_amount) AS Total_Spent
FROM Customers c
JOIN Orders o ON c.Customer_id = o.Customer_id
GROUP BY c.Customer_id, c.Name, c.Email
ORDER BY Total_Spent DESC
LIMIT 1;


--QUE 20 CALCULATE THE STOCK REMAINING AFTER FULFILLING ALL ORDERS--

SELECT 
    b.Book_id,
    b.Title,
    b.Stock AS Initial_Stock,
    COALESCE(SUM(o.Quantity), 0) AS Total_Sold,
    (b.Stock - COALESCE(SUM(o.Quantity), 0)) AS Remaining_Stock
FROM Books b
LEFT JOIN Orders o ON b.Book_id = o.Books_id
GROUP BY b.Book_id, b.Title, b.Stock
ORDER BY Remaining_Stock ASC;





