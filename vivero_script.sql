DROP DATABASE IF EXISTS VIVEROS;
CREATE DATABASE VIVEROS;

DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

DROP TABLE IF EXISTS vivero;
DROP TABLE IF EXISTS empleado;
DROP TABLE IF EXISTS historico_puestos;
DROP TABLE IF EXISTS zona;
DROP TABLE IF EXISTS tarea;
DROP TABLE IF EXISTS pedido;
DROP TABLE IF EXISTS producto; 
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS gestiona;
DROP TABLE IF EXISTS se_asigna;
DROP TABLE IF EXISTS contiene;

CREATE TABLE vivero (
  vivero_id INT GENERATED ALWAYS AS IDENTITY,
  vivero_name VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY(vivero_id)
);

CREATE TABLE empleado (
  empleado_id INT GENERATED ALWAYS AS IDENTITY,
  vivero_id INT NOT NULL,
  empleado_name VARCHAR(50) NOT NULL,
  epoca VARCHAR(50) NOT NULL,
  productividad_empleado FLOAT,
  PRIMARY KEY(empleado_id),
  CONSTRAINT fk_vivero
    FOREIGN KEY(vivero_id)
      REFERENCES vivero(vivero_id)
        ON DELETE CASCADE
);

CREATE TABLE historico_puestos (
  puesto_id INT GENERATED ALWAYS AS IDENTITY,
  empleado_id INT NOT NULL,
  puesto_name VARCHAR(50) NOT NULL,
  PRIMARY KEY(puesto_id, empleado_id)
);

CREATE TABLE zona (
  zona_id INT GENERATED ALWAYS AS IDENTITY,
  zona_name VARCHAR(50) NOT NULL UNIQUE,
  productividad_zona FLOAT,
  PRIMARY KEY(zona_id)
);

CREATE TABLE tarea (
  tarea_id INT GENERATED ALWAYS AS IDENTITY,
  zona_id INT NOT NULL,
  tarea_name VARCHAR(50) NOT NULL,
  PRIMARY KEY(tarea_id, zona_id)
);

CREATE TABLE pedido (
  pedido_id INT GENERATED ALWAYS AS IDENTITY, 
  fecha_pedido DATE NOT NULL,
  PRIMARY KEY(pedido_id)
);

CREATE TABLE producto (
  producto_id INT GENERATED ALWAYS AS IDENTITY,
  producto_name VARCHAR(50) NOT NULL UNIQUE,
  categoria VARCHAR(50) NOT NULL,
  precio FLOAT NOT NULL,
  cantidad INT NOT NULL,
  PRIMARY KEY(producto_id)
);

CREATE TABLE cliente (
  cliente_id INT GENERATED ALWAYS AS IDENTITY,
  nombre_cliente VARCHAR(50) NOT NULL,
  apellido_cliente VARCHAR(50),
  tipo_cliente VARCHAR(50) NOT NULL,
  PRIMARY KEY(cliente_id)
);

CREATE TABLE gestiona (
  pedido_id INT NOT NULL,
  cliente_id INT NOT NULL,
  empleado_id INT NOT NULL,
  PRIMARY KEY(pedido_id, cliente_id, empleado_id)
);

CREATE TABLE se_asigna (
  vivero_id INT NOT NULL,
  zona_id INT NOT NULL,
  producto_id INT NOT NULL,
  PRIMARY KEY(vivero_id, zona_id, producto_id)
);

CREATE TABLE contiene (
  pedido_id INT NOT NULL,
  producto_id INT NOT NULL,
  cantidad INT NOT NULL,
  PRIMARY KEY(pedido_id, producto_id)
);

INSERT INTO vivero(vivero_name)
VALUES
  ('Perez Ortega'),
  ('Hortalizas'),
  ('Guamasa'),
  ('Garden Luz'),
  --('Garden Luz'),
  ('La Cosma');

INSERT INTO empleado(vivero_id, empleado_name, epoca, productividad_empleado)
VALUES
  (1, 'Juan Antonio', 'Primavera', 0.8),
  (1, 'Antonio Perez', 'Primavera', 0.5),
  (2, 'Jose Luis', 'Verano', 0.7),
  (2, 'Manolo Garrafas', 'Invierno', 0.99),
  (3, 'José María', 'Otoño', 0.3),
  (3, 'Magdalena Santos', 'Primavera', 0.75),
  (4, 'Antonietta Perez', 'Otoño', 0.6);

INSERT INTO historico_puestos(empleado_id, puesto_name)
VALUES
  (1, 'Supervisor'),
  (1, 'Cajero'),
  (2, 'Jardinero'),
  (3, 'Agricultor'),
  (3, 'Reponedor'),
  (4, 'Controlador de plagas'),
  (4, 'Supervisor'),
  (5, 'Conservación'),
  (6, 'Agricultora'),
  (6, 'Cajera'),
  (7, 'Jardinera'),
  (7, 'Agricultora');

INSERT INTO zona(zona_name, productividad_zona)
VALUES
  ('Cajas', null),
  ('Almacén', 0.8),
  ('Exterior', 0.45),
  ('Invernadero', 0.7),
  --('Invernadero', null),
  ('Tienda', null),
  ('Taller', 0.3);

INSERT INTO tarea(zona_id, tarea_name)
VALUES
  (1, 'Manejar montacargas'),
  (1, 'Etiquetado'),
  (2, 'Limpieza'),
  (2, 'Manejar montacargas'),
  (3, 'Control de Plagas'),
  (3, 'Producción de semillas'),
  (4, 'Control de plagas'),
  (4, 'Propagación de plantas'),
  (4, 'Cultivo de plantas y tepes'),
  (5, 'Atención al cliente'),
  (5, 'Caja'),
  (6, 'Artesano'),
  (6, 'Ayudante de artesano');

INSERT INTO pedido(fecha_pedido)
VALUES
  ('2022-11-06'),
  ('2022-11-08'),
  ('2012-12-12'),
  ('2015-10-10'),
  ('2022-12-12'),
  ('2018-04-04');

INSERT INTO producto(producto_name, categoria, precio, cantidad)
VALUES
  ('Abono', 'Jardineria', 3.4, 45),
  ('Semilla', 'Plantas', 2.0, 345),
  ('Bonsais', 'Plantas', 25.4, 25),
  ('Orquideas', 'Plantas', 5.1, 68),
  ('Cactus', 'Plantas', 3.8, 35),
  ('Maceta de barro', 'Jardineria', 6.0, 420),
  ('Tijeras de podar', 'Jardineria', 4.3, 203),
  ('Azada', 'Jardineria', 7.3, 130),
  ('Regadera', 'Jardineria', 3.41, 520),
  ('Mallas de ocultación', 'Decoración', 1.99, 239),
  ('Hamacas', 'Decoración', 11.5, 25),
  ('Barriles', 'Decoración', 9.99, 53),
  ('Cesped artificial', 'Decoración', 2.5, 894);

INSERT INTO cliente(nombre_cliente, apellido_cliente, tipo_cliente)
VALUES
  ('Josefa', 'Ruiz', 'No Plus'),
  ('Domingo', 'Rodriguez', 'Plus'),
  ('Pepi', 'Pag', 'Plus'),
  ('Fernando', 'Alonso', 'No Plus'),
  ('Roselia', 'Estrella', 'Plus'),
  ('Rafa', 'Pons', 'Plus'),
  ('Normandia', 'Eslovaquia', 'Plus');

INSERT INTO gestiona(pedido_id, cliente_id, empleado_id)
VALUES
  (1, 5, 1),
  (2, 6, 3),
  (3, 7, 6),
  (4, 3, 1),
  (5, 2, 6),
  (6, 3, 6);

INSERT INTO se_asigna(vivero_id, zona_id, producto_id)
VALUES
  (1, 1, 1),
  (1, 2, 13),
  (2, 3, 4),
  (2, 1, 1),
  (2, 4, 2),
  (3, 2, 6),
  (3, 5, 12),
  (3, 6, 11),
  (3, 1, 6),
  (4, 5, 7),
  (5, 5, 5),
  (5, 2, 9),
  (5, 2, 10),
  (5, 4, 3),
  (5, 6, 13),
  (5, 1, 8),
  --(5,1,8),
  (5, 1, 1);

INSERT INTO contiene(pedido_id, producto_id, cantidad)
VALUES
  (1, 2, 10),
  (1, 7, 1),
  (1, 6, 1),
  (2, 4, 1),
  (2, 5, 1),
  (3, 13, 34),
  (3, 12, 5),
  (4, 6, 2),
  (5, 10, 25),
  (6, 9, 2);

SELECT * FROM vivero;
SELECT * FROM empleado;
SELECT * FROM historico_puestos;
SELECT * FROM zona;
SELECT * FROM tarea;
SELECT * FROM pedido;
SELECT * FROM producto;
SELECT * FROM cliente;
SELECT * FROM gestiona;
SELECT * FROM se_asigna;
SELECT * FROM contiene;
