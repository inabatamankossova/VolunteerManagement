USE VolunteerDB;
GO

-- 1. UPDATE: Волонтердің ұпайын өзгерту
UPDATE Volunteer
SET points = 100
WHERE email = 'aruzhan@gmail.com';

-- 2. UPDATE: Өтінішті қабылдау
UPDATE Application
SET status = 'Accepted'
WHERE volunteerId = (
    SELECT volunteerId
    FROM Volunteer
    WHERE email = 'aruzhan@gmail.com'
);


UPDATE Notification
SET status = 'Read'
WHERE volunteerId = (
    SELECT volunteerId
    FROM Volunteer
    WHERE email = 'dana@gmail.com'
);

-- Нәтижелерді тексеру
SELECT * FROM Volunteer;
SELECT * FROM Application;
SELECT * FROM Notification;