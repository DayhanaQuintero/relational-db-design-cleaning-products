CREATE TABLE Proveedores (
    IdProveedor INT IDENTITY PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Contacto VARCHAR(255) NOT NULL,
    Telefono VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    Direccion VARCHAR(255),
    FormaDePago VARCHAR(255)
);

-- Tabla Productos
CREATE TABLE Productos (
    IdProducto INT IDENTITY PRIMARY KEY,
    NombreProducto VARCHAR(255) NOT NULL,
    Categoria VARCHAR(255),
    Presentacion VARCHAR(255),
    PrecioVenta DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL,
    IdProveedor INT NOT NULL,
    FechaUltimaReposicion DATE,
    CONSTRAINT FK_Productos_Proveedores 
        FOREIGN KEY (IdProveedor) REFERENCES Proveedores(IdProveedor)
);

-- Tabla Clientes
CREATE TABLE Clientes (
    IdCliente INT IDENTITY PRIMARY KEY,
    Nombre VARCHAR(255) NOT NULL,
    Telefono VARCHAR(255),
    Email VARCHAR(255),
    Direccion VARCHAR(255)
);

-- Tabla Ventas
CREATE TABLE Ventas (
    IdVenta INT IDENTITY PRIMARY KEY,
    FechaHora DATETIME NOT NULL DEFAULT GETDATE(),
    IdCliente INT NULL,
    Total DECIMAL(10,2) NOT NULL,
    FormaDePago NVARCHAR(20) NOT NULL,
    CONSTRAINT FK_Ventas_Clientes
        FOREIGN KEY (IdCliente) REFERENCES Clientes(IdCliente)
);

-- Tabla Detalle_Venta
CREATE TABLE Detalle_Venta (
    IdDetalle INT IDENTITY PRIMARY KEY,
    IdVenta INT NOT NULL,
    IdProducto INT NOT NULL,
    CantidadComprada INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Detalle_Venta_Ventas
        FOREIGN KEY (IdVenta) REFERENCES Ventas(IdVenta),
    CONSTRAINT FK_Detalle_Venta_Productos
        FOREIGN KEY (IdProducto) REFERENCES Productos(IdProducto)
);

-- Tabla Entregas
CREATE TABLE Entregas (
    IdEntrega INT IDENTITY PRIMARY KEY,
    IdVenta INT NOT NULL,
    DireccionEntrega VARCHAR(255) NOT NULL,
    EstadoEntrega VARCHAR(255) NOT NULL CHECK (EstadoEntrega IN ('Pendiente', 'En camino', 'Entregado')),
    FechaEntrega DATE,
    CONSTRAINT FK_Entregas_Ventas
        FOREIGN KEY (IdVenta) REFERENCES Ventas(IdVenta)
);