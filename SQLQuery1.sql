CREATE TABLE UserStatus (StatusID INT PRIMARY KEY, 
                         StatusName VARCHAR(50));

INSERT INTO UserStatus (StatusID, StatusName) VALUES (1, 'Actived');
INSERT INTO UserStatus (StatusID, StatusName) VALUES (2, 'Deactivated');

SELECT * FROM UserStatus

CREATE TABLE AccessLevels (AccessLevelID INT PRIMARY KEY IDENTITY(1,1),
                           AccessLevelName VARCHAR(100)UNIQUE NOT NULL);
                         
INSERT INTO AccessLevels (AccessLevelName) VALUES ('Admin');
INSERT INTO AccessLevels (AccessLevelName) VALUES ('Service');
INSERT INTO AccessLevels (AccessLevelName) VALUES ('Inventory');

SELECT * FROM AccessLevels

CREATE TABLE Users (UserID INT PRIMARY KEY IDENTITY(1,1),
					Username VARCHAR(50) UNIQUE NOT NULL,
					Password VARCHAR(255) NOT NULL, 
					FirstName VARCHAR(255),
					LastName VARCHAR(255),
					Contact_No Char(11), 
					SecurityAnswer VARCHAR(255),
					StatusID INT, 
					CreatedDate DATETIME DEFAULT GETDATE(),
					FOREIGN KEY (StatusID) REFERENCES UserStatus(StatusID));
SELECT * FROM Users

--Users
INSERT INTO Users (Username, Password, FirstName, LastName, Contact_No, SecurityAnswer, StatusID, CreatedDate)
VALUES ('admin', 'admin', 'John', 'A', '09999999999', 'buggles', 1, GETDATE());

CREATE TABLE UserAccessLevels (UserAccessLevelID INT PRIMARY KEY IDENTITY(1,1),
							   UserID INT FOREIGN KEY REFERENCES Users(UserID)ON DELETE CASCADE,
							   AccessLevelID INT FOREIGN KEY REFERENCES AccessLevels(AccessLevelID),
							   UNIQUE(UserID, AccessLevelID));
SELECT * FROM UserAccessLevels

INSERT INTO UserAccessLevels (UserID, AccessLevelID) VALUES (1, 1);
SELECT * FROM UserAccessLevels

CREATE TABLE UserLog (LogID INT PRIMARY KEY IDENTITY(1,1),
					  UserID INT FOREIGN KEY REFERENCES Users(UserID)ON DELETE SET NULL,
					  LoginDateTime DATETIME DEFAULT GETDATE(),
					  LogoutDateTime DATETIME NULL);

SELECT * FROM UserLog


CREATE TABLE Clients (ClientID INT IDENTITY(1,1) PRIMARY KEY,
					  UserID INT,
					  FirstName VARCHAR(100)NOT NULL,
					  MiddleName VARCHAR(100)NULL,
					  LastName VARCHAR(100)NOT NULL,
					  Address VARCHAR(200),
					  Contact_No Char(11),
					  DateCreated DATETIME DEFAULT GETDATE(),
					  CreatedBy VARCHAR(200),
					  FOREIGN KEY (UserID) REFERENCES Users (UserID)ON DELETE SET NULL);
SELECT * FROM Clients

--FOr the casket
--maintenance
CREATE TABLE CasketType (CasketTypeID INT IDENTITY(1,1) PRIMARY KEY,
						 CasketTypeName VARCHAR(50));

INSERT INTO CasketType (CasketTypeName) VALUES ('Ordinary'),
											  ('Semi-ordinary'),
											  ('First-class ');
SELECT * FROM CasketType

CREATE TABLE Casket (CasketID INT IDENTITY(1,1) PRIMARY KEY,
					 CasketTypeID INT FOREIGN KEY REFERENCES CasketType(CasketTypeID),
					 CasketImage IMAGE,
					 CasketName VARCHAR(100),
					 Price DECIMAL(10, 2));	
INSERT INTO Casket (CasketTypeID, CasketImage, CasketName, Price)VALUES (1, NULL, 'Classic Oak Casket', 600.00),
																		(2, NULL, 'Stainless Steel Casket', 900.00);
SELECT * FROM Casket	 									
--For the Vehicle
--maintenance
CREATE TABLE VehicleType (VehicleTypeID INT IDENTITY(1,1) PRIMARY KEY,
						  VehicleTypeName VARCHAR(50));
						  
INSERT INTO VehicleType (VehicleTypeName) VALUES ('Hearse'),
												 ('Van');
SELECT * FROM VehicleType

CREATE TABLE Vehicle (VehicleID INT IDENTITY(1,1) PRIMARY KEY,
					  VehicleTypeID INT FOREIGN KEY REFERENCES VehicleType(VehicleTypeID),
					  VehicleImage IMAGE,
					  VehicleName VARCHAR(100),
					  Price DECIMAL(10, 2));
INSERT INTO Vehicle (VehicleTypeID, VehicleImage, VehicleName, Price) VALUES (1, NULL, 'car1', 250.00),
																			 (2, NULL, 'car2', 150.00);
SELECT * FROM Vehicle		  
-- For the Flower Arrangement
--maintenance
CREATE TABLE FlowerArrangementsType (ArrangementTypeID INT IDENTITY(1,1) PRIMARY KEY,
									 ArrangementTypeName VARCHAR(100));
									 
INSERT INTO FlowerArrangementsType (ArrangementTypeName)VALUES ('Bouquet'),
															   ('Wreath');
									 
CREATE TABLE FlowerArrangements (ArrangementID INT IDENTITY(1,1) PRIMARY KEY,
							 	 ArrangementTypeID INT FOREIGN KEY REFERENCES FlowerArrangementsType(ArrangementTypeID),
								 ArrangementImage IMAGE,
							 	 ArrangementName VARCHAR(200),
								 Price DECIMAL(10, 2));
								 
INSERT INTO FlowerArrangements (ArrangementTypeID, ArrangementImage, ArrangementName, Price) VALUES (1, NULL, 'White Sympathy Floor', 45.00),
																								    (2, NULL, 'Tulip Centerpiece', 55.00);
SELECT * FROM FlowerArrangements

-- embalming price
--maintenance
CREATE TABLE EmbalmingPrice (EmbalmingPriceId INT PRIMARY KEY IDENTITY(1,1),
							 IncludedDays INT NOT NULL,
							 BasePrice DECIMAL(18, 2) NOT NULL,
							 AdditionalDayCharge DECIMAL(18, 2) NOT NULL,
							 CreatedDate DATETIME DEFAULT GETDATE());
INSERT INTO EmbalmingPrice (IncludedDays, BasePrice, AdditionalDayCharge)VALUES 
							(4, 2000.00, 4000.00);
SELECT * FROM EmbalmingPrice

--maintencnce
CREATE TABLE EquipmentQuality (EquipmentQualityID INT IDENTITY(1,1) PRIMARY KEY,
							   Quality VARCHAR(100));
INSERT INTO EquipmentQuality (Quality) VALUES('Ordinary'),
											 ('First Class'),
											 ('Semi-Imported');

CREATE TABLE EquipmentCondition (EquipmentConditionID INT IDENTITY(1,1) PRIMARY KEY,
								 Condition VARCHAR(100));
INSERT INTO EquipmentCondition (Condition) VALUES('New'),
												 ('Good'),
												 ('Damaged');

--maintencnce
CREATE TABLE Equipment (EquipmentID INT IDENTITY(1,1) PRIMARY KEY,
						EquipmentQualityID INT FOREIGN KEY REFERENCES EquipmentQuality(EquipmentQualityID),
						EquipmentConditionID INT FOREIGN KEY REFERENCES EquipmentCondition(EquipmentConditionID),
						EquipmentName VARCHAR(200),
						EquipmentType VARCHAR(100),
						EquipmentQuality VARCHAR(100),
						EquipmentCondition VARCHAR(100),
						Quantity INT,
						DamageNote VARCHAR(Max),
						CreatedDate DATETIME DEFAULT GETDATE());
						
INSERT INTO Equipment (EquipmentName, EquipmentType, EquipmentQualityID, EquipmentConditionID, Quantity, DamageNote) VALUES
						('Religion Stand Board', 'Stand', 1, 1, 10, NULL),
						('Lights Silver', 'Light', 2, 2, 5, NULL),
						('Casket Stand', 'Casket Stand', 3, 1, 20, 'Minor damage from usage');
SELECT * FROM Equipment

--FOr PAckages
CREATE TABLE Package (PackageID INT IDENTITY(1,1) PRIMARY KEY,
					  CasketID INT  FOREIGN KEY REFERENCES Casket(CasketID)ON DELETE CASCADE,
					  VehicleID INT  FOREIGN KEY REFERENCES Vehicle(VehicleID),
					  PackageName VARCHAR(100),
					  CasketName VARCHAR(100),
					  VehicleName VARCHAR(100),
					  EmbalmingDays INT,
					  TotalPrice DECIMAL(10, 2),
					  CreatedDate DATETIME DEFAULT GETDATE());
SELECT * FROM Package

INSERT INTO Package (PackageName, CasketID, VehicleID, CasketName, VehicleName, EmbalmingDays, TotalPrice) VALUES 
					('Premium Package', 1, 1, 'Classic Oak Casket', 'Luxury Hearse', 9, 1000.00);


CREATE TABLE PackageFlowerArrangements (PackageFlowerArrangementID INT IDENTITY(1,1) PRIMARY KEY,
										PackageID INT FOREIGN KEY REFERENCES Package(PackageID),
										ArrangementID INT FOREIGN KEY REFERENCES FlowerArrangements(ArrangementID),
										FlowerArrangementName VARCHAR(200),
										Quantity INT,  
										PricePerUnit DECIMAL(10, 2));
SELECT * FROM PackageFlowerArrangements
	   
CREATE TABLE PackageEquipments (PackageEquipmentID INT IDENTITY(1,1) PRIMARY KEY,
								PackageID INT FOREIGN KEY REFERENCES Package(PackageID),
								EquipmentID INT FOREIGN KEY REFERENCES Equipment(EquipmentID),
								EquipmentQualityID INT FOREIGN KEY REFERENCES EquipmentQuality(EquipmentQualityID),
								EquipmentConditionID INT FOREIGN KEY REFERENCES EquipmentCondition(EquipmentConditionID),
								EquipmentName VARCHAR(200),
								EquipmentType VARCHAR(100),
								EquipmentQuality VARCHAR(100),
								EquipmentCondition VARCHAR(100),
								Quantity INT,
								DamageNote VARCHAR(Max));
SELECT * FROM PackageEquipments


CREATE TABLE CustomizePackage (CustomizePackageID INT IDENTITY(1,1) PRIMARY KEY,
							   PackageID INT  FOREIGN KEY REFERENCES Package(PackageID)ON DELETE CASCADE,
							   CasketID INT  FOREIGN KEY REFERENCES Casket(CasketID),
							   VehicleID INT  FOREIGN KEY REFERENCES Vehicle(VehicleID),
							   PackageName VARCHAR(100),
							   CasketName VARCHAR(100),
							   VehicleName VARCHAR(100),
							   EmbalmingDays INT,
							   TotalPrice DECIMAL(10, 2),
							   CreatedDate DATETIME DEFAULT GETDATE());
SELECT * FROM CustomizePackage

CREATE TABLE CustomizePackageFlowerArrangements (CustomizePackageFlowerArrangementID INT IDENTITY(1,1) PRIMARY KEY,
												 CustomizePackageID INT FOREIGN KEY REFERENCES CustomizePackage(CustomizePackageID),
												 ArrangementID INT FOREIGN KEY REFERENCES FlowerArrangements(ArrangementID),
												 FlowerArrangementName VARCHAR(200),
												 Quantity INT, 
												 PricePerUnit DECIMAL(10, 2));
SELECT * FROM CustomizePackageFlowerArrangements


CREATE TABLE CustomizePackageEquipments (CustomizePackageEquipmentID INT IDENTITY(1,1) PRIMARY KEY,
										 CustomizePackageID INT FOREIGN KEY REFERENCES CustomizePackage(CustomizePackageID),
										 EquipmentID INT FOREIGN KEY REFERENCES Equipment(EquipmentID),
										 EquipmentQualityID INT FOREIGN KEY REFERENCES EquipmentQuality(EquipmentQualityID),
										 EquipmentConditionID INT FOREIGN KEY REFERENCES EquipmentCondition(EquipmentConditionID),
										 EquipmentName VARCHAR(200),
										 EquipmentType VARCHAR(100),
										 EquipmentQuality VARCHAR(100),
										 EquipmentCondition VARCHAR(100),
										 Quantity INT,
										 DamageNote VARCHAR(Max));
SELECT * FROM CustomizePackageEquipments



CREATE TABLE ServiceStatus (ServiceStatusID INT IDENTITY(1,1) PRIMARY KEY,
							StatusName VARCHAR(50) NOT NULL);
INSERT INTO ServiceStatus (StatusName) VALUES ('Pending'), 
											  ('Ongoing'),
											  ('Completed'), 
											  ('Cancelled');
SELECT * FROM ServiceStatus

--maintenance
CREATE TABLE Cemeteries (CemeteryID INT IDENTITY(1,1) PRIMARY KEY,
						 CemeteryName VARCHAR(200) NOT NULL,
						 Location VARCHAR(250),
						 CreatedBy VARCHAR(250),
						 CreationDate DATETIME DEFAULT GETDATE());
INSERT INTO Cemeteries (CemeteryName, Location, CreatedBy) VALUES ('Tarlac Cemetery', 'Tarlac City', 'Admin'),
																  ('Tarlac Cemetery 2', 'Tarlac city', 'Admin');

--maintenance
CREATE TABLE Chapel (ChapelID INT IDENTITY(1,1) PRIMARY KEY,
					 ChapelName VARCHAR(100) NOT NULL,
					 Capacity INT,
					 Location VARCHAR(200),
					 Price DECIMAL(10, 2));

INSERT INTO Chapel (ChapelName, Capacity, Location, Price)	VALUES ('Chapel 1', 100, 'dito', 4000.00),
														   ('Chapel 2', 50, 'dyan', 4000.00); 
SELECT * FROM Chapel


CREATE TABLE ReservationStatus (ReservationStatusID INT IDENTITY(1,1) PRIMARY KEY,
								StatusName VARCHAR(50) NOT NULL);
								
INSERT INTO ReservationStatus (StatusName) VALUES ('Pending');
INSERT INTO ReservationStatus (StatusName) VALUES ('Confirmed');
INSERT INTO ReservationStatus (StatusName) VALUES ('Canceled');
INSERT INTO ReservationStatus (StatusName) VALUES ('Completed');

SELECT * FROM ReservationStatus

--okay na
CREATE TABLE ChapelReservation (ReservationID INT IDENTITY(1,1) PRIMARY KEY,   
								ChapelID INT Null FOREIGN KEY REFERENCES Chapel(ChapelID),    
								ClientID INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientID)ON DELETE CASCADE,
								ReservationStatusID INT NULL FOREIGN KEY REFERENCES ReservationStatus(ReservationStatusID),
								StartDate DATE NOT NULL,
								EndDate DATE NOT NULL,
								ReservedBy VARCHAR(100)NOT NULL,
								DateCreated DATETIME DEFAULT GETDATE());
SELECT * FROM ChapelReservation

--maintenance
CREATE TABLE Discounts (DiscountID INT IDENTITY(1,1) PRIMARY KEY,
						DiscountName VARCHAR(100) NOT NULL,       
						DiscountRate DECIMAL(5, 2) NOT NULL,      
						CreatedAt DATETIME DEFAULT GETDATE());

INSERT INTO Discounts (DiscountName, DiscountRate) VALUES ('Senior Citizen Discount', 10.00);

SELECT * FROM Discounts
CREATE TABLE EquipmentStatus (EquipmentStatusID INT IDENTITY(1,1) PRIMARY KEY,
								StatusName VARCHAR(50) NOT NULL UNIQUE);

INSERT INTO EquipmentStatus (StatusName) VALUES ('Pending'),
												('Reserved'), 
												('Released'), 
												('Returned');
SELECT * FROM EquipmentStatus

-- fixing
CREATE TABLE ServiceRequests (ServiceRequestID INT IDENTITY(1,1) PRIMARY KEY,    
							  UserID INT FOREIGN KEY REFERENCES Users(UserID)ON DELETE SET NULL,
							  ClientID INT FOREIGN KEY REFERENCES Clients(ClientID)ON DELETE CASCADE,
							  ServiceStatusID INT FOREIGN KEY REFERENCES ServiceStatus(ServiceStatusID),
							  CemeteryID INT FOREIGN KEY REFERENCES Cemeteries(CemeteryID),
							  ReservationID INT FOREIGN KEY REFERENCES ChapelReservation(ReservationID),
							  DiscountID INT FOREIGN KEY REFERENCES Discounts(DiscountID),
							  
							  --package 
							  CopPackageID INT  FOREIGN KEY REFERENCES Package(PackageID),
							  CopCasketID INT FOREIGN KEY REFERENCES Casket(CasketID)ON DELETE SET NULL,
							  CopVehicleID INT FOREIGN KEY REFERENCES Vehicle(VehicleID)ON DELETE SET NULL,
						    
						      
							  -- Client and deceased information
							  ClientName VARCHAR(250),
							  Address VARCHAR(200),
							  DeceasedFName VARCHAR(100) NOT NULL, 
							  DeceasedLName VARCHAR(100) NOT NULL, 
							  DeceasedMName VARCHAR(100)NULL,

							  -- Package information
							  PackageName VARCHAR(100),
							  CasketName VARCHAR(100), 
							  VehicleName VARCHAR(100), 
						    
							  -- Burial and service details
							  ServiceLocation VARCHAR(200),
							  CemeteryLocation VARCHAR(200),
							  DateBurial DATE, 
							  TimeBurial TIME,  
							  
							  
							  Document VARCHAR(100),
							  DocumentImage IMAGE,
						    
							  -- Service specifics
							  EmbalmingDays INT,
							  SubTotal DECIMAL(10, 2),
							  
							  --Discount
							  Discount VARCHAR(100),
							  DiscountRate DECIMAL(10, 2),
							  DiscountTotal DECIMAL(10, 2),
							  TotalPrice DECIMAL(10, 2),
						    
							  -- Auditing details
							  CreationDate DATETIME DEFAULT GETDATE(), 
							  CreatedBy VARCHAR(250));
SELECT * FROM ServiceRequests
CREATE TABLE ServiceRequestsFlowerArrangements (ServiceRequestsFlowerArrangementID INT IDENTITY(1,1) PRIMARY KEY,
												ServiceRequestID INT FOREIGN KEY REFERENCES ServiceRequests(ServiceRequestID)ON DELETE SET NULL,
												ArrangementID INT FOREIGN KEY REFERENCES FlowerArrangements(ArrangementID),
												FlowerArrangementName VARCHAR(200),
												Quantity INT, 
												PricePerUnit DECIMAL(10, 2));
SELECT * FROM ServiceRequestsFlowerArrangements

CREATE TABLE ServiceRequestsPackageEquipments (ServiceRequestsPackageEquipmentID INT IDENTITY(1,1) PRIMARY KEY,
											   ServiceRequestID INT FOREIGN KEY REFERENCES ServiceRequests(ServiceRequestID)ON DELETE SET NULL,
											   EquipmentID INT FOREIGN KEY REFERENCES Equipment(EquipmentID),
											   EquipmentStatusID INT FOREIGN KEY REFERENCES EquipmentStatus(EquipmentStatusID),
											   EquipmentQualityID INT FOREIGN KEY REFERENCES EquipmentQuality(EquipmentQualityID),
											   EquipmentConditionID INT FOREIGN KEY REFERENCES EquipmentCondition(EquipmentConditionID),
											   EquipmentName VARCHAR(200),
											   EquipmentType VARCHAR(100),
											   EquipmentQuality VARCHAR(100),
											   EquipmentCondition VARCHAR(100),
											   Quantity INT,
											   DamageNote VARCHAR(Max));
SELECT * FROM ServiceRequestsPackageEquipments


CREATE TABLE PaymentOptions (PaymentOptionID INT IDENTITY(1,1) PRIMARY KEY,
							 PaymenOptionName VARCHAR(100) NOT NULL UNIQUE);

INSERT INTO PaymentOptions (PaymenOptionName) VALUES ('Full Payment');
INSERT INTO PaymentOptions (PaymenOptionName) VALUES ('Installment');

SELECT * FROM PaymentOptions
							 
CREATE TABLE PaymentStatus (PaymentStatusID INT IDENTITY(1,1) PRIMARY KEY,
							PaymentStatusName VARCHAR(100) NOT NULL UNIQUE);
							
INSERT INTO PaymentStatus (PaymentStatusName) VALUES ('Pending');
INSERT INTO PaymentStatus (PaymentStatusName) VALUES ('Partially Paid');
INSERT INTO PaymentStatus (PaymentStatusName) VALUES ('Paid');
INSERT INTO PaymentStatus (PaymentStatusName) VALUES ('OverDue');
SELECT * FROM PaymentStatus

--maintenance
CREATE TABLE InstallmentPlans (InstallmentPlanID INT IDENTITY(1,1) PRIMARY KEY,
							   PlanName VARCHAR(50) NOT NULL,         
							   NumberOfPayments INT NOT NULL,        
							   PaymentInterval VARCHAR(50) NOT NULL);
							   
INSERT INTO InstallmentPlans (PlanName, NumberOfPayments, PaymentInterval)VALUES
							 ('2 Payments (Monthly)', 2, 'Monthly'),
							 ('4 Payments (Monthly)', 4, 'Monthly'),
							 ('6 Payments (Monthly)', 6, 'Monthly');

SELECT * FROM InstallmentPlans


-- payment 
CREATE TABLE Payments (PaymentID INT IDENTITY(1,1) PRIMARY KEY,
					   PaymentOptionID INT NOT NULL FOREIGN KEY REFERENCES PaymentOptions(PaymentOptionID),
					   PaymentStatusID INT NOT NULL FOREIGN KEY REFERENCES PaymentStatus(PaymentStatusID),
					   DiscountID INT NULL FOREIGN KEY REFERENCES Discounts(DiscountID),
					   InstallmentPlanID INT NULL FOREIGN KEY REFERENCES InstallmentPlans(InstallmentPlanID),
						   
						--charge to
					   ClientName VARCHAR(250) NOT NULL,
					   Subtotal DECIMAL(10, 2) NOT NULL,
				   
					   --discount information
					   DiscountApplied VARCHAR(100) NULL, 
					   DiscountAmount DECIMAL(10, 2) NULL,
					   FinalPrice DECIMAL(10, 2) NOT NULL,
						   
					   --payment option
					   PaymentOption VARCHAR(100) NOT NULL,
						   
					   --Installment Payment Details
					   InstallmentPlan VARCHAR(100) NULL, 
						   
					   --Payment Information
					   AmountPaid DECIMAL(10, 2)NOT NULL,
					   RemainingBalance DECIMAL(10, 2)NOT NULL,
						   
					   -- Audit information
					   CreatedBy VARCHAR(250) NOT NULL,
					   PaymentDate DATETIME DEFAULT GETDATE());
SELECT * FROM Payments   
					   
CREATE TABLE Installments (InstallmentID INT IDENTITY(1,1) PRIMARY KEY,
						   PaymentID INT NOT NULL FOREIGN KEY REFERENCES Payments(PaymentID),
						   PaymentStatusID INT NOT NULL FOREIGN KEY REFERENCES PaymentStatus(PaymentStatusID),
						   InstallmentNumber INT NOT NULL,
						   DueDate DATE NOT NULL,
						   Amount DECIMAL(10, 2) NOT NULL,
						   AmountPaid DECIMAL(10, 2) NOT NULL,
						   CreatedBy VARCHAR(250) NOT NULL,
						   PaymentDate DATETIME DEFAULT GETDATE());
SELECT * FROM Installments 

CREATE TABLE PaymentServiceRequests (PaymentServiceRequestID INT IDENTITY(1,1) PRIMARY KEY,
									 PaymentID INT NOT NULL FOREIGN KEY REFERENCES Payments(PaymentID),
									 ServiceRequestID INT NOT NULL FOREIGN KEY REFERENCES ServiceRequests(ServiceRequestID)ON DELETE CASCADE);
SELECT * FROM PaymentServiceRequests


--maintenance
CREATE TABLE InterestRate (InterestRateID INT IDENTITY(1,1) PRIMARY KEY,
						   InterestRate DECIMAL(5, 2) NOT NULL ,
							LastUpdated DATETIME DEFAULT GETDATE());

INSERT INTO InterestRate (InterestRate) VALUES (5.00);

SELECT * FROM InterestRate

--maintenance
CREATE TABLE Employees (EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
						FirstName VARCHAR(255) ,
						LastName VARCHAR(255) ,
						Contact_No CHAR(11) ,
						HireDate DATE );
INSERT INTO Employees (FirstName, LastName, Contact_No, HireDate)
VALUES 
('John', 'asd',  '09171234567', '2024-11-21'),
('asd', 'asd', '09181234567', '2023-06-15');
SELECT * FROM Employees


--wag muna 
CREATE TABLE EquipmentRelease (EquipmentReleaseID INT IDENTITY(1,1) PRIMARY KEY,
								ServiceRequestID INT FOREIGN KEY REFERENCES ServiceRequests(ServiceRequestID)ON DELETE SET NULL,
								EquipmentStatusID INT FOREIGN KEY REFERENCES EquipmentStatus(EquipmentStatusID),
								EquipmentID INT FOREIGN KEY REFERENCES Equipment(EquipmentID),
								Quantity INT NOT NULL,
								ReleaseDate DATETIME DEFAULT GETDATE(),
								ReturnDate DATETIME NULL,
								ReleasedBy VARCHAR(100),
								ReturnedBy VARCHAR(100));
SELECT * FROM EquipmentRelease