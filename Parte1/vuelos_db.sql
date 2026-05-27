
--Eliminar tabla
drop table vuelos;
--Crear tabla
create table vuelos (
    id serial PRIMARY KEY,
    codigo varchar(10) NOT NULL UNIQUE,
    precio_boleto NUMERIC(10,2) NOT NULL CHECK (precio_boleto >= 0),
    asientos_disponibles INTEGER NOT NULL CHECK (asientos_disponibles >= 0)
);

--Inserts con IA

INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('AA-123', 250.50, 45);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('LA-456', 180.00, 0);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('AV-789', 320.00, 120);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('CM-101', 450.99, 0);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('IB-202', 850.00, 15);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('AF-303', 920.50, 4);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('UA-404', 210.00, 88);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('DL-505', 315.25, 1);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('AR-606', 195.00, 60);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('AM-707', 280.00, 0);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('QL-808', 135.00, 3);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('VB-909', 99.99, 142);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('JA-111', 160.50, 35);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('H2-222', 115.00, 0);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('Wingo-33', 85.50, 18);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('A3-444', 410.00, 5);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('UX-555', 670.00, 22);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('EK-666', 1250.00, 55);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('QR-777', 1400.00, 8);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('LH-888', 980.00, 2);

--Select Tabla Vuelos
SELECT * FROM vuelos;


-- Alerta de Vuelo Lleno 
SELECT * FROM vuelos WHERE asientos_disponibles < 5;

-- Incremento de Tarifas 
UPDATE vuelos SET precio_boleto = precio_boleto * 1.15 WHERE id = 1;

-- Depuración de Rutas Canceladas 
DELETE FROM vuelos WHERE asientos_disponibles = 0;
