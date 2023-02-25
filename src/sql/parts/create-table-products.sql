-- Создаем таблицу products
CREATE TABLE IF NOT EXISTS merchent.products (
    article int(7) NOT NULL, -- 1
    design varchar(50) not null, -- 2
    color varchar(20), -- 3
    price int not null, -- 4
    balance int not null, -- 5
    PRIMARY KEY (article),
    CHECK (price > 0),
    CHECK (balance >= 0)
);