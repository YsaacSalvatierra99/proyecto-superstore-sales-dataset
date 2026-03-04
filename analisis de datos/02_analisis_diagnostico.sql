-- Crecimiento MoM / QoQ.
SELECT * FROM Ventas;
SELECT * FROM Tiempo;


WITH ventas_mensuales AS (
	SELECT 
		T.year,
		T.month,
		SUM(V.sales) AS total_sales
	FROM Ventas V
	JOIN Tiempo T
		ON V.order_date = T.order_date
	GROUP BY 
		T.year,
		T.month
)

SELECT
	year,
	month,
	total_sales,
	LAG(total_sales) OVER (ORDER BY year, month) AS ventas_mes_anterior,
	((total_sales - LAG(total_sales) OVER (ORDER BY year, month)) *100.0
	/ LAG(total_sales) OVER (ORDER BY year, month)) AS crecimiento_MoM_pct
FROM ventas_mensuales
ORDER BY
	year,
	month;


WITH ventas_trimestrales AS (
	SELECT 
		T.year,
		T.quarter,
		SUM(V.sales) AS total_sales
	FROM Ventas V
	JOIN Tiempo T
		ON V.order_date = T.order_date
	GROUP BY 
		T.year,
		T.quarter
)

SELECT 
	year,
	quarter,
	total_sales,
	LAG(total_sales) OVER (ORDER BY year,quarter) AS ventas_trimestre_anterior,
	((total_sales - LAG(total_sales) OVER (ORDER BY year,quarter))* 100.00 
	/ LAG(total_sales) OVER (ORDER BY year,quarter)) AS Crecimiento_QoQ_pct
FROM ventas_trimestrales
ORDER BY
	year,
	quarter;

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

-- Impacto DeliveryTime en ventas.
-- Productos con baja rotación.
