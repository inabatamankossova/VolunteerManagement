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

-- 3. UPDATE: Хабарламаны оқылған деп белгілеу
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

-- Жаңа тест хабарламасын енгізу
INSERT INTO Notification (volunteerId, message)
SELECT volunteerId, N'Тест хабарлама'
FROM Volunteer
WHERE email = 'aruzhan@gmail.com';

-- Тест хабарламасын өшіру
DELETE FROM Notification
WHERE message = N'Тест хабарлама';

-- Нәтижені тексеру
SELECT * FROM Notification;