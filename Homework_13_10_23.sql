-- Создать таблицу "Users"
-- Поле "user_id" - уникальный идентификатор пользователя (целое число, автоинкрементное, первичный ключ).
-- Поле "user_name" - имя пользователя (строка, максимум 50 символов, обязательное).
-- Поле "email" - адрес электронной почты (строка, максимум 100 символов, уникальное).
-- Поле "age" - возраст пользователя (целое число, от 0 до 140).
-- Поле "gender" - пол пользователя (значение 'm' или 'f')
CREATE DATABASE Users;
Use Users;
CREATE TABLE Users(
    user_id integer  PRIMARY KEY auto_increment,
    user_name varchar(50) NOT NULL,
    email varchar(100) UNIQUE,
    age integer check (age >= 0 AND age <= 140),
    gender varchar(128) check (gender in ('M', 'F'))
);

-- Добавить следующие данные в таблицу "Users"
-- Пользователь с именем "John Doe", адрес электронной почты "johndoe@example.com", возраст 30 лет.
-- Пользователь с именем "Jane Smith", адрес электронной почты "janesmith@example.com", возраст 25 лет.

insert into users (user_name, email, age, gender) 
	values 
	("John Doe","johndoe@example.com", 30, 'M');
insert into users (user_name, email, age, gender) 
	values 
	("Jane Smith","janesmith@example.com",25, 'F');
