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
SELECT * FROM dbo.DatosTrainRaw;

-- 2. Estandarizar formato de fecha (si fuera necesario)
SELECT [Order Date], [Ship Date]
FROM dbo.DatosTrainRaw;

UPDATE dbo.DatosTrainRaw
 SET [Order Date] = CAST([Order Date] AS DATE),
     [Ship Date] = CAST([Ship Date] AS DATE);

-- 3. Te muestra las filas que llevan NULL en alguna de sus columnas (Solo para visualizarlas, ya que eliminarlo será dependiendo del analisis de datos)
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
DELETE FROM dbo.DatosTrainRaw
WHERE [Row ID] IN (
    SELECT [Row ID]
    FROM FilasDuplicadas
    WHERE fila > 1
);


--5. Crear columna Año y asignarle el año de la fecha de orden
ALTER TABLE dbo.DatosTrainRaw
ADD AñoOrden INT;

UPDATE dbo.DatosTrainRaw
SET AñoOrden = YEAR([Order Date])
WHERE [Order Date] IS NOT NULL;


-- 5.2 Crear columna Mes
ALTER TABLE dbo.DatosTrainRaw ADD MesOrden INT;

UPDATE dbo.DatosTrainRaw
SET MesOrden = MONTH([Order Date]);

-- 5.3 Modificar columnas de City y Country en mayuscula para que sea más legible y evitar inconsistencias 
UPDATE dbo.DatosTrainRaw
SET City = UPPER(City),
    Country = UPPER(Country),
    State = UPPER(State);

-- 6.1 Normalizar los precios ya que estaban mal puestos debido a un error en la importacion por la nominacion regional en el uso de "," y "."

SELECT [Row ID], [PRODUCT Name], [SALES]
FROM DatosTrainRaw;

SELECT TOP 20 Sales, Sales / 1000.0 AS Corregido
FROM dbo.DatosTrainRaw
ORDER BY Sales DESC;

UPDATE dbo.DatosTrainRaw
SET Sales = Sales / 1000.0
WHERE Sales > 1000000;  -- Esto es para que no afecte a los valores que no eran tan altos por lo tanto no tenian este error

--.7 Limpiar los espacios al principio, dentro y al final de las cadenas. Esto para que no hayan dobles espacios, solo 1.
--Entiendo que esta opcion puede no ser eficiente para mas de 2 espacios, para eso pensaba usar WHILE pero no se bien como aplicarlo, hasta entonces me quedare con esta version de una solucion.
UPDATE DatosTrainRaw
SET
    [Order ID]       = LTRIM(RTRIM(REPLACE([Order ID], '  ', ' '))),
    [Ship Mode]      = LTRIM(RTRIM(REPLACE([Ship Mode], '  ', ' '))),
    [Customer ID]    = LTRIM(RTRIM(REPLACE([Customer ID], '  ', ' '))),
    [Customer Name]  = LTRIM(RTRIM(REPLACE([Customer Name], '  ', ' '))),
    Segment          = LTRIM(RTRIM(REPLACE(Segment, '  ', ' '))),
    Country          = LTRIM(RTRIM(REPLACE(Country, '  ', ' '))),
    City             = LTRIM(RTRIM(REPLACE(City, '  ', ' '))),
    State            = LTRIM(RTRIM(REPLACE(State, '  ', ' '))),
    Region           = LTRIM(RTRIM(REPLACE(Region, '  ', ' '))),
    [Product ID]     = LTRIM(RTRIM(REPLACE([Product ID], '  ', ' '))),
    Category         = LTRIM(RTRIM(REPLACE(Category, '  ', ' '))),
    [Sub-Category]   = LTRIM(RTRIM(REPLACE([Sub-Category], '  ', ' '))),
    [Product Name]   = LTRIM(RTRIM(REPLACE([Product Name], '  ', ' ')));

--8. Cambiar datos tipo NULL de la columna [Postal Code] a 9999. 
-- Usaré esta convencion para identificar los NULL aun manteniendome en el tipo de dato INT.

UPDATE DatosTrainRaw
SET [Postal Code] = 99999
WHERE [Postal Code] IS NULL;

--9. Verificar que no haya campos numeros invalidos en columnas tipo INT 
SELECT *
FROM DatosTrainRaw
WHERE Sales < 0;

--10. Verificar que los valores de la columna [Order Date] es menor que [Ship Date]
SELECT *
FROM DatosTrainRaw
WHERE [Ship Date] < [Order Date];

--11. Convertir la columna Mes en texto y pasarla a la columna MesTexto.
SELECT Mes,
       CASE Mes
           WHEN 1 THEN 'Enero'
           WHEN 2 THEN 'Febrero'
           WHEN 3 THEN 'Marzo'
           WHEN 4 THEN 'Abril'
           WHEN 5 THEN 'Mayo'
           WHEN 6 THEN 'Junio'
           WHEN 7 THEN 'Julio'
           WHEN 8 THEN 'Agosto'
           WHEN 9 THEN 'Septiembre'
           WHEN 10 THEN 'Octubre'
           WHEN 11 THEN 'Noviembre'
           WHEN 12 THEN 'Diciembre'
           ELSE 'Desconocido'
       END AS NombreMes
FROM DatosTrainRaw;

ALTER TABLE DatosTrainRaw
ADD MesTexto VARCHAR(20);

UPDATE DatosTrainRaw
SET MonthName = CASE Mes
    WHEN 1 THEN 'January'
    WHEN 2 THEN 'February'
    WHEN 3 THEN 'March'
    WHEN 4 THEN 'April'
    WHEN 5 THEN 'May'
    WHEN 6 THEN 'June'
    WHEN 7 THEN 'July'
    WHEN 8 THEN 'August'
    WHEN 9 THEN 'September'
    WHEN 10 THEN 'October'
    WHEN 11 THEN 'November'
    WHEN 12 THEN 'December'
    ELSE 'Unknown'
END;

--12. Convertir la columna [Order Date] en texto y pasarlo a DiaTexto.

UPDATE DatosTrainRaw
SET OrderDayText = CASE DATEPART(WEEKDAY, [Order Date])
    WHEN 1 THEN 'Sunday'
    WHEN 2 THEN 'Monday'
    WHEN 3 THEN 'Tuesday'
    WHEN 4 THEN 'Wednesday'
    WHEN 5 THEN 'Thursday'
    WHEN 6 THEN 'Friday'
    WHEN 7 THEN 'Saturday'
END;
--13. Crear una columna de trimestre (Q1, Q2, etc.).

ALTER TABLE DatosTrainRaw
ADD Trimestre VARCHAR(5);

UPDATE DatosTrainRaw
SET Trimestre = 
    CASE DATEPART(QUARTER, [Order Date])
        WHEN 1 THEN 'Q1'
        WHEN 2 THEN 'Q2'
        WHEN 3 THEN 'Q3'
        WHEN 4 THEN 'Q4'
    END;

--14. Convertir la columna [Ship Date] en texto y pasarlo a [DiaEntregaTexto].

ALTER TABLE DatosTrainRaw
ADD DeliveryDayText VARCHAR(20);


UPDATE DatosTrainRaw
SET DeliveryDayText = CASE DATEPART(WEEKDAY, [Ship Date])
    WHEN 1 THEN 'Sunday'
    WHEN 2 THEN 'Monday'
    WHEN 3 THEN 'Tuesday'
    WHEN 4 THEN 'Wednesday'
    WHEN 5 THEN 'Thursday'
    WHEN 6 THEN 'Friday'
    WHEN 7 THEN 'Saturday'
END;


--15. Crear una columna TiempoDeEntrega (cantidad de días entre Ship Date y Order Date).

ALTER TABLE DatosTrainRaw
ADD DeliveryTime INT;

UPDATE DatosTrainRaw
SET DeliveryTime = DATEDIFF(DAY, [Order Date], [Ship Date]);

--16. Crear una columna de YearMonth para tener el año y mes en formato texto(varchar).

ALTER TABLE DatosTrainRaw
ADD YearMonth VARCHAR(7);

UPDATE DatosTrainRaw
SET YearMonth = 
    CAST([Year] AS VARCHAR(4)) + '-' + 
    RIGHT('0' + CAST([Month] AS VARCHAR(2)), 2);



