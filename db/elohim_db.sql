-- ============================================================
--  Inversiones Elohim, S.A. — Esquema PostgreSQL
--  Refactor: tabla Usuario unificada con perfiles por tipo
-- ============================================================

-- DROP DATABASE IF EXISTS elohim_db;
-- DROP ROLE IF EXISTS elohim_user;

-- CREATE ROLE elohim_user WITH LOGIN PASSWORD 'ElohimS3cur3!';
-- CREATE DATABASE elohim_db WITH OWNER = elohim_user ENCODING = 'UTF8';

-- \c elohim_db

-- ------------------------------------------------------------
-- Tablas maestras de catálogo
-- ------------------------------------------------------------
CREATE TABLE Marca (
    id           VARCHAR(255) PRIMARY KEY,
    nombre_marca VARCHAR(15)  NOT NULL,
    descripcion  TEXT
);

CREATE TABLE Categoria (
    id               VARCHAR(255) PRIMARY KEY,
    nombre_categoria VARCHAR(15)  NOT NULL,
    descripcion      TEXT,
    fecha_creacion   TIMESTAMP    NOT NULL DEFAULT NOW()
);

CREATE TABLE MetodoPago (
    id_metodo_pago VARCHAR(255) PRIMARY KEY,
    nombre_metodo  VARCHAR(15)  NOT NULL,
    descripcion    TEXT,
    activo         BOOLEAN      NOT NULL
);

-- ------------------------------------------------------------
-- Usuarios unificados
-- Tipo de usuario determina a qué tabla de perfil se enlaza
-- ------------------------------------------------------------
CREATE TABLE Usuario (
    id             VARCHAR(255) PRIMARY KEY,
    correo         VARCHAR(100) NOT NULL UNIQUE,
    nombre         VARCHAR(30)  NOT NULL,
    apellido       VARCHAR(30),
    telefono       VARCHAR(30),
    contrasena     VARCHAR(255) NOT NULL,
    tipo_usuario   VARCHAR(20)  NOT NULL
    CHECK (tipo_usuario IN ('cliente', 'administrador')),
    estado         BOOLEAN      NOT NULL DEFAULT TRUE,
    fecha_creacion TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- Datos extendidos para clientes
-- tipo_cliente: mayorista | minorista | particular
CREATE TABLE ClientePerfil (
    usuario_id   VARCHAR(255) PRIMARY KEY REFERENCES Usuario (id) ON DELETE CASCADE,
    direccion    TEXT,
    tipo_cliente VARCHAR(20)  NOT NULL
    CHECK (tipo_cliente IN ('mayorista', 'minorista', 'particular'))
);

-- Datos extendidos para personal interno
-- rol: cajero | administrador
CREATE TABLE AdministradorPerfil (
    usuario_id VARCHAR(255) PRIMARY KEY REFERENCES Usuario (id) ON DELETE CASCADE,
    rol        VARCHAR(20)  NOT NULL
    CHECK (rol IN ('cajero', 'administrador'))
);

-- ------------------------------------------------------------
-- Consultas (cliente ↔ administrador)
-- ------------------------------------------------------------
CREATE TABLE Consulta (
    id_consulta    VARCHAR(255) PRIMARY KEY,
    id_cliente     VARCHAR(255) NOT NULL REFERENCES Usuario (id),
    id_usuario     VARCHAR(255) NOT NULL REFERENCES Usuario (id),
    fecha_consulta TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- ------------------------------------------------------------
-- Catálogo de productos
-- ------------------------------------------------------------
CREATE TABLE Producto (
    id_producto         VARCHAR(255) PRIMARY KEY,
    codigo_producto     VARCHAR(100) NOT NULL UNIQUE,
    nombre_producto     VARCHAR(100) NOT NULL,
    descripcion         TEXT,
    precio              INTEGER      NOT NULL CHECK (precio > 0),
    stock_actual        INTEGER      NOT NULL CHECK (stock_actual >= 0),
    id_marca            VARCHAR(255) REFERENCES Marca     (id),
    categoria_id        VARCHAR(255) REFERENCES Categoria (id),
    fecha_vencimiento   TIMESTAMP    NOT NULL,
    imagen_principal    TEXT,
    fecha_creacion      TIMESTAMP    NOT NULL DEFAULT NOW(),
    fecha_actualizacion TIMESTAMP    NOT NULL DEFAULT NOW()
);

-- ------------------------------------------------------------
-- Transacciones
-- ------------------------------------------------------------
CREATE TABLE Reservacion (
    id_reservacion      VARCHAR(255) PRIMARY KEY,
    codigo_reservacion  VARCHAR(60)  NOT NULL UNIQUE,
    cliente_id          VARCHAR(255) NOT NULL REFERENCES Usuario (id),
    fecha_renovacion    TIMESTAMP    NOT NULL DEFAULT NOW(),
    estado_renovacion   VARCHAR(60)  NOT NULL DEFAULT 'pendiente',
    total_renovacion    NUMERIC,
    metodo_pago_id      VARCHAR(255) REFERENCES MetodoPago (id_metodo_pago),
    pagado              BOOLEAN      NOT NULL DEFAULT FALSE,
    observaciones       TEXT,
    fecha_limite_retiro TIMESTAMP    NOT NULL
);

CREATE TABLE DetalleReservacion (
    id_details      VARCHAR(255) PRIMARY KEY,
    reservacion_id  VARCHAR(255) NOT NULL REFERENCES Reservacion (id_reservacion) ON DELETE CASCADE,
    producto_id     VARCHAR(255) NOT NULL REFERENCES Producto    (id_producto),
    cantidad        INTEGER      NOT NULL CHECK (cantidad > 0),
    precio_unitario NUMERIC      NOT NULL CHECK (precio_unitario > 0),
    subtotal        NUMERIC      GENERATED ALWAYS AS (cantidad * precio_unitario) STORED
);

CREATE TABLE Venta (
    id_venta          VARCHAR(255) PRIMARY KEY,
    reservacion_id    VARCHAR(255) UNIQUE NOT NULL REFERENCES Reservacion (id_reservacion),
    monto_total       NUMERIC      NOT NULL,
    usuario_cajero_id VARCHAR(255) NOT NULL REFERENCES Usuario     (id),
    fecha_venta       TIMESTAMP    NOT NULL DEFAULT NOW(),
    tipo_comprobante  VARCHAR(255) NOT NULL,
    estado_venta      VARCHAR(255) NOT NULL
);