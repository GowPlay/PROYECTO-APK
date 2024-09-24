CREATE DATABASE db_Restaurante;

USE db_Restaurante;

CREATE TABLE Roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255)
);

CREATE TABLE Usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    rol_id INT,
    FOREIGN KEY (rol_id) REFERENCES Roles(id)
);

CREATE TABLE Permisos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255)
);

CREATE TABLE Rol_Permisos (
    rol_id INT,
    permiso_id INT,
    PRIMARY KEY (rol_id, permiso_id),
    FOREIGN KEY (rol_id) REFERENCES Roles(id),
    FOREIGN KEY (permiso_id) REFERENCES Permisos(id)
);

CREATE TABLE Clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    direccion VARCHAR(255),
    email VARCHAR(100)
);

CREATE TABLE Empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    puesto VARCHAR(50),
    telefono VARCHAR(15),
    email VARCHAR(100),
    fecha_contratacion DATE
);

CREATE TABLE Categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255)
);

CREATE TABLE Productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255),
    precio DECIMAL(10, 2) NOT NULL,
    categoria_id INT,
    FOREIGN KEY (categoria_id) REFERENCES Categorias(id)
);

CREATE TABLE Pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    empleado_id INT,
    fecha_pedido DATETIME,
    total DECIMAL(10, 2),
    tipo_pedido ENUM('Local', 'Domicilio'),
    direccion_entrega VARCHAR(255),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id),
    FOREIGN KEY (empleado_id) REFERENCES Empleados(id)
);

CREATE TABLE DetallePedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    producto_id INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) AS (cantidad * precio_unitario) STORED,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(id),
    FOREIGN KEY (producto_id) REFERENCES Productos(id)
);

CREATE TABLE Pagos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    metodo_pago ENUM('Efectivo', 'Tarjeta', 'Transferencia', 'Otro') NOT NULL,
    monto_pagado DECIMAL(10, 2) NOT NULL,
    fecha_pago DATETIME NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(id)
);

CREATE TABLE Entregas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    repartidor_id INT,
    fecha_entrega DATETIME,
    estado_entrega ENUM('En preparación', 'En camino', 'Entregado'),
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(id),
    FOREIGN KEY (repartidor_id) REFERENCES Empleados(id)
);


INSERT INTO Roles (nombre, descripcion) VALUES 
('Administrador', 'Tiene acceso a todas las funciones del sistema'),
('Cocinero', 'Puede ver y gestionar los pedidos de cocina'),
('Cajero', 'Puede gestionar las ventas en el local y procesar pagos'),
('Repartidor', 'Gestiona las entregas a domicilio');

INSERT INTO Permisos (nombre, descripcion) VALUES 
('ver_clientes', 'Puede ver la lista de clientes'),
('crear_pedidos', 'Puede crear nuevos pedidos'),
('ver_reportes', 'Puede ver los reportes de ventas'),
('gestionar_productos', 'Puede agregar, actualizar o eliminar productos del menú');


INSERT INTO Rol_Permisos (rol_id, permiso_id) VALUES 
(1, 1),
(1, 2), 
(1, 3), 
(1, 4), 
(2, 2),
(3, 1),
(3, 2), 
(3, 3), 
(4, 2); 


INSERT INTO Rol_Permisos (rol_id, permiso_id) VALUES 
(1, 1), -- Administrador puede ver clientes
(1, 2), -- Administrador puede crear pedidos
(1, 3), -- Administrador puede ver reportes
(1, 4), -- Administrador puede gestionar productos
(2, 2), -- Cocinero puede crear pedidos
(3, 1), -- Cajero puede ver clientes
(3, 2), -- Cajero puede crear pedidos
(3, 3), -- Cajero puede ver reportes
(4, 2); -- Repartidor puede crear pedidos