
 1) --Create a database called “Umuzi”. 

    CREATE DATABASE umuzi;  

 2) --Create the following tables in the Umuzi database: 
        --Customers
        --Employees
        --Orders
        --Payments
        --Products

/*customers*/  
CREATE TABLE Customers(
    CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR,
    Address VARCHAR(200),
    Phone BIGINT,
    Email VARCHAR(100),
    City VARCHAR(20),
    Country VARCHAR(50)
);

/*Employees*/ 
CREATE TABLE Employees(
    EmployeeID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    JobTitle VARCHAR(20)
);

/*Payments*/
CREATE TABLE Payments(
    PaymentID SERIAL PRIMARY KEY,
    CustomerId INTEGER REFERENCES Customers(CustomerID),
    PaymentDate DATE NOT NULL, 
    Amount DECIMAL
);

/*Products*/ 
CREATE TABLE Products(
    ProductId SERIAL PRIMARY KEY,
    ProductName VARCHAR(100),
    Desrciption VARCHAR(300),
    Amount DECIMAL
);

/*Orders*/ 
CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY,
    ProductID INTEGER REFERENCES Products(ProductID),
    PaymentID INTEGER REFERENCES Payments(PaymentID),
    FulfilledByEmployeeID INTEGER REFERENCES Employees(EmployeeID),
    DateRequired DATE NOT NULL,
    DateShipped DATE,
    status VARCHAR(20)
);

3) --Create a primary key for each table with auto-increment (make sure you correctly specify the data types, e.g. the ID field should be int). --INSTRUCTION

        CustomerID SERIAL PRIMARY KEY
        EmployeeID SERIAL PRIMARY KEY
        PaymentID SERIAL PRIMARY KEY
        PaymentID SERIAL PRIMARY KEY
        OrderID SERIAL PRIMARY KEY

4)  --Create foreign keys so that every ID in the order table references an existing ID in the tables referenced (e.g., ProductID, EmployeeID, etc). --INSTRUCTION
        
        ProductID INTEGER REFERENCES Products(ProductID),
        PaymentID INTEGER REFERENCES Payments(PaymentID),

5) --INSERT the records in the tables below into the table you created in step 2.

  /*customers*/      
INSERT INTO Customers(FirstName, LastName, Gender, Address, Phone, Email, City, Country)
VALUES('John', 'Hibert', 'Male', '284 chaucer st', 084789657, 'john@gmail.com', 'Johannesburg', 'South Africa');
INSERT INTO Customers(FirstName, LastName, Gender, Address, Phone, Email, City, Country)
VALUES('Thando', 'Sithole', 'Female', '240 Sect 1', 0794445584, 'thando@gmail.com', 'Cape Town', 'South Africa');
INSERT INTO Customers( FirstName, LastName, Gender, Address, Phone, Email, City, Country)
VALUES('Leon', 'Glen', 'Male', '81 Everton Rd, Gillits', 0820832830, 'leaon@gmail.com', 'Durban', 'South Africa');
INSERT INTO Customers(FirstName, LastName, Gender, Address, Phone, Email, City, Country)
VALUES('Charl', 'Muller', 'Male', '290 Dorset Ecke', +44856872553, 'Charl.muller@yahoo.com', 'Berlin', 'Germany');
INSERT INTO Customers(FirstName, LastName, Gender, Address, Phone, Email, City, Country)
VALUES('Julia', 'Stein', 'Female', '2 Wernerring', +448672445058, 'Js234@yahoo.com', 'Frankfurt', 'Germany');

 /*Employees*/ 
 INSERT INTO Employees(FirstName, LastName, Email, JobTitle)
VALUES ('Kani','Matthew','/*Payments*/mat@gmail.com','Manager');
INSERT INTO Employees(Firs/*Payments*/tName, LastName, Email, JobTitle)
VALUES ('Lesly','Cronje','LesC@gmail.com','Clerk');
INSERT INTO Employees(FirstName, LastName, Email, JobTitle)
VALUES ('Gideon','Maduku','m@gmail.com','Accountant');

 /*Payments*/ 
INSERT INTO Payments(PaymentDate, Amount)
VALUES ('01-09-2018', 150.75);
INSERT INTO Payments(PaymentDate, Amount)
VALUES ('03-09-2018',150.75);
INSERT INTO Payments(PaymentDate, Amount)
VALUES ('03-09-2018',700.60);

 /*Products*/ 
INSERT INTO Products(ProductName,Desrciption,Amount)
VALUES ('Harley Davidson Chopper', 'This replica features working kickstand, front suspension, gear-shift lever',150.75);
INSERT INTO Products(ProductName,Desrciption,Amount)
VALUES ('Classic Car','Turnable front wheels, steering function',550.75);
INSERT INTO Products(ProductName,Desrciption,Amount)
VALUES ('Sports car','Turnable front wheels, steering function',700.60)

 /*Orders*/ 
INSERT INTO Orders (DateRequired ,DateShipped,status)
VALUES ('05-09-2018', NULL,'Not shipped');
INSERT INTO Orders (DateRequired ,DateShipped,status)
VALUES ('04-09-2018','03-09-2018','Shipped');
INSERT INTO Orders (DateRequired ,DateShipped,status)
VALUES ('06-09-2018', NULL,'Not shipped');
 

1) --SELECT ALL records from table Customers. 
         SELECT * FROM customers; 

2) --SELECT records only from the name column in the Customers table. 
        SELECT FirstName FROM Customers; 

3) --Show the name of the Customer whose CustomerID is 1. 
        SELECT FirstName FROM Customers WHERE CustomerID = 1; 

4) --UPDATE the record for CustomerID = 1 on the Customer table so that the name is “Lerato Mabitso”. 
        UPDATE Customers SET firstname = 'Lerato', lastname = 'Mabitso' WHERE customerid = 1; 

5) --DELETE the record from the Customers table for customer 2 (CustomerID = 2). 
        DELETE FROM Customers WHERE customerid = 2; 

6) --Select all unique statuses from the Orders table and get a count of the number of orders for each unique status.
        SELECT COUNT(DISTINCT status) From Orders; 

7) --Return the MAXIMUM payment made on the PAYMENTS table. 
        SELECT MAX(Amount) FROM Payments;

8) --Select all customers from the “Customers” table, sorted by the “Country” column.
        SELECT * FROM Customers ORDER BY Country; 

9) --Select all products with a price BETWEEN R100 and R600. 
        SELECT * FROM Products WHERE Amount BETWEEN 100 AND 600; 

10) --Select all fields from “Customers” where country is “Germany” AND city is “Berlin”. 
        SELECT * FROM Customers WHERE Country ='Germany' AND City='Berlin'; 

11) --Select all fields from “Customers” where city is “Cape Town” OR “Durban”. 
        SELECT * FROM Customers WHERE CITY = 'Cape Town' OR City = 'Durban'; 

12) --Select all records from Products where the Price is GREATER than R500.
        SELECT * FROM Products WHERE BuyPrice > 500; 

13) --Return the sum of the Amounts on the Payments table. 
        SELECT SUM(Amount) FROM Payments; 

14) --Count the number of shipped orders in the Orders table. 
        SELECT COUNT(status) FROM Orders WHERE status='Shipped'; 

15) --Return the average price of all Products, in Rands and in Dollars (assume the exchange rate is R12 to the Dollar).
        SELECT AVG(Amount / 12) FROM Products; 

16) --Using INNER JOIN create a query that selects all Payments with Customer information. 
        SELECT CustomerID, FirstName, LastName, Gender, Address, Phone, Email, Country, City FROM customers INNER JOIN Payments ON Payments.CustomerID=Customers.CustomerID; 

17) --Select all products that have turnable front wheels. 
        SELECT * FROM Products WHERE Desrciption > 'Turnable front wheels steering function'; 


