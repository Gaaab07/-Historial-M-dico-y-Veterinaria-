--CREANDO LA BASE DE DATOS "HISTORIALMED"
CREATE DATABASE BD_HM
GO
--ACTIVANDO LA BASE DE DATOS
USE BD_HM
GO

--CREANDO LA TABLA "PACIENTE"
CREATE TABLE PACIENTE
(
	IDPACIENTE CHAR(8) NOT NULL PRIMARY KEY,
	NOMBREP VARCHAR(100) NOT NULL,
	APELLIDOP VARCHAR(100),
	FECHANACIMP DATE DEFAULT GETDATE(),
	GENEROP CHAR(1) NOT NULL,
	DIRECCIONP VARCHAR(100),
	NUMTELEFONICOP VARCHAR(15) NOT NULL UNIQUE,
	EDAD CHAR(3),
	ESTADO BIT DEFAULT 1
)
GO

--CREANDO LA TABLA "MEDICO"
CREATE TABLE MEDICO
(
	IDMEDICO CHAR(8) NOT NULL PRIMARY KEY,
	NOMBREM VARCHAR(100) NOT NULL,
	APELLIDOM VARCHAR(100),
	TELEFONOM VARCHAR(15) NOT NULL UNIQUE,
	EMAILM VARCHAR(40) NOT NULL UNIQUE,
	DIRECCIONM VARCHAR(100),
	ESPECIALIDADM VARCHAR(100) NOT NULL,
	EXPERIENCIAM VARCHAR(100) NOT NULL,
	ESTADO BIT DEFAULT 1
)
GO

--CREANDO LA TABLA "CONSULTA"
CREATE TABLE CONSULTA
(
	IDCONSULTA CHAR(8) NOT NULL PRIMARY KEY,
	IDPACIENTE CHAR(8) NOT NULL,
	IDMEDICO CHAR(8) NOT NULL,
	TIPO_CONSULTA VARCHAR(100) NOT NULL,
	FECHA_HORA_CONSULTA DATETIME DEFAULT GETDATE(),
	OBSERVACIONES VARCHAR(300),
	ESTADO BIT DEFAULT 1,
	CONSTRAINT FK_CONSULTA_IDPACIENTE FOREIGN KEY(IDPACIENTE) REFERENCES PACIENTE(IDPACIENTE),
	CONSTRAINT FK_CONSULTA_IDMEDICO FOREIGN KEY(IDMEDICO) REFERENCES MEDICO(IDMEDICO)
)
GO

SELECT * FROM CONSULTA


--CREANDO LA TABLA "ENFERMERO"
CREATE TABLE ENFERMERO
(
	IDENFERMERO CHAR(8) NOT NULL PRIMARY KEY,
	NOMBREENF VARCHAR(100) NOT NULL,
	ESPECIALIDADENF VARCHAR(100) NOT NULL,
	EXPERIENCIAENF VARCHAR(100) NOT NULL,
	TELEFONOENF VARCHAR(15) NOT NULL UNIQUE,
	EMAILM VARCHAR(40) NOT NULL UNIQUE,
	ESTADO BIT DEFAULT 1
)
GO

--CREANDO LA TABLA "TRIAJE"
CREATE TABLE TRIAJE
(
	FECHAHORATRIAJE DATETIME DEFAULT GETDATE() NOT NULL,
	IDCONSULTA CHAR(8) NOT NULL,
	IDENFERMERO CHAR(8) NOT NULL,
	SINTOMASP VARCHAR(100) NOT NULL,
	PRESIONP DECIMAL(3,0) CHECK(PRESIONP BETWEEN 50 AND 250),
	TEMP DECIMAL(3,1) CHECK(TEMP BETWEEN 35.0 AND 42.0),
	PESOP DECIMAL(5,2) CHECK(PESOP BETWEEN 1.00 AND 300.00),
	ESTADO BIT DEFAULT 1,
	PRIMARY KEY(FECHAHORATRIAJE),
	CONSTRAINT FK_TRIAJE_IDCONSULTA FOREIGN KEY(IDCONSULTA) REFERENCES CONSULTA(IDCONSULTA),
	CONSTRAINT FK_TRIAJE_IDENFERMERO FOREIGN KEY(IDENFERMERO) REFERENCES ENFERMERO(IDENFERMERO)
)
GO



--CREANDO LA TABLA "DTTRIAJE"
CREATE TABLE DTTRIAJE
(
	FECHAHORATRIAJE DATETIME DEFAULT GETDATE() NOT NULL,
	OBSERVACIONES VARCHAR(300),
	ESTADO BIT DEFAULT 1,
	CONSTRAINT FK_DTTRIAJE_FECHAHORATRIAJE FOREIGN KEY(FECHAHORATRIAJE) REFERENCES TRIAJE(FECHAHORATRIAJE)
)
GO

--CREANDO LA TABLA "MEDICAMENTO"
CREATE TABLE MEDICAMENTO
(
	NOMBREMED CHAR(100) NOT NULL PRIMARY KEY,
	ALERGIAMED CHAR(100),
	DESCRIPCIONMED CHAR(300),
	ESTADO BIT DEFAULT 1
)
GO

--CREANDO LA TABLA "TRATAMIENTO"
CREATE TABLE TRATAMIENTO
(
	IDTRATAMIENTO CHAR(8) NOT NULL PRIMARY KEY,
	NOMBREMED CHAR(100) NOT NULL,
	NOMBRETR CHAR(100) NOT NULL,
	FECHAINI DATE DEFAULT GETDATE() NOT NULL,
	FECHAFIN DATE DEFAULT GETDATE() NOT NULL,
	DESCTRA CHAR(300),
	SUJETOTRA CHAR(100) NOT NULL,
	ESTADO BIT DEFAULT 1,
	CONSTRAINT FK_TRATAMIENTO_NOMBREMED FOREIGN KEY(NOMBREMED) REFERENCES MEDICAMENTO(NOMBREMED)
)
GO


--CREANDO LA TABLA "ENFERMEDAD"
CREATE TABLE ENFERMEDAD
(
	NOMBREENF CHAR(100) NOT NULL PRIMARY KEY,
	CAUSASENF CHAR(300) NOT NULL,
	COMPLICACIONESENF CHAR(300) NOT NULL,
	SINTOMASENF CHAR(300) NOT NULL,
	GRAVEDADENF CHAR(100) NOT NULL,
	ESTADO BIT DEFAULT 1
)
GO

--CREANDO LA TABLA "DIAGNOSTICO"
CREATE TABLE DIAGNOSTICO
(
	IDDIAGNOSTICO CHAR(8) NOT NULL PRIMARY KEY,
	IDCONSULTA CHAR(8) NOT NULL,
	NOMBREENF CHAR(100) NOT NULL,
	IDTRATAMIENTO CHAR(8) NOT NULL,
	ESTADO BIT DEFAULT 1,
	CONSTRAINT FK_DIAGNOSTICO_IDCONSULTA FOREIGN KEY(IDCONSULTA) REFERENCES CONSULTA(IDCONSULTA),
	CONSTRAINT FK_ENFERMEDAD_NOMBREENF FOREIGN KEY(NOMBREENF) REFERENCES ENFERMEDAD(NOMBREENF),
	CONSTRAINT FK_TRATAMIENTO_IDTRATAMIENTO FOREIGN KEY(IDTRATAMIENTO) REFERENCES TRATAMIENTO(IDTRATAMIENTO)
)
GO

--CREANDO LA TABLA "DTDIAGNOSTICO"
CREATE TABLE DTDIAGNOSTICO
(
	IDDIAGNOSTICO CHAR(8) NOT NULL,
	DESCRIPCION CHAR(300) NOT NULL,
	EXAMENESAD CHAR(300),
	FECHAHORADIAGNOSTICO DATETIME DEFAULT GETDATE() NOT NULL,
	INFECCION CHAR(100),
	RESFRIO CHAR(100),
	ESTADO BIT DEFAULT 1,
	PRIMARY KEY(IDDIAGNOSTICO),
	CONSTRAINT FK_DTDIAGNOSTICO_IDDIAGNOSTICO FOREIGN KEY(IDDIAGNOSTICO) REFERENCES DIAGNOSTICO(IDDIAGNOSTICO)
)
GO

--CREANDO LA TABLA "EXAMENES"
CREATE TABLE EXAMENES
(
	TIPOEXAMENES CHAR(100) NOT NULL PRIMARY KEY,
	FECHAHORA DATETIME DEFAULT GETDATE() NOT NULL,
	NOMBREP CHAR(100) NOT NULL,
	NOMBREM CHAR(100) NOT NULL,
	NOMBRELAB CHAR(100) NOT NULL,
	ESTADO BIT DEFAULT 1
)
GO

--CREANDO LA TABLA "ORDENA"
CREATE TABLE ORDENA
(
	IDCONSULTA CHAR(8) NOT NULL,
	TIPOEXAMENES CHAR(100) NOT NULL,
	CONSTRAINT FK_ORDENA_IDCONSULTA FOREIGN KEY(IDCONSULTA) REFERENCES CONSULTA(IDCONSULTA),
	CONSTRAINT FK_ORDENA_TIPOEXAMENES FOREIGN KEY(TIPOEXAMENES) REFERENCES EXAMENES(TIPOEXAMENES)
)
GO











------------------------PACIENTE---------------------
CREATE PROCEDURE CrearPaciente
    @IDPACIENTE CHAR(8),
    @NOMBREP VARCHAR(100),
    @APELLIDOP VARCHAR(100),
    @FECHANACIMP DATE,
    @GENEROP CHAR(1),
    @DIRECCIONP VARCHAR(100),
    @NUMTELEFONICOP VARCHAR(15),
    @EDAD CHAR(3),
    @ESTADO BIT
AS
BEGIN
    INSERT INTO PACIENTE (IDPACIENTE, NOMBREP, APELLIDOP, FECHANACIMP, GENEROP, DIRECCIONP, NUMTELEFONICOP, EDAD, ESTADO)
    VALUES (@IDPACIENTE, @NOMBREP, @APELLIDOP, @FECHANACIMP, @GENEROP, @DIRECCIONP, @NUMTELEFONICOP, @EDAD, @ESTADO);
END
GO
-------------------------------------------------------------------------

CREATE PROCEDURE EditarPaciente
    @IDPACIENTE CHAR(8),
    @NOMBREP VARCHAR(100),
    @APELLIDOP VARCHAR(100),
    @FECHANACIMP DATE,
    @GENEROP CHAR(1),
    @DIRECCIONP VARCHAR(100),
    @NUMTELEFONICOP VARCHAR(15),
    @EDAD CHAR(3),
    @ESTADO BIT
AS
BEGIN
    UPDATE PACIENTE
    SET NOMBREP = @NOMBREP, APELLIDOP = @APELLIDOP, FECHANACIMP = @FECHANACIMP, GENEROP = @GENEROP,
        DIRECCIONP = @DIRECCIONP, NUMTELEFONICOP = @NUMTELEFONICOP, EDAD = @EDAD, ESTADO = @ESTADO
    WHERE IDPACIENTE = @IDPACIENTE;
END
GO

-------------------------------------------------------------------------
CREATE PROCEDURE BuscarPaciente
    @IDPACIENTE CHAR(8)
AS
BEGIN
    SELECT * FROM PACIENTE WHERE IDPACIENTE = @IDPACIENTE;
END
GO
-------------------------------------------------------------------------

CREATE PROCEDURE EliminarPaciente
    @IDPACIENTE CHAR(8)
AS
BEGIN
    DELETE FROM PACIENTE WHERE IDPACIENTE = @IDPACIENTE;
END
GO


-------------------------------------------------------------------------
/*
EXEC CrearPaciente 'P0000052', 'Pedro', 'Pérez', '1985-05-12', 'M', 'Av. Siempre Viva', '999999999', '35', 1;

EXEC BuscarPaciente 'P0000052';

EXEC EditarPaciente 'P0000001', 'Juan', 'González', '1985-05-12', 'M', 'Av. Nueva', '999999999', '35', 1;

EXEC EliminarPaciente 'P0000001';
*/
-------------------------------------------------------------------------





------------------------MEDICO---------------------

CREATE PROCEDURE CrearMedico
    @IDMEDICO CHAR(8),
    @NOMBREM VARCHAR(100),
    @APELLIDOM VARCHAR(100),
    @TELEFONOM VARCHAR(15),
    @EMAILM VARCHAR(40),
    @DIRECCIONM VARCHAR(100),
    @ESPECIALIDADM VARCHAR(100),
    @EXPERIENCIAM VARCHAR(100),
    @ESTADO BIT
AS
BEGIN
    INSERT INTO MEDICO (IDMEDICO, NOMBREM, APELLIDOM, TELEFONOM, EMAILM, DIRECCIONM, ESPECIALIDADM, EXPERIENCIAM, ESTADO)
    VALUES (@IDMEDICO, @NOMBREM, @APELLIDOM, @TELEFONOM, @EMAILM, @DIRECCIONM, @ESPECIALIDADM, @EXPERIENCIAM, @ESTADO);
END
GO

CREATE PROCEDURE EditarMedico
    @IDMEDICO CHAR(8),
    @NOMBREM VARCHAR(100),
    @APELLIDOM VARCHAR(100),
    @TELEFONOM VARCHAR(15),
    @EMAILM VARCHAR(40),
    @DIRECCIONM VARCHAR(100),
    @ESPECIALIDADM VARCHAR(100),
    @EXPERIENCIAM VARCHAR(100),
    @ESTADO BIT
AS
BEGIN
    UPDATE MEDICO
    SET NOMBREM = @NOMBREM, APELLIDOM = @APELLIDOM, TELEFONOM = @TELEFONOM, EMAILM = @EMAILM,
        DIRECCIONM = @DIRECCIONM, ESPECIALIDADM = @ESPECIALIDADM, EXPERIENCIAM = @EXPERIENCIAM, ESTADO = @ESTADO
    WHERE IDMEDICO = @IDMEDICO;
END
GO

CREATE PROCEDURE BuscarMedico
    @IDMEDICO CHAR(8)
AS
BEGIN
    SELECT * FROM MEDICO WHERE IDMEDICO = @IDMEDICO;
END
GO

CREATE PROCEDURE EliminarMedico
    @IDMEDICO CHAR(8)
AS
BEGIN
    DELETE FROM MEDICO WHERE IDMEDICO = @IDMEDICO;
END
GO

-------------------------------------------------------------------------

-- Ejemplos de ejecución de los procedimientos
/*
EXEC CrearMedico 'M0000051', 'Carlos', 'Martínez', '999888777', 'c.martinez@example.com', 'Calle Falsa 123', 'Cardiología', '5 años', 1;

EXEC BuscarMedico 'M0000051';


EXEC EditarMedico 'M0000001', 'Carlosss', 'Martínez', '991188888', 'c.martinezz@examplee.com', 'Calle nueva 456', 'Cardiología', '6 años', 1;

EXEC EliminarMedico 'M0000001';

*/





------------------------CONSULTA---------------------

CREATE PROCEDURE CrearConsulta
    @IDCONSULTA CHAR(8),
    @IDPACIENTE CHAR(8),
    @IDMEDICO CHAR(8),
    @TIPO_CONSULTA VARCHAR(100),
    @FECHA_HORA_CONSULTA DATETIME = NULL,
    @OBSERVACIONES VARCHAR(300),
    @ESTADO BIT = 1
AS
BEGIN
    INSERT INTO CONSULTA (IDCONSULTA, IDPACIENTE, IDMEDICO, TIPO_CONSULTA, FECHA_HORA_CONSULTA, OBSERVACIONES, ESTADO)
    VALUES (@IDCONSULTA, @IDPACIENTE, @IDMEDICO, @TIPO_CONSULTA, 
            ISNULL(@FECHA_HORA_CONSULTA, GETDATE()), @OBSERVACIONES, @ESTADO);
END
GO



CREATE PROCEDURE EditarConsulta
    @IDCONSULTA CHAR(8),
    @IDPACIENTE CHAR(8),
    @IDMEDICO CHAR(8),
    @TIPO_CONSULTA VARCHAR(100),
    @FECHA_HORA_CONSULTA DATETIME,
    @OBSERVACIONES VARCHAR(300),
    @ESTADO BIT
AS
BEGIN
    UPDATE CONSULTA
    SET IDPACIENTE = @IDPACIENTE, IDMEDICO = @IDMEDICO, TIPO_CONSULTA = @TIPO_CONSULTA,
        FECHA_HORA_CONSULTA = @FECHA_HORA_CONSULTA, OBSERVACIONES = @OBSERVACIONES, ESTADO = @ESTADO
    WHERE IDCONSULTA = @IDCONSULTA;
END
GO

CREATE PROCEDURE BuscarConsulta
    @IDCONSULTA CHAR(8)
AS
BEGIN
    SELECT * FROM CONSULTA WHERE IDCONSULTA = @IDCONSULTA;
END
GO

CREATE PROCEDURE EliminarConsulta
    @IDCONSULTA CHAR(8)
AS
BEGIN
    DELETE FROM CONSULTA WHERE IDCONSULTA = @IDCONSULTA;
END
GO

-------------------------------------------------------------------------

-- Ejemplos de ejecución de los procedimientos
/*
EXEC CrearConsulta 'C0000055', 'P0000001', 'M0000001', 'Consulta General', '2024-10-10 10:00:00', 'Sin observaciones', 1;

EXEC BuscarConsulta 'C0000055';

EXEC EditarConsulta 'C0000001', 'P0000001', 'M0000005', 'Consulta de seguimiento', '2024-10-10 10:00:00', 'Control de salud', 1;

EXEC EliminarConsulta 'C0000051';
*/




------------------------DIAGNOSTICO---------------------

CREATE PROCEDURE CrearDiagnostico
    @IDDIAGNOSTICO CHAR(8),
    @IDCONSULTA CHAR(8),
    @NOMBREENF CHAR(100),
    @IDTRATAMIENTO CHAR(8),
    @ESTADO BIT = 1
AS
BEGIN
    INSERT INTO DIAGNOSTICO (IDDIAGNOSTICO, IDCONSULTA, NOMBREENF, IDTRATAMIENTO, ESTADO)
    VALUES (@IDDIAGNOSTICO, @IDCONSULTA, @NOMBREENF, @IDTRATAMIENTO, @ESTADO);
END
GO

CREATE PROCEDURE EditarDiagnostico
    @IDDIAGNOSTICO CHAR(8),
    @IDCONSULTA CHAR(8),
    @NOMBREENF CHAR(100),
    @IDTRATAMIENTO CHAR(8),
    @ESTADO BIT
AS
BEGIN
    UPDATE DIAGNOSTICO
    SET IDCONSULTA = @IDCONSULTA, NOMBREENF = @NOMBREENF, IDTRATAMIENTO = @IDTRATAMIENTO, ESTADO = @ESTADO
    WHERE IDDIAGNOSTICO = @IDDIAGNOSTICO;
END
GO

CREATE PROCEDURE BuscarDiagnostico
    @IDDIAGNOSTICO CHAR(8)
AS
BEGIN
    SELECT * FROM DIAGNOSTICO WHERE IDDIAGNOSTICO = @IDDIAGNOSTICO;
END
GO

CREATE PROCEDURE EliminarDiagnostico
    @IDDIAGNOSTICO CHAR(8)
AS
BEGIN
    DELETE FROM DIAGNOSTICO WHERE IDDIAGNOSTICO = @IDDIAGNOSTICO;
END
GO

-------------------------------------------------------------------------

-- Ejemplos de ejecución de los procedimientos
/*
EXEC CrearDiagnostico 'D0000055', 'C0000001', 'Gripe', 'T0000001', 1;

EXEC BuscarDiagnostico 'D0000055';

EXEC EditarDiagnostico 'D0000051', 'C0000015', 'Gripe', 'T0000006', 0;

EXEC EliminarDiagnostico 'D0000051';
*/


------------------------DTDIAGNOSTICO---------------------

CREATE PROCEDURE CrearDtDiagnostico
    @IDDIAGNOSTICO CHAR(8),
    @DESCRIPCION CHAR(300),
    @EXAMENESAD CHAR(300) = NULL,
    @FECHAHORADIAGNOSTICO DATETIME = NULL,
    @INFECCION CHAR(100) = NULL,
    @RESFRIO CHAR(100) = NULL,
    @ESTADO BIT = 1
AS
BEGIN
    INSERT INTO DTDIAGNOSTICO (IDDIAGNOSTICO, DESCRIPCION, EXAMENESAD, FECHAHORADIAGNOSTICO, INFECCION, RESFRIO, ESTADO)
    VALUES (@IDDIAGNOSTICO, @DESCRIPCION, @EXAMENESAD, ISNULL(@FECHAHORADIAGNOSTICO, GETDATE()), @INFECCION, @RESFRIO, @ESTADO);
END
GO

CREATE PROCEDURE EditarDtDiagnostico
    @IDDIAGNOSTICO CHAR(8),
    @DESCRIPCION CHAR(300),
    @EXAMENESAD CHAR(300) = NULL,
    @FECHAHORADIAGNOSTICO DATETIME,
    @INFECCION CHAR(100) = NULL,
    @RESFRIO CHAR(100) = NULL,
    @ESTADO BIT
AS
BEGIN
    UPDATE DTDIAGNOSTICO
    SET DESCRIPCION = @DESCRIPCION,
        EXAMENESAD = @EXAMENESAD,
        FECHAHORADIAGNOSTICO = @FECHAHORADIAGNOSTICO,
        INFECCION = @INFECCION,
        RESFRIO = @RESFRIO,
        ESTADO = @ESTADO
    WHERE IDDIAGNOSTICO = @IDDIAGNOSTICO;
END
GO

CREATE PROCEDURE BuscarDtDiagnostico
    @IDDIAGNOSTICO CHAR(8)
AS
BEGIN
    SELECT * FROM DTDIAGNOSTICO WHERE IDDIAGNOSTICO = @IDDIAGNOSTICO;
END
GO

CREATE PROCEDURE EliminarDtDiagnostico
    @IDDIAGNOSTICO CHAR(8)
AS
BEGIN
    DELETE FROM DTDIAGNOSTICO WHERE IDDIAGNOSTICO = @IDDIAGNOSTICO;
END
GO

-------------------------------------------------------------------------

-- Ejemplos de ejecución de los procedimientos
/*
--PARA CREAR UN DTDIAGNOSTICO DEBE EXISTIR UN IDDIAGNOSTICO
EXEC CrearDtDiagnostico 'D0000055', 'Diagnóstico inicial', 'Exámenes de sangre', '2024-10-10 10:00:00', 'Infección respiratoria', 'Resfriado leve', 1;
EXEC BuscarDtDiagnostico 'D0000055';
EXEC EditarDtDiagnostico 'D0000055', 'Diagnóstico actualizado', 'Exámenes de orina', '2024-10-10 10:00:00', 'Infección severa', 'Resfriado fuerte', 0;
EXEC EliminarDtDiagnostico 'D0000055';
*/




------------------------DTTRIAJE---------------------

CREATE PROCEDURE CrearDtTriage
    @FECHAHORATRIAJE DATETIME,
    @OBSERVACIONES VARCHAR(300),
    @ESTADO BIT = 1
AS
BEGIN
    INSERT INTO DTTRIAJE (FECHAHORATRIAJE, OBSERVACIONES, ESTADO)
    VALUES (@FECHAHORATRIAJE, @OBSERVACIONES, @ESTADO);
END
GO

CREATE PROCEDURE EditarDtTriage
    @FECHAHORATRIAJE DATETIME,
    @OBSERVACIONES VARCHAR(300),
    @ESTADO BIT
AS
BEGIN
    UPDATE DTTRIAJE
    SET OBSERVACIONES = @OBSERVACIONES,
        ESTADO = @ESTADO
    WHERE FECHAHORATRIAJE = @FECHAHORATRIAJE;
END
GO

CREATE PROCEDURE BuscarDtTriage
    @FECHAHORATRIAJE DATETIME
AS
BEGIN
    SELECT * FROM DTTRIAJE WHERE FECHAHORATRIAJE = @FECHAHORATRIAJE;
END
GO

CREATE PROCEDURE EliminarDtTriage
    @FECHAHORATRIAJE DATETIME
AS
BEGIN
    DELETE FROM DTTRIAJE WHERE FECHAHORATRIAJE = @FECHAHORATRIAJE;
END
GO

-------------------------------------------------------------------------

-- Ejemplos de ejecución de los procedimientos
/*
EXEC CrearDtTriage '2024-10-02 08:00:00', 'Paciente presenta dolor en el pecho, requiere evaluación.', 1;
EXEC BuscarDtTriage '2024-10-02 08:00:00';
EXEC EditarDtTriage '2024-10-02 08:00:00', 'Paciente con dolor en el pecho, se le realizará un electrocardiograma.', 0;
EXEC EliminarDtTriage '2024-10-02 08:00:00';
*/



------------------------ENFERMEDAD---------------------

CREATE PROCEDURE CrearEnfermedad
    @NOMBREENF CHAR(100),
    @CAUSASENF CHAR(300),
    @COMPLICACIONESENF CHAR(300),
    @SINTOMASENF CHAR(300),
    @GRAVEDADENF CHAR(100),
    @ESTADO BIT = 1
AS
BEGIN
    INSERT INTO ENFERMEDAD (NOMBREENF, CAUSASENF, COMPLICACIONESENF, SINTOMASENF, GRAVEDADENF, ESTADO)
    VALUES (@NOMBREENF, @CAUSASENF, @COMPLICACIONESENF, @SINTOMASENF, @GRAVEDADENF, @ESTADO);
END
GO

CREATE PROCEDURE EditarEnfermedad
    @NOMBREENF CHAR(100),
    @CAUSASENF CHAR(300),
    @COMPLICACIONESENF CHAR(300),
    @SINTOMASENF CHAR(300),
    @GRAVEDADENF CHAR(100),
    @ESTADO BIT
AS
BEGIN
    UPDATE ENFERMEDAD
    SET CAUSASENF = @CAUSASENF,
        COMPLICACIONESENF = @COMPLICACIONESENF,
        SINTOMASENF = @SINTOMASENF,
        GRAVEDADENF = @GRAVEDADENF,
        ESTADO = @ESTADO
    WHERE NOMBREENF = @NOMBREENF;
END
GO

CREATE PROCEDURE BuscarEnfermedad
    @NOMBREENF CHAR(100)
AS
BEGIN
    SELECT * FROM ENFERMEDAD WHERE NOMBREENF = @NOMBREENF;
END
GO

CREATE PROCEDURE EliminarEnfermedad
    @NOMBREENF CHAR(100)
AS
BEGIN
    DELETE FROM ENFERMEDAD WHERE NOMBREENF = @NOMBREENF;
END
GO

-------------------------------------------------------------------------

-- Ejemplos de ejecución de los procedimientos
/*
EXEC CrearEnfermedad  'DiabetesA', 'Genética, obesidad, sedentarismo', 'Complicaciones cardiovasculares, neuropatía', 'Sed, aumento de orina, fatiga', 'Moderada', 1;
EXEC BuscarEnfermedad 'DiabetesA ';
EXEC EditarEnfermedad 'Diabetes Avanzada', 'Genética, falta de ejercicio', 'Complicaciones cardiovasculares, daño renal', 'Sed, aumento de orina, fatiga, visión borrosa', 'Severa', 1;
EXEC EliminarEnfermedad 'DiabetesA';
*/




------------------------ENFERMERO---------------------

CREATE PROCEDURE CrearEnfermero
    @IDENFERMERO CHAR(8),
    @NOMBREENF VARCHAR(100),
    @ESPECIALIDADENF VARCHAR(100),
    @EXPERIENCIAENF VARCHAR(100),
    @TELEFONOENF VARCHAR(15),
    @EMAILM VARCHAR(40),
    @ESTADO BIT = 1
AS
BEGIN
    INSERT INTO ENFERMERO (IDENFERMERO, NOMBREENF, ESPECIALIDADENF, EXPERIENCIAENF, TELEFONOENF, EMAILM, ESTADO)
    VALUES (@IDENFERMERO, @NOMBREENF, @ESPECIALIDADENF, @EXPERIENCIAENF, @TELEFONOENF, @EMAILM, @ESTADO);
END
GO

CREATE PROCEDURE EditarEnfermero
    @IDENFERMERO CHAR(8),
    @NOMBREENF VARCHAR(100),
    @ESPECIALIDADENF VARCHAR(100),
    @EXPERIENCIAENF VARCHAR(100),
    @TELEFONOENF VARCHAR(15),
    @EMAILM VARCHAR(40),
    @ESTADO BIT
AS
BEGIN
    UPDATE ENFERMERO
    SET NOMBREENF = @NOMBREENF,
        ESPECIALIDADENF = @ESPECIALIDADENF,
        EXPERIENCIAENF = @EXPERIENCIAENF,
        TELEFONOENF = @TELEFONOENF,
        EMAILM = @EMAILM,
        ESTADO = @ESTADO
    WHERE IDENFERMERO = @IDENFERMERO;
END
GO

CREATE PROCEDURE BuscarEnfermero
    @IDENFERMERO CHAR(8)
AS
BEGIN
    SELECT * FROM ENFERMERO WHERE IDENFERMERO = @IDENFERMERO;
END
GO

CREATE PROCEDURE EliminarEnfermero
    @IDENFERMERO CHAR(8)
AS
BEGIN
    DELETE FROM ENFERMERO WHERE IDENFERMERO = @IDENFERMERO;
END
GO

-------------------------------------------------------------------------

-- Ejemplos de ejecución de los procedimientos
/*
EXEC CrearEnfermero 'E0000053', 'Juan Pérez', 'Pediatría', '5 años', '123412349', 'juan.perezalp@example.com', 1;
EXEC BuscarEnfermero 'E0000051';
EXEC EditarEnfermero 'E0000051', 'Juan Mendez', 'Traumatologia', '16 años', '123456789', 'juan.m@example.com', 1;
EXEC EliminarEnfermero 'E0000053';
*/


------------------------EXAMENES---------------------

CREATE PROCEDURE CrearExamen
    @TIPOEXAMENES CHAR(100),
    @FECHAHORA DATETIME = NULL,
    @NOMBREP CHAR(100),
    @NOMBREM CHAR(100),
    @NOMBRELAB CHAR(100),
    @ESTADO BIT = 1
AS
BEGIN
    INSERT INTO EXAMENES (TIPOEXAMENES, FECHAHORA, NOMBREP, NOMBREM, NOMBRELAB, ESTADO)
    VALUES (@TIPOEXAMENES, ISNULL(@FECHAHORA, GETDATE()), @NOMBREP, @NOMBREM, @NOMBRELAB, @ESTADO);
END
GO

CREATE PROCEDURE EditarExamen
    @TIPOEXAMENES CHAR(100),
    @FECHAHORA DATETIME,
    @NOMBREP CHAR(100),
    @NOMBREM CHAR(100),
    @NOMBRELAB CHAR(100),
    @ESTADO BIT
AS
BEGIN
    UPDATE EXAMENES
    SET FECHAHORA = @FECHAHORA,
        NOMBREP = @NOMBREP,
        NOMBREM = @NOMBREM,
        NOMBRELAB = @NOMBRELAB,
        ESTADO = @ESTADO
    WHERE TIPOEXAMENES = @TIPOEXAMENES;
END
GO

CREATE PROCEDURE BuscarExamen
    @TIPOEXAMENES CHAR(100)
AS
BEGIN
    SELECT * FROM EXAMENES WHERE TIPOEXAMENES = @TIPOEXAMENES;
END
GO

CREATE PROCEDURE EliminarExamen
    @TIPOEXAMENES CHAR(100)
AS
BEGIN
    DELETE FROM EXAMENES WHERE TIPOEXAMENES = @TIPOEXAMENES;
END
GO

-------------------------------------------------------------------------

-- Ejemplos de ejecución de los procedimientos
/*
EXEC CrearExamen 'Examen de Sangre', NULL, 'Pedro Pérez', 'Dr. Juan', 'Laboratorio Salud', 1;
EXEC BuscarExamen 'Examen de Sangre';
EXEC EditarExamen 'Examen de Sangre', '2024-10-15 09:00:00', 'Andres Pérez', 'Dr. Juan', 'Laboratorio Salud', 1;
EXEC EliminarExamen 'Examen de Sangre';
*/



------------------------MEDICAMENTOS---------------------

CREATE PROCEDURE CrearMedicamento
    @NOMBREMED CHAR(100),
    @ALERGIAMED CHAR(100),
    @DESCRIPCIONMED CHAR(300),
    @ESTADO BIT
AS
BEGIN
    INSERT INTO MEDICAMENTO (NOMBREMED, ALERGIAMED, DESCRIPCIONMED, ESTADO)
    VALUES (@NOMBREMED, @ALERGIAMED, @DESCRIPCIONMED, @ESTADO);
END
GO

CREATE PROCEDURE EditarMedicamento
    @NOMBREMED CHAR(100),
    @ALERGIAMED CHAR(100),
    @DESCRIPCIONMED CHAR(300),
    @ESTADO BIT
AS
BEGIN
    UPDATE MEDICAMENTO
    SET ALERGIAMED = @ALERGIAMED,
        DESCRIPCIONMED = @DESCRIPCIONMED,
        ESTADO = @ESTADO
    WHERE NOMBREMED = @NOMBREMED;
END
GO

CREATE PROCEDURE BuscarMedicamento
    @NOMBREMED CHAR(100)
AS
BEGIN
    SELECT * FROM MEDICAMENTO WHERE NOMBREMED = @NOMBREMED;
END
GO

CREATE PROCEDURE EliminarMedicamento
    @NOMBREMED CHAR(100)
AS
BEGIN
    DELETE FROM MEDICAMENTO WHERE NOMBREMED = @NOMBREMED;
END
GO

-------------------------------------------------------------------------

-- Ejemplos de ejecución de los procedimientos
/*
Execute CrearMedicamento 'Alendronato', 'Ninguna', 'Inhibidor de resorción', 1
Execute EditarMedicamento 'Alendronato', 'Ninguna', 'Antiinflamatorio y analgésico', 1;
Execute BuscarMedicamento 'Alendronato';
Execute EliminarMedicamento 'Alendronato';

select * from MEDICAMENTO
*/

----------------------------ORDENA--------------------------------

CREATE PROCEDURE CrearOrden
    @IDCONSULTA CHAR(8),
    @TIPOEXAMENES CHAR(100)
AS
BEGIN
    INSERT INTO ORDENA (IDCONSULTA, TIPOEXAMENES)
    VALUES (@IDCONSULTA, @TIPOEXAMENES);
END
GO

CREATE PROCEDURE EditarOrden
    @IDCONSULTA CHAR(8),
    @TIPOEXAMENES CHAR(100)
AS
BEGIN
    UPDATE ORDENA
    SET TIPOEXAMENES = @TIPOEXAMENES
    WHERE IDCONSULTA = @IDCONSULTA;
END
GO

CREATE PROCEDURE BuscarOrden
    @IDCONSULTA CHAR(8)
AS
BEGIN
    SELECT * FROM ORDENA WHERE IDCONSULTA = @IDCONSULTA;
END
GO

CREATE PROCEDURE EliminarOrden
    @IDCONSULTA CHAR(8)
AS
BEGIN
    DELETE FROM ORDENA WHERE IDCONSULTA = @IDCONSULTA;
END
GO

-------------------------------------------------------------------------

-- Ejemplos de ejecución de los procedimientos

/*
Execute CrearOrden 'C0000021', 'Prueba de glucosa';
Execute EditarOrden 'C0000021', 'Análisis de orina';
Execute BuscarOrden 'C0000021';
Execute EliminarOrden 'C0000021';

select * from ORDENA
select * from EXAMENES
*/

----------------------------Tratamiento--------------------------------


CREATE PROCEDURE CrearTratamiento
    @IDTRATAMIENTO CHAR(8),
    @NOMBREMED CHAR(100),
    @NOMBRETR CHAR(100),
    @FECHAINI DATE,
    @FECHAFIN DATE,
    @DESCTRA CHAR(300),
    @SUJETOTRA CHAR(100),
    @ESTADO BIT
AS
BEGIN
    INSERT INTO TRATAMIENTO (IDTRATAMIENTO, NOMBREMED, NOMBRETR, FECHAINI, FECHAFIN, DESCTRA, SUJETOTRA, ESTADO)
    VALUES (@IDTRATAMIENTO, @NOMBREMED, @NOMBRETR, @FECHAINI, @FECHAFIN, @DESCTRA, @SUJETOTRA, @ESTADO);
END
GO

CREATE PROCEDURE EditarTratamiento
    @IDTRATAMIENTO CHAR(8),
    @NOMBREMED CHAR(100),
    @NOMBRETR CHAR(100),
    @FECHAINI DATE,
    @FECHAFIN DATE,
    @DESCTRA CHAR(300),
    @SUJETOTRA CHAR(100),
    @ESTADO BIT
AS
BEGIN
    UPDATE TRATAMIENTO
    SET NOMBREMED = @NOMBREMED, NOMBRETR = @NOMBRETR, FECHAINI = @FECHAINI, FECHAFIN = @FECHAFIN,
        DESCTRA = @DESCTRA, SUJETOTRA = @SUJETOTRA, ESTADO = @ESTADO
    WHERE IDTRATAMIENTO = @IDTRATAMIENTO;
END
GO

CREATE PROCEDURE BuscarTratamiento
    @IDTRATAMIENTO CHAR(8)
AS
BEGIN
    SELECT * FROM TRATAMIENTO WHERE IDTRATAMIENTO = @IDTRATAMIENTO;
END
GO

CREATE PROCEDURE EliminarTratamiento
    @IDTRATAMIENTO CHAR(8)
AS
BEGIN
    DELETE FROM TRATAMIENTO WHERE IDTRATAMIENTO = @IDTRATAMIENTO;
END
GO

-------------------------------------------------------------------------
-- Ejemplos de ejecución de los procedimientos

/*
Execute CrearTratamiento 'T0000015', 'Aspirina', 'Tratamiento para dolor de cabeza', '2024-10-11', '2024-10-18', 'Reducir dolor de cabeza', 'Paciente con leucecmia', 1;
Execute EditarTratamiento 'T0000015', 'Paracetamol', 'Tratamiento para fiebre', '2024-10-12', '2024-10-19', 'Reducir fiebre', 'Paciente con dolor de cabeza', 1;
Execute BuscarTratamiento 'T0000015';
Execute EliminarTratamiento 'T0000015';

select * from TRATAMIENTO
select * from MEDICAMENTO
*/

----------------------------Triaje--------------------------------

CREATE PROCEDURE CrearTriaje
    @FECHAHORATRIAJE DATETIME,
    @IDCONSULTA CHAR(8),
    @IDENFERMERO CHAR(8),
    @SINTOMASP VARCHAR(100),
    @PRESIONP DECIMAL(3,0),
    @TEMP DECIMAL(3,1),
    @PESOP DECIMAL(5,2),
    @ESTADO BIT
AS
BEGIN
    INSERT INTO TRIAJE (FECHAHORATRIAJE, IDCONSULTA, IDENFERMERO, SINTOMASP, PRESIONP, TEMP, PESOP, ESTADO)
    VALUES (@FECHAHORATRIAJE, @IDCONSULTA, @IDENFERMERO, @SINTOMASP, @PRESIONP, @TEMP, @PESOP, @ESTADO);
END
GO

CREATE PROCEDURE EditarTriaje
    @FECHAHORATRIAJE DATETIME,
    @IDCONSULTA CHAR(8),
    @IDENFERMERO CHAR(8),
    @SINTOMASP VARCHAR(100),
    @PRESIONP DECIMAL(3,0),
    @TEMP DECIMAL(3,1),
    @PESOP DECIMAL(5,2),
    @ESTADO BIT
AS
BEGIN
    UPDATE TRIAJE
    SET IDCONSULTA = @IDCONSULTA, IDENFERMERO = @IDENFERMERO, SINTOMASP = @SINTOMASP, 
        PRESIONP = @PRESIONP, TEMP = @TEMP, PESOP = @PESOP, ESTADO = @ESTADO
    WHERE FECHAHORATRIAJE = @FECHAHORATRIAJE;
END
GO

CREATE PROCEDURE BuscarTriaje
    @FECHAHORATRIAJE DATETIME
AS
BEGIN
    SELECT * FROM TRIAJE WHERE FECHAHORATRIAJE = @FECHAHORATRIAJE;
END
GO

CREATE PROCEDURE EliminarTriaje
    @FECHAHORATRIAJE DATETIME
AS
BEGIN
    DELETE FROM TRIAJE WHERE FECHAHORATRIAJE = @FECHAHORATRIAJE;
END
GO

-------------------------------------------------------------------------
-- Ejemplos de ejecución de los procedimientos

/*
Execute CrearTriaje '2024-10-02 09:00:00.000', 'C0000050', 'E0000050', 'Dolor de cabeza', 120, 37.5, 70.5, 1;
Execute EditarTriaje '2024-10-02 09:00:00.000', 'C0000030', 'E0000030', 'Dolor abdominal',  130, 38.0, 71.0, 1;
Execute BuscarTriaje '2024-10-02 09:00:00.000';
Execute EliminarTriaje '2024-10-02 09:00:00.000';

select * from TRIAJE
*/




------------------------------REGISTROS------------------------------------------

INSERT INTO PACIENTE (IDPACIENTE, NOMBREP, APELLIDOP, FECHANACIMP, GENEROP, DIRECCIONP, NUMTELEFONICOP, EDAD)
VALUES
('P0000001', 'Juan', 'Pérez', '1990-05-15', 'M', 'Calle Falsa 123', '1234567890', '34'),
('P0000002', 'María', 'Gómez', '1985-03-22', 'F', 'Avenida Siempre Viva 742', '0987654321', '39'),
('P0000003', 'Luis', 'Martínez', '2000-01-10', 'M', 'Boulevard del Sol 45', '1122334455', '24'),
('P0000004', 'Ana', 'López', '1992-07-18', 'F', 'Calle Luna 99', '2233445566', '32'),
('P0000005', 'Pedro', 'Ramírez', '1988-12-30', 'M', 'Plaza Mayor 10', '3344556677', '35'),
('P0000006', 'Lucía', 'Hernández', '1995-09-09', 'F', 'Calle del Río 12', '4455667788', '29'),
('P0000007', 'Carlos', 'Torres', '1980-04-04', 'M', 'Calle Nueva 87', '5566778899', '44'),
('P0000008', 'Isabel', 'Flores', '1993-11-19', 'F', 'Calle Verde 33', '6677889900', '30'),
('P0000009', 'Javier', 'Cruz', '1986-06-16', 'M', 'Avenida Central 4', '7788990011', '38'),
('P0000010', 'Sofía', 'Díaz', '1991-02-28', 'F', 'Calle de la Paz 25', '8899001122', '33'),
('P0000011', 'Diego', 'García', '1999-08-15', 'M', 'Calle del Mar 56', '9900112233', '25'),
('P0000012', 'Gabriela', 'Mendoza', '1987-10-10', 'F', 'Calle del Bosque 78', '1011121314', '36'),
('P0000013', 'Andrés', 'Rojas', '1982-01-05', 'M', 'Avenida Libertad 99', '1213141516', '42'),
('P0000014', 'Paola', 'Salazar', '1994-03-17', 'F', 'Calle del Norte 11', '1415161718', '30'),
('P0000015', 'Fernando', 'Jiménez', '1979-12-12', 'M', 'Calle de la Aurora 90', '1617181920', '44'),
('P0000016', 'Valeria', 'Ortiz', '1996-05-25', 'F', 'Calle del Oeste 60', '1819202122', '28'),
('P0000017', 'Sebastián', 'Cano', '1998-07-20', 'M', 'Calle del Este 35', '2021222324', '26'),
('P0000018', 'Mariana', 'Maldonado', '1984-11-11', 'F', 'Calle del Cielo 88', '2223242526', '39'),
('P0000019', 'Cristian', 'Vega', '1992-04-22', 'M', 'Calle del Viento 44', '2425262728', '32'),
('P0000020', 'Diana', 'Ponce', '1990-08-09', 'F', 'Calle del Sol 22', '2627282930', '34'),
('P0000021', 'Ricardo', 'Núñez', '1989-06-30', 'M', 'Calle de la Lluvia 77', '2829303132', '35'),
('P0000022', 'Alma', 'Soto', '1997-12-15', 'F', 'Avenida de los Álamos 15', '3031323334', '26'),
('P0000023', 'Alberto', 'Ocampo', '1983-10-10', 'M', 'Calle de las Flores 19', '3233343536', '40'),
('P0000024', 'Martha', 'Salas', '1985-05-18', 'F', 'Avenida de los Olmos 13', '3435363738', '39'),
('P0000025', 'Edgar', 'Ríos', '1991-01-01', 'M', 'Calle de los Cactus 27', '3637383940', '33'),
('P0000026', 'Teresa', 'Guerrero', '1993-03-31', 'F', 'Calle de la Nieve 49', '3839404142', '31'),
('P0000027', 'Héctor', 'Morales', '1988-09-04', 'M', 'Calle del Arco 65', '4041424344', '36'),
('P0000028', 'Cecilia', 'Aguilar', '1986-02-20', 'F', 'Calle del Jardín 83', '4243444546', '38'),
('P0000029', 'Raúl', 'Salinas', '1995-06-14', 'M', 'Calle de la Luz 21', '4445464748', '29'),
('P0000030', 'Nadia', 'Pérez', '1994-08-19', 'F', 'Calle del Horizonte 70', '4647484950', '30'),
('P0000031', 'Ramón', 'Zapata', '1982-11-23', 'M', 'Avenida de la Montaña 34', '4849505152', '41'),
('P0000032', 'Paola', 'Hidalgo', '1989-04-04', 'F', 'Calle de las Estrellas 18', '5051525354', '35'),
('P0000033', 'Víctor', 'Cabrera', '1990-02-15', 'M', 'Calle de la Brisa 81', '5253545556', '34'),
('P0000034', 'Claudia', 'Pérez', '1991-09-10', 'F', 'Calle del Encanto 9', '5455565758', '33'),
('P0000035', 'Oscar', 'Castillo', '1993-12-27', 'M', 'Calle de la Esperanza 16', '5657585960', '30'),
('P0000036', 'Jessica', 'Martín', '1992-03-13', 'F', 'Calle de la Vida 37', '5859606162', '32'),
('P0000037', 'Jorge', 'Vargas', '1987-01-24', 'M', 'Calle del Océano 61', '6061626364', '37'),
('P0000038', 'Carla', 'Benítez', '1986-10-03', 'F', 'Avenida de los Sueños 72', '6263646566', '38'),
('P0000039', 'David', 'Silva', '1985-06-18', 'M', 'Calle de la Tierra 90', '6465666768', '39'),
('P0000040', 'Sara', 'Quintana', '1990-07-10', 'F', 'Calle de la Luna 33', '6667686970', '34'),
('P0000041', 'Nicolás', 'Rangel', '1988-09-29', 'M', 'Calle de la Primavera 11', '6869707172', '36'),
('P0000042', 'Marisol', 'Mora', '1995-11-05', 'F', 'Calle de la Tarde 45', '7071727374', '29'),
('P0000043', 'Alfonso', 'Paz', '1996-12-20', 'M', 'Calle de la Aurora 92', '7273747576', '28'),
('P0000044', 'Tatiana', 'Núñez', '1992-04-10', 'F', 'Calle de la Sombra 39', '7475767778', '32'),
('P0000045', 'Emilio', 'Duarte', '1983-08-08', 'M', 'Calle de los Faros 88', '7677787980', '41'),
('P0000046', 'Andrés', 'Ceballos', '1991-08-22', 'M', 'Calle del Faro 66', '7878787880', '33'),
('P0000047', 'Luciana', 'Mendoza', '1984-03-14', 'F', 'Avenida de los Lirios 14', '7979797981', '40'),
('P0000048', 'Samuel', 'Reyes', '1998-05-09', 'M', 'Calle de los Ríos 45', '8080808092', '26'),
('P0000049', 'Elena', 'González', '1982-11-30', 'F', 'Calle de la Nieve 88', '8181818193', '41'),
('P0000050', 'Ricardo', 'Salinas', '1990-09-15', 'M', 'Avenida de la Paz 54', '8282828294', '34');


SELECT * FROM PACIENTE




INSERT INTO MEDICO (IDMEDICO, NOMBREM, APELLIDOM, TELEFONOM, EMAILM, DIRECCIONM, ESPECIALIDADM, EXPERIENCIAM, ESTADO)
VALUES

('M0000001', 'Juan', 'Pérez', '600000001', 'juan.perez@medico.com', 'Calle 1', 'Cardiología', '5 años', 1),
('M0000002', 'María', 'García', '600000002', 'maria.garcia@medico.com', 'Calle 2', 'Pediatría', '3 años', 1),
('M0000003', 'Carlos', 'Fernández', '600000003', 'carlos.fernandez@medico.com', 'Calle 3', 'Dermatología', '8 años', 1),
('M0000004', 'Ana', 'Martínez', '600000004', 'ana.martinez@medico.com', 'Calle 4', 'Reumatología', '7 años', 1),
('M0000005', 'Luis', 'López', '600000005', 'luis.lopez@medico.com', 'Calle 5', 'Ginecología', '4 años', 1),
('M0000006', 'Claudia', 'González', '600000006', 'claudia.gonzalez@medico.com', 'Calle 6', 'Neumología', '6 años', 1),
('M0000007', 'Jorge', 'Hernández', '600000007', 'jorge.hernandez@medico.com', 'Calle 7', 'Psiquiatría', '9 años', 1),
('M0000008', 'Laura', 'Ramírez', '600000008', 'laura.ramirez@medico.com', 'Calle 8', 'Oftalmología', '5 años', 1),
('M0000009', 'Sofía', 'Torres', '600000009', 'sofia.torres@medico.com', 'Calle 9', 'Endocrinología', '2 años', 1),
('M0000010', 'Ricardo', 'Cruz', '600000010', 'ricardo.cruz@medico.com', 'Calle 10', 'Gastroenterología', '10 años', 1),
('M0000011', 'Valentina', 'Díaz', '600000011', 'valentina.diaz@medico.com', 'Calle 11', 'Traumatología', '3 años', 1),
('M0000012', 'Andrés', 'Morales', '600000012', 'andres.morales@medico.com', 'Calle 12', 'Otorrinolaringología', '6 años', 1),
('M0000013', 'Marta', 'Mendoza', '600000013', 'marta.mendoza@medico.com', 'Calle 13', 'Neurología', '4 años', 1),
('M0000014', 'Hugo', 'Salazar', '600000014', 'hugo.salazar@medico.com', 'Calle 14', 'Oncología', '7 años', 1),
('M0000015', 'Natalia', 'Valdés', '600000015', 'natalia.valdes@medico.com', 'Calle 15', 'Urología', '8 años', 1),
('M0000016', 'Felipe', 'González', '600000016', 'felipe.gonzalez@medico.com', 'Calle 16', 'Inmunología', '5 años', 1),
('M0000017', 'Lorena', 'Castillo', '600000017', 'lorena.castillo@medico.com', 'Calle 17', 'Cirugía General', '9 años', 1),
('M0000018', 'Pablo', 'Jiménez', '600000018', 'pablo.jimenez@medico.com', 'Calle 18', 'Anestesiología', '10 años', 1),
('M0000019', 'Carolina', 'Soto', '600000019', 'carolina.soto@medico.com', 'Calle 19', 'Pediatría', '3 años', 1),
('M0000020', 'José', 'Rojas', '600000020', 'jose.rojas@medico.com', 'Calle 20', 'Geriatría', '12 años', 1),
('M0000021', 'Isabel', 'Ceballos', '600000021', 'isabel.ceballos@medico.com', 'Calle 21', 'Reumatología', '4 años', 1),
('M0000022', 'Ricardo', 'Córdoba', '600000022', 'ricardo.cordoba@medico.com', 'Calle 22', 'Neumología', '7 años', 1),
('M0000023', 'Verónica', 'Hurtado', '600000023', 'veronica.hurtado@medico.com', 'Calle 23', 'Gastroenterología', '5 años', 1),
('M0000024', 'Julián', 'Villalobos', '600000024', 'julian.villalobos@medico.com', 'Calle 24', 'Oftalmología', '6 años', 1),
('M0000025', 'Alejandra', 'Salas', '600000025', 'alejandra.salas@medico.com', 'Calle 25', 'Cardiología', '8 años', 1),
('M0000026', 'Ricardo', 'Duran', '600000026', 'ricardo.duran@medico.com', 'Calle 26', 'Dermatología', '3 años', 1),
('M0000027', 'Mónica', 'Barreto', '600000027', 'monica.baretto@medico.com', 'Calle 27', 'Psiquiatría', '4 años', 1),
('M0000028', 'Samuel', 'García', '600000028', 'samuel.garcia@medico.com', 'Calle 28', 'Endocrinología', '5 años', 1),
('M0000029', 'Silvana', 'Hernández', '600000029', 'silvana.hernandez@medico.com', 'Calle 29', 'Neurología', '6 años', 1),
('M0000030', 'Diego', 'Martínez', '600000030', 'diego.martinez@medico.com', 'Calle 30', 'Cirugía General', '7 años', 1),
('M0000031', 'Lina', 'Moreno', '600000031', 'lina.moreno@medico.com', 'Calle 31', 'Ginecología', '8 años', 1),
('M0000032', 'Julio', 'Bermúdez', '600000032', 'julio.bermudez@medico.com', 'Calle 32', 'Traumatología', '5 años', 1),
('M0000033', 'Cynthia', 'Maya', '600000033', 'cynthia.maya@medico.com', 'Calle 33', 'Inmunología', '6 años', 1),
('M0000034', 'Ernesto', 'Gamboa', '600000034', 'ernesto.gamboa@medico.com', 'Calle 34', 'Oncología', '4 años', 1),
('M0000035', 'Patricia', 'Córdoba', '600000035', 'patricia.cordoba@medico.com', 'Calle 35', 'Geriatría', '9 años', 1),
('M0000036', 'Fernando', 'Espinoza', '600000036', 'fernando.espinoza@medico.com', 'Calle 36', 'Urología', '10 años', 1),
('M0000037', 'Gabriel', 'Castaño', '600000037', 'gabriel.castano@medico.com', 'Calle 37', 'Oftalmología', '5 años', 1),
('M0000038', 'Susana', 'Rincón', '600000038', 'susana.rincon@medico.com', 'Calle 38', 'Gastroenterología', '6 años', 1),
('M0000039', 'Oscar', 'Pacheco', '600000039', 'oscar.pacheco@medico.com', 'Calle 39', 'Dermatología', '4 años', 1),
('M0000040', 'Mariana', 'Rojas', '600000040', 'mariana.rojas@medico.com', 'Calle 40', 'Pediatría', '3 años', 1),
('M0000041', 'Mónica', 'Ochoa', '600123456', 'monica.ochoa@medico.com', 'Av. Manantial 202', 'Reumatología', '5 años', 1),
('M0000042', 'Anderson', 'Alarcón', '600234567', 'anderson.alarcon@medico.com', 'Calle Lirio 303', 'Neurología', '8 años', 1),
('M0000043', 'Gloria', 'Camacho', '600345678', 'gloria.camacho@medico.com', 'Calle Pez 404', 'Geriatría', '6 años', 1),
('M0000044', 'Hugo', 'Aguilar', '600456789', 'hugo.aguilar@medico.com', 'Calle Caoba 505', 'Dermatología', '7 años', 1),
('M0000045', 'Alejandra', 'Núñez', '600567890', 'alejandra.nunez@medico.com', 'Calle Algodón 606', 'Cirugía General', '4 años', 1),
('M0000046', 'Esteban', 'López', '600678901', 'esteban.lopez@medico.com', 'Calle Roca 707', 'Cardiología', '10 años', 1),
('M0000047', 'Cecilia', 'Soto', '600789012', 'cecilia.soto@medico.com', 'Calle Aceituna 808', 'Neumología', '3 años', 1),
('M0000048', 'Mauricio', 'Cruz', '600890123', 'mauricio.cruz@medico.com', 'Calle Melón 909', 'Psiquiatría', '12 años', 1),
('M0000049', 'Lina', 'Castañeda', '600901234', 'lina.castaneda@medico.com', 'Calle Coco 111', 'Pediatría', '9 años', 1),
('M0000050', 'Fernando', 'Alonso', '600012345', 'fernando.alonso@medico.com', 'Av. Rocío 222', 'Ginecología', '11 años', 1);



SELECT * FROM MEDICO




INSERT INTO CONSULTA (IDCONSULTA, IDPACIENTE, IDMEDICO, TIPO_CONSULTA, FECHA_HORA_CONSULTA, OBSERVACIONES, ESTADO)
VALUES
('C0000001', 'P0000001', 'M0000001', 'Chequeo general', '2024-10-01 10:00:00', 'Todo en orden', 1),
('C0000002', 'P0000002', 'M0000002', 'Consulta de alergias', '2024-10-01 10:30:00', 'Se necesita análisis', 1),
('C0000003', 'P0000003', 'M0000003', 'Control de diabetes', '2024-10-01 11:00:00', 'Nivel de azúcar alto', 1),
('C0000004', 'P0000004', 'M0000004', 'Revisión dental', '2024-10-01 11:30:00', 'Requiere limpieza', 1),
('C0000005', 'P0000005', 'M0000005', 'Consulta pediátrica', '2024-10-01 12:00:00', 'Desarrollo normal', 1),
('C0000006', 'P0000006', 'M0000006', 'Chequeo cardiológico', '2024-10-01 12:30:00', 'Requiere ecografía', 1),
('C0000007', 'P0000007', 'M0000007', 'Consulta de salud mental', '2024-10-01 13:00:00', 'Ansiedad moderada', 1),
('C0000008', 'P0000008', 'M0000008', 'Consulta ginecológica', '2024-10-01 13:30:00', 'Chequeo rutinario', 1),
('C0000009', 'P0000009', 'M0000009', 'Consulta dermatológica', '2024-10-01 14:00:00', 'Eccema en la piel', 1),
('C0000010', 'P0000010', 'M0000010', 'Consulta endocrinológica', '2024-10-01 14:30:00', 'Problemas de tiroides', 1),
('C0000011', 'P0000011', 'M0000011', 'Chequeo oftalmológico', '2024-10-01 15:00:00', 'Necesita gafas', 1),
('C0000012', 'P0000012', 'M0000012', 'Consulta neurológica', '2024-10-01 15:30:00', 'Dolores de cabeza frecuentes', 1),
('C0000013', 'P0000013', 'M0000013', 'Chequeo gastrointestinal', '2024-10-01 16:00:00', 'Dolor abdominal', 1),
('C0000014', 'P0000014', 'M0000014', 'Consulta de nutrición', '2024-10-01 16:30:00', 'Desequilibrio alimenticio', 1),
('C0000015', 'P0000015', 'M0000015', 'Consulta reumatológica', '2024-10-01 17:00:00', 'Dolor en las articulaciones', 1),
('C0000016', 'P0000016', 'M0000016', 'Consulta urológica', '2024-10-01 17:30:00', 'Problemas urinarios', 1),
('C0000017', 'P0000017', 'M0000017', 'Consulta geriátrica', '2024-10-01 18:00:00', 'Chequeo de rutina', 1),
('C0000018', 'P0000018', 'M0000018', 'Consulta de vacunación', '2024-10-01 18:30:00', 'Vacunas al día', 1),
('C0000019', 'P0000019', 'M0000019', 'Consulta de fisioterapia', '2024-10-01 19:00:00', 'Rehabilitación de rodilla', 1),
('C0000020', 'P0000020', 'M0000020', 'Consulta de medicina general', '2024-10-01 19:30:00', 'Síntomas de gripe', 1),
('C0000021', 'P0000021', 'M0000021', 'Consulta de dermatología', '2024-10-01 20:00:00', 'Acne severo', 1),
('C0000022', 'P0000022', 'M0000022', 'Chequeo prenatal', '2024-10-02 10:00:00', 'Embarazo saludable', 1),
('C0000023', 'P0000023', 'M0000023', 'Consulta de salud ocupacional', '2024-10-02 10:30:00', 'Chequeo anual', 1),
('C0000024', 'P0000024', 'M0000024', 'Consulta de alergología', '2024-10-02 11:00:00', 'Pruebas de alergias', 1),
('C0000025', 'P0000025', 'M0000025', 'Consulta de endocrinología', '2024-10-02 11:30:00', 'Problemas hormonales', 1),
('C0000026', 'P0000026', 'M0000026', 'Consulta de cardiología', '2024-10-02 12:00:00', 'Chequeo de presión', 1),
('C0000027', 'P0000027', 'M0000027', 'Consulta de medicina interna', '2024-10-02 12:30:00', 'Dolor en el pecho', 1),
('C0000028', 'P0000028', 'M0000028', 'Consulta pediátrica', '2024-10-02 13:00:00', 'Control de crecimiento', 1),
('C0000029', 'P0000029', 'M0000029', 'Consulta de psiquiatría', '2024-10-02 13:30:00', 'Ansiedad severa', 1),
('C0000030', 'P0000030', 'M0000030', 'Consulta de ginecología', '2024-10-02 14:00:00', 'Chequeo anual', 1),
('C0000031', 'P0000031', 'M0000031', 'Consulta dermatológica', '2024-10-02 14:30:00', 'Eczema persistente', 1),
('C0000032', 'P0000032', 'M0000032', 'Chequeo ortopédico', '2024-10-02 15:00:00', 'Lesión de tobillo', 1),
('C0000033', 'P0000033', 'M0000033', 'Consulta geriátrica', '2024-10-02 15:30:00', 'Control de medicación', 1),
('C0000034', 'P0000034', 'M0000034', 'Consulta de oncología', '2024-10-02 16:00:00', 'Chequeo de seguimiento', 1),
('C0000035', 'P0000035', 'M0000035', 'Consulta de salud mental', '2024-10-02 16:30:00', 'Depresión leve', 1),
('C0000036', 'P0000036', 'M0000036', 'Consulta de medicina deportiva', '2024-10-02 17:00:00', 'Lesión muscular', 1),
('C0000037', 'P0000037', 'M0000037', 'Consulta de reumatología', '2024-10-02 17:30:00', 'Dolor crónico', 1),
('C0000038', 'P0000038', 'M0000038', 'Consulta urológica', '2024-10-02 18:00:00', 'Chequeo de próstata', 1),
('C0000039', 'P0000039', 'M0000039', 'Consulta de endocrinología', '2024-10-02 18:30:00', 'Desequilibrio de insulina', 1),
('C0000040', 'P0000040', 'M0000040', 'Consulta de medicina interna', '2024-10-02 19:00:00', 'Control de hipertensión', 1),
('C0000041', 'P0000041', 'M0000041', 'Chequeo de salud', '2024-10-02 19:30:00', 'Evaluación general', 1),
('C0000042', 'P0000042', 'M0000042', 'Consulta pediátrica', '2024-10-02 20:00:00', 'Vacunación de rutina', 1),
('C0000043', 'P0000043', 'M0000043', 'Consulta de ginecología', '2024-10-02 20:30:00', 'Control de salud femenina', 1),
('C0000044', 'P0000044', 'M0000044', 'Consulta de nutrición', '2024-10-02 21:00:00', 'Revisión de dieta', 1),
('C0000045', 'P0000045', 'M0000045', 'Consulta dermatológica', '2024-10-02 21:30:00', 'Chequeo de manchas', 1),
('C0000046', 'P0000046', 'M0000046', 'Consulta psiquiátrica', '2024-10-02 22:00:00', 'Seguimiento de tratamiento', 1),
('C0000047', 'P0000047', 'M0000047', 'Consulta cardiológica', '2024-10-02 22:30:00', 'Revisión de colesterol', 1),
('C0000048', 'P0000048', 'M0000048', 'Consulta de medicina deportiva', '2024-10-02 23:00:00', 'Rehabilitación', 1),
('C0000049', 'P0000049', 'M0000049', 'Chequeo prenatal', '2024-10-02 23:30:00', 'Seguimiento de embarazo', 1),
('C0000050', 'P0000050', 'M0000050', 'Consulta de salud mental', '2024-10-03 00:00:00', 'Terapia de apoyo', 1);


SELECT * FROM CONSULTA


INSERT INTO ENFERMERO (IDENFERMERO, NOMBREENF, ESPECIALIDADENF, EXPERIENCIAENF, TELEFONOENF, EMAILM, ESTADO)
VALUES
('E0000001', 'Luis González', 'Pediatría', '5 años', '1234567890', 'luis.gonzalez@example.com', 1),
('E0000002', 'María López', 'Ginecología', '7 años', '2345678901', 'maria.lopez@example.com', 1),
('E0000003', 'Carlos Martínez', 'Cardiología', '4 años', '3456789012', 'carlos.martinez@example.com', 1),
('E0000004', 'Ana Hernández', 'Neurología', '3 años', '4567890123', 'ana.hernandez@example.com', 1),
('E0000005', 'Pedro Ramírez', 'Traumatología', '6 años', '5678901234', 'pedro.ramirez@example.com', 1),
('E0000006', 'Sofía García', 'Oncología', '2 años', '6789012345', 'sofia.garcia@example.com', 1),
('E0000007', 'Javier Díaz', 'Urología', '8 años', '7890123456', 'javier.diaz@example.com', 1),
('E0000008', 'Valeria Salas', 'Dermatología', '5 años', '8901234567', 'valeria.salas@example.com', 1),
('E0000009', 'Diego Ríos', 'Geriatría', '10 años', '9012345678', 'diego.rios@example.com', 1),
('E0000010', 'Gabriela Morales', 'Oftalmología', '4 años', '0123456789', 'gabriela.morales@example.com', 1),
('E0000011', 'Andrés Cano', 'Endocrinología', '9 años', '1234567891', 'andres.cano@example.com', 1),
('E0000012', 'Claudia Quintero', 'Neumología', '3 años', '2345678902', 'claudia.quintero@example.com', 1),
('E0000013', 'Fernando Castillo', 'Gastroenterología', '6 años', '3456789013', 'fernando.castillo@example.com', 1),
('E0000014', 'Isabel Aguilar', 'Pediatría', '7 años', '4567890124', 'isabel.aguilar@example.com', 1),
('E0000015', 'Sebastián Pérez', 'Cardiología', '5 años', '5678901235', 'sebastian.perez@example.com', 1),
('E0000016', 'Cristina Sánchez', 'Ginecología', '8 años', '6789012346', 'cristina.sanchez@example.com', 1),
('E0000017', 'Raúl Vega', 'Neurología', '4 años', '7890123457', 'raul.vega@example.com', 1),
('E0000018', 'Mariana Núñez', 'Traumatología', '2 años', '8901234568', 'mariana.nunez@example.com', 1),
('E0000019', 'Alberto Cruz', 'Oncología', '10 años', '9012345679', 'alberto.cruz@example.com', 1),
('E0000020', 'Lucía Maldonado', 'Urología', '3 años', '0123456780', 'lucia.maldonado@example.com', 1),
('E0000021', 'Ricardo Torres', 'Dermatología', '6 años', '1234567892', 'ricardo.torres@example.com', 1),
('E0000022', 'Diana Salazar', 'Geriatría', '4 años', '2345678903', 'diana.salazar@example.com', 1),
('E0000023', 'Oscar Rangel', 'Oftalmología', '5 años', '3456789014', 'oscar.rangel@example.com', 1),
('E0000024', 'Cecilia Benítez', 'Endocrinología', '7 años', '4567890125', 'cecilia.benitez@example.com', 1),
('E0000025', 'Héctor Jiménez', 'Neumología', '8 años', '5678901236', 'hector.jimenez@example.com', 1),
('E0000026', 'Paola Hidalgo', 'Gastroenterología', '3 años', '6789012347', 'paola.hidalgo@example.com', 1),
('E0000027', 'Luis Ceballos', 'Pediatría', '5 años', '7890123458', 'luis.ceballos@example.com', 1),
('E0000028', 'Martha Mora', 'Cardiología', '6 años', '8901234569', 'martha.mora@example.com', 1),
('E0000029', 'Emilio Silva', 'Ginecología', '2 años', '9012345670', 'emilio.silva@example.com', 1),
('E0000030', 'Sara González', 'Neurología', '4 años', '0123456781', 'sara.gonzalez@example.com', 1),
('E0000031', 'Alfonso Mora', 'Traumatología', '5 años', '1234567893', 'alfonso.mora@example.com', 1),
('E0000032', 'Tatiana Pérez', 'Oncología', '3 años', '2345678904', 'tatiana.perez@example.com', 1),
('E0000033', 'Diego Morales', 'Urología', '6 años', '3456789015', 'diego.morales@example.com', 1),
('E0000034', 'Luciana Díaz', 'Dermatología', '8 años', '4567890126', 'luciana.diaz@example.com', 1),
('E0000035', 'Gabriel Hernández', 'Geriatría', '10 años', '5678901237', 'gabriel.hernandez@example.com', 1),
('E0000036', 'Nadia López', 'Oftalmología', '2 años', '6789012348', 'nadia.lopez@example.com', 1),
('E0000037', 'Samuel Vega', 'Endocrinología', '3 años', '7890123459', 'samuel.vega@example.com', 1),
('E0000038', 'Valentina Santos', 'Neumología', '5 años', '8901234570', 'valentina.santos@example.com', 1),
('E0000039', 'Martín Cano', 'Gastroenterología', '6 años', '9012345671', 'martin.cano@example.com', 1),
('E0000040', 'Claudia Ríos', 'Pediatría', '4 años', '0123456782', 'claudia.rios@example.com', 1),
('E0000041', 'Ricardo Castillo', 'Cardiología', '9 años', '1234567894', 'ricardo.castillo@example.com', 1),
('E0000042', 'Isabella González', 'Ginecología', '5 años', '2345678905', 'isabella.gonzalez@example.com', 1),
('E0000043', 'Emilio Martínez', 'Neurología', '8 años', '3456789016', 'emilio.martinez@example.com', 1),
('E0000044', 'Camila Hernández', 'Traumatología', '6 años', '4567890127', 'camila.hernandez@example.com', 1),
('E0000045', 'Eduardo Salinas', 'Oncología', '4 años', '5678901238', 'eduardo.salinas@example.com', 1),
('E0000046', 'Jessica Soto', 'Urología', '7 años', '6789012349', 'jessica.soto@example.com', 1),
('E0000047', 'Gustavo Morales', 'Dermatología', '5 años', '7890123460', 'gustavo.morales@example.com', 1),
('E0000048', 'Sofia López', 'Geriatría', '3 años', '8901234571', 'sofia.lopez@example.com', 1),
('E0000049', 'Marco Ceballos', 'Oftalmología', '2 años', '9012345672', 'marco.ceballos@example.com', 1),
('E0000050', 'Paloma Sánchez', 'Endocrinología', '6 años', '0123456783', 'paloma.sanchez@example.com', 1);



SELECT * FROM ENFERMERO


INSERT INTO TRIAJE (FECHAHORATRIAJE, IDCONSULTA, IDENFERMERO, SINTOMASP, PRESIONP, TEMP, PESOP, ESTADO)
VALUES
('2024-10-02 08:00:00', 'C0000001', 'E0000001', 'Fiebre y tos', 120, 37.5, 70.00, 1),
('2024-10-02 08:01:00', 'C0000002', 'E0000002', 'Picazón y erupción', 115, 36.8, 68.00, 1),
('2024-10-02 08:02:00', 'C0000003', 'E0000003', 'Dolor de cabeza', 130, 38.0, 75.00, 1),
('2024-10-02 08:03:00', 'C0000004', 'E0000004', 'Sensación de cansancio', 125, 36.5, 80.00, 1),
('2024-10-02 08:04:00', 'C0000005', 'E0000005', 'Dolor en el abdomen', 140, 37.0, 60.00, 1),
('2024-10-02 08:05:00', 'C0000006', 'E0000006', 'Palpitaciones', 110, 39.2, 72.00, 1),
('2024-10-02 08:06:00', 'C0000007', 'E0000007', 'Depresión y ansiedad', 100, 37.5, 65.00, 1),
('2024-10-02 08:07:00', 'C0000008', 'E0000008', 'Dolor menstrual', 115, 36.8, 62.00, 1),
('2024-10-02 08:08:00', 'C0000009', 'E0000009', 'Erupción cutánea', 120, 38.1, 70.00, 1),
('2024-10-02 08:09:00', 'C0000010', 'E0000010', 'Fatiga y debilidad', 125, 37.4, 76.00, 1),
('2024-10-02 08:10:00', 'C0000011', 'E0000011', 'Visión borrosa', 130, 36.9, 78.00, 1),
('2024-10-02 08:11:00', 'C0000012', 'E0000012', 'Dolor en el pecho', 135, 38.5, 82.00, 1),
('2024-10-02 08:12:00', 'C0000013', 'E0000013', 'Náuseas y vómitos', 120, 37.2, 65.00, 1),
('2024-10-02 08:13:00', 'C0000014', 'E0000014', 'Cambios en el apetito', 110, 36.7, 70.00, 1),
('2024-10-02 08:14:00', 'C0000015', 'E0000015', 'Rigidez articular', 125, 37.1, 74.00, 1),
('2024-10-02 08:15:00', 'C0000016', 'E0000016', 'Dificultad para orinar', 140, 36.3, 69.00, 1),
('2024-10-02 08:16:00', 'C0000017', 'E0000017', 'Cansancio extremo', 115, 37.6, 68.00, 1),
('2024-10-02 08:17:00', 'C0000018', 'E0000018', 'Fiebre leve', 125, 38.0, 72.00, 1),
('2024-10-02 08:18:00', 'C0000019', 'E0000019', 'Dolor de rodilla', 130, 36.5, 76.00, 1),
('2024-10-02 08:19:00', 'C0000020', 'E0000020', 'Congestión nasal', 115, 37.3, 71.00, 1),
('2024-10-02 08:20:00', 'C0000021', 'E0000021', 'Pérdida de peso', 120, 38.2, 67.00, 1),
('2024-10-02 08:21:00', 'C0000022', 'E0000022', 'Tensión en el cuello', 110, 36.9, 74.00, 1),
('2024-10-02 08:22:00', 'C0000023', 'E0000023', 'Dolor en la espalda', 130, 37.4, 75.00, 1),
('2024-10-02 08:23:00', 'C0000024', 'E0000024', 'Picazón en la piel', 120, 36.6, 68.00, 1),
('2024-10-02 08:24:00', 'C0000025', 'E0000025', 'Mareos', 140, 37.5, 70.00, 1),
('2024-10-02 08:25:00', 'C0000026', 'E0000026', 'Fiebre alta', 135, 38.7, 78.00, 1),
('2024-10-02 08:26:00', 'C0000027', 'E0000027', 'Tos seca', 120, 37.9, 75.00, 1),
('2024-10-02 08:27:00', 'C0000028', 'E0000028', 'Dolor en la muñeca', 125, 36.8, 73.00, 1),
('2024-10-02 08:28:00', 'C0000029', 'E0000029', 'Nerviosismo', 115, 37.1, 70.00, 1),
('2024-10-02 08:29:00', 'C0000030', 'E0000030', 'Fatiga crónica', 120, 36.5, 68.00, 1),
('2024-10-02 08:30:00', 'C0000031', 'E0000031', 'Dolor de garganta', 130, 38.0, 74.00, 1),
('2024-10-02 08:31:00', 'C0000032', 'E0000032', 'Sudoración excesiva', 135, 39.0, 76.00, 1),
('2024-10-02 08:32:00', 'C0000033', 'E0000033', 'Dolor en el hombro', 125, 37.6, 71.00, 1),
('2024-10-02 08:33:00', 'C0000034', 'E0000034', 'Náuseas matutinas', 110, 36.4, 65.00, 1),
('2024-10-02 08:34:00', 'C0000035', 'E0000035', 'Dolor en el tobillo', 120, 37.8, 73.00, 1),
('2024-10-02 08:35:00', 'C0000036', 'E0000036', 'Sensibilidad en el pecho', 125, 36.5, 72.00, 1),
('2024-10-02 08:36:00', 'C0000037', 'E0000037', 'Fiebre intermitente', 140, 38.1, 77.00, 1),
('2024-10-02 08:37:00', 'C0000038', 'E0000038', 'Dificultad para respirar', 130, 39.2, 74.00, 1),
('2024-10-02 08:38:00', 'C0000039', 'E0000039', 'Agujetas musculares', 120, 36.7, 69.00, 1),
('2024-10-02 08:39:00', 'C0000040', 'E0000040', 'Sensación de frío', 115, 37.0, 66.00, 1),
('2024-10-02 08:40:00', 'C0000041', 'E0000041', 'Pérdida de apetito', 110, 36.8, 72.00, 1),
('2024-10-02 08:41:00', 'C0000042', 'E0000042', 'Infección urinaria', 125, 38.3, 70.00, 1),
('2024-10-02 08:42:00', 'C0000043', 'E0000043', 'Dolor en el pecho', 135, 37.4, 75.00, 1),
('2024-10-02 08:43:00', 'C0000044', 'E0000044', 'Rinitis alérgica', 120, 36.5, 68.00, 1),
('2024-10-02 08:44:00', 'C0000045', 'E0000045', 'Cefalea intensa', 130, 38.2, 78.00, 1),
('2024-10-02 08:45:00', 'C0000046', 'E0000046', 'Convulsiones', 125, 37.8, 73.00, 1),
('2024-10-02 08:46:00', 'C0000047', 'E0000047', 'Insomnio', 110, 36.9, 65.00, 1),
('2024-10-02 08:47:00', 'C0000048', 'E0000048', 'Dolor de espalda baja', 115, 37.3, 70.00, 1),
('2024-10-02 08:48:00', 'C0000049', 'E0000049', 'Hiperactividad', 120, 36.6, 72.00, 1),
('2024-10-02 08:49:00', 'C0000050', 'E0000050', 'Malestar general', 125, 37.1, 74.00, 1);







-- Continúa el patrón para el resto de inserciones.





select* from TRIAJE



INSERT INTO DTTRIAJE (FECHAHORATRIAJE, OBSERVACIONES, ESTADO)
VALUES
('2024-10-02 08:00:00', 'Paciente con fiebre leve, se recomienda reposo.', 1),
('2024-10-02 08:01:00', 'Erupción cutánea leve, se indica crema tópica.', 1),
('2024-10-02 08:02:00', 'Paciente presenta cefalea, se prescribe analgésico.', 1),
('2024-10-02 08:03:00', 'Cansancio moderado, se sugiere descanso adecuado.', 1),
('2024-10-02 08:04:00', 'Dolor abdominal, se recomienda dieta blanda.', 1),
('2024-10-02 08:05:00', 'Palpitaciones ocasionales, se recomienda seguimiento.', 1),
('2024-10-02 08:06:00', 'Ansiedad leve, se sugiere terapia de relajación.', 1),
('2024-10-02 08:07:00', 'Dolor menstrual, se prescribe analgésico.', 1),
('2024-10-02 08:08:00', 'Erupción cutánea, observar evolución.', 1),
('2024-10-02 08:09:00', 'Fatiga, se recomienda hidratación.', 1),
('2024-10-02 08:10:00', 'Visión borrosa, se sugiere revisión oftalmológica.', 1),
('2024-10-02 08:11:00', 'Dolor en el pecho leve, se recomienda reposo.', 1),
('2024-10-02 08:12:00', 'Náuseas, se prescribe antiemético.', 1),
('2024-10-02 08:13:00', 'Cambios en el apetito, se sugiere dieta balanceada.', 1),
('2024-10-02 08:14:00', 'Rigidez articular, se recomienda ejercicios suaves.', 1),
('2024-10-02 08:15:00', 'Dificultad para orinar, se sugiere hidratación.', 1),
('2024-10-02 08:16:00', 'Cansancio extremo, se indica evaluación médica.', 1),
('2024-10-02 08:17:00', 'Fiebre leve, se sugiere monitoreo.', 1),
('2024-10-02 08:18:00', 'Dolor en rodilla, se recomienda descanso.', 1),
('2024-10-02 08:19:00', 'Congestión nasal, se sugiere descongestionante.', 1),
('2024-10-02 08:20:00', 'Pérdida de peso, se recomienda consulta nutricional.', 1),
('2024-10-02 08:21:00', 'Tensión en el cuello, se sugiere terapia física.', 1),
('2024-10-02 08:22:00', 'Dolor de espalda, se recomienda reposo.', 1),
('2024-10-02 08:23:00', 'Picazón en la piel, se indica crema antihistamínica.', 1),
('2024-10-02 08:24:00', 'Mareos ocasionales, se recomienda hidratación.', 1),
('2024-10-02 08:25:00', 'Fiebre alta, se sugiere monitoreo continuo.', 1),
('2024-10-02 08:26:00', 'Tos seca persistente, se prescribe jarabe.', 1),
('2024-10-02 08:27:00', 'Dolor en muñeca, se sugiere reposo.', 1),
('2024-10-02 08:28:00', 'Nerviosismo leve, se recomienda terapia de relajación.', 1),
('2024-10-02 08:29:00', 'Fatiga crónica, se sugiere evaluación médica.', 1),
('2024-10-02 08:30:00', 'Dolor de garganta leve, se sugiere gárgaras.', 1),
('2024-10-02 08:31:00', 'Sudoración excesiva, se recomienda evaluación endocrina.', 1),
('2024-10-02 08:32:00', 'Dolor en hombro, se sugiere terapia física.', 1),
('2024-10-02 08:33:00', 'Náuseas matutinas, se prescribe antiemético.', 1),
('2024-10-02 08:34:00', 'Dolor en tobillo, se recomienda reposo.', 1),
('2024-10-02 08:35:00', 'Sensibilidad en el pecho, se sugiere evaluación médica.', 1),
('2024-10-02 08:36:00', 'Fiebre intermitente, se recomienda monitoreo.', 1),
('2024-10-02 08:37:00', 'Dificultad para respirar, se sugiere evaluación urgente.', 1),
('2024-10-02 08:38:00', 'Agujetas musculares, se recomienda descanso.', 1),
('2024-10-02 08:39:00', 'Sensación de frío, se recomienda abrigo.', 1),
('2024-10-02 08:40:00', 'Pérdida de apetito, se recomienda dieta balanceada.', 1),
('2024-10-02 08:41:00', 'Infección urinaria, se prescribe antibiótico.', 1),
('2024-10-02 08:42:00', 'Dolor en pecho leve, se recomienda reposo.', 1),
('2024-10-02 08:43:00', 'Rinitis alérgica, se prescribe antihistamínico.', 1),
('2024-10-02 08:44:00', 'Cefalea intensa, se prescribe analgésico.', 1),
('2024-10-02 08:45:00', 'Convulsiones ocasionales, se sugiere evaluación neurológica.', 1),
('2024-10-02 08:46:00', 'Insomnio, se sugiere terapia de sueño.', 1),
('2024-10-02 08:47:00', 'Dolor de espalda baja, se recomienda terapia física.', 1),
('2024-10-02 08:48:00', 'Hiperactividad, se sugiere seguimiento pediátrico.', 1),
('2024-10-02 08:49:00', 'Malestar general, se recomienda evaluación médica.', 1);



select* from DTTRIAJE



INSERT INTO MEDICAMENTO (NOMBREMED, ALERGIAMED, DESCRIPCIONMED, ESTADO)
VALUES

('Paracetamol', 'Ninguna', 'Analgesico y antipirético.', 1),
('Ibuprofeno', 'Ninguna', 'Antiinflamatorio no esteroideo.', 1),
('Amoxicilina', 'Alergia a penicilina', 'Antibiótico de amplio espectro.', 1),
('Loratadina', 'Ninguna', 'Antihistamínico para alergias.', 1),
('Omeprazol', 'Ninguna', 'Inhibidor de bomba de protones.', 1),
('Metformina', 'Ninguna', 'Antidiabético oral.', 1),
('Aspirina', 'Ninguna', 'Antiinflamatorio y antiplaquetario.', 1),
('Simvastatina', 'Ninguna', 'Reductor de lípidos.', 1),
('Ciprofloxacino', 'Ninguna', 'Antibiótico fluoroquinolona.', 1),
('Salbutamol', 'Ninguna', 'Broncodilatador para asma.', 1),
('Prednisona', 'Ninguna', 'Corticoide para inflamación.', 1),
('Furosemida', 'Ninguna', 'Diurético de asa.', 1),
('Sertralina', 'Ninguna', 'Antidepresivo inhibidor de la recaptación de serotonina.', 1),
('Citalopram', 'Ninguna', 'Antidepresivo ISRS.', 1),
('Metoprolol', 'Ninguna', 'Betabloqueante para hipertensión.', 1),
('Dextrometorfano', 'Ninguna', 'Antitusígeno.', 1),
('Clopidogrel', 'Ninguna', 'Antiplaquetario para prevenir coágulos.', 1),
('Atorvastatina', 'Ninguna', 'Anticolesterol.', 1),
('Levotiroxina', 'Ninguna', 'Hormona tiroidea para hipotiroidismo.', 1),
('Venlafaxina', 'Ninguna', 'Antidepresivo SNRI.', 1),
('Lisinopril', 'Ninguna', 'Antihipertensivo inhibidor de la ECA.', 1),
('Alprazolam', 'Ninguna', 'Ansiolítico de acción corta.', 1),
('Gliclazida', 'Ninguna', 'Antidiabético oral.', 1),
('Ranitidina', 'Ninguna', 'Antihistamínico H2 para acidez.', 1),
('Diltiazem', 'Ninguna', 'Antihipertensivo bloqueador de calcio.', 1),
('Tamsulosina', 'Ninguna', 'Medicamento para hiperplasia prostática benigna.', 1),
('Glucosamina', 'Ninguna', 'Suplemento para la salud articular.', 1),
('Ácido Acetilsalicílico', 'Ninguna', 'Antiinflamatorio y antipirético.', 1),
('Etoricoxib', 'Ninguna', 'Antiinflamatorio COX-2 selectivo.', 1),
('Esomeprazol', 'Ninguna', 'Inhibidor de bomba de protones.', 1),
('Pregabalina', 'Ninguna', 'Anticonvulsivo y analgésico neuropático.', 1),
('Dapagliflozina', 'Ninguna', 'Antidiabético SGLT2.', 1),
('Hydrochlorothiazide', 'Ninguna', 'Diurético tiazídico.', 1),
('Metronidazol', 'Ninguna', 'Antibiótico y antiparasitario.', 1),
('Nitroglicerina', 'Ninguna', 'Vasodilatador para angina.', 1),
('Amiodarona', 'Ninguna', 'Antiarritmico.', 1),
('Acarbosa', 'Ninguna', 'Antidiabético inhibidor de alfa-glucosidasa.', 1),
('Buspirona', 'Ninguna', 'Ansiolítico no benzodiazepínico.', 1),
('Lactulosa', 'Ninguna', 'Laxante osmótico.', 1),
('Acetaminofén', 'Ninguna', 'Analgesico y antipirético.', 1),
('Fluoxetina', 'Ninguna', 'Antidepresivo ISRS.', 1),
('Roxitromicina', 'Ninguna', 'Antibiótico macrólido.', 1),
('Fluticasona', 'Ninguna', 'Corticoide inhalado.', 1),
('Ketorolaco', 'Ninguna', 'Analgésico antiinflamatorio.', 1),
('Carbamazepina', 'Ninguna', 'Anticonvulsivo.', 1),
('Dexametasona', 'Ninguna', 'Corticoide.', 1),
('Tetraciclina', 'Ninguna', 'Antibiótico de amplio espectro.', 1),
('Fentolamina', 'Ninguna', 'Antagonista adrenérgico.', 1),
('Terbinafina', 'Ninguna', 'Antifúngico.', 1),
('Clonazepam', 'Ninguna', 'Ansiolítico.', 1);





select * from MEDICAMENTO


INSERT INTO TRATAMIENTO (IDTRATAMIENTO, NOMBREMED, NOMBRETR, FECHAINI, FECHAFIN, DESCTRA, SUJETOTRA, ESTADO)
VALUES
('T0000001', 'Paracetamol', 'Tratamiento para fiebre', '2024-10-02', '2024-10-09', 'Administrar paracetamol para controlar la fiebre.', 'Paciente con fiebre y tos', 1),
('T0000002', 'Ibuprofeno', 'Tratamiento para dolor', '2024-10-02', '2024-10-09', 'Administrar ibuprofeno cada 8 horas.', 'Paciente con dolor de cabeza', 1),
('T0000003', 'Amoxicilina', 'Tratamiento antibiótico', '2024-10-02', '2024-10-16', 'Administrar amoxicilina 500 mg cada 12 horas.', 'Paciente con infección', 1),
('T0000004', 'Loratadina', 'Tratamiento para alergias', '2024-10-02', '2024-10-09', 'Tomar loratadina 10 mg una vez al día.', 'Paciente con picazón y erupción', 1),
('T0000005', 'Omeprazol', 'Tratamiento para acidez', '2024-10-02', '2024-10-16', 'Administrar omeprazol 20 mg cada mañana.', 'Paciente con dolor en el abdomen', 1),
('T0000006', 'Metformina', 'Tratamiento para diabetes', '2024-10-02', '2024-10-09', 'Tomar metformina 500 mg dos veces al día.', 'Paciente con diabetes', 1),
('T0000007', 'Aspirina', 'Tratamiento para inflamación', '2024-10-02', '2024-10-09', 'Administrar aspirina 81 mg diariamente.', 'Paciente con palpitaciones', 1),
('T0000008', 'Simvastatina', 'Tratamiento para colesterol', '2024-10-02', '2024-10-16', 'Tomar simvastatina 10 mg cada noche.', 'Paciente con niveles altos de colesterol', 1),
('T0000009', 'Ciprofloxacino', 'Tratamiento antibiótico', '2024-10-02', '2024-10-09', 'Administrar ciprofloxacino 500 mg cada 12 horas.', 'Paciente con infección urinaria', 1),
('T0000010', 'Salbutamol', 'Tratamiento para asma', '2024-10-02', '2024-10-09', 'Administrar salbutamol en aerosol según necesidad.', 'Paciente con dificultad para respirar', 1),
('T0000011', 'Prednisona', 'Tratamiento antiinflamatorio', '2024-10-02', '2024-10-16', 'Tomar prednisona 20 mg diariamente.', 'Paciente con depresión y ansiedad', 1),
('T0000012', 'Furosemida', 'Tratamiento diurético', '2024-10-02', '2024-10-09', 'Administrar furosemida 40 mg cada mañana.', 'Paciente con edema', 1),
('T0000013', 'Sertralina', 'Tratamiento antidepresivo', '2024-10-02', '2024-10-16', 'Tomar sertralina 50 mg diariamente.', 'Paciente con depresión', 1),
('T0000014', 'Citalopram', 'Tratamiento antidepresivo', '2024-10-02', '2024-10-16', 'Tomar citalopram 20 mg diariamente.', 'Paciente con ansiedad', 1);


select * from TRATAMIENTO





INSERT INTO ENFERMEDAD (NOMBREENF, CAUSASENF, COMPLICACIONESENF, SINTOMASENF, GRAVEDADENF, ESTADO)
VALUES
('Gripe', 'Virus de la influenza', 'Neumonía, bronquitis', 'Fiebre, tos, dolor muscular', 'Leve', 1),
('Diabetes Tipo 2', 'Resistencia a la insulina, obesidad', 'Problemas cardíacos, daño renal', 'Sed excesiva, fatiga, visión borrosa', 'Moderada', 1),
('Asma', 'Alergias, contaminación del aire', 'Dificultad respiratoria grave', 'Silbido al respirar, tos', 'Moderada', 1),
('Hipertensión', 'Dieta alta en sodio, falta de ejercicio', 'Accidente cerebrovascular, insuficiencia cardíaca', 'Dolores de cabeza, visión borrosa', 'Moderada', 1),
('Artritis', 'Inflamación de las articulaciones', 'Daño articular permanente', 'Dolor, rigidez, hinchazón', 'Moderada', 1),
('EPOC', 'Fumar, exposición a irritantes pulmonares', 'Infecciones respiratorias, insuficiencia respiratoria', 'Tos crónica, dificultad para respirar', 'Severa', 1),
('Cáncer de mama', 'Factores genéticos, exposición a radiación', 'Metástasis a otros órganos', 'Bulto en el seno, cambio en la forma del seno', 'Severa', 1),
('Depresión', 'Factores biológicos y ambientales', 'Suicidio, trastornos de ansiedad', 'Tristeza, pérdida de interés', 'Moderada', 1),
('Ansiedad', 'Estrés, predisposición genética', 'Trastornos de pánico, depresión', 'Inquietud, palpitaciones', 'Moderada', 1),
('Acidez estomacal', 'Dieta, obesidad, hernia hiatal', 'Esófago inflamado, úlceras', 'Ardor en el pecho, regurgitación', 'Leve', 1),
('Enfermedad de Alzheimer', 'Edad avanzada, factores genéticos', 'Pérdida de la independencia, demencia', 'Pérdida de memoria, confusión', 'Severa', 1),
('Migraña', 'Factores genéticos, estrés', 'Ataques recurrentes, problemas de visión', 'Dolor intenso, náuseas', 'Moderada', 1),
('Infección urinaria', 'Bacterias, falta de higiene', 'Infecciones renales', 'Dolor al orinar, necesidad frecuente de orinar', 'Leve', 1),
('Osteoporosis', 'Envejecimiento, falta de calcio', 'Fracturas, deformidades óseas', 'Dolor en los huesos', 'Moderada', 1),
('Alergias estacionales', 'Pólenes, polvo', 'Asma, sinusitis', 'Estornudos, picazón en los ojos', 'Leve', 1),
('Cáncer de pulmón', 'Fumar, exposición a carcinógenos', 'Metástasis, insuficiencia respiratoria', 'Tos persistente, pérdida de peso', 'Severa', 1),
('Hepatitis', 'Virus, consumo excesivo de alcohol', 'Cirrhosis, cáncer de hígado', 'Fatiga, ictericia', 'Severa', 1),
('Insuficiencia cardíaca', 'Hipertensión, enfermedades del corazón', 'Paro cardíaco, edema', 'Dificultad para respirar, fatiga', 'Severa', 1),
('Esclerosis múltiple', 'Factores autoinmunitarios', 'Parálisis, problemas cognitivos', 'Fatiga, problemas de equilibrio', 'Severa', 1),
('Enfermedad celíaca', 'Intolerancia al gluten', 'Desnutrición, cáncer intestinal', 'Diarrea, pérdida de peso', 'Moderada', 1);






select * FROM MEDICAMENTO;




INSERT INTO DIAGNOSTICO (IDDIAGNOSTICO, IDCONSULTA, NOMBREENF, IDTRATAMIENTO, ESTADO)
VALUES
('D0000001', 'C0000001', 'Gripe', 'T0000001', 1),
('D0000002', 'C0000002', 'Diabetes Tipo 2', 'T0000002', 1),
('D0000003', 'C0000003', 'Asma', 'T0000003', 1),
('D0000004', 'C0000004', 'Hipertensión', 'T0000004', 1),
('D0000005', 'C0000005', 'Artritis', 'T0000005', 1),
('D0000006', 'C0000006', 'EPOC', 'T0000006', 1),
('D0000007', 'C0000007', 'Cáncer de mama', 'T0000007', 1),
('D0000008', 'C0000008', 'Depresión', 'T0000008', 1),
('D0000009', 'C0000009', 'Ansiedad', 'T0000009', 1),
('D0000010', 'C0000010', 'Acidez estomacal', 'T0000010', 1),
('D0000011', 'C0000011', 'Enfermedad de Alzheimer', 'T0000011', 1),


('D0000012', 'C0000012', 'Migraña', 'T0000012', 1),
('D0000013', 'C0000013', 'Infección urinaria', 'T0000009', 1),
('D0000014', 'C0000014', 'Osteoporosis', 'T0000013', 1),
('D0000015', 'C0000015', 'Alergias estacionales', 'T0000004', 1),
('D0000016', 'C0000016', 'Cáncer de pulmón', 'T0000007', 1),
('D0000017', 'C0000017', 'Hepatitis', 'T0000011', 1),
('D0000018', 'C0000018', 'Insuficiencia cardíaca', 'T0000012', 1),
('D0000019', 'C0000019', 'Esclerosis múltiple', 'T0000014', 1),
('D0000020', 'C0000020', 'Enfermedad celíaca', 'T0000013', 1),
('D0000021', 'C0000021', 'Gripe', 'T0000001', 1),
('D0000022', 'C0000022', 'Diabetes Tipo 2', 'T0000002', 1),
('D0000023', 'C0000023', 'Asma', 'T0000010', 1),
('D0000024', 'C0000024', 'Hipertensión', 'T0000006', 1),
('D0000025', 'C0000025', 'Artritis', 'T0000005', 1),
('D0000026', 'C0000026', 'EPOC', 'T0000008', 1),
('D0000027', 'C0000027', 'Cáncer de mama', 'T0000007', 1),
('D0000028', 'C0000028', 'Depresión', 'T0000013', 1),
('D0000029', 'C0000029', 'Ansiedad', 'T0000014', 1),
('D0000030', 'C0000030', 'Acidez estomacal', 'T0000005', 1),
('D0000031', 'C0000031', 'Migraña', 'T0000012', 1),
('D0000032', 'C0000032', 'Infección urinaria', 'T0000009', 1),
('D0000033', 'C0000033', 'Osteoporosis', 'T0000013', 1),
('D0000034', 'C0000034', 'Alergias estacionales', 'T0000004', 1),
('D0000035', 'C0000035', 'Cáncer de pulmón', 'T0000007', 1),
('D0000036', 'C0000036', 'Hepatitis', 'T0000011', 1),
('D0000037', 'C0000037', 'Insuficiencia cardíaca', 'T0000012', 1),
('D0000038', 'C0000038', 'Esclerosis múltiple', 'T0000014', 1),
('D0000039', 'C0000039', 'Enfermedad celíaca', 'T0000013', 1),
('D0000040', 'C0000040', 'Gripe', 'T0000001', 1),
('D0000041', 'C0000041', 'Diabetes Tipo 2', 'T0000002', 1),
('D0000042', 'C0000042', 'Asma', 'T0000010', 1),
('D0000043', 'C0000043', 'Hipertensión', 'T0000006', 1),
('D0000044', 'C0000044', 'Artritis', 'T0000005', 1),
('D0000045', 'C0000045', 'EPOC', 'T0000008', 1),
('D0000046', 'C0000046', 'Cáncer de mama', 'T0000007', 1),
('D0000047', 'C0000047', 'Depresión', 'T0000013', 1),
('D0000048', 'C0000048', 'Ansiedad', 'T0000014', 1),
('D0000049', 'C0000049', 'Acidez estomacal', 'T0000005', 1),
('D0000050', 'C0000050', 'Migraña', 'T0000012', 1);


select * from DIAGNOSTICO;


-- INSERTANDO REGISTROS EN DTDIAGNOSTICO
INSERT INTO DTDIAGNOSTICO (IDDIAGNOSTICO, DESCRIPCION, EXAMENESAD, FECHAHORADIAGNOSTICO, INFECCION, RESFRIO, ESTADO)
VALUES
('D0000001', 'Paciente presenta síntomas de fiebre alta, tos seca y malestar general. Diagnóstico de gripe.', 'Exámenes de sangre, PCR para virus respiratorio.', GETDATE(), 'Infección viral', 'No', 1),
('D0000002', 'Diagnóstico de Diabetes Tipo 2. Paciente con antecedentes familiares y niveles de glucosa elevados.', 'Pruebas de glucosa en ayunas, hemoglobina A1c.', GETDATE(), 'No', 'No', 1),
('D0000003', 'Diagnóstico de asma. Paciente reporta episodios de sibilancias y dificultad respiratoria al realizar ejercicio.', 'Espirometría, pruebas de alérgenos.', GETDATE(), 'No', 'No', 1),
('D0000004', 'Paciente con hipertensión arterial diagnosticada, bajo tratamiento antihipertensivo.', 'Monitoreo de presión arterial, análisis de electrolitos.', GETDATE(), 'No', 'No', 1),
('D0000005', 'Diagnóstico de artritis reumatoide, inflamación en articulaciones de manos y pies.', 'Radiografías, análisis de factor reumatoide.', GETDATE(), 'No', 'No', 1),
('D0000006', 'Diagnóstico de EPOC. Paciente con historial de tabaquismo y dificultad respiratoria crónica.', 'Espirometría, tomografía computarizada de tórax.', GETDATE(), 'No', 'No', 1),
('D0000007', 'Diagnóstico de cáncer de mama en estadio inicial. Paciente con bultos detectados en mamografía.', 'Mamografía, biopsia del tumor.', GETDATE(), 'No', 'No', 1),
('D0000008', 'Diagnóstico de depresión moderada. Paciente presenta tristeza persistente y falta de interés.', 'Evaluación psicológica, escalas de depresión.', GETDATE(), 'No', 'No', 1),
('D0000009', 'Diagnóstico de ansiedad generalizada. Paciente reporta preocupación excesiva y dificultades para dormir.', 'Entrevista clínica, escalas de ansiedad.', GETDATE(), 'No', 'No', 1),
('D0000010', 'Diagnóstico de acidez estomacal, paciente con ardor retroesternal después de las comidas.', 'Endoscopia digestiva alta, pruebas de pH.', GETDATE(), 'No', 'No', 1),
('D0000011', 'Diagnóstico de enfermedad de Alzheimer, seguimiento de síntomas cognitivos y de memoria.', 'Evaluación neuropsicológica, resonancia magnética.', GETDATE(), 'No', 'No', 1),


('D0000012', 'Paciente con migraña recurrente, presenta dolor de cabeza intenso y sensibilidad a la luz.', 'Examen neurológico, tomografía.', GETDATE(), 'No', 'No', 1),
('D0000013', 'Diagnóstico de infección urinaria, paciente reporta dolor al orinar y necesidad frecuente de orinar.', 'Cultivo de orina.', GETDATE(), 'Bacteriana', 'No', 1),
('D0000014', 'Paciente con osteoporosis, reporta dolor óseo y antecedentes de fracturas.', 'Densitometría ósea.', GETDATE(), 'No', 'No', 1),
('D0000015', 'Diagnóstico de alergias estacionales, presenta estornudos y picazón en los ojos.', 'Pruebas de alergias.', GETDATE(), 'No', 'No', 1),
('D0000016', 'Paciente diagnosticado con cáncer de pulmón, presenta tos persistente y pérdida de peso.', 'Biopsia pulmonar, tomografía de tórax.', GETDATE(), 'No', 'No', 1),
('D0000017', 'Diagnóstico de hepatitis, paciente con ictericia y dolor abdominal.', 'Pruebas hepáticas, ultrasonido abdominal.', GETDATE(), 'Viral', 'No', 1),
('D0000018', 'Paciente con insuficiencia cardíaca, reporta fatiga extrema y dificultad para respirar.', 'Ecocardiograma, análisis de BNP.', GETDATE(), 'No', 'No', 1),
('D0000019', 'Diagnóstico de esclerosis múltiple, presenta problemas de equilibrio y fatiga crónica.', 'Resonancia magnética, punción lumbar.', GETDATE(), 'No', 'No', 1),
('D0000020', 'Diagnóstico de enfermedad celíaca, presenta diarrea crónica y pérdida de peso.', 'Pruebas serológicas para gluten.', GETDATE(), 'No', 'No', 1),
('D0000021', 'Paciente con síntomas de gripe, presenta fiebre y dolor muscular.', 'Pruebas rápidas para virus respiratorio.', GETDATE(), 'Infección viral', 'Sí', 1),
('D0000022', 'Paciente con diabetes tipo 2, reporta niveles altos de glucosa en sangre.', 'Hemoglobina A1c, curva de tolerancia a la glucosa.', GETDATE(), 'No', 'No', 1),
('D0000023', 'Diagnóstico de asma, reporta dificultad para respirar y episodios de sibilancias.', 'Espirometría, pruebas de alergias.', GETDATE(), 'No', 'No', 1),
('D0000024', 'Paciente con hipertensión arterial, presenta dolor de cabeza recurrente.', 'Monitoreo de presión arterial, electrocardiograma.', GETDATE(), 'No', 'No', 1),
('D0000025', 'Diagnóstico de artritis reumatoide, paciente presenta dolor articular y rigidez.', 'Radiografías de manos y pies.', GETDATE(), 'No', 'No', 1),
('D0000026', 'Paciente con EPOC, reporta dificultad respiratoria crónica y tos productiva.', 'Pruebas de función pulmonar.', GETDATE(), 'No', 'No', 1),
('D0000027', 'Paciente diagnosticado con cáncer de mama, bultos detectados en mamografía.', 'Mamografía, biopsia.', GETDATE(), 'No', 'No', 1),
('D0000028', 'Paciente con depresión moderada, reporta pérdida de interés en actividades diarias.', 'Evaluación psicológica, escalas de depresión.', GETDATE(), 'No', 'No', 1),
('D0000029', 'Diagnóstico de ansiedad generalizada, reporta preocupación excesiva y dificultad para dormir.', 'Entrevista clínica, pruebas de ansiedad.', GETDATE(), 'No', 'No', 1),
('D0000030', 'Paciente con acidez estomacal, reporta ardor retroesternal después de las comidas.', 'Endoscopia digestiva alta.', GETDATE(), 'No', 'No', 1),
('D0000031', 'Paciente con migraña crónica, reporta dolor intenso y náuseas.', 'Examen neurológico.', GETDATE(), 'No', 'No', 1),
('D0000032', 'Diagnóstico de infección urinaria, presenta fiebre y dolor en la región lumbar.', 'Cultivo de orina, análisis de sangre.', GETDATE(), 'Bacteriana', 'No', 1),
('D0000033', 'Paciente con osteoporosis, reporta pérdida de altura y dolor en la espalda.', 'Radiografías, densitometría ósea.', GETDATE(), 'No', 'No', 1),
('D0000034', 'Diagnóstico de alergias estacionales, presenta congestión nasal y picazón en los ojos.', 'Pruebas cutáneas para alérgenos.', GETDATE(), 'No', 'No', 1),
('D0000035', 'Paciente diagnosticado con cáncer de pulmón, reporta dolor torácico y disnea.', 'Tomografía de tórax.', GETDATE(), 'No', 'No', 1),
('D0000036', 'Diagnóstico de hepatitis, paciente con síntomas de fatiga extrema y pérdida de apetito.', 'Pruebas de función hepática.', GETDATE(), 'Viral', 'No', 1),
('D0000037', 'Paciente con insuficiencia cardíaca, reporta edemas en las piernas y fatiga severa.', 'Ecocardiograma.', GETDATE(), 'No', 'No', 1),
('D0000038', 'Paciente con esclerosis múltiple, presenta visión borrosa y debilidad en extremidades.', 'Resonancia magnética.', GETDATE(), 'No', 'No', 1),
('D0000039', 'Diagnóstico de enfermedad celíaca, reporta hinchazón abdominal tras consumir gluten.', 'Pruebas de anticuerpos.', GETDATE(), 'No', 'No', 1),
('D0000040', 'Paciente con gripe, reporta congestión nasal y dolor de cabeza.', 'Pruebas rápidas.', GETDATE(), 'Infección viral', 'Sí', 1),
('D0000041', 'Diagnóstico de diabetes tipo 2, paciente con visión borrosa y fatiga extrema.', 'Pruebas de glucosa en ayunas.', GETDATE(), 'No', 'No', 1),
('D0000042', 'Paciente con asma, presenta dificultad para respirar al realizar ejercicio.', 'Pruebas de función pulmonar.', GETDATE(), 'No', 'No', 1),
('D0000043', 'Paciente con hipertensión, reporta mareos frecuentes.', 'Monitoreo de presión arterial.', GETDATE(), 'No', 'No', 1),
('D0000044', 'Diagnóstico de artritis, paciente con inflamación en las articulaciones de las manos.', 'Pruebas de sangre.', GETDATE(), 'No', 'No', 1),
('D0000045', 'Paciente con EPOC, reporta sibilancias y dificultad para respirar.', 'Espirometría avanzada.', GETDATE(), 'No', 'No', 1),
('D0000046', 'Diagnóstico de cáncer de mama, presenta secreción anormal del pezón.', 'Mamografía.', GETDATE(), 'No', 'No', 1),
('D0000047', 'Paciente con depresión severa, reporta insomnio y pérdida de peso.', 'Evaluación psiquiátrica.', GETDATE(), 'No', 'No', 1),
('D0000048', 'Diagnóstico de ansiedad, reporta hiperventilación y sensación de ahogo.', 'Pruebas psicológicas.', GETDATE(), 'No', 'No', 1),
('D0000049', 'Paciente con acidez estomacal crónica, reporta ardor severo.', 'Endoscopia.', GETDATE(), 'No', 'No', 1),
('D0000050', 'Paciente con migraña, reporta episodios recurrentes.', 'Evaluación neurológica.', GETDATE(), 'No', 'No', 1);




select * from DTDIAGNOSTICO




INSERT INTO EXAMENES (TIPOEXAMENES, FECHAHORA, NOMBREP, NOMBREM, NOMBRELAB, ESTADO) VALUES
('Análisis de sangre', '2024-10-01 10:00:00', 'Juan Pérez', 'Dr. López', 'Laboratorio A', 1),
('Radiografía de tórax', '2024-10-01 10:30:00', 'María González', 'Dr. Torres', 'Laboratorio B', 1),
('Ultrasonido abdominal', '2024-10-01 11:00:00', 'Carlos Méndez', 'Dra. Sánchez', 'Laboratorio C', 1),
('Electrocardiograma', '2024-10-01 11:30:00', 'Ana Martínez', 'Dr. Ramírez', 'Laboratorio D', 1),
('Prueba de glucosa', '2024-10-01 12:00:00', 'Luis Fernández', 'Dr. Romero', 'Laboratorio A', 1),
('TAC de cabeza', '2024-10-01 12:30:00', 'Sofía Jiménez', 'Dra. Ruiz', 'Laboratorio B', 1),
('Biopsia de piel', '2024-10-01 13:00:00', 'Pedro Díaz', 'Dr. Castro', 'Laboratorio C', 1),
('Análisis de orina', '2024-10-01 13:30:00', 'Laura Torres', 'Dr. Vargas', 'Laboratorio D', 1),
('Examen de colesterol', '2024-10-01 14:00:00', 'Gabriel López', 'Dra. Herrera', 'Laboratorio A', 1),
('Prueba de embarazo', '2024-10-01 14:30:00', 'Claudia Silva', 'Dr. Peña', 'Laboratorio B', 1),
('Cultivo de esputo', '2024-10-01 15:00:00', 'Javier Castillo', 'Dr. Salas', 'Laboratorio C', 1),
('Ecografía obstétrica', '2024-10-01 15:30:00', 'Patricia Rojas', 'Dra. Morales', 'Laboratorio D', 1),
('Examen de sangre oculta en heces', '2024-10-01 16:00:00', 'Martín Romero', 'Dr. Torres', 'Laboratorio A', 1),
('Prueba de función pulmonar', '2024-10-01 16:30:00', 'Nadia Vega', 'Dr. López', 'Laboratorio B', 1),
('Resonancia magnética', '2024-10-01 17:00:00', 'Samuel Castillo', 'Dra. Ruiz', 'Laboratorio C', 1),
('Papanicolau', '2024-10-01 17:30:00', 'Teresa Salazar', 'Dr. Ramírez', 'Laboratorio D', 1),
('Examen de tiroides', '2024-10-01 18:00:00', 'Fernando Pérez', 'Dra. Herrera', 'Laboratorio A', 1),
('Electromiograma', '2024-10-01 18:30:00', 'Valeria Castro', 'Dr. Vargas', 'Laboratorio B', 1),
('Test de alergias', '2024-10-01 19:00:00', 'Cristian Díaz', 'Dr. Romero', 'Laboratorio C', 1),
('Mediación de sangre', '2024-10-01 19:30:00', 'Santiago López', 'Dra. Morales', 'Laboratorio D', 1);



INSERT INTO ORDENA (IDCONSULTA, TIPOEXAMENES) VALUES

('C0000001', 'Análisis de sangre'),
('C0000002', 'Radiografía de tórax'),
('C0000003', 'Ultrasonido abdominal'),
('C0000004', 'Electrocardiograma'),
('C0000005', 'Prueba de glucosa'),
('C0000006', 'TAC de cabeza'),
('C0000007', 'Biopsia de piel'),
('C0000008', 'Análisis de orina'),
('C0000009', 'Examen de colesterol'),
('C0000010', 'Prueba de embarazo'),
('C0000011', 'Cultivo de esputo'),
('C0000012', 'Ecografía obstétrica'),
('C0000013', 'Examen de sangre oculta en heces'),
('C0000014', 'Prueba de función pulmonar'),
('C0000015', 'Resonancia magnética'),
('C0000016', 'Papanicolau'),
('C0000017', 'Examen de tiroides'),
('C0000018', 'Electromiograma'),
('C0000019', 'Test de alergias'),
('C0000020', 'Mediación de sangre');