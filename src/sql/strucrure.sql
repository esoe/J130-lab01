CREATE DATABASE IF NOT EXISTS merchent;
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
    CHECK (req_status in ('P', 'S', 'C')),
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