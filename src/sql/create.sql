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
    product_article int(7) NOT NULL, -- 1
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
    product_design varchar(50) not null, -- 2
    product_color varchar(20), -- 3
    product_price int not null, -- 4
    product_balance int not null, -- 5
    PRIMARY KEY (product_article),
    CHECK (product_price > 0),
    CHECK (product_balance >= 0)
);
-- заполняем таблицу "Продукты" тестовыми значениями
INSERT INTO merchent.products (product_article, product_design, product_color, product_price, product_balance)
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
    req_id int NOT NULL AUTO_INCREMENT,
    -- дата регистрации заказа
    req_register_date DATE not null,
    -- ФИО заказчика
    customer varchar(100) not null,
    -- номер телефона заказчика
    customer_phone varchar(50),
    -- адрес электронной почты заказчика
    customer_mail varchar(50),
    -- адрес доставки
    customer_address varchar(200),
    -- стадия исполнения заказа
    req_status varchar(1),
    -- дата отгрузки заказа
    shipment_date DATE,
    PRIMARY KEY(req_id),
    /*
        Статус товара закодирован символом:
            P - Готовится
            S - Отгружен
            C - Отменен
    */
    CHECK (req_status in ('P', 'S', 'C')),
    /*
        для заказов в статусе «Отгружен» (S) д.б. заполнено,
        для остальных ситуаций - пусто
    */
    CHECK (req_status='S' and shipment_date is not null or shipment_date is null)
);
-- Заполняем таблицу "Заказы" тестовыми данными


-- создаем таблицу "Позиции заказа" : positions
CREATE TABLE IF NOT EXISTS merchent.positions (
    request_id int,
    product_article int (7),
    current_price int not null,
    quantity int not null,
    FOREIGN KEY (request_id) REFERENCES merchent.requests (req_id),
    FOREIGN KEY (product_article) REFERENCES merchent.requests (product_article),
    PRIMARY KEY (product_article, request_id),
    CHECK (current_price > 0),
    CHECK (quantity > 0)
);
