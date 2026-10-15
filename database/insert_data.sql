USE VolunteerDB;
GO

-- 1. Волонтерлерді қосу
INSERT INTO Volunteer
(name, phone, email, skills, interests, freeTime, points)
VALUES
(N'Аружан', N'87011234567',
 'aruzhan@gmail.com', N'Ұйымдастыру',
 N'Экология', N'Демалыс күндері', 50),

(N'Дана', N'87021234567',
 'dana@gmail.com', N'Балалармен жұмыс',
 N'Білім беру', N'Сенбі', 30),

(N'Айдана', N'87031234567',
 'aidana@gmail.com', N'Медицина',
 N'Денсаулық сақтау', N'Жексенбі', 20);

-- 2. Ұйымдастырушыларды қосу
INSERT INTO Organizer
(name, email, organization)
VALUES
(N'Ерлан', 'erlan@gmail.com', N'Жастар ұйымы'),
(N'Мадина', 'madina@gmail.com', N'Еріктілер орталығы');

-- Нәтижені көру
SELECT * FROM Volunteer;
SELECT * FROM Organizer;

USE VolunteerDB;
GO

-- 3. Іс-шараларды қосу
INSERT INTO Event
(title, description, [date], location,
 requiredSkills, availablePlaces, organizerId)
VALUES
(N'Экологиялық сенбілік',
 N'Қаланы тазалау',
 '2026-11-10 10:00:00',
 N'Алматы', N'Ұйымдастыру', 20,
 (SELECT organizerId FROM Organizer
  WHERE email = 'erlan@gmail.com')),

(N'Балаларға көмек',
 N'Балаларға сабақ өткізу',
 '2026-11-15 11:00:00',
 N'Алматы', N'Балалармен жұмыс', 10,
 (SELECT organizerId FROM Organizer
  WHERE email = 'madina@gmail.com'));

-- 4. Волонтерлердің өтініштері
INSERT INTO Application
(volunteerId, eventId, status)
VALUES
(
 (SELECT volunteerId FROM Volunteer
  WHERE email = 'aruzhan@gmail.com'),
 (SELECT eventId FROM Event
  WHERE title = N'Экологиялық сенбілік'),
 'Pending'
),
(
 (SELECT volunteerId FROM Volunteer
  WHERE email = 'dana@gmail.com'),
 (SELECT eventId FROM Event
  WHERE title = N'Балаларға көмек'),
 'Accepted'
);

-- 5. Автоматты ұсыныстар
INSERT INTO Recommendation
(volunteerId, eventId, matchPercent)
VALUES
(
 (SELECT volunteerId FROM Volunteer
  WHERE email = 'aruzhan@gmail.com'),
 (SELECT eventId FROM Event
  WHERE title = N'Экологиялық сенбілік'),
 95.00
),
(
 (SELECT volunteerId FROM Volunteer
  WHERE email = 'dana@gmail.com'),
 (SELECT eventId FROM Event
  WHERE title = N'Балаларға көмек'),
 90.00
);

-- 6. Хабарламалар
INSERT INTO Notification
(volunteerId, message, status)
VALUES
(
 (SELECT volunteerId FROM Volunteer
  WHERE email = 'aruzhan@gmail.com'),
 N'Сіздің өтінішіңіз қарастырылуда',
 'Unread'
),
(
 (SELECT volunteerId FROM Volunteer
  WHERE email = 'dana@gmail.com'),
 N'Сіздің өтінішіңіз қабылданды',
 'Unread'
);

-- Барлық мәліметтерді тексеру
SELECT * FROM Event;
SELECT * FROM Application;
SELECT * FROM Recommendation;
SELECT * FROM Notification;