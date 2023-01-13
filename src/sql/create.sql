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
CREATE DATABASE merchent IF NOT EXISTS;
/*
    чтобы далее в скрипте не указывать наименование базы данных
    можно тут указать директиву:
    USE merchent;
*/

-- создаем таблицу "Продукты" : products
CREATE TABLE IF NOT EXISTS merchent.products (
    product_article int(7) ZEROFILL 
        primary key generated always
        as identity (start with 1, increment by 1),
    product_design varchar(50) not null unique,
    product_color varchar(20),
    product_price int not null,
    product_balance int not null,
    CHECK (product_price > 0),
    CHECK (product_balance >= 0)
);

-- создаем таблицу "Заказы" : requests
CREATE TABLE IF NOT EXISTS merchent.requests(
    -- уникальный идентификатор заказа
    req_id int primary key generated always
        as identity (start with 1, increment by 1),
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

-- создаем таблицу "Позиции заказа" : positions
CREATE TABLE IF NOT EXISTS merchent.positions (
    request_id int,
    product_article int (7) ZEROFILL,
    current_price int not null,
    quantity int not null,
    FOREIGN KEY (reques_id) REFERENCES merchent.requests (req_id),
    FOREIGN KEY (product_article) REFERENCES merchent.requests (product_article),
    PRIMARY KEY (product_article, request_id),
    CHECK (current_price > 0),
    CHECK (quantity > 0),
);
