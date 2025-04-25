mysql> CREATE TABLE books (
    ->     book_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     title VARCHAR(100),
    ->     author VARCHAR(50),
    ->     genre VARCHAR(30),
    ->     available BOOLEAN DEFAULT TRUE
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> CREATE TABLE members (
    ->     member_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     name VARCHAR(50),
    ->     email VARCHAR(100),
    ->     join_date DATE
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> CREATE TABLE borrow_records (
    ->     record_id INT AUTO_INCREMENT PRIMARY KEY,
    ->     member_id INT,
    ->     book_id INT,
    ->     borrow_date DATE,
    ->     return_date DATE,
    ->     FOREIGN KEY (member_id) REFERENCES members(member_id),
    ->     FOREIGN KEY (book_id) REFERENCES books(book_id)
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql> INSERT INTO books (title, author, genre) VALUES
    -> ('SQL Fundamentals', 'John Smith', 'Education'),
    -> ('Learn MySQL', 'Jane Doe', 'Education'),
    -> ('Harry Potter', 'J.K. Rowling', 'Fiction');
Query OK, 3 rows affected (0.02 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO members (name, email, join_date) VALUES
    -> ('Alice', 'alice@gmail.com', '2023-01-10'),
    -> ('Bob', 'bob@yahoo.com', '2023-03-15');
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO borrow_records (member_id, book_id, borrow_date, return_date) VALUES
    -> (1, 1, '2023-05-01', NULL),
    -> (2, 3, '2023-05-02', '2023-05-12');
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> SELECT members.name, books.title, borrow_date, return_date
    -> FROM borrow_records
    -> JOIN members ON borrow_records.member_id = members.member_id
    -> JOIN books ON borrow_records.book_id = books.book_id;
+-------+------------------+-------------+-------------+
| name  | title            | borrow_date | return_date |
+-------+------------------+-------------+-------------+
| Alice | SQL Fundamentals | 2023-05-01  | NULL        |
| Bob   | Harry Potter     | 2023-05-02  | 2023-05-12  |
+-------+------------------+-------------+-------------+
2 rows in set (0.01 sec)

mysql>
mysql> -- Show books that are available
mysql> SELECT * FROM books WHERE available = TRUE;
+---------+------------------+--------------+-----------+-----------+
| book_id | title            | author       | genre     | available |
+---------+------------------+--------------+-----------+-----------+
|       1 | SQL Fundamentals | John Smith   | Education |         1 |
|       2 | Learn MySQL      | Jane Doe     | Education |         1 |
|       3 | Harry Potter     | J.K. Rowling | Fiction   |         1 |
+---------+------------------+--------------+-----------+-----------+
3 rows in set (0.00 sec)

mysql>
mysql> -- Count how many books each member has borrowed
mysql> SELECT members.name, COUNT(*) AS books_borrowed
    -> FROM borrow_records
    -> JOIN members ON borrow_records.member_id = members.member_id
    -> GROUP BY members.name;
+-------+----------------+
| name  | books_borrowed |
+-------+----------------+
| Alice |              1 |
| Bob   |              1 |
+-------+----------------+
2 rows in set (0.00 sec)