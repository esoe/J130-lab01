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
    -- дата отгрузки заказа //пробую текстовое поле
    delivery DATE,
    -- delivery varchar(50),
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
    CHECK ((position='S' and delivery is not null) or delivery is null)
);
