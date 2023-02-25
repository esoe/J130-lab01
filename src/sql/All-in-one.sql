CREATE DATABASE IF NOT EXISTS merchent;
CREATE TABLE IF NOT EXISTS merchent.products (
    article int(7) NOT NULL,
    design varchar(50) not null,
    color varchar(20),
    price int not null,
    balance int not null,
    PRIMARY KEY (article),
    CHECK (price > 0),
    CHECK (balance >= 0)
);
CREATE TABLE IF NOT EXISTS merchent.requests(
    id int NOT NULL AUTO_INCREMENT,
    created DATE not null,
    customer_name varchar(100) not null,
    customer_phone varchar(50),
    customer_mail varchar(50),
    customer_address varchar(200),
    position varchar(1),
    delivery DATE,
    PRIMARY KEY(id),
    CHECK (position in ('P', 'S', 'C')),
    CHECK ((position='S' and delivery is not null) or delivery is null)
);
CREATE TABLE IF NOT EXISTS merchent.positions (
    id int,
    article int (7),
    price int not null,
    quantity int not null,
    FOREIGN KEY (id) REFERENCES merchent.requests (id),
    FOREIGN KEY (article) REFERENCES merchent.products (article),
    PRIMARY KEY (article, id),
    CHECK (price > 0),
    CHECK (quantity > 0)
);
INSERT INTO merchent.products (article, design, color, price, balance)
VALUES
    (3251615, 'Стол кухонный', 'белый', 8000, 12),
    (3251616, 'Стол кухонный', NULL, 8000, 15),
    (3251617, 'Стул столовый гусарский', 'орех', 4000, 0),
    (3251619, 'Стул столовый с высокой спинкой', 'белый', 3500, 37),
    (3251620, 'Стул столовый с высокой спинкой', 'коричневый', 3500, 52);
INSERT INTO merchent.requests
    (created,
    customer_name,
    customer_phone,
    customer_mail,
    customer_address,
    position,
    delivery)
VALUES
    ('2020-11-20', 'Сергей Иванов', '(981)123-45-67', NULL, 'ул. Веденеева, 20-1-41', 'S', '2020-11-29'),
    ('2020-11-22', 'Алексей Комаров', '(921)001-22-33', NULL, 'пр. Пархоменко 51-2-123', 'S', '2020-11-29'),
    ('2020-11-28', 'Ирина Викторова', '(911)009-88-77', NULL, 'Тихорецкий пр. 21-21', 'P', NULL),
    ('2020-12-03', 'Павел Николаев', NULL, 'pasha_nick@mail.ru', 'ул. Хлопина 3-88', 'P', NULL),
    ('2020-12-03', 'Антонина Васильева', '(931)777-66-55', 'antvas66@gmail.com', 'пр. Науки, 11-3-9', 'P', NULL),
    ('2020-12-10', 'Ирина Викторова', '(911)009-88-77', NULL, 'Тихорецкий пр. 21-21', 'P', NULL);
INSERT INTO merchent.positions (id, article, price, quantity)
VALUES
    (1, 3251616, 7500, 1),
    (2, 3251615, 7500, 1),
    (3, 3251615, 8000, 1),
    (3, 3251617, 4000, 4),
    (4, 3251619, 3500, 2),
    (5, 3251615, 8000, 1),
    (5, 3251617, 4000, 4),
    (6, 3251617, 4000, 2);