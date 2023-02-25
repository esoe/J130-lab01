-- названия товаров, включенных в заказ № 3
SELECT design
FROM merchent.positions
    JOIN merchent.products
        on merchent.positions.article = merchent.products.article
WHERE merchent.positions.id=3;