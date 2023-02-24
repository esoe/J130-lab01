CREATE DATABASE IF NOT EXISTS merchent;
-- добавляем таблицу со столбцом article
CREATE TABLE IF NOT EXISTS merchent.products(
    article int(7) NOT NULL,
    PRIMARY KEY (article)
);

-- добавляем остальные столбцы
ALTER TABLE merchent.products
    ADD design varchar(50) NOT NULL;

ALTER TABLE merchent.products
    ADD color varchar(20);

ALTER TABLE merchent.products
    ADD price int NOT NULL;

ALTER TABLE merchent.products
    ADD balance int NOT NULL;

-- определяем ограницения
ALTER TABLE merchent.products
ADD CONSTRAINT  rule_price CHECK (price > 0);

ALTER TABLE merchent.products
ADD CONSTRAINT  rule_balance CHECK (balance >= 0);

INSERT INTO merchent.products (article, design, color, price, balance)
VALUES
    (3251615, 'Стол кухонный', 'белый', 8000, 12),
    (3251616, 'Стол кухонный', '', 8000, 15),
    (3251617, 'Стул столовый гусарский', 'орех', 4000, 0),
    (3251619, 'Стул столовый с высокой спинкой', 'белый', 3500, 37),
    (3251620, 'Стул столовый с высокой спинкой', 'коричневый', 3500, 52);

