WITH monthly_sales AS (
    SELECT
        pharmacy_name,
        DATE_TRUNC('month', report_date::date) AS month,
        SUM(price * count) AS total_sales,
        city
    FROM
        pharma_orders
    WHERE
        city IN ('Москва', 'Санкт-Петербург')
    GROUP BY
        pharmacy_name, month, city
),
sales_comparison AS (
    SELECT
        COALESCE(moscow_sales.month, spb_sales.month) AS month,
        COALESCE(moscow_sales.pharmacy_name, spb_sales.pharmacy_name) AS pharmacy_name,
        COALESCE(moscow_sales.total_sales, 0) AS moscow_sales,
        COALESCE(spb_sales.total_sales, 0) AS spb_sales
    FROM
        (SELECT month, pharmacy_name, total_sales FROM monthly_sales WHERE city = 'Москва') AS moscow_sales
    FULL OUTER JOIN
        (SELECT month, pharmacy_name, total_sales FROM monthly_sales WHERE city = 'Санкт-Петербург') AS spb_sales
    ON
        moscow_sales.month = spb_sales.month AND moscow_sales.pharmacy_name = spb_sales.pharmacy_name
),
sales_difference AS (
    SELECT
        month,
        pharmacy_name,
        moscow_sales,
        spb_sales,
        CASE 
            WHEN spb_sales = 0 THEN NULL  -- Избегаем деления на ноль
            ELSE ROUND(((moscow_sales::numeric - spb_sales::numeric) / spb_sales::numeric)* 100, 2) 
        END AS sales_difference_percentage
    FROM
        sales_comparison
)

SELECT
    month,
    pharmacy_name,
    moscow_sales,
    spb_sales,
    sales_difference_percentage
FROM
    sales_difference
ORDER BY
    month, pharmacy_name 