
VENTAS

--1. Zonas con mayores ventas por Año-Mes (YearMonth)

SELECT
  YearMonth,
  Region,
 SUM(Sales) AS TotalSales
FROM dbo.DatosTrainRaw
GROUP BY YearMonth, Region
ORDER BY
TotalSales DESC;


--2. Zonas con mayores ventas por Trimestre (Quarter)

SELECT
Quarter,
Region,
SUM(Sales) AS TotalSales
FROM dbo.DatosTrainRaw
GROUP BY Quarter, Region
ORDER BY
TotalSales DESC;

--3. Zonas con mayores ventas por Semestre (Semester)

SELECT
Semester,
Region,
SUM(Sales) AS TotalSales
FROM dbo.DatosTrainRaw
GROUP BY Semester, Region
ORDER BY
TotalSales DESC;

-- Sacar una conclusion de si hay alguna estacionalidad


PRODUCTOS
--1. Productos mas vendidos separados por categoria 

SELECT Category, [Product Name], SUM(Sales) AS TotalSales
FROM dbo.DatosTrainRaw
GROUP BY Category, [Product Name]
ORDER BY Category, TotalSales DESC;


--2. Productos con entregas más demoradas en promedio (DeliveryTime alto)

SELECT 
    [Product Name],
    AVG(DeliveryTime) AS AvgDeliveryDays,
    COUNT(*) AS TotalOrders
FROM dbo.DatosTrainRaw
GROUP BY [Product Name]
HAVING COUNT(*) > 1 
ORDER BY AvgDeliveryDays DESC,TotalOrders DESC;

--3. Productos vendidos solo 1 vez en todo el histórico

SELECT 
    [Product Name],
    COUNT(*) AS TimesSold
FROM dbo.DatosTrainRaw
GROUP BY [Product Name]
HAVING COUNT(*) = 1
ORDER BY [Product Name];


TIEMPOS DE ENTREGA

--1. DeliveryTime promedio por tipo de envío (Ship Mode)

SELECT 
[Ship Mode],
AVG(DeliveryTime) AS AvgDeliveryDays,
COUNT(*) AS TotalOrders
FROM dbo.DatosTrainRaw
GROUP BY [Ship Mode]
ORDER BY AvgDeliveryDays DESC;


--2. Órdenes con mayor DeliveryTime, del MAYOR al MENOR, con información relevante para posible justificativo de demoras.
SELECT 
    [Order ID],
    [Product Name],
    DeliveryTime,
    [Ship Mode],
    [Order Date],
    [Ship Date],
    Region
FROM dbo.DatosTrainRaw
ORDER BY DeliveryTime DESC;


CLIENTES

--1. Que tipo de cliente compra mas segun region, trimestre, promedio de demora en el delivery y la suma de su venta. Ordenados por AVG de demora y TotalSales.

SELECT 
Segment,
Region,
Quarter,
AVG(DeliveryTime) AS AvgDeliveryDays,
SUM(Sales) AS TotalSales
FROM dbo.DatosTrainRaw
GROUP BY Segment, Region, Quarter
ORDER BY AvgDeliveryDays DESC, TotalSales DESC;

--2. ¿Qué tipo de cliente (Segment) compra más según trimestre/zona?



--3. Revisar la demora de entrega en cada caso para ver si tiene relacion




ALERTAS

--1. Ventas con DeliveryTime inusualmente alto (>15 días)


