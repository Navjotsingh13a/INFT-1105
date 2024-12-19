/*
Author: Navjot Singh, Akmal Hameed and Sarabhjodh Singh Baweja 
Date: March 8, 2024
Course: INFT 1105
*/

USE VETCLINIC;

DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Species;
DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Vet;

CREATE TABLE Vet (
    VetID INT IDENTITY(1,1) PRIMARY KEY,
    VetFirstName VARCHAR(50) NOT NULL,
    VetLastName VARCHAR(50) NOT NULL,
    Seniority VARCHAR(20) NOT NULL,
    StartDate DATE NOT NULL,
    DOB DATE NOT NULL,
    Specialization VARCHAR(50) NOT NULL
);

CREATE TABLE Species (
    SpeciesID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50)
);

CREATE TABLE Client (
    ClientID INT IDENTITY(1,1) PRIMARY KEY,
    ClientFirstName VARCHAR(50) NOT NULL,
    ClientLastName VARCHAR(50) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NOT NULL
);


CREATE TABLE Patient (
    PatientID INT IDENTITY(1,1) PRIMARY KEY,
	VetID INT,
    Name VARCHAR(50),
    DOB DATE,
    ClientID INT,
    Breed VARCHAR(50),
    Color VARCHAR(50),
    Altered BIT, -- Changed "Binary" to "BIT"
    SpeciesID INT,
	FOREIGN KEY (VetID) REFERENCES Vet(VetID),
	FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID),
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID)
);

-- Vet table inserts
INSERT INTO Vet (VetFirstName, VetLastName, Seniority, StartDate, DOB, Specialization) VALUES
    ('Peter', 'Hoogers', 'Owner', '1990-09-23', '1972-06-12', 'Veterinarian'),
    ('Emily', 'Carr', 'Level 5', '1999-06-14', '1989-02-05', 'Veterinarian'),
    ('Cindy', 'Iqqbal', 'Level 3', '2021-11-28', '1991-08-17', 'Veterinarian'),
    ('Eric', 'Marlow', 'Level 2', '2022-10-02', '1998-05-20', 'Veterinarian'),
    ('Navjot', 'Singh', 'Level 1', '1800-01-05', '1950-05-05', 'Veterinarian');

-- Client table inserts
INSERT INTO Client (ClientFirstName, ClientLastName, Phone, Email) VALUES
    ('Jennifer', 'Short', '9054873829', 'jennifer.short@durhamcolllege.ca'),
    ('Sherry', 'Teller', '4168574933', 's.teller@gmail.com'),
    ('Kevin', 'Butler', '9058473374', 'butler123@gmail.com'),
    ('Sarabh', 'singh', '9866847887', 'sarabh@gmail.com');
  
 -- Species table inserts
INSERT INTO Species (Name) VALUES
    ('Dog'),
    ('Cat'),
    ('Bird'),
    ('Pigeon');

-- Patient table inserts
INSERT INTO Patient (VetID, Name, DOB, ClientID, Breed, Color, Altered, SpeciesID) VALUES
    (1, 'Goose', '2019-06-17', 1, 'Labrador Retriever', 'Black', 1, 1),
    (3, 'Bruce', '2021-05-23', 1, 'Newfoundlander', 'Brown', 0, 2),
    (2, 'Sheamus', '1998-07-15', 1, 'American Foxhound', 'Brown and white', 1, 3),
    (1, 'Mary Kate', '1995-02-26', 2, 'Tabby', 'Grey', 1, 3),
    (4, 'Kyle', '1667-02-24' ,3, 'Australian', 'Blue', 0,3);

