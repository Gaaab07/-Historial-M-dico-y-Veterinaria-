-- Crear la base de datos
CREATE DATABASE VeterinariaDB;
GO

-- Usar la base de datos reciÈn creada
USE VeterinariaDB;
GO

select*from Cliente

-- CreaciÛn de la tabla Cliente/DueÒo
CREATE TABLE Cliente (
    ID_Cliente INT PRIMARY KEY IDENTITY(1,1),
    Nombres VARCHAR(50),
    Apellidos VARCHAR(50),
    DNI CHAR(8),
    Direccion VARCHAR(100),
    Telefono CHAR(9)
);
select*from Trabajador
-- CreaciÛn de la tabla Trabajador
CREATE TABLE Trabajador (
    ID_Trabajador INT PRIMARY KEY IDENTITY(1,1),
    DNI CHAR(8),
    Nombres VARCHAR(50),
    Apellidos VARCHAR(50),
    Telefono CHAR(9),
    Direccion VARCHAR(100),
    Cargo VARCHAR(50),
    Sueldo DECIMAL(10, 2),
    Fecha_Ingreso DATE
);

select*from Mascota
-- CreaciÛn de la tabla Mascota
CREATE TABLE Mascota (
    ID_Mascota INT PRIMARY KEY IDENTITY(1,1),
    ID_Cliente INT FOREIGN KEY REFERENCES Cliente(ID_Cliente) ON DELETE CASCADE,
    Nombre VARCHAR(50),
    Especie VARCHAR(50),
    Raza VARCHAR(50),
    Edad INT,
    Peso DECIMAL(5, 2),
    Sexo CHAR(1),
    Fecha_Nacimiento DATE
);

-- CreaciÛn de la tabla DiagnÛstico
CREATE TABLE Diagnostico (
    ID_Diagnostico INT PRIMARY KEY IDENTITY(1,1),
    ID_Mascota INT FOREIGN KEY REFERENCES Mascota(ID_Mascota) ON DELETE CASCADE,
    Fecha_Diagnostico DATE,
    Sintoma VARCHAR(255),
    Observaciones VARCHAR(255)
);

-- CreaciÛn de la tabla Consulta
CREATE TABLE Consulta (
    NroAtencion INT PRIMARY KEY IDENTITY(1,1),
    ID_Trabajador INT FOREIGN KEY REFERENCES Trabajador(ID_Trabajador) ON DELETE NO ACTION,
    ID_Mascota INT FOREIGN KEY REFERENCES Mascota(ID_Mascota) ON DELETE CASCADE,
    ID_Diagnostico INT FOREIGN KEY REFERENCES Diagnostico(ID_Diagnostico) ON DELETE NO ACTION,
    Fecha_Hora DATETIME,
    Estado VARCHAR(50)
);

-- CreaciÛn de la tabla Tratamiento
CREATE TABLE Tratamiento (
    ID_Tratamiento INT PRIMARY KEY IDENTITY(1,1),
    ID_Diagnostico INT FOREIGN KEY REFERENCES Diagnostico(ID_Diagnostico) ON DELETE CASCADE,
    Duracion INT,
    Fecha_Inicio DATE,
    Fecha_Fin DATE
);
select*from Producto
-- CreaciÛn de la tabla Producto
CREATE TABLE Producto (
    ID_Producto INT PRIMARY KEY IDENTITY(1,1),
    Descripcion VARCHAR(100),
    PrecioVenta DECIMAL(10, 2),
    Categoria VARCHAR(50)
);

-- CreaciÛn de la tabla Pedido
CREATE TABLE Pedido (
    ID_Pedido INT PRIMARY KEY IDENTITY(1,1),
    ID_Trabajador INT FOREIGN KEY REFERENCES Trabajador(ID_Trabajador) ON DELETE CASCADE,
    ID_Cliente INT FOREIGN KEY REFERENCES Cliente(ID_Cliente) ON DELETE CASCADE,
    ID_Producto INT FOREIGN KEY REFERENCES Producto(ID_Producto) ON DELETE CASCADE,
    FechaHora DATE,
    Descripcion VARCHAR(100),
    Cantidad INT,
    PrecioPedido DECIMAL(10, 2),
    Estado VARCHAR(50),
    NroPago VARCHAR(50),
    Monto DECIMAL(10, 2),
    TipoComprobante VARCHAR(50),
    MetodoPago VARCHAR(50)
);

INSERT INTO Cliente (Nombres, Apellidos, DNI, Direccion, Telefono)
VALUES 
('Juan', 'Perez', '12345678', 'Av. Lima 123', '987654321'),
('Maria', 'Rodriguez', '87654321', 'Jr. Ica 456', '987654322'),
('Carlos', 'Sanchez', '34567890', 'Av. Independencia 789', '987654323'),
('Sofia', 'Gomez', '90123456', 'Jr. Arequipa 567', '987654370'),
('Pedro', 'Hernandez', '45678901', 'Av. La Paz 901', '987654371'),
('Ana', 'Garcia', '67890123', 'Av. La Paz 123', '987654372'),
('Luis', 'Martinez', '23456789', 'Jr. Ica 789', '987654373'),
('Eva', 'Hernandez', '34567890', 'Av. Independencia 901', '987654374'),
('Juan', 'Perez', '45678901', 'Av. Lima 456', '987654375'),
('Maria', 'Rodriguez', '56789012', 'Jr. Arequipa 123', '987654376'),
('Carlos', 'Sanchez', '67890123', 'Av. La Paz 789', '987654377'),
('Sofia', 'Gomez', '78901234', 'Av. Independencia 456', '987654378'),
('Pedro', 'Hernandez', '89012345', 'Av. Lima 901', '987654379'),
('Lucia', 'Martinez', '90123456', 'Jr. Ica 123', '987654380'),
('Raul', 'Garcia', '01234567', 'Av. La Paz 456', '987654381'),
('Hugo', 'Alfaro', '67890123', 'Av. La Paz 123', '987654382'),
('Luis', 'Martinez', '23456789', 'Jr. Ica 789', '987654383'),
('Eva', 'Hernandez', '34567890', 'Av. Independencia 901', '987654384'),
('Juan', 'Perez', '45678901', 'Av. Lima 456', '987654385'),
('Maria', 'Rodriguez', '56789012', 'Jr. Arequipa 123', '987654386'),
('Carlos', 'Sanchez', '67890123', 'Av. La Paz 789', '987654387'),
('Sofia', 'Gomez', '78901234', 'Av. Independencia 456', '987654388'),
('Pedro', 'Hernandez', '89012345', 'Av. Lima 901', '987654389'),
('Lucia', 'Martinez', '90123456', 'Jr. Ica 123', '987654390'),
('Raul', 'Garcia', '01234567', 'Av. La Paz 456', '987654391');

INSERT INTO Mascota (ID_Cliente, Nombre, Especie, Raza, Edad, Peso, Sexo, Fecha_Nacimiento)
VALUES 
(1, 'Max', 'Perro', 'Golden', 3, 20.50, 'M', '2019-01-01'),
(2, 'Luna', 'Gato', 'Siames', 2, 10.20, 'F', '2020-02-02'),
(3, 'Rocky', 'Perro', 'Boxer', 5, 30.00, 'M', '2018-03-03'),
(4, 'Toby', 'Perro', 'Poodle', 1, 5.00, 'M', '2022-04-04'),
(5, 'Fido', 'Perro', 'Labrador', 4, 25.00, 'M', '2020-05-05'),
(6, 'Lola', 'Perro', 'Poodle', 2, 10.00, 'F', '2020-06-06'),
(7, 'Toro', 'Perro', 'Boxer', 3, 20.00, 'M', '2019-07-07'),
(8, 'Mia', 'Gato', 'Siames', 1, 5.00, 'F', '2022-08-08'),
(9, 'Fido', 'Perro', 'Labrador', 4, 25.00, 'M', '2018-09-09'),
(10, 'Gato', 'Gato', 'Persa', 5, 15.00, 'M', '2017-10-10'),
(11, 'Perra', 'Perro', 'Chihuahua', 2, 8.00, 'F', '2020-11-11'),
(12, 'Perro', 'Perro', 'Golden', 3, 20.00, 'M', '2019-12-12'),
(13, 'Gatito', 'Gato', 'SiamÈs', 1, 5.00, 'M', '2022-01-01'),
(14, 'Perrito', 'Perro', 'Poodle', 2, 10.00, 'M', '2020-02-02'),
(15, 'Gatita', 'Gato', 'Persa', 3, 15.00, 'F', '2019-03-03'),
(16, 'Lola', 'Perro', 'Poodle', 2, 10.00, 'F', '2020-06-06'),
(17, 'Toro', 'Perro', 'Boxer', 3, 20.00, 'M', '2019-07-07'),
(18, 'Mia', 'Gato', 'Siames', 1, 5.00, 'F', '2022-08-08'),
(19, 'Fido', 'Perro', 'Labrador', 4, 25.00, 'M', '2018-09-09'),
(20, 'Gato', 'Gato', 'Persa', 5, 15.00, 'M', '2017-10-10'),
(21, 'Pepa', 'Perro', 'Chihuahua', 2, 8.00, 'F', '2020-11-11'),
(22, 'Perry', 'Perro', 'Golden', 3, 20.00, 'M', '2019-12-12'),
(23, 'steven', 'Gato', 'SiamÈs', 1, 5.00, 'M', '2022-01-01'),
(24, 'chato', 'Perro', 'Poodle', 2, 10.00, 'M', '2020-02-02'),
(25, 'Gatitaonly', 'Gato', 'Persa', 3, 15.00, 'F', '2019-03-03');

INSERT INTO Trabajador (DNI, Nombres, Apellidos, Telefono, Direccion, Cargo, Sueldo, Fecha_Ingreso)
VALUES 
('11111111', 'Juan', 'Hernandez', '987654321', 'Av. Lima 123', 'Veterinario', 5000.00, '2015-01-01'),
('22222222', 'Maria', 'Martinez', '987654322', 'Jr. Ica 456', 'Enfermera', 4000.00, '2016-02-02'),
('33333333', 'Carlos', 'Sanchez', '987654323', 'Av. Independencia 789', 'Recepcionista', 3000.00, '2017-03-03'),
('44444444', 'Sofia', 'Gomez', '987654370', 'Jr. Arequipa 567', 'Veterinaria', 6000.00, '2020-04-04'),
('55555555', 'Pedro', 'Ugarte', '987654371', 'Av. La Paz 901', 'Enfermero', 4500.00, '2018-05-05'),
('77777778', 'Sara', 'Gomez', '987654388', 'Av. Independencia 456', 'Enfermera', 4000.00, '2016-02-02'),
('88888889', 'Mariano', 'Villanueva', '987654389', 'Av. Lima 901', 'Recepcionista', 3000.00, '2017-03-03'),
('99999990', 'Piero', 'Martinez', '987654390', 'Jr. Ica 123', 'Veterinario', 6000.00, '2020-04-04'),
('10101011', 'Yair', 'Pereda', '987654391', 'Av. La Paz 456', 'Enfermero', 4500.00, '2018-05-05'),
('11111112', 'Eder', 'Garc˙}', '987654392', 'Av. Independencia 789', 'Veterinario', 5500.00, '2019-06-06'),
('77777779', 'Eva', 'Gomez', '987654398', 'Av. Independencia 456', 'Enfermera', 4000.00, '2016-02-02'),
('88888880', 'Elisa', 'Lopez', '987654399', 'Av. Lima 901', 'Recepcionista', 3000.00, '2017-03-03'),
('99999981', 'B·rbara', 'Martinez', '987654400', 'Jr. Ica 123', 'Veterinaria', 6000.00, '2020-04-04'),
('10101012', 'Rodrigo', 'Huaynates', '987654401', 'Av. La Paz 456', 'Enfermero', 4500.00, '2018-05-05'),
('11111113', 'Johana', 'Ch·vez', '987654402', 'Av. Independencia 789', 'Veterinaria', 5500.00, '2019-06-06');

INSERT INTO Consulta (ID_Trabajador, ID_Mascota, ID_Diagnostico, Fecha_Hora, Estado)
VALUES 
(1, 1, 1, '2022-02-02 11:00', 'Pendiente'),
(2, 2, 2, '2022-03-03 12:00', 'Pendiente'),
(3, 3, 3, '2022-04-04 13:00', 'Pendiente'),
(4, 4, 4, '2022-05-05 14:00', 'Pendiente'),
(5, 5, 5, '2022-11-11 15:00', 'Pendiente'),
(6, 6, 6, '2022-12-12 16:00', 'Pendiente'),
(7, 7, 7, '2023-01-01 17:00', 'Pendiente'),
(8, 8, 8, '2023-02-02 18:00', 'Pendiente'),
(9, 9, 9, '2023-03-03 19:00', 'Pendiente'),
(10, 10, 10, '2022-11-11 15:00', 'Pendiente'),
(11, 11, 11, '2022-12-12 16:00', 'Pendiente'),
(12, 12, 12, '2023-01-01 17:00', 'Pendiente'),
(13, 13, 13, '2023-02-02 18:00', 'Pendiente'),
(14, 14, 14, '2023-03-03 19:00', 'Pendiente');

INSERT INTO Diagnostico (ID_Mascota, Fecha_Diagnostico, Sintoma, Observaciones)
VALUES 
(1, '2022-01-01', 'Fiebre', 'No tiene antecedentes de enfermedades'),
(2, '2022-02-02', 'Vomito', 'Se observÅEpresencia de gusanos'),
(3, '2022-03-03', 'Dolor', 'Se realizÅEradiograf˙} para determinar causa'),
(4, '2022-04-04', 'Sarpullido', 'Se recomienda tratamiento con antibiÛticos'),
(5, '2022-05-05', 'Fatiga', 'Se realizaron an·lisis de sangre'),
(6, '2022-06-06', 'Fiebre', 'No tiene antecedentes de enfermedades'),
(7, '2022-07-07', 'Vomito', 'Se observÅEpresencia de gusanos'),
(8, '2022-08-08', 'Dolor', 'Se realizÅEradiograf˙} para determinar causa'),
(9, '2022-09-09', 'Sarpullido', 'Se recomienda tratamiento con antibiÛticos'),
(10, '2022-10-10', 'Fatiga', 'Se realizaron an·lisis de sangre'),
(11, '2022-11-11', 'Tos', 'Se recomienda tratamiento con antibiÛticos'),
(12, '2022-12-12', 'Dolor de cabeza', 'Se realizÅEradiograf˙} para determinar causa'),
(13, '2023-01-01', 'Fiebre alta', 'No tiene antecedentes de enfermedades'),
(14, '2023-02-02', 'Vomito', 'Se observÅEpresencia de gusanos'),
(15, '2023-03-03', 'Dolor de estÛmago', 'Se recomienda tratamiento con antibiÛticos');

INSERT INTO Tratamiento (ID_Diagnostico, Duracion, Fecha_Inicio, Fecha_Fin)
VALUES 

(1, 14, '20230715', '20230529'),
(2, 3, '20230316', '20230319'),
(3, 7, '20220607', '20220614'),
(4, 10, '20220708', '20220718'),
(5, 5, '20220809', '20220814'),
(6, 14, '20220910', '20220924'),
(7, 3, '20221011', '20221014');

INSERT INTO Producto (Descripcion, PrecioVenta, Categoria)
VALUES 
('Alimento para perros', 50.00, 'Alimentos'),
('Vacuna antirr·bica', 20.00, 'Medicamentos'),
('Ropa para mascotas', 30.00, 'Accesorios'),
('Shampoo para perros', 15.00, 'Higiene'),
('Juguete para gatos', 25.00, 'Juguetes'),
('Alimento para gatos', 40.00, 'Alimentos'),
('Vacuna antiparasitaria', 30.00, 'Medicamentos'),
('Ropa para perros', 35.00, 'Accesorios'),
('Shampoo para gatos', 20.00, 'Higiene'),
('Juguete para perros', 45.00, 'Juguetes'),
('Alimento para peces', 50.00, 'Alimentos'),
('Vacuna antiviral', 40.00, 'Medicamentos'),
('Ropa para gatos', 30.00, 'Accesorios'),
('Shampoo para perros', 25.00, 'Higiene'),
('Juguete para gatos', 40.00, 'Juguetes'),
('Alimento para perros', 50.00, 'Alimentos'),
('Vacuna antirr·bica', 20.00, 'Medicamentos'),
('Ropa para mascotas', 30.00, 'Accesorios'),
('Shampoo para perros', 15.00, 'Higiene'),
('Juguete para gatos', 25.00, 'Juguetes'),
('Alimento para gatos', 40.00, 'Alimentos'),
('Vacuna antiparasitaria', 30.00, 'Medicamentos'),
('Ropa para perros', 35.00, 'Accesorios'),
('Shampoo para gatos', 20.00, 'Higiene'),
('Juguete para perros', 45.00, 'Juguetes'),
('Alimento para cachorros', 45.00, 'Alimentos'),
('Alimento para gatitos', 40.00, 'Alimentos'),
('Vacuna antiviral para perros', 40.00, 'Medicamentos'),
('Vacuna antiviral para gatos', 35.00, 'Medicamentos'),
('Ropa para perros de invierno', 40.00, 'Accesorios'),
('Ropa para gatos de invierno', 35.00, 'Accesorios'),
('Shampoo para perros con alergias', 25.00, 'Higiene'),
('Shampoo para gatos con alergias', 20.00, 'Higiene'),
('Juguete para perros de madera', 50.00, 'Juguetes'),
('Juguete para gatos de lana', 40.00, 'Juguetes'),
('Alimento para perros con problemas digestivos', 50.00, 'Alimentos'),
('Alimento para gatos con problemas digestivos', 45.00, 'Alimentos'),
('Vacuna contra la tos de perros', 30.00, 'Medicamentos'),
('Vacuna contra la tos de gatos', 25.00, 'Medicamentos');

INSERT INTO Pedido (ID_Trabajador, ID_Cliente, ID_Producto, FechaHora, Descripcion, Cantidad, PrecioPedido, Estado, NroPago, Monto, TipoComprobante, MetodoPago)
VALUES 
(1, 1, 1, '2022-01-01', 'Pedido de alimento', 2, 100.00, 'Pendiente', '001', 100.00, 'Boleta', 'Efectivo'),
(2, 2, 2, '2022-02-02', 'Pedido de vacuna', 1, 20.00, 'Pendiente', '002', 20.00, 'Factura', 'Tarjeta'),
(3, 3, 3, '2022-03-03', 'Pedido de ropa', 3, 90.00, 'Pendiente', '003', 90.00, 'Boleta', 'Efectivo'),
(4, 4, 4, '2022-04-04', 'Pedido de shampoo', 1, 15.00, 'Pendiente', '004', 15.00, 'Factura', 'Tarjeta'),
(5, 5, 5, '2022-05-05', 'Pedido de juguete', 2, 50.00, 'Pendiente', '005', 50.00, 'Boleta', 'Efectivo'),
(6, 6, 1, '2022-06-06', 'Pedido de alimento', 2, 80.00, 'Pendiente', '011', 80.00, 'Boleta', 'Efectivo'),
(2, 7, 2, '2022-07-07', 'Pedido de vacuna', 1, 30.00, 'Pendiente', '012', 30.00, 'Factura', 'Tarjeta'),
(3, 8, 3, '2022-08-08', 'Pedido de ropa', 3, 105.00, 'Pendiente', '013', 105.00, 'Boleta', 'Efectivo'),
(4, 9, 4, '2022-09-09', 'Pedido de shampoo', 1, 20.00, 'Pendiente', '014', 20.00, 'Factura', 'Tarjeta'),
(5, 10, 5, '2022-10-10', 'Pedido de juguete', 2, 90.00, 'Pendiente', '015', 90.00, 'Boleta', 'Efectivo'),
(6, 11, 6, '2022-11-11', 'Pedido de alimento', 3, 150.00, 'Pendiente', '016', 150.00, 'Factura', 'Tarjeta'),
(7, 12, 7, '2022-12-12', 'Pedido de vacuna', 2, 80.00, 'Pendiente', '017', 80.00, 'Boleta', 'Efectivo'),
(8, 13, 8, '2023-01-01', 'Pedido de ropa', 4, 120.00, 'Pendiente', '018', 120.00, 'Factura', 'Tarjeta'),
(9, 14, 9, '2023-02-02', 'Pedido de shampoo', 2, 50.00, 'Pendiente', '019', 50.00, 'Boleta', 'Efectivo');


--Agregar cliente
CREATE PROCEDURE sp_AgregarCliente
    @Nombres VARCHAR(50),
    @Apellidos VARCHAR(50),
    @DNI CHAR(8),
    @Direccion VARCHAR(100),
    @Telefono CHAR(9)
AS
BEGIN
    INSERT INTO Cliente (Nombres, Apellidos, DNI, Direccion, Telefono)
    VALUES (@Nombres, @Apellidos, @DNI, @Direccion, @Telefono);
END;

--Modificar cliente
CREATE PROCEDURE sp_ModificarCliente
    @ID_Cliente INT,
    @Nombres VARCHAR(50),
    @Apellidos VARCHAR(50),
    @DNI CHAR(8),
    @Direccion VARCHAR(100),
    @Telefono CHAR(9)
AS
BEGIN
    UPDATE Cliente
    SET Nombres = @Nombres, Apellidos = @Apellidos, DNI = @DNI, Direccion = @Direccion, Telefono = @Telefono
    WHERE ID_Cliente = @ID_Cliente;
END;

--Eliminar Cliente
CREATE PROCEDURE sp_EliminarCliente
    @ID_Cliente INT
AS
BEGIN
    DELETE FROM Cliente
    WHERE ID_Cliente = @ID_Cliente;
END;

EXEC sp_EliminarCliente @ID_Cliente = 1;

--Buscar cliente
CREATE PROCEDURE sp_BuscarCliente
    @DNI CHAR(8)
AS
BEGIN
    SELECT * FROM Cliente
    WHERE DNI = @DNI;
END;

EXEC sp_BuscarCliente @DNI = '12345678';

--Agregar Mascota
CREATE PROCEDURE sp_AgregarMascota
    @ID_Cliente INT,
    @Nombre VARCHAR(50),
    @Especie VARCHAR(50),
    @Raza VARCHAR(50),
    @Edad INT,
    @Peso DECIMAL(5, 2),
    @Sexo CHAR(1),
    @Fecha_Nacimiento DATE
AS
BEGIN
    INSERT INTO Mascota (ID_Cliente, Nombre, Especie, Raza, Edad, Peso, Sexo, Fecha_Nacimiento)
    VALUES (@ID_Cliente, @Nombre, @Especie, @Raza, @Edad, @Peso, @Sexo, @Fecha_Nacimiento);
END;

--Modificar mascota
CREATE PROCEDURE sp_ModificarMascota
    @ID_Mascota INT,
    @Nombre VARCHAR(50),
    @Especie VARCHAR(50),
    @Raza VARCHAR(50),
    @Edad INT,
    @Peso DECIMAL(5, 2),
    @Sexo CHAR(1),
    @Fecha_Nacimiento DATE
AS
BEGIN
    UPDATE Mascota
    SET Nombre = @Nombre, Especie = @Especie, Raza = @Raza, Edad = @Edad, Peso = @Peso, Sexo = @Sexo, Fecha_Nacimiento = @Fecha_Nacimiento
    WHERE ID_Mascota = @ID_Mascota;
END;

--Eliminar mascota
CREATE PROCEDURE sp_EliminarMascota
    @ID_Mascota INT
AS
BEGIN
    DELETE FROM Mascota
    WHERE ID_Mascota = @ID_Mascota;
END;

--Buscar mascota
CREATE PROCEDURE sp_BuscarMascota
    @ID_Mascota INT
AS
BEGIN
    SELECT * FROM Mascota
    WHERE ID_Mascota = @ID_Mascota;
END;

--Agregar trabajador
CREATE PROCEDURE sp_AgregarTrabajador
    @DNI CHAR(8),
    @Nombres VARCHAR(50),
    @Apellidos VARCHAR(50),
    @Telefono CHAR(9),
    @Direccion VARCHAR(100),
    @Cargo VARCHAR(50),
    @Sueldo DECIMAL(10, 2),
    @Fecha_Ingreso DATE
AS
BEGIN
    INSERT INTO Trabajador (DNI, Nombres, Apellidos, Telefono, Direccion, Cargo, Sueldo, Fecha_Ingreso)
    VALUES (@DNI, @Nombres, @Apellidos, @Telefono, @Direccion, @Cargo, @Sueldo, @Fecha_Ingreso);
END;

--Modificar trabajador
CREATE PROCEDURE sp_ModificarTrabajador
    @ID_Trabajador INT,
    @DNI CHAR(8),
    @Nombres VARCHAR(50),
    @Apellidos VARCHAR(50),
    @Telefono CHAR(9),
    @Direccion VARCHAR(100),
    @Cargo VARCHAR(50),
    @Sueldo DECIMAL(10, 2),
    @Fecha_Ingreso DATE
AS
BEGIN
    UPDATE Trabajador
    SET DNI = @DNI, Nombres = @Nombres, Apellidos = @Apellidos, Telefono = @Telefono, Direccion = @Direccion, Cargo = @Cargo, Sueldo = @Sueldo, Fecha_Ingreso = @Fecha_Ingreso
    WHERE ID_Trabajador = @ID_Trabajador;
END;

--Eliminar trabajador
CREATE PROCEDURE sp_EliminarTrabajador
    @ID_Trabajador INT
AS
BEGIN
    DELETE FROM Trabajador
    WHERE ID_Trabajador = @ID_Trabajador;
END;

--Buscar trabajador
CREATE PROCEDURE sp_BuscarTrabajador
    @ID_Trabajador INT
AS
BEGIN
    SELECT * FROM Trabajador
    WHERE ID_Trabajador = @ID_Trabajador;
END;

--Agregar producto
CREATE PROCEDURE sp_AgregarProducto
    @Descripcion VARCHAR(100),
    @PrecioVenta DECIMAL(10, 2),
    @Categoria VARCHAR(50)
AS
BEGIN
    INSERT INTO Producto (Descripcion, PrecioVenta, Categoria)
    VALUES (@Descripcion, @PrecioVenta, @Categoria);
END;

--Modificar producto
CREATE PROCEDURE sp_ModificarProducto
    @ID_Producto INT,
    @Descripcion VARCHAR(100),
    @PrecioVenta DECIMAL(10, 2),
    @Categoria VARCHAR(50)
AS
BEGIN
    UPDATE Producto
    SET Descripcion = @Descripcion, PrecioVenta = @PrecioVenta, Categoria = @Categoria
    WHERE ID_Producto = @ID_Producto;
END;

--Eliminar producto
CREATE PROCEDURE sp_EliminarProducto
    @ID_Producto INT
AS
BEGIN
    DELETE FROM Producto
    WHERE ID_Producto = @ID_Producto;
END;

--Buscar producto
CREATE PROCEDURE sp_BuscarProducto
    @ID_Producto INT
AS
BEGIN
    SELECT * FROM Producto
    WHERE ID_Producto = @ID_Producto;
END;

--Agregar consulta
CREATE PROCEDURE sp_AgregarConsulta
    @ID_Trabajador INT,
    @ID_Mascota INT,
    @ID_Diagnostico INT,
    @Fecha_Hora DATETIME,
    @Estado VARCHAR(50)
AS
BEGIN
    INSERT INTO Consulta (ID_Trabajador, ID_Mascota, ID_Diagnostico, Fecha_Hora, Estado)
    VALUES (@ID_Trabajador, @ID_Mascota, @ID_Diagnostico, @Fecha_Hora, @Estado);
END;

--Modificar consulta
CREATE PROCEDURE sp_ModificarConsulta
    @NroAtencion INT,
    @ID_Trabajador INT,
    @ID_Mascota INT,
    @ID_Diagnostico INT,
    @Fecha_Hora DATETIME,
    @Estado VARCHAR(50)
AS
BEGIN
    UPDATE Consulta
    SET ID_Trabajador = @ID_Trabajador,
        ID_Mascota = @ID_Mascota,
        ID_Diagnostico = @ID_Diagnostico,
        Fecha_Hora = @Fecha_Hora,
        Estado = @Estado
    WHERE NroAtencion = @NroAtencion;
END;

--Eliminar consulta
CREATE PROCEDURE sp_EliminarConsulta
    @NroAtencion INT
AS
BEGIN
    DELETE FROM Consulta
    WHERE NroAtencion = @NroAtencion;
END;

--Buscar consulta
CREATE PROCEDURE sp_BuscarConsulta
    @NroAtencion INT
AS
BEGIN
    SELECT * FROM Consulta
    WHERE NroAtencion = @NroAtencion;
END;

--Agregar Tratamiento
CREATE PROCEDURE sp_AgregarTratamiento
    @ID_Diagnostico INT,
    @Duracion INT,
    @Fecha_Inicio DATE,
    @Fecha_Fin DATE
AS
BEGIN
    INSERT INTO Tratamiento (ID_Diagnostico, Duracion, Fecha_Inicio, Fecha_Fin)
    VALUES (@ID_Diagnostico, @Duracion, @Fecha_Inicio, @Fecha_Fin);
END;

--Buscar Tratamiento
CREATE PROCEDURE sp_BuscarTratamientos
AS
BEGIN
    SELECT * FROM Tratamiento;
END;

--Actualizar Tratamiento
CREATE PROCEDURE sp_ModificarTratamiento
    @ID_Tratamiento INT,
    @Duracion INT,
    @Fecha_Inicio DATE,
    @Fecha_Fin DATE
AS
BEGIN
    UPDATE Tratamiento
    SET Duracion = @Duracion, Fecha_Inicio = @Fecha_Inicio, Fecha_Fin = @Fecha_Fin
    WHERE ID_Tratamiento = @ID_Tratamiento;
END;

--Eliminar Tratamiento
CREATE PROCEDURE sp_EliminarTratamiento
    @ID_Tratamiento INT
AS
BEGIN
    DELETE FROM Tratamiento WHERE ID_Tratamiento = @ID_Tratamiento;
END;

--Agregar Pedido
CREATE PROCEDURE sp_AgregarPedido
    @ID_Trabajador INT,
    @ID_Cliente INT,
    @ID_Producto INT,
    @FechaHora DATETIME,
    @Descripcion VARCHAR(255),
    @Cantidad INT,
    @PrecioPedido DECIMAL(10, 2),
    @Estado VARCHAR(50),
    @NroPago VARCHAR(50),
    @Monto DECIMAL(10, 2),
    @TipoComprobante VARCHAR(50),
    @MetodoPago VARCHAR(50)
AS
BEGIN
    INSERT INTO Pedido (ID_Trabajador, ID_Cliente, ID_Producto, FechaHora, Descripcion, Cantidad, PrecioPedido, Estado, NroPago, Monto, TipoComprobante, MetodoPago)
    VALUES (@ID_Trabajador, @ID_Cliente, @ID_Producto, @FechaHora, @Descripcion, @Cantidad, @PrecioPedido, @Estado, @NroPago, @Monto, @TipoComprobante, @MetodoPago);
END;

--Buscar Pedido
CREATE PROCEDURE sp_BuscarPedido
    @ID_Pedido INT = NULL,
    @ID_Trabajador INT = NULL,
    @ID_Cliente INT = NULL,
    @ID_Producto INT = NULL,
    @FechaHora DATETIME = NULL,
    @Descripcion VARCHAR(255) = NULL,
    @Estado VARCHAR(50) = NULL,
    @MetodoPago VARCHAR(50) = NULL
AS
BEGIN
  
    SELECT *
    FROM Pedido
    WHERE 
        (@ID_Pedido IS NULL OR ID_Pedido = @ID_Pedido) AND
        (@ID_Trabajador IS NULL OR ID_Trabajador = @ID_Trabajador) AND
        (@ID_Cliente IS NULL OR ID_Cliente = @ID_Cliente) AND
        (@ID_Producto IS NULL OR ID_Producto = @ID_Producto) AND
        (@FechaHora IS NULL OR FechaHora = @FechaHora) AND
        (@Descripcion IS NULL OR Descripcion LIKE '%' + @Descripcion + '%') AND
        (@Estado IS NULL OR Estado = @Estado) AND
        (@MetodoPago IS NULL OR MetodoPago = @MetodoPago);
END;
GO

--Modificar Pedido
CREATE PROCEDURE sp_ModificarPedido
    @ID_Pedido INT,
    @ID_Trabajador INT,
    @ID_Cliente INT,
    @ID_Producto INT,
    @FechaHora DATETIME,
    @Descripcion VARCHAR(255),
    @Cantidad INT,
    @PrecioPedido DECIMAL(10, 2),
    @Estado VARCHAR(50),
    @NroPago VARCHAR(50),
    @Monto DECIMAL(10, 2),
    @TipoComprobante VARCHAR(50),
    @MetodoPago VARCHAR(50)
AS
BEGIN
    UPDATE Pedido
    SET ID_Trabajador = @ID_Trabajador,
        ID_Cliente = @ID_Cliente,
        ID_Producto = @ID_Producto,
        FechaHora = @FechaHora,
        Descripcion = @Descripcion,
        Cantidad = @Cantidad,
        PrecioPedido = @PrecioPedido,
        Estado = @Estado,
        NroPago = @NroPago,
        Monto = @Monto,
        TipoComprobante = @TipoComprobante,
        MetodoPago = @MetodoPago
    WHERE ID_Pedido = @ID_Pedido;
END;

--Eliminar Pedido
CREATE PROCEDURE sp_EliminarPedido
    @ID_Pedido INT
AS
BEGIN
    DELETE FROM Pedido WHERE ID_Pedido = @ID_Pedido;
END;

--Agregar DiagnÛstico
CREATE PROCEDURE sp_AgregarDiagnostico
    @ID_Mascota INT,
    @Fecha_Diagnostico DATE,
    @Sintoma VARCHAR(255),
    @Observaciones VARCHAR(255)
AS
BEGIN
    INSERT INTO Diagnostico (ID_Mascota, Fecha_Diagnostico, Sintoma, Observaciones)
    VALUES (@ID_Mascota, @Fecha_Diagnostico, @Sintoma, @Observaciones);

    -- Retornar el ID del nuevo diagnÛstico
    SELECT SCOPE_IDENTITY() AS ID_DiagnosticoCreado;
END;
GO

--Buscar DiagnÛstico
CREATE PROCEDURE sp_BuscarDiagnostico
    @ID_Diagnostico INT
AS
BEGIN
    SELECT * 
    FROM Diagnostico
    WHERE ID_Diagnostico = @ID_Diagnostico;
END;
GO

--Eliminar DiagnÛstico
CREATE PROCEDURE sp_EliminarDiagnostico
    @ID_Diagnostico INT
AS
BEGIN
    DELETE FROM Diagnostico
    WHERE ID_Diagnostico = @ID_Diagnostico;
END;
GO

--Modificar DiagnÛstico
CREATE PROCEDURE sp_ModificarDiagnostico
    @ID_Diagnostico INT,
    @Fecha_Diagnostico DATE,
    @Sintoma VARCHAR(255),
    @Observaciones VARCHAR(255)
AS
BEGIN
    UPDATE Diagnostico
    SET 
        Fecha_Diagnostico = @Fecha_Diagnostico,
        Sintoma = @Sintoma,
        Observaciones = @Observaciones
    WHERE ID_Diagnostico = @ID_Diagnostico;
END;
GO


--Agregar Cliente
EXEC sp_AgregarCliente 
    @Nombres = 'Obrian', 
    @Apellidos = 'Velasquez', 
    @DNI = '65134854', 
    @Direccion = 'Calle 123', 
    @Telefono = '987546321';

--Modificar Cliente

EXEC sp_ModificarCliente 
    @ID_Cliente = 1, 
    @Nombres = 'Carlos', 
    @Apellidos = 'Garcia', 
    @DNI = '87654321', 
    @Direccion = 'Av. Siempre Viva 742', 
    @Telefono = '987654321';

--Eliminar Cliente
EXEC sp_EliminarCliente @ID_Cliente = 1;

--Buscar Cliente
EXEC sp_BuscarCliente @DNI = '12345678';

--Agregar Mascota
EXEC sp_AgregarMascota 
    @ID_Cliente = 1, 
    @Nombre = 'Fido', 
    @Especie = 'Perro', 
    @Raza = 'Labrador', 
    @Edad = 3, 
    @Peso = 25.50, 
    @Sexo = 'M', 
    @Fecha_Nacimiento = '2020-01-01';

--Modificar Mascota
EXEC sp_ModificarMascota 
    @ID_Mascota = 1, 
    @Nombre = 'Max', 
    @Especie = 'Perro', 
    @Raza = 'Golden Retriever', 
    @Edad = 4, 
    @Peso = 30.00, 
    @Sexo = 'M', 
    @Fecha_Nacimiento = '2019-01-01';

--Eliminar Mascota
EXEC sp_EliminarMascota @ID_Mascota = 11;

--Buscar Mascota
EXEC sp_BuscarMascota @ID_Mascota = 1;

--Agregar Trabajador
EXEC sp_AgregarTrabajador 
    @DNI = '87654321', 
    @Nombres = 'Juan', 
    @Apellidos = 'PÈrez', 
    @Telefono = '987654321', 
    @Direccion = 'Calle Principal 123', 
    @Cargo = 'Gerente', 
    @Sueldo = 2500.00, 
    @Fecha_Ingreso = '2024-10-04';

--Modificar Trabajador
EXEC sp_ModificarTrabajador 
    @ID_Trabajador = 1, 
    @DNI = '87654321', 
    @Nombres = 'Juan', 
    @Apellidos = 'PÈrez', 
    @Telefono = '987654321', 
    @Direccion = 'Calle Nueva 456', 
    @Cargo = 'Gerente', 
    @Sueldo = 3000.00, 
    @Fecha_Ingreso = '2023-09-10';

--Eliminar Trabajador
EXEC sp_EliminarTrabajador @ID_Trabajador = 2;

--Buscar Trabajador
EXEC sp_BuscarTrabajador @ID_Trabajador = 1;

--Agregar producto
EXEC sp_AgregarProducto 
    @Descripcion = 'Laptop', 
    @PrecioVenta = 15000.00, 
    @Categoria = 'ElectrÛnica';

--Modificar producto
EXEC sp_ModificarProducto 
    @ID_Producto = 3, 
    @Descripcion = 'Laptop Gaming', 
    @PrecioVenta = 18000.00, 
    @Categoria = 'ElectrÛnica';

--Eliminar producto
EXEC sp_EliminarProducto @ID_Producto = 5;

--Buscar producto
EXEC sp_BuscarProducto @ID_Producto = 4;

--Agregar consulta
EXEC sp_AgregarConsulta 
    @ID_Trabajador = 1,
    @ID_Mascota = 1,
    @ID_Diagnostico = 1,
    @Fecha_Hora = '20240115 10:00',
    @Estado = 'Completada';

--Modificar Consulta 
EXEC sp_ModificarConsulta 
    @NroAtencion = 1,
    @ID_Trabajador = 2,
    @ID_Mascota = 1,
    @ID_Diagnostico = 2,
    @Fecha_Hora = '20240116 14:00',
    @Estado = 'En progreso';

--Eliminar Consulta
EXEC sp_EliminarConsulta 
    @NroAtencion = 9;

--Buscar consulta
EXEC sp_BuscarConsulta 
    @NroAtencion = 6;

--Agregar Tratamiento
EXEC sp_AgregarTratamiento @ID_Diagnostico = 1, @Duracion = 14, @Fecha_Inicio = '2023-07-15', @Fecha_Fin = '2023-07-29';

--Buscar Tratamiento
EXEC sp_BuscarTratamientos;

--Actualizar Tratamiento
EXEC sp_ModificarTratamiento @ID_Tratamiento = 1, @Duracion = 10, @Fecha_Inicio = '2023-07-15', @Fecha_Fin = '2023-07-25';

--Eliminar Tratamiento
EXEC sp_EliminarTratamiento @ID_Tratamiento = 1;

--Agregar pedido
EXEC sp_AgregarPedido 1, 1, 1, '2023-04-01 14:30', 'Compra de alimento para perros', 2, 50.00, 'Pendiente', '12345', 50.00, 'Factura', 'Tarjeta de crÈdito';

--Buscar Pedido
EXEC sp_BuscarPedido @ID_Pedido = 1;
EXEC sp_BuscarPedido @ID_Trabajador = 2;
EXEC sp_BuscarPedido @ID_Cliente = 3;
EXEC sp_BuscarPedido @FechaHora = '2024-10-05 10:00:00';
EXEC sp_BuscarPedido @Estado = 'Completado';
EXEC sp_BuscarPedido @MetodoPago = 'Tarjeta';

--Modificar Pedido
EXEC sp_ModificarPedido 1, 2, 2, 2, '2023-04-02 15:00', 'Compra de juguete para perros', 3, 75.00, 'Completado', '54321', 75.00, 'Boleta', 'Efectivo';

--Eliminar Pedido
EXEC sp_EliminarPedido 1;

--Agregar DiagnÛstico
EXEC sp_AgregarDiagnostico 1, '2024-10-05', 'Dolor abdominal', 'Se observa ligera mejora';

--Buscar DiagnÛstico
EXEC sp_BuscarDiagnostico 1;

--Eliminar DiagnÛstico
EXEC sp_EliminarDiagnostico 3;

--Modificar DiagnÛstico
EXEC sp_ModificarDiagnostico 2, '2024-10-06', 'Tos severa', 'Aumento en s˙ãtomas de tos';