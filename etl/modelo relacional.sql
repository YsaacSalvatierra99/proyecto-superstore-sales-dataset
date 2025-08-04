/* Tabla Ventas con Tabla Clientes*/

ALTER TABLE Ventas
ADD CONSTRAINT FK_Ventas_Clientes
FOREIGN KEY ([Customer ID])
REFERENCES Clientes(CustomerID);


/* Tabla Ventas con Tabla Productos*/

ALTER TABLE Ventas
ADD CONSTRAINT FK_Ventas_Productos
FOREIGN KEY ([Product ID])
REFERENCES Productos(ProductID);


/* Tabla DatosTrainRaw con Tabla Clientes*/

ALTER TABLE DatosTrainRaw
ADD CONSTRAINT FK_DatosTrainRaw_Clientes
FOREIGN KEY ([Customer ID])
REFERENCES Clientes(CustomerID);


/* Tabla DatosTrainRaw con Tabla Ventas*/

ALTER TABLE DatosTrainRaw
ADD CONSTRAINT FK_DatosTrainRaw_OrderID
FOREIGN KEY ([Order ID])
REFERENCES Ventas([Order ID]);


/* Tabla DatosTrainRaw con Tabla Productos*/

ALTER TABLE DatosTrainRaw
ADD CONSTRAINT FK_DatosTrainRaw_Productos
FOREIGN KEY ([Product ID])
REFERENCES Productos(ProductID);
