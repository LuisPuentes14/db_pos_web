ALTER TABLE IF EXISTS public.categories
    ADD CONSTRAINT fk_category_Measure FOREIGN KEY (id_type_measure)
        REFERENCES public.types_measures (id_type_measure) MATCH SIMPLE,
    ADD CONSTRAINT fk_category_business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.sales_detail
    ADD CONSTRAINT fk_sales_detail_sale FOREIGN KEY (id_sale)
        REFERENCES public.sales (id_sale) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.products
    ADD CONSTRAINT fk_product_category FOREIGN KEY (id_category)
        REFERENCES public.categories (id_category) MATCH SIMPLE,
    ADD CONSTRAINT fk_product_business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE,
    ADD CONSTRAINT fk_product_provider FOREIGN KEY (id_provider)
        REFERENCES public.providers (id_provider) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.user_accounts
    ADD CONSTRAINT fk_user_account_role FOREIGN KEY (id_role)
        REFERENCES public.roles (id_role) MATCH SIMPLE,
    ADD CONSTRAINT fk_user_account_business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.sales
    ADD CONSTRAINT fk_sale_user_account FOREIGN KEY (id_user)
        REFERENCES public.user_accounts (id_user) MATCH SIMPLE,
    ADD CONSTRAINT fk_sale_business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.providers
    ADD CONSTRAINT fk_provider_business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.sales_sequence
    ADD CONSTRAINT fk_sales_sequence_business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.cash_register_sessions
    ADD CONSTRAINT fk_cash_register_sessions_user_account FOREIGN KEY (id_user)
        REFERENCES public.user_accounts (id_user) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.cash_entries_withdrawals
    ADD CONSTRAINT fk_cash_entries_withdrawals_cash_register_sessions FOREIGN KEY (id_cash_register_session)
        REFERENCES public.cash_register_sessions (id_cash_register_session) MATCH SIMPLE,
    ADD CONSTRAINT fk_cash_entries_withdrawals_user_account FOREIGN KEY (id_user)
        REFERENCES public.user_accounts (id_user) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.cash_counts
    ADD CONSTRAINT fk_cash_entries_withdrawals_cash_register_sessions FOREIGN KEY (id_cash_register_session)
        REFERENCES public.cash_register_sessions (id_cash_register_session) MATCH SIMPLE,
    ADD CONSTRAINT fk_cash_entries_withdrawals_user_account FOREIGN KEY (id_user)
        REFERENCES public.user_accounts (id_user) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.sales
    ADD CONSTRAINT fk_sales_clients FOREIGN KEY (id_client)
        REFERENCES public.clients (id_client) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.states
    ADD CONSTRAINT fk_states_countries FOREIGN KEY (id_country)
        REFERENCES public.countries (id_country) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.cities
    ADD CONSTRAINT fk_cities_states FOREIGN KEY (id_state)
        REFERENCES public.states (id_state) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

