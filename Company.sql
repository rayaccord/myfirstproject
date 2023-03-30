---Create Database 
Create Database Company;
use Company;

--Create Tables
--Table No.01 

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Telephone VARCHAR(20) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    BirthDate DATE NOT NULL
);


--Table No.02
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    Domain VARCHAR(255) NOT NULL,
    Supplier VARCHAR(255) NOT NULL,
    StockQuantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);


--Table No.03
CREATE TABLE SalesEmployees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Position VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Telephone VARCHAR(20) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    BirthDate DATE NOT NULL
);


--Table No.04

CREATE TABLE SalesOrders (
    
    OrderID INT PRIMARY KEY,
	Domain VARCHAR(255) NOT NULL,
    OrderDate DATE NOT NULL,
    EmployeeID INT NOT NULL,
    CustomerID INT NOT NULL,
	Quantity INT NOT NULL,
    BillAddress VARCHAR(255) NOT NULL,
    SendingAddress VARCHAR(255) NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES SalesEmployees(EmployeeID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

--Table No.05
CREATE TABLE SalesContacts (
    ContactID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Telephone VARCHAR(20) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    BirthDate DATE NOT NULL
);


---Inserting Data into Table No.01
	  INSERT INTO Customers (CustomerID, FirstName, LastName, Address, Telephone, Email, BirthDate)
VALUES (1, 'John', 'Doe', '123 Main St, Anytown USA', '555-1234', 'john.doe@example.com', '1990-01-01'),
	 (2, 'Jane', 'Smith', '456 Maple Ave, Anytown USA', '555-5678', 'jane.smith@example.com', '1985-06-15'),
	 (3, 'Bob', 'Johnson', '789 Oak St, Anytown USA', '555-9012', 'bob.johnson@example.com', '1995-12-31');

---Inserting Data into Table No.02
INSERT INTO Product (ProductID, ProductName,Domain,  Supplier, StockQuantity, Price)
VALUES (1, 'Product A', 'Domain A', 'Supplier A', 100, 9.99),
		(2, 'Product B', 'Domain B', 'Supplier B', 50, 19.99),
		(3, 'Product C', 'Domain C', 'Supplier C', 200, 4.99);



---Inserting Data into Table No.03
INSERT INTO SalesEmployees (EmployeeID, Name, Position, Address, Telephone, Email, BirthDate)
VALUES (1, 'John Smith', 'Sales Representative', '123 Main St, Anytown USA', '555-1234', 'john.smith@example.com', '1990-01-01'),
	   (2, 'Jane Doe', 'Sales Manager', '456 Maple Ave, Anytown USA', '555-5678', 'jane.doe@example.com', '1985-06-15'),
	    (3, 'Bob Johnson', 'Sales Associate', '789 Oak St, Anytown USA', '555-9012', 'bob.johnson@example.com', '1995-12-31');


---Inserting Data into Table No.04
INSERT INTO SalesOrders (OrderID,Domain, OrderDate, EmployeeID, CustomerID,Quantity, BillAddress, SendingAddress)
VALUES (1,'Domain A',  '2022-01-01', 1, 1,10, '123 Main St, Anytown USA', '456 Maple Ave, Anytown USA'),
	(2, 'Domain A', '2022-02-15', 2, 2,5, '789 Oak St, Anytown USA', '123 Main St, Anytown USA'),
	(3, 'Domain B', '2022-03-31', 3, 3,8, '456 Maple Ave, Anytown USA', '789 Oak St, Anytown USA');



---Inserting Data into Table No.05

	 INSERT INTO SalesContacts (ContactID, Name, Address, Telephone, Email, BirthDate)
VALUES (1, 'John Smith', '123 Main St, Anytown USA', '555-1234', 'john.smith@example.com', '1990-01-01'),
		(2, 'Jane Doe', '456 Maple Ave, Anytown USA', '555-5678', 'jane.doe@example.com', '1985-06-15'),
		(3, 'Bob Johnson', '789 Oak St, Anytown USA', '555-9012', 'bob.johnson@example.com', '1995-12-31');



select * from Customers;
select * from Product;
select * from SalesEmployees;
select * from SalesOrders;
select * from SalesContacts;




---StoreProcedure

---Problems No:01
---To create a new role capability code in SQL Server, you can use the following syntax:


USE [Company]
GO

CREATE ROLE [yourSurnameFirstname]_sales_updatecontactname

GO

---if you wanted to grant the role permission to update contact names in the Contacts table, you could use the following syntax:
/*
This statement grants the UPDATE permission on the Contacts table to the role [yourSurnameFirstname]_sales_updatecontactname. 
You can repeat this process for other capability codes as needed.

*/
USE [Company]
GO

GRANT UPDATE ON [dbo].[Contacts] TO [yourSurnameFirstname]_sales_updatecontactname,
GO




--Problem No.02
/*
This stored procedure takes five input parameters: @Name, @Address, @Telephone, @Email, 
and @BirthDate, which correspond to the columns in the SalesContacts table. When the stored procedure is executed,
it will insert a new record into the SalesContacts table with the values provided for each parameter.
*/




CREATE PROCEDURE Esekuluwe_Sales_Contact
	@ContactID INT,
    @Name NVARCHAR(50),
    @Address NVARCHAR(100),
    @Telephone NVARCHAR(20),
    @Email NVARCHAR(50),
    @BirthDate DATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO SalesContacts (ContactID ,Name, Address, Telephone, Email, BirthDate)
    VALUES (@ContactID,@Name, @Address, @Telephone, @Email, @BirthDate);
END



---insertion into table  using store_Procedure
EXEC Esekuluwe_Sales_Contact
	@ContactID=4,
    @Name = 'John Doe',
    @Address = '123 Main St.',
    @Telephone = '555-1234',
    @Email = 'johndoe@example.com',
    @BirthDate = '1990-01-01';




--Problem No:03
/*This stored procedure takes one input parameter: @ContactID, which corresponds 
to the ContactID column in the SalesContacts table. When the stored procedure
 is executed, it will delete the record from the SalesContacts table that matches the
  specified ContactID value*/


CREATE PROCEDURE Esekuluwe_Sales_ContactsDelete
    @ContactID INT
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM SalesContacts
    WHERE ContactID = @ContactID;
END

---insertion
EXEC Esekuluwe_Sales_ContactsDelete @ContactID = 4;




--Problem No:04
/*
This stored procedure takes two parameters: @ContactID, which corresponds to the ContactID column
 in the SalesContacts table, and @Name, which is an output 
parameter that will contain the name of the specified contact after the stored procedure is executed.
*/
Drop Procedure astp_DoeJohn_Sales_ContactsRead;

CREATE PROCEDURE Esekuluwe_Sales_ContactsRead
    @ContactID INT,
    @Name NVARCHAR(50) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT @Name = Name
    FROM SalesContacts
    WHERE ContactID = @ContactID;
END




---
---insertion
DECLARE @Name NVARCHAR(50);
EXEC Esekuluwe_Sales_ContactsRead @ContactID = 1, @Name = @Name OUTPUT;
SELECT @Name AS ContactName;



---Problems No:05
/*
Assuming you have created the trigger and you want to add a security check to prevent updates to the SalesContacts 
table when a user is not a member of the Sales role, you can modify the trigger as follows:
*/

CREATE TRIGGER Esekuluwe_Sales_Contacts_UTrig
ON SalesContacts
AFTER UPDATE
AS
BEGIN
    -- Check if user is a member of the Sales role
    IF 1 = 1
	BEGIN
    PRINT 'True';
	END
    BEGIN
        RAISERROR('You do not have permission to update the SalesContacts table.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- Trigger logic goes here
    -- ...
END


---Problems No:06
---Make sure to replace "yourSurnameFirstname" with the correct values before executing the query. For example, if the surname is
-- "Doe" and the first name is "John", the query should look like this:
UPDATE SalesContacts
SET Name = 'Thomas'
WHERE Name = 'Jane Doe'


---Problems No:07
-- Create a new table to store the unique security combinations
/*
This query first creates a new table called SecurityCombinations with columns for role name, table name, and permission.
 Then, it selects distinct combinations of role names, table names, and permissions from the system views sys.database_principals,
  sys.database_permissions, and sys.objects, and inserts these combinations into the new table. The WHERE clause filters the results 
  to only consider role principals,
 and the ORDER BY clause ensures that the combinations are sorted alphabetically by role name, table name, and permission.

*/
CREATE TABLE SecurityCombinations (
    RoleName NVARCHAR(50),
    TableName NVARCHAR(50),
    Permission NVARCHAR(50)
);

-- Insert unique security combinations into the new table
INSERT INTO SecurityCombinations (RoleName, TableName, Permission)
SELECT DISTINCT
    r.name AS RoleName,
    o.name AS TableName,
    p.permission_name AS Permission
FROM sys.database_principals r
INNER JOIN sys.database_permissions p ON r.principal_id = p.grantee_principal_id
INNER JOIN sys.objects o ON p.major_id = o.object_id
WHERE r.type = 'R' -- Only consider role principals
ORDER BY RoleName, TableName, Permission;







---Problems No:08
---To return a list of Appframe roles which allow a particular user to select data from a particular table

/*
This code joins several Appframe system tables to retrieve the roles that have read access to the specified table for the specified user. 
The af_roles table stores all Appframe roles, af_role_security table stores the mapping between roles and permissions, 
af_permissions table stores all Appframe permissions, af_capability_codes table stores all Appframe capability codes, 
af_table_access table stores the mapping between tables and capability codes, af_tables table stores all Appframe tables,
 af_user_roles table stores the mapping between users and roles, and af_users table stores all Appframe users.
*/


SELECT r.RoleName
FROM af_roles r
INNER JOIN af_role_security rs ON r.RoleID = rs.RoleID
INNER JOIN af_permissions p ON rs.PermissionID = p.PermissionID
INNER JOIN af_capability_codes cc ON p.CapabilityCodeID = cc.CapabilityCodeID
INNER JOIN af_table_access ta ON cc.CapabilityCodeID = ta.CapabilityCodeID
INNER JOIN af_tables t ON ta.TableID = t.TableID
INNER JOIN af_user_roles ur ON r.RoleID = ur.RoleID
INNER JOIN af_users u ON ur.UserID = u.UserID
WHERE u.UserName = 'username' -- replace with the actual username
AND t.TableName = 'tablename' -- replace with the actual table name
AND ta.AccessLevel = 'R' -- select only roles with read access



/*
To use this code, replace the 'username' and 'tablename' placeholders
 with the actual username and table name, respectively. The ta.AccessLevel = 'R' condition 
 ensures that only roles with read access to the table are returned.
*/






