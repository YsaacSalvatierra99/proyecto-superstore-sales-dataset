
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
