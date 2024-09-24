Tabla "Clientes"
Contiene información sobre los clientes que compran en el restaurante.

Tabla "Empleados"
Almacena la información de los empleados, incluyendo los que atienden en el local y los repartidores.

Tabla "Productos"
Contiene la información de los productos ofrecidos en el restaurante.

Tabla "Pedidos"
Almacena los pedidos realizados por los clientes, tanto en el local como a domicilio.

Tabla "DetallePedidos"
Almacena los detalles de cada pedido, es decir, los productos y la cantidad de cada uno.

Tabla "Entregas"
Gestiona las entregas a domicilio, incluyendo la relación con los repartidores.


Tabla "Pagos"
Registra la información de los pagos realizados por los clientes.

Tabla "Categorias"
Opcionalmente, puedes tener una tabla de categorías para los productos si tienes una gran variedad de ellos.

CREATE TABLE Clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(255),
    email VARCHAR(100)
);

CREATE TABLE Empleados (
    empleado_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    puesto VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_contratacion DATE
);

CREATE TABLE Productos (
    producto_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    categoria VARCHAR(50)
);

CREATE TABLE Pedidos (
    pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    empleado_id INT,
    fecha_pedido DATETIME NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    tipo_pedido ENUM('Local', 'Domicilio') NOT NULL,
    direccion_entrega VARCHAR(255),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id),
    FOREIGN KEY (empleado_id) REFERENCES Empleados(empleado_id)
);

CREATE TABLE DetallePedidos (
    detalle_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    producto_id INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(pedido_id),
    FOREIGN KEY (producto_id) REFERENCES Productos(producto_id)
);

CREATE TABLE Entregas (
    entrega_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    repartidor_id INT,
    fecha_entrega DATETIME NOT NULL,
    estado_entrega ENUM('Pendiente', 'En Camino', 'Entregado', 'Cancelado') NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(pedido_id),
    FOREIGN KEY (repartidor_id) REFERENCES Empleados(empleado_id)
);

CREATE TABLE Pagos (
    pago_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    fecha_pago DATETIME NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    metodo_pago ENUM('Efectivo', 'Tarjeta', 'Transferencia') NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(pedido_id)
);

CREATE TABLE Categorias (
    categoria_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);


ALTER TABLE Productos
ADD COLUMN categoria_id INT,
ADD FOREIGN KEY (categoria_id) REFERENCES Categorias(categoria_id);


CREATE TABLE Mesas (
    mesa_id INT AUTO_INCREMENT PRIMARY KEY,
    numero INT NOT NULL,
    capacidad INT NOT NULL
);

Relación Mesas-Pedidos (Asocia pedidos con mesas.)

ALTER TABLE Pedidos
ADD COLUMN mesa_id INT,
ADD FOREIGN KEY (mesa_id) REFERENCES Mesas(mesa_id);
