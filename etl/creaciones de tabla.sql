/*CREACION DE TABLA

-- 1. Primero lo abrí en Excel para separar los datos ya que estaban todos juntos en una misma celda, y necesitaba que esten separados por su delimitador de ",".
Una vez abierto el Excel, fui a Datos/Texto en columnas/Delimitados/Coma.

Ahora me faltaba crear una tabla e importar el data set a la tabla de SQL server.

-- 2. Creacion de tabla tipo RAW(Elegi crear primero una tabla tipo RAW ya que el data set no era muy grande y tenia problemas en la importacion y no sabia si era por el formato de alguna columna o elementos que se me escapaban a entenderlo)
*/

CREATE TABLE dbo.DatosTrainRaw (
    [Row ID] VARCHAR(MAX),
    [Order ID] VARCHAR(MAX),
    [Order Date] VARCHAR(MAX),
    [Ship Date] VARCHAR(MAX),
    [Ship Mode] VARCHAR(MAX),
    [Customer ID] VARCHAR(MAX),
    [Customer Name] VARCHAR(MAX),
    [Segment] VARCHAR(MAX),
    [Country] VARCHAR(MAX),
    [City] VARCHAR(MAX),
    [State] VARCHAR(MAX),
    [Postal Code] VARCHAR(MAX),
    [Region] VARCHAR(MAX),
    [Product ID] VARCHAR(MAX),
    [Category] VARCHAR(MAX),
    [Sub-Category] VARCHAR(MAX),
    [Product Name] VARCHAR(MAX),
    [Sales] VARCHAR(MAX)
);

/* Luego Ingrese el data set superstore-sale-dataset que su nombre predeterminado al descargarlo era train.csv  usando BULK INSERT, por temas de compatibilidad lo mantuve asi, para ver si fue ese el error. */
/* Una vez cree la tabla tipo RAW e ingresé la base de datos. Ahora modifiqué el tipo de dato de las columnas y tambien de los datos para que coincidan, la tabla de diseño se encuentra en el README. */

BULK INSERT dbo.DatosTrainRaw
FROM 'C:\TABLAS DE DATOS\train.csv'
WITH (
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);


--. creacion de tabla clientes 

CREATE TABLE Clientes (
    CustomerID VARCHAR(50) PRIMARY KEY,
    CustomerName VARCHAR(100),
    Segment VARCHAR(50)
);


--. Creacion de tabla de productos 

CREATE TABLE Productos (
    ProductID VARCHAR(50) PRIMARY KEY,
    ProductName VARCHAR(200),
    Category VARCHAR(100),
    SubCategory VARCHAR(100)
);

--. Creacion de tabla de transacciones

CREATE TABLE Ventas (
    [Order ID] VARCHAR(50),          
    [Order Date] DATE,               
    [Ship Date] DATE,             
    [Ship Mode] VARCHAR(50),       
    Sales DECIMAL(18, 2),
    [Postal Code] VARCHAR(20),    
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    Region VARCHAR(50),
    [Customer ID] VARCHAR(50),    
    [Product ID] VARCHAR(50), 
);
