CREATE DATABASE Team4Summer2023_Final;

USE Team4Summer2023_Final;
GO

------------------------------------Creating Tables---------------------------------------------------------------------

CREATE TABLE LogisticsSystem
(
   logisticsSystemID VARCHAR(10) NOT NULL PRIMARY KEY,
   companyID VARCHAR(10),
   shipmentID VARCHAR(10),
   transactionID VARCHAR(10),
   financesID VARCHAR(10),
   customerID VARCHAR(10),
   employeeID VARCHAR(10),
   departmentID VARCHAR(10)
);
CREATE TABLE Employees (
    employeeID VARCHAR(10) PRIMARY KEY NOT NULL,
	password VARCHAR(100) NOT NULL,
    firstName VARCHAR(20) NOT NULL,
    lastName VARCHAR(20) NOT NULL,
    DateOfBirth DATE NOT NULL,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip INT NOT NULL,
    hiredDate DATE NOT NULL,
    mobile CHAR(10) NOT NULL,
    departmentID VARCHAR(10)
	);
CREATE TABLE Department (
    departmentID VARCHAR(10) PRIMARY KEY NOT NULL,
    departmentName VARCHAR(50) NOT NULL,
    employeeID VARCHAR(10)
    );
CREATE TABLE Company (
    companyID VARCHAR(10) PRIMARY KEY NOT NULL,
    companyName VARCHAR(100) NOT NULL,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    [state] VARCHAR(50) NOT NULL,
    zip INT NOT NULL,
    phone CHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    contactPersonEmail VARCHAR(100) NOT NULL
);
CREATE TABLE Tracking (
trackingID VARCHAR(10) NOT NULL Primary Key,
shipmentID VARCHAR(10),
shipmentLocation VARCHAR(50) NOT NULL,
prodcutTimeStamp VARCHAR(10) NOT NULL,
transportationModeID VARCHAR(10)
);
CREATE TABLE Packaging(
packagingID VARCHAR(10) NOT NULL Primary Key,
packagingType VARCHAR(10) NOT NULL,
decsription VARCHAR(100) NOT NULL,
transportationModeID VARCHAR(10)
);
CREATE TABLE TransportationMode(
transportationModeID  VARCHAR(10) NOT NULL Primary Key,
modeName VARCHAR(10) NOT NULL,
description VARCHAR(100)
);
CREATE TABLE Finances
(
    financesID VARCHAR(10) NOT NULL PRIMARY KEY,
    amount INT not NULL,
    quarter VARCHAR(10) NOT NULL,
    transactionID VARCHAR(10)
);
CREATE TABLE Transactions
(
    transactionID VARCHAR(10) NOT NULL PRIMARY KEY,
    amount INT NOT NULL,
    quantity INT NOT NULL,
    comments VARCHAR(100) NOT NULL,
    transactionType varchar(50) NOT NULL,
    customerID VARCHAR(10),
    shipmentID VARCHAR(10)
);
CREATE TABLE Customer
(
    customerID VARCHAR(10) NOT NULL PRIMARY KEY,
    trackingID VARCHAR(10),
    reviewID VARCHAR(10),
    customerRating VARCHAR(10) NOT NULL,
    customerComments VARCHAR(100)
);
CREATE TABLE CustomerReviews
(
    reviewID VARCHAR(10) NOT NULL PRIMARY KEY,
    rating VARCHAR(20),
    title VARCHAR(50) NOT NULL,
    description VARCHAR(200) ,
    customerID VARCHAR(10),
    shipmentID VARCHAR(10)
);
CREATE TABLE Shipments (
shipmentID VARCHAR(10) NOT NULL PRIMARY KEY,
shipmentDate DATE NOT NULL,
[status] VARCHAR(25) NOT NULL CHECK ([status] IN ('Pending', 'In Transit', 'Arrived at Warehouse', 
									'Out for Delivery', 'Delivered', 'Failed Delivery Attempt', 'Delayed', 'Canceled', 'Lost', 'Cancelled',
									'On Hold', 'Ready for Pickup')),
packagingID VARCHAR(10),
transportationModeID VARCHAR(10)
);
CREATE TABLE Warehouses (
warehouseID VARCHAR(10) NOT NULL PRIMARY KEY,
warehouseCity VARCHAR(20) NOT NULL,
warehouseState VARCHAR(15) NOT NULL,
warehouseZip INTEGER NOT NULL,
volume INTEGER NOT NULL,
availableQuantity INTEGER NOT NULL
);
CREATE TABLE ShipmentWarehouse (
warehouseID VARCHAR(10) NOT NULL,
shipmentID VARCHAR(10) NOT NULL,
PRIMARY KEY (warehouseID, shipmentID));

------------------------------------Adding Foreign Keys----------------------------------------------

ALTER TABLE Employees ADD FOREIGN KEY (departmentID) REFERENCES Department(departmentID)

ALTER TABLE Department ADD FOREIGN KEY (employeeID) REFERENCES Employees(employeeID)

ALTER TABLE Tracking ADD FOREIGN KEY (shipmentID) REFERENCES Shipments(shipmentID);

ALTER TABLE Tracking ADD FOREIGN KEY (transportationModeID) REFERENCES TransportationMode(transportationModeID);
ALTER TABLE Finances ADD FOREIGN KEY (transactionID) REFERENCES Transactions(transactionID);

ALTER TABLE Transactions ADD FOREIGN KEY (customerID) REFERENCES Customer(customerID);

ALTER TABLE Transactions ADD FOREIGN KEY (shipmentID) REFERENCES Shipments(shipmentID);

ALTER TABLE Customer ADD FOREIGN KEY (reviewID) REFERENCES CustomerReviews(reviewID);

ALTER TABLE CustomerReviews ADD FOREIGN KEY (customerID) REFERENCES Customer(customerID);

ALTER TABLE CustomerReviews ADD FOREIGN KEY (shipmentID) REFERENCES Shipments(shipmentID);
ALTER TABLE LogisticsSystem ADD FOREIGN KEY (companyID) REFERENCES Company(companyID);

ALTER TABLE LogisticsSystem ADD FOREIGN KEY (shipmentID) REFERENCES Shipments(shipmentID);

ALTER TABLE LogisticsSystem ADD FOREIGN KEY (transactionID) REFERENCES Transactions(transactionID);

ALTER TABLE LogisticsSystem ADD FOREIGN KEY (financesID) REFERENCES Finances(financesID);

ALTER TABLE LogisticsSystem ADD FOREIGN KEY (customerID) REFERENCES Customer(customerID);

ALTER TABLE LogisticsSystem ADD FOREIGN KEY (employeeID) REFERENCES Employees(employeeID);

ALTER TABLE LogisticsSystem ADD FOREIGN KEY (departmentID) REFERENCES Department(departmentID);
ALTER TABLE Shipments ADD FOREIGN KEY (packagingID) REFERENCES [dbo].[Packaging] ([packagingID]);
ALTER TABLE Shipments ADD FOREIGN KEY (transportationModeID) REFERENCES [dbo].[TransportationMode]([transportationModeID]);

ALTER TABLE ShipmentWarehouse ADD FOREIGN KEY (warehouseID) REFERENCES [dbo].[Warehouses]([warehouseID]);
ALTER TABLE ShipmentWarehouse ADD FOREIGN KEY (shipmentID) REFERENCES [dbo].[Shipments]([shipmentID]);

---------------------------------- Adding Check Constraint------------------------------------

ALTER TABLE Employees
ADD CONSTRAINT ZipCheck_Employees CHECK (zip >= 10000 AND zip <= 99999);

ALTER TABLE Company
ADD CONSTRAINT ZipCheck_Company CHECK (zip >= 10000 AND zip <= 99999);

ALTER TABLE Company
ADD CONSTRAINT PhoneCheck_Company CHECK (LEN(phone) = 10 AND phone LIKE '[0-9]%');

ALTER TABLE Warehouses ADD CONSTRAINT warehouseState CHECK(warehouseState IN ('Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California',
																				'Colorado', 'Connecticut', 'Delaware', 'Florida', 'Georgia',
																				'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana',
																				'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota', 'Mississippi',
																				'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey',
																				'New Mexico', 'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma',
																				'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota',
																				'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington', 'West Virginia', 'Wisconsin', 'Wyoming'));

------------------------------------Inserting Dummy Data without FK----------------------------------
SELECT * FROM Employees;
INSERT INTO Employees (employeeID, password, firstName, lastName, DateOfBirth, street, city, state, zip, hiredDate, mobile)
VALUES
('EMP001', 'password1', 'Abhinav', 'Choudhary', '1997-06-11', '9 Chilcott Pl', 'Boston', 'Massachusetts', 12130, '2022-09-18', '4445556666'),
    ('EMP002', 'password2', 'David', 'Brown', '1988-12-05', '222 Pine St', 'Miami', 'Florida', 24680, '2019-04-30', '7778889999'),
    ('EMP003', 'password3', 'Sarah', 'Miller', '1995-02-25', '333 Oak Ave', 'Las Vegas', 'Nevada', 98765, '2020-08-22', '1112223333'),
    ('EMP004', 'password4', 'Emily', 'Williams', '1993-07-10', '101 Maple Ave', 'New York City', 'New York', 13579, '2016-09-18', '4445556666'),
    ('EMP005', 'password5', 'David', 'Brown', '1988-12-05', '222 Pine St', 'Los Angeles', 'California', 24680, '2019-04-30', '7778889999'),
    ('EMP006', 'password6', 'Sarah', 'Miller', '1995-02-25', '333 Washington St', 'Las Vegas', 'Nevada', 98765, '2020-08-22', '1112223333'),
    ('EMP007', 'password7', 'Robert', 'Davis', '1987-06-12', '444 Elm St', 'Austin', 'Texas', 13579, '2014-03-08', '9998887777'),
    ('EMP008', 'password8', 'Elizabeth', 'Anderson', '1991-09-28', '555 Cedar Ave', 'Chicago', 'Illinois', 24680, '2016-11-05', '5554443333'),
    ('EMP009', 'password9', 'Christopher', 'Wilson', '1986-04-15', '666 Oak St', 'Seattle', 'Washington', 13579, '2013-07-20', '2223334444'),
    ('EMP010', 'password10', 'Jessica', 'Lee', '1994-01-30', '777 Pine Ave', 'Phoenix', 'Arizona', 24680, '2018-02-14', '8889990000'),
	('EMP016', 'new_password1', 'Alice', 'Johnson', '1998-03-22', '123 Main St', 'Seattle', 'Washington', 54321, '2022-10-15','1112223333'),
    ('EMP017', 'new_password2', 'Michael', 'Smith', '1990-08-18', '456 Oak Ave', 'New York City', 'New York', 98765, '2017-05-10', '4445556666'),
   ('EMP018', 'new_password3', 'Jessica', 'Williams', '1993-05-12', '789 Elm St', 'Los Angeles', 'California', 12345, '2019-12-03', '7778889999'),
   ('EMP019', 'new_password4', 'Daniel', 'Brown', '1985-11-02', '101 Pine St', 'Chicago', 'Illinois', 67890, '2014-08-28', '2223334444'),
   ('EMP020', 'new_password5', 'Emily', 'Davis', '1997-02-28', '222 Maple Ave', 'Miami', 'Florida', 54321, '2020-06-19', '5554443333'),
  ('EMP021', 'new_password6', 'William', 'Miller', '1989-07-15', '333 Oak St', 'Las Vegas', 'Nevada', 98765, '2018-11-21', '9998887777'),
('EMP022', 'new_password7', 'Olivia', 'Wilson', '1991-09-04', '444 Elm St', 'San Francisco', 'California', 13579, '2016-03-12', '8889990000'),
('EMP023', 'new_password8', 'Ethan', 'Martinez', '1987-12-11', '555 Cedar Ave', 'Austin', 'Texas', 67890, '2013-09-05', '1112223333'),
('EMP024', 'new_password9', 'Sophia', 'Garcia', '1994-06-25', '666 Pine Ave', 'Phoenix', 'Arizona', 54321, '2017-01-25', '7778889999'),
('EMP025', 'new_password10', 'Alexander', 'Lee', '1984-04-03', '777 Oak St', 'Denver', 'Colorado', 12345, '2015-08-08','4445556666');

INSERT INTO Department (departmentID, departmentName)
VALUES
('DEP001', 'Quality Assaurance'),
    ('DEP002', 'Sales'),
    ('DEP003', 'Marketing'),
    ('DEP004', 'Finance'),
    ('DEP005', 'Human Resources'),
    ('DEP006', 'IT'),
    ('DEP007', 'Research and Development'),
    ('DEP008', 'Customer Service'),
    ('DEP009', 'Operations'),
    ('DEP010', 'Public Relations');



INSERT INTO Company (companyID, companyName, street, city, [state], zip, phone, email, contactPersonEmail)
VALUES
('COMP001', 'ABC Transport Inc.', '550 Cargo Rd', 'Las Vegas', 'Nevada', 89101, '4445556666', 'info@ghitransport.com', 'emily.williams@ghitransport.com'),
    ('COMP002', 'XYZ Express', '66 Expressway Blvd', 'New York City', 'New York', 10001, '7778889999', 'info@lmnexpress.com', 'david.brown@lmnexpress.com'),
    ('COMP003', 'GHI Transport Inc.', '555 Cargo Rd', 'Boston', 'Massachusetts', 12101, '4445556666', 'info@ghitransport.com', 'emily.williams@ghitransport.com'),
    ('COMP004', 'LMN Express', '77 Expressway Blvd', 'Atlanta', 'Georgia', 30301, '7778889999', 'info@lmnexpress.com', 'david.brown@lmnexpress.com'),
    ('COMP005', 'PQR Shipping Services', '333 Freight Lane', 'Phoenix', 'Arizona', 85001, '2223334444', 'info@pqrshipping.com', 'sarah.miller@pqrshipping.com'),
    ('COMP006', 'RST Logistics', '222 Supply St', 'Seattle', 'Washington', 98101, '1112223333', 'info@rstlogistics.com', 'robert.davis@rstlogistics.com'),
    ('COMP007', 'UVW Transport Co.', '444 Hauling Ave', 'Chicago', 'Illinois', 60601, '5554443333', 'info@uvwtransport.com', 'elizabeth.anderson@uvwtransport.com'),
    ('COMP008', 'XYZ Corp', '777 Delivery Rd', 'Miami', 'Florida', 33101, '8889990000', 'info@xyzcorp.com', 'christopher.wilson@xyzcorp.com'),
    ('COMP009', 'ABC Express', '999 Shipping Lane', 'Austin', 'Texas', 73301, '9998887777', 'info@abcexpress.com', 'jessica.lee@abcexpress.com'),
    ('COMP010', 'LMN Logistics', '111 Logistics Ave', 'Los Angeles', 'California', 90001, '5556667777', 'info@lmnlogistics.com', 'michael.johnson@lmnlogistics.com');


INSERT INTO Tracking (trackingID, shipmentLocation, prodcutTimeStamp)
VALUES
('TRACK001','Miami', '2023-07-25'),
    ('TRACK002', 'Las Vegas', '2023-07-24'),
    ('TRACK003','New York City', '2023-07-25'),
    ('TRACK004', 'Los Angeles', '2023-07-24'),
    ('TRACK005','Boston', '2023-07-23'),
    ('TRACK006','Austin', '2023-07-22'),
    ('TRACK007','Seattle', '2023-07-21'),
    ('TRACK008', 'Chicago', '2023-07-20'),
    ('TRACK009','Phoenix', '2023-07-19'),
    ('TRACK010','Atlanta', '2023-07-18');

INSERT INTO Packaging (packagingID, packagingType, decsription)
VALUES
('PACK001', 'Envelope', 'Cardboard box for small to medium items'),
    ('PACK002', 'Crate', 'Wodden Crates for machinery'),
    ('PACK003', 'Envelope', 'Small padded envelope for documents'),
    ('PACK004', 'Crate', 'Heavy-duty crate for fragile items'),
    ('PACK005', 'Tube', 'Cardboard tube for posters and blueprints'),
    ('PACK006', 'Bag', 'Plastic bag for clothing and soft items'),
    ('PACK007', 'Barrel', 'Metal barrel for liquid goods'),
    ('PACK008', 'Tote', 'Plastic tote for organizing smaller items'),
    ('PACK009', 'Cylinder', 'Metal cylinder for storing gases'),
    ('PACK010', 'Case', 'Hard case for protecting delicate equipment');

INSERT INTO TransportationMode (transportationModeID, modeName, description)
VALUES
('MODE001', 'Car', 'Shipping goods by road'),
    ('MODE002', 'Truck', 'Transportation by truck for longer distances'),
    ('MODE003', 'Ship', 'Shipping goods by sea'),
    ('MODE004', 'Train', 'Transportation by train for longer distances'),
    ('MODE005', 'Bicycle', 'Local transportation using bicycles'),
    ('MODE006', 'Helicopter', 'Fast aerial transportation for critical shipments'),
    ('MODE007', 'Van', 'Small-scale ground transportation using vans'),
    ('MODE008', 'Motorcycle', 'Quick delivery using motorcycles'),
    ('MODE009', 'Drone', 'Unmanned aerial transportation for lightweight items'),
    ('MODE010', 'Submarine', 'Underwater transportation for specialized cargo');



INSERT INTO Finances (financesID, amount, quarter)
VALUES
('FIN001', 1000, 'Q3 2023'),
    ('FIN002', 900, 'Q4 2023'),
    ('FIN003', 1200, 'Q3 2023'),
    ('FIN004', 900, 'Q3 2023'),
    ('FIN005', 800, 'Q3 2023'),
    ('FIN006', 1100, 'Q3 2023'),
    ('FIN007', 950, 'Q4 2023'),
    ('FIN008', 700, 'Q4 2023'),
    ('FIN009', 1300, 'Q4 2023'),
    ('FIN010', 850, 'Q4 2023');



INSERT INTO Customer (customerID, customerRating, customerComments)
VALUES
('CUST001','0', 'Fast delivery, but packaging could be better.'),
    ('CUST002','0', 'Excellent service! No complaints.'),
    ('CUST003','0', 'Fast delivery, but packaging could be better.'),
    ('CUST004','0', 'Excellent service! No complaints.'),
    ('CUST005','0', 'Delivery was delayed by a day.'),
    ('CUST006','0', 'Courteous delivery person.'),
    ('CUST007','0', 'Items arrived damaged.'),
    ('CUST008','0', 'Good overall experience.'),
    ('CUST009','0', 'Customer support needs improvement.'),
    ('CUST010','0', 'Happy with the product quality.');


INSERT INTO CustomerReviews (reviewID, rating, title, description)
VALUES
('REVIEW001', '2.0', 'Fast Delivery', 'Received my order late and packaging could be improved.'),
    ('REVIEW002', '3.5', 'Great Service', 'Good Product'),
    ('REVIEW003', '4.2', 'Fast Delivery', 'Received my order quickly, but packaging could be improved.'),
    ('REVIEW004', '5.0', 'Great Service', 'Everything was perfect. Highly recommended!'),
    ('REVIEW005', '3.5', 'Delayed Delivery', 'The shipment was delayed by a day.'),
    ('REVIEW006', '4.7', 'Friendly Delivery', 'The delivery person was very polite and friendly.'),
    ('REVIEW007', '2.9', 'Damaged Items', 'Some items arrived damaged during transit.'),
    ('REVIEW008', '4.0', 'Good Experience', 'Overall, I had a good experience with them.'),
    ('REVIEW009', '3.2', 'Needs Improvement', 'Customer support needs improvement.'),
    ('REVIEW010', '4.5', 'Happy with the Product', 'I am happy with the quality of the product.');



INSERT INTO Shipments (shipmentID, shipmentDate, [status])
VALUES
('SHIP001', '2023-06-15', 'Pending'),
    ('SHIP002', '2023-05-11', 'Canceled'),
    ('SHIP003', '2023-07-15', 'In Transit'),
    ('SHIP004', '2023-07-12', 'Delivered'),
    ('SHIP005', '2023-07-08', 'In Transit'),
    ('SHIP006', '2023-07-05', 'Delivered'),
    ('SHIP007', '2023-07-01', 'In Transit'),
    ('SHIP008', '2023-06-28', 'Delivered'),
    ('SHIP009', '2023-06-24', 'In Transit'),
    ('SHIP010', '2023-06-20', 'Delivered');


	INSERT INTO Warehouses (warehouseID, warehouseCity, warehouseState, warehouseZip, volume, availableQuantity)
VALUES
('WH001', 'Miami', 'Florida', 33101, 20000, 8000),
    ('WH002', 'Las Vegas', 'Nevada', 89101, 15000, 6000),
    ('WH003', 'New York City', 'New York', 10001, 20000, 8000),
    ('WH004', 'Los Angeles', 'California', 90001, 15000, 6000),
    ('WH005', 'Boston', 'Massachusetts', 02101, 18000, 7000),
    ('WH006', 'Austin', 'Texas', 73301, 25000, 10000),
    ('WH007', 'Seattle', 'Washington', 98101, 22000, 9000),
    ('WH008', 'Chicago', 'Illinois', 60601, 30000, 12000),
    ('WH009', 'Phoenix', 'Arizona', 85001, 28000, 11000),
    ('WH010', 'Atlanta', 'Georgia', 30301, 35000, 15000);

INSERT INTO ShipmentWarehouse (warehouseID, shipmentID)
VALUES
('WH001', 'SHIP001'),
    ('WH002', 'SHIP002'),
    ('WH003', 'SHIP003'),
    ('WH004', 'SHIP004'),
    ('WH005', 'SHIP005'),
    ('WH006', 'SHIP006'),
    ('WH007', 'SHIP007'),
    ('WH008', 'SHIP008'),
    ('WH009', 'SHIP009'),
    ('WH010', 'SHIP010');

INSERT INTO Transactions (transactionID, amount, quantity, comments, transactionType)
VALUES
    ('TXN0001', 500, 2, 'Payment for goods', 'Sale'),
    ('TXN0002', 300, 1, 'Refund for returned item', 'Return'),
    ('TXN0003', 1000, 5, 'Bulk purchase', 'Sale'),
    ('TXN0004', 150, 3, 'Discount applied', 'Sale'),
    ('TXN0005', 750, 2, 'Payment for services', 'Service'),
    ('TXN0006', 200, 1, 'Refund for damaged item', 'Return'),
    ('TXN0007', 800, 4, 'Wholesale order', 'Sale'),
    ('TXN0008', 50, 2, 'Promotional offer', 'Sale'),
    ('TXN0009', 250, 1, 'Payment for subscription', 'Service'),
    ('TXN0010', 600, 3, 'Discount for loyal customer', 'Sale');

INSERT INTO LogisticsSystem (logisticsSystemID, companyID, shipmentID, transactionID, financesID, employeeID, customerID, departmentID)
VALUES
('LS0001', 'COMP001', 'SHIP001', 'TXN0001', 'FIN001', 'EMP001', 'CUST001', 'DEP001'),
('LS0002', 'COMP002', 'SHIP002', 'TXN0002', 'FIN002', 'EMP002', 'CUST002', 'DEP002'),
('LS0003', 'COMP003', 'SHIP003', 'TXN0003', 'FIN003', 'EMP003', 'CUST003', 'DEP003'),
('LS0004', 'COMP004', 'SHIP004', 'TXN0004', 'FIN004', 'EMP004', 'CUST004', 'DEP004'),
('LS0005', 'COMP005', 'SHIP005', 'TXN0005', 'FIN005', 'EMP005', 'CUST005', 'DEP005'),
('LS0006', 'COMP006', 'SHIP006', 'TXN0006', 'FIN006', 'EMP006', 'CUST006', 'DEP006'),
('LS0007', 'COMP007', 'SHIP007', 'TXN0007', 'FIN007', 'EMP007', 'CUST007', 'DEP007'),
('LS0008', 'COMP008', 'SHIP008', 'TXN0008', 'FIN008', 'EMP008', 'CUST008', 'DEP008'),
('LS0009', 'COMP009', 'SHIP009', 'TXN0009', 'FIN009', 'EMP009', 'CUST009', 'DEP009'),
('LS00010', 'COMP010', 'SHIP010', 'TXN0010', 'FIN010', 'EMP010', 'CUST010', 'DEP010');

---------------Insert Foreign Keys data----------------------------------
DECLARE @CurrentID INT = 1;

WHILE @CurrentID <= 10
BEGIN

	IF @CurrentID < 10
		BEGIN
			UPDATE Employees
			SET departmentID = 'DEP00' + CAST(@CurrentID AS VARCHAR)
			WHERE employeeID = 'EMP00' + CAST(@CurrentID AS VARCHAR);

			UPDATE Department
			SET employeeID = 'EMP00' + CAST(@CurrentID AS VARCHAR)
			WHERE departmentID = 'DEP00' + CAST(@CurrentID AS VARCHAR);

			UPDATE [Tracking]
			SET shipmentID = 'SHIP00' + CAST(@CurrentID AS VARCHAR),
				transportationModeID = 'MODE00' + CAST(@CurrentID AS VARCHAR)
			WHERE trackingID = 'TRACK00' + CAST(@CurrentID AS VARCHAR);

			UPDATE Finances
			SET transactionID = 'TXN000' + CAST(@CurrentID AS VARCHAR)
			WHERE financesID = 'FIN00' + CAST(@CurrentID AS VARCHAR);

			UPDATE Customer
			SET reviewID = 'REVIEW00' + CAST(@CurrentID AS VARCHAR),
				trackingID = 'TRACK00' + CAST(@CurrentID AS VARCHAR),
				customerRating = CAST((CAST(1 AS INT) + CAST(4 * RAND() AS DECIMAL(10, 2))) AS FLOAT)
			WHERE customerID = 'CUST00' + CAST(@CurrentID AS VARCHAR);

			UPDATE CustomerReviews
			SET customerID = 'CUST00' + CAST(@CurrentID AS VARCHAR),
				shipmentID = 'SHIP00' + CAST(@CurrentID AS VARCHAR)
			WHERE reviewID = 'REVIEW00' + CAST(@CurrentID AS VARCHAR);

			UPDATE Shipments
			SET packagingID = 'PACK00' + CAST(@CurrentID AS VARCHAR),
				transportationModeID = 'MODE00' + CAST(@CurrentID AS VARCHAR)
			WHERE shipmentID = 'SHIP00' + CAST(@CurrentID AS VARCHAR);

			UPDATE Transactions
			SET customerID = 'CUST00' + CAST(@CurrentID AS VARCHAR),
				shipmentID = 'SHIP00' + CAST(@CurrentID AS VARCHAR)
			WHERE transactionID = 'TXN000' + CAST(@CurrentID AS VARCHAR);

			UPDATE Packaging
			SET transportationModeID = 'MODE00' + CAST(@CurrentID AS VARCHAR)
			WHERE packagingID = 'PACK00' + CAST(@CurrentID AS VARCHAR);
		END
	ELSE
		BEGIN
			UPDATE Employees
			SET departmentID = 'DEP0' + CAST(@CurrentID AS VARCHAR)
			WHERE employeeID = 'EMP0' + CAST(@CurrentID AS VARCHAR);

			UPDATE Department
			SET employeeID = 'EMP0' + CAST(@CurrentID AS VARCHAR)
			WHERE departmentID = 'DEP0' + CAST(@CurrentID AS VARCHAR);

			UPDATE [Tracking]
			SET shipmentID = 'SHIP0' + CAST(@CurrentID AS VARCHAR),
				transportationModeID = 'MODE0' + CAST(@CurrentID AS VARCHAR)
			WHERE trackingID = 'TRACK0' + CAST(@CurrentID AS VARCHAR);

			UPDATE Finances
			SET transactionID = 'TXN00' + CAST(@CurrentID AS VARCHAR)
			WHERE financesID = 'FIN0' + CAST(@CurrentID AS VARCHAR);

			UPDATE Customer
			SET reviewID = 'REVIEW0' + CAST(@CurrentID AS VARCHAR),
				trackingID = 'TRACK0' + CAST(@CurrentID AS VARCHAR),
				customerRating = CAST((CAST(1 AS INT) + CAST(4 * RAND() AS DECIMAL(10, 2))) AS FLOAT)
			WHERE customerID = 'CUST0' + CAST(@CurrentID AS VARCHAR);

			UPDATE CustomerReviews
			SET customerID = 'CUST0' + CAST(@CurrentID AS VARCHAR),
				shipmentID = 'SHIP0' + CAST(@CurrentID AS VARCHAR)
			WHERE reviewID = 'REVIEW0' + CAST(@CurrentID AS VARCHAR);

			UPDATE Shipments
			SET packagingID = 'PACK0' + CAST(@CurrentID AS VARCHAR),
				transportationModeID = 'MODE0' + CAST(@CurrentID AS VARCHAR)
			WHERE shipmentID = 'SHIP0' + CAST(@CurrentID AS VARCHAR);

			UPDATE Transactions
			SET customerID = 'CUST0' + CAST(@CurrentID AS VARCHAR),
				shipmentID = 'SHIP0' + CAST(@CurrentID AS VARCHAR)
			WHERE transactionID = 'TXN00' + CAST(@CurrentID AS VARCHAR);

			UPDATE Packaging
			SET transportationModeID = 'MODE0' + CAST(@CurrentID AS VARCHAR)
			WHERE packagingID = 'PACK0' + CAST(@CurrentID AS VARCHAR);
	END
	SET @CurrentID = @CurrentID + 1;
END

---------------SELECT Queries----------------------------------------------------

SELECT * FROM Employees;
SELECT * FROM Department;
SELECT * FROM Tracking;
SELECT * FROM Finances;
SELECT * FROM Customer;
SELECT * FROM CustomerReviews;
SELECT * FROM Company;
SELECT * FROM Packaging;
SELECT * FROM TransportationMode;
SELECT * FROM Transactions;
SELECT * FROM Shipments;
SELECT * FROM Warehouses;
SELECT * FROM ShipmentWarehouse;
SELECT * FROM LogisticsSystem;

----------------------------------Computed Columns based on a function--------------------------

-- Create Function to Calculate Age from Date of Birth
CREATE FUNCTION CalculateAgeFromDateOfBirth(@birthdate DATE)
RETURNS INT
BEGIN
    RETURN DATEDIFF(YEAR, @birthdate, GETDATE());
END

-- Alter Table Employees to add computed column age
ALTER TABLE Employees
DROP COLUMN Age;

ALTER TABLE Employees
ADD Age AS dbo.CalculateAgeFromDateOfBirth(DateOfBirth);

-- Calculate Average Rating by averaging all the ratings from customer table for a particular shipment
CREATE FUNCTION dbo.GetAverageRatingForCustomerReviews(@ShipmentID VARCHAR(10))
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @AverageRating VARCHAR(20);

    SELECT @AverageRating = CAST(AVG(CAST(customerRating AS FLOAT)) AS VARCHAR(20))
    FROM Customer cust
	JOIN CustomerReviews custReviews ON custReviews.reviewID = cust.reviewID
    WHERE shipmentID = @ShipmentID;

    RETURN @AverageRating;
END;

-- Alter table customer reviews to add computed column rating
ALTER TABLE CustomerReviews
DROP COLUMN rating;

ALTER TABLE CustomerReviews
ADD rating AS dbo.GetAverageRatingForCustomerReviews(shipmentID);

-- Calculate Volume Occupied from Volume and availableQuantity
CREATE FUNCTION dbo.CalculateVolumeOccupied (@warehouseID VARCHAR(10))
RETURNS INTEGER
AS
BEGIN
    DECLARE @volumeOccupied INTEGER;

    SELECT @volumeOccupied = w.volume - w.availableQuantity
    FROM Warehouses w
    INNER JOIN ShipmentWarehouse sw ON w.warehouseID = sw.warehouseID
    INNER JOIN Shipments s ON sw.shipmentID = s.shipmentID
    WHERE w.warehouseID = @warehouseID;

    RETURN @volumeOccupied;
END;

-- Alter Table Warehouses to include computed column volumeOccupied
ALTER TABLE Warehouses
ADD volumeOccupied AS dbo.CalculateVolumeOccupied(warehouseID);

----------------------------------Views-------------------------------------------------

select * from vwEmployeeDetails;
/* Employees and Departments */
CREATE VIEW vwEmployeeDetails AS
SELECT emp.employeeID, emp.firstName, emp.lastName, emp.DateOfBirth, emp.street, emp.city, emp.state, emp.zip,
       emp.hiredDate, emp.mobile, dept.departmentID, dept.departmentName
FROM Employees emp
JOIN Department dept ON emp.departmentID = dept.departmentID;


/*Finances and Transactions*/
select * from vwCustomerTransactions;
CREATE VIEW vwCustomerTransactions AS
SELECT c.customerID, c.customerRating, c.customerComments, t.transactionID, t.amount, t.quantity, t.comments AS transactionComments
FROM Customer c
LEFT JOIN Transactions t ON c.customerID = t.customerID;

/*Customer Rating and Customer and Shipments*/
CREATE VIEW vwShipmentDetails AS
SELECT s.shipmentID, s.shipmentDate, s.status, p.packagingID, p.packagingType,
       t.transportationModeID, t.modeName AS transportationModeName
FROM Shipments s
LEFT JOIN Packaging p ON s.packagingID = p.packagingID
LEFT JOIN TransportationMode t ON s.transportationModeID = t.transportationModeID;

/*Shipment and Warehouse*/
CREATE VIEW vwWarehouseDetails AS
SELECT warehouseID, warehouseCity, warehouseState, warehouseZip, volume, availableQuantity
FROM Warehouses;

------------------------------------Column Data Encryption----------------------------------------------
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'TEAM4SUMMER2023';

CREATE CERTIFICATE UserCertificate
WITH SUBJECT = 'User Certificate',
EXPIRY_DATE = '2026-12-31';

CREATE SYMMETRIC KEY UserEncryption
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE UserCertificate;

OPEN SYMMETRIC KEY UserEncryption
DECRYPTION BY CERTIFICATE UserCertificate;

---------------Trigger and Functions to Encrypt columns -----------------------------------------

-- Encrypt Password column
GO
CREATE FUNCTION dbo.EncryptPassword
(
    @Password VARCHAR(100)
)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @EncryptedPassword VARCHAR(100);
    SET @EncryptedPassword = EncryptByKey(Key_GUID('UserEncryption'), @Password);
    RETURN @EncryptedPassword;
END;

-- Encrypt Street column
GO
CREATE FUNCTION dbo.EncryptStreet
(
    @Street VARCHAR(100)
)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @EncryptedStreet VARCHAR(100);
    SET @EncryptedStreet = EncryptByKey(Key_GUID('UserEncryption'), @Street);
    RETURN @EncryptedStreet;
END;

-- Trigger to encrypt Password and street in Employees table
GO
CREATE TRIGGER Trg_EncryptEmployeeData
ON Employees
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE e
    SET password = dbo.EncryptPassword(i.password),
		street = dbo.EncryptStreet(i.street)
    FROM Employees e
    JOIN INSERTED i ON e.employeeID = i.employeeID;
END;

--------------------- Select Queries to check encrypted and decrypted columns ------------------------------
SELECT * FROM Employees;

SELECT
    employeeID,
    CONVERT(VARCHAR(100), DECRYPTBYKEY(password)) AS DecryptedPassword,
    CONVERT(VARCHAR(100), DECRYPTBYKEY(street)) AS DecryptedStreet,
	*
FROM Employees;

--------------- HouseKeeping ------------------------------------------------------------
/*

USE Team4Summer2023_Final;
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

-- Drop Foreign Key Constraints
ALTER TABLE LogisticsSystem DROP CONSTRAINT FK_LogisticsSystem_departmentID;
ALTER TABLE LogisticsSystem DROP CONSTRAINT FK_LogisticsSystem_employeeID;
ALTER TABLE LogisticsSystem DROP CONSTRAINT FK_LogisticsSystem_customerID;
ALTER TABLE LogisticsSystem DROP CONSTRAINT FK_LogisticsSystem_financesID;
ALTER TABLE LogisticsSystem DROP CONSTRAINT FK_LogisticsSystem_transactionID;
ALTER TABLE LogisticsSystem DROP CONSTRAINT FK_LogisticsSystem_shipmentID;

ALTER TABLE CustomerReviews DROP CONSTRAINT FK_CustomerReviews_shipmentID;
ALTER TABLE CustomerReviews DROP CONSTRAINT FK_CustomerReviews_customerID;

ALTER TABLE Customer DROP CONSTRAINT FK_Customer_reviewID;

ALTER TABLE Transactions DROP CONSTRAINT FK_Transactions_shipmentID;
ALTER TABLE Transactions DROP CONSTRAINT FK_Transactions_customerID;

ALTER TABLE Finances DROP CONSTRAINT FK_Finances_transactionID;

ALTER TABLE Tracking DROP CONSTRAINT FK_Tracking_transportationModeID;
ALTER TABLE Tracking DROP CONSTRAINT FK_Tracking_shipmentID;

ALTER TABLE Shipments DROP CONSTRAINT FK_Shipments_transportationModeID;
ALTER TABLE Shipments DROP CONSTRAINT FK_Shipments_packagingID;

ALTER TABLE ShipmentWarehouse DROP CONSTRAINT FK_ShipmentWarehouse_shipmentID;
ALTER TABLE ShipmentWarehouse DROP CONSTRAINT FK_ShipmentWarehouse_warehouseID;

ALTER TABLE Department DROP CONSTRAINT FK_Department_employeeID;

ALTER TABLE Employees DROP CONSTRAINT FK_Employees_departmentID;

-- Drop Check Constraints
ALTER TABLE Employees DROP CONSTRAINT CK_Employees_zip;
ALTER TABLE Company DROP CONSTRAINT CK_Company_zip;
ALTER TABLE Company DROP CONSTRAINT CK_Company_phone;
ALTER TABLE Warehouses DROP CONSTRAINT CK_Warehouses_warehouseState;

-- Drop Functions
DROP FUNCTION IF EXISTS CalculateVolumeOccupied;
DROP FUNCTION IF EXISTS GetAverageRatingForCustomerReviews;
DROP FUNCTION IF EXISTS CalculateAge;
DROP FUNCTION IF EXISTS EncryptPassword;
DROP FUNCTION IF EXISTS EncryptStreet;

-- Drop Trigger
DROP TRIGGER IF EXISTS Trg_EncryptEmployeeData;

-- Close the symmetric key
CLOSE SYMMETRIC KEY UserEncryption;
-- Drop the symmetric key
DROP SYMMETRIC KEY UserEncryption;
-- Drop the certificate
DROP CERTIFICATE UserCertificate;
--Drop the DMK
DROP MASTER KEY;

-- Drop Tables
DROP TABLE IF EXISTS ShipmentWarehouse;
DROP TABLE IF EXISTS Warehouses;
DROP TABLE IF EXISTS Shipments;
DROP TABLE IF EXISTS CustomerReviews;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Finances;
DROP TABLE IF EXISTS Tracking;
DROP TABLE IF EXISTS Packaging;
DROP TABLE IF EXISTS TransportationMode;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Employees;

-- Dropping database
DROP DATABASE IF EXISTS Team4Summer2023_Final;

*/