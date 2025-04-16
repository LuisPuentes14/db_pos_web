ALTER TABLE IF EXISTS public.category
    ADD CONSTRAINT fk_category_Measure FOREIGN KEY (id_measure)
        REFERENCES public.Measure (id_measure) MATCH SIMPLE,
    ADD CONSTRAINT fk_category_business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.sales_detail
    ADD CONSTRAINT fk_sales_detail_sale FOREIGN KEY (id_sale)
        REFERENCES public.sale (id_sale) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.product
    ADD CONSTRAINT fk_product_category FOREIGN KEY (id_category)
        REFERENCES public.category (id_category) MATCH SIMPLE,
    ADD CONSTRAINT fk_product_business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE,
    ADD CONSTRAINT fk_product_provider FOREIGN KEY (id_provider)
        REFERENCES public.provider (id_provider) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.user_account
    ADD CONSTRAINT fk_user_account_role FOREIGN KEY (id_role)
        REFERENCES public.role (id_role) MATCH SIMPLE,
    ADD CONSTRAINT fk_user_account_business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.sale
    ADD CONSTRAINT fk_sale_user_account FOREIGN KEY (id_user)
        REFERENCES public.user_account (id_user) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.provider
    ADD CONSTRAINT fk_provider_business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.sales_sequence
    ADD CONSTRAINT fk_sales_sequence_business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.sale
    ADD CONSTRAINT fk_sale_business FOREIGN KEY (id_business)
        REFERENCES public.business (id_business) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.cash_register_sessions
    ADD CONSTRAINT fk_cash_register_sessions_user_account FOREIGN KEY (id_user)
        REFERENCES public.user_account (id_user) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.cash_entries_withdrawals
    ADD CONSTRAINT fk_cash_entries_withdrawals_cash_register_sessions FOREIGN KEY (id_cash_register_session)
        REFERENCES public.cash_register_sessions (id_cash_register_session) MATCH SIMPLE,
    ADD CONSTRAINT fk_cash_entries_withdrawals_user_account FOREIGN KEY (id_user)
        REFERENCES public.user_account (id_user) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE IF EXISTS public.cash_counts
    ADD CONSTRAINT fk_cash_entries_withdrawals_cash_register_sessions FOREIGN KEY (id_cash_register_session)
        REFERENCES public.cash_register_sessions (id_cash_register_session) MATCH SIMPLE,
    ADD CONSTRAINT fk_cash_entries_withdrawals_user_account FOREIGN KEY (id_user)
        REFERENCES public.user_account (id_user) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;


