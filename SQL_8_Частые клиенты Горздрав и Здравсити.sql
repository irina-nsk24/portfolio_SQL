WITH gorzdrav_customers AS (
    SELECT
        c.customer_id,
        CONCAT(c.last_name, ' ', c.first_name, ' ', c.second_name) AS full_name,
        COUNT(p.order_id) AS order_count
    FROM
        pharma_orders p
    JOIN
        customers c ON p.customer_id = c.customer_id
    WHERE
        p.pharmacy_name = 'Горздрав'
    GROUP BY
        c.customer_id, full_name
    ORDER BY
        order_count DESC
    LIMIT 10
),
zdravsiti_customers AS (
    SELECT
        c.customer_id,
        CONCAT(c.last_name, ' ', c.first_name, ' ', c.second_name) AS full_name,
        COUNT(p.order_id) AS order_count
    FROM
        pharma_orders p
    JOIN
        customers c ON p.customer_id = c.customer_id
    WHERE
        p.pharmacy_name = 'Здравсити'
    GROUP BY
        c.customer_id, full_name
    ORDER BY
        order_count DESC
    LIMIT 10
)
SELECT
    customer_id,
    full_name,
    order_count,
    'Горздрав' AS pharmacy
FROM
    gorzdrav_customers
UNION ALL
SELECT
    customer_id,
    full_name,
    order_count,
    'Здравсити' AS pharmacy
FROM
    zdravsiti_customers