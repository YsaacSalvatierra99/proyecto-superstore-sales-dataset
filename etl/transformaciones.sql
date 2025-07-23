/*
    Limpieza de datos en SQL - Superstore Dataset
    Habilidades aplicadas: SELECT, UPDATE, CAST, CONVERT, ISNULL, CASE, GROUP BY
*/

-- 1. Vista general del dataset
SELECT * FROM train;

-- 2. Estandarizar formato de fecha (si fuera necesario)
-- SELECT [Order Date], CAST([Order Date] AS DATE) FROM train;
-- UPDATE train SET [Order Date] = CAST([Order Date] AS DATE);

-- 3. Reemplazar valores nulos en columnas clave
-- SELECT * FROM train WHERE [Customer Name] IS NULL;
-- UPDATE train SET [Customer Name] = 'Desconocido' WHERE [Customer Name] IS NULL;

-- 4. Eliminar filas duplicadas (si aplica)
-- WITH CTE_Duplicates AS (
--     SELECT *, ROW_NUMBER() OVER (PARTITION BY [Order ID], [Product ID] ORDER BY [Row ID]) AS fila
--     FROM train
-- )
-- DELETE FROM CTE_Duplicates WHERE fila > 1;

-- 5. Crear nuevas columnas derivadas (ejemplo: año de orden)
-- SELECT [Order Date], YEAR([Order Date]) AS AñoOrden FROM train;
-- ALTER TABLE train ADD AñoOrden INT;
-- UPDATE train SET AñoOrden = YEAR([Order Date]);

-- 6. Validar ventas negativas
-- SELECT * FROM train WHERE Sales < 0;
