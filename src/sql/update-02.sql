-- ЗАДАЧА:
-- сделать запрос фиксирующий отгрузку заказа с id = 5
-- изменить статус заказа (requests.position) "P" -> "S"
-- зафиксировать дату отгрузки (requests.delivery)
-- уменьшить остаток товара на складе (products.balance)

-- обновить данные не выходит, на складе не может быть количество продукции меньше нуля.
-- по задаче выходит, что нужно отгрузить не существующий стул.
USE merchent;

SELECT * FROM products 
    LEFT JOIN positions
    on products.article = positions.article
WHERE positions.id = 5;

-- не работает из за предусмотренных в таблице products ограничений
UPDATE products 
    LEFT JOIN positions
    on products.article = positions.article
    SET products.balance = products.balance - positions.quantity
WHERE positions.id = 5;
    