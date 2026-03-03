--Ventas por Año - Mes.
SELECT T.year, T.month, SUM(V.sales) AS total_sales
FROM Ventas V
JOIN Tiempo T
	ON V.order_date = T.order_date
GROUP BY 
	T.month,
	T.year
ORDER BY
	T.year,
	T.month;

--Ventas por Región.
SELECT G.region,
	SUM(V.sales) AS total_sales,
	COUNT(DISTINCT V.order_id) AS total_orders
FROM Geografia G
JOIN Ventas V
	ON G.postal_code = V.postal_code
GROUP BY 
	G.region
ORDER BY
	total_sales DESC;

--Ventas por Categoría.
SELECT 
	P.category,
	SUM(V.sales) AS total_sales,
	COUNT(DISTINCT V.order_id) AS total_orders
FROM Ventas V
JOIN Productos P
	ON P.product_id = V.product_id
GROUP BY 
	P.category
ORDER BY
	total_orders;

--Ventas por Segmento.
SELECT 
    c.segment,
    SUM(o.sales) AS total_sales,
    COUNT(DISTINCT o.order_id) AS total_orders,
    AVG(o.sales) AS avg_ticket
FROM orders o
JOIN customers c 
    ON o.customer_id = c.customer_id
GROUP BY 
    c.segment
ORDER BY 
    total_sales DESC;

--DelyveryTime promedio.
SELECT 
    AVG(DATEDIFF(DAY, o.order_date, o.ship_date)) AS avg_delivery_days
FROM orders o;




SELECT 
    g.region,
    AVG(DATEDIFF(DAY, o.order_date, o.ship_date)) AS avg_delivery_days
FROM orders o
JOIN geography g 
    ON o.postal_code = g.postal_code
GROUP BY 
    g.region;
