SELECT
    b.title,
    a.author_name,
    SUM(oi.quantity) AS total_sold
FROM
    books b
    JOIN order_items oi ON b.book_id = oi.book_id
    JOIN orders o ON oi.order_id = o.order_id
    JOIN authors a ON b.author_id = a.author_id
GROUP BY
    b.book_id
ORDER BY
    total_sold DESC
LIMIT
    10; -- Change the limit to adjust the number of top-selling books you want to retrieve



SELECT
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM
    order_items oi
    JOIN orders o ON oi.order_id = o.order_id
WHERE
    o.order_date >= '2024-01-01'
    AND o.order_date <= '2024-01-31';