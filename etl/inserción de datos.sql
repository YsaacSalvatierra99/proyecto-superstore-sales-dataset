
/*Insercion de datos en la tabla Clientes*/

INSERT INTO Clientes (CustomerID, CustomerName, Segment)
SELECT DISTINCT
    [Customer ID],
    [Customer Name],
    Segment
FROM DatosTrainRaw;


/*Insercion de datos en la tabla Productos*/

INSERT INTO Productos (ProductID, ProductName, Category, SubCategory)
SELECT DISTINCT
    [Product ID],
    [Product Name],
    Category,
    [Sub-Category]
FROM DatosTrainRaw;



/*Insercion de datos en la tabla Ventas*/

INSERT INTO Ventas (
    [Order ID],
    [Order Date],
    [Ship Date],
    [Ship Mode],
    Sales,
    [Postal Code],
    City,
    State,
    Country,
    Region,
    [Customer ID],
    [Product ID]
)
SELECT
    [Order ID],
    CAST([Order Date] AS DATE),
    CAST([Ship Date] AS DATE),
    [Ship Mode],
    CAST(Sales AS DECIMAL(18,2)),
    CAST([Postal Code] AS VARCHAR(20)), -- <-- Esto cambia
    City,
    State,
    Country,
    Region,
    [Customer ID],
    [Product ID]
FROM DatosTrainRaw;

/*Inserción de los datos de la tabla Geografia.
  La diferencia con las demas inserciones es que esta te normaliza los espacios en blancos del principio y final,
  tambien las mayusculas, solo la primera letra de cada palabra.

  Cuando pueda deberia usar este metodo para las demas inserciones, vaciando las tablas y colocandolas de nuevo 
  pero con esta version.
*/


INSERT INTO Geografia (Postal_Code, City, State, Country, Region)
SELECT 
    TRIM(CAST([Postal Code] AS VARCHAR(20))), 
    UPPER(TRIM(MAX(City))), 
    UPPER(TRIM(MAX(State))), 
    UPPER(TRIM(MAX(Country))), 
    UPPER(TRIM(MAX(Region)))
FROM DatosTrainRaw
WHERE [Postal Code] IS NOT NULL
GROUP BY [Postal Code];

/* Inserción de los datos en la tabla Tiempo*/

INSERT INTO Tiempo (Order_Date, Year, Month, Month_Name, Quarter, Semester)
SELECT DISTINCT 
    [Order Date], 
    Year, 
    Month, 
    UPPER(TRIM(MonthName)), 
    Quarter, 
    UPPER(TRIM(Semester))
FROM DatosTrainRaw
WHERE [Order Date] IS NOT NULL;
