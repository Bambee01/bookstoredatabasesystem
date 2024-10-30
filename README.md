# Bookstore Database System

This SQL Server script creates a relational database for a bookstore management system. The database includes tables to store information about books, authors, publishers, customers, orders, shipping methods, and more.

## Database Schema

![erd-gravity.png](erd-gravity.png)

The script defines the following tables:

1. **BookTable**
    - Stores details of each book.
    - Fields:
        - `book_id`: INT, Primary Key
        - `tittle`: VARCHAR(100), Book title
        - `isnb`: INT, International Standard Book Number
        - `language_id`: INT, Foreign Key to `booklanguage`
        - `number_pages`: INT, Total number of pages
        - `publications_date`: DATE, Date of publication
        - `publisher_id`: INT, Foreign Key to `PUBLISHER`
2. **PUBLISHER**
    - Stores information about book publishers.
    - Fields:
        - `publisher_id`: INT, Primary Key
        - `publisher_name`: VARCHAR(100)
3. **BookAutors**
    - Links books to their authors.
    - Fields:
        - `book_id`: INT, Foreign Key to `BookTable`
        - `author_id`: INT, Foreign Key to `author`
4. **author**
    - Stores author information.
    - Fields:
        - `author_id`: INT, Primary Key
        - `author_name`: VARCHAR(100)
5. **booklanguage**
    - Stores language details for books.
    - Fields:
        - `language_id`: INT, Primary Key
        - `language_code`: VARCHAR(100)
        - `language_name`: VARCHAR(100)
6. **customer**
    - Stores customer information.
    - Fields:
        - `customer_id`: INT, Primary Key
        - `first_name`: VARCHAR(50)
        - `last_name`: VARCHAR(50)
        - `email`: VARCHAR(100)
7. **country**
    - Stores country names.
    - Fields:
        - `country_id`: INT, Primary Key
        - `country_name`: VARCHAR(100)
8. **address**
    - Stores address details for customers.
    - Fields:
        - `address_id`: INT, Primary Key
        - `street_number`: INT
        - `street_name`: VARCHAR(100)
        - `city`: VARCHAR(100)
        - `country_id`: INT, Foreign Key to `country`
9. **addressStatus**
    - Stores address status.
    - Fields:
        - `status_id`: INT, Primary Key
        - `address_status`: VARCHAR(100)
10. **customer_address**
    - Links customers to their addresses.
    - Fields:
        - `customer_id`: INT, Foreign Key to `customer`
        - `address_id`: INT, Foreign Key to `address`
        - `status_id`: INT, Foreign Key to `addressStatus`
11. **orderStatus**
    - Stores order status values.
    - Fields:
        - `status_id`: INT, Primary Key
        - `status_value`: VARCHAR(200)
12. **shippingMethod**
    - Stores available shipping methods.
    - Fields:
        - `method_id`: INT, Primary Key
        - `method_name`: VARCHAR(150)
        - `cost`: DECIMAL
13. **custorder**
    - Stores order details.
    - Fields:
        - `order_id`: INT, Primary Key
        - `order_date`: DATETIME
        - `customer_id`: INT, Foreign Key to `customer`
        - `shipping_method_id`: INT, Foreign Key to `shippingMethod`
        - `dest_address_id`: INT, Foreign Key to `address`
14. **orderLine**
    - Stores individual items within orders.
    - Fields:
        - `line_id`: INT, Primary Key
        - `order_id`: INT, Foreign Key to `custorder`
        - `book_id`: INT, Foreign Key to `BookTable`
        - `price`: DECIMAL
15. **orderHistory**
    - Tracks changes in order status over time.
    - Fields:
        - `history_id`: INT, Primary Key
        - `order_id`: INT, Foreign Key to `custorder`
        - `status_id`: INT, Foreign Key to `orderStatus`
        - `status_date`: DATE

## Usage

To initialize the database, run this script in SQL Server. Each table has the necessary constraints, such as primary and foreign keys, to enforce data integrity.

Use `SELECT` queries to retrieve information from each table, as illustrated in the script with example queries for `BookTable` and `PUBLISHER`.

---

## Stored Procedures

The script includes three stored procedures to simplify data insertion and management in the bookstore database:

1. **insertBookDataWithDuplicateCheck**
    - Inserts a new book, along with its associated publisher and author information, into the database.
    - **Parameters:**
        - `@bookTitle`: Title of the book.
        - `@pages`: Number of pages in the book.
        - `@publicationDate`: Publication date of the book.
        - `@publisherName`: Name of the publisher.
        - `@authorName`: Name of the author.
    - **Functionality:**
        - Checks if the specified publisher and author exist. If not, it creates new entries for them.
        - Automatically generates `book_id`, `publisher_id`, and `author_id` based on the maximum ID value in their respective tables.
        - Inserts a new record into the `BookAutors` table to link the book with its author.
2. **addNewCustomer**
    - Adds a new customer, along with their address, to the database.
    - **Parameters:**
        - `@first_name`, `@last_Name`, `@email`: Customer's personal information.
        - `@street_number`, `@street_name`, `@city`: Customer's address details.
        - `@country_name`: Name of the country for the customer's address.
    - **Functionality:**
        - Checks if the specified country exists in the `country` table and creates it if it does not.
        - Automatically generates a unique `customer_id` and `address_id`.
        - Inserts the new customer information into the `customer` and `address` tables.
        - Links the customer with their address in the `customer_address` table.
3. **addNewAddressForOldCustomer**
    - Adds an additional address for an existing customer and updates the address status.
    - **Parameters:**
        - `@customer_id`: Unique identifier of the customer.
        - `@street_number`, `@street_name`, `@city`: Details of the new address.
        - `@country_name`: Name of the country for the new address.
    - **Functionality:**
        - Verifies if the customer exists and checks if the specified country exists; if not, it creates a new country entry.
        - Generates a new `address_id` for the additional address.
        - Updates the current address status of the customer in the `customer_address` table to inactive (`status_id = 2`) and sets the new address as active (`status_id = 1`).
        - Prints an error message if the customer ID does not exist.

---

These stored procedures streamline data input and maintain consistency by managing primary and foreign key relationships across the database.

---
