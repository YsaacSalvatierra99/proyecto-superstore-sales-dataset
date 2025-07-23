/*
    Limpieza de datos en SQL - Superstore Dataset
    Habilidades aplicadas: SELECT, UPDATE, CAST, CONVERT, ISNULL, CASE, GROUP BY
*/

-- 1. Vista general del dataset
SELECT * FROM train;

-- 2. Estandarizar formato de fecha (si fuera necesario)
SELECT [Order Date], [Ship Date]
FROM dbo.DatosTrainRaw;

UPDATE dbo.DatosTrainRaw
 SET [Order Date] = CAST([Order Date] AS DATE),
     [Ship Date] = CAST([Ship Date] AS DATE);

-- 3. Reemplazar valores nulos en columnas clave (Sé que hay maneras de hacerla con scripts, pero me falta estudiarlo para saber hacerlo mejor)
SELECT *
FROM dbo.DatosTrainRaw
WHERE 
    [Row ID] IS NULL OR
    [Order ID] IS NULL OR
    [Order Date] IS NULL OR
    [Ship Date] IS NULL OR
    [Ship Mode] IS NULL OR
    [Customer ID] IS NULL OR
    [Customer Name] IS NULL OR
    [Segment] IS NULL OR
    [Country] IS NULL OR
    [City] IS NULL OR
    [State] IS NULL OR
    [Postal Code] IS NULL OR
    [Region] IS NULL OR
    [Product ID] IS NULL OR
    [Category] IS NULL OR
    [Sub-Category] IS NULL OR
    [Product Name] IS NULL OR
    [Sales] IS NULL

-- 4. Eliminar filas duplicadas (si aplica)
WITH FilasDuplicadas AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY [Order ID], [Product ID]
               ORDER BY [Row ID]
           ) AS fila
    FROM dbo.DatosTrainRaw
)
DELETE FROM CTE_Duplicados
WHERE fila > 1;

-- 5. Crear nuevas columnas derivadas (ejemplo: año de orden)
-- SELECT [Order Date], YEAR([Order Date]) AS AñoOrden FROM train;
-- ALTER TABLE train ADD AñoOrden INT;
-- UPDATE train SET AñoOrden = YEAR([Order Date]);

-- 6. Validar ventas negativas
-- SELECT * FROM train WHERE Sales < 0;
