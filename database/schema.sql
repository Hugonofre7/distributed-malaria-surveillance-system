-- =========================================
-- BASE DE DATOS: PALUDISMO
-- =========================================

CREATE DATABASE IF NOT EXISTS paludismo_db;
USE paludismo_db;

-- =========================================
-- TABLA: LOCALIDAD
-- =========================================

CREATE TABLE localidad (
    id_localidad INT AUTO_INCREMENT PRIMARY KEY,
    nombre_localidad VARCHAR(100) NOT NULL,
    municipio VARCHAR(100) NOT NULL,
    estado VARCHAR(100) NOT NULL,
    zona_riesgo ENUM('ALTA', 'MEDIA', 'BAJA') NOT NULL,
    UNIQUE (nombre_localidad, municipio, estado)
);

-- =========================================
-- TABLA: VIVIENDA
-- =========================================

CREATE TABLE vivienda (
    id_vivienda INT AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(150) NOT NULL,
    tipo_vivienda VARCHAR(50),
    condicion_sanitaria VARCHAR(100),
    id_localidad INT NOT NULL,
    FOREIGN KEY (id_localidad) REFERENCES localidad(id_localidad)
);

-- =========================================
-- TABLA: PACIENTE
-- =========================================

CREATE TABLE paciente (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    edad INT,
    sexo ENUM('M', 'F') NOT NULL,
    curp VARCHAR(18),
    id_vivienda INT NOT NULL,
    UNIQUE (curp),
    FOREIGN KEY (id_vivienda) REFERENCES vivienda(id_vivienda)
);

-- =========================================
-- TABLA: CASO
-- =========================================

CREATE TABLE caso (
    id_caso INT AUTO_INCREMENT PRIMARY KEY,
    fecha_diagnostico DATE NOT NULL,
    tipo_caso ENUM('SOSPECHOSO', 'CONFIRMADO') NOT NULL,
    clasificacion ENUM('IMPORTADO', 'AUTOCTONO') NOT NULL,
    estatus ENUM('ACTIVO', 'CERRADO') NOT NULL,
    id_paciente INT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente)
);

-- =========================================
-- TABLA: LABORATORIO
-- =========================================

CREATE TABLE laboratorio (
    id_laboratorio INT AUTO_INCREMENT PRIMARY KEY,
    tipo_prueba ENUM('GOTA_GRUESA', 'PRUEBA_RAPIDA') NOT NULL,
    resultado ENUM('POSITIVO', 'NEGATIVO') NOT NULL,
    fecha_prueba DATE NOT NULL,
    id_caso INT NOT NULL,
    FOREIGN KEY (id_caso) REFERENCES caso(id_caso)
);

-- =========================================
-- TABLA: BRIGADA
-- =========================================

CREATE TABLE brigada (
    id_brigada INT AUTO_INCREMENT PRIMARY KEY,
    nombre_brigada VARCHAR(100) NOT NULL,
    responsable VARCHAR(100),
    zona_asignada VARCHAR(100),
    UNIQUE (nombre_brigada)
);

-- =========================================
-- TABLA: INTERVENCION
-- =========================================

CREATE TABLE intervencion (
    id_intervencion INT AUTO_INCREMENT PRIMARY KEY,
    tipo_intervencion ENUM('FUMIGACION', 'LARVICIDA', 'CONTROL_FISICO') NOT NULL,
    fecha DATE NOT NULL,
    observaciones TEXT,
    id_brigada INT NOT NULL,
    id_vivienda INT NOT NULL,
    FOREIGN KEY (id_brigada) REFERENCES brigada(id_brigada),
    FOREIGN KEY (id_vivienda) REFERENCES vivienda(id_vivienda)
);

-- =========================================
-- INSERTS DE PRUEBA
-- =========================================

INSERT INTO localidad (nombre_localidad, municipio, estado, zona_riesgo)
VALUES ('Chilpancingo Centro', 'Chilpancingo', 'Guerrero', 'MEDIA');

INSERT INTO vivienda (direccion, tipo_vivienda, condicion_sanitaria, id_localidad)
VALUES ('Calle 123, Col Centro', 'Casa', 'Buena', 1);

INSERT INTO paciente (nombre, edad, sexo, curp, id_vivienda)
VALUES ('Juan Perez', 30, 'M', 'PEPJ900101HGRXXX01', 1);

INSERT INTO caso (fecha_diagnostico, tipo_caso, clasificacion, estatus, id_paciente)
VALUES ('2026-03-23', 'CONFIRMADO', 'AUTOCTONO', 'ACTIVO', 1);

INSERT INTO laboratorio (tipo_prueba, resultado, fecha_prueba, id_caso)
VALUES ('GOTA_GRUESA', 'POSITIVO', '2026-03-23', 1);

INSERT INTO brigada (nombre_brigada, responsable, zona_asignada)
VALUES ('Brigada Centro', 'Carlos Lopez', 'Zona Centro');

INSERT INTO intervencion (tipo_intervencion, fecha, observaciones, id_brigada, id_vivienda)
VALUES ('FUMIGACION', '2026-03-24', 'Se fumigó correctamente la vivienda', 1, 1);