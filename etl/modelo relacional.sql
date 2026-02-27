
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

