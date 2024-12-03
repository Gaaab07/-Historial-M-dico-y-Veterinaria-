create database VeterinariaDW;
go

use VeterinariaDW;
go


-- Tabla de Hechos: Hecho_Consultas

-- Dimensión: Dim_Cliente
CREATE TABLE Dim_Cliente (
    ID_Cliente INT PRIMARY KEY,
    Nombres VARCHAR(50),
    Apellidos VARCHAR(50),
    DNI CHAR(8),
    Direccion VARCHAR(100),
    Telefono CHAR(9)
);

-- Dimensión: Dim_Trabajador
CREATE TABLE Dim_Trabajador (
    ID_Trabajador INT PRIMARY KEY,
    DNI CHAR(8),
    Nombres VARCHAR(50),
    Apellidos VARCHAR(50),
    Cargo VARCHAR(50),
    Sueldo DECIMAL(10, 2),
    Fecha_Ingreso DATE
);

-- Dimensión: Dim_Mascota
CREATE TABLE Dim_Mascota (
    ID_Mascota INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Especie VARCHAR(50),
    Raza VARCHAR(50),
    Edad INT,
    Peso DECIMAL(5, 2),
    Sexo CHAR(1),
    Fecha_Nacimiento DATE
);

-- Dimensión: Dim_Tiempo

CREATE TABLE Dim_Tiempo (

	fechaID int primary key,
	año int,
	trimestre int,
	mes int,
	nomMes varchar (15),
	dia int,
	diaSem int,
	nomDiaSem varchar (15)
);

select * from Dim_Tiempo

create TABLE Hecho_Consultas (
    --ID_Hecho INT PRIMARY KEY IDENTITY(1,1),
    ID_Cliente INT PRIMARY KEY,
    ID_Trabajador INT NOT NULL,
    ID_Mascota INT NOT NULL,
    fechaID INT NOT NULL,
    ID_Diagnostico INT,
    ID_Tratamiento INT
    --Estado VARCHAR(50)
    --Costo DECIMAL(10, 2),
    FOREIGN KEY (ID_Cliente) REFERENCES Dim_Cliente(ID_Cliente),
    FOREIGN KEY (ID_Trabajador) REFERENCES Dim_Trabajador(ID_Trabajador),
    FOREIGN KEY (ID_Mascota) REFERENCES Dim_Mascota(ID_Mascota),
    FOREIGN KEY (fechaID) REFERENCES Dim_Tiempo(fechaID)
);

INSERT INTO VeterinariaDW.dbo.Dim_Cliente (ID_Cliente, Nombres, Apellidos, DNI, Direccion, Telefono)
SELECT ID_Cliente, Nombres, Apellidos, DNI, Direccion, Telefono
FROM VeterinariaDB.dbo.Cliente;

select * from Dim_Cliente

INSERT INTO VeterinariaDW.dbo.Dim_Trabajador (ID_Trabajador, DNI, Nombres, Apellidos, Cargo, Sueldo, Fecha_Ingreso)
SELECT ID_Trabajador, DNI, Nombres, Apellidos, Cargo, Sueldo, Fecha_Ingreso
FROM VeterinariaDB.dbo.Trabajador;

select * from Dim_Trabajador

INSERT INTO VeterinariaDW.dbo.Dim_Mascota (ID_Mascota, Nombre, Especie, Raza, Edad, Peso, Sexo, Fecha_Nacimiento)
SELECT ID_Mascota, Nombre, Especie, Raza, Edad, Peso, Sexo, Fecha_Nacimiento
FROM VeterinariaDB.dbo.Mascota;

select * from Dim_Mascota

select * from Hecho_Consultas


------------------------------------------
--creando función fn_Mes

create function fn_Mes(@mm int) returns varchar(15)
begin
	declare @meses table(cod int, nombre varchar(15))
	insert @meses values(1,'enero'),(2,'febrero'),(3,'marzo'),(4,'abril'),(5,'mayo'),(6,'junio'),
	(7,'julio'),(8,'agosto'),(9,'setiembre'),(10,'octubre'),(11,'noviembre'),(12,'diciembre')
	return (select nombre from @meses where cod=@mm)
end
go


--creando función fn_dia

create function fn_dia (@dd int) returns varchar(15)
begin
	declare @semana table(cod int, nombre varchar(15))
	insert @semana values(1,'domingo'),(2,'lunes'),(3,'martes'),(4,'miercoles'),(5,'jueves'),
	(6,'viernes'),(7,'sabado')
	return (select nombre from @semana where cod=@dd)
end
go

-- INSERTAR DATOS DIMENSION FECHA

insert VeterinariaDW.dbo.Dim_Tiempo
select distinct year(FECHA_HORA)*10000+month(FECHA_HORA)*100+day(FECHA_HORA), 
year(FECHA_HORA) as año, datepart (quarter,FECHA_HORA) as trimestre,
month (FECHA_HORA) as mes, dbo.fn_Mes(month(FECHA_HORA)) as nomMes,
day(FECHA_HORA) as dia, DATEPART(WEEKDAY, FECHA_HORA) as diaSem,
dbo.fn_dia(DATEPART(weekday, FECHA_HORA)) as nomDia
from VeterinariaDB.dbo.Consulta
go

select*from Dim_Tiempo

select * from Hecho_Consultas
INSERT INTO VeterinariaDW.dbo.Hecho_Consultas 
(ID_Cliente, ID_Trabajador, ID_Mascota, fechaID, ID_Diagnostico, ID_Tratamiento)
SELECT DISTINCT
    mas.ID_Cliente,                        -- ID del cliente relacionado desde Mascota
    c.ID_Trabajador,                       -- ID del trabajador relacionado
    c.ID_Mascota,                          -- ID de la mascota relacionada
    YEAR(c.FECHA_HORA) * 10000 
    + MONTH(c.FECHA_HORA) * 100 
    + DAY(c.FECHA_HORA) AS fechaID,        -- Clave de la dimensión tiempo
    c.ID_Diagnostico,                      -- ID del diagnóstico
    trat.ID_Tratamiento                  -- ID del tratamiento relacionado desde Diagnostico
    --c.Estado,                              -- Estado de la consulta
    --0.0                                    -- Valor predeterminado para Costo
FROM 
    VeterinariaDB.dbo.Consulta c
LEFT JOIN 
    VeterinariaDB.dbo.Mascota mas ON c.ID_Mascota = mas.ID_Mascota
LEFT JOIN 
    VeterinariaDB.dbo.Diagnostico diag ON c.ID_Diagnostico = diag.ID_Diagnostico
LEFT JOIN 
    VeterinariaDB.dbo.Tratamiento trat ON c.ID_Diagnostico = trat.ID_Tratamiento
LEFT JOIN 
    VeterinariaDW.dbo.Dim_Trabajador tra ON c.ID_Trabajador = tra.ID_Trabajador

select*from dbo.Dim_Cliente
select*from dbo.Dim_Mascota
select*from dbo.Dim_Tiempo
select*from dbo.Dim_Trabajador
select*from dbo.Hecho_Consultas

