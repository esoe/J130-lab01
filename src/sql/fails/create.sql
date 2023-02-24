/*
    Назначение скрипта:
    - создает базу данных merchent
    - создает таблицы в базе данных
    - создает столбцы таблиц базы данных
    - наполняет базу данных данными
*/

-- Авторизация в базе данных
-- mysql -u yourusername -p yourpassword

-- Просмотр перечня баз данных
-- SHOW DATABASES;

-- Просмотр таблиц в базе
-- SHOW TABLES;
-- SHOW TABLES FROM database_name;
-- SHOW TABLES LIKE pattern;

-- Создание базы данных a_new_database_name
-- mysql>CREATE DATABASE a_new_database_name

/*
    Запуск скрипта main.sql  на исполнение:
    команды unix
    - вывод результата в консоль
    mysql -u yourusername -p yourpassword a_new_database_name < text_file
    - вывод результата в файл
    mysql -u yourusername -p yourpassword yourdatabase < query_file > results_file
    mysql --user="username" --database="databasename" -p < "filepath"

    команды SQL
    mysql>source file_name.sql
*/
-- создаем базу данных merchent
CREATE DATABASE IF NOT EXISTS merchent ;
-- чтобы далее в скрипте не указывать наименование базы данных можно тут указать директиву: USE merchent;

-- создаем таблицу "Продукты" : products
CREATE TABLE IF NOT EXISTS merchent.products (
    article int(7) NOT NULL, -- 1
    /*
        Вариант автоинкрементации поля, предложенный на занятии не применим в mysql (предназначен для oracleSQL)
        в mysql предусмотрены соответствующие переменные,
        которые могут задаваться глобально или для текущей сессии
        -- меняем параметры --> создаем таблицу --> возвращаем исходные значения параметров
        SET @@SESSION.auto_increment_increment=1;
        SET @@GLOBAL.auto_increment_increment=1;
        SET @@SESSION.auto_increment_offset=1;
        SET @@GLOBAL.auto_increment_offset=1;
    */
    design varchar(50) not null, -- 2
    color varchar(20), -- 3
    price int not null, -- 4
    balance int not null, -- 5
    PRIMARY KEY (article),
    CHECK (price > 0),
    CHECK (balance >= 0)
);
-- заполняем таблицу "Продукты" тестовыми значениями
INSERT INTO merchent.products (article, design, color, price, balance)
VALUES
    (3251615, 'Стол кухонный', 'белый', 8000, 12),
    (3251616, 'Стол кухонный', '', 8000, 15),
    (3251617, 'Стул столовый гусарский', 'орех', 4000, 0),
    (3251619, 'Стул столовый с высокой спинкой', 'белый', 3500, 37),
    (3251620, 'Стул столовый с высокой спинкой', 'коричневый', 3500, 52);
-- выводим данные таблицы "Продукты"
SELECT * FROM merchent.products;

-- создаем таблицу "Заказы" : requests
CREATE TABLE IF NOT EXISTS merchent.requests(
    -- уникальный идентификатор заказа
    id int NOT NULL AUTO_INCREMENT,
    -- дата регистрации заказа
    created DATE not null,
    -- ФИО заказчика
    customer_name varchar(100) not null,
    -- номер телефона заказчика
    customer_phone varchar(50),
    -- адрес электронной почты заказчика
    customer_mail varchar(50),
    -- адрес доставки
    customer_address varchar(200),
    -- стадия исполнения заказа
    position varchar(1),
    -- дата отгрузки заказа
    delivery DATE,
    PRIMARY KEY(id),
    /*
        Статус товара закодирован символом:
            P - Готовится
            S - Отгружен
            C - Отменен
    */
    CHECK (position in ('P', 'S', 'C')),
    /*
        для заказов в статусе «Отгружен» (S) д.б. заполнено,
        для остальных ситуаций - пусто
    */
    CHECK (position='S' and delivery is not null or delivery is null)
);
-- Заполняем таблицу "Заказы" тестовыми данными
INSERT INTO merchent.requests
    (created,
    customer_name,
    customer_phone,
    customer_mail,
    customer_address,
    position,
    delivery)
VALUES
('2020-11-20', 'Сергей Иванов', '(981)123-45-67', '', 'ул. Веденеева, 20-1-41', 'S', '2020-11-29'),
('2020-11-22', 'Алексей Комаров', '(921)001-22-33', '', 'пр. Пархоменко 51-2-123', 'S', '2020-11-29'),
('2020-11-28', 'Ирина Викторова', '(911)009-88-77', '', 'Тихорецкий пр. 21-21', 'P', ),
('2020-12-03', 'Павел Николаев', '', 'pasha_nick@mail.ru', 'ул. Хлопина 3-88', 'P', ),
('2020-12-03', 'Антонина Васильева', '(931)777-66-55', 'antvas66@gmail.com', 'пр. Науки, 11-3-9', 'P', ),
('2020-12-10', 'Ирина Викторова', '(911)009-88-77', '', 'Тихорецкий пр. 21-21', 'P', );
-- SELECT * FROM merchent.requests;

-- создаем таблицу "Позиции заказа" : positions
CREATE TABLE IF NOT EXISTS merchent.positions (
    id int,
    article int (7),
    price int not null,
    quantity int not null,
    FOREIGN KEY (id) REFERENCES merchent.requests (id),
    FOREIGN KEY (article) REFERENCES merchent.requests (article),
    PRIMARY KEY (article, id),
    CHECK (price > 0),
    CHECK (quantity > 0)
);
