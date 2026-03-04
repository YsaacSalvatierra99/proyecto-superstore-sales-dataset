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

-- Dependencia del cliente top.

-- Impacto DeliveryTime en ventas.
-- Productos con baja rotación.
