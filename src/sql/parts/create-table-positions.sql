-- создаем таблицу "Позиции заказа" : positions
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
