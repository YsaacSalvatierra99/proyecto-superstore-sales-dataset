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
--EXPLICAR MEJOR LA INFORMACION MOSTRADA EN EL SELECT Y POR QUE

--DelyveryTime promedio por Region
SELECT 
	G.region,
	AVG(DATEDIFF(DAY,V.order_date,V.ship_date)) AS avg_delivery_time
FROM Ventas V
JOIN Geografia G
	ON V.postal_code = G.postal_code
GROUP BY 
	G.region
ORDER BY 
	avg_delivery_time DESC;
