CREATE DATABASE test;
USE test;

CREATE TABLE Users(
    id integer,
    first_name varchar(128),
    last_name varchar(128),
    age integer
);

DROP TABLE products;
CREATE TABLE products(
	id integer PRIMARY KEY auto_increment,
    title varchar(64) unique,
    amount integer NOT NULL,
    price decimal (8,2) CHECK(price BETWEEN 0 AND 10000)
    );
    
NOT NULL - поле не может принимать NULL значение 
UNIQUE - значение поля должно быть уникальным 
PRIMARY KEY - не принимает NULL и уникально
CHECK - указанное условие должно выполняться


INSERT INTO products ( title, amount, price)
	VALUE ('roliki', 12, 12000);
    
    SELECT *
    FROM products;
    
id - автоинкремент
first_name - обязательное поле 
age - от 0 до 140
curse_num - от 0 до 6
gender - или "m" или "f"

inset добавить 5 студентов
    
    DROP TABLE students;
    CREATE TABLE students(
		id integer  PRIMARY KEY auto_increment,
		first_name varchar(128) NOT NULL,
		age integer check (age between 0 and 140),
		curse_num integer check (curse_num  between 0 and 6),
		gender varchar(128) check (gender in ('M', 'F'))
);

INSERT INTO students (first_name, age, curse_num, gender)
 VALUES ('Иван', 29, 3, 'm');
INSERT INTO students (first_name, age, curse_num, gender)
 VALUES ('Ирина', 25, 1, 'f');
INSERT INTO students (first_name, age, curse_num, gender)
 VALUES ('Олег', 27, 2, 'm');
INSERT INTO students (first_name, age, curse_num, gender)
 VALUES ('Ольга', 24, 2, 'f');
INSERT INTO students (first_name, age, curse_num, gender)
 VALUES ('Антон', 32, 6, 'm');

SELECT *
    FROM students;
    
    DELETE FROM students
    WHERE id =5;
    
     DELETE FROM students
		WHERE curse_num = 1;
        
        SET SQL_SAFE_UPDATES = 0;
    