
/* Relacion entre Ventas[Customer ID] y Clientes[CustomerID] */
ALTER TABLE dbo.Ventas
ADD CONSTRAINT FK_Ventas_Clientes
FOREIGN KEY ([Customer ID]) REFERENCES dbo.Clientes(CustomerID);

/* Relacion entre Ventas[Product ID] y Productos[ProductID] */
ALTER TABLE dbo.Ventas
ADD CONSTRAINT FK_Ventas_Productos
FOREIGN KEY ([Product ID]) REFERENCES dbo.Productos(ProductID);

/* Relacion entre Ventas[Postal Code] y Geografia[Postal Code]*/
ALTER TABLE dbo.Ventas
ADD CONSTRAINT FK_Ventas_Geografia 
FOREIGN KEY ([Postal Code]) REFERENCES dbo.Geografia(Postal_Code);

/* Relacion entre Ventas[Order Date] y Geografia[Order_date]*/
ALTER TABLE dbo.Ventas
ADD CONSTRAINT FK_Ventas_Tiempo 
FOREIGN KEY ([Order Date]) REFERENCES dbo.Tiempo(Order_Date);








/* Me parecia mucho codigo y poco practico si fuesen mas columnas, pero no sabia como resolverlo. 
   Le pregunté a chatgpt pero me daba version con If que aun no manejo y no sabria explicar bien, por ahora usare este metodo.
*/

-- TABLA VENTAS
EXEC sp_rename 'dbo.Ventas.[Order Date]', 'order_date', 'COLUMN';
EXEC sp_rename 'dbo.Ventas.[Ship Date]', 'ship_date', 'COLUMN';
EXEC sp_rename 'dbo.Ventas.[Ship Mode]', 'ship_mode', 'COLUMN';
EXEC sp_rename 'dbo.Ventas.[Postal Code]', 'postal_code', 'COLUMN';
EXEC sp_rename 'dbo.Ventas.[Customer ID]', 'customer_id', 'COLUMN';
EXEC sp_rename 'dbo.Ventas.[Product ID]', 'product_id', 'COLUMN';

-- TABLA CLIENTES
EXEC sp_rename 'dbo.Clientes.CustomerID', 'customer_id', 'COLUMN';
EXEC sp_rename 'dbo.Clientes.CustomerName', 'customer_name', 'COLUMN';
EXEC sp_rename 'dbo.Clientes.Segment', 'segment', 'COLUMN';

-- TABLA PRODUCTOS
EXEC sp_rename 'dbo.Productos.ProductID', 'product_id', 'COLUMN';
EXEC sp_rename 'dbo.Productos.ProductName', 'product_name', 'COLUMN';
EXEC sp_rename 'dbo.Productos.Category', 'category', 'COLUMN';
EXEC sp_rename 'dbo.Productos.SubCategory', 'sub_category', 'COLUMN';

-- TABLA GEOGRAFIA
EXEC sp_rename 'dbo.Geografia.City', 'city', 'COLUMN';
EXEC sp_rename 'dbo.Geografia.State', 'state', 'COLUMN';
EXEC sp_rename 'dbo.Geografia.Country', 'country', 'COLUMN';
EXEC sp_rename 'dbo.Geografia.Region', 'region', 'COLUMN';
