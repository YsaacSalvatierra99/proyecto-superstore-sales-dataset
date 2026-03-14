-- Ventas por mes
SELECT 
    T.month_name, 
    SUM(V.sales) AS total_ventas
FROM dbo.Ventas V
INNER JOIN dbo.Tiempo T ON V.order_date = T.order_date
GROUP BY T.month_name
ORDER BY MIN(V.order_date);

-- Ventas por trimestre
SELECT 
    T.quarter, 
    SUM(V.sales) AS total_ventas
FROM dbo.Ventas V
INNER JOIN dbo.Tiempo T ON V.order_date = T.order_date
GROUP BY T.quarter;

-- Ventas por año
SELECT 
    T.year, 
    SUM(V.sales) AS total_ventas
FROM dbo.Ventas V
INNER JOIN dbo.Tiempo T ON V.order_date = T.order_date
GROUP BY T.year
ORDER BY T.year;

-- Que meses venden mas?
SELECT TOP 5 
    T.month_name, 
    SUM(V.sales) AS total_ventas
FROM dbo.Ventas V
INNER JOIN dbo.Tiempo T ON V.order_date = T.order_date
GROUP BY T.month_name
ORDER BY total_ventas DESC;

-- Que trimestre genera mas ingresos?
SELECT TOP 1 
    T.quarter, 
    SUM(V.sales) AS total_ingresos
FROM dbo.Ventas V
INNER JOIN dbo.Tiempo T ON V.order_date = T.order_date
GROUP BY T.quarter
ORDER BY total_ingresos DESC;
-----------------------------------------------------------------------------
-- Ventas por categoria.
SELECT 
    P.category, 
    SUM(V.sales) AS total_ventas
FROM dbo.Ventas V
INNER JOIN dbo.Productos P ON V.product_id = P.product_id
GROUP BY P.category
ORDER BY total_ventas DESC;

-- Ventas por subcategoria.
SELECT 
    P.sub_category, 
    SUM(V.sales) AS total_ventas
FROM dbo.Ventas V
INNER JOIN dbo.Productos P ON V.product_id = P.product_id
GROUP BY P.sub_category
ORDER BY total_ventas DESC;

-- Ventas por producto.
SELECT 
    P.product_name, 
    SUM(V.sales) AS total_ventas
FROM dbo.Ventas V
INNER JOIN dbo.Productos P ON V.product_id = P.product_id
GROUP BY P.product_name
ORDER BY total_ventas DESC;

-- Top 10 productos mas vendidos por categoria.
SELECT TOP 10 
    P.category,
    P.product_name, 
    SUM(V.sales) AS total_ventas
FROM dbo.Ventas V
INNER JOIN dbo.Productos P ON V.product_id = P.product_id
GROUP BY P.category, P.product_name
ORDER BY total_ventas DESC;

-- Ventas de segment por categoria.
SELECT 
    C.segment, 
    P.category, 
    SUM(V.sales) AS total_ventas
FROM dbo.Ventas V
JOIN dbo.Clientes C ON V.customer_id = C.customer_id
JOIN dbo.Productos P ON V.product_id = P.product_id
GROUP BY C.segment, P.category
ORDER BY C.segment, total_ventas DESC;

-- segment con mayor revenue (ingreso bruto)
SELECT TOP 1 
    C.segment, 
    SUM(V.sales) AS revenue_total
FROM dbo.Ventas V
JOIN dbo.Clientes C ON V.customer_id = C.customer_id
GROUP BY C.segment
ORDER BY revenue_total DESC;

-- En que mes se venden mas productos por categoria?
WITH VentasMensuales AS (
    SELECT 
        P.category, 
        T.month_name, 
        SUM(V.sales) AS total_ventas,
        RANK() OVER (PARTITION BY P.category ORDER BY SUM(V.sales) DESC) as ranking
    FROM dbo.Ventas V
    JOIN dbo.Productos P ON V.product_id = P.product_id
    JOIN dbo.Tiempo T ON V.order_date = T.order_date
    GROUP BY P.category, T.month_name
)
SELECT category, month_name, total_ventas
FROM VentasMensuales
WHERE ranking = 1;

-- En que trimestre se venden mas productos por categoria?
WITH VentasTrimestrales AS (
    SELECT 
        P.category, 
        T.quarter, 
        SUM(V.sales) AS total_ventas,
        RANK() OVER (PARTITION BY P.category ORDER BY SUM(V.sales) DESC) as ranking
    FROM dbo.Ventas V
    JOIN dbo.Productos P ON V.product_id = P.product_id
    JOIN dbo.Tiempo T ON V.order_date = T.order_date
    GROUP BY P.category, T.quarter
)
SELECT category, quarter, total_ventas
FROM VentasTrimestrales
WHERE ranking = 1;

-- Dependencia del cliente top.
WITH ventas_cliente AS (
    SELECT
        C.customer_id,
        C.customer_name,
        SUM(V.sales) AS total_sales_cliente
    FROM Ventas V
    JOIN Clientes C
        ON V.customer_id = C.customer_id
    GROUP BY
        C.customer_id,
        C.customer_name
)

SELECT TOP 5
    customer_name,
    total_sales_cliente,
    (total_sales_cliente * 100.0 / (SELECT SUM(sales) FROM Ventas)) AS porcentaje_del_total
FROM ventas_cliente
ORDER BY total_sales_cliente DESC;

-- (Como no hay centralizacion, no es relevante el cuantas compras o el revenue del top 10).


ORDER BY veces_vendido;
