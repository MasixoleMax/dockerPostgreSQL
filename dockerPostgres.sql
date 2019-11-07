/*******************************************************************/
                         CREATING A DATABASE
/*******************************************************************/

/**************[INSTRUCTIONS, COMMANDS & RESULTS]*******************/

 1) Create a database called “Umuzi”. -------------------------------------------------INSTRUCTION.
    CREATE DATABASE umuzi;  -----------------------------------------------------------COMMAND.
                                List of databases  ------------------------------------RESULT.
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges   
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 umuzi     | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
(4 rows)


 2) Create the following tables in the Umuzi database:  ----------------------------------INSTRUCTION.
        Customers
        Employees
        Orders
        Payments
        Products
    CREATE TABLE customers(customerid SERIAL PRIMARY KEY, firstname CHAR(50) NOT NULL, lastname CHAR(50) NOT NULL, gender VARCHAR NOT NULL,  address CHAR(200) NOT NULL, phone BIGINT NOT NULL, email CHAR(100) NOT NULL, city CHAR(50) NOT NULL, country CHAR(50) NOT NULL); --COMMAND.
   #\d tabel_name; -----------------------------------------------------------------------COMMAND.
                                          Table "public.customers" -----------------------ALL TABLES RESULTS.
   Column   |       Type        | Collation | Nullable |                    Default                    
------------+-------------------+-----------+----------+-----------------------------------------------
 customerid | integer           |           | not null | nextval('customers_customerid_seq'::regclass)
 firstname  | character(50)     |           | not null | 
 lastname   | character(50)     |           | not null | 
 gender     | character varying |           | not null | 
 address    | character(200)    |           | not null | 
 phone      | bigint            |           | not null | 
 email      | character(100)    |           | not null | 
 city       | character(50)     |           | not null | 
 country    | character(50)     |           | not null | 
Indexes:
    "customers_pkey" PRIMARY KEY, btree (customerid)
Referenced by:
    TABLE "payments" CONSTRAINT "payments_customerid_fkey" FOREIGN KEY (customerid) REFERENCES customers(customerid)

 Table "public.employees"
   Column   |      Type      | Collation | Nullable |                    Default                    
------------+----------------+-----------+----------+-----------------------------------------------
 employeeid | integer        |           | not null | nextval('employees_employeeid_seq'::regclass)
 firstname  | character(50)  |           | not null | 
 lastname   | character(50)  |           | not null | 
 email      | character(100) |           | not null | 
 jobtitle   | character(20)  |           | not null | 
Indexes:
    "employees_pkey" PRIMARY KEY, btree (employeeid)
Referenced by:
    TABLE "orders" CONSTRAINT "orders_fulfilledbyemployeeid_fkey" FOREIGN KEY (fulfilledbyemployeeid) REFERENCES employees(employeeid)

Table "public.orders"
        Column         |     Type      | Collation | Nullable |                 Default                 
-----------------------+---------------+-----------+----------+-----------------------------------------
 orderid               | integer       |           | not null | nextval('orders_orderid_seq'::regclass)
 productid             | integer       |           |          | 
 paymentid             | integer       |           |          | 
 fulfilledbyemployeeid | integer       |           |          | 
 daterequired          | date          |           | not null | 
 dateshipped           | date          |           |          | 
 status                | character(20) |           |          | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (orderid)
Foreign-key constraints:
    "orders_fulfilledbyemployeeid_fkey" FOREIGN KEY (fulfilledbyemployeeid) REFERENCES employees(employeeid)
    "orders_paymentid_fkey" FOREIGN KEY (paymentid) REFERENCES payments(paymentid)
    "orders_productid_fkey" FOREIGN KEY (productid) REFERENCES products(productid)

Table "public.payments"
   Column    |  Type   | Collation | Nullable |                   Default                   
-------------+---------+-----------+----------+---------------------------------------------
 customerid  | integer |           |          | 
 paymentid   | integer |           | not null | nextval('payments_paymentid_seq'::regclass)
 paymentdate | date    |           | not null | 
 amount      | numeric |           | not null | 
Indexes:
    "payments_pkey" PRIMARY KEY, btree (paymentid)
Foreign-key constraints:
    "payments_customerid_fkey" FOREIGN KEY (customerid) REFERENCES customers(customerid)
Referenced by:
    TABLE "orders" CONSTRAINT "orders_paymentid_fkey" FOREIGN KEY (paymentid) REFERENCES payments(paymentid)

Table "public.products"
   Column    |      Type      | Collation | Nullable |                   Default                   
-------------+----------------+-----------+----------+---------------------------------------------
 productid   | integer        |           | not null | nextval('products_productid_seq'::regclass)
 productname | character(100) |           | not null | 
 description | character(300) |           | not null | 
 buyprice    | numeric        |           | not null | 
Indexes:
    "products_pkey" PRIMARY KEY, btree (productid)
Referenced by:
    TABLE "orders" CONSTRAINT "orders_productid_fkey" FOREIGN KEY (productid) REFERENCES products(productid)

3) Create a primary key for each table with auto-increment (make sure you correctly specify the data types, e.g. the ID field should be int). --INSTRUCTION
customerid SERIAL PRIMARY KEY, --------------------------------------------------------COMMAND.

4)  Create foreign keys so that every ID in the order table references an existing ID in the tables referenced (e.g., ProductID, EmployeeID, etc). --INSTRUCTION
paymentid INT REFERENCES payments(paymentid)-------------------------------------------COMMAND.

5) INSERT the records in the tables below into the table you created in step 2.---------INSTRUCTION.
INSERT INTO employees (employeeid,firstname,lastname,email,jobtitle) VALUES (1,'Kani','Matthew','mat@gmai.com','Manager'); --COMMAND. 

/*******************************************************************/
                         QUERING A DATABASE
/*******************************************************************/

/**************[INSTRUCTIONS, COMMANDS & RESULTS]*******************/

1) SELECT ALL records from table Customers. --------------------------------------------- INSTRUCTION.
    SELECT * FROM customers;  ------------------------------------------------------------ COMMAND.
/*customers query*/ ----------------------------------------------------------------------- ALL QUERIES RESULTS.
customerid |firstname |lastname   |gender  |address                  |phone          |email                    |city           |country                       
-----------+----------+-----------+--------+-------------------------+---------------+-------------------------+---------------+----------------
         1 | John     | Hibert    | Male   | 284 chaucer st          |    8489657    | john@gmail.com          | Johannesburg  | South Africa                                      
         2 | Thando   | Sithole   | Female | 240 Sect 1              |    794445584  | thando@gmail.com        | Cape Town     | South Africa                                      
         3 | Leon     | Glen      | Male   | 81 Everton Rd,Gillits   |    820832830  | leon@gmail.com          | Durban        | South Africa                                      
         4 | Charl    | Muller    | Male   | 290A Dorset Ecke        |  44856872553  | Charl.muller@yahoo.com  | Berlin        | Germany                                           
         5 | Julia    | Stein     | Female | 2 Wernerring            | 448672445058  | Js234@yahoo.com         | Frankfurt     | Germany                                           
(5 rows)

/*payments query*/
 customerid | paymentid | paymentdate | amount  
------------+-----------+-------------+--------
          1 |         1 | 2018-01-09  | 180.75
          5 |         2 | 2018-03-09  | 150.75
          4 |         3 | 2018-03-09  | 700.60
(3 rows)

/*orders query*/
 orderid | productid | paymentid | fulfilledbyemployeeid | daterequired | dateshipped |  status        
---------+-----------+-----------+-----------------------+--------------+-------------+----------------
       1 |         1 |         1 |                     2 | 2018-05-09   |             | Not shipped         
       2 |         1 |         2 |                     2 | 2018-04-09   | 2018-03-09  | Shipped             
       3 |         3 |         3 |                     3 | 2018-06-09   |             | Not shipped         
(3 rows)

/*employees query*/
employeeid  | firstname |  lastname |  email             |  jobtitle                   
------------+-----------+-----------+--------------------+-------------
          1 | Kani      | Matthew   | mat@gmail.com      | Manager             
          2 | Lesly     | Cronje    | LesC@gmail.com     | Clerk               
          3 | Gideon    | Maduku    | m@gmail.com        | Accountant          
(3 rows)

/*products query*/
 productid |     productname         |   description                                                                | buyprice 
-----------+-------------------------+----------------------------------------------------------------------------  +------------------------------------------------------
         1 | Harley Davidson Chopper | This replica features working kickstand, front suspension, gear-shift lever  |   150.75
         2 | Classic Car             | Turnable front wheels, steering function                                     |   550.75
         3 | Classic Car             | Turnable front wheels, steering function                                     |   700.60
(3 rows)

2) SELECT records only from the name column in the Customers table. ---------------------------------INSRUCTION.
SELECT FirstName FROM Customers; --------------------------------------------------------------------COMMAND.
        firstname -----------------------------------------------------------------------------------RESULT.                   
--+--------------------+--
 John                                              
 Thando                                            
 Leon                                              
 Charl                                             
 Julia                                             
(5 rows)

3) Show the name of the Customer whose CustomerID is 1. ------------------------------------------------INSTRUCTION.
     SELECT FirstName FROM Customers WHERE CustomerID = 1; ---------------------------------------------COMMAND.
    firstname  -----------------------------------------------------------------------------------------RESULT.
--+-----------------+--
    John                                              
(1 row)

4) UPDATE the record for CustomerID = 1 on the Customer table so that the name is “Lerato Mabitso”. ----INSTRUCTION.
     UPDATE Customers SET firstname = 'Lerato', lastname = 'Mabitso' WHERE customerid = 1; -------------COMMAND.

5) DELETE the record from the Customers table for customer 2 (CustomerID = 2). ------------------------INSTRUCTION.
    DELETE FROM Customers WHERE customerid = 2; -------------------------------------------------------COMMAND.

6) Select all unique statuses from the Orders table and get a count of the number of orders for each unique status.--INSTRUCTION.
        SELECT COUNT(DISTINCT status) From Orders; --------------------------------------------------------COMMAND.

7) Return the MAXIMUM payment made on the PAYMENTS table. ---------------------------------------------INSTRUCTION.
        SELECT MAX(Amount) FROM Payments; -----------------------------------------------------------------COMMAND.

8) Select all customers from the “Customers” table, sorted by the “Country” column. -------------------INSTRUCTION.
        SELECT * FROM Customers ORDER BY Country; ---------------------------------------------------------COMMAND.

9) Select all products with a price BETWEEN R100 and R600. --------------------------------------------INSTRUCTION.
        SELECT * FROM Products WHERE Amount BETWEEN 100 AND 600; ------------------------------------------COMMAND.

10) Select all fields from “Customers” where country is “Germany” AND city is “Berlin”. ---------------INSTRUCTION.
        SELECT * FROM Customers WHERE Country ='Germany' AND City='Berlin'; -------------------------------COMMAND.

11) Select all fields from “Customers” where city is “Cape Town” OR “Durban”. -------------------------INSTRUCTION.
        SELECT * FROM Customers WHERE CITY = 'Cape Town' OR City = 'Durban'; ------------------------------COMMAND.

12) Select all records from Products where the Price is GREATER than R500. ----------------------------INSTRUCTION.
        SELECT * FROM Products WHERE BuyPrice > 500; ------------------------------------------------------COMMAND.

13) Return the sum of the Amounts on the Payments table. ----------------------------------------------INSTRUCTION.
        SELECT SUM(Amount) FROM Payments; -----------------------------------------------------------------COMMAND.

14) Count the number of shipped orders in the Orders table. -------------------------------------------INSTRUCTION.
        SELECT COUNT(status) FROM Orders WHERE status='Shipped'; ------------------------------------------COMMAND.

15) Return the average price of all Products, in Rands and in Dollars (assume the exchange rate is R12 to the Dollar).--INSTRUCTION.
        SELECT AVG(Amount / 12) FROM Products; ------------------------------------------------------------COMMAND.

16) Using INNER JOIN create a query that selects all Payments with Customer information. --------------INSTRUCTION.
        SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName, Customers.Gender, Customers.Address, Customers.Phone, Customers.Email, Customers.Country, Customers.City FROM CustomersINNER JOIN Payments ON Payments.CustomerID=Customers.CustomerID; --COMMAND.

17) Select all products that have turnable front wheels. ----------------------------------------------INSTRUCTION.
        SELECT * FROM Products WHERE description > 'Turnable front wheels steering function'; -------------COMMAND.
