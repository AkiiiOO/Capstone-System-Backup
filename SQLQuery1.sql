CREATE TABLE UserStatus (StatusID INT PRIMARY KEY, 
                         StatusName VARCHAR(50));

INSERT INTO UserStatus (StatusID, StatusName) VALUES (1, 'Active');
INSERT INTO UserStatus (StatusID, StatusName) VALUES (2, 'Inactive');

SELECT * FROM UserStatus

CREATE TABLE AccessLevels (AccessLevelID INT PRIMARY KEY IDENTITY(1,1),
                           AccessLevelName VARCHAR(100)UNIQUE NOT NULL);
                         
INSERT INTO AccessLevels (AccessLevelName) VALUES ('Admin');
INSERT INTO AccessLevels (AccessLevelName) VALUES ('Service');
INSERT INTO AccessLevels (AccessLevelName) VALUES ('Inventory');

SELECT * FROM AccessLevels

CREATE TABLE Permissions (PermissionID INT PRIMARY KEY IDENTITY(1,1),
						  PermissionName VARCHAR(50)UNIQUE NOT NULL);

INSERT INTO Permissions (PermissionName) VALUES ('Full control');
INSERT INTO Permissions (PermissionName) VALUES ('Modify');
INSERT INTO Permissions (PermissionName) VALUES ('Read');
INSERT INTO Permissions (PermissionName) VALUES ('Write');

SELECT * FROM Permissions

CREATE TABLE Users (UserID INT PRIMARY KEY IDENTITY(1,1),
					Username VARCHAR(50) UNIQUE NOT NULL,
					Password VARCHAR(255) NOT NULL, 
					FirstName VARCHAR(100),
					LastName VARCHAR(100),
					Contact_No Char(11), 
					StatusID INT, 
					CreatedDate DATETIME DEFAULT GETDATE(),
					UpdatedDate DATETIME DEFAULT GETDATE(),
					FOREIGN KEY (StatusID) REFERENCES UserStatus(StatusID));
SELECT * FROM Users
							   
CREATE TABLE UserAccessLevels (UserAccessLevelID INT PRIMARY KEY IDENTITY(1,1),
							   UserID INT FOREIGN KEY REFERENCES Users(UserID),
							   AccessLevelID INT FOREIGN KEY REFERENCES AccessLevels(AccessLevelID),
							   UNIQUE(UserID, AccessLevelID));
SELECT * FROM UserAccessLevels


CREATE TABLE AccessLevelPermissions (AccessLevelPermissionID INT PRIMARY KEY IDENTITY(1,1),
									 AccessLevelID INT,
									 PermissionID INT,
									 FOREIGN KEY (AccessLevelID) REFERENCES AccessLevels(AccessLevelID),
									 FOREIGN KEY (PermissionID) REFERENCES Permissions(PermissionID));
									 

--Users
INSERT INTO Users (Username, Password, FirstName, LastName, Contact_No, StatusID)
VALUES ('admin', 'admin', 'John', 'A', '09345678911', 1);

--UserAccessLevels
INSERT INTO UserAccessLevels (UserID, AccessLevelID) VALUES (1, 1);
SELECT * FROM UserAccessLevels

--AccessLevelPermissions
INSERT INTO AccessLevelPermissions (AccessLevelID, PermissionID) VALUES (1, 1);
SELECT * FROM AccessLevelPermissions


CREATE TABLE Clients (ClientID INT IDENTITY(1,1) PRIMARY KEY,
					  UserID INT,
					  FirstName VARCHAR(100)NOT NULL,
					  MiddleInitial CHAR(1)NULL,
					  LastName VARCHAR(100)NOT NULL,
					  Address VARCHAR(200),
					  Contact_No Char(11),
					  DateCreated DATETIME DEFAULT GETDATE(),
					  CreatedBy VARCHAR(200),
					  FOREIGN KEY (UserID) REFERENCES Users (UserID));
SELECT * FROM Clients

--FOr the casket
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

--songs
CREATE TABLE Song (SongID INT IDENTITY(1,1) PRIMARY KEY,
				   UserID INT FOREIGN KEY REFERENCES Users(UserID),
                   SongName VARCHAR(100),
                   Artist VARCHAR(100),
                   CreatedBy VARCHAR(250),
                   DateCreated DATETIME DEFAULT GETDATE());
                   
INSERT INTO Song (SongName, Artist) VALUES ('Yesterday', 'The Beatles');
INSERT INTO Song (SongName, Artist) VALUES ('About You', 'The 1975');
SELECT * FROM Song

CREATE TABLE Playlists (PlaylistsID INT IDENTITY(1,1) PRIMARY KEY,
						UserID INT FOREIGN KEY REFERENCES Users(UserID),
						PlaylistsName VARCHAR(100),
						CreatedBy VARCHAR(250),
						DateCreated DATETIME DEFAULT GETDATE());

INSERT INTO Playlists (UserID, PlaylistsName, CreatedBy) VALUES (1, 'My Favorite Songs', 'John A');
INSERT INTO Playlists (UserID, PlaylistsName, CreatedBy) VALUES (1, 'Sad', 'John A');
SELECT * FROM Playlists
						
CREATE TABLE PlaylistSongs (PlaylistSongsID INT IDENTITY(1,1) PRIMARY KEY,
							SongID INT FOREIGN KEY REFERENCES Song(SongID),
							PlaylistsID INT FOREIGN KEY REFERENCES Playlists(PlaylistsID),
							DateCreated DATETIME DEFAULT GETDATE());
SELECT * FROM PlaylistSongs

-- embalming price
CREATE TABLE EmbalmingPrice (EmbalmingPriceId INT PRIMARY KEY IDENTITY(1,1),
							 IncludedDays INT NOT NULL,
							 BasePrice DECIMAL(18, 2) NOT NULL,
							 AdditionalDayCharge DECIMAL(18, 2) NOT NULL,
							 CreatedDate DATETIME DEFAULT GETDATE());
INSERT INTO EmbalmingPrice (IncludedDays, BasePrice, AdditionalDayCharge)VALUES 
							(4, 2000.00, 4000.00);
SELECT * FROM EmbalmingPrice


--FOr PAckages
CREATE TABLE Package (PackageID INT IDENTITY(1,1) PRIMARY KEY,
					  CasketID INT  FOREIGN KEY REFERENCES Casket(CasketID),
					  PlaylistsID INT FOREIGN KEY REFERENCES Playlists(PlaylistsID),
					  VehicleID INT  FOREIGN KEY REFERENCES Vehicle(VehicleID),
					  ArrangementID INT  FOREIGN KEY REFERENCES FlowerArrangements(ArrangementID),
					  PackageName VARCHAR(100),
					  CasketName VARCHAR(100),
					  VehicleName VARCHAR(100),
					  FlowerArrangementName VARCHAR(200),
					  PlaylistsName VARCHAR(100),
					  EmbalmingDays INT,
					  TotalPrice DECIMAL(10, 2),
					  CreatedDate DATETIME DEFAULT GETDATE());

					  
INSERT INTO Package (PackageName, CasketID, PlaylistsID, VehicleID, ArrangementID, CasketName, VehicleName, FlowerArrangementName,EmbalmingDays, TotalPrice) VALUES 
					('Premium Package', 1, 2, 1, 1, 'Classic Oak Casket', 'Luxury Hearse', 'White Sympathy Floor', 0, 895.00);
INSERT INTO Package (PackageName, CasketID, PlaylistsID, VehicleID, ArrangementID, CasketName, VehicleName, FlowerArrangementName,EmbalmingDays, TotalPrice) VALUES 
					('Ordinary', 2, 2, 1, 1, 'Stainless Steel Casket', 'Luxury Hearse', 'White Sympathy Floor', 0, 1195.00);

SELECT * FROM Package

CREATE TABLE CustomizePackage (CustomizePackageID INT IDENTITY(1,1) PRIMARY KEY,
							   PackageID INT  FOREIGN KEY REFERENCES Package(PackageID),
							   CasketID INT  FOREIGN KEY REFERENCES Casket(CasketID),
							   VehicleID INT  FOREIGN KEY REFERENCES Vehicle(VehicleID),
							   ArrangementID INT  FOREIGN KEY REFERENCES FlowerArrangements(ArrangementID),
							   PlaylistSongsID INT FOREIGN KEY REFERENCES PlaylistSongs(PlaylistSongsID),
							   PackageName VARCHAR(100),
							   CasketName VARCHAR(100),
							   VehicleName VARCHAR(100),
							   FlowerArrangementName VARCHAR(200),
							   PlaylistsName VARCHAR(100),
							   EmbalmingDays INT,
							   TotalPrice DECIMAL(10, 2),
							   CreatedDate DATETIME DEFAULT GETDATE());
SELECT * FROM CustomizePackage

CREATE TABLE DocumentType (DocumentTypeID INT IDENTITY(1,1) PRIMARY KEY,
						   DocumentTypeName VARCHAR(100) NOT NULL);

INSERT INTO DocumentType (DocumentTypeName)VALUES ('Death Certificate'),
												  ('Medical Certificate');
SELECT * FROM DocumentType

CREATE TABLE ServiceStatus (ServiceStatusID INT IDENTITY(1,1) PRIMARY KEY,
							StatusName VARCHAR(50) NOT NULL);
INSERT INTO ServiceStatus (StatusName) VALUES ('Pending'), 
											  ('Ongoing'),
											  ('Completed'), 
											  ('Cancelled');
SELECT * FROM ServiceStatus

CREATE TABLE Cemeteries (CemeteryID INT IDENTITY(1,1) PRIMARY KEY,
						 CemeteryName VARCHAR(200) NOT NULL,
						 Location VARCHAR(250),
						 CreatedBy VARCHAR(250),
						 CreationDate DATETIME DEFAULT GETDATE());
INSERT INTO Cemeteries (CemeteryName, Location, CreatedBy) VALUES ('Tarlac Cemetery', 'Tarlac City', 'Admin'),
																  ('Tarlac Cemetery 2', 'Tarlac city', 'Admin');



CREATE TABLE Chapel (ChapelID INT IDENTITY(1,1) PRIMARY KEY,
					 ChapelName VARCHAR(100) NOT NULL,
					 Capacity INT,
					 Location VARCHAR(200),
					 Price DECIMAL(10, 2));

INSERT INTO Chapel (ChapelName, Capacity, Location, Price)	VALUES ('Chapel 1', 100, 'dito', 4000.00),
														   ('Chapel 2', 50, 'dyan', 4000.00); 
SELECT * FROM Chapel

CREATE TABLE ServiceType (ServiceTypeID INT IDENTITY(1,1) PRIMARY KEY,
						  ServiceTypeName VARCHAR(100) NOT NULL);
						  
-- Insert predefined service types
INSERT INTO ServiceType (ServiceTypeName) VALUES ('Home Service'), 
												 ('Chapel Service');
SELECT * FROM ServiceType

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
								ClientID INT NOT NULL FOREIGN KEY REFERENCES Clients(ClientID),
								ServiceTypeID INT NULL FOREIGN KEY REFERENCES ServiceType(ServiceTypeID),
								ReservationStatusID INT NULL FOREIGN KEY REFERENCES ReservationStatus(ReservationStatusID),
								ServiceTypeName VARCHAR(100) NULL,
								StartDate DATE NOT NULL,
								EndDate DATE NOT NULL,
								Location VARCHAR(200) NULL,
								ReservedBy VARCHAR(100)NOT NULL,
								DateCreated DATETIME DEFAULT GETDATE());
SELECT * FROM ChapelReservation


-- done
CREATE TABLE ServiceRequests (ServiceRequestID INT IDENTITY(1,1) PRIMARY KEY,    
							  UserID INT FOREIGN KEY REFERENCES Users(UserID),
							  ClientID INT FOREIGN KEY REFERENCES Clients(ClientID),
							  ServiceStatusID INT FOREIGN KEY REFERENCES ServiceStatus(ServiceStatusID),
							  ServiceTypeID INT FOREIGN KEY REFERENCES ServiceType(ServiceTypeID),
							  CemeteryID INT FOREIGN KEY REFERENCES Cemeteries(CemeteryID),
							  DocumentTypeID INT FOREIGN KEY REFERENCES DocumentType(DocumentTypeID),
							  ReservationID INT FOREIGN KEY REFERENCES ChapelReservation(ReservationID),
							  DiscountID INT FOREIGN KEY REFERENCES Discounts(DiscountID),
							  
							  --package 
							  CopPackageID INT  FOREIGN KEY REFERENCES Package(PackageID),
							  CopCasketID INT FOREIGN KEY REFERENCES Casket(CasketID),
							  CopVehicleID INT FOREIGN KEY REFERENCES Vehicle(VehicleID),
							  CopArrangementID INT FOREIGN KEY REFERENCES FlowerArrangements(ArrangementID),
							  CopPlaylistID INT FOREIGN KEY REFERENCES PlaylistSongs(PlaylistSongsID),
						    
						      -- Service type 
						      ServiceType VARCHAR(100),
						      
							  -- Client and deceased information
							  ClientName VARCHAR(250),
							  DeceasedFName VARCHAR(100) NOT NULL, 
							  DeceasedLName VARCHAR(100) NOT NULL, 
							  DeceasedMInitial VARCHAR(50)NULL,

							  -- Package information
							  PackageName VARCHAR(100),
							  CasketName VARCHAR(100), 
							  VehicleName VARCHAR(100), 
							  FlowerArrangementName VARCHAR(200),
							  PlaylistName VARCHAR(100), 
							  ChapelName VARCHAR(100), 
							  Location VARCHAR(200),
						    
							  -- Burial and service details
							  CemeteryLocation VARCHAR(200),
							  DateBurial DATE, 
							  TimeBurial TIME,  
							  Address VARCHAR(200),
							  
							  DocumentType VARCHAR(100),
							  DocumentImage IMAGE,
						    
							  -- Service specifics
							  EmbalmingDays INT,
							  TotalPrice DECIMAL(10, 2),
							  --Discount
							  Discount VARCHAR(100),
							  DiscountRate DECIMAL(10, 2),
							  DiscountTotal DECIMAL(10, 2),
						    
							  -- Auditing details
							  CreationDate DATETIME DEFAULT GETDATE(), 
							  CreatedBy VARCHAR(250));
SELECT * FROM ServiceRequests

CREATE TABLE Discounts (DiscountID INT IDENTITY(1,1) PRIMARY KEY,
						DiscountName VARCHAR(100) NOT NULL,       
						DiscountRate DECIMAL(5, 2) NOT NULL,      
						CreatedAt DATETIME DEFAULT GETDATE());

INSERT INTO Discounts (DiscountName, DiscountRate) VALUES ('Senior Citizen Discount', 10.00);

SELECT * FROM Discounts

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
					   TotalPrice DECIMAL(10, 2) NOT NULL,
				   
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
									 ServiceRequestID INT NOT NULL FOREIGN KEY REFERENCES ServiceRequests(ServiceRequestID));
SELECT * FROM PaymentServiceRequests



