-- Table: public.nse_market_data

-- DROP TABLE IF EXISTS public.nse_market_data;

CREATE TABLE IF NOT EXISTS public.nse_market_data
(
    trade_date date,
    symbol character varying(20) COLLATE pg_catalog."default",
    series character varying(10) COLLATE pg_catalog."default",
    prev_close numeric(10,2),
    open_price numeric(10,2),
    high_price numeric(10,2),
    low_price numeric(10,2),
    last_price numeric(10,2),
    close_price numeric(10,2),
    vwap numeric(10,2),
    volume bigint,
    turnover numeric(20,2),
    trades bigint,
    deliverable_volume bigint,
    percent_deliverable numeric(5,2)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.nse_market_data
    OWNER to postgres;