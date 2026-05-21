CREATE DATABASE onlinebookstore;

USE onlinebookstore;

CREATE TABLE BOOKS( 
Book_ID	INT	PRIMARY KEY , 
Title	VARCHAR (100) ,	
Author	VARCHAR (100) ,	
Genre	VARCHAR (50) ,	
Published_Year	INT,	
Price	NUMERIC(10, 2) ,	
Stock	INT	);

CREATE TABLE CUSTOMERS(
Customer_ID	VARCHAR(100),
Name	VARCHAR(100),
Email	VARCHAR(15),
Phone	VARCHAR(20),
City	VARCHAR(50),
Country	VARCHAR(150));

CREATE TABLE ORDERS(
Order_ID INT PRIMARY KEY, 
Customer_ID	INT  REFERENCES  CUSTOMERS (Order_ID),	
Book_ID	INT  REFERENCES BOOKS  (Book_ID),	
Order_Date	DATE,	
Quantity INT,	
Total_Amount NUMERIC (10, 2));	

SELECT * from books;

select * from customers;

select * from orders;

-- 1) Retrieve all books in the "Fiction" genre:

select * from books where genre = "Fiction";


-- 2). Find books published after the year 1950: 

select * from books where published_year >1950;


-- 3) List all the customers from Canada: 

select * from customers where country = "Canada" ;


-- 4) Show orders placed in November 2023: 

select * from orders where Order_date between '01-11-2023' and '30-11-2023';



-- 5) Retrieve the total stock of books available: 

select SUM(stock) as Total_Stock from books;


-- 6) Find the details of the most expensive book: 

select * from books order by Price desc limit 1;


-- 7) Show all customers who ordered more than 1 quantity of a book: 

Select * FROM ORDERS WHERE quantity > 1;


-- 8) Retrieve all orders where the total amount exceeds $20: 

select * from orders where total_amount>20;

-- 9) List all genre available in the bokks table: 

select distinct genre from books;

-- 10) Find the book with the lowest stock: 

select * from books order by stock asc limit 1;

-- 11) Calculate the total revenue generated from all orders: 

select SUM(total_amount) as revenue from orders ;



-- ADVANCE QUESTIONS : 



-- 1) Retrieve the total number of books sold for each genre :

select b.genre, sum(o.quantity) as total_books_sold
from orders o join books b 
on o.book_id = b.book_id
group by b.genre;


-- 2)	Find the average price of books in the "Fantasy" genre: 

select avg(price) as average_price 
from books where genre = 'Fantasy';


-- 3) List customers who have placed at least 2 orders: 

SELECT customer_id, COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) >= 2;

-- 4)	Find the most frequently ordered book: 

SELECT book_id, COUNT(order_id) AS order_count
FROM orders
GROUP BY book_id
ORDER BY order_count DESC;

-- 5)	Show the top 3 most expensive books of 'Fantasy' Genre:

select * from books where genre = 'fantasy' order by price desc limit 3;


-- 6)	Retrieve the total quantity of books sold by each author: 

select b.author, sum(o.quantity) as total_books_sold
from orders o join books b 
on o.book_id = b.book_id 
group by author;

-- 7) List the cities where customers who spent over $30 are located: 

select distinct c.city, total_amount
from orders o join customers c 
on o.customer_id = c.customer_id 
where o.total_amount> 30;

-- 8)	Find the customer who spent the most on orders: 

select c.customer_id, c.name, sum(o.total_amount) as total_spent
from orders o join customers c 
on o.customer_id = c.customer_id 
group by c.customer_id, c.name
order by total_spent desc limit 2;

-- 9)	Calculate the stock remaining after fulfilling all orders: 

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(quantity), 0) AS order_quantity, 
b.stock - COALESCE(SUM(quantity), 0) as remaining_quantity
FROM books b
LEFT JOIN orders o
ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock;















