USE master;
GO

CREATE DATABASE VolunteerDB;
GO

USE VolunteerDB;
GO

SELECT DB_NAME() AS CurrentDatabase;

CREATE TABLE Volunteer (
    volunteerId INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    phone NVARCHAR(20),
    email NVARCHAR(100) UNIQUE,
    skills NVARCHAR(200),
    interests NVARCHAR(200),
    freeTime NVARCHAR(100),
    points INT DEFAULT 0
);

CREATE TABLE Organizer (
    organizerId INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) UNIQUE,
    organization NVARCHAR(150)
);

USE VolunteerDB;
GO

CREATE TABLE Event (
    eventId INT PRIMARY KEY IDENTITY(1,1),
    title NVARCHAR(150) NOT NULL,
    description NVARCHAR(500),
    [date] DATETIME2 NOT NULL,
    location NVARCHAR(200),
    requiredSkills NVARCHAR(200),
    availablePlaces INT NOT NULL
        CHECK (availablePlaces >= 0),
    organizerId INT NOT NULL,
    FOREIGN KEY (organizerId)
        REFERENCES Organizer(organizerId)
);

USE VolunteerDB;
GO

CREATE TABLE Application (
    applicationId INT PRIMARY KEY IDENTITY(1,1),
    applicationDate DATETIME2 DEFAULT GETDATE(),
    status NVARCHAR(20) NOT NULL DEFAULT 'Pending',
    volunteerId INT NOT NULL,
    eventId INT NOT NULL,

    FOREIGN KEY (volunteerId)
        REFERENCES Volunteer(volunteerId),

    FOREIGN KEY (eventId)
        REFERENCES Event(eventId),

    CHECK (status IN ('Pending', 'Accepted', 'Rejected'))
);

USE VolunteerDB;
GO

CREATE TABLE Recommendation (
    recommendationId INT PRIMARY KEY IDENTITY(1,1),
    volunteerId INT NOT NULL,
    eventId INT NOT NULL,
    matchPercent DECIMAL(5,2) NOT NULL,

    FOREIGN KEY (volunteerId)
        REFERENCES Volunteer(volunteerId),

    FOREIGN KEY (eventId)
        REFERENCES Event(eventId),

    CHECK (matchPercent BETWEEN 0 AND 100)
);

USE VolunteerDB;
GO

CREATE TABLE Notification (
    notificationId INT PRIMARY KEY IDENTITY(1,1),
    volunteerId INT NOT NULL,
    message NVARCHAR(500) NOT NULL,
    [date] DATETIME2 DEFAULT GETDATE(),
    status NVARCHAR(20) NOT NULL DEFAULT 'Unread',

    FOREIGN KEY (volunteerId)
        REFERENCES Volunteer(volunteerId),

    CHECK (status IN ('Read', 'Unread'))
);