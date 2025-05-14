create database PlsqlAssignment;
use PlsqlAssignment;

create table Book(book_id INT ,book_title VARCHAR(255),
book_price double,author_name varchar(255),
publication_house varchar(255),category varchar(255),status varchar(255));

INSERT INTO Book VALUES 
(1, 'The War Within', 299.99, 'John Doe', 'Mcgraw Hill', 'WAR', 'IN STOCK'),
(2, 'Dream Chronicles', 499.50, 'Jane Smith', 'DreamFolks', 'FICTION', 'IN STOCK'),
(3, 'Comedy Nights', 199.00, 'Charlie Ray', 'Warner Bros', 'COMEDY', 'OUT_OF_STOCK'),
(4, 'Sports Spirit', 349.75, 'Mary Joe', 'Mcgraw Hill', 'SPORTS', 'IN STOCK'),
(5, 'War and Peace', 599.00, 'Leo Tolstoy', 'DreamFolks', 'WAR', 'IN STOCK'),
(6, 'Laugh Out Loud', 249.99, 'Jim Bean', 'Warner Bros', 'COMEDY', 'IN STOCK'),
(7, 'Fictional Reality', 150.00, 'Ann White', 'DreamFolks', 'FICTION', 'OUT_OF_STOCK'),
(8, 'Match Day', 300.00, 'Ricky Ponting', 'Mcgraw Hill', 'SPORTS', 'IN STOCK'),
(9, 'War Tactics', 450.00, 'George Black', 'Warner Bros', 'WAR', 'IN STOCK'),
(10, 'Fiction Rewritten', 275.00, 'Samantha Lee', 'Mcgraw Hill', 'FICTION', 'OUT_OF_STOCK');


-- fetch book in stock and are less than input value
drop procedure proc_book_details;
delimiter $$
create procedure proc_book_details(IN price_value double)
BEGIN	
	select book_title as books_in_stock 
    from Book where status="IN STOCK" AND book_price < price_value;
END;
CALL proc_book_details(500);


-- Delete a book with respect to the given publication house .Not to enable safe mode 
delimiter $$
create procedure del_book(IN  pub_house VARCHAR(255))
BEGIN
	DELETE FROM Book Where publication_house=pub_house;
END;
CREATE INDEX idx_pub_house ON Book(publication_house);

CALL del_book('Mcgraw Hill');
SELECT * FROM Book ;

-- query to update the price of books by given percent based on given category.dont activate safe mode
delimiter $$
create procedure update_book_price(IN percent_inc double,IN in_category varchar(255))
BEGIN
		UPDATE Book SET book_price=book_price + (book_price * (percent_inc/100))
        WHERE category=in_category;
END;
CREATE INDEX idx_book_price ON Book(book_price);
CREATE INDEX idx_category ON Book(category);

CALL update_book_price(5,'COMEDY');
Select * from Book;


