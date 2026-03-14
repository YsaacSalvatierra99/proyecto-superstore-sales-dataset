--EDA basico.

--Cuantas transacciones unicas hay registradas.
SELECT COUNT(*) FROM ventas;

-- Cuantos clientes unicos hay registrados.
SELECT COUNT(*) FROM clientes;

-- Cuantos productos unicos hay registrados.
SELECT COUNT(*) FROM productos;

-- Rango de fechas que abarca la base de datos a analizar.
SELECT MIN(order_date), MAX(order_date)
FROM ventas;

-- Ventas totales (Dentro del rango de fecha del BBDD).
SELECT SUM(sales) total_sales
FROM ventas;

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

-- Ventas por categoria.
SELECT 
    P.category,
    SUM(V.sales) AS total_sales
FROM ventas V
JOIN productos P
ON V.product_id = P.product_id
GROUP BY P.category
ORDER BY total_sales DESC;

--Ventas por Categoría.
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

--Ventas por Segmento.
SELECT
	C.segment,
	SUM(V.sales) AS total_sales,
	COUNT(DISTINCT V.order_id) AS total_orders,
	AVG(V.sales) AS avg_ticket
FROM Clientes C
JOIN Ventas V
	ON C.customer_id = V.customer_id
GROUP BY 
	C.segment
ORDER BY
	total_sales DESC;
