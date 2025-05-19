DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;


-- LOGICA PUNTO DE VENTA
----------------------------------------------
-- Empresa
CREATE TABLE business
(
    id_business     BIGSERIAL PRIMARY KEY,
    business_name   VARCHAR(100),
    tax_id          VARCHAR(20),
    address         VARCHAR(100),
    phone           VARCHAR(10),
    email           VARCHAR(30),
    currency_symbol VARCHAR(5),
    logo_name       VARCHAR(100),
    logo_url        VARCHAR(200),
    create_by       VARCHAR(255),
    create_date     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_by       VARCHAR(255),
    update_date     TIMESTAMP
);


-- Categorias de los productos
CREATE TABLE categories
(
    id_category BIGSERIAL PRIMARY KEY,
    id_business BIGINT,
    name        VARCHAR(50) NOT NULL,
    active      BOOLEAN   DEFAULT TRUE,
    create_by   VARCHAR(255),
    create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_by   VARCHAR(255),
    update_date TIMESTAMP
);

-- proveedor de los productos
CREATE TABLE providers
(
    id_provider  BIGSERIAL PRIMARY KEY,
    id_business  BIGINT,
    name         VARCHAR(255) NOT NULL,
    contact_name VARCHAR(255) NOT NULL,
    phone        VARCHAR(15)  NOT NULL,
    address      VARCHAR(255) NOT NULL,
    active       BOOLEAN   DEFAULT TRUE,
    create_by    VARCHAR(255),
    create_date  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_by    VARCHAR(255),
    update_date  TIMESTAMP
);

-- productos
CREATE TABLE products
(
    id_product           BIGSERIAL PRIMARY KEY,
    id_business          BIGINT,                  -- id negocio o empresa
    id_provider          BIGINT,                  -- proveedor del producto
    id_category          BIGINT,                  -- categoria del producto
    id_brand             BIGINT,                  -- marca del producto
    id_type_measure      BIGINT,                  -- tipo de medida
    code                 VARCHAR(50)    NOT NULL, -- codigo de referencia del producto
    bar_code             VARCHAR(1000),           -- codigo de barras
    id_product_status    BIGINT         NOT NULL, -- id estado del producto (nuevo, usado, etc)
    name                 TEXT           NOT NULL, -- nombre del producto
    description          TEXT           NOT NULL, -- descripcion del producto
    purchase_price       DECIMAL(10, 2) NOT NULL,
    sale_price           DECIMAL(10, 2) NOT NULL,
    quantity             DECIMAL(10, 2) NOT NULL DEFAULT 0,
    minimum_quantity     DECIMAL(10, 2) NOT NULL DEFAULT 0,
    promotion_percentage DECIMAL(10, 2) NOT NULL DEFAULT 0,
    promotion_star_date  TIMESTAMP,
    promotion_end_date   TIMESTAMP,
    promotion_active     BOOLEAN                 DEFAULT FALSE,
    active               BOOLEAN                 DEFAULT TRUE,
    create_by            VARCHAR(255),
    create_date          TIMESTAMP               DEFAULT CURRENT_TIMESTAMP,
    update_by            VARCHAR(255),
    update_date          TIMESTAMP,
    UNIQUE (id_business, code),
    UNIQUE (id_business, bar_code)
);


CREATE TABLE product_pictures
(
    id_product_picture BIGSERIAL PRIMARY KEY,
    id_product         BIGINT NOT NULL,
    picture            BYTEA  NOT NULL
);

-- estados de productos
CREATE TABLE products_status
(
    id_product_status BIGSERIAL PRIMARY KEY,
    id_business       BIGINT, -- id negocio o empresa
    description       VARCHAR(150) NOT NULL,
    create_by         VARCHAR(255),
    create_date       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_by         VARCHAR(255),
    update_date       TIMESTAMP
);

-- marcas de productos
CREATE TABLE brands
(
    id_brand    BIGSERIAL PRIMARY KEY,
    id_business BIGINT, -- id negocio o empresa
    name        VARCHAR(50)  NOT NULL,
    description VARCHAR(150) NOT NULL,
    create_by   VARCHAR(255),
    create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_by   VARCHAR(255),
    update_date TIMESTAMP
);

-- impuestos por productos
CREATE TABLE taxes_by_products
(
    id_tax_by_product BIGSERIAL PRIMARY KEY,
    id_business       BIGINT,                  -- id negocio o empresa
    id_product        BIGINT,                  -- id producto
    id_type_tax       BIGINT,                  -- id tipo de impuesto
    percentage        DECIMAL(10, 2) NOT NULL, -- porcentaje del impuesto
    create_by         VARCHAR(255),
    create_date       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_by         VARCHAR(255),
    update_date       TIMESTAMP
);

CREATE TABLE clients
(
    id_client                     BIGSERIAL PRIMARY KEY,
    name                          VARCHAR(255),
    dni                           VARCHAR(255),
    email                         VARCHAR(255),
    phone                         VARCHAR(20),
    address                       VARCHAR(255),
    commercial_registration       VARCHAR(255),-- Matricual mercantil
    id_country                    BIGINT,      -- pais
    id_state                      BIGINT,      -- departamento
    id_city                       BIGINT,      -- ciudad
    id_types_identification       BIGINT,      -- tipo de indentificacion
    id_type_contributor           BIGINT,      -- tipo de contribuyente
    id_type_tax_regime            BIGINT,      -- tipo de regimen fiscal
    id_type_fiscal_responsibility BIGINT,      -- tipo de responsabilidad fiscal
    create_by                     VARCHAR(255),
    create_date                   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_by                     VARCHAR(255),
    update_date                   TIMESTAMP
);

-- secuencias numericas de los productos
CREATE TABLE sales_sequence
(
    id_sale_sequence BIGSERIAL,
    id_business      BIGINT,
    number           BIGINT NOT NULL DEFAULT 1,
    active           BOOLEAN         DEFAULT TRUE,
    PRIMARY KEY (id_business, number)
);

-- ventas
CREATE TABLE sales
(
    id_sale                  BIGSERIAL PRIMARY KEY,   -- id tabla
    id_business              BIGINT,                  -- id negocio o empresa
    sale_number              VARCHAR(10),             -- id venta
    id_user                  BIGINT,                  -- usuario que regsitro la venta
    id_client                BIGINT,                  -- id cliente
    paid_amount              DECIMAL(10, 2) NOT NULL, -- total_pagado
    id_cash_register_session BIGINT,                  -- id de la caja que se encuentra abierta
    registration_date        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    create_by                VARCHAR(255),
    create_date              TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- pagos realizados por venta
CREATE TABLE sales_payments
(
    id_payment              BIGSERIAL PRIMARY KEY, -- id tabla
    id_sale                 BIGINT,                -- id tabla venta
    id_types_form_payment   BIGINT,                -- tipo de pago
    id_type_payment_methods BIGINT,                -- metodo de pago
    money_received          DECIMAL(10, 2),        -- cantidad recibida cuando es efectivo
    change                  DECIMAL(10, 2),        -- cambio devuelto de la cantidad recbidad
    paid_amount             DECIMAL(10, 2),        -- total pagado  con el tipo de pago y metodo de pago
    create_by               VARCHAR(255),
    create_date             TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE sales_detail
(
    id_sales_detail     BIGSERIAL PRIMARY KEY, -- id
    id_sale             BIGINT,                -- id tabla venta
    product_code        VARCHAR(50),           -- codigo del producto
    product_bar_code    VARCHAR(1000),         -- codigo de barras
    product_name        TEXT,                  -- nombre de producto
    product_description TEXT,                  -- descipcion de producto
    unit_price          BIGINT,                -- precio de la unidad
    quantity            INT,                   -- cantidad del producto
    sale_price          DECIMAL(10, 2),        -- valor de la venta del producto
    create_by           VARCHAR(255),
    create_date         TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- detalle de impuestos por producto vendido
CREATE TABLE sales_detail_taxes
(
    id_sales_detail_tax BIGSERIAL PRIMARY KEY,   -- id
    id_sales_detail     BIGINT,                  -- id tabla detalle de venta
    id_type_tax         BIGINT,                  -- id tipo de impuesto
    percentage          DECIMAL(10, 2) NOT NULL, -- porcentaje del impuesto
    amount              DECIMAL(10, 2) NOT NULL, -- valor del impuesto
    tax_base            DECIMAL(10, 2) NOT NULL, -- valor del impuesto
    create_by           VARCHAR(255),
    create_date         TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- detalle de cargos o recaregos por producto vendido
CREATE TABLE sales_detail_charges
(
    id_sales_detail_charge  BIGSERIAL PRIMARY KEY,   -- id
    id_sales_detail         BIGINT,                  -- id tabla detalle de venta
    id_type_detailed_charge BIGINT,                  -- id tipo de recargo
    percentage              DECIMAL(10, 2) NOT NULL, -- porcentaje del recargo
    amount                  DECIMAL(10, 2) NOT NULL, -- valor del recargo
    charge_base             DECIMAL(10, 2) NOT NULL, -- base del recargo
    create_by               VARCHAR(255),
    create_date             TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- detalle de descuentos por producto vendido
CREATE TABLE sales_detail_discounts
(
    id_sales_detail_discount BIGSERIAL PRIMARY KEY,   -- id
    id_sales_detail          BIGINT,                  -- id tabla detalle de venta
    id_type_discount         BIGINT,                  -- id tipo de descuento
    percentage               DECIMAL(10, 2) NOT NULL, -- porcentaje del descuento
    amount                   DECIMAL(10, 2) NOT NULL, -- valor del descuento
    discount_base            DECIMAL(10, 2) NOT NULL, -- base de descuento
    create_by                VARCHAR(255),
    create_date              TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- tipos de medidas para los productos
CREATE TABLE types_measures
(
    id_type_measure BIGSERIAL PRIMARY KEY,
    name            VARCHAR(50) NOT NULL,
    abbreviation    VARCHAR(4)  NOT NULL,
    equivalent      VARCHAR(4)  NOT NULL,
    value           INT         NOT NULL,
    create_by       VARCHAR(255),
    create_date     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_by       VARCHAR(255),
    update_date     TIMESTAMP
);

-- apertura y cierre de la caja
CREATE TABLE cash_register_sessions
(
    id_cash_register_session BIGSERIAL PRIMARY KEY,
    id_user                  BIGINT         NOT NULL,                                                             -- ID del cajero
    opening_amount           NUMERIC(12, 2) NOT NULL,
    closing_amount           NUMERIC(12, 2),
    status                   VARCHAR(20)    NOT NULL DEFAULT 'ABIERTO' CHECK (status IN ('ABIERTO', 'CERRADO') ), -- ABIERTO | CERRADO
    notes                    TEXT,
    create_by                VARCHAR(255),
    create_date              TIMESTAMP               DEFAULT CURRENT_TIMESTAMP,
    update_by                VARCHAR(255),
    update_date              TIMESTAMP
);

--Registra entradas y salidas de efectivo a la caja (que no sean ventas).
CREATE TABLE cash_entries_withdrawals
(
    id_cash_entry_withdrawal BIGSERIAL PRIMARY KEY,
    id_cash_register_session BIGINT         NOT NULL,
    amount                   NUMERIC(12, 2) NOT NULL CHECK ( amount >= 0 ),
    reason                   TEXT           NOT NULL,
    id_user                  BIGINT,
    type                     VARCHAR(20)    NOT NULL DEFAULT 'ENTRADA' CHECK (type IN ('ENTRADA', 'SALIDA') ),
    create_by                VARCHAR(255),
    create_date              TIMESTAMP               DEFAULT CURRENT_TIMESTAMP,
    update_by                VARCHAR(255),
    update_date              TIMESTAMP
);


CREATE TABLE cash_counts
(
    id_cash_count            BIGSERIAL PRIMARY KEY,
    id_cash_register_session BIGINT         NOT NULL,
    counted_amount           NUMERIC(12, 2) NOT NULL,
    difference               NUMERIC(12, 2), -- diferencia entre lo contado y lo esperado
    notes                    TEXT,
    id_user                  BIGINT,
    create_by                VARCHAR(255),
    create_date              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_by                VARCHAR(255),
    update_date              TIMESTAMP
);
----------------------------------------------


-- MODULO DE SEGURIDAD
----------------------------------------------


-- roles de los usuarios
CREATE TABLE roles
(
    id_role SERIAL PRIMARY KEY,
    name    VARCHAR(50) NOT NULL
);

-- usuaarios que van a ingregar a la pagina
CREATE TABLE user_accounts
(
    id_user        SERIAL PRIMARY KEY,
    id_business    INT,
    id_role        INT,
    full_name      VARCHAR(50)        NOT NULL,
    email          VARCHAR(50)        NOT NULL,
    username       VARCHAR(50) UNIQUE NOT NULL,
    password       VARCHAR(100)       NOT NULL,
    reset_password BOOLEAN   DEFAULT TRUE,
    active         BOOLEAN   DEFAULT TRUE,
    create_by      VARCHAR(255),
    create_date    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_by      VARCHAR(255),
    update_date    TIMESTAMP
);

-- menus que sevan a mostar por usuarios
CREATE TABLE menu
(
    id_menu        SERIAL PRIMARY KEY,
    menu_name      VARCHAR(50) NOT NULL,
    parent_menu_id INT DEFAULT 0
);
--
-- CREATE TABLE menu_role
-- (
--     id_menu_role SERIAL PRIMARY KEY,
--     id_menu      INT REFERENCES Menu (id_menu),
--     id_role      INT REFERENCES Role (id_role),
--     active       BOOLEAN DEFAULT TRUE
-- );

----------------------------------------------


--Facturacion electronica DIAN
---------------------------------------------------

-- Tabla: country
CREATE TABLE countries
(
    id_country BIGSERIAL PRIMARY KEY,
    code       VARCHAR(20)  NOT NULL,
    name       VARCHAR(100) NOT NULL,
    UNIQUE (code, name)
);

-- Tabla: state (equivale a "departamento")
CREATE TABLE states
(
    id_state   BIGSERIAL PRIMARY KEY,
    code       VARCHAR(20),
    name       VARCHAR(100) NOT NULL,
    id_country INTEGER      NOT NULL,
    UNIQUE (code, name)
);

-- Tabla: city (equivale a "municipio")
CREATE TABLE cities
(
    id_city  BIGSERIAL PRIMARY KEY,
    code     VARCHAR(20),
    name     VARCHAR(100) NOT NULL,
    id_state INTEGER      NOT NULL,
    FOREIGN KEY (id_state) REFERENCES states (id_state) ON DELETE CASCADE,
    UNIQUE (code, name)
);

-- Tabla: tipo de indentificacion
CREATE TABLE types_identification
(
    id_types_identification BIGSERIAL PRIMARY KEY,
    code                    VARCHAR(20),
    name                    VARCHAR(100) NOT NULL,
    UNIQUE (code, name)
);

-- Tabla: tipos de contribuyentes
CREATE TABLE types_contributors
(
    id_type_contributor BIGSERIAL PRIMARY KEY,
    code                VARCHAR(20),
    name                VARCHAR(100) NOT NULL,
    UNIQUE (code, name)
);

-- Tabla: regimen fiscal
CREATE TABLE types_tax_regime
(
    id_type_tax_regime BIGSERIAL PRIMARY KEY,
    code               VARCHAR(20),
    name               VARCHAR(100) NOT NULL,
    UNIQUE (code, name)
);


-- Tabla: responsabilidad fiscal
CREATE TABLE types_fiscal_responsibility
(
    id_type_fiscal_responsibility BIGSERIAL PRIMARY KEY,
    code                          VARCHAR(20),
    name                          VARCHAR(100) NOT NULL,
    UNIQUE (code, name)
);

-- Tabla: forma de pago
CREATE TABLE types_form_payment
(
    id_types_form_payment BIGSERIAL PRIMARY KEY,
    code                  VARCHAR(20),
    name                  VARCHAR(100) NOT NULL,
    UNIQUE (code, name)
);

-- Tabla: tipos metodos de pago
CREATE TABLE types_payment_methods
(
    id_type_payment_methods BIGSERIAL PRIMARY KEY,
    code                    VARCHAR(20),
    name                    VARCHAR(100) NOT NULL,
    UNIQUE (code, name)
);

-- Tabla: tipos de descuento
CREATE TABLE types_discounts
(
    id_type_discount BIGSERIAL PRIMARY KEY,
    code             VARCHAR(20),
    name             VARCHAR(100) NOT NULL,
    UNIQUE (code, name)
);


-- Tabla: tipos de cargos
CREATE TABLE types_detailed_charges
(
    id_type_detailed_charge BIGSERIAL PRIMARY KEY,
    code                    VARCHAR(20),
    name                    VARCHAR(100) NOT NULL,
    UNIQUE (code, name)
);

-- Tabla: tipos de impuestos
CREATE TABLE types_taxes
(
    id_type_tax BIGSERIAL PRIMARY KEY,
    code        VARCHAR(20),
    name        VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    UNIQUE (code, name)
);


CREATE TABLE issuers
(
    id_issuers              SERIAL PRIMARY KEY,
    nit                     VARCHAR(200),
    name                    VARCHAR(255),
    commercial_registration VARCHAR(100), -- MATRICULA MERCANTIL
    contributor_type        VARCHAR(255), -- TIPO DE CONTRIBUYENTE
    tax_regime              VARCHAR(255), --REGIMEN FISCAL
    fiscal_responsibility   VARCHAR(255), -- RESPONSABILIDAD FISCAL
    email                   VARCHAR(255),
    phone                   VARCHAR(50)
);

CREATE TABLE software_dian
(
    id_software_dian    SERIAL PRIMARY KEY,
    id_business         INT,
    identifier          VARCHAR(255),
    pin                 VARCHAR(255),
    identifier_set_test VARCHAR(255),
    user_set_tests      BOOLEAN DEFAULT TRUE
);

CREATE TABLE ranks_dian
(
    id_ranks_dian     SERIAL PRIMARY KEY,
    id_business       INT,
    number_resolution VARCHAR(255)
);

