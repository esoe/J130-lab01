-- список заказов, отгруженных: в ноябре, декабре
SELECT * FROM merchent.requests WHERE delivery
BETWEEN '2020-11-01' AND '2020-12-31'