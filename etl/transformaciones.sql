/*
    Limpieza de datos en SQL - Superstore Dataset
    Habilidades aplicadas: SELECT, UPDATE, CAST, CONVERT, ISNULL, CASE, GROUP BY
Procedimiento:
1) Hacemos una consulta tipo visual para conocer la columna
2) Hacemos otra consulta tipo visual de qué sucedería si pedimos los datos con la/s modificación/es para normalizarla, y ver si aparecería algun error.
3) Editamos los datos con consultas visuales para verificar los datos que no coinciden con los demás.
4) Una vez sepamos las modificaciones necesarias para que coincidan los datos, utilizamos los comandos de ALTER TABLE, UPDATE (entre otros) para que este cambio afecte de manera permanente en la tabla.
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

UPDATE dbo.DatosTrainRaw
SET 
  [Order ID]       = ISNULL([Order ID], 'Desconocido'),
  [Ship Mode]      = ISNULL([Ship Mode], 'Desconocido'),
  [Customer ID]    = ISNULL([Customer ID], 'Desconocido'),
  [Customer Name]  = ISNULL([Customer Name], 'Desconocido'),
  [Segment]        = ISNULL([Segment], 'Desconocido'),
  [Country]        = ISNULL([Country], 'Desconocido'),
  [City]           = ISNULL([City], 'Desconocido'),
  [State]          = ISNULL([State], 'Desconocido'),
  [Region]         = ISNULL([Region], 'Desconocido'),
  [Product ID]     = ISNULL([Product ID], 'Desconocido'),
  [Category]       = ISNULL([Category], 'Desconocido'),
  [Sub-Category]   = ISNULL([Sub-Category], 'Desconocido'),
  [Product Name]   = ISNULL([Product Name], 'Desconocido')
WHERE 
  [Order ID] IS NULL OR
  [Ship Mode] IS NULL OR
  [Customer ID] IS NULL OR
  [Customer Name] IS NULL OR
  [Segment] IS NULL OR
  [Country] IS NULL OR
  [City] IS NULL OR
  [State] IS NULL OR
  [Region] IS NULL OR
  [Product ID] IS NULL OR
  [Category] IS NULL OR
  [Sub-Category] IS NULL OR
  [Product Name] IS NULL;


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

--5. Crear columna Año y asignarle el año de la fecha de orden
ALTER TABLE dbo.DatosTrainRaw
ADD AñoOrden INT;

UPDATE dbo.DatosTrainRaw
SET Año = YEAR([Order Date])
WHERE [Order Date] IS NOT NULL;

-- 5.2 Crear columna Mes
ALTER TABLE dbo.DatosTrainRaw ADD MesOrden INT;

UPDATE dbo.DatosTrainRaw
SET MesOrden = MONTH([Order Date]);

-- 5.3 Modificar columnas de City y Country en mayuscula para que sea más legible y evitar inconsistencias 
UPDATE dbo.DatosTrainRaw
SET City = UPPER(City),
    Country = UPPER(Country);

-- 6.1 Normalizar los precios ya que estaban mal puestos debido a un error en la importacion por la nominacion regional en el uso de "," y "."

SELECT [Row ID], [PRODUCT Name], [SALES]
FROM DatosTrainRaw;

SELECT TOP 20 Sales, Sales / 1000.0 AS Corregido
FROM dbo.DatosTrainRaw
ORDER BY Sales DESC;

UPDATE dbo.DatosTrainRaw
SET Sales = Sales / 1000.0
WHERE Sales > 1000000;  -- Esto es para que no afecte a los valores que no eran tan altos por lo tanto no tenian este error



