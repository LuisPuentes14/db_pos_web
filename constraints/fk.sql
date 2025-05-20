ALTER TABLE IF EXISTS public.categories
    ADD CONSTRAINT fk_category__business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.sales_detail
    ADD CONSTRAINT fk_sales__detail_sale FOREIGN KEY (id_sale)
        REFERENCES public.sales (id_sale) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.products
    ADD CONSTRAINT fk_product__category FOREIGN KEY (id_category)
        REFERENCES public.categories (id_category) MATCH SIMPLE,
    ADD CONSTRAINT fk_product__business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE,
    ADD CONSTRAINT fk_product__provider FOREIGN KEY (id_provider)
        REFERENCES public.providers (id_provider) MATCH SIMPLE,
    ADD CONSTRAINT fk_product__types_measures FOREIGN KEY (id_type_measure)
        REFERENCES public.types_measures (id_type_measure) MATCH SIMPLE,
    ADD CONSTRAINT fk_product__products_status FOREIGN KEY (id_product_status)
        REFERENCES public.products_status (id_product_status) MATCH SIMPLE,
    ADD CONSTRAINT fk_product__brands FOREIGN KEY (id_brand)
        REFERENCES public.brands (id_brand) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.user_accounts
    ADD CONSTRAINT fk_user_account__role FOREIGN KEY (id_role)
        REFERENCES public.roles (id_role) MATCH SIMPLE,
    ADD CONSTRAINT fk_user_account__business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.sales
    ADD CONSTRAINT fk_sale__user_account FOREIGN KEY (id_user)
        REFERENCES public.user_accounts (id_user) MATCH SIMPLE,
    ADD CONSTRAINT fk_sale__business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.providers
    ADD CONSTRAINT fk_provider__business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.sales_sequence
    ADD CONSTRAINT fk_sales_sequence__business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.cash_registers
    ADD CONSTRAINT fk_cash_registers__business FOREIGN KEY (id_business)
        REFERENCES public.sales (id_sale) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.cash_register_sessions
    ADD CONSTRAINT fk_cash_register_sessions__cash_registers FOREIGN KEY (id_cash_register)
        REFERENCES public.cash_registers (id_cash_register) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.cash_entries_withdrawals
    ADD CONSTRAINT fk_cash_entries_withdrawals__cash_register_sessions FOREIGN KEY (id_cash_register_session)
        REFERENCES public.cash_register_sessions (id_cash_register_session) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.cash_counts
    ADD CONSTRAINT fk_cash_counts__cash_register_sessions FOREIGN KEY (id_cash_register_session)
        REFERENCES public.cash_register_sessions (id_cash_register_session) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.sales
    ADD CONSTRAINT fk_sales__clients FOREIGN KEY (id_client)
        REFERENCES public.clients (id_client) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.states
    ADD CONSTRAINT fk_states__countries FOREIGN KEY (id_country)
        REFERENCES public.countries (id_country) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.cities
    ADD CONSTRAINT fk_cities__states FOREIGN KEY (id_state)
        REFERENCES public.states (id_state) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.clients
    ADD CONSTRAINT fk_clients__countries FOREIGN KEY (id_country)
        REFERENCES public.countries (id_country) MATCH SIMPLE,
    ADD CONSTRAINT fk_clients__states FOREIGN KEY (id_state)
        REFERENCES public.states (id_state) MATCH SIMPLE,
    ADD CONSTRAINT fk_clients__cities FOREIGN KEY (id_city)
        REFERENCES public.cities (id_city) MATCH SIMPLE,
    ADD CONSTRAINT fk_clients__types_identification FOREIGN KEY (id_types_identification)
        REFERENCES public.types_identification (id_types_identification) MATCH SIMPLE,
    ADD CONSTRAINT fk_clients__types_contributors FOREIGN KEY (id_type_contributor)
        REFERENCES public.types_contributors (id_type_contributor) MATCH SIMPLE,
    ADD CONSTRAINT fk_clients__types_tax_regime FOREIGN KEY (id_type_tax_regime)
        REFERENCES public.types_tax_regime (id_type_tax_regime) MATCH SIMPLE,
    ADD CONSTRAINT fk_clients__types_fiscal_responsibility FOREIGN KEY (id_type_fiscal_responsibility)
        REFERENCES public.types_fiscal_responsibility (id_type_fiscal_responsibility) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.product_pictures
    ADD CONSTRAINT fk_product_pictures__products FOREIGN KEY (id_product)
        REFERENCES public.products (id_product) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.brands
    ADD CONSTRAINT fk_brands__business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.taxes_by_products
    ADD CONSTRAINT fk_taxes_by_products__business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE,
    ADD CONSTRAINT fk_taxes_by_products__products FOREIGN KEY (id_product)
        REFERENCES public.products (id_product) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.products_status
    ADD CONSTRAINT fk_tproducts_status__business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.sales_detail_taxes
    ADD CONSTRAINT fk_sales_detail_taxes_status__sales_detail FOREIGN KEY (id_sales_detail)
        REFERENCES public.sales_detail (id_sales_detail) MATCH SIMPLE,
    ADD CONSTRAINT fk_sales_detail_taxes_status__types_taxes FOREIGN KEY (id_type_tax)
        REFERENCES public.types_taxes (id_type_tax) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.sales_detail_charges
    ADD CONSTRAINT fk_sales_detail_charges__sales_detail FOREIGN KEY (id_sales_detail)
        REFERENCES public.sales_detail (id_sales_detail) MATCH SIMPLE,
    ADD CONSTRAINT fk_sales_detail_charges__types_detailed_charges FOREIGN KEY (id_type_detailed_charge)
        REFERENCES public.types_detailed_charges (id_type_detailed_charge) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.sales_detail_discounts
    ADD CONSTRAINT fk_sales_detail_discounts__sales_detail FOREIGN KEY (id_sales_detail)
        REFERENCES public.sales_detail (id_sales_detail) MATCH SIMPLE,
    ADD CONSTRAINT fk_sales_detail_discounts__types_discounts FOREIGN KEY (id_type_discount)
        REFERENCES public.types_discounts (id_type_discount) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.sales_taxes
    ADD CONSTRAINT fk_sales_taxes__sales FOREIGN KEY (id_sale)
        REFERENCES public.sales (id_sale) MATCH SIMPLE,
    ADD CONSTRAINT fk_sales_taxes__types_taxes FOREIGN KEY (id_type_tax)
        REFERENCES public.types_taxes (id_type_tax) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.sales_charges
    ADD CONSTRAINT fk_sales_charges__sales FOREIGN KEY (id_sale)
        REFERENCES public.sales (id_sale) MATCH SIMPLE,
    ADD CONSTRAINT fk_sales_charges__types_detailed_charges FOREIGN KEY (id_type_detailed_charge)
        REFERENCES public.types_detailed_charges (id_type_detailed_charge) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.sales_discounts
    ADD CONSTRAINT fk_sales_discounts__sales FOREIGN KEY (id_sale)
        REFERENCES public.sales (id_sale) MATCH SIMPLE,
    ADD CONSTRAINT fk_sales_discounts__types_discounts FOREIGN KEY (id_type_discount)
        REFERENCES public.types_discounts (id_type_discount) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;


