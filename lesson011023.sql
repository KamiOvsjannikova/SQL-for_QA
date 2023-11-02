/* 1 задача
0) Создать БД university

1) создать таблицу Students
с полями:
- id целое число первичный ключ автоинкремент
- name строка 128 не null
- age целое число

2) создать таблицу Teachers
с полями:
- id целое число первичный ключ автоинкремент
- name строка 128 не null
- age целое число

3) создать таблицу Competencies
с полями:
- id целое число первичный ключ автоинкремент
- title строка 128 не null

4) создать таблицу Teachers2Competencies
с полями:
- id целое число первичный ключ автоинкремент
- teacher_id целое число
- competencies_id целое число

5) создать таблицу Courses
- id целое число первичный ключ автоинкремент
- teacher_id целое число
- title строка 128 не null
- headman_id целое число

6) создать таблицу Students2Courses
- id целое число первичный ключ автоинкремент
- student_id целое число
- course_id целое число

*/


create database university;
use university;
 
 CREATE TABLE Students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(128) NOT NULL,
    age INT
);

CREATE TABLE Teachers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(128) NOT NULL,
    age INT
);

CREATE TABLE Competencies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(128) NOT NULL
);

CREATE TABLE Teachers2Competencies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    teacher_id INT,
    competencies_id INT
);

CREATE TABLE Courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    teacher_id INT,
    title VARCHAR(128) NOT NULL,
    headman_id INT
);

CREATE TABLE Students2Courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT
);

-- 2 задача. Заполнить таблицы
insert into students (name, age) values ('Анатолий', 29);
insert into students (name, age) values ('Олег', 25);
insert into students (name, age) values ('Семен', 27);
insert into students (name, age) values ('Олеся', 28);
insert into students (name, age) values ('Ольга', 31);
insert into students (name, age) values ('Иван', 22);

insert into teachers (name, age) values ('Петр', 39);
insert into teachers (name, age) values ('Максим', 35);
insert into teachers (name, age) values ('Антон', 37);
insert into teachers (name, age) values ('Всеволод', 38);
insert into teachers (name, age) values ('Егор', 41);
insert into teachers (name, age) values ('Светлана', 32);

insert into Competencies (title) values ('Математика');
insert into Competencies (title) values ('Информатика');
insert into Competencies (title) values ('Программирование');
insert into Competencies (title) values ('Графика');

insert into Teachers2Competencies (teacher_id, competencies_id) values (1, 1);
insert into Teachers2Competencies (teacher_id, competencies_id) values (2, 1);
insert into Teachers2Competencies (teacher_id, competencies_id) values (2, 3);
insert into Teachers2Competencies (teacher_id, competencies_id) values (3, 2);
insert into Teachers2Competencies (teacher_id, competencies_id) values (4, 1);
insert into Teachers2Competencies (teacher_id, competencies_id) values (5, 3);

insert into courses (teacher_id, title, headman_id) values (1, 'Алгебра логики', 2);
insert into courses (teacher_id, title, headman_id) values (2, 'Математическая статистика', 3);
insert into courses (teacher_id, title, headman_id) values (4, 'Высшая математика', 5);
insert into courses (teacher_id, title, headman_id) values (5, 'Javascript', 1);
insert into courses (teacher_id, title, headman_id) values (5, 'Базовый Python', 1);

insert into students2courses (student_id, course_id) values (1, 1);
insert into students2courses (student_id, course_id) values (2, 1);
insert into students2courses (student_id, course_id) values (3, 2);
insert into students2courses (student_id, course_id) values (3, 3);
insert into students2courses (student_id, course_id) values (4, 5);

-- 3 задача:
-- Вывести имена студентов и названия курсов, который они посещают. 
-- Если студент не посещает ниодного курса, то напротив него вывести null

-- на подумать:
-- какие поля нужно вывести?
-- в каких таблицах есть эти поля?
-- как эти таблицы могут быть объеденены?

SELECT 
	Students.name AS StudentName, 
	Courses.title AS CourseTitle
FROM Students
LEFT JOIN Students2Courses 
ON Students.id = Students2Courses.student_id
LEFT JOIN Courses 
ON Students2Courses.course_id = Courses.id;

-- другая запись решения задачи №3:

select
	t1.name,
	t3.title
from students t1
left join students2courses t2
on t1.id = t2.student_id
left join courses t3
on t2.course_id = t3.id;

-- 4 задача:
-- Найти преподавателя, у которого нет компетенций. Вывести имя этого преподавателя


SELECT 
	Teachers.name AS Name
FROM Teachers
LEFT JOIN Teachers2Competencies 
ON Teachers.id = Teachers2Competencies.teacher_id
WHERE Teachers2Competencies.competencies_id IS NULL;

-- другая запись решения задачи №4:

select
 t1.name
from teachers t1
left join teachers2competencies t2
on t1.id = t2.teacher_id
where t2.competencies_id is null;


-- 5 задача:
-- Найти курс(-ы), который никто не посещает. Вывести назвоние курса(-ов)

SELECT 
	Courses.title AS Title
FROM Courses
LEFT JOIN Students2Courses ON Courses.id = Students2Courses.course_id
WHERE Students2Courses.course_id IS NULL;

-- другая запись решения задачи №5:

select
	t1.title
from courses t1
left join students2courses t2
on t1.id = t2.course_id
where t2.course_id is null;

-- 6 задача
-- Вывести название курса и имя старосты на этом курсе

SELECT 
	Courses.title AS Title, 
	Students.name AS Name
FROM Courses
LEFT JOIN Students ON Courses.headman_id = Students.id;

-- другая запись решения задачи №6:

select
 t1.title,
    t2.name
from courses t1
left join students t2
on t1.headman_id = t2.id;
-----------------------------------------------------------
-- ДЗ:
-- 1. Вывести имена студентов, не посещающих ни одного курса

SELECT 
	Students.name AS StudentName
FROM Students
LEFT JOIN Students2Courses ON Students.id = Students2Courses.student_id
WHERE Students2Courses.student_id IS NULL;


-- 2. Вывести компетенции, которых нет ни у одного преподавателя 

SELECT 
	Competencies.title AS CompetencyTitle
FROM Competencies
LEFT JOIN Teachers2Competencies 
ON Competencies.id = Teachers2Competencies.competencies_id
WHERE Teachers2Competencies.competencies_id IS NULL;


-- *3. Вести имя студента и имя старосты того курса, который посещает студент

SELECT 
S.name AS StudentName, 
C.title AS CourseTitle, 
H.name AS HeadmanName
FROM Students S
JOIN Students2Courses SC ON S.id = SC.student_id
JOIN Courses C ON SC.course_id = C.id
LEFT JOIN Students H ON C.headman_id = H.id;
------------------------------------------------------------------













