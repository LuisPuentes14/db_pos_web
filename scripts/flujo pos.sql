-- FLUJO COMPLETO DE FUNCIONAMIENTO DE UN SISTEMA POS
-- Etapa 1: Configuración Inicial

-- Insertar empresa
INSERT INTO business (business_name, tax_id, address, phone, email, currency_symbol, logo_name, logo_url, create_by)
VALUES ('Tienda MiNegocio', '901234567', 'Calle Principal #123', '3201234567', 'info@minegocio.com', '$', 'logo.png', '/assets/img/logo.png', 'admin');

-- Insertar roles
INSERT INTO role (name) VALUES ('Administrador'), ('Cajero');

-- Insertar usuarios
INSERT INTO user_account (id_business, id_role, full_name, email, username, password, create_by)
VALUES (1, 1, 'Juan Pérez', 'juan@minegocio.com', 'juanp', 'hashedpassword', 'admin'),
       (1, 2, 'María López', 'maria@minegocio.com', 'marial', 'hashedpassword', 'admin');

-- Insertar unidades de medida
INSERT INTO measure (name, abbreviation, equivalent, value, create_by)
VALUES ('Unidad', 'UND', 'UND', 1, 'admin'),
       ('Litro', 'L', 'ML', 1000, 'admin');

-- Insertar categorías
INSERT INTO category (id_business, name, id_measure, create_by)
VALUES (1, 'Bebidas', 1, 'admin'),
       (1, 'Panadería', 1, 'admin');

-- Insertar proveedores
INSERT INTO provider (id_business, name, contact_name, phone, address, create_by)
VALUES (1, 'Distribuidora El Sol', 'Carlos Díaz', '3001234567', 'Av. Siempre Viva 456', 'admin');

-- Insertar productos
INSERT INTO product (id_business, id_provider, id_category, code, description, purchase_price, sale_price, quantity, minimum_quantity, picture, create_by)
VALUES (1, 1, 1, 'BEB001', 'Gaseosa 500ml', 8.00, 10.00, 100, 10, '\x', 'admin'),
       (1, 1, 2, 'PAN001', 'Pan artesanal', 3.00, 5.00, 200, 20, '\x', 'admin');

-- Insertar secuencia de ventas
INSERT INTO sales_sequence (id_business, series, number)
VALUES (1, 'A01', 1);


--------------------------------------------- FLUJO DE CAJA ---------------------------------------------
-- Etapa 2: Apertura de caja
INSERT INTO cash_register_sessions (id_user, opening_amount, status, create_by)
VALUES (2, 100.00, 'ABIERTO', 'marial');

-- Etapa 3: Entradas/Salidas manuales de efectivo
INSERT INTO cash_entries_withdrawals (id_cash_register_session, amount, reason, id_user, type, create_by)
VALUES (1, 20.00, 'Reposición de cambio', 2, 'ENTRADA', 'marial'),
       (1, 10.00, 'Compra de sobres', 2, 'SALIDA', 'marial');

-- Etapa 4: Registro de venta
INSERT INTO sale (id_business, sale_number, id_user, client_name, total_price, paid_amount, change, create_by)
VALUES (1, 'A01-000001', 2, 'Cliente Final', 45.00, 50.00, 5.00, 'marial');

-- Detalle de la venta
INSERT INTO sales_detail (id_sale, id_product, description, quantity, sale_price, total_price, create_by)
VALUES (1, 1, 'Gaseosa 500ml', 2, 10.00, 20.00, 'marial'),
       (1, 2, 'Pan artesanal', 5, 5.00, 25.00, 'marial');

-- Etapa 5: Arqueo de caja y cierre
INSERT INTO cash_counts (id_cash_register_session, counted_amount, difference, notes, id_user, create_by)
VALUES (1, 150.00, 0.00, 'Todo en orden', 2, 'marial');

UPDATE cash_register_sessions
SET closing_amount = 150.00, status = 'CERRADO', update_by = 'marial', update_date = CURRENT_TIMESTAMP
WHERE id_cash_register_session = 1;
