--
-- PostgreSQL database dump
--

\restrict 0mdfHHzzCbpIpBoFBZsuDop0n6MQFnomzEn0PNHDKdZG3U6b15WI67qLzOqhrkd

-- Dumped from database version 18.6 (Ubuntu 18.6-0ubuntu0.26.04.1)
-- Dumped by pg_dump version 18.6 (Ubuntu 18.6-0ubuntu0.26.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_transactions (
    id bigint NOT NULL,
    txn_id character varying,
    amount numeric,
    reason character varying,
    user_code character varying,
    mobile character varying,
    txn_type character varying,
    user_type character varying,
    user_name character varying,
    status character varying,
    parent_id integer,
    user_id bigint NOT NULL,
    wallet_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.account_transactions OWNER TO postgres;

--
-- Name: account_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.account_transactions_id_seq OWNER TO postgres;

--
-- Name: account_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_transactions_id_seq OWNED BY public.account_transactions.id;


--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO postgres;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_attachments_id_seq OWNER TO postgres;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO postgres;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_blobs_id_seq OWNER TO postgres;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO postgres;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNER TO postgres;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: aeps_commission_slab_ranges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aeps_commission_slab_ranges (
    id bigint NOT NULL,
    min_amount numeric,
    max_amount numeric,
    bank_fee_percent numeric,
    eko_fee numeric,
    surcharge numeric,
    tds_percent numeric,
    gst_percent numeric,
    from_role character varying,
    to_role character varying,
    value numeric,
    active boolean,
    scheme_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    service_type character varying DEFAULT 'transaction'::character varying NOT NULL
);


ALTER TABLE public.aeps_commission_slab_ranges OWNER TO postgres;

--
-- Name: aeps_commission_slab_ranges_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aeps_commission_slab_ranges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.aeps_commission_slab_ranges_id_seq OWNER TO postgres;

--
-- Name: aeps_commission_slab_ranges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aeps_commission_slab_ranges_id_seq OWNED BY public.aeps_commission_slab_ranges.id;


--
-- Name: aeps_commission_slabs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aeps_commission_slabs (
    id bigint NOT NULL,
    min_amount numeric,
    max_amount numeric,
    bank_fee_percent numeric,
    eko_fee numeric,
    surcharge numeric,
    tds_percent numeric,
    gst_percent numeric,
    from_role character varying,
    to_role character varying,
    value numeric,
    active boolean,
    scheme_id integer,
    aeps_commission_slab_range_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    service_type character varying DEFAULT 'transaction'::character varying NOT NULL
);


ALTER TABLE public.aeps_commission_slabs OWNER TO postgres;

--
-- Name: aeps_commission_slabs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aeps_commission_slabs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.aeps_commission_slabs_id_seq OWNER TO postgres;

--
-- Name: aeps_commission_slabs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aeps_commission_slabs_id_seq OWNED BY public.aeps_commission_slabs.id;


--
-- Name: aeps_mini_statements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aeps_mini_statements (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    bank_code character varying,
    customer_id character varying,
    aadhaar_last4 character varying,
    status character varying,
    commission_data jsonb,
    provider_response jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.aeps_mini_statements OWNER TO postgres;

--
-- Name: aeps_mini_statements_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aeps_mini_statements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.aeps_mini_statements_id_seq OWNER TO postgres;

--
-- Name: aeps_mini_statements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aeps_mini_statements_id_seq OWNED BY public.aeps_mini_statements.id;


--
-- Name: aeps_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aeps_transactions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    transaction_type character varying,
    client_ref_id character varying,
    customer_id character varying,
    user_code character varying,
    bank_code character varying,
    bank_name character varying,
    aadhaar_number character varying,
    aadhaar_last4 character varying,
    amount numeric(12,2),
    customer_balance numeric(12,2),
    opening_balance numeric(12,2),
    closing_balance numeric(12,2),
    commission numeric(12,2),
    tds numeric(12,2),
    tx_status character varying,
    status character varying,
    message character varying,
    comment text,
    tid character varying,
    bank_ref_num character varying,
    merchant_name character varying,
    sender_name character varying,
    shop_name character varying,
    transaction_date timestamp(6) without time zone,
    provider_response jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.aeps_transactions OWNER TO postgres;

--
-- Name: aeps_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aeps_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.aeps_transactions_id_seq OWNER TO postgres;

--
-- Name: aeps_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aeps_transactions_id_seq OWNED BY public.aeps_transactions.id;


--
-- Name: aeps_wallet_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aeps_wallet_transactions (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    aeps_wallet_id bigint NOT NULL,
    amount numeric(15,2) NOT NULL,
    transaction_type character varying NOT NULL,
    reference_id character varying,
    remarks text,
    balance_before numeric(15,2),
    balance_after numeric(15,2),
    status character varying DEFAULT 'success'::character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.aeps_wallet_transactions OWNER TO postgres;

--
-- Name: aeps_wallet_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aeps_wallet_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.aeps_wallet_transactions_id_seq OWNER TO postgres;

--
-- Name: aeps_wallet_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aeps_wallet_transactions_id_seq OWNED BY public.aeps_wallet_transactions.id;


--
-- Name: aeps_wallets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aeps_wallets (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    balance numeric(15,2) DEFAULT 0.0 NOT NULL,
    status integer DEFAULT 0 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.aeps_wallets OWNER TO postgres;

--
-- Name: aeps_wallets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aeps_wallets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.aeps_wallets_id_seq OWNER TO postgres;

--
-- Name: aeps_wallets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aeps_wallets_id_seq OWNED BY public.aeps_wallets.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: banks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.banks (
    id bigint NOT NULL,
    bank_name character varying,
    account_name character varying,
    ifsc_code character varying,
    account_number character varying,
    account_type character varying,
    first_name character varying,
    last_name character varying,
    initial_balance numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.banks OWNER TO postgres;

--
-- Name: banks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.banks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.banks_id_seq OWNER TO postgres;

--
-- Name: banks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.banks_id_seq OWNED BY public.banks.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    title character varying,
    image character varying,
    status boolean,
    service_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: cibil_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cibil_reports (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    pan character varying,
    mobile_number character varying,
    name character varying,
    credit_score character varying,
    bureau character varying,
    response_data jsonb,
    doc_id character varying,
    status_code integer,
    success boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.cibil_reports OWNER TO postgres;

--
-- Name: cibil_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cibil_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cibil_reports_id_seq OWNER TO postgres;

--
-- Name: cibil_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cibil_reports_id_seq OWNED BY public.cibil_reports.id;


--
-- Name: commissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commissions (
    id bigint NOT NULL,
    commission_type character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    service_product_item_id bigint NOT NULL,
    scheme_id bigint,
    value numeric,
    to_role character varying,
    from_role character varying,
    set_by_role character varying,
    set_for_role character varying,
    commission_rate character varying
);


ALTER TABLE public.commissions OWNER TO postgres;

--
-- Name: commissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.commissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.commissions_id_seq OWNER TO postgres;

--
-- Name: commissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commissions_id_seq OWNED BY public.commissions.id;


--
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    id bigint NOT NULL,
    name character varying,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- Name: departments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.departments_id_seq OWNER TO postgres;

--
-- Name: departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departments_id_seq OWNED BY public.departments.id;


--
-- Name: dmt_commission_slab_ranges; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dmt_commission_slab_ranges (
    id bigint NOT NULL,
    min_amount numeric(10,2),
    max_amount numeric(10,2),
    bank_fee_percent numeric(5,2) DEFAULT 1.0,
    eko_fee numeric(10,2) DEFAULT 7.0,
    surcharge numeric(10,2) DEFAULT 0.0,
    tds_percent numeric(5,2) DEFAULT 2.0,
    gst_percent numeric(5,2) DEFAULT 2.0,
    from_role character varying,
    to_role character varying,
    value numeric(10,2),
    active boolean DEFAULT true,
    scheme_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.dmt_commission_slab_ranges OWNER TO postgres;

--
-- Name: dmt_commission_slab_ranges_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dmt_commission_slab_ranges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dmt_commission_slab_ranges_id_seq OWNER TO postgres;

--
-- Name: dmt_commission_slab_ranges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dmt_commission_slab_ranges_id_seq OWNED BY public.dmt_commission_slab_ranges.id;


--
-- Name: dmt_commission_slabs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dmt_commission_slabs (
    id bigint NOT NULL,
    min_amount numeric(10,2),
    max_amount numeric(10,2),
    bank_fee_percent numeric(5,2) DEFAULT 1.0,
    eko_fee numeric(10,2) DEFAULT 7.0,
    surcharge numeric(10,2) DEFAULT 0.0,
    tds_percent numeric(5,2) DEFAULT 2.0,
    gst_percent numeric(5,2) DEFAULT 2.0,
    from_role character varying,
    to_role character varying,
    value numeric(10,2),
    active boolean DEFAULT true,
    scheme_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    dmt_commission_slab_range_id bigint NOT NULL
);


ALTER TABLE public.dmt_commission_slabs OWNER TO postgres;

--
-- Name: dmt_commission_slabs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dmt_commission_slabs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dmt_commission_slabs_id_seq OWNER TO postgres;

--
-- Name: dmt_commission_slabs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dmt_commission_slabs_id_seq OWNED BY public.dmt_commission_slabs.id;


--
-- Name: dmt_commissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dmt_commissions (
    id bigint NOT NULL,
    dmt_id integer NOT NULL,
    user_id integer NOT NULL,
    role character varying,
    commission_amount numeric(10,4),
    service_product_item_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.dmt_commissions OWNER TO postgres;

--
-- Name: dmt_commissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dmt_commissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dmt_commissions_id_seq OWNER TO postgres;

--
-- Name: dmt_commissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dmt_commissions_id_seq OWNED BY public.dmt_commissions.id;


--
-- Name: dmt_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dmt_transactions (
    id bigint NOT NULL,
    dmt_id integer,
    user_id integer,
    status character varying,
    txn_id character varying,
    sender_mobile_number character varying,
    bank_name character varying,
    account_number character varying,
    amount numeric,
    parent_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    fee numeric(10,2) DEFAULT 0.0,
    tid character varying,
    tds numeric(10,2) DEFAULT 0.0,
    service_tax numeric(10,2) DEFAULT 0.0,
    commission numeric(10,2) DEFAULT 0.0,
    txstatus_desc character varying,
    collectable_amount numeric(12,2) DEFAULT 0.0
);


ALTER TABLE public.dmt_transactions OWNER TO postgres;

--
-- Name: dmt_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dmt_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dmt_transactions_id_seq OWNER TO postgres;

--
-- Name: dmt_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dmt_transactions_id_seq OWNED BY public.dmt_transactions.id;


--
-- Name: dmts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dmts (
    id bigint NOT NULL,
    account_number character varying,
    confirm_account_number character varying,
    sender_mobile_number character varying,
    receiver_name character varying,
    receiver_mobile_number character varying,
    sender_full_name character varying,
    bank_name character varying,
    ifsc_code character varying,
    branch_name character varying,
    amount numeric,
    parent_id integer,
    user_id integer,
    beneficiaries_status boolean,
    status character varying,
    aadhaar_number_otp character varying,
    aadhaar_number_otp_expiry timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    customer_id character varying,
    recipient_id bigint,
    bank_verify_status boolean DEFAULT false,
    vendor_user_id bigint,
    txn_id character varying,
    transaction_status boolean DEFAULT false
);


ALTER TABLE public.dmts OWNER TO postgres;

--
-- Name: dmts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dmts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dmts_id_seq OWNER TO postgres;

--
-- Name: dmts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dmts_id_seq OWNED BY public.dmts.id;


--
-- Name: eko_banks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.eko_banks (
    id bigint NOT NULL,
    bank_id character varying,
    name character varying,
    ifsc_prefix character varying,
    bank_code character varying,
    status boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.eko_banks OWNER TO postgres;

--
-- Name: eko_banks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.eko_banks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.eko_banks_id_seq OWNER TO postgres;

--
-- Name: eko_banks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.eko_banks_id_seq OWNED BY public.eko_banks.id;


--
-- Name: enquiries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.enquiries (
    id bigint NOT NULL,
    first_name character varying,
    last_name character varying,
    email character varying,
    phone_number character varying,
    aadhaar_number character varying,
    pan_card character varying,
    status boolean DEFAULT false,
    role_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.enquiries OWNER TO postgres;

--
-- Name: enquiries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.enquiries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.enquiries_id_seq OWNER TO postgres;

--
-- Name: enquiries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.enquiries_id_seq OWNED BY public.enquiries.id;


--
-- Name: fund_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fund_requests (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    requested_by integer,
    amount numeric,
    status character varying,
    approved_by integer,
    approved_at timestamp(6) without time zone,
    remark character varying,
    image character varying,
    transaction_type character varying,
    mode character varying,
    bank_reference_no character varying,
    payment_mode character varying,
    deposit_bank character varying,
    your_bank character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    account_number character varying,
    reject_note character varying,
    deposit_account_no character varying,
    deposit_ifsc_code character varying,
    ifsc_code character varying
);


ALTER TABLE public.fund_requests OWNER TO postgres;

--
-- Name: fund_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.fund_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fund_requests_id_seq OWNER TO postgres;

--
-- Name: fund_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fund_requests_id_seq OWNED BY public.fund_requests.id;


--
-- Name: leads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leads (
    id bigint NOT NULL,
    name character varying,
    mobile character varying,
    email character varying,
    address text,
    director character varying,
    loan_type character varying,
    loan_ac character varying,
    total_outstanding numeric,
    borrower_info text,
    emi_amount numeric,
    service_id integer,
    user_id bigint NOT NULL,
    adhaar_image character varying,
    pan_image character varying,
    notice_image character varying,
    check_image character varying,
    address_proof character varying,
    amount numeric,
    status character varying,
    account_number character varying,
    date date,
    image character varying,
    area character varying,
    bank_name character varying,
    branch_address text,
    officer_name character varying,
    designation character varying,
    borrower_name character varying,
    co_borrower character varying,
    loan_account_number character varying,
    borrower_address text,
    outstanding_amount numeric,
    npa_date date,
    notice_132_date date,
    expiry_date date,
    property_address text,
    survey_number character varying,
    north_boundary character varying,
    south_boundary character varying,
    east_boundary character varying,
    west_boundary character varying,
    possession_type character varying,
    possession_date date,
    possession_place character varying,
    notice_issue_date date,
    issue_place character varying,
    pending_message text,
    reject_message text,
    ca_id integer,
    lawyer_id integer,
    document_permission_status character varying,
    lead_status character varying,
    befor_sumbit_mca_status character varying,
    document_status character varying,
    payment_status character varying,
    review_status character varying,
    step_status character varying,
    service_type character varying,
    lead_ref_id character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.leads OWNER TO postgres;

--
-- Name: leads_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.leads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.leads_id_seq OWNER TO postgres;

--
-- Name: leads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.leads_id_seq OWNED BY public.leads.id;


--
-- Name: leave_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leave_requests (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    parent_id bigint,
    start_date date,
    end_date date,
    total_days integer,
    reason text,
    status character varying DEFAULT 'pending'::character varying,
    reject_note text,
    approve_note text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.leave_requests OWNER TO postgres;

--
-- Name: leave_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.leave_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.leave_requests_id_seq OWNER TO postgres;

--
-- Name: leave_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.leave_requests_id_seq OWNED BY public.leave_requests.id;


--
-- Name: refund_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refund_requests (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    transaction_id bigint NOT NULL,
    parent_id bigint NOT NULL,
    refund_id character varying,
    refund_type character varying,
    amount numeric(15,2),
    reason text,
    status character varying,
    admin_note text,
    processed_at timestamp(6) without time zone,
    processed_by integer,
    attachment_url character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.refund_requests OWNER TO postgres;

--
-- Name: refund_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.refund_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.refund_requests_id_seq OWNER TO postgres;

--
-- Name: refund_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.refund_requests_id_seq OWNED BY public.refund_requests.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    title character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: salaries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salaries (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    month character varying,
    year integer,
    total_days integer,
    leave_days integer,
    working_days integer,
    per_day_salary numeric,
    total_salary numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.salaries OWNER TO postgres;

--
-- Name: salaries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.salaries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.salaries_id_seq OWNER TO postgres;

--
-- Name: salaries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.salaries_id_seq OWNED BY public.salaries.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: schemes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schemes (
    id bigint NOT NULL,
    scheme_name character varying,
    scheme_type character varying,
    commision_rate numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    user_id bigint
);


ALTER TABLE public.schemes OWNER TO postgres;

--
-- Name: schemes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.schemes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.schemes_id_seq OWNER TO postgres;

--
-- Name: schemes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.schemes_id_seq OWNED BY public.schemes.id;


--
-- Name: service_product_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_product_items (
    id bigint NOT NULL,
    service_product_id bigint NOT NULL,
    name character varying,
    oprator_type character varying,
    status character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    operator_id bigint
);


ALTER TABLE public.service_product_items OWNER TO postgres;

--
-- Name: service_product_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.service_product_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_product_items_id_seq OWNER TO postgres;

--
-- Name: service_product_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.service_product_items_id_seq OWNED BY public.service_product_items.id;


--
-- Name: service_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.service_products (
    id bigint NOT NULL,
    company_name character varying,
    admin_commission numeric,
    master_commission numeric,
    dealer_commission numeric,
    retailer_commission numeric,
    category_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.service_products OWNER TO postgres;

--
-- Name: service_products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.service_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.service_products_id_seq OWNER TO postgres;

--
-- Name: service_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.service_products_id_seq OWNED BY public.service_products.id;


--
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id bigint NOT NULL,
    title character varying,
    status boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    logo character varying,
    "position" integer
);


ALTER TABLE public.services OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.services_id_seq OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- Name: support_tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.support_tickets (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    ticket_number character varying,
    full_name character varying,
    email character varying,
    service_type character varying,
    reference_id character varying,
    subject character varying,
    description text,
    status character varying,
    status_updated_at timestamp(6) without time zone,
    resolution_note text,
    resolved_at timestamp(6) without time zone,
    assigned_agent_id integer,
    attachment_url character varying,
    parent_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.support_tickets OWNER TO postgres;

--
-- Name: support_tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.support_tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.support_tickets_id_seq OWNER TO postgres;

--
-- Name: support_tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.support_tickets_id_seq OWNED BY public.support_tickets.id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    id bigint NOT NULL,
    title character varying,
    description text,
    priority character varying,
    status character varying,
    task_status character varying,
    deadline timestamp(6) without time zone,
    user_id bigint NOT NULL,
    department_id bigint NOT NULL,
    assigned_to integer,
    pending_note text,
    approved_note text,
    note text,
    lead_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tasks_id_seq OWNER TO postgres;

--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: transaction_commissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction_commissions (
    id bigint NOT NULL,
    transaction_id bigint NOT NULL,
    user_id bigint NOT NULL,
    role integer,
    commission_amount numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    service_product_item_id bigint
);


ALTER TABLE public.transaction_commissions OWNER TO postgres;

--
-- Name: transaction_commissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transaction_commissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transaction_commissions_id_seq OWNER TO postgres;

--
-- Name: transaction_commissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transaction_commissions_id_seq OWNED BY public.transaction_commissions.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id bigint NOT NULL,
    tx_id character varying,
    operator character varying,
    transaction_type character varying,
    account_or_mobile character varying,
    amount numeric,
    status character varying,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    service_product_id bigint,
    consumer_name character varying,
    subscriber_or_vc_number character varying,
    bill_no character varying,
    landline_no character varying,
    std_code character varying,
    tid character varying,
    tds numeric,
    sender_id character varying,
    payment_mode_desc character varying,
    totalamount numeric,
    status_text character varying,
    txstatus_desc character varying,
    commission character varying,
    mobile character varying,
    vehicle_no character varying,
    card_number character varying
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO postgres;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: user_services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_services (
    id bigint NOT NULL,
    assigner_id bigint NOT NULL,
    assignee_id bigint NOT NULL,
    service_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.user_services OWNER TO postgres;

--
-- Name: user_services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_services_id_seq OWNER TO postgres;

--
-- Name: user_services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_services_id_seq OWNED BY public.user_services.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    first_name character varying,
    last_name character varying,
    email character varying,
    password_digest character varying,
    role integer,
    otp integer,
    verify_otp integer,
    otp_expires_at timestamp(6) without time zone,
    phone_number character varying,
    country_code character varying,
    alternative_number character varying,
    aadhaar_number character varying,
    pan_card character varying,
    date_of_birth date,
    gender character varying,
    business_name character varying,
    business_owner_type character varying,
    business_nature_type character varying,
    business_registration_number character varying,
    gst_number character varying,
    pan_number character varying,
    address text,
    city character varying,
    state character varying,
    pincode character varying,
    landmark character varying,
    username character varying,
    scheme character varying,
    referred_by character varying,
    bank_name character varying,
    account_number character varying,
    ifsc_code character varying,
    account_holder_name character varying,
    notes text,
    session_token text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    role_id bigint DEFAULT 1 NOT NULL,
    status boolean DEFAULT false,
    company_type character varying,
    company_name character varying,
    cin_number character varying,
    registration_certificate character varying,
    user_admin_id integer,
    confirm_password character varying,
    domain_name character varying,
    scheme_id bigint,
    service_id bigint,
    pan_card_image character varying,
    aadhaar_image character varying,
    passport_photo character varying,
    store_shop_photo character varying,
    address_proof_photo character varying,
    parent_id integer,
    set_pin character varying,
    confirm_pin character varying,
    latitude numeric(10,6),
    longitude numeric(10,6),
    captured_at timestamp(6) without time zone,
    last_seen_at timestamp(6) without time zone,
    ip_address character varying,
    location character varying,
    kyc_status character varying DEFAULT 'not_started'::character varying,
    kyc_method character varying,
    aadhaar_front_image character varying,
    aadhaar_back_image character varying,
    aadhaar_otp character varying,
    pan_otp character varying,
    pan_status character varying DEFAULT 'not_started'::character varying,
    aadhaar_status character varying DEFAULT 'not_started'::character varying,
    image character varying,
    kyc_verifications boolean DEFAULT false,
    kyc_verified_at timestamp(6) without time zone,
    kyc_data jsonb DEFAULT '{}'::jsonb NOT NULL,
    set_mpin character varying,
    status_mpin boolean,
    email_otp_status boolean DEFAULT false NOT NULL,
    email_otp character varying,
    email_otp_verified_at timestamp(6) without time zone,
    set_pin_status boolean DEFAULT false,
    email_otp_sent_at timestamp(6) without time zone,
    user_code character varying,
    eko_onboard_first_step boolean DEFAULT false,
    eko_profile_second_step boolean DEFAULT false,
    eko_status_otp boolean DEFAULT false,
    eko_verify_otp boolean DEFAULT false,
    eko_biometric_kyc boolean DEFAULT false,
    vendor_otp character varying,
    vendor_expiry_otp timestamp(6) without time zone,
    vendor_verify_status boolean DEFAULT false,
    permanent_address character varying,
    permanent_landmark character varying,
    permanent_postal_code character varying,
    permanent_city character varying,
    permanent_state character varying,
    permanent_pincode character varying,
    aeps_kyc boolean DEFAULT false NOT NULL,
    daily_aeps_kyc boolean DEFAULT false NOT NULL,
    aeps_service_activate boolean DEFAULT false NOT NULL,
    aeps_latlong character varying,
    login_in_time timestamp(6) without time zone,
    logout_time timestamp(6) without time zone,
    ip_city character varying,
    ip_location character varying,
    bank_code character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: vendor_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendor_users (
    id bigint NOT NULL,
    full_name character varying,
    phone_number character varying,
    otp character varying,
    vendor_expiry_otp timestamp(6) without time zone,
    vendor_verify_status boolean DEFAULT false,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    addhar_kyc_status boolean DEFAULT false,
    user_code character varying,
    sender_phone_number character varying
);


ALTER TABLE public.vendor_users OWNER TO postgres;

--
-- Name: vendor_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendor_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendor_users_id_seq OWNER TO postgres;

--
-- Name: vendor_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendor_users_id_seq OWNED BY public.vendor_users.id;


--
-- Name: wallet_histories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wallet_histories (
    id bigint NOT NULL,
    wallet_id bigint NOT NULL,
    user_id integer,
    parent_id integer,
    amount numeric(15,2),
    before_balance numeric(15,2),
    after_balance numeric(15,2),
    transaction_type character varying,
    remark character varying,
    reference_id character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.wallet_histories OWNER TO postgres;

--
-- Name: wallet_histories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wallet_histories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wallet_histories_id_seq OWNER TO postgres;

--
-- Name: wallet_histories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wallet_histories_id_seq OWNED BY public.wallet_histories.id;


--
-- Name: wallet_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wallet_transactions (
    id bigint NOT NULL,
    wallet_id bigint NOT NULL,
    tx_id character varying(50) NOT NULL,
    mode character varying NOT NULL,
    transaction_type character varying NOT NULL,
    amount numeric(12,2) NOT NULL,
    status character varying DEFAULT 'pending'::character varying,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    fund_request_id bigint NOT NULL
);


ALTER TABLE public.wallet_transactions OWNER TO postgres;

--
-- Name: wallet_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wallet_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wallet_transactions_id_seq OWNER TO postgres;

--
-- Name: wallet_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wallet_transactions_id_seq OWNED BY public.wallet_transactions.id;


--
-- Name: wallets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wallets (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    balance numeric,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.wallets OWNER TO postgres;

--
-- Name: wallets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.wallets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.wallets_id_seq OWNER TO postgres;

--
-- Name: wallets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wallets_id_seq OWNED BY public.wallets.id;


--
-- Name: account_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_transactions ALTER COLUMN id SET DEFAULT nextval('public.account_transactions_id_seq'::regclass);


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: aeps_commission_slab_ranges id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeps_commission_slab_ranges ALTER COLUMN id SET DEFAULT nextval('public.aeps_commission_slab_ranges_id_seq'::regclass);


--
-- Name: aeps_commission_slabs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeps_commission_slabs ALTER COLUMN id SET DEFAULT nextval('public.aeps_commission_slabs_id_seq'::regclass);


--
-- Name: aeps_mini_statements id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeps_mini_statements ALTER COLUMN id SET DEFAULT nextval('public.aeps_mini_statements_id_seq'::regclass);


--
-- Name: aeps_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeps_transactions ALTER COLUMN id SET DEFAULT nextval('public.aeps_transactions_id_seq'::regclass);


--
-- Name: aeps_wallet_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeps_wallet_transactions ALTER COLUMN id SET DEFAULT nextval('public.aeps_wallet_transactions_id_seq'::regclass);


--
-- Name: aeps_wallets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeps_wallets ALTER COLUMN id SET DEFAULT nextval('public.aeps_wallets_id_seq'::regclass);


--
-- Name: banks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banks ALTER COLUMN id SET DEFAULT nextval('public.banks_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: cibil_reports id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cibil_reports ALTER COLUMN id SET DEFAULT nextval('public.cibil_reports_id_seq'::regclass);


--
-- Name: commissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commissions ALTER COLUMN id SET DEFAULT nextval('public.commissions_id_seq'::regclass);


--
-- Name: departments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments ALTER COLUMN id SET DEFAULT nextval('public.departments_id_seq'::regclass);


--
-- Name: dmt_commission_slab_ranges id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmt_commission_slab_ranges ALTER COLUMN id SET DEFAULT nextval('public.dmt_commission_slab_ranges_id_seq'::regclass);


--
-- Name: dmt_commission_slabs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmt_commission_slabs ALTER COLUMN id SET DEFAULT nextval('public.dmt_commission_slabs_id_seq'::regclass);


--
-- Name: dmt_commissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmt_commissions ALTER COLUMN id SET DEFAULT nextval('public.dmt_commissions_id_seq'::regclass);


--
-- Name: dmt_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmt_transactions ALTER COLUMN id SET DEFAULT nextval('public.dmt_transactions_id_seq'::regclass);


--
-- Name: dmts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmts ALTER COLUMN id SET DEFAULT nextval('public.dmts_id_seq'::regclass);


--
-- Name: eko_banks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eko_banks ALTER COLUMN id SET DEFAULT nextval('public.eko_banks_id_seq'::regclass);


--
-- Name: enquiries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enquiries ALTER COLUMN id SET DEFAULT nextval('public.enquiries_id_seq'::regclass);


--
-- Name: fund_requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fund_requests ALTER COLUMN id SET DEFAULT nextval('public.fund_requests_id_seq'::regclass);


--
-- Name: leads id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leads ALTER COLUMN id SET DEFAULT nextval('public.leads_id_seq'::regclass);


--
-- Name: leave_requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_requests ALTER COLUMN id SET DEFAULT nextval('public.leave_requests_id_seq'::regclass);


--
-- Name: refund_requests id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refund_requests ALTER COLUMN id SET DEFAULT nextval('public.refund_requests_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: salaries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaries ALTER COLUMN id SET DEFAULT nextval('public.salaries_id_seq'::regclass);


--
-- Name: schemes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schemes ALTER COLUMN id SET DEFAULT nextval('public.schemes_id_seq'::regclass);


--
-- Name: service_product_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_product_items ALTER COLUMN id SET DEFAULT nextval('public.service_product_items_id_seq'::regclass);


--
-- Name: service_products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_products ALTER COLUMN id SET DEFAULT nextval('public.service_products_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Name: support_tickets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_tickets ALTER COLUMN id SET DEFAULT nextval('public.support_tickets_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: transaction_commissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_commissions ALTER COLUMN id SET DEFAULT nextval('public.transaction_commissions_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: user_services id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_services ALTER COLUMN id SET DEFAULT nextval('public.user_services_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: vendor_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_users ALTER COLUMN id SET DEFAULT nextval('public.vendor_users_id_seq'::regclass);


--
-- Name: wallet_histories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_histories ALTER COLUMN id SET DEFAULT nextval('public.wallet_histories_id_seq'::regclass);


--
-- Name: wallet_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions ALTER COLUMN id SET DEFAULT nextval('public.wallet_transactions_id_seq'::regclass);


--
-- Name: wallets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets ALTER COLUMN id SET DEFAULT nextval('public.wallets_id_seq'::regclass);


--
-- Data for Name: account_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_transactions (id, txn_id, amount, reason, user_code, mobile, txn_type, user_type, user_name, status, parent_id, user_id, wallet_id, created_at, updated_at) FROM stdin;
1	TXN927104	2.0	Reason 1	\N	323243434343	Credit	\N	\N	success	104	127	8	2025-09-15 06:38:25.675895	2025-09-15 06:38:25.675895
2	TXN778846	2.0	Reason 1	\N	323243434343	Debit	\N	\N	success	104	127	8	2025-09-15 06:39:18.562588	2025-09-15 06:39:18.562588
3	TXN734549	2.0	Reason 1	\N	323243434343	Credit	\N	\N	success	104	127	8	2025-09-15 06:43:02.435203	2025-09-15 06:43:02.435203
4	TXN433798	2.0	Reason 1	\N	323243434343	Debit	\N	\N	success	104	127	8	2025-09-15 06:43:38.828927	2025-09-15 06:43:38.828927
5	TXN505620	2.0	Reason 1	\N	323243434343	Debit	\N	\N	success	104	127	8	2025-09-15 06:45:00.906546	2025-09-15 06:45:00.906546
6	TXN102263	5.0	Reason 1	\N	323243434343	Debit	\N	\N	success	104	127	8	2025-09-15 06:45:30.808059	2025-09-15 06:45:30.808059
7	TXN260008	5.0	Reason 1	\N	323243434343	Credit	\N	\N	success	104	127	8	2025-09-15 06:46:23.242174	2025-09-15 06:46:23.242174
8	TXN541011	5.0	Reason 1	\N	323243434343	Credit	\N	\N	success	104	127	8	2025-09-15 06:48:36.899376	2025-09-15 06:48:36.899376
9	TXN151049	5.0	Reason 1	\N	323243434343	Debit	\N	\N	success	104	127	8	2025-09-15 06:49:14.379198	2025-09-15 06:49:14.379198
10	TXN179949	5.0	Reason 1	\N	94434349494	Credit	\N	\N	success	\N	104	7	2025-09-15 06:51:02.519043	2025-09-15 06:51:02.519043
11	TXN182174	5.0	Reason 1	\N	94434349494	Credit	\N	\N	success	136	104	7	2025-09-15 06:52:13.362436	2025-09-15 06:52:13.362436
12	TXN139539	5.0	Reason 1	\N	94434349494	Debit	\N	\N	success	136	104	7	2025-09-15 06:53:48.242601	2025-09-15 06:53:48.242601
13	TXN579314	120.0	Reason 1	\N	9568773855	Credit	\N	\N	success	104	134	10	2025-09-15 13:04:00.408368	2025-09-15 13:04:00.408368
14	TXN657453	8.0	Reason 1	\N	9568773855	Debit	\N	\N	success	104	134	10	2025-09-15 13:04:42.802394	2025-09-15 13:04:42.802394
15	TXN676719	100.0	Reason 1	\N	9568773855	Debit	\N	\N	success	104	134	10	2025-09-15 13:42:54.72828	2025-09-15 13:42:54.72828
16	TXN512730	120.0	Reason 1	\N	9568773855	Credit	\N	\N	success	104	134	10	2025-09-15 13:43:52.551655	2025-09-15 13:43:52.551655
17	TXN668514	2.0	Reason 1	\N	94434349494	Credit	\N	\N	success	136	104	7	2025-09-15 17:26:29.17496	2025-09-15 17:26:29.17496
18	TXN532510	50000.0	Reason 1	\N	9568773855	Credit	\N	\N	success	104	134	10	2025-09-16 13:23:25.848647	2025-09-16 13:23:25.848647
19	TXN133148	0.0	\N	\N	\N	Credit	\N	\N	success	104	145	61	2025-11-20 06:19:09.385828	2025-11-20 06:19:09.385828
20	TXN352648	0.0	\N	\N	\N	Credit	\N	\N	success	104	145	61	2025-11-20 06:21:45.512352	2025-11-20 06:21:45.512352
21	TXN979778	100.0	reason1	\N	\N	Credit	\N	\N	success	104	145	61	2025-11-20 07:30:04.786023	2025-11-20 07:30:04.786023
22	TXN225023	70.0	reason2	\N	\N	Credit	\N	\N	success	104	145	61	2025-11-20 07:31:06.941589	2025-11-20 07:31:06.941589
23	TXN745885	24.0	reason1	\N	\N	Credit	\N	\N	success	104	145	61	2025-11-20 07:38:43.541669	2025-11-20 07:38:43.541669
24	TXN469470	76.0	reason1	\N	\N	Credit	\N	\N	success	104	145	61	2025-11-20 07:46:13.927959	2025-11-20 07:46:13.927959
25	TXN309716	100.0	reason1	\N	7778889990	Credit	\N	\N	success	104	139	9	2025-11-20 07:55:50.510156	2025-11-20 07:55:50.510156
26	TXN276866	0.0	\N	\N	\N	Debit	\N	\N	success	104	145	61	2025-11-20 08:36:17.828385	2025-11-20 08:36:17.828385
27	TXN487811	100.0	reason1	\N	7778889990	Debit	\N	\N	success	104	139	9	2025-11-20 08:46:59.206159	2025-11-20 08:46:59.206159
28	TXN842077	76.5	penalty	\N	7778889990	Debit	\N	\N	success	104	139	9	2025-11-20 09:02:53.937816	2025-11-20 09:02:53.937816
29	TXN938979	1.0	referral	\N	7778889990	Credit	\N	\N	success	104	139	9	2025-11-20 11:41:33.766493	2025-11-20 11:41:33.766493
30	TXN941901	2.0	penalty	\N	7778889990	Debit	\N	\N	success	104	139	9	2025-11-20 11:42:27.541887	2025-11-20 11:42:27.541887
31	TXN623675	100.0	refund	\N	7778889990	Credit	\N	\N	success	104	139	9	2025-11-20 11:50:09.857604	2025-11-20 11:50:09.857604
32	TXN601349	100.0	bonus	\N	7778889990	Credit	\N	\N	success	104	139	9	2025-11-20 11:52:58.923836	2025-11-20 11:52:58.923836
33	TXN705433	1.0	bonus	\N	7778889990	Credit	\N	\N	success	104	139	9	2025-11-20 12:25:57.551199	2025-11-20 12:25:57.551199
34	TXN528823	2.0	commission	\N	7778889990	Debit	\N	\N	success	104	139	9	2025-11-20 12:27:06.797739	2025-11-20 12:27:06.797739
35	TXN341028	1.0	technical_issue	\N	9999999999	Debit	\N	\N	success	169	175	66	2025-11-27 08:42:03.947942	2025-11-27 08:42:03.947942
36	TXN108281	99.0	cashback	\N	9999999999	Credit	\N	\N	success	169	175	66	2025-11-27 08:50:48.798629	2025-11-27 08:50:48.798629
37	TXN111099	10.0	adjustment	\N	9999999999	Debit	\N	\N	success	169	175	66	2025-11-27 12:16:48.433765	2025-11-27 12:16:48.433765
38	TXN479780	19.0	adjustment	\N	9999999999	Credit	\N	\N	success	169	175	66	2025-11-27 12:17:50.040646	2025-11-27 12:17:50.040646
39	TXN296619	7.0	adjustment	\N	9999999999	Debit	\N	\N	success	169	175	66	2025-11-27 12:33:44.473128	2025-11-27 12:33:44.473128
40	TXN281771	7.0	promotional	\N	9999999999	Credit	\N	\N	success	169	175	66	2025-11-27 12:34:38.437978	2025-11-27 12:34:38.437978
41	TXN695222	10.0	commission	\N	9999999999	Debit	\N	\N	success	169	175	66	2025-11-27 12:38:48.630412	2025-11-27 12:38:48.630412
42	TXN3FBC0899	4500.0	Reason 1	\N	03443434334	credit	\N	\N	success	136	181	71	2026-05-26 12:31:58.131593	2026-05-26 12:31:58.131593
43	TXNDD07AC7C	200.0	commission	\N	9348075033	Credit	\N	\N	success	181	189	72	2026-05-27 13:22:47.467657	2026-05-27 13:22:47.467657
44	TXNB3BCC4D0	20.0	other	\N	8280251228	Credit	\N	\N	success	181	193	75	2026-05-29 12:11:02.229309	2026-05-29 12:11:02.229309
45	TXN01FFD307	200.0	promotional	\N	9348075033	Credit	\N	\N	success	181	189	72	2026-06-03 08:23:16.459844	2026-06-03 08:23:16.459844
46	TXN1F8FDAF5	100.0	other	\N	9348075033	Credit	\N	\N	success	181	189	72	2026-06-07 13:50:52.728376	2026-06-07 13:50:52.728376
47	TXN66EF0B99	20.0	referral	\N	7846960035	Credit	\N	\N	success	181	194	76	2026-07-06 12:08:56.545756	2026-07-06 12:08:56.545756
48	TXN11DBF814	100.0	other	\N	7846960035	Credit	\N	\N	success	181	194	76	2026-07-06 12:11:03.193898	2026-07-06 12:11:03.193898
\.


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
\.


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, service_name, byte_size, checksum, created_at) FROM stdin;
\.


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
\.


--
-- Data for Name: aeps_commission_slab_ranges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aeps_commission_slab_ranges (id, min_amount, max_amount, bank_fee_percent, eko_fee, surcharge, tds_percent, gst_percent, from_role, to_role, value, active, scheme_id, created_at, updated_at, service_type) FROM stdin;
1	101.0	25000.0	\N	\N	\N	\N	18.0	superadmin	admin	5.0	t	5	2026-08-07 06:20:35.832923	2026-08-07 06:20:35.832923	fund_settlement
3	3000.0	10000.0	\N	\N	\N	\N	\N	superadmin	admin	13.0	\N	5	2026-08-07 06:22:45.950593	2026-08-07 06:22:45.950593	transaction
4	1.0	999999999.0	\N	\N	\N	\N	\N	superadmin	admin	0.75	t	5	2026-08-07 06:22:45.954132	2026-08-07 06:22:45.954132	mini_statement
7	25001.0	200000.0	\N	\N	\N	\N	18.0	superadmin	admin	10.0	t	5	2026-08-07 06:22:45.96407	2026-08-07 06:22:45.96407	fund_settlement
2	100.0	3000.0	\N	\N	\N	\N	\N	superadmin	admin	0.4	\N	5	2026-08-07 06:22:45.946979	2026-08-07 11:20:47.73551	transaction
8	1.0	99000.0	\N	\N	\N	\N	18.0	superadmin	admin	5.0	t	5	2026-08-07 12:18:59.542677	2026-08-07 12:18:59.542677	balance_enquiry
\.


--
-- Data for Name: aeps_commission_slabs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aeps_commission_slabs (id, min_amount, max_amount, bank_fee_percent, eko_fee, surcharge, tds_percent, gst_percent, from_role, to_role, value, active, scheme_id, aeps_commission_slab_range_id, created_at, updated_at, service_type) FROM stdin;
1	100.0	3000.0	\N	\N	\N	\N	\N	admin	master	1.0	t	21	2	2026-08-07 06:29:10.053352	2026-08-07 06:29:10.053352	transaction
2	100.0	3000.0	\N	\N	\N	\N	\N	admin	dealer	2.0	t	21	2	2026-08-07 06:29:10.061388	2026-08-07 06:29:10.061388	transaction
3	100.0	3000.0	\N	\N	\N	\N	\N	admin	retailer	2.0	t	21	2	2026-08-07 06:29:10.067826	2026-08-07 06:29:10.067826	transaction
4	100.0	3000.0	\N	\N	\N	\N	\N	admin	master	2.0	t	44	2	2026-08-07 11:19:20.744675	2026-08-07 11:19:20.744675	transaction
5	100.0	3000.0	\N	\N	\N	\N	\N	admin	dealer	3.0	t	44	2	2026-08-07 11:19:20.756425	2026-08-07 11:19:20.756425	transaction
6	100.0	3000.0	\N	\N	\N	\N	\N	admin	retailer	4.0	t	44	2	2026-08-07 11:19:20.762112	2026-08-07 11:19:20.762112	transaction
7	100.0	3000.0	\N	\N	\N	\N	\N	admin	master	0.1	t	45	2	2026-08-07 11:22:03.376224	2026-08-07 11:22:03.376224	transaction
8	100.0	3000.0	\N	\N	\N	\N	\N	admin	dealer	0.1	t	45	2	2026-08-07 11:22:03.382676	2026-08-07 11:22:03.382676	transaction
9	100.0	3000.0	\N	\N	\N	\N	\N	admin	retailer	0.2	t	45	2	2026-08-07 11:22:03.389659	2026-08-07 11:22:03.389659	transaction
10	3000.0	10000.0	\N	\N	\N	\N	\N	admin	master	2.0	t	45	3	2026-08-07 11:22:34.085938	2026-08-07 11:22:34.085938	transaction
11	3000.0	10000.0	\N	\N	\N	\N	\N	admin	dealer	3.0	t	45	3	2026-08-07 11:22:34.095264	2026-08-07 11:22:34.095264	transaction
12	3000.0	10000.0	\N	\N	\N	\N	\N	admin	retailer	5.0	t	45	3	2026-08-07 11:22:34.104523	2026-08-07 11:22:34.104523	transaction
13	0.0	999999999.0	\N	\N	\N	\N	\N	admin	master	0.2	t	45	5	2026-08-07 11:23:56.138521	2026-08-07 11:23:56.138521	mini_statement
14	0.0	999999999.0	\N	\N	\N	\N	\N	admin	retailer	0.2	t	45	5	2026-08-07 11:23:56.146162	2026-08-07 11:23:56.146162	mini_statement
15	1.0	999999999.0	\N	\N	\N	\N	\N	admin	master	0.1	t	45	4	2026-08-07 11:24:39.44741	2026-08-07 11:24:39.44741	mini_statement
16	1.0	999999999.0	\N	\N	\N	\N	\N	admin	retailer	0.3	t	45	4	2026-08-07 11:24:39.452861	2026-08-07 11:24:39.452861	mini_statement
17	101.0	25000.0	\N	\N	\N	\N	18.0	admin	master	1.0	t	45	6	2026-08-07 11:26:25.439278	2026-08-07 11:26:25.439278	fund_settlement
18	101.0	25000.0	\N	\N	\N	\N	18.0	admin	retailer	2.0	t	45	6	2026-08-07 11:26:25.450667	2026-08-07 11:26:25.450667	fund_settlement
19	25001.0	200000.0	\N	\N	\N	\N	18.0	admin	master	2.0	t	45	7	2026-08-07 11:26:55.773677	2026-08-07 11:26:55.773677	fund_settlement
20	25001.0	200000.0	\N	\N	\N	\N	18.0	admin	retailer	4.0	t	45	7	2026-08-07 11:26:55.782555	2026-08-07 11:26:55.782555	fund_settlement
21	1.0	999999999.0	\N	\N	\N	\N	\N	admin	dealer	0.2	t	45	4	2026-08-07 11:51:08.004452	2026-08-07 11:51:08.004452	mini_statement
22	101.0	25000.0	\N	\N	\N	\N	18.0	admin	master	1.0	t	45	1	2026-08-07 11:51:38.911765	2026-08-07 11:51:38.911765	fund_settlement
23	101.0	25000.0	\N	\N	\N	\N	18.0	admin	dealer	1.0	t	45	1	2026-08-07 11:51:38.992493	2026-08-07 11:51:38.992493	fund_settlement
24	101.0	25000.0	\N	\N	\N	\N	18.0	admin	retailer	1.0	t	45	1	2026-08-07 11:51:39.064323	2026-08-07 11:51:39.064323	fund_settlement
25	25001.0	200000.0	\N	\N	\N	\N	18.0	admin	dealer	1.0	t	45	7	2026-08-07 11:51:45.65809	2026-08-07 11:51:45.65809	fund_settlement
26	1.0	999999999.0	\N	\N	\N	\N	\N	admin	master	0.4	t	20	4	2026-08-13 11:58:37.446752	2026-08-13 11:58:37.446752	mini_statement
27	1.0	999999999.0	\N	\N	\N	\N	\N	admin	dealer	0.3	t	20	4	2026-08-13 11:58:37.465093	2026-08-13 11:58:37.465093	mini_statement
28	1.0	999999999.0	\N	\N	\N	\N	\N	admin	retailer	0.05	t	20	4	2026-08-13 11:58:37.471527	2026-08-13 11:58:37.471527	mini_statement
\.


--
-- Data for Name: aeps_mini_statements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aeps_mini_statements (id, user_id, bank_code, customer_id, aadhaar_last4, status, commission_data, provider_response, created_at, updated_at) FROM stdin;
1	196	CBIN	9568773855	3098	success	{"admin": 0.75, "dealer": 0.0, "master": 0.0, "superadmin": 0.0}	{"data": {"tid": "3572369330", "reason": "", "comment": "Your transaction limit has been exhausted for selected Bank", "sender_name": "siddharthGautam", "terminal_id": "", "bank_ref_num": "", "merchantname": "Siddharth gautam", "merchant_code": "", "customer_balance": "", "transaction_date": "07-08-26 12:02:01", "transaction_time": "07-08-26 12:02:01"}, "status": 1528, "message": "Transaction Fail", "response_type_id": 1528, "response_status_id": 1}	2026-08-07 06:32:01.757261	2026-08-07 06:32:01.757261
2	196	CBIN	9568773855	3098	success	{"admin": 0.75, "dealer": 0.0, "master": 0.0, "superadmin": 0.0}	{"data": {"tid": "3572369424", "reason": "", "comment": "Duplicate Biometric data", "sender_name": "siddharthGautam", "terminal_id": "", "bank_ref_num": "", "merchantname": "Siddharth gautam", "merchant_code": "", "customer_balance": "", "transaction_date": "07-08-26 12:04:28", "transaction_time": "07-08-26 12:04:28"}, "status": 1528, "message": "Transaction Fail", "response_type_id": 1528, "response_status_id": 1}	2026-08-07 06:34:28.975719	2026-08-07 06:34:28.975719
3	196	CBIN	9568773855	3098	success	{"admin": 0.75, "dealer": 0.0, "master": 0.0, "superadmin": 0.0}	{"data": {"tid": "3572372013", "reason": "", "comment": "Duplicate Biometric data", "sender_name": "siddharthGautam", "terminal_id": "", "bank_ref_num": "", "merchantname": "Siddharth gautam", "merchant_code": "", "customer_balance": "", "transaction_date": "07-08-26 12:06:15", "transaction_time": "07-08-26 12:06:15"}, "status": 1528, "message": "Transaction Fail", "response_type_id": 1528, "response_status_id": 1}	2026-08-07 06:36:15.509629	2026-08-07 06:36:15.509629
4	196	CBIN	9568773855	3098	success	{}	{"data": {"tid": "3572372090", "reason": "", "comment": "Duplicate Biometric data", "sender_name": "siddharthGautam", "terminal_id": "", "bank_ref_num": "", "merchantname": "Siddharth gautam", "merchant_code": "", "customer_balance": "", "transaction_date": "07-08-26 12:09:22", "transaction_time": "07-08-26 12:09:22"}, "status": 1528, "message": "Transaction Fail", "response_type_id": 1528, "response_status_id": 1}	2026-08-07 06:39:22.183865	2026-08-07 06:39:22.183865
5	196	CBIN	9568773855	3098	success	{}	{"data": {"tid": "3572372131", "reason": "", "comment": "Your transaction limit has been exhausted for selected Bank", "sender_name": "siddharthGautam", "terminal_id": "", "bank_ref_num": "", "merchantname": "Siddharth gautam", "merchant_code": "", "customer_balance": "", "transaction_date": "07-08-26 12:10:04", "transaction_time": "07-08-26 12:10:04"}, "status": 1528, "message": "Transaction Fail", "response_type_id": 1528, "response_status_id": 1}	2026-08-07 06:40:04.507227	2026-08-07 06:40:04.507227
6	194	FDRL	7846960035	6894	success	{"admin": 0.45, "dealer": 0.2, "master": 0.1, "superadmin": 0.0}	{"data": {"tid": "3572530977", "comment": "Request Completed", "totalfee": "0.0", "commission": "1.0", "sender_name": "SiddharthGautam", "service_tax": "0.0", "terminal_id": "AB160091", "bank_ref_num": "", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "0.0", "transaction_date": "08-08-26 12:12:33", "transaction_time": "08-08-26 12:12:33", "mini_statement_list": [{"date": "01/08/2026", "amount": "10.0", "txnType": "Dr", "narration": " Loan Rec:23116"}, {"date": "01/08/2026", "amount": "10.0", "txnType": "Cr", "narration": " UPI IN/4390665"}, {"date": "28/07/2026", "amount": "100.0", "txnType": "Dr", "narration": " Loan Rec:23116"}, {"date": "28/07/2026", "amount": "100.0", "txnType": "Cr", "narration": " UPI IN/7099329"}, {"date": "14/07/2026", "amount": "80.0", "txnType": "Dr", "narration": " Loan Rec:23116"}, {"date": "14/07/2026", "amount": "620.0", "txnType": "Dr", "narration": " UPIOUT/8466555"}, {"date": "14/07/2026", "amount": "700.0", "txnType": "Cr", "narration": " UPI IN/2339204"}, {"date": "29/06/2026", "amount": "8.0", "txnType": "Dr", "narration": " Loan Rec:23116"}, {"date": "29/06/2026", "amount": "8.0", "txnType": "Cr", "narration": " SBINT:29-03-20"}]}, "status": 0, "message": "Transaction Successful", "response_type_id": 1527, "response_status_id": 0}	2026-08-08 06:42:33.689858	2026-08-08 06:42:33.689858
7	194	FDRL	7846960035	6894	success	{"admin": 0.45, "dealer": 0.2, "master": 0.1, "superadmin": 0.0}	{"data": {"tid": "3572531151", "comment": "Request Completed", "totalfee": "0.0", "commission": "1.0", "sender_name": "SiddharthGautam", "service_tax": "0.0", "terminal_id": "AB160091", "bank_ref_num": "", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "0.0", "transaction_date": "08-08-26 12:17:28", "transaction_time": "08-08-26 12:17:28", "mini_statement_list": [{"date": "01/08/2026", "amount": "10.0", "txnType": "Dr", "narration": " Loan Rec:23116"}, {"date": "01/08/2026", "amount": "10.0", "txnType": "Cr", "narration": " UPI IN/4390665"}, {"date": "28/07/2026", "amount": "100.0", "txnType": "Dr", "narration": " Loan Rec:23116"}, {"date": "28/07/2026", "amount": "100.0", "txnType": "Cr", "narration": " UPI IN/7099329"}, {"date": "14/07/2026", "amount": "80.0", "txnType": "Dr", "narration": " Loan Rec:23116"}, {"date": "14/07/2026", "amount": "620.0", "txnType": "Dr", "narration": " UPIOUT/8466555"}, {"date": "14/07/2026", "amount": "700.0", "txnType": "Cr", "narration": " UPI IN/2339204"}, {"date": "29/06/2026", "amount": "8.0", "txnType": "Dr", "narration": " Loan Rec:23116"}, {"date": "29/06/2026", "amount": "8.0", "txnType": "Cr", "narration": " SBINT:29-03-20"}]}, "status": 0, "message": "Transaction Successful", "response_type_id": 1527, "response_status_id": 0}	2026-08-08 06:47:28.334535	2026-08-08 06:47:28.334535
8	194	UBIN	7846960035	1399	success	{"admin": 0.45, "dealer": 0.2, "master": 0.1, "superadmin": 0.0}	{"data": {"tid": "3573728538", "comment": "Request Completed", "totalfee": "0.0", "commission": "1.0", "sender_name": "SiddharthGautam", "service_tax": "0.0", "terminal_id": "AB160091", "bank_ref_num": "", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "2057.42", "transaction_date": "18-08-26 19:19:57", "transaction_time": "18-08-26 19:19:57", "mini_statement_list": [{"date": "10/07", "amount": "1057.78", "txnType": "Cr", "narration": " POS/D/IRVAD MICR "}, {"date": "04/07", "amount": "43.0", "txnType": "Cr", "narration": " POS/D/20003090:I "}, {"date": "27/06", "amount": "1.77", "txnType": "Dr", "narration": " POS/W/rges For J "}, {"date": "09/06", "amount": "18500.0", "txnType": "Dr", "narration": " POS/W/           "}, {"date": "04/06", "amount": "20000.0", "txnType": "Dr", "narration": " POS/W/           "}, {"date": "01/06", "amount": "20000.0", "txnType": "Dr", "narration": " POS/W/           "}, {"date": "27/05", "amount": "57138.2", "txnType": "Cr", "narration": " POS/D/ANDANA SPH "}, {"date": "26/05", "amount": "1.0", "txnType": "Cr", "narration": " POS/D/6146185536 "}, {"date": "17/05", "amount": "20.0", "txnType": "Dr", "narration": " POS/W/BY-23-24-0 "}]}, "status": 0, "message": "Transaction Successful", "response_type_id": 1527, "response_status_id": 0}	2026-08-18 13:49:57.594606	2026-08-18 13:49:57.594606
9	194	UBIN	7846960035	1399	success	{"admin": 0.45, "dealer": 0.2, "master": 0.1, "superadmin": 0.0}	{"data": {"tid": "3573728701", "comment": "Request Completed", "totalfee": "0.0", "commission": "1.0", "sender_name": "SiddharthGautam", "service_tax": "0.0", "terminal_id": "AB160091", "bank_ref_num": "", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "1257.42", "transaction_date": "18-08-26 19:24:43", "transaction_time": "18-08-26 19:24:43", "mini_statement_list": [{"date": "18/08", "amount": "800.0", "txnType": "Dr", "narration": " POS/W/S-CW-62301 "}, {"date": "10/07", "amount": "1057.78", "txnType": "Cr", "narration": " POS/D/IRVAD MICR "}, {"date": "04/07", "amount": "43.0", "txnType": "Cr", "narration": " POS/D/20003090:I "}, {"date": "27/06", "amount": "1.77", "txnType": "Dr", "narration": " POS/W/rges For J "}, {"date": "09/06", "amount": "18500.0", "txnType": "Dr", "narration": " POS/W/           "}, {"date": "04/06", "amount": "20000.0", "txnType": "Dr", "narration": " POS/W/           "}, {"date": "01/06", "amount": "20000.0", "txnType": "Dr", "narration": " POS/W/           "}, {"date": "27/05", "amount": "57138.2", "txnType": "Cr", "narration": " POS/D/ANDANA SPH "}, {"date": "26/05", "amount": "1.0", "txnType": "Cr", "narration": " POS/D/6146185536 "}]}, "status": 0, "message": "Transaction Successful", "response_type_id": 1527, "response_status_id": 0}	2026-08-18 13:54:43.609314	2026-08-18 13:54:43.609314
10	194	UBIN	7846960035	1399	success	{"admin": 0.45, "dealer": 0.2, "master": 0.1, "superadmin": 0.0}	{"data": {"tid": "3573830176", "comment": "Request Completed", "totalfee": "0.0", "commission": "1.0", "sender_name": "SiddharthGautam", "service_tax": "0.0", "terminal_id": "AB160091", "bank_ref_num": "", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "1257.42", "transaction_date": "19-08-26 11:08:26", "transaction_time": "19-08-26 11:08:26", "mini_statement_list": [{"date": "18/08", "amount": "800.0", "txnType": "Dr", "narration": " POS/W/S-CW-62301 "}, {"date": "10/07", "amount": "1057.78", "txnType": "Cr", "narration": " POS/D/IRVAD MICR "}, {"date": "04/07", "amount": "43.0", "txnType": "Cr", "narration": " POS/D/20003090:I "}, {"date": "27/06", "amount": "1.77", "txnType": "Dr", "narration": " POS/W/rges For J "}, {"date": "09/06", "amount": "18500.0", "txnType": "Dr", "narration": " POS/W/           "}, {"date": "04/06", "amount": "20000.0", "txnType": "Dr", "narration": " POS/W/           "}, {"date": "01/06", "amount": "20000.0", "txnType": "Dr", "narration": " POS/W/           "}, {"date": "27/05", "amount": "57138.2", "txnType": "Cr", "narration": " POS/D/ANDANA SPH "}, {"date": "26/05", "amount": "1.0", "txnType": "Cr", "narration": " POS/D/6146185536 "}]}, "status": 0, "message": "Transaction Successful", "response_type_id": 1527, "response_status_id": 0}	2026-08-19 05:38:26.63515	2026-08-19 05:38:26.63515
11	194	UBIN	7846960035	1399	success	{}	{"data": {"tid": "3574702111", "reason": "", "comment": "Biometric did not match with Aadhaar, please try with another finger", "sender_name": "SiddharthGautam", "terminal_id": "", "bank_ref_num": "", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "", "transaction_date": "29-08-26 11:58:07", "transaction_time": "29-08-26 11:58:07"}, "status": 1528, "message": "Transaction Fail", "response_type_id": 1528, "response_status_id": 1}	2026-08-29 06:28:07.281066	2026-08-29 06:28:07.281066
12	194	UBIN	7846960035	1399	success	{"admin": 0.45, "dealer": 0.2, "master": 0.1, "superadmin": 0.0}	{"data": {"tid": "3574702159", "comment": "Request Completed", "totalfee": "0.0", "commission": "1.0", "sender_name": "SiddharthGautam", "service_tax": "0.0", "terminal_id": "AB160091", "bank_ref_num": "", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "6257.42", "transaction_date": "29-08-26 11:59:18", "transaction_time": "29-08-26 11:59:18", "mini_statement_list": [{"date": "28/08", "amount": "5000.0", "txnType": "Cr", "narration": " POS/D/P000035789 "}, {"date": "18/08", "amount": "800.0", "txnType": "Dr", "narration": " POS/W/S-CW-62301 "}, {"date": "10/07", "amount": "1057.78", "txnType": "Cr", "narration": " POS/D/IRVAD MICR "}, {"date": "04/07", "amount": "43.0", "txnType": "Cr", "narration": " POS/D/20003090:I "}, {"date": "27/06", "amount": "1.77", "txnType": "Dr", "narration": " POS/W/rges For J "}, {"date": "09/06", "amount": "18500.0", "txnType": "Dr", "narration": " POS/W/           "}, {"date": "04/06", "amount": "20000.0", "txnType": "Dr", "narration": " POS/W/           "}, {"date": "01/06", "amount": "20000.0", "txnType": "Dr", "narration": " POS/W/           "}, {"date": "27/05", "amount": "57138.2", "txnType": "Cr", "narration": " POS/D/ANDANA SPH "}]}, "status": 0, "message": "Transaction Successful", "response_type_id": 1527, "response_status_id": 0}	2026-08-29 06:29:18.493939	2026-08-29 06:29:18.493939
\.


--
-- Data for Name: aeps_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aeps_transactions (id, user_id, transaction_type, client_ref_id, customer_id, user_code, bank_code, bank_name, aadhaar_number, aadhaar_last4, amount, customer_balance, opening_balance, closing_balance, commission, tds, tx_status, status, message, comment, tid, bank_ref_num, merchant_name, sender_name, shop_name, transaction_date, provider_response, created_at, updated_at) FROM stdin;
1	197	cash_withdrawal	202608031000119106	7037075725	205091007	SBIN	State Bank of India	XXXX XXXX 2113	2113	100.00	0.00	0.00	100.00	0.00	0.00	0	success	Transaction Successful	Request Completed	3571964826	621515255435	Sachin Kumar	Sachin Kumar Gola	DGLYF INNOVATION PRIVATE LIMITED	0003-08-26 15:30:18	{"data": {"fee": "", "tds": "0.0", "tid": "3571964826", "bank": "State Bank of India", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 2113", "amount": "100.0", "reason": "", "balance": "1291.98", "comment": "Request Completed", "totalfee": "0.0", "auth_code": "", "tx_status": "0", "user_code": "205091007", "commission": "0.0", "sender_name": "Sachin Kumar Gola", "service_tax": "0.0", "terminal_id": "", "bank_ref_num": "621515255435", "merchantname": "Sachin Kumar", "merchant_code": "", "customer_balance": "0.0", "transaction_date": "03-08-26 15:30:18", "transaction_time": "03-08-26 15:30:18", "shop_address_line1": "Char Kamba, Rambagh, Uttar Pradesh, Agra,-282006"}, "status": 0, "message": "Transaction Successful", "response_type_id": 1463, "response_status_id": 0}	2026-08-03 10:00:18.66266	2026-08-03 10:00:18.66266
2	197	cash_withdrawal	202608051310206364	7037075724	205091007	SBIN	\N	XXXX XXXX 2113	2113	100.00	0.00	100.00	200.00	\N	\N	1	success	Transaction Fail	Duplicate Biometric data.	3572099050		Sachin Kumar	SachinKumar	DGLYF INNOVATION PRIVATE LIMITED	0005-08-26 18:40:20	{"data": {"tid": "3572099050", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 2113", "amount": "100.0", "reason": "", "comment": "Duplicate Biometric data.", "auth_code": "", "tx_status": "1", "user_code": "205091007", "sender_name": "SachinKumar", "terminal_id": "", "bank_ref_num": "", "merchantname": "Sachin Kumar", "merchant_code": "", "customer_balance": "0.00", "transaction_date": "05-08-26 18:40:20", "transaction_time": "05-08-26 18:40:20", "shop_address_line1": "Char Kamba, Rambagh, Uttar Pradesh, Agra,-282006"}, "status": 1464, "message": "Transaction Fail", "response_type_id": 1464, "response_status_id": 1}	2026-08-05 13:10:21.471538	2026-08-05 13:10:21.471538
3	197	cash_withdrawal	202608051310449407	7037075724	205091007	SBIN	\N	XXXX XXXX 2113	2113	100.00	0.00	200.00	300.00	\N	\N	1	success	Transaction Fail	U16 - RISK THRESHOLD EXCEEDED	3572099067	621718664261	Sachin Kumar	SachinKumar	DGLYF INNOVATION PRIVATE LIMITED	0005-08-26 18:40:45	{"data": {"tid": "3572099067", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 2113", "amount": "100.0", "reason": "", "comment": "U16 - RISK THRESHOLD EXCEEDED", "auth_code": "", "tx_status": "1", "user_code": "205091007", "sender_name": "SachinKumar", "terminal_id": "", "bank_ref_num": "621718664261", "merchantname": "Sachin Kumar", "merchant_code": "", "customer_balance": "0.00", "transaction_date": "05-08-26 18:40:45", "transaction_time": "05-08-26 18:40:45", "shop_address_line1": "Char Kamba, Rambagh, Uttar Pradesh, Agra,-282006"}, "status": 1464, "message": "Transaction Fail", "response_type_id": 1464, "response_status_id": 1}	2026-08-05 13:10:46.180445	2026-08-05 13:10:46.180445
4	197	cash_withdrawal	202608051312021459	9568773851	\N	CBIN	\N	\N	3098	\N	\N	300.00	395.00	\N	\N	\N	success	Transaction amount should be in multiple of 50 ex-2050,3000	\N	\N	\N	\N	\N	\N	\N	{"status": 1960, "message": "Transaction amount should be in multiple of 50 ex-2050,3000", "response_type_id": 1960, "response_status_id": 1}	2026-08-05 13:12:02.348969	2026-08-05 13:12:02.348969
5	197	cash_withdrawal	202608051312153045	9568773851	205091007	CBIN	\N	XXXX XXXX 3098	3098	100.00	0.00	395.00	495.00	\N	\N	1	success	Transaction Fail	Invalid Transaction	3572099108	621718669659	Sachin Kumar	SachinKumar	DGLYF INNOVATION PRIVATE LIMITED	0005-08-26 18:42:17	{"data": {"tid": "3572099108", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 3098", "amount": "100.0", "reason": "", "comment": "Invalid Transaction", "auth_code": "", "tx_status": "1", "user_code": "205091007", "sender_name": "SachinKumar", "terminal_id": "", "bank_ref_num": "621718669659", "merchantname": "Sachin Kumar", "merchant_code": "", "customer_balance": "0.00", "transaction_date": "05-08-26 18:42:17", "transaction_time": "05-08-26 18:42:17", "shop_address_line1": "Char Kamba, Rambagh, Uttar Pradesh, Agra,-282006"}, "status": 1464, "message": "Transaction Fail", "response_type_id": 1464, "response_status_id": 1}	2026-08-05 13:12:17.384656	2026-08-05 13:12:17.384656
6	196	cash_withdrawal	202608070600432344	9568773855	38130026	CBIN	\N	XXXX XXXX 3098	3098	100.00	0.00	0.00	100.00	\N	\N	1	success	Transaction Fail	Please do 2fa before initiating transaction	3572365738		Siddharth gautam	siddharthGautam	DGLYF INNOVATION PRIVATE LIMITED	0007-08-26 11:30:43	{"data": {"tid": "3572365738", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 3098", "amount": "100.0", "reason": "", "comment": "Please do 2fa before initiating transaction", "auth_code": "", "tx_status": "1", "user_code": "38130026", "sender_name": "siddharthGautam", "terminal_id": "", "bank_ref_num": "", "merchantname": "Siddharth gautam", "merchant_code": "", "customer_balance": "0.00", "transaction_date": "07-08-26 11:30:43", "transaction_time": "07-08-26 11:30:43", "shop_address_line1": "Jay SIngh Pura, 04, Vrindavan Rd, near Methodist Hospital, Masani, Mathura,, Uttar Pradesh, Mathura,-281001"}, "status": 1464, "message": "Transaction Fail", "response_type_id": 1464, "response_status_id": 1}	2026-08-07 06:00:43.633572	2026-08-07 06:00:43.633572
7	196	cash_withdrawal	202608070602112939	958773855	38130026	CBIN	\N	XXXX XXXX 3098	3098	100.00	0.00	0.00	100.00	\N	\N	1	success	Transaction Fail	Invalid Transaction	3572365767	621911156898	Siddharth gautam	siddharthGautam	DGLYF INNOVATION PRIVATE LIMITED	0007-08-26 11:32:13	{"data": {"tid": "3572365767", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 3098", "amount": "100.0", "reason": "", "comment": "Invalid Transaction", "auth_code": "", "tx_status": "1", "user_code": "38130026", "sender_name": "siddharthGautam", "terminal_id": "", "bank_ref_num": "621911156898", "merchantname": "Siddharth gautam", "merchant_code": "", "customer_balance": "0.00", "transaction_date": "07-08-26 11:32:13", "transaction_time": "07-08-26 11:32:13", "shop_address_line1": "Jay SIngh Pura, 04, Vrindavan Rd, near Methodist Hospital, Masani, Mathura,, Uttar Pradesh, Mathura,-281001"}, "status": 1464, "message": "Transaction Fail", "response_type_id": 1464, "response_status_id": 1}	2026-08-07 06:02:13.273603	2026-08-07 06:02:13.273603
8	196	cash_withdrawal	202608070641296294	9568773855	38130026	CBIN	\N	XXXX XXXX 3098	3098	100.00	0.00	0.00	100.00	\N	\N	1	success	Transaction Fail	Invalid Transaction	3572372189	621912290104	Siddharth gautam	siddharthGautam	DGLYF INNOVATION PRIVATE LIMITED	0007-08-26 12:11:31	{"data": {"tid": "3572372189", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 3098", "amount": "100.0", "reason": "", "comment": "Invalid Transaction", "auth_code": "", "tx_status": "1", "user_code": "38130026", "sender_name": "siddharthGautam", "terminal_id": "", "bank_ref_num": "621912290104", "merchantname": "Siddharth gautam", "merchant_code": "", "customer_balance": "0.00", "transaction_date": "07-08-26 12:11:31", "transaction_time": "07-08-26 12:11:31", "shop_address_line1": "Jay SIngh Pura, 04, Vrindavan Rd, near Methodist Hospital, Masani, Mathura,, Uttar Pradesh, Mathura,-281001"}, "status": 1464, "message": "Transaction Fail", "response_type_id": 1464, "response_status_id": 1}	2026-08-07 06:41:31.349757	2026-08-07 06:41:31.349757
9	194	cash_withdrawal	202608080634369955	9337691368	205091004	YESB	\N	XXXX XXXX 6894	6894	100.00	0.00	0.00	100.00	\N	\N	1	success	Transaction Fail	AePS debit transactions are disabled by customer bank	3572528219	622012608305	SASMITA DAS	SiddharthGautam	DGLYF INNOVATION PRIVATE LIMITED	0008-08-26 12:04:40	{"data": {"tid": "3572528219", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 6894", "amount": "100.0", "reason": "", "comment": "AePS debit transactions are disabled by customer bank", "auth_code": "", "tx_status": "1", "user_code": "205091004", "sender_name": "SiddharthGautam", "terminal_id": "", "bank_ref_num": "622012608305", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "0.00", "transaction_date": "08-08-26 12:04:40", "transaction_time": "08-08-26 12:04:40", "shop_address_line1": "R J PALACE, SAMANTARAPUR, Odisha, BHUBANESWAR,-751002"}, "status": 1464, "message": "Transaction Fail", "response_type_id": 1464, "response_status_id": 1}	2026-08-08 06:34:40.371652	2026-08-08 06:34:40.371652
10	194	cash_withdrawal	202608080636535557	9337691368	205091004	FDRL	\N	XXXX XXXX 6894	6894	100.00	0.00	0.00	100.00	\N	\N	1	success	Transaction Fail	AePS debit transactions are disabled by customer bank	3572530824	622012616366	SASMITA DAS	SiddharthGautam	DGLYF INNOVATION PRIVATE LIMITED	0008-08-26 12:06:56	{"data": {"tid": "3572530824", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 6894", "amount": "100.0", "reason": "", "comment": "AePS debit transactions are disabled by customer bank", "auth_code": "", "tx_status": "1", "user_code": "205091004", "sender_name": "SiddharthGautam", "terminal_id": "", "bank_ref_num": "622012616366", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "0.00", "transaction_date": "08-08-26 12:06:56", "transaction_time": "08-08-26 12:06:56", "shop_address_line1": "R J PALACE, SAMANTARAPUR, Odisha, BHUBANESWAR,-751002"}, "status": 1464, "message": "Transaction Fail", "response_type_id": 1464, "response_status_id": 1}	2026-08-08 06:36:56.34279	2026-08-08 06:36:56.34279
11	194	cash_withdrawal	202608080638211935	9337691368	205091004	YESB	\N	XXXX XXXX 6894	6894	100.00	0.00	0.00	100.00	\N	\N	1	success	Transaction Fail	AePS debit transactions are disabled by customer bank	3572530846	622012621246	SASMITA DAS	SiddharthGautam	DGLYF INNOVATION PRIVATE LIMITED	0008-08-26 12:08:32	{"data": {"tid": "3572530846", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 6894", "amount": "100.0", "reason": "", "comment": "AePS debit transactions are disabled by customer bank", "auth_code": "", "tx_status": "1", "user_code": "205091004", "sender_name": "SiddharthGautam", "terminal_id": "", "bank_ref_num": "622012621246", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "0.00", "transaction_date": "08-08-26 12:08:32", "transaction_time": "08-08-26 12:08:32", "shop_address_line1": "R J PALACE, SAMANTARAPUR, Odisha, BHUBANESWAR,-751002"}, "status": 1464, "message": "Transaction Fail", "response_type_id": 1464, "response_status_id": 1}	2026-08-08 06:38:32.120736	2026-08-08 06:38:32.120736
12	194	cash_withdrawal	202608080656387026	9337691368	205091004	YESB	\N	XXXX XXXX 6894	6894	100.00	0.00	0.00	100.00	\N	\N	1	success	Transaction Fail	AePS debit transactions are disabled by customer bank	3572531455	622012681744	SASMITA DAS	SiddharthGautam	DGLYF INNOVATION PRIVATE LIMITED	0008-08-26 12:26:41	{"data": {"tid": "3572531455", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 6894", "amount": "100.0", "reason": "", "comment": "AePS debit transactions are disabled by customer bank", "auth_code": "", "tx_status": "1", "user_code": "205091004", "sender_name": "SiddharthGautam", "terminal_id": "", "bank_ref_num": "622012681744", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "0.00", "transaction_date": "08-08-26 12:26:41", "transaction_time": "08-08-26 12:26:41", "shop_address_line1": "R J PALACE, SAMANTARAPUR, Odisha, BHUBANESWAR,-751002"}, "status": 1464, "message": "Transaction Fail", "response_type_id": 1464, "response_status_id": 1}	2026-08-08 06:56:41.931622	2026-08-08 06:56:41.931622
13	194	cash_withdrawal	202608080719573491	7008366174	205091004	IOGB	\N	XXXX XXXX 7219	7219	100.00	0.00	0.00	100.00	\N	\N	1	success	Transaction Fail	Customer  Aadhaar number is not linked with Selected Bank. Please check with the bank or select another Aadhaar linked bank	3572534752	622012753001	SASMITA DAS	SiddharthGautam	DGLYF INNOVATION PRIVATE LIMITED	0008-08-26 12:49:59	{"data": {"tid": "3572534752", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 7219", "amount": "100.0", "reason": "", "comment": "Customer  Aadhaar number is not linked with Selected Bank. Please check with the bank or select another Aadhaar linked bank", "auth_code": "", "tx_status": "1", "user_code": "205091004", "sender_name": "SiddharthGautam", "terminal_id": "", "bank_ref_num": "622012753001", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "0.00", "transaction_date": "08-08-26 12:49:59", "transaction_time": "08-08-26 12:49:59", "shop_address_line1": "R J PALACE, SAMANTARAPUR, Odisha, BHUBANESWAR,-751002"}, "status": 1464, "message": "Transaction Fail", "response_type_id": 1464, "response_status_id": 1}	2026-08-08 07:19:59.566382	2026-08-08 07:19:59.566382
14	194	cash_withdrawal	202608080721558908	7008366174	205091004	IDIB	\N	XXXX XXXX 7219	7219	100.00	0.00	0.00	100.00	\N	\N	1	success	Transaction Fail	Duplicate Biometric data.	3572534867		SASMITA DAS	SiddharthGautam	DGLYF INNOVATION PRIVATE LIMITED	0008-08-26 12:51:56	{"data": {"tid": "3572534867", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 7219", "amount": "100.0", "reason": "", "comment": "Duplicate Biometric data.", "auth_code": "", "tx_status": "1", "user_code": "205091004", "sender_name": "SiddharthGautam", "terminal_id": "", "bank_ref_num": "", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "0.00", "transaction_date": "08-08-26 12:51:56", "transaction_time": "08-08-26 12:51:56", "shop_address_line1": "R J PALACE, SAMANTARAPUR, Odisha, BHUBANESWAR,-751002"}, "status": 1464, "message": "Transaction Fail", "response_type_id": 1464, "response_status_id": 1}	2026-08-08 07:21:56.37685	2026-08-08 07:21:56.37685
15	194	cash_withdrawal	202608080723171086	7008366174	205091004	IDIB	\N	XXXX XXXX 7219	7219	100.00	0.00	0.00	100.00	\N	\N	1	success	Transaction Fail	AePS debit transactions are disabled by customer bank	3572534914	622012762367	SASMITA DAS	SiddharthGautam	DGLYF INNOVATION PRIVATE LIMITED	0008-08-26 12:53:19	{"data": {"tid": "3572534914", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 7219", "amount": "100.0", "reason": "", "comment": "AePS debit transactions are disabled by customer bank", "auth_code": "", "tx_status": "1", "user_code": "205091004", "sender_name": "SiddharthGautam", "terminal_id": "", "bank_ref_num": "622012762367", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "0.00", "transaction_date": "08-08-26 12:53:19", "transaction_time": "08-08-26 12:53:19", "shop_address_line1": "R J PALACE, SAMANTARAPUR, Odisha, BHUBANESWAR,-751002"}, "status": 1464, "message": "Transaction Fail", "response_type_id": 1464, "response_status_id": 1}	2026-08-08 07:23:19.214841	2026-08-08 07:23:19.214841
16	194	cash_withdrawal	202608080725233265	7008366174	205091004	IDIB	\N	XXXX XXXX 7219	7219	100.00	0.00	0.00	100.00	\N	\N	1	success	Transaction Fail	AePS debit transactions are disabled by customer bank	3572535065	622012768249	SASMITA DAS	SiddharthGautam	DGLYF INNOVATION PRIVATE LIMITED	0008-08-26 12:55:25	{"data": {"tid": "3572535065", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 7219", "amount": "100.0", "reason": "", "comment": "AePS debit transactions are disabled by customer bank", "auth_code": "", "tx_status": "1", "user_code": "205091004", "sender_name": "SiddharthGautam", "terminal_id": "", "bank_ref_num": "622012768249", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "0.00", "transaction_date": "08-08-26 12:55:25", "transaction_time": "08-08-26 12:55:25", "shop_address_line1": "R J PALACE, SAMANTARAPUR, Odisha, BHUBANESWAR,-751002"}, "status": 1464, "message": "Transaction Fail", "response_type_id": 1464, "response_status_id": 1}	2026-08-08 07:25:25.440252	2026-08-08 07:25:25.440252
17	194	cash_withdrawal	202608080730404693	7846960035	205091004	PUNB	\N	XXXX XXXX 0513	0513	100.00	0.00	0.00	100.00	\N	\N	1	success	Transaction Fail	Customer  Aadhaar number is not linked with Selected Bank. Please check with the bank or select another Aadhaar linked bank	3572535256	622013783469	SASMITA DAS	SiddharthGautam	DGLYF INNOVATION PRIVATE LIMITED	0008-08-26 13:01:00	{"data": {"tid": "3572535256", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 0513", "amount": "100.0", "reason": "", "comment": "Customer  Aadhaar number is not linked with Selected Bank. Please check with the bank or select another Aadhaar linked bank", "auth_code": "", "tx_status": "1", "user_code": "205091004", "sender_name": "SiddharthGautam", "terminal_id": "", "bank_ref_num": "622013783469", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "0.00", "transaction_date": "08-08-26 13:01:00", "transaction_time": "08-08-26 13:01:00", "shop_address_line1": "R J PALACE, SAMANTARAPUR, Odisha, BHUBANESWAR,-751002"}, "status": 1464, "message": "Transaction Fail", "response_type_id": 1464, "response_status_id": 1}	2026-08-08 07:31:00.707697	2026-08-08 07:31:00.707697
18	194	cash_withdrawal	202608080731301257	7846960035	205091004	PUNB	\N	XXXX XXXX 0513	0513	100.00	0.00	0.00	100.00	\N	\N	1	success	Transaction Fail	Customer  Aadhaar number is not linked with Selected Bank. Please check with the bank or select another Aadhaar linked bank	3572535279	622013784986	SASMITA DAS	SiddharthGautam	DGLYF INNOVATION PRIVATE LIMITED	0008-08-26 13:01:32	{"data": {"tid": "3572535279", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 0513", "amount": "100.0", "reason": "", "comment": "Customer  Aadhaar number is not linked with Selected Bank. Please check with the bank or select another Aadhaar linked bank", "auth_code": "", "tx_status": "1", "user_code": "205091004", "sender_name": "SiddharthGautam", "terminal_id": "", "bank_ref_num": "622013784986", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "0.00", "transaction_date": "08-08-26 13:01:32", "transaction_time": "08-08-26 13:01:32", "shop_address_line1": "R J PALACE, SAMANTARAPUR, Odisha, BHUBANESWAR,-751002"}, "status": 1464, "message": "Transaction Fail", "response_type_id": 1464, "response_status_id": 1}	2026-08-08 07:31:32.46944	2026-08-08 07:31:32.46944
19	194	cash_withdrawal	202608181353071430	9556987316	205091004	UBIN	\N	XXXX XXXX 1399	1399	800.00	0.00	0.00	800.00	\N	\N	1	success	Transaction Fail	Duplicate Biometric data.	3573728629		SASMITA DAS	SiddharthGautam	DGLYF INNOVATION PRIVATE LIMITED	0018-08-26 19:23:07	{"data": {"tid": "3573728629", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 1399", "amount": "800.0", "reason": "", "comment": "Duplicate Biometric data.", "auth_code": "", "tx_status": "1", "user_code": "205091004", "sender_name": "SiddharthGautam", "terminal_id": "", "bank_ref_num": "", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "0.00", "transaction_date": "18-08-26 19:23:07", "transaction_time": "18-08-26 19:23:07", "shop_address_line1": "R J PALACE, SAMANTARAPUR, Odisha, BHUBANESWAR,-751002"}, "status": 1464, "message": "Transaction Fail", "response_type_id": 1464, "response_status_id": 1}	2026-08-18 13:53:07.60153	2026-08-18 13:53:07.60153
20	194	cash_withdrawal	202608191251421082	9692682395	205091004	UCBA	UCO Bank	XXXX XXXX 4385	4385	100.00	60.73	0.00	100.00	0.40	0.01	0	success	Transaction Successful	Request Completed	3573853760	623118148935	SASMITA DAS	SiddharthGautam	DGLYF INNOVATION PRIVATE LIMITED	0019-08-26 18:21:45	{"data": {"fee": "", "tds": "0.01", "tid": "3573853760", "bank": "UCO Bank", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 4385", "amount": "100.0", "reason": "", "balance": "2058.76", "comment": "Request Completed", "totalfee": "0.0", "auth_code": "", "tx_status": "0", "user_code": "205091004", "commission": "0.4", "sender_name": "SiddharthGautam", "service_tax": "0.0", "terminal_id": "", "bank_ref_num": "623118148935", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "60.73", "transaction_date": "19-08-26 18:21:45", "transaction_time": "19-08-26 18:21:45", "shop_address_line1": "R J PALACE, SAMANTARAPUR, Odisha, BHUBANESWAR,-751002"}, "status": 0, "message": "Transaction Successful", "response_type_id": 1463, "response_status_id": 0}	2026-08-19 12:51:49.726595	2026-08-19 12:51:49.726595
21	194	cash_withdrawal	202608311202349880	7846960035	205091004	HDFC	HDFC Bank	XXXX XXXX 6586	6586	1400.00	87.35	900.00	2300.00	5.60	0.11	0	success	Transaction Successful	Request Completed	3575059583	624317946360	SASMITA DAS	SiddharthGautam	DGLYF INNOVATION PRIVATE LIMITED	0031-08-26 17:32:36	{"data": {"fee": "", "tds": "0.11", "tid": "3575059583", "bank": "HDFC Bank", "shop": "DGLYF INNOVATION PRIVATE LIMITED", "stan": "", "aadhar": "XXXX XXXX 6586", "amount": "1400.0", "reason": "", "balance": "3351.37", "comment": "Request Completed", "totalfee": "0.0", "auth_code": "", "tx_status": "0", "user_code": "205091004", "commission": "5.6", "sender_name": "SiddharthGautam", "service_tax": "0.0", "terminal_id": "", "bank_ref_num": "624317946360", "merchantname": "SASMITA DAS", "merchant_code": "", "customer_balance": "87.35", "transaction_date": "31-08-26 17:32:36", "transaction_time": "31-08-26 17:32:36", "shop_address_line1": "R J PALACE, SAMANTARAPUR, Odisha, BHUBANESWAR,-751002"}, "status": 0, "message": "Transaction Successful", "response_type_id": 1463, "response_status_id": 0}	2026-08-31 12:02:36.577164	2026-08-31 12:02:36.577164
\.


--
-- Data for Name: aeps_wallet_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aeps_wallet_transactions (id, user_id, aeps_wallet_id, amount, transaction_type, reference_id, remarks, balance_before, balance_after, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: aeps_wallets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aeps_wallets (id, user_id, balance, status, created_at, updated_at) FROM stdin;
2	150	0.00	0	2026-07-27 12:36:58.114178	2026-07-27 12:36:58.114178
3	196	0.00	0	2026-07-27 12:47:40.429231	2026-07-27 12:47:40.429231
5	197	495.00	0	2026-08-03 09:21:13.623421	2026-08-05 13:12:17.231302
6	127	0.00	0	2026-08-10 05:38:59.232435	2026-08-10 05:38:59.232435
4	194	2300.00	0	2026-07-28 12:53:07.478939	2026-08-31 12:02:36.564352
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2025-08-19 11:00:42.469236	2025-08-19 11:00:42.469242
\.


--
-- Data for Name: banks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.banks (id, bank_name, account_name, ifsc_code, account_number, account_type, first_name, last_name, initial_balance, created_at, updated_at, user_id) FROM stdin;
1	ds	\N	ds	ds		\N	\N	23232.0	2025-09-01 11:11:59.373553	2025-09-01 11:11:59.373553	\N
2	Axis	\N	AXIS89SX	779776876567576576	savings	Siddharth Gautam		1000.0	2025-09-01 11:13:25.981914	2025-09-01 11:58:37.973077	\N
4	Axis	\N	AXIS89SX	779776876567576576	savings	Siddharth Gautam	ds	0.0	2025-11-15 12:06:22.364978	2025-11-15 12:06:27.742474	136
5	HDFC Bank	Rahul Sharma	HDFC0001234	123456789012	Savings	Rahul	Sharma	10000.0	2025-11-16 18:18:33.397367	2025-11-16 18:18:33.397367	104
6	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-17 05:56:49.128236	2025-11-17 05:56:49.128236	104
7	SBI	89769878777987	SBI87988	\N	\N	\N	\N	\N	2025-11-17 06:39:54.157036	2025-11-17 06:40:37.074249	136
8	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-17 06:57:43.23263	2025-11-17 06:57:43.23263	104
9	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-17 06:58:47.455834	2025-11-17 06:58:47.455834	104
22	State Bank of India	Manikant Tiwari	SBIN0001234	123456789012	Savings	Manikant	Tiwari	5000.0	2025-11-25 09:54:20.924299	2025-11-25 09:54:20.924299	169
35	ds fb sd	dbshfbsh 	abcde1234kk	222222222222	Current	dbshfbsh		22.0	2025-11-25 12:27:10.504554	2025-11-25 12:27:10.504554	169
36	kotak mahindra	pritesh prasad 	abcde1234kk	222222222222222	Current	pritesh prasad		100.0	2025-11-26 05:20:31.270487	2025-11-26 05:20:31.270487	169
38	state bank of india	rahul 	sbik0011809	43902309288	Current	rahul		300.0	2025-12-18 09:58:37.400029	2025-12-18 09:58:37.400029	103
39	Kylee Pope	dsss jdshdkhj	UTIB0002193	9924000100007471	\N	dsss	jdshdkhj	\N	2026-05-25 12:07:29.270145	2026-05-25 12:07:29.270145	127
40	Axis	prasad kumaty	UTIB0002193	9924000100007471	\N	prasad	kumaty	\N	2026-05-26 08:44:04.868334	2026-05-26 08:44:04.868334	181
41	FEDERAL BANK	\N	FDRL0002311	23110200000412	\N	\N	\N	\N	2026-05-27 11:28:36.881591	2026-05-29 12:42:52.945675	189
42	FEDERAL BANK	prasad kumar mohanty	FDRL0002311	23110200000412	\N	prasad kumar	mohanty	\N	2026-05-27 13:16:51.095425	2026-05-29 12:46:24.025071	189
43	HDFC	\N	IFDD&775655	687687676776876	\N	\N	\N	\N	2026-07-03 09:08:55.828359	2026-07-03 09:08:55.828359	139
44	FEDERAL BANK	SASMITA  DAS	FDRL0002311	23110100033851	\N	SASMITA 	DAS	\N	2026-07-06 11:59:11.472194	2026-07-06 11:59:11.472194	194
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, title, image, status, service_id, created_at, updated_at) FROM stdin;
14	Utility Bills	\N	\N	7	2025-09-04 06:56:51.899042	2025-09-09 04:59:00.092412
15	Telecom & DTH	\N	\N	7	2025-09-04 06:57:05.940464	2025-09-09 04:59:10.380441
16	Financial Service	\N	\N	7	2025-09-04 06:57:22.614	2025-09-09 13:02:44.18975
17	Gov Payments	\N	\N	7	2025-09-04 06:57:35.120447	2025-09-09 13:04:20.275432
18	Subscription & Offers	\N	\N	7	2025-09-09 05:04:50.414025	2025-09-09 13:05:33.000885
20	Utility Bills	\N	\N	8	2025-09-10 04:42:27.417519	2025-09-10 04:42:27.417519
21	Telecom & DTH	\N	\N	8	2025-09-10 04:42:38.665596	2025-09-10 04:42:38.665596
22	Financial Service	\N	\N	8	2025-09-10 04:42:48.938126	2025-09-10 04:42:48.938126
23	Gov Payments	\N	\N	8	2025-09-10 04:43:01.593211	2025-09-10 04:43:01.593211
26	Flight Booking	\N	\N	1	2025-09-16 05:51:17.413975	2025-09-16 05:51:17.413975
27	Bus Booking	\N	\N	1	2025-09-16 05:51:33.662226	2025-09-16 05:51:33.662226
13	Hotel Booking	\N	\N	1	2025-09-04 06:52:47.257969	2025-09-16 14:15:22.007462
\.


--
-- Data for Name: cibil_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cibil_reports (id, user_id, pan, mobile_number, name, credit_score, bureau, response_data, doc_id, status_code, success, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: commissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.commissions (id, commission_type, created_at, updated_at, service_product_item_id, scheme_id, value, to_role, from_role, set_by_role, set_for_role, commission_rate) FROM stdin;
127	fixed	2026-05-26 13:24:16.557459	2026-05-26 13:25:42.598491	34	40	100.0	admin	superadmin	\N	\N	0.81% of bill amount for transaction
128	fixed	2026-05-26 13:26:24.09518	2026-05-26 13:26:24.09518	35	40	100.0	admin	superadmin	\N	\N	0.81% of bill amount for transaction
129	fixed	2026-05-26 13:27:45.011784	2026-05-26 13:27:45.011784	36	40	100.0	admin	superadmin	\N	\N	3.15% of bill amount for transaction
130	fixed	2026-05-26 13:28:56.801846	2026-05-26 13:28:56.801846	37	40	100.0	admin	superadmin	\N	\N	1.14% of bill amount for transaction
131	commission	2026-05-27 12:50:11.831777	2026-05-27 12:50:11.831777	34	46	10.0	master	admin	\N	\N	\N
132	commission	2026-05-27 12:50:11.841404	2026-05-27 12:50:11.841404	34	46	10.0	dealer	admin	\N	\N	\N
133	commission	2026-05-27 12:50:11.850142	2026-05-27 12:50:51.079119	34	46	30.0	retailer	admin	\N	\N	\N
134	commission	2026-05-27 18:04:05.342379	2026-05-27 18:04:05.342379	34	44	0.1	master	admin	\N	\N	\N
135	commission	2026-05-27 18:04:05.351594	2026-05-27 18:04:05.351594	34	44	0.1	dealer	admin	\N	\N	\N
136	commission	2026-05-27 18:04:05.360079	2026-05-27 18:04:05.360079	34	44	0.5	retailer	admin	\N	\N	\N
137	commission	2026-05-27 18:05:56.372896	2026-05-27 18:05:56.372896	37	44	0.15	master	admin	\N	\N	\N
138	commission	2026-05-27 18:05:56.381673	2026-05-27 18:05:56.381673	37	44	0.15	dealer	admin	\N	\N	\N
139	commission	2026-05-27 18:05:56.390451	2026-05-27 18:05:56.390451	37	44	0.7	retailer	admin	\N	\N	\N
140	commission	2026-05-27 18:07:37.423503	2026-05-27 18:07:37.423503	36	44	0.25	master	admin	\N	\N	\N
141	commission	2026-05-27 18:07:37.43269	2026-05-27 18:07:37.43269	36	44	0.25	dealer	admin	\N	\N	\N
142	commission	2026-05-27 18:07:37.441477	2026-05-27 18:07:37.441477	36	44	2.0	retailer	admin	\N	\N	\N
143	commission	2026-05-27 18:08:05.523474	2026-05-27 18:08:05.523474	35	44	0.1	master	admin	\N	\N	\N
144	commission	2026-05-27 18:08:05.532196	2026-05-27 18:08:05.532196	35	44	0.1	dealer	admin	\N	\N	\N
145	commission	2026-05-27 18:08:05.540137	2026-05-27 18:08:05.540137	35	44	0.5	retailer	admin	\N	\N	\N
146	fixed	2026-05-28 05:59:22.890072	2026-05-28 05:59:22.890072	38	40	100.0	admin	superadmin	\N	\N	1.80 of bill amount for transaction
147	fixed	2026-05-28 06:02:59.883326	2026-05-28 06:02:59.883326	39	40	100.0	admin	superadmin	\N	\N	0.18% of bill amount for trancation between 5000-20000
148	fixed	2026-05-28 06:04:20.180727	2026-05-28 06:04:20.180727	40	40	100.0	admin	superadmin	\N	\N	2.79% of bill amount for transaction
\.


--
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departments (id, name, description, created_at, updated_at) FROM stdin;
1	lo	kjhl	2026-05-26 07:14:55.883057	2026-05-26 07:14:55.883057
2	hr	testing hr	2026-05-26 08:58:46.812447	2026-05-26 08:58:46.812447
\.


--
-- Data for Name: dmt_commission_slab_ranges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dmt_commission_slab_ranges (id, min_amount, max_amount, bank_fee_percent, eko_fee, surcharge, tds_percent, gst_percent, from_role, to_role, value, active, scheme_id, created_at, updated_at) FROM stdin;
9	10001.00	50000.00	1.00	7.00	10.00	4.00	1.00	superadmin	admin	7.00	t	5	2025-12-26 11:06:05.209856	2025-12-26 11:11:13.603391
8	1000.00	10000.00	1.00	7.00	10.00	7.00	3.00	superadmin	admin	8.00	t	36	2025-12-26 09:01:33.533856	2025-12-26 12:06:06.182665
7	1.00	1000.00	1.00	7.00	10.00	7.00	3.00	superadmin	admin	9.00	t	36	2025-12-26 09:01:15.687862	2025-12-26 12:07:22.414896
10	50000.00	100000.00	1.00	7.00	20.00	2.00	2.00	\N	\N	6.00	t	36	2025-12-26 11:35:26.422101	2025-12-26 12:10:01.22186
\.


--
-- Data for Name: dmt_commission_slabs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dmt_commission_slabs (id, min_amount, max_amount, bank_fee_percent, eko_fee, surcharge, tds_percent, gst_percent, from_role, to_role, value, active, scheme_id, created_at, updated_at, dmt_commission_slab_range_id) FROM stdin;
50	1000.00	10000.00	1.00	7.00	10.00	7.00	3.00	admin	master	1.00	t	21	2025-12-26 13:31:00.39398	2025-12-26 13:31:00.39398	8
51	1000.00	10000.00	1.00	7.00	10.00	7.00	3.00	admin	retailer	1.00	t	21	2025-12-26 13:31:00.407984	2025-12-26 13:31:00.407984	8
52	1.00	1000.00	1.00	7.00	10.00	7.00	3.00	admin	retailer	2.00	t	20	2025-12-27 11:07:34.650421	2025-12-27 11:07:52.124577	7
41	1000.00	10000.00	1.00	7.00	10.00	7.00	3.00	admin	retailer	2.00	t	5	2025-12-26 11:05:03.914346	2025-12-26 11:05:03.914346	8
42	10001.00	50000.00	1.00	7.00	10.00	4.00	1.00	admin	master	2.00	t	5	2025-12-26 12:32:45.42475	2025-12-26 12:32:45.42475	9
43	10001.00	50000.00	1.00	7.00	10.00	4.00	1.00	admin	retailer	1.00	t	5	2025-12-26 12:32:45.456521	2025-12-26 12:32:45.456521	9
40	100.00	1000.00	1.00	7.00	10.00	7.00	3.00	admin	master	2.00	t	5	2025-12-26 11:05:03.893262	2025-12-26 12:41:22.166765	8
47	10001.00	50000.00	1.00	7.00	10.00	4.00	1.00	admin	retailer	2.00	t	21	2025-12-26 12:57:38.806208	2025-12-26 12:57:38.806208	9
44	10001.00	50000.00	1.00	7.00	10.00	4.00	1.00	admin	master	5.00	t	20	2025-12-26 12:53:09.378293	2025-12-26 13:14:59.339767	9
45	10001.00	50000.00	1.00	7.00	10.00	4.00	1.00	admin	retailer	2.00	t	20	2025-12-26 12:53:09.394893	2025-12-26 13:14:59.370839	9
48	10001.00	50000.00	1.00	7.00	10.00	4.00	1.00	admin	master	1.00	t	42	2025-12-26 13:18:39.382822	2025-12-26 13:18:39.382822	9
49	10001.00	50000.00	1.00	7.00	10.00	4.00	1.00	admin	retailer	2.00	t	42	2025-12-26 13:18:39.398188	2025-12-26 13:21:44.259852	9
46	10001.00	50000.00	1.00	7.00	10.00	4.00	1.00	admin	master	2.00	t	21	2025-12-26 12:57:38.793075	2025-12-26 13:26:44.727092	9
53	1.00	1000.00	1.00	7.00	10.00	7.00	3.00	admin	master	2.00	t	46	2026-08-07 08:42:55.198128	2026-08-07 08:42:55.198128	7
54	1.00	1000.00	1.00	7.00	10.00	7.00	3.00	admin	dealer	3.00	t	46	2026-08-07 08:42:55.216342	2026-08-07 08:42:55.216342	7
55	1.00	1000.00	1.00	7.00	10.00	7.00	3.00	admin	retailer	5.00	t	46	2026-08-07 08:42:55.229584	2026-08-07 08:42:55.229584	7
56	1.00	1000.00	1.00	7.00	10.00	7.00	3.00	admin	master	2.00	t	45	2026-08-07 08:47:14.896275	2026-08-07 08:47:14.896275	7
57	1.00	1000.00	1.00	7.00	10.00	7.00	3.00	admin	dealer	3.00	t	45	2026-08-07 08:47:14.905768	2026-08-07 08:47:14.905768	7
58	1.00	1000.00	1.00	7.00	10.00	7.00	3.00	admin	retailer	5.00	t	45	2026-08-07 08:47:14.915585	2026-08-07 08:47:14.915585	7
\.


--
-- Data for Name: dmt_commissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dmt_commissions (id, dmt_id, user_id, role, commission_amount, service_product_item_id, created_at, updated_at) FROM stdin;
1	59	139	retailer	2.0000	\N	2025-12-26 12:47:43.624062	2025-12-26 12:47:43.624062
2	59	136	superadmin	10.0000	\N	2025-12-26 12:47:43.660282	2025-12-26 12:47:43.660282
3	65	136	superadmin	10.0000	\N	2026-05-29 12:57:52.092329	2026-05-29 12:57:52.092329
4	65	136	superadmin	10.0000	\N	2026-06-03 08:31:12.286797	2026-06-03 08:31:12.286797
5	65	181	admin	10.0000	\N	2026-07-06 12:15:51.050021	2026-07-06 12:15:51.050021
6	68	181	admin	10.0000	\N	2026-08-07 08:37:18.474964	2026-08-07 08:37:18.474964
7	68	194	retailer	5.0000	\N	2026-08-07 08:43:45.884913	2026-08-07 08:43:45.884913
8	68	181	admin	5.0000	\N	2026-08-07 08:43:45.903284	2026-08-07 08:43:45.903284
9	68	194	retailer	5.0000	\N	2026-08-07 08:48:04.390732	2026-08-07 08:48:04.390732
10	68	194	retailer	5.0000	\N	2026-08-07 08:50:31.083446	2026-08-07 08:50:31.083446
\.


--
-- Data for Name: dmt_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dmt_transactions (id, dmt_id, user_id, status, txn_id, sender_mobile_number, bank_name, account_number, amount, parent_id, created_at, updated_at, fee, tid, tds, service_tax, commission, txstatus_desc, collectable_amount) FROM stdin;
1	1	127	success	TXN113F205E5643	6546456464	HDFC	888888888888888888	0.0	\N	2025-11-14 07:58:52.713944	2025-11-14 08:42:10.493849	0.00	\N	0.00	0.00	0.00	\N	0.00
2	2	127	success	TXN69A93DE5433D	6546456464	HDFC	888888888888888888	0.0	\N	2025-11-14 08:43:56.751506	2025-11-14 08:44:11.300888	0.00	\N	0.00	0.00	0.00	\N	0.00
3	3	127	pending	TXNA56FDE4F32F0	\N	Axis Bank	435345789798797	0.0	\N	2025-11-14 08:51:40.643231	2025-11-14 08:51:40.643231	0.00	\N	0.00	0.00	0.00	\N	0.00
4	4	127	pending	TXNFDF69AB5B2A1	6546456464	Axis Bank	435345789798797	0.0	\N	2025-11-14 09:21:13.167848	2025-11-14 09:21:13.167848	0.00	\N	0.00	0.00	0.00	\N	0.00
5	5	127	pending	TXN457F2FC95C8F	5675675676	Axis Bank	435345789798797	0.0	\N	2025-11-14 09:27:44.110021	2025-11-14 09:27:44.110021	0.00	\N	0.00	0.00	0.00	\N	0.00
6	6	127	pending	TXN63AE5C5C5BDC	\N	Axis Bank	1111111111	0.0	\N	2025-11-14 12:14:17.408636	2025-11-14 12:14:17.408636	0.00	\N	0.00	0.00	0.00	\N	0.00
7	7	127	success	TXNBFAF48733486	6666666677	Axis Bank	1111111111	0.0	\N	2025-11-14 12:15:21.191085	2025-11-14 12:15:44.779956	0.00	\N	0.00	0.00	0.00	\N	0.00
8	8	127	pending	TXN6711D3757165	9879879797	SBI	433333333333333334	0.0	\N	2025-11-22 06:32:21.565073	2025-11-22 06:32:21.565073	0.00	\N	0.00	0.00	0.00	\N	0.00
9	9	127	pending	TXN570874639E01	\N	Bob	1234567890	0.0	\N	2025-11-26 13:32:27.378181	2025-11-26 13:32:27.378181	0.00	\N	0.00	0.00	0.00	\N	0.00
10	10	127	success	TXN35FD1F2CC3D0	6546456464	Bob	1234567890	0.0	\N	2025-11-26 13:33:13.204622	2025-11-26 13:33:28.775841	0.00	\N	0.00	0.00	0.00	\N	0.00
11	11	139	pending	TXNA8FC896EEAEE	\N	sbi	886868886868868	0.0	\N	2025-12-16 07:13:05.234349	2025-12-16 07:13:05.234349	0.00	\N	0.00	0.00	0.00	\N	0.00
12	12	139	pending	TXNC70F1E901CBA	\N	Bandhan Bank	52200032996299	0.0	\N	2025-12-19 05:59:42.085815	2025-12-19 05:59:42.085815	0.00	\N	0.00	0.00	0.00	\N	0.00
13	14	104	pending	TXNFF779A2BAB18	\N	HDFC BANK	9999999999	5000.0	\N	2025-12-24 09:32:39.26687	2025-12-24 09:32:39.26687	0.00	\N	0.00	0.00	0.00	\N	0.00
14	15	104	pending	TXN16AF6B2501AF	\N	HDFC BANK	9999999999	100.0	\N	2025-12-24 09:39:23.272358	2025-12-24 09:39:23.272358	0.00	\N	0.00	0.00	0.00	\N	0.00
15	16	104	pending	TXN905AF86D8D97	\N	HDFC BANK	9999999999	100.0	\N	2025-12-24 10:36:10.324982	2025-12-24 10:36:10.324982	0.00	\N	0.00	0.00	0.00	\N	0.00
16	17	104	pending	TXN0E0CCD48DCFF	\N	HDFC BANK	9999999999	123.0	\N	2025-12-24 10:38:20.192736	2025-12-24 10:38:20.192736	0.00	\N	0.00	0.00	0.00	\N	0.00
17	18	104	pending	TXN99CEF5FE49F9	\N	HDFC BANK	9999999999	123.0	\N	2025-12-24 10:38:42.241276	2025-12-24 10:38:42.241276	0.00	\N	0.00	0.00	0.00	\N	0.00
18	19	104	pending	TXN0BC7E7D4F1A3	\N	HDFC BANK	9999999999	123.0	\N	2025-12-24 10:39:03.786241	2025-12-24 10:39:03.786241	0.00	\N	0.00	0.00	0.00	\N	0.00
19	20	104	pending	TXND262517995B4	\N	HDFC BANK	9999999999	123.0	\N	2025-12-24 10:39:25.171521	2025-12-24 10:39:25.171521	0.00	\N	0.00	0.00	0.00	\N	0.00
20	21	104	pending	TXN7E08EE5F3B27	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 10:42:05.075176	2025-12-24 10:42:05.075176	0.00	\N	0.00	0.00	0.00	\N	0.00
21	22	104	pending	TXN1E6C40AC9F5C	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 10:50:43.969501	2025-12-24 10:50:43.969501	0.00	\N	0.00	0.00	0.00	\N	0.00
22	23	104	pending	TXN1720134B692C	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:09:23.580388	2025-12-24 11:09:23.580388	0.00	\N	0.00	0.00	0.00	\N	0.00
23	24	104	pending	TXN94276DDCD718	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:26:35.676904	2025-12-24 11:26:35.676904	0.00	\N	0.00	0.00	0.00	\N	0.00
24	25	104	pending	TXN7AF6C130693A	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:27:37.895156	2025-12-24 11:27:37.895156	0.00	\N	0.00	0.00	0.00	\N	0.00
25	26	104	pending	TXN847FAB0DD59B	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:28:30.007575	2025-12-24 11:28:30.007575	0.00	\N	0.00	0.00	0.00	\N	0.00
26	27	104	pending	TXN70A5CCAF5E52	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:29:37.284937	2025-12-24 11:29:37.284937	0.00	\N	0.00	0.00	0.00	\N	0.00
27	28	104	pending	TXN25B30339B83B	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:30:21.586947	2025-12-24 11:30:21.586947	0.00	\N	0.00	0.00	0.00	\N	0.00
28	29	104	pending	TXN71456BE07026	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:32:49.666865	2025-12-24 11:32:49.666865	0.00	\N	0.00	0.00	0.00	\N	0.00
29	30	104	pending	TXND95F60E12697	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:33:46.928891	2025-12-24 11:33:46.928891	0.00	\N	0.00	0.00	0.00	\N	0.00
30	31	104	pending	TXNEA6FC4ABE07B	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:35:15.954343	2025-12-24 11:35:15.954343	0.00	\N	0.00	0.00	0.00	\N	0.00
31	32	104	pending	TXNE2A6246E88B3	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:38:07.802015	2025-12-24 11:38:07.802015	0.00	\N	0.00	0.00	0.00	\N	0.00
32	33	104	pending	TXNDD23A6B15812	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:39:55.019993	2025-12-24 11:39:55.019993	0.00	\N	0.00	0.00	0.00	\N	0.00
33	34	104	pending	TXN88982E970E9C	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:42:39.297314	2025-12-24 11:42:39.297314	0.00	\N	0.00	0.00	0.00	\N	0.00
34	35	104	pending	TXNFA4FDC87978D	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:44:39.326831	2025-12-24 11:44:39.326831	0.00	\N	0.00	0.00	0.00	\N	0.00
35	36	104	pending	TXN814A221D4313	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:46:08.30691	2025-12-24 11:46:08.30691	0.00	\N	0.00	0.00	0.00	\N	0.00
36	37	104	pending	TXN542D6A8A0965	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:49:45.479665	2025-12-24 11:49:45.479665	0.00	\N	0.00	0.00	0.00	\N	0.00
37	38	104	pending	TXN4682D64550BA	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:54:02.093703	2025-12-24 11:54:02.093703	0.00	\N	0.00	0.00	0.00	\N	0.00
38	39	104	pending	TXND1ED88A451BB	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 12:05:44.731779	2025-12-24 12:05:44.731779	0.00	\N	0.00	0.00	0.00	\N	0.00
39	40	104	pending	TXN365A2ECDEAA9	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 12:13:18.11363	2025-12-24 12:13:18.11363	0.00	\N	0.00	0.00	0.00	\N	0.00
40	41	104	pending	TXN4466414F080C	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 12:14:07.214043	2025-12-24 12:14:07.214043	0.00	\N	0.00	0.00	0.00	\N	0.00
41	42	104	pending	TXNC056B21A562F	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 12:15:55.968684	2025-12-24 12:15:55.968684	0.00	\N	0.00	0.00	0.00	\N	0.00
42	43	104	pending	TXND71E8F004B7D	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 12:18:45.248695	2025-12-24 12:18:45.248695	0.00	\N	0.00	0.00	0.00	\N	0.00
43	44	104	pending	TXNCC3E9841FCCD	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 12:28:15.501425	2025-12-24 12:28:15.501425	0.00	\N	0.00	0.00	0.00	\N	0.00
44	45	104	pending	TXNDC7B223B4638	\N	HDFC BANK	9999999999	104.0	\N	2025-12-24 13:34:24.978603	2025-12-24 13:34:24.978603	0.00	\N	0.00	0.00	0.00	\N	0.00
45	46	104	pending	TXNA8F30082D3D0	\N	HDFC BANK	9999999999	114.0	\N	2025-12-24 13:35:43.240304	2025-12-24 13:35:43.240304	0.00	\N	0.00	0.00	0.00	\N	0.00
46	47	104	pending	TXN99C67D8B850D	\N	HDFC BANK	9999999999	114.0	\N	2025-12-24 13:36:24.876457	2025-12-24 13:36:24.876457	0.00	\N	0.00	0.00	0.00	\N	0.00
47	48	104	pending	TXN9AE6C2AA7391	\N	HDFC BANK	9999999999	114.0	\N	2025-12-24 18:05:59.505581	2025-12-24 18:05:59.505581	0.00	\N	0.00	0.00	0.00	\N	0.00
48	49	104	pending	TXNFE23E0F35DA4	\N	HDFC BANK	9999999999	114.0	\N	2025-12-24 18:12:35.555104	2025-12-24 18:12:35.555104	0.00	\N	0.00	0.00	0.00	\N	0.00
51	52	104	pending	TXN6A48337F80EB	\N	HDFC BANK	9999999999	114.0	\N	2025-12-24 18:17:45.523841	2025-12-24 18:17:45.523841	0.00	\N	0.00	0.00	0.00	\N	0.00
52	53	104	pending	TXNB70B6491915D	\N	HDFC BANK	9999999999	114.0	\N	2025-12-24 18:26:46.411068	2025-12-24 18:26:46.411068	0.00	\N	0.00	0.00	0.00	\N	0.00
53	54	104	success	TXNE22C7A798C9D	\N	HDFC BANK	9999999999	114.0	\N	2025-12-24 18:33:48.464184	2025-12-24 18:54:07.403978	0.00	\N	0.00	0.00	0.00	\N	0.00
54	55	139	success	TXND35C9D32EDDC	\N	HDFC BANK	9999999999	100.0	\N	2025-12-24 18:59:00.286757	2025-12-24 18:59:46.98804	0.00	\N	0.00	0.00	0.00	\N	0.00
55	56	139	success	TXN0056B3AE0F24	\N	HDFC BANK	9999999999	100.0	\N	2025-12-24 19:19:45.365057	2025-12-24 19:29:00.653107	0.00	\N	0.00	0.00	0.00	\N	0.00
56	57	139	success	TXN18530AA4DA46	\N	HDFC BANK	9999999999	100.0	\N	2025-12-25 04:51:10.254033	2025-12-25 04:52:30.287816	0.00	\N	0.00	0.00	0.00	\N	0.00
57	58	139	pending	TXN0AC6C9994F86	\N	HDFC BANK	9999999999	100.0	\N	2025-12-26 12:29:22.931514	2025-12-26 12:29:22.931514	0.00	\N	0.00	0.00	0.00	\N	0.00
58	59	139	success	TXND16D52F85337	\N	HDFC BANK	9999999999	1001.0	\N	2025-12-26 12:47:00.658782	2025-12-26 12:47:43.594361	0.00	\N	0.00	0.00	0.00	\N	0.00
59	60	139	pending	TXNBF5DA076F764	\N	HDFC BANK	9999999999	1001.0	\N	2025-12-26 16:50:15.277761	2025-12-26 16:50:15.277761	0.00	\N	0.00	0.00	0.00	\N	0.00
60	65	189	success	TXN983670	\N	\N	\N	100.0	\N	2026-05-29 12:57:52.056589	2026-05-29 12:57:52.056589	10.00	3562456554	0.01	1.53	0.47	Success	110.00
61	65	189	success	TXN493035	\N	\N	\N	100.0	\N	2026-06-03 08:31:11.805437	2026-06-03 08:31:11.805437	10.00	3563132591	0.01	1.53	0.47	Success	110.00
62	65	194	success	TXN842623	\N	\N	\N	60.0	\N	2026-07-06 12:15:50.551625	2026-07-06 12:15:50.551625	0.00	\N	0.00	0.00	0.00	\N	0.00
63	68	194	success	TXN630690	\N	\N	\N	1.0	\N	2026-08-07 08:37:18.440555	2026-08-07 08:37:18.440555	0.00	\N	0.00	0.00	0.00	\N	0.00
64	68	194	success	TXN501049	\N	\N	\N	1.0	\N	2026-08-07 08:43:45.869533	2026-08-07 08:43:45.869533	0.00	\N	0.00	0.00	0.00	\N	0.00
65	68	194	success	TXN993678	\N	\N	\N	1.0	\N	2026-08-07 08:48:04.374015	2026-08-07 08:48:04.374015	0.00	\N	0.00	0.00	0.00	\N	0.00
66	68	194	success	TXN955287	\N	\N	\N	1.0	\N	2026-08-07 08:50:31.071241	2026-08-07 08:50:31.071241	0.00	\N	0.00	0.00	0.00	\N	0.00
\.


--
-- Data for Name: dmts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dmts (id, account_number, confirm_account_number, sender_mobile_number, receiver_name, receiver_mobile_number, sender_full_name, bank_name, ifsc_code, branch_name, amount, parent_id, user_id, beneficiaries_status, status, aadhaar_number_otp, aadhaar_number_otp_expiry, created_at, updated_at, customer_id, recipient_id, bank_verify_status, vendor_user_id, txn_id, transaction_status) FROM stdin;
1	888888888888888888	888888888888888888	6546456464	Mohammad Aamir	9999999999	\N	HDFC	BARB0PANDEY	\N	500.0	104	\N	f	pending	\N	\N	2025-11-14 07:58:52.699257	2025-11-14 07:59:05.767403	\N	\N	f	\N	\N	f
2	888888888888888888	888888888888888888	6546456464	njhjhj	8979707098	\N	HDFC	BARB0PANDEY	\N	500.0	104	\N	f	pending	\N	\N	2025-11-14 08:43:56.740771	2025-11-14 08:44:02.88416	\N	\N	f	\N	\N	f
3	435345789798797	435345789798797	\N	Mohammad Aamir	9999999999	\N	Axis Bank	UTIB0001234	\N	\N	104	\N	t	pending	\N	\N	2025-11-14 08:51:40.635493	2025-11-14 08:51:40.635493	\N	\N	f	\N	\N	f
4	435345789798797	435345789798797	6546456464	Mohammad Aamir	9999999999	\N	Axis Bank	UTIB0001234	\N	500.0	104	\N	f	pending	\N	\N	2025-11-14 09:21:13.136517	2025-11-14 09:23:07.375588	\N	\N	f	\N	\N	f
5	435345789798797	435345789798797	5675675676	Mohammad Aamir	9999999999	\N	Axis Bank	UTIB0001234	\N	500.0	104	\N	f	pending	\N	\N	2025-11-14 09:27:44.080624	2025-11-14 09:27:49.858894	\N	\N	f	\N	\N	f
6	1111111111	1111111111	\N	Mohammad Aamir	8888888888	\N	Axis Bank	UTIB0001234	\N	\N	104	\N	t	pending	\N	\N	2025-11-14 12:14:17.377756	2025-11-14 12:14:17.377756	\N	\N	f	\N	\N	f
7	1111111111	1111111111	6666666677	Mohammad Aamir	8888888888	\N	Axis Bank	UTIB0001234	\N	500.0	104	\N	f	pending	\N	\N	2025-11-14 12:15:21.184784	2025-11-14 12:15:27.403668	\N	\N	f	\N	\N	f
8	433333333333333334	433333333333333334	9879879797	siddharth	9879879878	\N	SBI	UTIB0004491	\N	100.0	104	\N	f	pending	\N	\N	2025-11-22 06:32:21.521034	2025-11-22 06:32:44.213657	\N	\N	f	\N	\N	f
9	1234567890	1234567890	\N	aaa	7777777777	\N	Bob	UTIB0001234	\N	\N	104	\N	t	pending	\N	\N	2025-11-26 13:32:27.323937	2025-11-26 13:32:27.323937	\N	\N	f	\N	\N	f
10	1234567890	1234567890	6546456464	aaa	7777777777	\N	Bob	UTIB0001234	\N	500.0	104	\N	f	pending	\N	\N	2025-11-26 13:33:13.193668	2025-11-26 13:33:19.138902	\N	\N	f	\N	\N	f
11	886868886868868	886868886868868	\N	aamir	8181818181	\N	sbi	SBIN0023456	\N	\N	104	\N	t	pending	\N	\N	2025-12-16 07:13:05.181785	2025-12-16 07:13:05.181785	\N	\N	f	\N	\N	f
12	52200032996299	52200032996299	\N	SONAM GUPTA	6268075916	\N	Bandhan Bank	BDBL0001498	\N	\N	104	\N	t	recipient_added	\N	\N	2025-12-19 05:59:41.761604	2025-12-19 05:59:42.042517	\N	\N	f	\N	\N	f
13	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	5000.0	136	\N	f	pending	\N	\N	2025-12-24 09:32:05.005697	2025-12-24 09:32:05.005697	\N	\N	f	\N	\N	f
14	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	5000.0	136	\N	f	pending	\N	\N	2025-12-24 09:32:39.237286	2025-12-24 09:32:39.237286	\N	\N	f	\N	\N	f
15	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	100.0	136	\N	f	pending	\N	\N	2025-12-24 09:39:23.258417	2025-12-24 09:39:23.258417	\N	\N	f	\N	\N	f
16	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	100.0	136	\N	f	pending	\N	\N	2025-12-24 10:36:10.30045	2025-12-24 10:36:10.30045	\N	\N	f	\N	\N	f
17	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	100.0	136	\N	f	pending	\N	\N	2025-12-24 10:38:20.174428	2025-12-24 10:38:20.174428	\N	\N	f	\N	\N	f
18	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	100.0	136	\N	f	pending	\N	\N	2025-12-24 10:38:42.221644	2025-12-24 10:38:42.221644	\N	\N	f	\N	\N	f
19	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	100.0	136	\N	f	pending	\N	\N	2025-12-24 10:39:03.75083	2025-12-24 10:39:03.75083	\N	\N	f	\N	\N	f
20	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	100.0	136	\N	f	pending	\N	\N	2025-12-24 10:39:25.150411	2025-12-24 10:39:25.150411	\N	\N	f	\N	\N	f
21	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	100.0	136	\N	f	pending	\N	\N	2025-12-24 10:42:05.05475	2025-12-24 10:42:05.05475	\N	\N	f	\N	\N	f
22	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 10:50:43.949574	2025-12-24 10:50:43.949574	\N	\N	f	\N	\N	f
23	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:09:23.561014	2025-12-24 11:09:23.561014	\N	\N	f	\N	\N	f
24	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:26:35.654981	2025-12-24 11:26:35.654981	\N	\N	f	\N	\N	f
25	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:27:37.875115	2025-12-24 11:27:37.875115	\N	\N	f	\N	\N	f
26	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:28:29.978043	2025-12-24 11:28:29.978043	\N	\N	f	\N	\N	f
27	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:29:37.257193	2025-12-24 11:29:37.257193	\N	\N	f	\N	\N	f
28	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:30:21.576006	2025-12-24 11:30:21.576006	\N	\N	f	\N	\N	f
29	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:32:49.656064	2025-12-24 11:32:49.656064	\N	\N	f	\N	\N	f
30	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:33:46.918115	2025-12-24 11:33:46.918115	\N	\N	f	\N	\N	f
31	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:35:15.946487	2025-12-24 11:35:15.946487	\N	\N	f	\N	\N	f
32	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:38:07.781957	2025-12-24 11:38:07.781957	\N	\N	f	\N	\N	f
33	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:39:55.001422	2025-12-24 11:39:55.001422	\N	\N	f	\N	\N	f
34	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:42:39.27875	2025-12-24 11:42:39.27875	\N	\N	f	\N	\N	f
35	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:44:39.307075	2025-12-24 11:44:39.307075	\N	\N	f	\N	\N	f
36	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:46:08.287384	2025-12-24 11:46:08.287384	\N	\N	f	\N	\N	f
37	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:49:45.445002	2025-12-24 11:49:45.445002	\N	\N	f	\N	\N	f
38	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:54:02.048459	2025-12-24 11:54:02.048459	\N	\N	f	\N	\N	f
39	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 12:05:44.718444	2025-12-24 12:05:44.718444	\N	\N	f	\N	\N	f
40	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 12:13:18.081468	2025-12-24 12:13:18.081468	\N	\N	f	\N	\N	f
41	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 12:14:07.204475	2025-12-24 12:14:07.204475	\N	\N	f	\N	\N	f
42	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 12:15:55.95535	2025-12-24 12:15:55.95535	\N	\N	f	\N	\N	f
43	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 12:18:45.238437	2025-12-24 12:18:45.238437	\N	\N	f	\N	\N	f
44	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 12:28:15.476688	2025-12-24 12:28:15.476688	\N	\N	f	\N	\N	f
45	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	104.0	136	\N	f	pending	\N	\N	2025-12-24 13:34:24.957961	2025-12-24 13:34:24.957961	\N	\N	f	\N	\N	f
46	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	114.0	136	\N	f	pending	\N	\N	2025-12-24 13:35:43.229431	2025-12-24 13:35:43.229431	\N	\N	f	\N	\N	f
47	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	114.0	136	\N	f	pending	\N	\N	2025-12-24 13:36:24.864124	2025-12-24 13:36:24.864124	\N	\N	f	\N	\N	f
48	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	114.0	136	\N	f	pending	\N	\N	2025-12-24 18:05:59.474001	2025-12-24 18:05:59.474001	\N	\N	f	\N	\N	f
49	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	114.0	136	\N	f	pending	\N	\N	2025-12-24 18:12:35.533859	2025-12-24 18:12:35.533859	\N	\N	f	\N	\N	f
52	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	114.0	136	\N	f	pending	\N	\N	2025-12-24 18:17:45.500469	2025-12-24 18:17:45.500469	\N	\N	f	\N	\N	f
53	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	114.0	136	\N	f	pending	\N	\N	2025-12-24 18:26:46.39481	2025-12-24 18:26:46.39481	\N	\N	f	\N	\N	f
54	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	114.0	136	\N	f	pending	\N	\N	2025-12-24 18:33:48.453674	2025-12-24 18:33:48.453674	\N	\N	f	\N	\N	f
55	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	100.0	104	\N	f	pending	\N	\N	2025-12-24 18:59:00.257493	2025-12-24 18:59:00.257493	\N	\N	f	\N	\N	f
56	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	114.0	104	\N	f	pending	\N	\N	2025-12-24 19:19:45.351641	2025-12-24 19:29:00.614443	\N	\N	f	\N	\N	f
57	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	114.0	104	\N	f	pending	\N	\N	2025-12-25 04:51:10.233111	2025-12-25 04:52:30.249599	\N	\N	f	\N	\N	f
58	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	100.0	104	\N	f	pending	\N	\N	2025-12-26 12:29:22.904098	2025-12-26 12:29:22.904098	\N	\N	f	\N	\N	f
59	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	1021.0	104	\N	f	pending	\N	\N	2025-12-26 12:47:00.605961	2025-12-26 12:47:43.52992	\N	\N	f	\N	\N	f
60	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	1001.0	104	\N	f	pending	\N	\N	2025-12-26 16:50:15.221296	2025-12-26 16:50:15.221296	\N	\N	f	\N	\N	f
61	3323232	32332	\N	\N	\N	\N	aaa	\N	\N	\N	104	139	\N	\N	\N	\N	2025-12-27 06:40:19.605709	2025-12-27 06:52:58.916544	\N	\N	t	\N	\N	f
64	23110200000404	\N	\N	\N	\N	\N	\N	FDRL0001232	\N	\N	\N	\N	\N	\N	\N	\N	2026-05-29 12:55:48.520134	2026-05-29 12:55:48.520134	\N	\N	t	2	\N	f
66	23110200000412	\N	\N	\N	\N	\N	\N	FDRL0001232	\N	\N	\N	\N	\N	\N	\N	\N	2026-06-03 08:36:02.48479	2026-06-03 08:36:02.48479	\N	\N	t	5	\N	f
67	23110200000412	\N	9348075033	NARASINGH SUAR	9348075033	narasingh suar	Federal Bank	FDRL0001232	\N	0.0	184	189	t	recipient_added	\N	\N	2026-06-03 08:36:10.368051	2026-06-03 08:36:10.368051	\N	116979226	t	5	TXN602748	f
65	23110200000404	\N	9337691368	PRASAD KUMAR MOHANTY	9337691368	PRASAD KUMAR MOHANTY	Federal Bank	FDRL0001232	\N	80.0	184	189	t	Success	\N	\N	2026-05-29 12:56:05.206731	2026-07-06 12:15:50.590526	\N	116974845	t	2	TXN542633	t
68	922010023211252	\N	9305096443	siddharth Gautam	9568773855	siddharth Gautam	Axis Bank	UTIB0002193	\N	21.0	184	194	t	Success	\N	\N	2026-08-07 08:36:18.653583	2026-08-07 08:37:18.445016	\N	117023688	f	6	TXN263862	t
\.


--
-- Data for Name: eko_banks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.eko_banks (id, bank_id, name, ifsc_prefix, bank_code, status, created_at, updated_at) FROM stdin;
1	1	Axis Bank	UTIB	UTIB	t	2025-12-19 05:49:53.476042	2025-12-19 05:49:53.476042
2	2	Bank of Baroda	BARB	BARB	t	2025-12-19 05:49:53.482035	2025-12-19 05:49:53.482035
3	3	Bank of India	BKID	BKID	t	2025-12-19 05:49:53.487715	2025-12-19 05:49:53.487715
4	4	Central Bank of India	CBIN	CBIN	t	2025-12-19 05:49:53.493683	2025-12-19 05:49:53.493683
5	5	Citibank	CITI	CITI	t	2025-12-19 05:49:53.500091	2025-12-19 05:49:53.500091
6	6	HDFC Bank	HDFC	HDFC	t	2025-12-19 05:49:53.506093	2025-12-19 05:49:53.506093
7	7	ICICI Bank	ICIC	ICIC	t	2025-12-19 05:49:53.51317	2025-12-19 05:49:53.51317
8	8	IDBI Bank	IBKL	IBKL	t	2025-12-19 05:49:53.519248	2025-12-19 05:49:53.519248
9	9	Indian Bank	IDIB	IDIB	t	2025-12-19 05:49:53.525152	2025-12-19 05:49:53.525152
10	10	Indian Overseas Bank	IOBA	IOBA	t	2025-12-19 05:49:53.549871	2025-12-19 05:49:53.549871
11	11	Punjab National Bank	PUNB	PUNB	t	2025-12-19 05:49:53.596458	2025-12-19 05:49:53.596458
12	12	State Bank of Bikaner and Jaipur	NULL	NULL	t	2025-12-19 05:49:53.601789	2025-12-19 05:49:53.601789
13	13	Union Bank of India	UBIN	UBIN	t	2025-12-19 05:49:53.606959	2025-12-19 05:49:53.606959
14	14	UCO Bank	UCBA	UCBA	t	2025-12-19 05:49:53.612097	2025-12-19 05:49:53.612097
15	16	Yes Bank	YESB	YESB	t	2025-12-19 05:49:53.617586	2025-12-19 05:49:53.617586
16	17	Dena Bank	BKDN	BKDN	t	2025-12-19 05:49:53.623301	2025-12-19 05:49:53.623301
17	18	Abhyudaya Co-Op Bank	ABHY	ABHY	t	2025-12-19 05:49:53.629527	2025-12-19 05:49:53.629527
18	19	Abu Dhabi Commercial Bank	ADCB	ADCB	f	2025-12-19 05:49:53.635272	2025-12-19 05:49:53.635272
19	20	Allahabad Bank	ALLA	ALLA	t	2025-12-19 05:49:53.641353	2025-12-19 05:49:53.641353
20	21	Andhra Bank	ANDB	ANDB	t	2025-12-19 05:49:53.647746	2025-12-19 05:49:53.647746
21	22	Bank of America	BOFA	BOFA	t	2025-12-19 05:49:53.653064	2025-12-19 05:49:53.653064
22	23	Bank of Bahrain and Kuwait	BBKM	BBKM	f	2025-12-19 05:49:53.658297	2025-12-19 05:49:53.658297
23	24	Bank of Ceylon	BCEY	BCEY	f	2025-12-19 05:49:53.663634	2025-12-19 05:49:53.663634
24	25	Bank of Maharashtra	MAHB	MAHB	t	2025-12-19 05:49:53.668674	2025-12-19 05:49:53.668674
25	26	Bank Of Tokyo Mitsubishi Ufj Ltd	BOTM	BOTM	f	2025-12-19 05:49:53.674338	2025-12-19 05:49:53.674338
26	27	Barclays Bank	BARC	BARC	t	2025-12-19 05:49:53.679769	2025-12-19 05:49:53.679769
27	28	Bassein Catholic Co-Op Bank	BACB	BACB	t	2025-12-19 05:49:53.684717	2025-12-19 05:49:53.684717
28	29	Bnp Paribas Bank	BNPA	BNPA	t	2025-12-19 05:49:53.689635	2025-12-19 05:49:53.689635
29	30	Canara Bank	CNRB	CNRB	t	2025-12-19 05:49:53.694607	2025-12-19 05:49:53.694607
30	32	Catholic Syrian Bank	CSBK	CSBK	t	2025-12-19 05:49:53.699479	2025-12-19 05:49:53.699479
31	33	Chinatrust Commercial Bank	CTCB	CTCB	f	2025-12-19 05:49:53.704423	2025-12-19 05:49:53.704423
32	34	Citizen Credit Co-Op Bank	CCBL	CCBL	t	2025-12-19 05:49:53.709334	2025-12-19 05:49:53.709334
33	35	City Union Bank	CIUB	CIUB	t	2025-12-19 05:49:53.714296	2025-12-19 05:49:53.714296
34	37	Corporation Bank	CORP	CORP	t	2025-12-19 05:49:53.719118	2025-12-19 05:49:53.719118
35	38	Credit Agricole Corporate And Investment Bank Calyon Bank	CRLY	CRLY	f	2025-12-19 05:49:53.724016	2025-12-19 05:49:53.724016
36	39	DBS Bank	DBSS	DBSS	t	2025-12-19 05:49:53.729073	2025-12-19 05:49:53.729073
37	41	Deutsche Bank AG	DEUT	DEUT	f	2025-12-19 05:49:53.73411	2025-12-19 05:49:53.73411
38	42	Development Credit Bank	DCBL	DCBL	t	2025-12-19 05:49:53.739057	2025-12-19 05:49:53.739057
39	43	Dhanlaxmi Bank	DLXB	DLXB	t	2025-12-19 05:49:53.743967	2025-12-19 05:49:53.743967
40	44	Deposit Insurance and Credit Guarantee Corporation	DICG	DICG	f	2025-12-19 05:49:53.748817	2025-12-19 05:49:53.748817
41	45	Dombivli Nagari Sahakari Bank	DNSB	DNSB	t	2025-12-19 05:49:53.753783	2025-12-19 05:49:53.753783
42	46	Firstrand Bank	FIRN	FIRN	f	2025-12-19 05:49:53.758648	2025-12-19 05:49:53.758648
43	47	HSBC	HSBC	HSBC	t	2025-12-19 05:49:53.763454	2025-12-19 05:49:53.763454
44	48	IndusInd Bank	INDB	INDB	t	2025-12-19 05:49:53.768296	2025-12-19 05:49:53.768296
45	49	ING Vysya Bank	VYSA	VYSA	t	2025-12-19 05:49:53.773099	2025-12-19 05:49:53.773099
46	50	Janakalyan Sahakari Bank	JSBL	JSBL	t	2025-12-19 05:49:53.778037	2025-12-19 05:49:53.778037
47	51	Janata Sahakari Bank Pune	JSBP	JSBP	t	2025-12-19 05:49:53.782822	2025-12-19 05:49:53.782822
48	52	JP Morgan Chase Bank	CHAS	CHAS	f	2025-12-19 05:49:53.787641	2025-12-19 05:49:53.787641
49	53	Kapole Co-Op Bank	KCBL	KCBL	f	2025-12-19 05:49:53.792503	2025-12-19 05:49:53.792503
50	54	Karnataka Bank	KARB	KARB	t	2025-12-19 05:49:53.797298	2025-12-19 05:49:53.797298
51	55	Karur Vysya Bank	KVBL	KVBL	t	2025-12-19 05:49:53.802207	2025-12-19 05:49:53.802207
52	56	Kotak Mahindra Bank	KKBK	KKBK	t	2025-12-19 05:49:53.807119	2025-12-19 05:49:53.807119
53	57	Mahanagar Co-Op Bank	MCBL	MCBL	t	2025-12-19 05:49:53.812385	2025-12-19 05:49:53.812385
54	58	Maharashtra State Co-Op Bank	MSCI	MSCI	t	2025-12-19 05:49:53.817394	2025-12-19 05:49:53.817394
55	59	Mashreq Bank PSC	MSHQ	MSHQ	f	2025-12-19 05:49:53.822336	2025-12-19 05:49:53.822336
56	60	Mizuho Corporate Bank	MHCB	MHCB	f	2025-12-19 05:49:53.827405	2025-12-19 05:49:53.827405
57	61	New India Co-Op Bank Ltd	NICB	NICB	f	2025-12-19 05:49:53.832758	2025-12-19 05:49:53.832758
58	62	NKGSB Co-Op Bank	NKGS	NKGS	t	2025-12-19 05:49:53.837737	2025-12-19 05:49:53.837737
59	63	Nutan Nagarik Sahakari Bank	NNSB	NNSB	t	2025-12-19 05:49:53.843228	2025-12-19 05:49:53.843228
60	64	Oman International Bank Saog	OIBA	OIBA	f	2025-12-19 05:49:53.848843	2025-12-19 05:49:53.848843
61	65	Oriental Bank of Commerce	ORBC	ORBC	t	2025-12-19 05:49:53.854231	2025-12-19 05:49:53.854231
62	66	Parsik Janata Sahakari Bank	PJSB	PJSB	t	2025-12-19 05:49:53.859239	2025-12-19 05:49:53.859239
63	67	Punjab And Maharashtra Co-Op Bank	PMCB	PMCB	f	2025-12-19 05:49:53.864534	2025-12-19 05:49:53.864534
64	68	Punjab and Sind Bank	PSIB	PSIB	t	2025-12-19 05:49:53.869712	2025-12-19 05:49:53.869712
65	69	Rajkot Nagarik Sahakari Bank	RNSB	RNSB	t	2025-12-19 05:49:53.874853	2025-12-19 05:49:53.874853
66	70	Reserve Bank of India	RBIS	RBIS	f	2025-12-19 05:49:53.880073	2025-12-19 05:49:53.880073
67	71	Shinhan Bank	SHBK	SHBK	t	2025-12-19 05:49:53.885226	2025-12-19 05:49:53.885226
68	72	Societe Generale Bank	SOGE	SOGE	f	2025-12-19 05:49:53.890412	2025-12-19 05:49:53.890412
69	73	South Indian Bank	SIBL	SIBL	t	2025-12-19 05:49:53.895621	2025-12-19 05:49:53.895621
70	74	Standard Chartered Bank	SCBL	SCBL	t	2025-12-19 05:49:53.90062	2025-12-19 05:49:53.90062
71	76	State Bank of Mauritius	STCB	STCB	f	2025-12-19 05:49:53.907021	2025-12-19 05:49:53.907021
72	80	Syndicate Bank	SYNB	SYNB	t	2025-12-19 05:49:53.915726	2025-12-19 05:49:53.915726
73	81	Tamilnad Mercantile Bank	TMBL	TMBL	t	2025-12-19 05:49:53.920716	2025-12-19 05:49:53.920716
74	82	Bank of Nova Scotia	NOSC	NOSC	f	2025-12-19 05:49:53.926145	2025-12-19 05:49:53.926145
75	83	Ahmedabad Mercantile Co-Op Bank	AMCB	AMCB	t	2025-12-19 05:49:53.931846	2025-12-19 05:49:53.931846
76	84	Bharat Co-Op Bank Mumbai	BCBM	BCBM	t	2025-12-19 05:49:53.937175	2025-12-19 05:49:53.937175
77	85	Cosmos Co-Op Bank	COSB	COSB	t	2025-12-19 05:49:53.943832	2025-12-19 05:49:53.943832
78	86	Federal Bank	FDRL	FDRL	t	2025-12-19 05:49:53.9507	2025-12-19 05:49:53.9507
79	87	Greater Bombay Co-Op Bank	GBCB	GBCB	t	2025-12-19 05:49:53.956291	2025-12-19 05:49:53.956291
80	88	Jammu and Kashmir Bank	JAKA	JAKA	t	2025-12-19 05:49:53.962371	2025-12-19 05:49:53.962371
81	89	Kalupur Commercial Co-Op Bank	KCCB	KCCB	t	2025-12-19 05:49:53.967578	2025-12-19 05:49:53.967578
82	90	Karnataka State Apex Co-Op Bank	KSBC	KSBC	f	2025-12-19 05:49:53.972822	2025-12-19 05:49:53.972822
83	91	Kalyan Janata Sahakari Bank	KJSB	KJSB	t	2025-12-19 05:49:53.978584	2025-12-19 05:49:53.978584
84	92	Lakshmi Vilas Bank	LAVB	LAVB	t	2025-12-19 05:49:53.983793	2025-12-19 05:49:53.983793
85	93	Mehsana Urban Co-Op Bank	MSNU	MSNU	t	2025-12-19 05:49:53.989037	2025-12-19 05:49:53.989037
86	94	Nainital Bank	NTBL	NTBL	t	2025-12-19 05:49:53.994476	2025-12-19 05:49:53.994476
87	95	The Ratnakar Bank Ltd	RATN	RATN	t	2025-12-19 05:49:53.999663	2025-12-19 05:49:53.999663
88	96	Royal Bank of Scotland	ABNA	ABNA	f	2025-12-19 05:49:54.004799	2025-12-19 05:49:54.004799
89	97	Saraswat Co-Op Bank	SRCB	SRCB	t	2025-12-19 05:49:54.010582	2025-12-19 05:49:54.010582
90	98	Shamrao Vithal Co-Op Bank	SVCB	SVCB	t	2025-12-19 05:49:54.015804	2025-12-19 05:49:54.015804
91	99	The Surat Peoples Co-Op Bank	SPCB	SPCB	t	2025-12-19 05:49:54.021079	2025-12-19 05:49:54.021079
92	100	Thane Janata Sahakari Bank	TJSB	TJSB	t	2025-12-19 05:49:54.026418	2025-12-19 05:49:54.026418
93	101	Tamilnadu State Apex Co-Op Bank	TNSC	TNSC	t	2025-12-19 05:49:54.031851	2025-12-19 05:49:54.031851
94	102	West Bengal State Co-Op Bank	WBSC	WBSC	f	2025-12-19 05:49:54.037015	2025-12-19 05:49:54.037015
95	103	Vijaya Bank	VIJB	VIJB	t	2025-12-19 05:49:54.04206	2025-12-19 05:49:54.04206
96	108	State Bank of India	SBIN	SBIN	t	2025-12-19 05:49:54.046979	2025-12-19 05:49:54.046979
97	109	A P Mahesh Co-Op Urban Bank Ltd	APMC	APMC	t	2025-12-19 05:49:54.052047	2025-12-19 05:49:54.052047
98	110	Karad Urban Co-Op Bank	KUCB	KUCB	t	2025-12-19 05:49:54.057555	2025-12-19 05:49:54.057555
99	111	Karnataka State Co-Op Apex Bank	KSCB	KSCB	f	2025-12-19 05:49:54.063232	2025-12-19 05:49:54.063232
100	112	Nashik Merchants Co-Op Bank	NMCB	NMCB	f	2025-12-19 05:49:54.068884	2025-12-19 05:49:54.068884
101	113	UBS AG Bank	UBSW	UBSW	f	2025-12-19 05:49:54.074831	2025-12-19 05:49:54.074831
102	114	United Bank of India	UTBI	UTBI	t	2025-12-19 05:49:54.080888	2025-12-19 05:49:54.080888
103	115	Kangra Co-Op Bank	KANG	KANG	f	2025-12-19 05:49:54.086809	2025-12-19 05:49:54.086809
104	116	Kangra Central Co-Op Bank	KACE	KACE	t	2025-12-19 05:49:54.092588	2025-12-19 05:49:54.092588
105	117	Prathama Bank	PRTH	PRTH	t	2025-12-19 05:49:54.097701	2025-12-19 05:49:54.097701
106	119	Chaitanya Godavari Grameena Bank	ACGG	ACGG	t	2025-12-19 05:49:54.10342	2025-12-19 05:49:54.10342
107	120	Allahabad UP Gramin Bank	ALLG	ALLG	f	2025-12-19 05:49:54.1088	2025-12-19 05:49:54.1088
108	121	Rushikulya Gramin Bank	ANDG	ANDG	f	2025-12-19 05:49:54.114061	2025-12-19 05:49:54.114061
109	122	Sharda Gramin Bank	ASGB	ASGB	f	2025-12-19 05:49:54.119596	2025-12-19 05:49:54.119596
110	123	Nainital Almora Kshetriya Gramin Bank	BARG	BARG	f	2025-12-19 05:49:54.124593	2025-12-19 05:49:54.124593
111	124	Baroda Rajasthan Gramin Bank	BARR	BARR	t	2025-12-19 05:49:54.130639	2025-12-19 05:49:54.130639
112	125	Baroda Uttar Pradesh Gramin Bank	BARU	BARU	t	2025-12-19 05:49:54.136977	2025-12-19 05:49:54.136977
113	126	Baroda Gujarat Gramin Bank	BGGB	BGGB	t	2025-12-19 05:49:54.142181	2025-12-19 05:49:54.142181
114	127	Jhabua Dhar Kshetriya Gramin Bank	BJDG	BJDG	f	2025-12-19 05:49:54.147145	2025-12-19 05:49:54.147145
115	128	Dena Gujarat Gramin Bank	BKDD	BKDD	t	2025-12-19 05:49:54.151972	2025-12-19 05:49:54.151972
116	129	Durg Rajnandgaon Gramin Bank	BKDR	BKDR	f	2025-12-19 05:49:54.156878	2025-12-19 05:49:54.156878
117	130	Baitarani Gramin Bank	BKIB	BKIB	f	2025-12-19 05:49:54.161897	2025-12-19 05:49:54.161897
118	131	Aryavart Gramin Bank	BKIG	BKIG	f	2025-12-19 05:49:54.166766	2025-12-19 05:49:54.166766
119	133	Wainganga Krishna Gramin Bank	BWKG	BWKG	f	2025-12-19 05:49:54.171657	2025-12-19 05:49:54.171657
120	134	Uttar Bihar Gramin Bank	CBBB	CBBB	f	2025-12-19 05:49:54.176711	2025-12-19 05:49:54.176711
121	135	Ballia Etawah Gramin Bank	CBIG	CBIG	f	2025-12-19 05:49:54.181598	2025-12-19 05:49:54.181598
122	136	Hadoti Kshetriya Gramin Bank	CBIH	CBIH	f	2025-12-19 05:49:54.186742	2025-12-19 05:49:54.186742
123	137	Surguja Kshetriya Gramin Bank	CKGB	CKGB	f	2025-12-19 05:49:54.191683	2025-12-19 05:49:54.191683
124	138	South Malabar Gramin Bank	CMGB	CMGB	f	2025-12-19 05:49:54.196569	2025-12-19 05:49:54.196569
125	139	Chickmangalur Kodagu Gramin Bank	CORG	CORG	f	2025-12-19 05:49:54.201397	2025-12-19 05:49:54.201397
126	140	Pragathi Gramin Bank	CPGB	CPGB	f	2025-12-19 05:49:54.206325	2025-12-19 05:49:54.206325
127	141	Shreyas Gramin Bank	CSGB	CSGB	f	2025-12-19 05:49:54.211347	2025-12-19 05:49:54.211347
128	142	Satpura Narmada Kshetriya Gramin Bank	CSUG	CSUG	f	2025-12-19 05:49:54.216298	2025-12-19 05:49:54.216298
129	143	Uttar Banga Kshetriya Gramin Bank	CUKG	CUKG	f	2025-12-19 05:49:54.221146	2025-12-19 05:49:54.221146
130	144	Vidharbha Kshetriya Gramin Bank	CVAG	CVAG	f	2025-12-19 05:49:54.226086	2025-12-19 05:49:54.226086
131	145	Madhya Bharat Gramin Bank	FBIG	FBIG	f	2025-12-19 05:49:54.231797	2025-12-19 05:49:54.231797
132	146	Gurgaon Gramin Bank	GGBK	GGBK	f	2025-12-19 05:49:54.237125	2025-12-19 05:49:54.237125
133	147	Malwa Gramin Bank	HDFG	HDFG	f	2025-12-19 05:49:54.242195	2025-12-19 05:49:54.242195
134	148	Mewar Anchalik Gramin Bank	ICIG	ICIG	f	2025-12-19 05:49:54.247238	2025-12-19 05:49:54.247238
135	149	Pallavan Grama Bank	IDIG	IDIG	f	2025-12-19 05:49:54.252889	2025-12-19 05:49:54.252889
136	150	Neelachal Gramya Bank	INGB	INGB	f	2025-12-19 05:49:54.258693	2025-12-19 05:49:54.258693
137	151	Pandyan Gramin Bank	IOBG	IOBG	t	2025-12-19 05:49:54.264496	2025-12-19 05:49:54.264496
138	152	Puduvai Bharathiar Grama Bank	IPBG	IPBG	f	2025-12-19 05:49:54.270307	2025-12-19 05:49:54.270307
139	153	J&K Grameen Bank	JAKG	JAKG	t	2025-12-19 05:49:54.275336	2025-12-19 05:49:54.275336
140	154	Maharashtra Gramin Bank	MAHG	MAHG	t	2025-12-19 05:49:54.280259	2025-12-19 05:49:54.280259
141	156	Rajasthan Gramin Bank	PRGB	PRGB	f	2025-12-19 05:49:54.286574	2025-12-19 05:49:54.286574
142	157	Sarva UP Gramin Bank	PSGB	PSGB	t	2025-12-19 05:49:54.291813	2025-12-19 05:49:54.291813
143	158	Sutlej Gramin Bank	PSIG	PSIG	t	2025-12-19 05:49:54.299072	2025-12-19 05:49:54.299072
144	159	Himachal Gramin Bank	PUHG	PUHG	t	2025-12-19 05:49:54.304305	2025-12-19 05:49:54.304305
145	160	Madhya Bihar Gramin Bank	PUNG	PUNG	t	2025-12-19 05:49:54.310516	2025-12-19 05:49:54.310516
146	161	Sarva Haryana Gramin Bank	PUNH	PUNH	t	2025-12-19 05:49:54.315776	2025-12-19 05:49:54.315776
147	162	Andhra Pradesh Grameena Vikas Bank	APGV	APGV	t	2025-12-19 05:49:54.321227	2025-12-19 05:49:54.321227
148	163	Arunachal Pradesh Rural Bank	SBAP	SBAP	t	2025-12-19 05:49:54.326491	2025-12-19 05:49:54.326491
149	164	MG Baroda Gramin Bank	SBBG	SBBG	f	2025-12-19 05:49:54.331692	2025-12-19 05:49:54.331692
150	165	Telangana Grameena Bank	SBHG	SBHG	t	2025-12-19 05:49:54.338418	2025-12-19 05:49:54.338418
151	166	Chhattisgarh Gramin Bank	SBIC	SBIC	t	2025-12-19 05:49:54.343933	2025-12-19 05:49:54.343933
152	167	Ellaqui Dehati Bank	SBIE	SBIE	t	2025-12-19 05:49:54.350767	2025-12-19 05:49:54.350767
153	168	Mizoram Rural Bank	SBIG	SBIG	t	2025-12-19 05:49:54.357089	2025-12-19 05:49:54.357089
154	169	Jharkhand Gramin Bank	SBIJ	SBIJ	f	2025-12-19 05:49:54.362741	2025-12-19 05:49:54.362741
155	170	Kaveri Grameena Bank	SBMG	SBMG	t	2025-12-19 05:49:54.36845	2025-12-19 05:49:54.36845
156	171	Vidisha Bhopal Kshetriya Gramin Bank	SBOG	SBOG	f	2025-12-19 05:49:54.374458	2025-12-19 05:49:54.374458
157	172	Krishna Gramin Bank	SKRG	SKRG	f	2025-12-19 05:49:54.379805	2025-12-19 05:49:54.379805
158	173	Langpi Dehangi Rural Bank	SLDR	SLDR	t	2025-12-19 05:49:54.385495	2025-12-19 05:49:54.385495
159	174	Meghalaya Rural Bank	SMEG	SMEG	t	2025-12-19 05:49:54.391502	2025-12-19 05:49:54.391502
160	176	Parvatiya Gramin Bank	SPGB	SPGB	f	2025-12-19 05:49:54.396888	2025-12-19 05:49:54.396888
161	177	Purvanchal Gramin Bank	SRGB	SRGB	t	2025-12-19 05:49:54.402002	2025-12-19 05:49:54.402002
162	179	Saurashtra Gramin Bank	SSGB	SSGB	t	2025-12-19 05:49:54.407365	2025-12-19 05:49:54.407365
163	180	Samastipur Kshetriya Gramin Bank	SSKG	SSKG	f	2025-12-19 05:49:54.413437	2025-12-19 05:49:54.413437
164	181	Uttarakhand Gramin Bank	SUTG	SUTG	t	2025-12-19 05:49:54.41854	2025-12-19 05:49:54.41854
165	182	Utkal Gramya Bank	SUUG	SUUG	t	2025-12-19 05:49:54.423798	2025-12-19 05:49:54.423798
166	184	Karnataka Vikas Grameena Bank	KVGB	KVGB	t	2025-12-19 05:49:54.42966	2025-12-19 05:49:54.42966
167	185	Andhra Pragathi Grameena Bank	APGB	APGB	t	2025-12-19 05:49:54.436342	2025-12-19 05:49:54.436342
168	186	North Malabar Gramin Bank	SYNM	SYNM	f	2025-12-19 05:49:54.442543	2025-12-19 05:49:54.442543
169	187	Assam Gramin Vikash Bank	UASG	UASG	t	2025-12-19 05:49:54.448156	2025-12-19 05:49:54.448156
170	188	Kashi Gomati Samyut Gramin Bank	UBKG	UBKG	t	2025-12-19 05:49:54.453626	2025-12-19 05:49:54.453626
171	189	Mahakaushal Kshetriya Gramin Bank	UCBG	UCBG	f	2025-12-19 05:49:54.459976	2025-12-19 05:49:54.459976
172	190	Bihar Kshetriya Gramin Bank	UCBK	UCBK	t	2025-12-19 05:49:54.465778	2025-12-19 05:49:54.465778
173	191	Kalinga Gramya Bank	UCKG	UCKG	f	2025-12-19 05:49:54.471562	2025-12-19 05:49:54.471562
174	192	Jaipur Thar Gramin Bank	UJTG	UJTG	f	2025-12-19 05:49:54.47742	2025-12-19 05:49:54.47742
175	193	Paschim Banga Gramin Bank	UPBG	UPBG	t	2025-12-19 05:49:54.48341	2025-12-19 05:49:54.48341
176	194	Rewa Sidhi Gramin Bank	URSG	URSG	f	2025-12-19 05:49:54.488664	2025-12-19 05:49:54.488664
177	195	Bangiya Gramin Bank	UTBB	UTBB	f	2025-12-19 05:49:54.494044	2025-12-19 05:49:54.494044
178	196	Manipur Rural Bank	UTBG	UTBG	t	2025-12-19 05:49:54.499983	2025-12-19 05:49:54.499983
179	197	Tripura Gramin Bank	UTGB	UTGB	t	2025-12-19 05:49:54.506166	2025-12-19 05:49:54.506166
180	198	Visveshwaraya Gramin Bank	VIJG	VIJG	f	2025-12-19 05:49:54.511261	2025-12-19 05:49:54.511261
181	199	Swarna Bharat Trust Cyber Grameen	SBCG	SBCG	f	2025-12-19 05:49:54.517483	2025-12-19 05:49:54.517483
182	200	Neft Malwa Gramin Bank	NMGB	NMGB	f	2025-12-19 05:49:54.522998	2025-12-19 05:49:54.522998
183	201	ABN Amro Bank Credit Card	ABCC	ABCC	f	2025-12-19 05:49:54.528155	2025-12-19 05:49:54.528155
184	202	Barclays Credit Card	BACC	BACC	f	2025-12-19 05:49:54.534202	2025-12-19 05:49:54.534202
185	203	Citibank Credit Card	CICC	CICC	f	2025-12-19 05:49:54.540602	2025-12-19 05:49:54.540602
186	204	HDFC Bank Credit Card	HDCC	HDCC	f	2025-12-19 05:49:54.545817	2025-12-19 05:49:54.545817
187	205	HSBC Credit Card	HSCC	HSCC	f	2025-12-19 05:49:54.551673	2025-12-19 05:49:54.551673
188	206	ICICI Bank Credit Card	ICCC	ICCC	f	2025-12-19 05:49:54.557277	2025-12-19 05:49:54.557277
189	207	Kotak Mahindra Credit Card	KKCC	KKCC	f	2025-12-19 05:49:54.562922	2025-12-19 05:49:54.562922
190	208	State Bank of India Credit Card	SBCC	SBCC	f	2025-12-19 05:49:54.568294	2025-12-19 05:49:54.568294
191	209	Standard Chartered Credit Card	SCCC	SCCC	f	2025-12-19 05:49:54.57362	2025-12-19 05:49:54.57362
192	210	UTI Axis Bank Credit Card	UTCC	UTCC	f	2025-12-19 05:49:54.579193	2025-12-19 05:49:54.579193
193	211	Vijaya Credit Card	VICC	VICC	f	2025-12-19 05:49:54.584799	2025-12-19 05:49:54.584799
194	212	American Express Credit Card	AMEX	AMEX	f	2025-12-19 05:49:54.589947	2025-12-19 05:49:54.589947
195	213	Janaseva Sahakari Bank	JANA	JANA	t	2025-12-19 05:49:54.595191	2025-12-19 05:49:54.595191
196	214	Kallappanna Awade Ichalkaranji Janata Sahkari Bank	KAIJ	KAIJ	t	2025-12-19 05:49:54.600618	2025-12-19 05:49:54.600618
197	215	Pandharpur Merchant Co-Op Bank	ICIP	ICIP	t	2025-12-19 05:49:54.606446	2025-12-19 05:49:54.606446
198	216	The Gayatri Co Operative Urban Bank Ltd	HDGB	HDGB	t	2025-12-19 05:49:54.612161	2025-12-19 05:49:54.612161
199	217	Pochampally Co-Op Urban Bank	HDFP	HDFP	t	2025-12-19 05:49:54.617786	2025-12-19 05:49:54.617786
200	218	Dr Annasaheb Chougule Urban Co-Op Bank	HDFA	HDFA	t	2025-12-19 05:49:54.623427	2025-12-19 05:49:54.623427
201	219	Surat District Co-Op Bank	SDCB	SDCB	t	2025-12-19 05:49:54.628767	2025-12-19 05:49:54.628767
202	220	Suco Souharda Sahakari Bank	HDFS	HDFS	t	2025-12-19 05:49:54.634675	2025-12-19 05:49:54.634675
203	221	Pune Peoples Co-Op Bank	IBKP	IBKP	t	2025-12-19 05:49:54.640581	2025-12-19 05:49:54.640581
204	222	Shri Arihant Co-Op Bank	ICSA	ICSA	t	2025-12-19 05:49:54.646478	2025-12-19 05:49:54.646478
205	223	The National Co-Op Bank Ltd	KKBN	KKBN	t	2025-12-19 05:49:54.651837	2025-12-19 05:49:54.651837
206	224	Parshwanath Co-Op Bank	HDPA	HDPA	t	2025-12-19 05:49:54.657022	2025-12-19 05:49:54.657022
207	225	Apna Sahakari Bank	ASBL	ASBL	t	2025-12-19 05:49:54.662152	2025-12-19 05:49:54.662152
208	226	Jalore Nagrik Sahakari Bank	HDJC	HDJC	t	2025-12-19 05:49:54.667957	2025-12-19 05:49:54.667957
209	227	Varachha Co-Op Bank	VARA	VARA	t	2025-12-19 05:49:54.673392	2025-12-19 05:49:54.673392
210	228	Janata Co-Op Bank Malegaon	HDFJ	HDFJ	t	2025-12-19 05:49:54.680297	2025-12-19 05:49:54.680297
211	229	Shri Basaveshwar Sahakari Bank Niyamit Bagalkot	ICIS	ICIS	t	2025-12-19 05:49:54.685615	2025-12-19 05:49:54.685615
212	230	Shirpur Peoples Co-Op Bank	KKBS	KKBS	t	2025-12-19 05:49:54.691568	2025-12-19 05:49:54.691568
213	232	Kerala Gramin Bank	KLGB	KLGB	t	2025-12-19 05:49:54.699251	2025-12-19 05:49:54.699251
214	233	Pragathi Krishna Gramin Bank	PKGB	PKGB	t	2025-12-19 05:49:54.705546	2025-12-19 05:49:54.705546
215	234	Yadagiri Lakshmi Narasimha Swamy Co-Op Urban Bank	YESP	YESP	t	2025-12-19 05:49:54.711033	2025-12-19 05:49:54.711033
216	235	Hutatma Sahakari Bank	ICIH	ICIH	t	2025-12-19 05:49:54.716281	2025-12-19 05:49:54.716281
217	236	Himachal Pradesh State Co-Op Bank	HPSC	HPSC	t	2025-12-19 05:49:54.722513	2025-12-19 05:49:54.722513
218	237	Adarsh Urban Co-Op Bank Hyderabad	ICIA	ICIA	t	2025-12-19 05:49:54.728421	2025-12-19 05:49:54.728421
219	238	Mayani Urban Co-Op Bank	ICIM	ICIM	t	2025-12-19 05:49:54.734449	2025-12-19 05:49:54.734449
220	239	Pandharpur Urban Co-Op Bank	ICPU	ICPU	t	2025-12-19 05:49:54.740155	2025-12-19 05:49:54.740155
221	240	Vananchal Gramin Bank	SVAG	SVAG	t	2025-12-19 05:49:54.746496	2025-12-19 05:49:54.746496
222	241	Punjab Gramin Bank	PPGB	PPGB	t	2025-12-19 05:49:54.753122	2025-12-19 05:49:54.753122
223	242	Shri Veershaiv Co-Op Bank Ltd	SVSH	SVSH	t	2025-12-19 05:49:54.759406	2025-12-19 05:49:54.759406
224	243	Thrissur District Central Co-Op Bank	TDCB	TDCB	t	2025-12-19 05:49:54.764708	2025-12-19 05:49:54.764708
225	244	Vishweshwar Sahakari Bank Ltd	VSBL	VSBL	t	2025-12-19 05:49:54.770695	2025-12-19 05:49:54.770695
226	245	Raipur Urban Mercantile Co-Op Bank	HDRU	HDRU	t	2025-12-19 05:49:54.776135	2025-12-19 05:49:54.776135
227	246	Zila Sahkari Bank	ICZS	ICZS	f	2025-12-19 05:49:54.78179	2025-12-19 05:49:54.78179
228	247	Titwala	SBIT	SBIT	f	2025-12-19 05:49:54.787577	2025-12-19 05:49:54.787577
229	248	Dombivli East	SBDO	SBDO	f	2025-12-19 05:49:54.792918	2025-12-19 05:49:54.792918
230	250	MGCB Main	WBMG	WBMG	f	2025-12-19 05:49:54.798351	2025-12-19 05:49:54.798351
231	251	Sindhudurg District Central Co-Op Bank	HDSI	HDSI	t	2025-12-19 05:49:54.803377	2025-12-19 05:49:54.803377
232	252	Hamirpur District Co-Op Bank Mahoba	ICMA	ICMA	f	2025-12-19 05:49:54.809067	2025-12-19 05:49:54.809067
233	253	Shivalik Mercantile Co-Op Bank	SMCB	SMCB	t	2025-12-19 05:49:54.814262	2025-12-19 05:49:54.814262
234	254	Hasti Co-Op Bank	HCBL	HCBL	t	2025-12-19 05:49:54.819606	2025-12-19 05:49:54.819606
235	255	Rajgurunagar Sahakari Bank	RSBL	RSBL	t	2025-12-19 05:49:54.826138	2025-12-19 05:49:54.826138
236	256	Bandhan Bank	BDBL	BDBL	t	2025-12-19 05:49:54.831655	2025-12-19 05:49:54.831655
237	257	Dapoli Urban Co-Op Bank	IBDU	IBDU	f	2025-12-19 05:49:54.836594	2025-12-19 05:49:54.836594
238	258	Gujarat State Co-Op Bank	GSCB	GSCB	t	2025-12-19 05:49:54.841778	2025-12-19 05:49:54.841778
239	259	Municipal Co-Op Bank	MUBL	MUBL	t	2025-12-19 05:49:54.847837	2025-12-19 05:49:54.847837
240	260	Rajapur Urban Co-Op Bank	ICRU	ICRU	t	2025-12-19 05:49:54.855159	2025-12-19 05:49:54.855159
241	261	Ahmedabad District Central Co-Op Bank	GSAD	GSAD	t	2025-12-19 05:49:54.860379	2025-12-19 05:49:54.860379
242	262	IDFC Bank	IDFB	IDFB	t	2025-12-19 05:49:54.865936	2025-12-19 05:49:54.865936
243	263	Rajasthan Marudhara Gramin Bank	SBRM	SBRM	t	2025-12-19 05:49:54.871646	2025-12-19 05:49:54.871646
244	264	Suvarnayug Sahakari Bank	SUSB	SUSB	t	2025-12-19 05:49:54.877068	2025-12-19 05:49:54.877068
245	265	Sutex Co-Op Bank	SUTB	SUTB	t	2025-12-19 05:49:54.88281	2025-12-19 05:49:54.88281
246	266	Nagar Sahkari Bank	NASB	NASB	f	2025-12-19 05:49:54.888521	2025-12-19 05:49:54.888521
247	267	Irinjalakuda Town Co-Op Bank	IRTO	IRTO	t	2025-12-19 05:49:54.894518	2025-12-19 05:49:54.894518
248	268	Shivajirao Bhosale Sahakari Bank	SHBH	SHBH	t	2025-12-19 05:49:54.900144	2025-12-19 05:49:54.900144
249	269	Thane Bharat Sahakari Bank	TBSB	TBSB	t	2025-12-19 05:49:54.905795	2025-12-19 05:49:54.905795
250	270	Maratha Co-Op Bank	MCOB	MCOB	t	2025-12-19 05:49:54.911879	2025-12-19 05:49:54.911879
251	271	Pithoragarh Jila Sahkari Bank	IBJS	IBJS	t	2025-12-19 05:49:54.91763	2025-12-19 05:49:54.91763
252	272	Pune Cantonment Sahakari Bank	PCSB	PCSB	t	2025-12-19 05:49:54.923382	2025-12-19 05:49:54.923382
253	273	Uttarakhand Gramin Bank	UTTB	UTTB	t	2025-12-19 05:49:54.929122	2025-12-19 05:49:54.929122
254	274	The Malad Sahakari Bank Ltd	MASB	MASB	t	2025-12-19 05:49:54.934684	2025-12-19 05:49:54.934684
255	275	Shree Mahalaxmi Co-Op Bank	SML	SML	t	2025-12-19 05:49:54.940572	2025-12-19 05:49:54.940572
256	276	Moradabad Zila Sahkari Bank	MZSB	MZSB	f	2025-12-19 05:49:54.946339	2025-12-19 05:49:54.946339
257	277	Siwan Central Co-Op Bank	SCCB	SCCB	t	2025-12-19 05:49:54.951816	2025-12-19 05:49:54.951816
258	278	Madhyanchal Gramin Bank	MGBS	MGBS	t	2025-12-19 05:49:54.957095	2025-12-19 05:49:54.957095
259	279	Triveni Kshetriya Gramin Bank	TKGB	TKGB	f	2025-12-19 05:49:54.962177	2025-12-19 05:49:54.962177
260	280	The Ratnakar Bank Credit Card	RBCC	RBCC	f	2025-12-19 05:49:54.967345	2025-12-19 05:49:54.967345
261	281	Punjab National Bank Credit Card	PBCC	PBCC	f	2025-12-19 05:49:54.972473	2025-12-19 05:49:54.972473
262	283	IndusInd Bank Credit Card	IBCC	IBCC	f	2025-12-19 05:49:54.977389	2025-12-19 05:49:54.977389
263	284	Canara Bank Credit Card	CBCC	CBCC	f	2025-12-19 05:49:54.982331	2025-12-19 05:49:54.982331
264	285	IDBI Bank Credit Card	IDCC	IDCC	f	2025-12-19 05:49:54.987519	2025-12-19 05:49:54.987519
265	286	Andhra Bank Credit Card	ANCC	ANCC	f	2025-12-19 05:49:54.992711	2025-12-19 05:49:54.992711
266	287	Bank Of India Credit Card	BKCC	BKCC	f	2025-12-19 05:49:54.997783	2025-12-19 05:49:54.997783
267	288	Bank Of Baroda Credit Card	BABC	BABC	f	2025-12-19 05:49:55.002735	2025-12-19 05:49:55.002735
268	289	Odisha Gramya Bank	IOGB	IOGB	t	2025-12-19 05:49:55.007702	2025-12-19 05:49:55.007702
269	290	The Udaipur Mahila Samridhi Urban Co-Op Bank Ltd	UMSC	UMSC	t	2025-12-19 05:49:55.012702	2025-12-19 05:49:55.012702
270	291	Delhi State Co-Op Bank	DSCB	DSCB	f	2025-12-19 05:49:55.017942	2025-12-19 05:49:55.017942
271	292	Citizen Co-Op Bank Noida	COBL	COBL	t	2025-12-19 05:49:55.022982	2025-12-19 05:49:55.022982
272	293	Chikhli Urban Co-Op Bank	CUCB	CUCB	t	2025-12-19 05:49:55.027855	2025-12-19 05:49:55.027855
273	294	Poornawadi Nagrik Sahakari Bank	PNSB	PNSB	t	2025-12-19 05:49:55.032795	2025-12-19 05:49:55.032795
274	295	Ahmednagar Mer Co-Op Bank	AGBL	AGBL	t	2025-12-19 05:49:55.037833	2025-12-19 05:49:55.037833
275	296	Pavana Sahakari Bank	PSBL	PSBL	t	2025-12-19 05:49:55.043867	2025-12-19 05:49:55.043867
276	297	Fingrowth Co-Op Bank Ltd	UCBL	UCBL	t	2025-12-19 05:49:55.049471	2025-12-19 05:49:55.049471
277	298	Airtel Payments Bank	AIRP	AIRP	t	2025-12-19 05:49:55.054991	2025-12-19 05:49:55.054991
278	299	Jalgaon Peoples Co-Op Bank	JPCB	JPCB	t	2025-12-19 05:49:55.059955	2025-12-19 05:49:55.059955
279	300	Vasai Vikas Co-Op Bank	VVSB	VVSB	t	2025-12-19 05:49:55.06547	2025-12-19 05:49:55.06547
280	301	Equitas Small Finance Bank	ESFB	ESFB	t	2025-12-19 05:49:55.072005	2025-12-19 05:49:55.072005
281	302	Noble Co-Op Bank	NCBL	NCBL	t	2025-12-19 05:49:55.07777	2025-12-19 05:49:55.07777
282	303	Jalaun District Co-Op Bank	JDCB	JDCB	f	2025-12-19 05:49:55.083172	2025-12-19 05:49:55.083172
283	304	Vaidyanath Urban Co-Op Bank	VUCB	VUCB	f	2025-12-19 05:49:55.088951	2025-12-19 05:49:55.088951
284	305	Sapthagiri Grameena Bank	SGCB	SGCB	f	2025-12-19 05:49:55.094853	2025-12-19 05:49:55.094853
285	306	Ambarnath Jai Hind Co-Op Bank	AJHB	AJHB	t	2025-12-19 05:49:55.100797	2025-12-19 05:49:55.100797
286	307	Seva Vikas Co-Op Bank	SVBL	SVBL	f	2025-12-19 05:49:55.107011	2025-12-19 05:49:55.107011
287	308	Pachora Peoples Co-Op Bank	PPCB	PPCB	f	2025-12-19 05:49:55.113286	2025-12-19 05:49:55.113286
288	309	India Post Payments Bank	IPOS	IPOS	t	2025-12-19 05:49:55.119583	2025-12-19 05:49:55.119583
289	310	Bombay Mercantile Co-Op Bank	BMCL	BMCL	f	2025-12-19 05:49:55.125134	2025-12-19 05:49:55.125134
290	311	Malda District Central Co-Op Bank	MDCB	MDCB	f	2025-12-19 05:49:55.130762	2025-12-19 05:49:55.130762
291	312	Ujjivan Small Finance Bank	UJVN	UJVN	t	2025-12-19 05:49:55.137064	2025-12-19 05:49:55.137064
292	313	Jamia Co-Op Bank	JCBL	JCBL	f	2025-12-19 05:49:55.142463	2025-12-19 05:49:55.142463
293	314	Integral Urban Co-Op Bank	IUCB	IUCB	t	2025-12-19 05:49:55.148008	2025-12-19 05:49:55.148008
294	315	ESAF Small Finance Bank	ESMF	ESMF	t	2025-12-19 05:49:55.154685	2025-12-19 05:49:55.154685
295	316	Mogaveera Co-Op Bank	MGCB	MGCB	f	2025-12-19 05:49:55.160503	2025-12-19 05:49:55.160503
296	317	Akhand Anand Co-Op Bank	AACB	AACB	t	2025-12-19 05:49:55.166612	2025-12-19 05:49:55.166612
297	318	Sardar Bhiladwala Pardi Peoples Co-Op Bank	SBPP	SBPP	t	2025-12-19 05:49:55.172678	2025-12-19 05:49:55.172678
298	319	Manvi Pattana Souharda Sahakari Bank	MPSS	MPSS	t	2025-12-19 05:49:55.178462	2025-12-19 05:49:55.178462
299	320	Shree Sharada Sahakari Bank	SSSB	SSSB	t	2025-12-19 05:49:55.184156	2025-12-19 05:49:55.184156
300	321	Aircel Smart Money	ASML	ASML	t	2025-12-19 05:49:55.190118	2025-12-19 05:49:55.190118
301	322	Mumbai District Central Co-Op Bank	DCCL	DCCL	t	2025-12-19 05:49:55.195967	2025-12-19 05:49:55.195967
302	323	The Thane District Central Co-Op Bank	TCCB	TCCB	f	2025-12-19 05:49:55.201539	2025-12-19 05:49:55.201539
303	324	Zoroastrian Co-Op Bank	ZCBL	ZCBL	f	2025-12-19 05:49:55.207233	2025-12-19 05:49:55.207233
304	325	Saurashtra Co-Op Bank	SSCB	SSCB	t	2025-12-19 05:49:55.212528	2025-12-19 05:49:55.212528
305	326	Kurmanchal Nagar Sahkari Bank	KNSB	KNSB	f	2025-12-19 05:49:55.217709	2025-12-19 05:49:55.217709
306	327	Suryoday Small Finance Bank	SURY	SURY	t	2025-12-19 05:49:55.222863	2025-12-19 05:49:55.222863
307	328	Akola Janata Commercial Co-Op Bank	AKJB	AKJB	t	2025-12-19 05:49:55.228636	2025-12-19 05:49:55.228636
308	329	Sahebrao Deshmukh Co-Op Bank	SAHE	SAHE	f	2025-12-19 05:49:55.23514	2025-12-19 05:49:55.23514
309	330	Shri Chhatrapati Rajarshi Shahu Urban Co-Op Bank	CRUB	CRUB	f	2025-12-19 05:49:55.240848	2025-12-19 05:49:55.240848
310	331	Akola District Central Co-Op Bank	ADCC	ADCC	t	2025-12-19 05:49:55.246632	2025-12-19 05:49:55.246632
311	332	Hindusthan Co-Op Bank	THCB	THCB	t	2025-12-19 05:49:55.252136	2025-12-19 05:49:55.252136
312	333	Sadhana Sahakari Bank	SSBL	SSBL	t	2025-12-19 05:49:55.258666	2025-12-19 05:49:55.258666
313	334	Sabarkantha District Central Co-Op Bank	SDCC	SDCC	t	2025-12-19 05:49:55.264459	2025-12-19 05:49:55.264459
314	335	Sharad Sahakari Bank Manchar	SSBM	SSBM	f	2025-12-19 05:49:55.270422	2025-12-19 05:49:55.270422
315	336	Udaipur Urban Co-Op Bank	UUCB	UUCB	t	2025-12-19 05:49:55.276106	2025-12-19 05:49:55.276106
316	337	Vikas Souharda Co-Op Bank	VSCB	VSCB	t	2025-12-19 05:49:55.281332	2025-12-19 05:49:55.281332
317	338	Priyadarshani Nagari Sahakari Bank	PNSL	PNSL	t	2025-12-19 05:49:55.286911	2025-12-19 05:49:55.286911
318	339	Kaira District Central Co-Op Bank	KAIB	KAIB	f	2025-12-19 05:49:55.292517	2025-12-19 05:49:55.292517
319	340	Murshidabad District Central Co-Op Bank	MCCB	MCCB	f	2025-12-19 05:49:55.298332	2025-12-19 05:49:55.298332
320	341	Kottayam Co-Op Urban Bank	KCUB	KCUB	t	2025-12-19 05:49:55.304	2025-12-19 05:49:55.304
321	342	Panipat Urban Co-Op Bank	PUCB	PUCB	f	2025-12-19 05:49:55.309535	2025-12-19 05:49:55.309535
322	343	Telangana State Co-Op Apex Bank	TSAB	TSAB	t	2025-12-19 05:49:55.315108	2025-12-19 05:49:55.315108
323	344	Assam Co-Op Apex Bank	ACAB	ACAB	f	2025-12-19 05:49:55.320707	2025-12-19 05:49:55.320707
324	345	Paytm Payments Bank	PYTM	PYTM	t	2025-12-19 05:49:55.326363	2025-12-19 05:49:55.326363
325	346	Surat National Co-Op Bank	SUNB	SUNB	t	2025-12-19 05:49:55.331973	2025-12-19 05:49:55.331973
326	347	FINO Payments Bank	FINO	FINO	t	2025-12-19 05:49:55.337454	2025-12-19 05:49:55.337454
327	348	Narmada Malwa Gramin Bank	MRGB	MRGB	f	2025-12-19 05:49:55.342932	2025-12-19 05:49:55.342932
328	349	Markandey Nagari Sahakari Bank	MSBL	MSBL	f	2025-12-19 05:49:55.351217	2025-12-19 05:49:55.351217
329	350	Bijnor Urban Co-Op Bank	BCBL	BCBL	f	2025-12-19 05:49:55.356751	2025-12-19 05:49:55.356751
330	351	Adarsh Mahila Mercantile Co-Op Bank	AMMC	AMMC	f	2025-12-19 05:49:55.362729	2025-12-19 05:49:55.362729
331	352	Adarsh Co-Op Bank Rajasthan	ACBR	ACBR	t	2025-12-19 05:49:55.368255	2025-12-19 05:49:55.368255
332	353	The Baramati Sahakari Bank Ltd	BARA	BARA	t	2025-12-19 05:49:55.374041	2025-12-19 05:49:55.374041
333	354	Jalna Merchant Co-Op Bank	JMBL	JMBL	t	2025-12-19 05:49:55.379705	2025-12-19 05:49:55.379705
334	355	Kanaka Mahalakshmi Co-Op Bank	KMCB	KMCB	t	2025-12-19 05:49:55.384848	2025-12-19 05:49:55.384848
335	356	Lokmangal Co-Op Bank	LCBL	LCBL	t	2025-12-19 05:49:55.389945	2025-12-19 05:49:55.389945
336	357	Odisha State Co-Op Bank	ORCB	ORCB	t	2025-12-19 05:49:55.394941	2025-12-19 05:49:55.394941
337	358	Prime Co-Op Bank Ltd	PMEC	PMEC	t	2025-12-19 05:49:55.399915	2025-12-19 05:49:55.399915
338	359	Solapur Janata Sahakari Bank	SJSB	SJSB	f	2025-12-19 05:49:55.404825	2025-12-19 05:49:55.404825
339	360	Raigad District Central Co-Op Bank	TRDC	TRDC	t	2025-12-19 05:49:55.409757	2025-12-19 05:49:55.409757
340	361	Sangli District Central Co-Op Bank	ISDC	ISDC	f	2025-12-19 05:49:55.415091	2025-12-19 05:49:55.415091
341	362	Urban Co-Op Bank Siddharthanagar	UCBS	UCBS	t	2025-12-19 05:49:55.420787	2025-12-19 05:49:55.420787
342	363	Zila Sahakari Bank Lucknow	ZSBL	ZSBL	t	2025-12-19 05:49:55.4264	2025-12-19 05:49:55.4264
343	364	AU Small Finance Bank	AUBL	AUBL	t	2025-12-19 05:49:55.431629	2025-12-19 05:49:55.431629
344	365	District Co-Op Bank Agra	AGCB	AGCB	f	2025-12-19 05:49:55.436512	2025-12-19 05:49:55.436512
345	366	Janata Sahakari Bank Osmanabad	OJSB	OJSB	f	2025-12-19 05:49:55.441638	2025-12-19 05:49:55.441638
346	367	Rajarshi Shahu Sah Bank Pune	CRBL	CRBL	t	2025-12-19 05:49:55.446772	2025-12-19 05:49:55.446772
347	368	Sant Sopankaka Sahakari Bank Saswad	SSSD	SSSD	f	2025-12-19 05:49:55.453379	2025-12-19 05:49:55.453379
348	369	Deccan Merchants Co-Op Bank	DMCB	DMCB	f	2025-12-19 05:49:55.462144	2025-12-19 05:49:55.462144
349	370	Nanded Disctrict Central Co-Op Bank	NDCB	NDCB	f	2025-12-19 05:49:55.467713	2025-12-19 05:49:55.467713
350	371	Bhagalpur Central Co-Op Bank	BCCB	BCCB	f	2025-12-19 05:49:55.474457	2025-12-19 05:49:55.474457
351	372	Almora Urban Co-Op Bank	AUCB	AUCB	f	2025-12-19 05:49:55.480851	2025-12-19 05:49:55.480851
352	373	Zila Sahakari Bank Haridwar	ZSBH	ZSBH	t	2025-12-19 05:49:55.48714	2025-12-19 05:49:55.48714
353	374	Etah District Co-Op bank	EDCB	EDCB	f	2025-12-19 05:49:55.493176	2025-12-19 05:49:55.493176
354	375	Andhra Pradesh State Co-Op Bank	APBL	APBL	t	2025-12-19 05:49:55.499385	2025-12-19 05:49:55.499385
355	376	Jharkhand State Co-Op Bank	JSCB	JSCB	f	2025-12-19 05:49:55.504695	2025-12-19 05:49:55.504695
356	377	Sangamner Merchant Co-Op Bank	TSMC	TSMC	t	2025-12-19 05:49:55.510162	2025-12-19 05:49:55.510162
357	378	The Satara District Central Co-Op Bank Ltd	SDCE	SDCE	f	2025-12-19 05:49:55.515815	2025-12-19 05:49:55.515815
358	379	Pune District Central Co-Op Bank	PDCC	PDCC	t	2025-12-19 05:49:55.521243	2025-12-19 05:49:55.521243
359	380	The Khamgaon Urban Co-Op Bank Ltd	KUCC	KUCC	t	2025-12-19 05:49:55.526866	2025-12-19 05:49:55.526866
360	381	Chartered Sahakari Bank Niyamitha	CSBN	CSBN	t	2025-12-19 05:49:55.532246	2025-12-19 05:49:55.532246
361	382	The Gandhinagar Urban Co-Op Bank Ltd	TGUC	TGUC	f	2025-12-19 05:49:55.537397	2025-12-19 05:49:55.537397
362	383	Valsad District Central Co-Op Bank Ltd	VDCC	VDCC	t	2025-12-19 05:49:55.542414	2025-12-19 05:49:55.542414
363	384	Jijamata Mahila Sah Bank Ltd Pune	CJMS	CJMS	t	2025-12-19 05:49:55.547683	2025-12-19 05:49:55.547683
364	385	Capital Small Finance Bank	CLBL	CLBL	t	2025-12-19 05:49:55.554288	2025-12-19 05:49:55.554288
365	386	The Muslim Co-Op Bank Ltd	TMCO	TMCO	t	2025-12-19 05:49:55.55941	2025-12-19 05:49:55.55941
366	387	The Gandhinagar Nagrik Co-Op Bank Ltd	TGNC	TGNC	t	2025-12-19 05:49:55.564717	2025-12-19 05:49:55.564717
367	388	The Rajasthan State Co-Op Bank Ltd	RSCB	RSCB	f	2025-12-19 05:49:55.569706	2025-12-19 05:49:55.569706
368	389	Ratnagiri District Central Co-Op Bank Ltd	RDCC	RDCC	f	2025-12-19 05:49:55.575286	2025-12-19 05:49:55.575286
369	390	Jila Sahakari Kendriya Bank Khandwa	MPDC	MPDC	t	2025-12-19 05:49:55.580738	2025-12-19 05:49:55.580738
370	391	Jila Sahakari Kendriya Bank Maryadit Rajnandgaon	SJSD	SJSD	f	2025-12-19 05:49:55.586274	2025-12-19 05:49:55.586274
371	392	Kokan Mercantile Co-Op Bank Ltd	KKCB	KKCB	f	2025-12-19 05:49:55.591518	2025-12-19 05:49:55.591518
372	393	Annasaheb Savant Co-Op Urban Bank	AHAD	AHAD	f	2025-12-19 05:49:55.596931	2025-12-19 05:49:55.596931
373	394	Prerana Co-Op Bank Ltd	PCBL	PCBL	t	2025-12-19 05:49:55.602469	2025-12-19 05:49:55.602469
374	395	The Chembur Nagarik Sahakari Bank Ltd	CNSB	CNSB	t	2025-12-19 05:49:55.607902	2025-12-19 05:49:55.607902
375	396	The Bhagyodaya Co-Op Bank Ltd	TBCB	TBCB	t	2025-12-19 05:49:55.613332	2025-12-19 05:49:55.613332
376	397	Saibaba Nagari Sahakari Bank Ltd	SSNS	SSNS	t	2025-12-19 05:49:55.61884	2025-12-19 05:49:55.61884
377	398	Central Madhya Pradesh Gramin Bank	CMPG	CMPG	f	2025-12-19 05:49:55.624201	2025-12-19 05:49:55.624201
378	399	Jio Payments Bank Ltd	JIOP	JIOP	t	2025-12-19 05:49:55.629919	2025-12-19 05:49:55.629919
379	400	The Co-Op Bank Of Rajkot Gandhigram	CBOR	CBOR	f	2025-12-19 05:49:55.635514	2025-12-19 05:49:55.635514
380	401	Vijay Commercial Co-Op Bank	VCCB	VCCB	t	2025-12-19 05:49:55.641056	2025-12-19 05:49:55.641056
381	402	Samarth Sahakari Bank Ltd	SMRT	SMRT	t	2025-12-19 05:49:55.646816	2025-12-19 05:49:55.646816
382	403	Khalilabad Nagar Sah Bank Semariawa	KHBK	KHBK	f	2025-12-19 05:49:55.653029	2025-12-19 05:49:55.653029
383	404	Zila Sahakari Bank Ltd Rampur	RAMP	RAMP	f	2025-12-19 05:49:55.658768	2025-12-19 05:49:55.658768
384	405	Zila Sahakari Bank Ltd Moradabad	MORD	MORD	f	2025-12-19 05:49:55.664517	2025-12-19 05:49:55.664517
385	406	Narmada Jhabua Gramin Bank	NJGB	NJGB	f	2025-12-19 05:49:55.669645	2025-12-19 05:49:55.669645
386	407	Home Credit Finance Bank	HCFB	HCFB	t	2025-12-19 05:49:55.674955	2025-12-19 05:49:55.674955
387	408	DCB Bank	DCBB	DCBB	t	2025-12-19 05:49:55.680229	2025-12-19 05:49:55.680229
388	409	Bajaj Finance Bank	BFBB	BFBB	t	2025-12-19 05:49:55.6855	2025-12-19 05:49:55.6855
389	410	Rae Bareli District Co-Op Bank Ltd	RBDC	RBDC	t	2025-12-19 05:49:55.690715	2025-12-19 05:49:55.690715
390	411	Karnala Nagari Sahakari Bank	KNBB	KNBB	t	2025-12-19 05:49:55.695841	2025-12-19 05:49:55.695841
391	412	Meghalaya Co-Op Apex Bank	MCAB	MCAB	t	2025-12-19 05:49:55.701001	2025-12-19 05:49:55.701001
392	413	Bharuch District Central Co-Op Bank Ltd	BDCC	BDCC	t	2025-12-19 05:49:55.706055	2025-12-19 05:49:55.706055
393	414	Gopinath Patil Parsik Janata Sahakari Bank Ltd	GPPJ	GPPJ	t	2025-12-19 05:49:55.711197	2025-12-19 05:49:55.711197
394	415	Rbl Bank Limited	RBLL	RBLL	f	2025-12-19 05:49:55.716496	2025-12-19 05:49:55.716496
395	416	Aditya Birla Idea Payments Bank	ABPB	ABPB	t	2025-12-19 05:49:55.721478	2025-12-19 05:49:55.721478
396	417	Indrayani Co-Op Bank Ltd	ICBL	ICBL	f	2025-12-19 05:49:55.726556	2025-12-19 05:49:55.726556
397	418	Contai Co-Op Bank Ltd	CBLT	CBLT	f	2025-12-19 05:49:55.73153	2025-12-19 05:49:55.73153
398	419	The Punjab State Co-Op Bank	PSCB	PSCB	f	2025-12-19 05:49:55.736762	2025-12-19 05:49:55.736762
399	420	Kolhapur Mahila Sahakari Bank Ltd	CKMB	CKMB	t	2025-12-19 05:49:55.741798	2025-12-19 05:49:55.741798
400	421	The Chandigarh State Co-Op Bank Ltd	CSCB	CSCB	t	2025-12-19 05:49:55.746784	2025-12-19 05:49:55.746784
401	422	The Villupuram District Central Co-Op Bank Ltd	VDCB	VDCB	f	2025-12-19 05:49:55.751953	2025-12-19 05:49:55.751953
402	423	Uttar Pradesh State Co-Op Bank Ltd	UPSC	UPSC	f	2025-12-19 05:49:55.757096	2025-12-19 05:49:55.757096
403	424	The Ajara Urban Co-Op Bank Ltd	AUBB	AUBB	t	2025-12-19 05:49:55.762449	2025-12-19 05:49:55.762449
404	426	Samata Co-Op Development Bank	SAMA	SAMA	f	2025-12-19 05:49:55.767559	2025-12-19 05:49:55.767559
405	427	Bhagini Nivedita Sahakari Bank Ltd	NBNK	NBNK	t	2025-12-19 05:49:55.77253	2025-12-19 05:49:55.77253
406	428	Model Co-Op Bank Ltd	MODE	MODE	f	2025-12-19 05:49:55.777516	2025-12-19 05:49:55.777516
407	429	The Satara Sahakari Bank Ltd	TSSB	TSSB	t	2025-12-19 05:49:55.782616	2025-12-19 05:49:55.782616
408	430	The Mehsana Nagrik Sahakari Bank Ltd	MNSB	MNSB	f	2025-12-19 05:49:55.787929	2025-12-19 05:49:55.787929
409	431	Tehri Garhwal Zila Sahakari Bank Ltd	TGZS	TGZS	t	2025-12-19 05:49:55.793243	2025-12-19 05:49:55.793243
410	432	Utkarsh Small Finance Bank	UTKS	UTKS	t	2025-12-19 05:49:55.798498	2025-12-19 05:49:55.798498
411	435	Shahjahanpur District Central Co-Op Bank Ltd	SDDB	SDDB	f	2025-12-19 05:49:55.804937	2025-12-19 05:49:55.804937
412	436	The Kolhapur Urban Co-Op Bank Ltd Kolhapur	KUBL	KUBL	t	2025-12-19 05:49:55.810102	2025-12-19 05:49:55.810102
413	437	Uttar Daudpur Samabay Krishi Unnayan Samity Ltd	UDSK	UDSK	f	2025-12-19 05:49:55.815537	2025-12-19 05:49:55.815537
414	438	Durgapur Steel Peoples Co-Op Bank Ltd	DURG	DURG	f	2025-12-19 05:49:55.821807	2025-12-19 05:49:55.821807
415	439	The Sitamarhi Central Co-Op Bank	ISCB	ISCB	f	2025-12-19 05:49:55.827388	2025-12-19 05:49:55.827388
416	440	Shree Kadi Nagarik Sahakari Bank Ltd	KNBL	KNBL	t	2025-12-19 05:49:55.832743	2025-12-19 05:49:55.832743
417	441	The Ahmednagar District Central Co-Op Bank Ltd	ACCB	ACCB	t	2025-12-19 05:49:55.838229	2025-12-19 05:49:55.838229
418	442	Sardargunj Mercantile Co-Op Bank Ltd	SSMC	SSMC	t	2025-12-19 05:49:55.843556	2025-12-19 05:49:55.843556
419	443	Himatnagar Nagrik Sahakari Bank Ltd	HNSB	HNSB	t	2025-12-19 05:49:55.849135	2025-12-19 05:49:55.849135
420	444	Pali Urban Co-Op Bank Ltd	CPUB	CPUB	t	2025-12-19 05:49:55.855244	2025-12-19 05:49:55.855244
421	445	Janata Sahakari Bank Ltd Ajara	LJSB	LJSB	t	2025-12-19 05:49:55.864286	2025-12-19 05:49:55.864286
422	446	Dr.Appashab urf Sa.Re.Patil Jasingpur Udgaon Sahakari Bank Ltd,Jaysingpur	JUSB	JUSB	t	2025-12-19 05:49:55.870581	2025-12-19 05:49:55.870581
423	447	The Ranuj Nagrik Sahakari Bank Ltd	RANU	RANU	t	2025-12-19 05:49:55.876671	2025-12-19 05:49:55.876671
424	448	Sandur Pattana Souharda Sahakari Bank Ltd	SPSB	SPSB	t	2025-12-19 05:49:55.882536	2025-12-19 05:49:55.882536
425	449	Nirmal Urban Co-Op Bank Nagpur	CNBL	CNBL	t	2025-12-19 05:49:55.888397	2025-12-19 05:49:55.888397
426	450	The Mangalore Catholic Co-Op Bank Ltd	TMCC	TMCC	t	2025-12-19 05:49:55.894345	2025-12-19 05:49:55.894345
427	451	Peoples Urban Co-Op Bank Ltd	TPCB	TPCB	t	2025-12-19 05:49:55.9017	2025-12-19 05:49:55.9017
428	453	Bhadradri Co-Op Urban Bank Ltd	BCUB	BCUB	t	2025-12-19 05:49:55.909124	2025-12-19 05:49:55.909124
429	454	The Manipur State Co-Op Bank	MSCB	MSCB	t	2025-12-19 05:49:55.914582	2025-12-19 05:49:55.914582
430	455	The Financial Co-Op Bank Ltd	FSCB	FSCB	t	2025-12-19 05:49:55.919904	2025-12-19 05:49:55.919904
431	456	The Kodungallur Town Co-Op Bank Ltd	KTCB	KTCB	t	2025-12-19 05:49:55.926427	2025-12-19 05:49:55.926427
432	457	Shree Panchganga Nagari Sahakari Bank	SPNB	SPNB	t	2025-12-19 05:49:55.932774	2025-12-19 05:49:55.932774
433	458	Malviya Urban Co-Op Bank Ltd	MUCB	MUCB	t	2025-12-19 05:49:55.937915	2025-12-19 05:49:55.937915
434	460	Saraspur Nagrik Sahakari Bank	SCNB	SCNB	t	2025-12-19 05:49:55.944414	2025-12-19 05:49:55.944414
435	461	Patan Nagarik Sahakari Bank Ltd	UPAT	UPAT	t	2025-12-19 05:49:55.949535	2025-12-19 05:49:55.949535
436	462	The Mehsana District Central Co-Op Bank Ltd	MSNB	MSNB	t	2025-12-19 05:49:55.955069	2025-12-19 05:49:55.955069
437	463	Khagaria District Central Co-Op Bank Ltd	KDCB	KDCB	t	2025-12-19 05:49:55.960451	2025-12-19 05:49:55.960451
438	464	The Yavatmal Urban Co-Op Bank Ltd	YUCB	YUCB	t	2025-12-19 05:49:55.965427	2025-12-19 05:49:55.965427
439	465	The Aurangabad District Central Co-Op Bank Ltd	ACBL	ACBL	t	2025-12-19 05:49:55.970539	2025-12-19 05:49:55.970539
440	466	The Rohika Central Co-Op Bank Ltd Madhubani	RCCB	RCCB	t	2025-12-19 05:49:55.97571	2025-12-19 05:49:55.97571
441	467	Uttrakhand Co-Op Bank Ltd	UCOB	UCOB	t	2025-12-19 05:49:55.980909	2025-12-19 05:49:55.980909
442	468	Khattri Co-Op Urban Bank Ltd	BKCB	BKCB	t	2025-12-19 05:49:55.985917	2025-12-19 05:49:55.985917
443	469	The Surat Mercantile Co-Op Bank Ltd	SMBC	SMBC	t	2025-12-19 05:49:55.990952	2025-12-19 05:49:55.990952
444	470	Chittorgarh Urban Co-Op Bank Ltd	CCUC	CCUC	t	2025-12-19 05:49:55.995989	2025-12-19 05:49:55.995989
445	471	The Kanara District Central Co-Op Bank Ltd Sirsi	KDCC	KDCC	t	2025-12-19 05:49:56.001059	2025-12-19 05:49:56.001059
446	472	The Karnavati Co-Op Bank Ltd	TKCB	TKCB	t	2025-12-19 05:49:56.006403	2025-12-19 05:49:56.006403
447	473	The Washim Urban Co-Op Bank Ltd Washim	WUCB	WUCB	t	2025-12-19 05:49:56.01152	2025-12-19 05:49:56.01152
448	474	Sarvodaya Sahakari Bank Ltd	SSBH	SSBH	t	2025-12-19 05:49:56.01667	2025-12-19 05:49:56.01667
449	475	Ambajogai Peoples Co-Op Bank Ltd	CAPC	CAPC	t	2025-12-19 05:49:56.022076	2025-12-19 05:49:56.022076
450	476	Manjeri Co-Op Urban Bank Ltd	MCUB	MCUB	t	2025-12-19 05:49:56.028038	2025-12-19 05:49:56.028038
451	477	Mansing Co-Op Bank Ltd Dudhondi	CMCB	CMCB	t	2025-12-19 05:49:56.03357	2025-12-19 05:49:56.03357
452	478	Shri Adinath Co-Op Bank Ltd	SACB	SACB	t	2025-12-19 05:49:56.03872	2025-12-19 05:49:56.03872
453	479	The Commercial Co-Op Bank Ltd Kolhapur	CCBK	CCBK	t	2025-12-19 05:49:56.043763	2025-12-19 05:49:56.043763
454	480	The Vijay Co-Op Bank Ltd	VCBL	VCBL	t	2025-12-19 05:49:56.04891	2025-12-19 05:49:56.04891
455	481	Veraval Mercantile Co-Op Bank	VMCB	VMCB	t	2025-12-19 05:49:56.054248	2025-12-19 05:49:56.054248
456	482	The Baroda City Co-Op Bank Ltd	BCOB	BCOB	t	2025-12-19 05:49:56.059742	2025-12-19 05:49:56.059742
457	483	Shri Janata Sahakari Bank Ltd Halol	USJB	USJB	t	2025-12-19 05:49:56.064882	2025-12-19 05:49:56.064882
458	484	The Bhavana Rishi Co-Op Urban Bank Ltd	BRCB	BRCB	t	2025-12-19 05:49:56.069965	2025-12-19 05:49:56.069965
459	485	Adarsh Mahila Nagari Sahakari Bank Ltd Aurangabad	AMSB	AMSB	t	2025-12-19 05:49:56.075003	2025-12-19 05:49:56.075003
460	486	Associate Co-Op Bank Ltd	ASCB	ASCB	t	2025-12-19 05:49:56.080083	2025-12-19 05:49:56.080083
461	487	Uttarkashi Zila Sahakari Bank Ltd	DCBU	DCBU	t	2025-12-19 05:49:56.08528	2025-12-19 05:49:56.08528
462	488	Sampada Sahakari Bank Ltd	SBSL	SBSL	t	2025-12-19 05:49:56.090501	2025-12-19 05:49:56.090501
463	489	The Ottapalam Co-Op Urban Bank Ltd	OCBL	OCBL	t	2025-12-19 05:49:56.095507	2025-12-19 05:49:56.095507
464	490	The Nawanagar Co-Op Bank	NCOB	NCOB	t	2025-12-19 05:49:56.100601	2025-12-19 05:49:56.100601
465	491	The Deola Merchant Co-Op Bank Ltd	DMOB	DMOB	t	2025-12-19 05:49:56.105742	2025-12-19 05:49:56.105742
466	492	Madhya Pradesh Rajya Sahakari Bank Maryadit	MPAB	MPAB	t	2025-12-19 05:49:56.110936	2025-12-19 05:49:56.110936
467	493	Aman Sahakari Bank Ltd Ichalkaranji	ASMB	ASMB	t	2025-12-19 05:49:56.116082	2025-12-19 05:49:56.116082
468	494	The Manmandir Co-Op Bank Ltd Vita	MMCB	MMCB	t	2025-12-19 05:49:56.121345	2025-12-19 05:49:56.121345
469	495	Balotra Urban Co-Op Bank Ltd	BALU	BALU	t	2025-12-19 05:49:56.126441	2025-12-19 05:49:56.126441
470	496	Rajkot District Central Co-Op Bank	RDCB	RDCB	t	2025-12-19 05:49:56.131664	2025-12-19 05:49:56.131664
471	497	Bhatpara Naihati Co-Op Bank Ltd	BUCB	BUCB	t	2025-12-19 05:49:56.136888	2025-12-19 05:49:56.136888
472	498	Wai Urban Co-Op Bank Ltd	WUBL	WUBL	t	2025-12-19 05:49:56.142071	2025-12-19 05:49:56.142071
473	499	Navi Mumbai Co-Op Bank Ltd	NMCL	NMCL	f	2025-12-19 05:49:56.147264	2025-12-19 05:49:56.147264
474	500	Sudha Co-Op Urban Bank Ltd	SCUB	SCUB	t	2025-12-19 05:49:56.152307	2025-12-19 05:49:56.152307
475	501	Angul Central Co-Op Bank Ltd	YEAC	YEAC	t	2025-12-19 05:49:56.157656	2025-12-19 05:49:56.157656
476	502	Balasore Bhadrak Central Co-Op Bank	BBCC	BBCC	t	2025-12-19 05:49:56.163859	2025-12-19 05:49:56.163859
477	503	Banki Central Co-Op Bank Ltd	BCYS	BCYS	t	2025-12-19 05:49:56.169714	2025-12-19 05:49:56.169714
478	504	Berhampore Central Co-Op Bank Ltd	IBBC	IBBC	t	2025-12-19 05:49:56.175709	2025-12-19 05:49:56.175709
479	505	Bhawanipatna Central Co-Op Bank Ltd	ICBC	ICBC	t	2025-12-19 05:49:56.184217	2025-12-19 05:49:56.184217
480	506	Bolangir Central Co-Op Bank Ltd	YSBC	YSBC	t	2025-12-19 05:49:56.189572	2025-12-19 05:49:56.189572
481	507	Boudh Central Co-Op Bank Ltd	YSBB	YSBB	t	2025-12-19 05:49:56.196408	2025-12-19 05:49:56.196408
482	508	Cuttack Central Co-Op Bank Ltd	CCCB	CCCB	t	2025-12-19 05:49:56.202228	2025-12-19 05:49:56.202228
483	509	Khurda Central Co-Op Bank Ltd	KCCC	KCCC	t	2025-12-19 05:49:56.208105	2025-12-19 05:49:56.208105
484	510	Mayurbhanj Central Co-Op Bank Ltd	MCCC	MCCC	t	2025-12-19 05:49:56.21342	2025-12-19 05:49:56.21342
485	511	Nayagarh Central Co-Op Bank Ltd	NCCC	NCCC	t	2025-12-19 05:49:56.218759	2025-12-19 05:49:56.218759
486	512	Sambalpur Central Co-Op Bank Ltd	SCYS	SCYS	t	2025-12-19 05:49:56.224282	2025-12-19 05:49:56.224282
487	513	Samruddhi Co-Op Bank Ltd	SSBB	SSBB	t	2025-12-19 05:49:56.22959	2025-12-19 05:49:56.22959
488	514	The District Co-Op Bank Ltd	TDCC	TDCC	f	2025-12-19 05:49:56.234826	2025-12-19 05:49:56.234826
489	515	Sundargarh Central Co-Op Bank Ltd	SCBB	SCBB	t	2025-12-19 05:49:56.240515	2025-12-19 05:49:56.240515
490	516	United Puri Nimapara Central Co-Op Bank	UPNC	UPNC	t	2025-12-19 05:49:56.246319	2025-12-19 05:49:56.246319
491	517	Abhinandan Urban Co-Op Bank Ltd	AUUB	AUUB	t	2025-12-19 05:49:56.2527	2025-12-19 05:49:56.2527
492	518	Bhilwara Urban Co-Op Bank Ltd	BUCN	BUCN	t	2025-12-19 05:49:56.259	2025-12-19 05:49:56.259
493	519	Sumerpur Merchantile Urban Co-Op Bank Ltd	SMUC	SMUC	t	2025-12-19 05:49:56.265362	2025-12-19 05:49:56.265362
494	520	The Eenadu Co-Op Urban Bank Ltd	ECUB	ECUB	t	2025-12-19 05:49:56.271236	2025-12-19 05:49:56.271236
495	521	M S Co-Op Bank Ltd	MSSB	MSSB	t	2025-12-19 05:49:56.277332	2025-12-19 05:49:56.277332
496	522	Sterling Urban Co-Op Bank Ltd	SUCC	SUCC	t	2025-12-19 05:49:56.282726	2025-12-19 05:49:56.282726
497	523	Vallabh Vidyanagar Commercial Co-Op Bank Ltd	VVCC	VVCC	t	2025-12-19 05:49:56.287912	2025-12-19 05:49:56.287912
498	524	Godavari Urban Co-Op Bank Ltd Vazirabad	GUCC	GUCC	t	2025-12-19 05:49:56.293165	2025-12-19 05:49:56.293165
499	525	Baroda Central Co-Op Bank	BCCC	BCCC	t	2025-12-19 05:49:56.29866	2025-12-19 05:49:56.29866
500	526	Darussalam Co-Op Urban Bank Ltd	DCUB	DCUB	t	2025-12-19 05:49:56.305186	2025-12-19 05:49:56.305186
501	527	Shree Warana Sahakari Bank Ltd	SWSS	SWSS	t	2025-12-19 05:49:56.312844	2025-12-19 05:49:56.312844
502	528	The Panchsheel Mercantile Co-Op Bank Ltd	TPMB	TPMB	t	2025-12-19 05:49:56.319542	2025-12-19 05:49:56.319542
503	529	Unjha Nagarik Sahakari Bank Ltd	UNSB	UNSB	t	2025-12-19 05:49:56.325387	2025-12-19 05:49:56.325387
504	530	Adar P D Patil Sahakari Bank	APDB	APDB	t	2025-12-19 05:49:56.331324	2025-12-19 05:49:56.331324
505	531	C G Rajya Sahakari Bank Maryadit Raipur	CGSB	CGSB	t	2025-12-19 05:49:56.337407	2025-12-19 05:49:56.337407
506	532	Samata Sahakari Bank Ltd	SSBC	SSBC	t	2025-12-19 05:49:56.343247	2025-12-19 05:49:56.343247
507	533	Mahesh Sahakari Bank Pune	MSBP	MSBP	t	2025-12-19 05:49:56.349011	2025-12-19 05:49:56.349011
508	534	The Madanapalle Co-Op Town Bank Ltd	MCTB	MCTB	t	2025-12-19 05:49:56.354756	2025-12-19 05:49:56.354756
509	535	Shrimant Malojiraje Sahakari Bank Ltd	SMSB	SMSB	t	2025-12-19 05:49:56.363494	2025-12-19 05:49:56.363494
510	536	Deendayal Nagari Sahakari Bank Ltd	DNBB	DNBB	t	2025-12-19 05:49:56.369422	2025-12-19 05:49:56.369422
511	537	District Co-Op Bank Ltd Dehradun	DCOB	DCOB	t	2025-12-19 05:49:56.375447	2025-12-19 05:49:56.375447
512	538	The Urban Co-Op Bank Ltd Dharangaon	UCBD	UCBD	t	2025-12-19 05:49:56.381549	2025-12-19 05:49:56.381549
513	539	Lakhimpur Urban Co-Op Bank Ltd	LCUB	LCUB	t	2025-12-19 05:49:56.387423	2025-12-19 05:49:56.387423
514	540	Sundarlal Sawaji Urban Co-Op Bank Ltd	SSCU	SSCU	t	2025-12-19 05:49:56.393358	2025-12-19 05:49:56.393358
515	541	Manorma Co-Op Bank Ltd Solapur	MCBB	MCBB	t	2025-12-19 05:49:56.398862	2025-12-19 05:49:56.398862
516	542	Junagadh Commercial Co-Op Bank Ltd	JCCB	JCCB	t	2025-12-19 05:49:56.404544	2025-12-19 05:49:56.404544
517	543	Fincare Small Finance Bank Ltd	FSFB	FSFB	t	2025-12-19 05:49:56.410228	2025-12-19 05:49:56.410228
518	544	Idukki District Co-Op Bank Ltd	IDUK	IDUK	t	2025-12-19 05:49:56.416064	2025-12-19 05:49:56.416064
519	545	Jalgaon Janata Sahakari Bank Ltd	JJSB	JJSB	t	2025-12-19 05:49:56.421812	2025-12-19 05:49:56.421812
520	546	Janaseva Sahakari Bank Borivali Ltd	JASB	JASB	t	2025-12-19 05:49:56.426994	2025-12-19 05:49:56.426994
521	547	Textile Traders Co-Op Bank Ltd	TTCB	TTCB	t	2025-12-19 05:49:56.432286	2025-12-19 05:49:56.432286
522	548	Pragati Sahakari Bank Ltd	PSBB	PSBB	t	2025-12-19 05:49:56.437642	2025-12-19 05:49:56.437642
523	549	Bhavnagar District Central Co-Op Bank Ltd	BVNL	BVNL	t	2025-12-19 05:49:56.442742	2025-12-19 05:49:56.442742
524	550	The Banaskantha District Central Co-Op Bank Ltd	BKDL	BKDL	t	2025-12-19 05:49:56.44798	2025-12-19 05:49:56.44798
525	551	Pune Merchants Co-Op Bank Ltd	PMCL	PMCL	t	2025-12-19 05:49:56.453099	2025-12-19 05:49:56.453099
526	552	Latur Urban Co-Op Bank	LUCL	LUCL	t	2025-12-19 05:49:56.460594	2025-12-19 05:49:56.460594
527	553	The Gandevi Peoples Co-Op Bank Ltd	GPCB	GPCB	t	2025-12-19 05:49:56.467574	2025-12-19 05:49:56.467574
528	554	Rajarambapu Sahakari Bank Ltd	RBSL	RBSL	t	2025-12-19 05:49:56.475104	2025-12-19 05:49:56.475104
529	555	Central Co-Op Bank Ltd Ara	CCBA	CCBA	t	2025-12-19 05:49:56.480385	2025-12-19 05:49:56.480385
530	556	Mahaveer Co-Op Urban Bank Ltd	MBCL	MBCL	t	2025-12-19 05:49:56.486346	2025-12-19 05:49:56.486346
531	557	The Jalgaon District Central Co-Op Bank Ltd	JDBL	JDBL	t	2025-12-19 05:49:56.491623	2025-12-19 05:49:56.491623
532	558	Etawah District Co-Op Bank Ltd Etawah	ETAW	ETAW	t	2025-12-19 05:49:56.497103	2025-12-19 05:49:56.497103
533	559	Bihar State Co-Op Bank Ltd	BSCB	BSCB	t	2025-12-19 05:49:56.502283	2025-12-19 05:49:56.502283
534	560	Almora Zila Sahakari Bank Ltd	AZSB	AZSB	t	2025-12-19 05:49:56.508157	2025-12-19 05:49:56.508157
535	561	Nainital District Co-Op Bank Ltd	NDCL	NDCL	t	2025-12-19 05:49:56.513967	2025-12-19 05:49:56.513967
536	562	North East Small Finance Bank Ltd	NESF	NESF	t	2025-12-19 05:49:56.521928	2025-12-19 05:49:56.521928
537	563	Alapuzha District Co-Op Bank Ltd	SADC	SADC	t	2025-12-19 05:49:56.52743	2025-12-19 05:49:56.52743
538	564	Chamoli Zila Sahakari Bank Ltd	CZSB	CZSB	t	2025-12-19 05:49:56.533286	2025-12-19 05:49:56.533286
539	565	Navsarjan Industrial Co-OP Bank Ltd	CNIC	CNIC	t	2025-12-19 05:49:56.53864	2025-12-19 05:49:56.53864
540	566	Kankaria Maninagar Nagrik Sahakari Bank Ltd	KMNB	KMNB	t	2025-12-19 05:49:56.544045	2025-12-19 05:49:56.544045
541	567	The Sarvodaya Nagrik Sahkari Bank Ltd	SNBL	SNBL	t	2025-12-19 05:49:56.55	2025-12-19 05:49:56.55
542	568	The Kurla Nagarik Sahakari Bank Ltd	KURL	KURL	t	2025-12-19 05:49:56.555688	2025-12-19 05:49:56.555688
543	569	The Bharat Co-Op Bank Ltd	IBCB	IBCB	t	2025-12-19 05:49:56.562439	2025-12-19 05:49:56.562439
544	570	Jana Small Finance Bank Ltd	JSFB	JSFB	t	2025-12-19 05:49:56.56919	2025-12-19 05:49:56.56919
545	571	Gadchiroli District Central Co-Op Bank	GDCB	GDCB	t	2025-12-19 05:49:56.575036	2025-12-19 05:49:56.575036
546	572	Shri Anand Nagari Sahakari Bank Limited	SANB	SANB	t	2025-12-19 05:49:56.580331	2025-12-19 05:49:56.580331
547	573	Belagavi Shree Basveshwar Co-Op Bank Ltd	SBCL	SBCL	t	2025-12-19 05:49:56.58581	2025-12-19 05:49:56.58581
548	574	Bhopal Co-Op Central Bank Ltd	BCAE	BCAE	t	2025-12-19 05:49:56.592539	2025-12-19 05:49:56.592539
549	575	Kashmir Mercantile Co-Op Bank Ltd Kashmir	KAMC	KAMC	t	2025-12-19 05:49:56.598561	2025-12-19 05:49:56.598561
550	576	The Sevalia Urban Co-Op Bank Ltd	SEVC	SEVC	t	2025-12-19 05:49:56.604919	2025-12-19 05:49:56.604919
551	577	The Laxmi Co-Op Bank Ltd Solapur	LCOS	LCOS	t	2025-12-19 05:49:56.611656	2025-12-19 05:49:56.611656
552	578	The Sarvodaya Co-Op Bank Ltd Mum	CSBM	CSBM	f	2025-12-19 05:49:56.617889	2025-12-19 05:49:56.617889
553	579	Janakalyan Co-Op Bank Ltd	JBLN	JBLN	f	2025-12-19 05:49:56.623945	2025-12-19 05:49:56.623945
554	580	Deogiri Nagari Sahakari Bank Ltd	DEOB	DEOB	f	2025-12-19 05:49:56.630099	2025-12-19 05:49:56.630099
555	581	The Kapurthala Central Co-Op Bank Ltd	SKPT	SKPT	f	2025-12-19 05:49:56.636058	2025-12-19 05:49:56.636058
556	582	Patliputra Central Co-Op Bank Ltd	IPCC	IPCC	t	2025-12-19 05:49:56.64246	2025-12-19 05:49:56.64246
557	583	The Begusarai District Central Co-Op Bank	BDCB	BDCB	f	2025-12-19 05:49:56.647888	2025-12-19 05:49:56.647888
558	584	Kozhikode District Co-Op Bank	KDDB	KDDB	t	2025-12-19 05:49:56.653291	2025-12-19 05:49:56.653291
559	585	Shushruti Souharda Sahakara Bank Niyamita	SSBN	SSBN	t	2025-12-19 05:49:56.659745	2025-12-19 05:49:56.659745
560	586	The Rajkot Commercial Co-Op Bank Ltd	RCBB	RCBB	t	2025-12-19 05:49:56.666033	2025-12-19 05:49:56.666033
561	587	The Bardoli Nagrik Sahakari bank Ltd	BNBL	BNBL	t	2025-12-19 05:49:56.671717	2025-12-19 05:49:56.671717
562	588	Urban Co-Op Bank Ltd Bareilly	UCBB	UCBB	t	2025-12-19 05:49:56.677772	2025-12-19 05:49:56.677772
563	589	The United Co-Op Bank Ltd	TUBL	TUBL	f	2025-12-19 05:49:56.68394	2025-12-19 05:49:56.68394
564	590	The Faridabad Central Co-Op Bank Ltd	SFCB	SFCB	f	2025-12-19 05:49:56.689897	2025-12-19 05:49:56.689897
565	591	The Muzaffarpur Central Co-Op Bank Ltd	IMCC	IMCC	f	2025-12-19 05:49:56.696124	2025-12-19 05:49:56.696124
566	592	The South Canara District Central Co-Op Bank	SCDC	SCDC	f	2025-12-19 05:49:56.701289	2025-12-19 05:49:56.701289
567	593	The Ernakulam District Co-Op Bank Ltd	BEDC	BEDC	f	2025-12-19 05:49:56.706602	2025-12-19 05:49:56.706602
568	594	Vasai Janata Sahkari Bank Ltd	VJBL	VJBL	f	2025-12-19 05:49:56.711751	2025-12-19 05:49:56.711751
569	595	Sangli Sahakari Bank Ltd	SBBB	SBBB	t	2025-12-19 05:49:56.717512	2025-12-19 05:49:56.717512
570	596	Australia And New Zealand Banking Group Ltd	ANZB	ANZB	f	2025-12-19 05:49:56.723204	2025-12-19 05:49:56.723204
571	597	DMK Jaoli Bank	DMKJ	DMKJ	t	2025-12-19 05:49:56.728934	2025-12-19 05:49:56.728934
572	598	Doha Bank	DOHB	DOHB	f	2025-12-19 05:49:56.7347	2025-12-19 05:49:56.7347
573	599	Emirates Nbd India	EBIL	EBIL	t	2025-12-19 05:49:56.740279	2025-12-19 05:49:56.740279
574	600	Export Import Bank Of India	EIBI	EIBI	f	2025-12-19 05:49:56.745975	2025-12-19 05:49:56.745975
575	601	Haryana State Co-Op Bank	HARC	HARC	t	2025-12-19 05:49:56.752129	2025-12-19 05:49:56.752129
576	602	Woori Bank	HVBK	HVBK	f	2025-12-19 05:49:56.757655	2025-12-19 05:49:56.757655
577	603	Bank Internasional Indonesia	IBBK	IBBK	f	2025-12-19 05:49:56.763716	2025-12-19 05:49:56.763716
578	604	Industrial Bank Of Korea	IBKO	IBKO	f	2025-12-19 05:49:56.769495	2025-12-19 05:49:56.769495
579	605	Industrial And Commercial Bank Of China Ltd	ICBK	ICBK	f	2025-12-19 05:49:56.776373	2025-12-19 05:49:56.776373
580	606	Keb Hana Bank	KOEX	KOEX	f	2025-12-19 05:49:56.782027	2025-12-19 05:49:56.782027
581	607	Krung Thai Bank Pcl	KRTH	KRTH	f	2025-12-19 05:49:56.787823	2025-12-19 05:49:56.787823
582	608	Sir M Visvesvaraya Co-Op Bank Ltd	MVCB	MVCB	f	2025-12-19 05:49:56.793656	2025-12-19 05:49:56.793656
583	609	National Australia Bank Ltd	NATA	NATA	f	2025-12-19 05:49:56.799294	2025-12-19 05:49:56.799294
584	610	National Bank Of Abu Dhabi PJSC	NBAD	NBAD	f	2025-12-19 05:49:56.804913	2025-12-19 05:49:56.804913
585	611	National Bank For Agriculture And Rural Development	NBRD	NBRD	f	2025-12-19 05:49:56.810427	2025-12-19 05:49:56.810427
586	612	Nagpur Nagrik Sahakari Bank Ltd	NGSB	NGSB	f	2025-12-19 05:49:56.816176	2025-12-19 05:49:56.816176
587	613	Nagar Urban Co-Op Bank	NUCB	NUCB	f	2025-12-19 05:49:56.821607	2025-12-19 05:49:56.821607
588	614	The Navnirman Co-Op Bank Ltd	NVNM	NVNM	t	2025-12-19 05:49:56.826807	2025-12-19 05:49:56.826807
589	615	Qatar National Bank Saq	QNBA	QNBA	f	2025-12-19 05:49:56.832099	2025-12-19 05:49:56.832099
590	616	Rabobank International	RABO	RABO	f	2025-12-19 05:49:56.837219	2025-12-19 05:49:56.837219
591	617	IDRBT Bank	RBIH	RBIH	f	2025-12-19 05:49:56.842284	2025-12-19 05:49:56.842284
592	618	Sber Bank	SABR	SABR	f	2025-12-19 05:49:56.847832	2025-12-19 05:49:56.847832
593	619	Small Industries Development Bank Of India	SIDB	SIDB	f	2025-12-19 05:49:56.85589	2025-12-19 05:49:56.85589
594	620	Shikshak Sahakari Bank Ltd	SKSB	SKSB	f	2025-12-19 05:49:56.861017	2025-12-19 05:49:56.861017
595	621	Tumkur Grain Merchants Co-Op Bank Ltd	TGMB	TGMB	t	2025-12-19 05:49:56.866945	2025-12-19 05:49:56.866945
596	622	United Overseas Bank Ltd	UOVB	UOVB	f	2025-12-19 05:49:56.872882	2025-12-19 05:49:56.872882
597	623	Westpac Banking Corporation	WPAC	WPAC	f	2025-12-19 05:49:56.878108	2025-12-19 05:49:56.878108
598	624	Credit Suisse AG Bank	CRES	CRES	f	2025-12-19 05:49:56.884325	2025-12-19 05:49:56.884325
599	625	Sumitomo Mitsui Banking Co-Op Bank	SMBB	SMBB	f	2025-12-19 05:49:56.889618	2025-12-19 05:49:56.889618
600	626	Tripura State Co-Op Bank Ltd	TSCB	TSCB	f	2025-12-19 05:49:56.894907	2025-12-19 05:49:56.894907
601	627	The Yamuna Nagar Central Co-Op Bank Ltd	YCCB	YCCB	f	2025-12-19 05:49:56.901396	2025-12-19 05:49:56.901396
602	628	The Banaskantha Mercantile Co-Op Bank Ltd	BMCB	BMCB	t	2025-12-19 05:49:56.906508	2025-12-19 05:49:56.906508
603	629	Kota Nagrik Sahkari Bank Ltd kota	CKNB	CKNB	t	2025-12-19 05:49:56.913289	2025-12-19 05:49:56.913289
604	630	The Commercial Co-Op Bank Ltd	COMM	COMM	t	2025-12-19 05:49:56.919814	2025-12-19 05:49:56.919814
605	631	The Naroda Nagrik Co-Op Bank Ltd	NNCB	NNCB	t	2025-12-19 05:49:56.926573	2025-12-19 05:49:56.926573
606	632	The Godhra Urban Co-Op Bank Ltd	SGUC	SGUC	t	2025-12-19 05:49:56.931795	2025-12-19 05:49:56.931795
607	633	Solapur Siddheshwar Sahakari Bank Ltd	SIDD	SIDD	t	2025-12-19 05:49:56.936869	2025-12-19 05:49:56.936869
608	634	Sharad Nagari Sahakari Bank Ltd	SNSB	SNSB	f	2025-12-19 05:49:56.942245	2025-12-19 05:49:56.942245
609	635	The Tarn Taran Central Co-Op Bank Ltd	STTN	STTN	f	2025-12-19 05:49:56.947616	2025-12-19 05:49:56.947616
610	636	Purnea District Central Co-Op Bank	PCCB	PCCB	f	2025-12-19 05:49:56.952655	2025-12-19 05:49:56.952655
611	637	The Panchkula Central Co-Op Bank Ltd	SPKL	SPKL	f	2025-12-19 05:49:56.957935	2025-12-19 05:49:56.957935
612	638	The Kottakkal Co-Op Urban Bank Ltd	SKUB	SKUB	t	2025-12-19 05:49:56.963103	2025-12-19 05:49:56.963103
613	639	Jampeta Urban Co-Op Bank	CBNB	CBNB	t	2025-12-19 05:49:56.96973	2025-12-19 05:49:56.96973
614	640	Karnataka Gramin Bank	RKGB	RKGB	t	2025-12-19 05:49:56.974932	2025-12-19 05:49:56.974932
615	641	Ahmednagar Sahar Sahakari Bank Maryadit	ASSB	ASSB	t	2025-12-19 05:49:56.981255	2025-12-19 05:49:56.981255
616	642	Gujarat Ambuja Co-Op Bank Ltd	GACB	GACB	t	2025-12-19 05:49:56.987602	2025-12-19 05:49:56.987602
617	643	The Business Co-Op Bank Ltd	BOBC	BOBC	t	2025-12-19 05:49:56.992862	2025-12-19 05:49:56.992862
618	644	The Nawada Central Co-Op Bank Ltd	NCCB	NCCB	t	2025-12-19 05:49:56.998411	2025-12-19 05:49:56.998411
619	645	The Adinath Co-Op Bank Ltd	ACOB	ACOB	t	2025-12-19 05:49:57.003778	2025-12-19 05:49:57.003778
620	646	Shree Dharati Co-Op Bank Ltd	SCDB	SCDB	t	2025-12-19 05:49:57.009065	2025-12-19 05:49:57.009065
621	647	Rajkot Peoples Co-Op Bank Ltd	RPCB	RPCB	t	2025-12-19 05:49:57.014737	2025-12-19 05:49:57.014737
622	648	Sirsi Urban Sahakari Bank Ltd	USBL	USBL	t	2025-12-19 05:49:57.020148	2025-12-19 05:49:57.020148
623	649	Sangola Urban Co-Op Bank Ltd	SUCB	SUCB	f	2025-12-19 05:49:57.025445	2025-12-19 05:49:57.025445
624	650	The Hoshiarpur Central Co-Op Bank Ltd	SHSP	SHSP	f	2025-12-19 05:49:57.031325	2025-12-19 05:49:57.031325
625	651	Vaijapur Merchants Bank	VMBL	VMBL	f	2025-12-19 05:49:57.036623	2025-12-19 05:49:57.036623
626	652	Jila Sahakari Kendriya Bank Maryadit Dhar	JSKB	JSKB	t	2025-12-19 05:49:57.042159	2025-12-19 05:49:57.042159
627	653	Peoples Co-Op Bank Ltd Dholka	PCBD	PCBD	t	2025-12-19 05:49:57.047579	2025-12-19 05:49:57.047579
628	654	The Udaipur Mahila Urban Co-Op Bank Ltd	UMUC	UMUC	t	2025-12-19 05:49:57.052834	2025-12-19 05:49:57.052834
629	655	The Aska Co-Op Central Bank Ltd	ASKA	ASKA	t	2025-12-19 05:49:57.058472	2025-12-19 05:49:57.058472
630	656	Keonjhar Central Co-Op Bank Ltd	SKCC	SKCC	t	2025-12-19 05:49:57.063616	2025-12-19 05:49:57.063616
631	657	The Koraput Central Co-Op Bank Ltd	SKOC	SKOC	t	2025-12-19 05:49:57.06893	2025-12-19 05:49:57.06893
632	658	Nagaland Rural Bank	NLGB	NLGB	t	2025-12-19 05:49:57.074444	2025-12-19 05:49:57.074444
633	659	The Udupi Co-Op Town Bank	UCTB	UCTB	t	2025-12-19 05:49:57.079662	2025-12-19 05:49:57.079662
634	660	Coastal Local Area Bank Ltd	CLAB	CLAB	t	2025-12-19 05:49:57.085577	2025-12-19 05:49:57.085577
635	661	The Bhagyalakshmi Mahila Sah Bank	BMSB	BMSB	t	2025-12-19 05:49:57.091051	2025-12-19 05:49:57.091051
636	662	The Ssk Co-Op Bank Ltd	SSSK	SSSK	t	2025-12-19 05:49:57.097592	2025-12-19 05:49:57.097592
637	663	Valmiki Urban Co-Op Bank Ltd	SVAU	SVAU	t	2025-12-19 05:49:57.102918	2025-12-19 05:49:57.102918
638	664	The Bhandara District Central Co-Op Bank Ltd	BHNL	BHNL	t	2025-12-19 05:49:57.10874	2025-12-19 05:49:57.10874
639	665	The Nagar Sahakari Bank Ltd	NBKG	NBKG	t	2025-12-19 05:49:57.114528	2025-12-19 05:49:57.114528
640	666	The Uttarsanda Peoples Co-Op Bank	SUPC	SUPC	t	2025-12-19 05:49:57.121186	2025-12-19 05:49:57.121186
641	667	The Kakatiya Co-Op Urban Bank	SKCU	SKCU	t	2025-12-19 05:49:57.127411	2025-12-19 05:49:57.127411
642	668	The Kranthi Co-Op Urban Bank Ltd	SKRN	SKRN	t	2025-12-19 05:49:57.1326	2025-12-19 05:49:57.1326
643	669	Sri Vasavamba Co-Op Bank Ltd	VCBA	VCBA	t	2025-12-19 05:49:57.137704	2025-12-19 05:49:57.137704
644	670	The Union Co-Op Bank Ltd	UCBN	UCBN	t	2025-12-19 05:49:57.144186	2025-12-19 05:49:57.144186
645	671	Citizens Co-Op Bank Ltd	CCOB	CCOB	t	2025-12-19 05:49:57.150114	2025-12-19 05:49:57.150114
646	672	Jawahar Sahakari Bank Ltd	JSBH	JSBH	t	2025-12-19 05:49:57.155746	2025-12-19 05:49:57.155746
647	673	Bapuji Co-Op Bank Ltd	BOBL	BOBL	t	2025-12-19 05:49:57.161245	2025-12-19 05:49:57.161245
648	674	Uttrakhand State Co-Co Bank Ltd	USCB	USCB	t	2025-12-19 05:49:57.167073	2025-12-19 05:49:57.167073
649	675	Udham Singh Nagar District Co-Op Bank Ltd	USND	USND	t	2025-12-19 05:49:57.173168	2025-12-19 05:49:57.173168
650	676	The Burdwan Central Co-Op Bank Ltd	CBCB	CBCB	t	2025-12-19 05:49:57.178965	2025-12-19 05:49:57.178965
651	677	Pimpri Chinchwad Sahakari Bank	PSCL	PSCL	t	2025-12-19 05:49:57.184363	2025-12-19 05:49:57.184363
652	678	The Maharaja Co-Op Urban Bank Ltd	IMCB	IMCB	t	2025-12-19 05:49:57.189725	2025-12-19 05:49:57.189725
653	679	The Kerala State Co-Op Bank Ltd	KCSB	KCSB	t	2025-12-19 05:49:57.195	2025-12-19 05:49:57.195
654	680	The Visakhapatnam Co-Op Bank Ltd	TVCB	TVCB	t	2025-12-19 05:49:57.200095	2025-12-19 05:49:57.200095
655	681	Sarvodaya Commercial Co-Op Bank Ltd	SCOB	SCOB	t	2025-12-19 05:49:57.205276	2025-12-19 05:49:57.205276
656	682	The Samastipur District Central Co-Op Bank Ltd	SDCL	SDCL	t	2025-12-19 05:49:57.210381	2025-12-19 05:49:57.210381
657	683	Belgaum Zilla Rani Channamma Mahila Sahakari Bank Niyamit	BZRB	BZRB	t	2025-12-19 05:49:57.215616	2025-12-19 05:49:57.215616
658	684	The Chandrapur District Central Co-Op Bank Ltd	CDBL	CDBL	t	2025-12-19 05:49:57.221104	2025-12-19 05:49:57.221104
659	685	Ajantha Urban Co-Op Bank Ltd	AUCL	AUCL	t	2025-12-19 05:49:57.226362	2025-12-19 05:49:57.226362
660	686	Mudgal Urban Co-Op Bank Ltd	SMUB	SMUB	t	2025-12-19 05:49:57.231691	2025-12-19 05:49:57.231691
661	687	Jodhpur Nagrik Sahakari Bank Ltd	CJNB	CJNB	t	2025-12-19 05:49:57.237005	2025-12-19 05:49:57.237005
662	688	Wardhman Urban Co-Op Bank Ltd	WUCL	WUCL	t	2025-12-19 05:49:57.242154	2025-12-19 05:49:57.242154
663	689	Mizoram Co-Op Apex Bank Ltd	MABL	MABL	t	2025-12-19 05:49:57.247288	2025-12-19 05:49:57.247288
664	690	The Naval Dockyard Co-Op Bank Ltd	NDBL	NDBL	t	2025-12-19 05:49:57.252419	2025-12-19 05:49:57.252419
665	691	Vardhaman Mahila Co-Op Urban Bank Ltd	CVBL	CVBL	t	2025-12-19 05:49:57.257926	2025-12-19 05:49:57.257926
666	692	Jammu And Kashmir State Co-Op Bank	SJKB	SJKB	t	2025-12-19 05:49:57.263282	2025-12-19 05:49:57.263282
667	693	Jivan Commercial Co-Op Bank Ltd	JIVA	JIVA	t	2025-12-19 05:49:57.269112	2025-12-19 05:49:57.269112
668	694	Krishna Bhima Samruddhi Local Area Bank	KBSL	KBSL	t	2025-12-19 05:49:57.275093	2025-12-19 05:49:57.275093
669	695	The Dahod Urban Co-Op Bank Ltd	TDUC	TDUC	t	2025-12-19 05:49:57.280488	2025-12-19 05:49:57.280488
670	696	Shri Mahila Sewa Sahakari Bank Ltd	SMSS	SMSS	t	2025-12-19 05:49:57.286117	2025-12-19 05:49:57.286117
671	697	Mahatma Fule Urban Co-Op Bank Ltd Amravati	MFUC	MFUC	t	2025-12-19 05:49:57.291406	2025-12-19 05:49:57.291406
672	698	The Tiruvalla East Co-Op Bank	TTEC	TTEC	t	2025-12-19 05:49:57.296732	2025-12-19 05:49:57.296732
673	699	The Gandhi Co-Op Urban Bank Ltd	TGCU	TGCU	t	2025-12-19 05:49:57.302505	2025-12-19 05:49:57.302505
674	700	The Anand Mercantile Co-Op Bank Ltd	AMBL	AMBL	t	2025-12-19 05:49:57.307887	2025-12-19 05:49:57.307887
675	701	Nagrik Sahakari Bank Maryadit Vidisha	NSMV	NSMV	t	2025-12-19 05:49:57.313509	2025-12-19 05:49:57.313509
676	702	Udyam Vikas Sahakari bank	UVSB	UVSB	t	2025-12-19 05:49:57.319357	2025-12-19 05:49:57.319357
677	703	The Texco Co-Op Bank Ltd	TCBL	TCBL	t	2025-12-19 05:49:57.325042	2025-12-19 05:49:57.325042
678	704	Uma Co-Op Bank Ltd	UMCB	UMCB	t	2025-12-19 05:49:57.330771	2025-12-19 05:49:57.330771
679	705	Shri Shivayogi Murughendra Swami Urban Co-Op Bank Ltd	SMSU	SMSU	t	2025-12-19 05:49:57.33665	2025-12-19 05:49:57.33665
680	706	Jila Sahakari Kendriya Bank Maryadit Vidisha	JSKV	JSKV	t	2025-12-19 05:49:57.342782	2025-12-19 05:49:57.342782
681	707	Jila Sahakari Kendriya Bank Maryadit Ujjain	JSKU	JSKU	t	2025-12-19 05:49:57.349206	2025-12-19 05:49:57.349206
682	708	Jila Sahakari Kendriya Bank Maryadit Dewas	JSKD	JSKD	t	2025-12-19 05:49:57.356125	2025-12-19 05:49:57.356125
683	709	The Sultan S Battery Co-Op Urban Bank Ltd	SBCB	SBCB	t	2025-12-19 05:49:57.362635	2025-12-19 05:49:57.362635
684	710	Sri Rama Co-Op Bank Ltd	SRBB	SRBB	t	2025-12-19 05:49:57.368615	2025-12-19 05:49:57.368615
685	711	Sri Guru Raghavendra Sahakara Bank Niyamitha	SGRS	SGRS	t	2025-12-19 05:49:57.374755	2025-12-19 05:49:57.374755
686	712	Navanagara Urban Co-Op Bank Ltd	NUBB	NUBB	t	2025-12-19 05:49:57.381132	2025-12-19 05:49:57.381132
687	713	Subhadra Local Area Bank Ltd	SLAB	SLAB	t	2025-12-19 05:49:57.387155	2025-12-19 05:49:57.387155
688	714	Parbhani District Central Co-Op Bank	PDBH	PDBH	f	2025-12-19 05:49:57.393603	2025-12-19 05:49:57.393603
689	715	The Gopalganj Central Gopalganj Co-Op Bank Ltd	GCBL	GCBL	f	2025-12-19 05:49:57.400942	2025-12-19 05:49:57.400942
690	716	The Bhatkal Urban Co-Op Bank Ltd	SBUL	SBUL	f	2025-12-19 05:49:57.406696	2025-12-19 05:49:57.406696
691	717	Vaishya Nagari Sahakari Bank Ltd	SVNS	SVNS	t	2025-12-19 05:49:57.412782	2025-12-19 05:49:57.412782
692	718	The Fatehgarh Sahib Central Co-Op Bank Ltd	SFGH	SFGH	f	2025-12-19 05:49:57.418666	2025-12-19 05:49:57.418666
693	719	Indore Cloth Mkt Co-Op Bank	ICMB	ICMB	f	2025-12-19 05:49:57.424506	2025-12-19 05:49:57.424506
694	720	The Solapur Dist Central Co-Op Bank	BSDC	BSDC	f	2025-12-19 05:49:57.430517	2025-12-19 05:49:57.430517
695	721	Latur District Central Co-Op Bank Ltd	ILDC	ILDC	f	2025-12-19 05:49:57.436472	2025-12-19 05:49:57.436472
696	722	NSDL Payment Bank Limited	NSPB	NSPB	t	2025-12-19 05:49:57.44259	2025-12-19 05:49:57.44259
697	723	The Pimpalgaon Merchants Co-Op Bank Ltd	CPIM	CPIM	t	2025-12-19 05:49:57.448128	2025-12-19 05:49:57.448128
698	724	Mizoram Urban Co-Op Development Bank	MUDC	MUDC	t	2025-12-19 05:49:57.45444	2025-12-19 05:49:57.45444
699	725	Indore Paraspar Sahakari Bank Ltd	INPR	INPR	t	2025-12-19 05:49:57.462475	2025-12-19 05:49:57.462475
700	726	The Co-Op Bank Of Mehsana Ltd	CBML	CBML	t	2025-12-19 05:49:57.468701	2025-12-19 05:49:57.468701
701	727	The Gurgaon Central Co-Op Bank Ltd	BGBL	BGBL	f	2025-12-19 05:49:57.474683	2025-12-19 05:49:57.474683
\.


--
-- Data for Name: enquiries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.enquiries (id, first_name, last_name, email, phone_number, aadhaar_number, pan_card, status, role_id, created_at, updated_at) FROM stdin;
1	Siddharth	gautam	sid12321@gmail.com	7879879879	987969668768	\N	t	5	2025-08-28 07:40:17.022381	2025-08-28 07:44:12.203754
2	Mohammad	Aamir	aman@gmail.com	6776767687	557686757858	\N	f	5	2025-08-28 08:39:51.331706	2025-08-28 08:39:51.331706
3	Gulshan	Gautam	gulshan@gmail.com	9877987879	687856567576	\N	t	5	2025-08-28 08:48:28.503893	2025-08-28 09:04:36.911381
4	Satish	kumar	satish@gmail.com	9877989879	789789879877	\N	t	5	2025-08-28 09:06:59.523494	2025-08-28 09:08:17.361513
5	khalid	abdul	khalid@gmail.com	7886867869	689676785768	\N	t	5	2025-08-28 09:15:50.225575	2025-08-28 09:18:02.941339
6	sandeep	kumar	sandeep@gmail.com	9877987798	987797987987	\N	t	5	2025-08-28 10:04:15.383853	2025-08-28 10:10:56.088823
7	Sameer	khsn	sameer@gmail.com	4354354364	837583465724	\N	t	7	2025-08-28 10:32:03.86179	2025-08-28 10:34:33.231633
9	Manoj	kumar	manoj@gmail.com	9877987979	087987979868	\N	t	5	2025-08-28 13:40:17.14873	2025-08-28 13:42:05.492517
10	Anurag	singh	anurag@gmail.com	7686868686	879878797987	\N	f	5	2025-09-17 07:00:57.252527	2025-09-17 07:00:57.252527
11	Mohammad	Aamir	f@jjh	0875685476	\N	YUUYY4545J	f	6	2025-09-17 07:44:48.337068	2025-09-17 07:44:48.337068
12	\N	\N	\N	\N	\N	\N	f	5	2025-11-19 07:26:30.669516	2025-11-19 07:26:30.669516
13	\N	\N	manikanttiwari3669@gmail.com	\N	\N	\N	f	5	2025-11-19 08:41:07.500272	2025-11-19 08:41:07.500272
14	\N	\N	manikanttiwari3669@gmail.com	\N	\N	\N	f	5	2025-11-19 08:41:40.773202	2025-11-19 08:41:40.773202
15	rajju 	bhai	manikanttiwari3669@gmail.com	8317082162	\N	\N	f	5	2025-11-19 08:47:20.548223	2025-11-19 08:47:20.548223
16	rajju 	bhai	manikanttiwari3669@gmail.com	8317082162	\N	\N	f	5	2025-11-19 08:49:44.618946	2025-11-19 08:49:44.618946
17	siddd	sir	manikanttiwari3669@gmail.com	8317082162	655380762625	\N	f	5	2025-11-19 08:51:36.238965	2025-11-19 08:51:36.238965
18	sonam	mam	manikanttiwari3669@gmail.com	8317082162	655380766161	\N	f	5	2025-11-19 12:39:22.03458	2025-11-19 12:39:22.03458
\.


--
-- Data for Name: fund_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fund_requests (id, user_id, requested_by, amount, status, approved_by, approved_at, remark, image, transaction_type, mode, bank_reference_no, payment_mode, deposit_bank, your_bank, created_at, updated_at, account_number, reject_note, deposit_account_no, deposit_ifsc_code, ifsc_code) FROM stdin;
11	127	104	10.0	\N	\N	\N	test	\N	UPI	credit	879879ds787878	\N	Axis	HDFC	2025-09-06 10:53:22.238745	2025-09-06 10:53:22.238745	\N	\N	\N	\N	\N
12	127	104	10.0	\N	\N	\N	test	\N	UPI	credit	879879ds787878	\N	Axis	HDFC	2025-09-06 10:58:12.306457	2025-09-06 10:58:12.306457	\N	\N	\N	\N	\N
13	127	104	10.0	\N	\N	\N	test	\N	UPI	credit	879879ds787878	\N	Axis	HDFC	2025-09-06 10:58:36.043983	2025-09-06 10:58:36.043983	\N	\N	\N	\N	\N
15	127	104	10.0	\N	\N	\N	bhej do bhai	null	CashInBank	credit	208987	\N	SBI	HDFC	2025-09-06 11:01:16.175689	2025-09-06 11:01:16.175689	\N	\N	\N	\N	\N
16	127	104	20.0	\N	\N	\N	de do na	null	NEFT	credit	43543	\N	SBI	SBI	2025-09-06 11:08:17.288251	2025-09-06 11:08:17.288251	\N	\N	\N	\N	\N
17	127	104	5.0	\N	\N	\N	dfgd	null	UPI	credit	454353435	\N	HDFC	ICICI	2025-09-06 11:10:11.793622	2025-09-06 11:10:11.793622	\N	\N	\N	\N	\N
18	127	104	20.0	\N	\N	\N	de do mera paisa	null	Cheque	credit	86876876	\N	SBI	HDFC	2025-09-06 11:15:13.014605	2025-09-06 11:15:13.014605	\N	\N	\N	\N	\N
19	127	104	40.0	\N	\N	\N		null	CashInBank	credit	45	\N	SBI	ICICI	2025-09-06 11:20:57.526698	2025-09-06 11:20:57.526698	\N	\N	\N	\N	\N
20	127	104	400.0	\N	\N	\N		null	CashInBank	credit	86876876	\N	HDFC	HDFC	2025-09-06 11:22:08.43994	2025-09-06 11:22:08.43994	\N	\N	\N	\N	\N
21	127	104	600.0	\N	\N	\N		null	Netbanking	credit	86876876	\N	SBI	SBI	2025-09-06 11:27:09.982909	2025-09-06 11:27:09.982909	\N	\N	\N	\N	\N
22	127	104	1.0	\N	\N	\N		null	Cash	credit	2332	\N	HDFC	SBI	2025-09-06 11:32:10.205525	2025-09-06 11:32:10.205525	\N	\N	\N	\N	\N
23	127	104	500.0	\N	\N	\N		null	Cheque	credit	897987	\N	HDFC	HDFC	2025-09-06 11:37:10.679613	2025-09-06 11:37:10.679613	\N	\N	\N	\N	\N
24	127	104	500.0	\N	\N	\N		null	Cheque	credit	897987	\N	HDFC	HDFC	2025-09-06 11:37:53.467712	2025-09-06 11:37:53.467712	\N	\N	\N	\N	\N
25	127	104	500.0	\N	\N	\N		null	Cheque	credit	897987	\N	HDFC	HDFC	2025-09-06 11:38:34.42233	2025-09-06 11:38:34.42233	\N	\N	\N	\N	\N
26	127	104	200.0	\N	\N	\N		null	CashInBank	credit	87	\N	HDFC	AXIS	2025-09-06 11:39:25.212643	2025-09-06 11:39:25.212643	\N	\N	\N	\N	\N
27	127	104	76.0	\N	\N	\N		null	NEFT	credit	769	\N	HDFC	ICICI	2025-09-06 11:57:13.457331	2025-09-06 11:57:13.457331	\N	\N	\N	\N	\N
28	127	104	300.0	\N	\N	\N		null	CashInBank	credit	34534	\N	HDFC	HDFC	2025-09-06 12:03:54.839562	2025-09-06 12:03:54.839562	\N	\N	\N	\N	\N
29	127	104	2.0	\N	\N	\N		null	Netbanking	credit	86876876	\N	HDFC	ICICI	2025-09-06 12:09:59.78103	2025-09-06 12:09:59.78103	\N	\N	\N	\N	\N
30	127	104	1.0	\N	\N	\N		null	CashInBank	credit	86876876	\N	HDFC	SBI	2025-09-06 12:14:14.926249	2025-09-06 12:14:14.926249	\N	\N	\N	\N	\N
32	127	104	31.0	\N	\N	\N	test	null	UPI	credit	ghhg566556	\N	HDFC	HDFC	2025-09-06 12:20:08.384143	2025-09-06 12:20:08.384143	\N	\N	\N	\N	\N
33	127	104	35.0	\N	\N	\N		null	Cheque	credit	89698	\N	HDFC	SBI	2025-09-06 12:25:32.369262	2025-09-06 12:25:32.369262	\N	\N	\N	\N	\N
34	127	104	70.0	\N	\N	\N		null	UPI	credit	233	\N	SBI	ICICI	2025-09-06 12:26:55.606828	2025-09-06 12:26:55.606828	\N	\N	\N	\N	\N
35	127	104	7.0	\N	\N	\N		null	UPI	credit	233	\N	SBI	ICICI	2025-09-06 12:28:15.177185	2025-09-06 12:28:15.177185	\N	\N	\N	\N	\N
39	127	104	93.0	\N	\N	\N		null	NEFT	credit	1	\N	SBI	SBI	2025-09-06 12:35:37.104368	2025-09-06 12:35:37.104368	\N	\N	\N	\N	\N
40	127	104	400.0	\N	\N	\N		null	CashInBank	credit	86876876	\N	HDFC	PNB	2025-09-06 12:36:21.959471	2025-09-06 12:36:21.959471	\N	\N	\N	\N	\N
43	127	104	100.0	\N	\N	\N		null	NEFT	credit	86876876	\N	SBI	HDFC	2025-09-06 12:52:53.423225	2025-09-06 12:52:53.423225	\N	\N	\N	\N	\N
45	127	104	100.0	\N	\N	\N		null	Cheque	credit	86876876	\N	SBI	AXIS	2025-09-06 13:02:08.8759	2025-09-06 13:02:08.8759	\N	\N	\N	\N	\N
46	127	104	1000.0	\N	\N	\N		null	CashInBank	credit	56757	\N	ICICI	AXIS	2025-09-08 04:47:39.042799	2025-09-08 04:47:39.042799	\N	\N	\N	\N	\N
47	127	104	100.0	\N	\N	\N		null	IMPS	credit	4534	\N	SBI	SBI	2025-09-08 05:38:42.852321	2025-09-08 05:38:42.852321	\N	\N	\N	\N	\N
48	139	\N	200.0	\N	\N	\N	malik	null	NEFT	credit	32444435	\N	SBI	HDFC	2025-09-08 05:43:00.558427	2025-09-08 05:43:00.558427	\N	\N	\N	\N	\N
49	139	104	299.0	\N	\N	\N	malik	null	NEFT	credit	32444435	\N	SBI	HDFC	2025-09-08 05:44:50.488068	2025-09-08 05:44:50.488068	\N	\N	\N	\N	\N
50	134	104	399.0	\N	\N	\N	test	null	NEFT	credit	100dsdddsds	\N	HDFC	ICICI	2025-09-08 06:37:14.65265	2025-09-08 06:37:14.65265	\N	\N	\N	\N	\N
51	134	104	100.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	SBI	2025-09-08 07:28:52.968781	2025-09-08 07:28:52.968781	\N	\N	\N	\N	\N
52	134	104	120.0	\N	\N	\N	test	null	NEFT	credit	100dsdddsds	\N	ICICI	HDFC	2025-09-08 07:45:11.344586	2025-09-08 07:45:11.344586	\N	\N	\N	\N	\N
57	139	104	997.0	\N	\N	\N	malik	null	Netbanking	credit	32444435	\N	HDFC	SBI	2025-09-08 12:31:35.781488	2025-09-08 12:31:35.781488	\N	\N	\N	\N	\N
58	139	104	500.0	\N	\N	\N	malik	null	Netbanking	credit	32444435	\N	SBI	SBI	2025-09-08 12:34:09.578595	2025-09-08 12:34:09.578595	\N	\N	\N	\N	\N
60	127	104	100.0	\N	\N	\N		null	Cash	credit	564	\N	SBI	SBI	2025-09-10 13:31:42.342144	2025-09-10 13:31:42.342144	\N	\N	\N	\N	\N
61	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 06:42:27.945305	2025-09-11 06:42:27.945305	\N	\N	\N	\N	\N
62	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 07:38:16.938037	2025-09-11 07:38:16.938037	\N	\N	\N	\N	\N
63	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 07:39:29.96736	2025-09-11 07:39:29.96736	\N	\N	\N	\N	\N
64	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 07:40:27.444735	2025-09-11 07:40:27.444735	\N	\N	\N	\N	\N
65	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 07:56:25.320924	2025-09-11 07:56:25.320924	\N	\N	\N	\N	\N
66	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 08:38:21.030052	2025-09-11 08:38:21.030052	\N	\N	\N	\N	\N
67	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 08:40:14.005162	2025-09-11 08:40:14.005162	\N	\N	\N	\N	\N
69	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 08:45:56.258823	2025-09-11 08:45:56.258823	\N	\N	\N	\N	\N
71	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 09:16:37.343503	2025-09-11 09:16:37.343503	\N	\N	\N	\N	\N
6	104	136	12.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	SBI	SBI	2025-09-06 09:24:59.568809	2025-09-12 12:43:28.294395	\N	\N	\N	\N	\N
9	104	136	20.0	success	\N	\N	test	\N	UPI	credit	hjhjhdjs766868	\N	SBI	AXIS	2025-09-06 09:57:23.541551	2025-09-12 12:43:28.296918	\N	\N	\N	\N	\N
73	127	104	10000.0	\N	\N	\N		null	UPI	credit	4565465465464564645	\N	SBI	SBI	2025-09-11 09:56:48.199583	2025-09-11 09:56:48.199583	\N	\N	\N	\N	\N
74	139	104	10000.0	\N	\N	\N		null	UPI	credit	32444435	\N	HDFC	ICICI	2025-09-11 09:56:48.428133	2025-09-11 09:56:48.428133	\N	\N	\N	\N	\N
75	127	104	1000.0	\N	\N	\N		null	Netbanking	credit	2	\N	HDFC	SBI	2025-09-11 09:59:40.800117	2025-09-11 09:59:40.800117	\N	\N	\N	\N	\N
76	139	104	90000.0	\N	\N	\N		null	Cheque	credit	32444435	\N	SBI	ICICI	2025-09-11 11:04:05.638344	2025-09-11 11:04:05.638344	\N	\N	\N	\N	\N
77	134	104	120.0	\N	\N	\N	test	null	UPI	credit	Upi79879897csd	\N	HDFC	ICICI	2025-09-11 12:55:29.635289	2025-09-11 12:55:29.635289	\N	\N	\N	\N	\N
79	139	104	333.0	\N	\N	\N		null	Cash	credit	32444435	\N	HDFC	HDFC	2025-09-11 14:12:28.311338	2025-09-11 14:12:28.311338	\N	\N	\N	\N	\N
90	139	104	44.0	\N	\N	\N		null	Cheque	credit	32444435	\N	HDFC	SBI	2025-09-12 10:56:50.797145	2025-09-12 10:56:50.797145	\N	\N	\N	\N	\N
91	127	104	2000.0	\N	\N	\N		null	Netbanking	credit	d	\N	SBI	SBI	2025-09-12 10:58:46.382606	2025-09-12 10:58:46.382606	\N	\N	\N	\N	\N
99	138	\N	100.0	pending	\N	\N		\N	IMPS	\N	87	\N	SBI	SBI	2025-09-12 12:06:33.52371	2025-09-12 12:06:33.52371	\N	\N	\N	\N	\N
31	104	136	30.0	success	\N	\N	test	\N	NEFT	credit	hjkh978787879879	\N	SBI	HDFC	2025-09-06 12:19:01.760776	2025-09-12 12:43:28.299106	\N	\N	\N	\N	\N
36	104	136	100.0	success	\N	\N	test	\N	UPI	credit	lkjdshd79887687	\N	SBI	SBI	2025-09-06 12:32:32.729136	2025-09-12 12:43:28.301199	\N	\N	\N	\N	\N
37	104	136	100.0	success	\N	\N	test	\N	NEFT	credit	jjdsh7686887	\N	SBI	SBI	2025-09-06 12:34:04.571712	2025-09-12 12:43:28.303474	\N	\N	\N	\N	\N
38	104	136	100.0	success	\N	\N	test	\N	UPI	credit	sdsdsds	\N	SBI	HDFC	2025-09-06 12:34:52.777219	2025-09-12 12:43:28.305685	\N	\N	\N	\N	\N
41	104	136	1000.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	HDFC	HDFC	2025-09-06 12:36:50.754006	2025-09-12 12:43:28.308021	\N	\N	\N	\N	\N
42	104	136	100.0	success	\N	\N	Test	\N	UPI	credit	jHJKJHH787987	\N	HDFC	PNB	2025-09-06 12:50:35.90369	2025-09-12 12:43:28.31011	\N	\N	\N	\N	\N
44	104	136	100.0	success	\N	\N	test	\N	UPI	credit	UPI95687586867	\N	SBI	SBI	2025-09-06 12:59:23.04227	2025-09-12 12:43:28.312366	\N	\N	\N	\N	\N
53	104	136	100.0	success	\N	\N	test	\N	NEFT	credit	33232332	\N	SBI	SBI	2025-09-08 07:53:10.183143	2025-09-12 12:43:28.314382	\N	\N	\N	\N	\N
54	104	136	100.0	success	\N	\N	test	\N	NEFT	credit	hjkh978787879879	\N	ICICI	HDFC	2025-09-08 08:30:37.275921	2025-09-12 12:43:28.316729	\N	\N	\N	\N	\N
55	104	136	100.0	success	\N	\N	test	\N	CashInBank	credit	hjkh9787878798792222	\N	ICICI	HDFC	2025-09-08 08:32:27.761322	2025-09-12 12:43:28.319255	\N	\N	\N	\N	\N
56	104	136	100.0	success	\N	\N	test	\N	UPI	credit	hjkh9787878798792222	\N	ICICI	ICICI	2025-09-08 08:33:58.913333	2025-09-12 12:43:28.321487	\N	\N	\N	\N	\N
59	104	136	1000.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	ICICI	ICICI	2025-09-08 13:22:27.727574	2025-09-12 12:43:28.323919	\N	\N	\N	\N	\N
68	104	136	300000.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	SBI	SBI	2025-09-11 08:41:07.372091	2025-09-12 12:43:28.327345	\N	\N	\N	\N	\N
70	104	136	1000.0	success	\N	\N	test	\N	UPI	credit	jjkjds89809	\N	SBI	HDFC	2025-09-11 09:16:03.652824	2025-09-12 12:43:28.33054	\N	\N	\N	\N	\N
72	104	136	100.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	HDFC	AXIS	2025-09-11 09:46:31.307035	2025-09-12 12:43:28.333577	\N	\N	\N	\N	\N
78	104	136	100.0	success	\N	\N	test	\N	UPI	credit	Appim77987n	\N	SBI	HDFC	2025-09-11 12:56:20.453078	2025-09-12 12:43:28.336067	\N	\N	\N	\N	\N
80	104	136	1089.0	success	\N	\N	test	\N	UPI	credit	SSid89897676	\N	HDFC	HDFC	2025-09-11 14:13:40.673541	2025-09-12 12:43:28.338282	\N	\N	\N	\N	\N
81	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	SBI	SBI	2025-09-12 10:33:14.196391	2025-09-12 12:43:28.340767	\N	\N	\N	\N	\N
82	104	136	5.0	success	\N	\N	test	\N	NEFT	\N	hjkh978787879879	\N	HDFC	HDFC	2025-09-12 10:35:42.102839	2025-09-12 12:43:28.343657	\N	\N	\N	\N	\N
83	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	HDFC	SBI	2025-09-12 10:36:44.718712	2025-09-12 12:43:28.346525	\N	\N	\N	\N	\N
84	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	SBI	HDFC	2025-09-12 10:39:31.020996	2025-09-12 12:43:28.3496	\N	\N	\N	\N	\N
85	104	136	1.0	success	\N	\N		\N	NEFT	\N	hjkh978787879879	\N	SBI	SBI	2025-09-12 10:42:38.385524	2025-09-12 12:43:28.352403	\N	\N	\N	\N	\N
86	104	136	3.0	success	\N	\N		\N	IMPS	\N	hjkh978787879879	\N	SBI	HDFC	2025-09-12 10:45:43.800779	2025-09-12 12:43:28.355145	\N	\N	\N	\N	\N
87	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	ICICI	AXIS	2025-09-12 10:48:09.017809	2025-09-12 12:43:28.357609	\N	\N	\N	\N	\N
88	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	HDFC	ICICI	2025-09-12 10:49:33.146204	2025-09-12 12:43:28.360077	\N	\N	\N	\N	\N
89	104	136	5.0	success	\N	\N	test	\N	CashInBank	\N	hjkh978787879879	\N	HDFC	SBI	2025-09-12 10:56:10.923195	2025-09-12 12:43:28.362274	\N	\N	\N	\N	\N
92	104	136	9.0	success	\N	\N	test	\N	NEFT	\N	33232332	\N	SBI	HDFC	2025-09-12 11:04:17.82122	2025-09-12 12:43:28.364573	\N	\N	\N	\N	\N
93	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	SBI	SBI	2025-09-12 11:07:46.064179	2025-09-12 12:43:28.36684	\N	\N	\N	\N	\N
94	104	136	5.0	success	\N	\N	test	\N	NEFT	\N	hjkh978787879879	\N	HDFC	HDFC	2025-09-12 11:09:37.755661	2025-09-12 12:43:28.368906	\N	\N	\N	\N	\N
95	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh9787878798792222	\N	HDFC	HDFC	2025-09-12 11:41:44.662777	2025-09-12 12:43:28.372248	\N	\N	\N	\N	\N
96	104	136	5.0	success	\N	\N	test	\N	UPI	\N	ddd	\N	HDFC	HDFC	2025-09-12 11:44:37.158235	2025-09-12 12:43:28.374441	\N	\N	\N	\N	\N
97	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	ICICI	HDFC	2025-09-12 11:46:17.530108	2025-09-12 12:43:28.376855	\N	\N	\N	\N	\N
100	104	136	5.0	success	\N	\N		\N	NEFT	\N	hjkh978787879879	\N	HDFC	HDFC	2025-09-12 12:07:09.153851	2025-09-12 12:43:28.379102	\N	\N	\N	\N	\N
101	138	136	100.0	success	\N	\N		\N	IMPS	\N	1	\N	SBI	SBI	2025-09-12 12:10:10.589275	2025-09-12 12:43:28.381597	\N	\N	\N	\N	\N
102	141	136	85.0	success	\N	\N	...	\N	UPI	\N	8888	\N	HDFC	HDFC	2025-09-12 12:11:31.792498	2025-09-12 12:43:28.383783	\N	\N	\N	\N	\N
103	141	136	90.0	success	\N	\N	mm	\N	Cash	\N	8888	\N	HDFC	AXIS	2025-09-12 12:41:03.003884	2025-09-12 12:43:28.385955	\N	\N	\N	\N	\N
104	141	136	100.0	pending	\N	\N	malik	\N	Cash	\N	8888	\N	HDFC	AXIS	2025-09-12 12:47:36.187494	2025-09-12 12:47:36.187494	\N	\N	\N	\N	\N
105	134	104	100.0	\N	\N	\N	test	null	NEFT	credit	Upi79879897csd	\N	SBI	HDFC	2025-09-15 17:29:52.85102	2025-09-15 17:29:52.85102	\N	\N	\N	\N	\N
106	127	104	50000.0	\N	\N	\N	ret	null	UPI	credit	34534	\N	HDFC	HDFC	2025-09-18 07:03:50.157983	2025-09-18 07:03:50.157983	\N	\N	\N	\N	\N
107	127	104	2000.0	\N	\N	\N	dfg	null	CashInBank	credit	345	\N	SBI	HDFC	2025-09-18 07:13:36.791823	2025-09-18 07:13:36.791823	\N	\N	\N	\N	\N
108	104	136	5000.0	pending	\N	\N	Adding funds via IMPS	base64-image-or-file-url	IMPS	fund	REF123456789	\N	HDFC Bank	ICICI Bank	2025-11-17 05:38:37.381261	2025-11-17 05:38:37.381261	123456789012	\N	\N	\N	\N
109	104	136	100.0	pending	\N	\N	dedo	\N	IMPS	fund	86876876	\N	Axis	SBI	2025-11-17 07:19:43.038443	2025-11-17 07:19:43.038443	779776876567576576	\N	\N	\N	\N
110	104	136	100.0	success	\N	\N	dedo	\N	IMPS	fund	86876876	\N	Axis	SBI	2025-11-17 07:19:56.29324	2025-11-20 07:37:18.39239	779776876567576576	\N	\N	\N	\N
111	139	104	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-20 08:49:59.696654	2025-11-20 08:49:59.696654	\N	\N	\N	\N	\N
112	139	104	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-20 08:50:07.590631	2025-11-20 08:50:07.590631	\N	\N	\N	\N	\N
118	139	104	1000.0	\N	\N	\N	\N	\N	credit	\N	REF123456	\N	HDFC Bank	ICICI Bank	2025-11-20 09:51:18.357788	2025-11-20 09:51:18.357788	\N	\N	\N	\N	\N
123	104	136	100.0	pending	\N	\N	plz dedo	\N	IMPS	fund	43543	\N	Axis	SBI	2025-11-20 11:44:38.854776	2025-11-20 11:44:38.854776	779776876567576576	\N	\N	\N	\N
124	104	136	100.0	pending	\N	\N	plz dedo	\N	IMPS	fund	43543	\N	Axis	SBI	2025-11-20 11:44:53.961234	2025-11-20 11:44:53.961234	779776876567576576	\N	\N	\N	\N
125	104	136	100.0	pending	\N	\N	plz dedo	\N	IMPS	fund	43543	\N	Axis	SBI	2025-11-20 11:45:05.835729	2025-11-20 11:45:05.835729	779776876567576576	\N	\N	\N	\N
126	104	136	100.0	pending	\N	\N	plz dedo	\N	IMPS	fund	43543	\N	Axis	SBI	2025-11-20 11:45:46.809058	2025-11-20 11:45:46.809058	779776876567576576	\N	\N	\N	\N
127	104	136	100.0	pending	\N	\N	45	\N	Cash	fund	86876876	\N	Axis	AXIS	2025-11-20 11:46:12.493231	2025-11-20 11:46:12.493231	779776876567576576	\N	\N	\N	\N
128	104	136	109.0	pending	\N	\N	dff	\N	CashInBank	fund	86876876	\N	Axis	HDFC	2025-11-20 11:46:44.51557	2025-11-20 11:46:44.51557	779776876567576576	\N	\N	\N	\N
129	104	136	109.0	pending	\N	\N	dff	\N	CashInBank	fund	86876876	\N	Axis	HDFC	2025-11-20 11:46:59.106506	2025-11-20 11:46:59.106506	779776876567576576	\N	\N	\N	\N
133	139	104	247.0	success	\N	\N	hiii	\N	imps	fund	44	\N	5	sbi	2025-11-20 12:21:24.360853	2025-11-21 06:03:14.357622	\N	\N	\N	\N	\N
134	104	136	111.0	pending	\N	\N		\N	IMPS	fund	86876876	\N	Axis	HDFC	2025-11-21 06:14:49.192253	2025-11-21 06:14:49.192253	779776876567576576	\N	\N	\N	\N
132	139	104	52.0	success	\N	\N	55555	\N	neft	fund	8755	\N	5	sbi	2025-11-20 12:15:14.534103	2025-11-21 06:22:46.010117	\N	\N	\N	\N	\N
131	104	136	676.0	rejected	104	2025-11-21 06:26:15.923408	dds	\N	UPI	fund	86876876	\N	Axis	HDFC	2025-11-20 11:49:09.764333	2025-11-21 06:26:15.925519	779776876567576576	nikal	\N	\N	\N
117	139	104	1000.0	rejected	104	2025-11-21 07:10:49.558027	\N	\N	credit	\N	REF123456	\N	HDFC Bank	ICICI Bank	2025-11-20 09:51:03.299687	2025-11-21 07:10:49.558578	\N	s	\N	\N	\N
114	139	104	1000.0	rejected	104	2025-11-21 06:36:35.343481	\N	\N	credit	\N	BRN123456	\N	HDFC Bank	SBI Bank	2025-11-20 08:54:55.512819	2025-11-21 06:36:35.34421	\N	e	\N	\N	\N
116	139	104	1000.0	success	\N	\N	\N	\N	credit	fund	BRN123456	\N	HDFC Bank	SBI Bank	2025-11-20 08:56:47.366876	2025-11-21 07:06:51.494837	\N	\N	\N	\N	\N
119	139	104	1000.0	rejected	104	2025-11-21 07:48:54.236857	\N	\N	credit	fund	REF123456	\N	HDFC Bank	ICICI Bank	2025-11-20 09:51:33.993931	2025-11-21 07:48:54.237633	\N	j	\N	\N	\N
113	139	104	1000.0	rejected	104	2025-11-21 07:11:20.126097	\N	\N	credit	\N	BRN123456	\N	HDFC Bank	SBI Bank	2025-11-20 08:52:47.779826	2025-11-21 07:11:20.126547	\N	1	\N	\N	\N
130	104	136	109.0	rejected	104	2025-11-21 07:13:07.467433	dff	\N	CashInBank	fund	86876876	\N	Axis	HDFC	2025-11-20 11:47:16.677366	2025-11-21 07:13:07.468015	779776876567576576	1	\N	\N	\N
120	139	104	2000.0	rejected	104	2025-11-21 07:43:13.742043	hi	\N	neft	\N	88888888	\N	5	sbi	2025-11-20 09:58:54.76747	2025-11-21 07:43:13.742505	\N	d	\N	\N	\N
122	139	104	300.0	success	\N	\N	uuiqui	\N	imps	fund	777777	\N	5	sbi	2025-11-20 10:06:15.584176	2025-11-21 07:44:14.568894	\N	\N	\N	\N	\N
121	139	104	2000.0	rejected	104	2025-11-21 07:52:06.342883	hi	\N	neft	fund	88888888	\N	5	sbi	2025-11-20 09:59:40.858795	2025-11-21 07:52:06.343383	\N	a	\N	\N	\N
115	139	104	1000.0	success	\N	\N	\N	\N	credit	fund	BRN123456	\N	HDFC Bank	SBI Bank	2025-11-20 08:56:38.752089	2025-11-21 10:11:03.950216	\N	\N	\N	\N	\N
98	139	104	85.0	rejected	104	2025-11-21 10:11:16.393192		null	Cash	credit	32444435	\N	SBI	ICICI	2025-09-12 12:05:31.001945	2025-11-21 10:11:16.393624	\N	w	\N	\N	\N
135	127	104	32.0	\N	\N	\N	dedo	\N	neft	fund	8978789	\N	5	sbi	2025-11-21 10:33:38.478658	2025-11-21 10:33:38.478658	\N	\N	\N	\N	\N
136	127	104	222.0	\N	\N	\N		\N	UPI	fund	87878798978	\N	HDFC Bank	SBI	2025-11-21 10:39:59.156349	2025-11-21 10:39:59.156349	\N	\N	\N	\N	\N
137	104	136	567.0	\N	\N	\N	\N	https://res.cloudinary.com/siddtec/image/upload/v1763722135/pxtg7wby2xiivqglimlo.png	dsds	fund	343434	\N	dssd	fsdf	2025-11-21 10:48:56.071919	2025-11-21 10:48:56.071919	\N	\N	\N	\N	\N
138	127	104	1212.0	\N	\N	\N	sda	\N	NEFT	fund	9878	\N	HDFC Bank	SBI	2025-11-21 10:55:30.179233	2025-11-21 10:55:30.179233	\N	\N	\N	\N	\N
139	127	104	1212.0	\N	\N	\N	sda	\N	NEFT	fund	9878	\N	HDFC Bank	SBI	2025-11-21 10:55:37.737552	2025-11-21 10:55:37.737552	\N	\N	\N	\N	\N
140	127	104	100.0	\N	\N	\N	fds	\N	NEFT	fund	2332	\N	HDFC Bank	ICICI	2025-11-21 11:07:27.084109	2025-11-21 11:07:27.084109	\N	\N	\N	\N	\N
141	127	104	600.0	\N	\N	\N	aaa	\N	Netbanking	fund	34534	\N	HDFC Bank	HDFC	2025-11-21 11:26:25.050729	2025-11-21 11:26:25.050729	\N	\N	\N	\N	\N
142	127	104	555.0	\N	\N	\N	ss	\N	NEFT	fund	8977	\N	5	HDFC	2025-11-21 11:31:49.22377	2025-11-21 11:31:49.22377	\N	\N	\N	\N	\N
143	127	104	555.0	\N	\N	\N	ss	\N	NEFT	fund	8977	\N	5	HDFC	2025-11-21 11:32:04.79385	2025-11-21 11:32:04.79385	\N	\N	\N	\N	\N
144	127	104	593.0	\N	\N	\N	ss	\N	IMPS	fund	43543	\N	HDFC Bank	SBI	2025-11-21 11:32:57.816084	2025-11-21 11:32:57.816084	\N	\N	\N	\N	\N
146	127	104	66.0	rejected	104	2025-11-21 13:13:38.148636	77	https://res.cloudinary.com/siddtec/image/upload/v1763725387/qespzpmuder6vlxh3usm.png	IMPS	fund	43543	\N	HDFC Bank	SBI	2025-11-21 11:43:07.470339	2025-11-21 13:13:38.149545	\N	q	\N	\N	\N
145	127	104	13.0	success	\N	\N	22	\N	IMPS	fund	22	\N	HDFC Bank	SBI	2025-11-21 11:35:59.897118	2025-11-21 13:14:35.937	\N	\N	\N	\N	\N
148	169	104	18.0	pending	\N	\N	bhbhm	\N	CashInBank	fund	88	\N	HDFC Bank	HDFC	2025-11-25 11:15:07.669155	2025-11-25 11:15:07.669155	123456789012	\N	\N	\N	\N
149	169	104	103.0	pending	\N	\N	56756	\N	UPI	fund	56676767	\N	HDFC Bank	ICICI	2025-11-26 07:08:01.413502	2025-11-26 07:08:01.413502	123456789012	\N	\N	\N	\N
147	170	169	58.0	rejected	169	2025-11-26 10:14:08.352595	hhhhh	https://res.cloudinary.com/siddtec/image/upload/v1764068960/ezveg3800tnsga1wuscg.jpg	NEFT	fund	78678	\N	State Bank of India	HDFC	2025-11-25 11:09:21.313239	2025-11-26 10:14:08.353231	\N	fake	\N	\N	\N
150	170	169	29.0	\N	\N	\N	sjeioeu	https://res.cloudinary.com/siddtec/image/upload/v1764152413/wynbz1bxqsak8lqeibnj.jpg	Cash	fund	5894375983	\N	State Bank of India	HDFC	2025-11-26 10:20:14.101307	2025-11-26 10:20:14.101307	\N	\N	\N	\N	\N
151	169	104	19.0	pending	\N	\N	njk	\N	UPI	fund	u8989080	\N	HDFC Bank	SBI	2025-11-26 10:24:03.645654	2025-11-26 10:24:03.645654	123456789012	\N	\N	\N	\N
152	170	169	20.0	pending	\N	\N	t876t788	https://res.cloudinary.com/siddtec/image/upload/v1764152735/y2lawtrg88qyccbtwffy.jpg	Netbanking	fund	gfhg	\N	State Bank of India	HDFC	2025-11-26 10:25:37.299687	2025-11-26 10:25:37.299687	\N	\N	\N	\N	\N
153	104	136	11.0	pending	\N	\N	saad	\N	IMPS	fund	96789	\N	Axis	HDFC	2025-11-26 10:31:41.816082	2025-11-26 10:31:41.816082	779776876567576576	\N	\N	\N	\N
154	170	169	19.0	pending	\N	\N	sndfjsdk	https://res.cloudinary.com/siddtec/image/upload/v1764154101/zrvkg0h9wwhfebnlesis.jpg	CashInBank	fund	389748932	\N	State Bank of India	ICICI	2025-11-26 10:48:22.348371	2025-11-26 10:48:22.348371	\N	\N	\N	\N	\N
155	170	169	101.0	pending	\N	\N	ghvhj	https://res.cloudinary.com/siddtec/image/upload/v1764156790/ogmdy2xpkaakgdla8n2r.jpg	IMPS	fund	57656567	\N	kotak mahindra	HDFC	2025-11-26 11:33:10.869349	2025-11-26 11:33:10.869349	\N	\N	\N	\N	\N
156	169	104	620.0	pending	\N	\N	fkjerbj	\N	Netbanking	fund	4757894375834	\N	HDFC Bank	AXIS	2025-11-26 12:28:29.608622	2025-11-26 12:28:29.608622	123456789012	\N	\N	\N	\N
157	174	169	200.0	pending	\N	\N	hwdjke	https://res.cloudinary.com/siddtec/image/upload/v1764161085/rconjnskn3olodcuxf8b.jpg	Cheque	fund	6234823949	\N	kotak mahindra	HDFC	2025-11-26 12:44:46.968637	2025-11-26 12:44:46.968637	\N	\N	\N	\N	\N
158	174	169	5000.0	pending	\N	\N	jhewjk	https://res.cloudinary.com/siddtec/image/upload/v1764161147/n5kczlnfqnuoohzuwymp.jpg	Netbanking	fund	623493264	\N	kotak mahindra	ICICI	2025-11-26 12:45:48.064614	2025-11-26 12:45:48.064614	\N	\N	\N	\N	\N
160	169	104	100.0	success	\N	\N	7ghj	\N	Netbanking	fund	y7y7y	\N	HDFC Bank	SBI	2025-11-26 12:58:34.614409	2025-11-26 12:58:51.313893	123456789012	\N	\N	\N	\N
159	174	169	99.0	success	\N	\N	jjnnjk	https://res.cloudinary.com/siddtec/image/upload/v1764161707/xpm4jruc8x05euhaps1o.jpg	UPI	fund	555	\N	State Bank of India	HDFC	2025-11-26 12:55:08.616837	2025-11-26 12:59:12.522881	\N	\N	\N	\N	\N
161	175	169	19.0	pending	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1764229080/qhwfs33jrmzrejgepu1i.jpg	Netbanking	fund	6778678	\N	kotak mahindra	SBI	2025-11-27 07:38:00.991865	2025-11-27 07:38:00.991865	\N	\N	\N	\N	\N
162	175	169	1.0	success	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1764229155/h2rudfdqxamefahsp0uk.jpg	Cash	fund	87778789	\N	ds fb sd	SBI	2025-11-27 07:39:16.199122	2025-11-27 07:39:32.909226	\N	\N	\N	\N	\N
163	169	104	10000.0	success	\N	\N	fyffhg	\N	NEFT	fund	ctgfgfg	\N	HDFC Bank	SBI	2025-11-27 08:47:38.427454	2025-11-27 08:50:02.428031	123456789012	\N	\N	\N	\N
164	176	104	11.0	success	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1765447200/brriw8oc9hwpwn77tvps.jpg	NEFT	fund	4324343454345	\N	HDFC Bank	SBI	2025-12-11 10:00:01.523561	2025-12-11 10:00:43.129608	\N	\N	\N	\N	\N
165	176	104	100.0	success	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1765455139/iuwdl4jhx6diuu6bunn3.jpg	Netbanking	fund	6666666666666788	\N	HDFC Bank	SBI	2025-12-11 12:12:19.780305	2025-12-11 12:12:37.4171	\N	\N	\N	\N	\N
166	177	104	10.0	success	\N	\N	hjhjj	https://res.cloudinary.com/siddtec/image/upload/v1765540418/jmxhlvmrgcosn7jw9vba.jpg	NEFT	fund	5425625245245245425	\N	HDFC Bank	HDFC	2025-12-12 11:53:39.839689	2025-12-12 11:54:13.17972	\N	\N	\N	\N	\N
167	127	104	120.0	pending	\N	\N	test	\N	NEFT	fund	100dsdddsds	\N	HDFC Bank	SBI	2025-12-13 09:07:49.176117	2025-12-13 09:07:49.176117	\N	\N	\N	\N	\N
168	104	136	10.0	pending	\N	\N		\N	Cheque	fund	4324343454345	\N	Axis	HDFC	2025-12-16 05:26:55.742194	2025-12-16 05:26:55.742194	779776876567576576	\N	\N	\N	\N
169	104	136	3.0	pending	\N	\N		\N	Netbanking	fund	6666666666666788	\N	Axis	HDFC	2025-12-16 06:11:54.448787	2025-12-16 06:11:54.448787	779776876567576576	\N	\N	\N	\N
170	104	136	5.0	pending	\N	\N		\N	Netbanking	fund	4324343454345	\N	Axis	HDFC	2025-12-16 06:21:26.851039	2025-12-16 06:21:26.851039	779776876567576576	\N	\N	\N	\N
171	104	136	6.0	pending	\N	\N		\N	NEFT	fund	4324343454345	\N	Axis	HDFC	2025-12-16 06:22:08.041546	2025-12-16 06:22:08.041546	779776876567576576	\N	\N	\N	\N
172	104	136	2.0	pending	\N	\N		\N	UPI	fund	4324343454345	\N	Axis	HDFC	2025-12-16 06:23:33.91004	2025-12-16 06:23:33.91004	779776876567576576	\N	\N	\N	\N
173	104	136	8.0	pending	\N	\N		\N	CashInBank	fund	4324343454345	\N	Axis	SBI	2025-12-16 06:28:03.135171	2025-12-16 06:28:03.135171	779776876567576576	\N	\N	\N	\N
174	139	104	2.0	pending	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1765867511/bkijkiftkxdbvyp2fz5q.png	UPI	fund	436432648732647	\N	HDFC Bank	ICICI	2025-12-16 06:45:12.388451	2025-12-16 06:45:12.388451	\N	\N	\N	\N	\N
175	139	104	4.0	pending	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1765868286/yuwoo8v68uumv33asgc3.png	NEFT	fund	3243454345546546	\N	HDFC Bank	ICICI	2025-12-16 06:58:07.455297	2025-12-16 06:58:07.455297	\N	\N	\N	\N	\N
176	139	104	2.0	pending	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1765868443/vpfjrxpto08tr6q3rwp7.png	UPI	fund	454586954685	\N	HDFC Bank	HDFC	2025-12-16 07:00:44.04457	2025-12-16 07:00:44.04457	\N	\N	\N	\N	\N
177	104	136	3.0	pending	\N	\N		\N	CashInBank	fund	4324343454345	\N	Axis	HDFC	2025-12-17 12:53:35.467604	2025-12-17 12:53:35.467604	779776876567576576	\N	\N	\N	\N
178	178	103	200.0	pending	\N	\N	nfmgnf	https://res.cloudinary.com/siddtec/image/upload/v1766051979/e1cosm613ikfvr3jreza.png	UPI	fund	34723947237	\N	state bank of india	HDFC	2025-12-18 09:59:40.43253	2025-12-18 09:59:40.43253	\N	\N	\N	\N	\N
179	103	\N	700.0	pending	\N	\N		\N	Netbanking	fund	4324343454345	\N	Axis	ICICI	2025-12-18 10:01:39.796022	2025-12-18 10:01:39.796022	779776876567576576	\N	\N	\N	\N
180	127	104	10.0	pending	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1766134682/kwrsypibpgkykxxxdc1y.png	CashInBank	fund	7656756	\N	HDFC Bank	SBI	2025-12-19 08:58:03.066599	2025-12-19 08:58:03.066599	\N	\N	\N	\N	\N
181	127	104	20.0	pending	\N	\N	\N	https://res.cloudinary.com/siddtec/image/upload/v1766139921/cfcel8lrq8dgodcbif32.png	NEFT	fund	857485743	\N	HDFC Bank	SBI	2025-12-19 10:25:21.544126	2025-12-19 10:25:21.544126	\N	\N	\N	\N	\N
182	127	104	20.0	pending	\N	\N	\N	https://res.cloudinary.com/siddtec/image/upload/v1766139930/vg0tpzst3gnp03jj2nl4.png	NEFT	fund	857485743	\N	HDFC Bank	SBI	2025-12-19 10:25:31.37215	2025-12-19 10:25:31.37215	\N	\N	\N	\N	\N
183	127	104	20.0	pending	\N	\N	\N	https://res.cloudinary.com/siddtec/image/upload/v1766139943/ujyjyvdtukd1ufrrd9yz.png	NEFT	fund	857485743	\N	HDFC Bank	SBI	2025-12-19 10:25:44.174838	2025-12-19 10:25:44.174838	\N	\N	\N	\N	\N
184	127	104	12.0	pending	\N	\N	\N	https://res.cloudinary.com/siddtec/image/upload/v1766140060/yc3pok9fwvexhczrlxc0.png	NEFT	fund	58437583457	\N	HDFC Bank	SBI	2025-12-19 10:27:40.812298	2025-12-19 10:27:40.812298	\N	\N	\N	\N	\N
185	127	104	12.0	pending	\N	\N	\N	https://res.cloudinary.com/siddtec/image/upload/v1766140070/jjywrggmztovxuqjxyrd.png	NEFT	fund	58437583457	\N	HDFC Bank	SBI	2025-12-19 10:27:51.657635	2025-12-19 10:27:51.657635	\N	\N	\N	\N	\N
186	127	104	7.0	pending	\N	\N	\N	https://res.cloudinary.com/siddtec/image/upload/v1766140173/sk8spnqpqfv9fzftdytm.png	NEFT	fund	786786	\N	HDFC Bank	AXIS	2025-12-19 10:29:34.274748	2025-12-19 10:29:34.274748	\N	\N	\N	\N	\N
187	127	104	9.0	pending	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1766140225/asjqlgt017kbrrbpgikp.png	UPI	fund	9843243276439	\N	HDFC Bank	HDFC	2025-12-19 10:30:26.011638	2025-12-19 10:30:26.011638	\N	\N	\N	\N	\N
188	127	104	19.0	pending	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1766140641/lotop1o6z7buqljx1f3s.png	Cash	fund	7867689	\N	HDFC Bank	ICICI	2025-12-19 10:37:22.155918	2025-12-19 10:37:22.155918	\N	\N	\N	\N	\N
189	127	104	45.0	pending	\N	\N	yyuiyu	https://res.cloudinary.com/siddtec/image/upload/v1766141558/uzhf3mqnccofj3tfxxqt.png	Netbanking	fund	8767678978	\N	HDFC Bank	SBI	2025-12-19 10:52:38.616691	2025-12-19 10:52:38.616691	\N	\N	\N	\N	\N
190	127	104	10.0	pending	\N	\N	erggf	https://res.cloudinary.com/siddtec/image/upload/v1766143497/rp3stlpc5akpemkmwsss.png	Netbanking	fund	t54657y	\N	HDFC Bank	ICICI	2025-12-19 11:24:58.580833	2025-12-19 11:24:58.580833	\N	\N	\N	\N	\N
191	127	104	10.0	pending	\N	\N	erggf	https://res.cloudinary.com/siddtec/image/upload/v1766143541/za3dt59zcbzgxxoqii5q.png	Netbanking	fund	t54657y	\N	HDFC Bank	ICICI	2025-12-19 11:25:42.312284	2025-12-19 11:25:42.312284	\N	\N	\N	\N	\N
192	127	104	8.0	pending	\N	\N	4t32yewgr	https://res.cloudinary.com/siddtec/image/upload/v1766143661/bj1ggihpg8jvjedsmiyw.png	Netbanking	fund	2374632974	\N	HDFC Bank	AXIS	2025-12-19 11:27:42.290114	2025-12-19 11:27:42.290114	\N	\N	\N	\N	\N
193	127	104	8.0	pending	\N	\N	4t32yewgr	https://res.cloudinary.com/siddtec/image/upload/v1766143747/vqeb5vl6cunbqmuaz4tt.png	Netbanking	fund	2374632974	\N	HDFC Bank	AXIS	2025-12-19 11:29:07.733416	2025-12-19 11:29:07.733416	\N	\N	\N	\N	\N
194	127	104	99.0	pending	\N	\N	jhhjbh	\N	Netbanking	fund	76567565	\N	HDFC Bank	AXIS	2025-12-19 13:03:30.355383	2025-12-19 13:03:30.355383	\N	\N	\N	\N	\N
195	127	104	21.0	pending	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1766149449/cg6hbqlr8erqttc0werd.png	NEFT	fund	767867867678	\N	HDFC Bank	ICICI	2025-12-19 13:04:09.747293	2025-12-19 13:04:09.747293	\N	\N	\N	\N	\N
196	104	136	101.0	pending	\N	\N		\N	Cash	fund	4324343776556	\N	Axis	ICICI	2025-12-24 05:08:45.755301	2025-12-24 05:08:45.755301	779776876567576576	\N	\N	\N	\N
197	104	136	11.0	pending	\N	\N		\N	UPI	fund	5425625245245245425	\N	Axis	HDFC	2025-12-24 05:10:55.139346	2025-12-24 05:10:55.139346	779776876567576576	\N	\N	\N	\N
198	127	104	100.0	pending	\N	\N	xczzc	\N	IMPS	fund	87097797	\N	HDFC Bank	Kylee Pope	2026-05-26 05:05:17.551124	2026-05-26 05:05:17.551124	9924000100007471	\N	\N	HDFC0001234	UTIB0002193
199	181	136	500.0	success	\N	\N	test Remark	https://res.cloudinary.com/siddtec/image/upload/v1779785096/rgww1czoqaugttkdhk28.png	IMPS	fund	Upi79879897csd	\N	Axis	Axis	2026-05-26 08:44:57.088663	2026-05-26 09:49:35.824436	9924000100007471	\N	779776876567576576	AXIS89SX	UTIB0002193
\.


--
-- Data for Name: leads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.leads (id, name, mobile, email, address, director, loan_type, loan_ac, total_outstanding, borrower_info, emi_amount, service_id, user_id, adhaar_image, pan_image, notice_image, check_image, address_proof, amount, status, account_number, date, image, area, bank_name, branch_address, officer_name, designation, borrower_name, co_borrower, loan_account_number, borrower_address, outstanding_amount, npa_date, notice_132_date, expiry_date, property_address, survey_number, north_boundary, south_boundary, east_boundary, west_boundary, possession_type, possession_date, possession_place, notice_issue_date, issue_place, pending_message, reject_message, ca_id, lawyer_id, document_permission_status, lead_status, befor_sumbit_mca_status, document_status, payment_status, review_status, step_status, service_type, lead_ref_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: leave_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.leave_requests (id, user_id, parent_id, start_date, end_date, total_days, reason, status, reject_note, approve_note, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refund_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refund_requests (id, user_id, transaction_id, parent_id, refund_id, refund_type, amount, reason, status, admin_note, processed_at, processed_by, attachment_url, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, title, created_at, updated_at) FROM stdin;
5	retailer	2025-08-27 05:50:00.645062	2025-08-27 05:50:00.645062
6	master	2025-08-27 05:50:06.010086	2025-08-27 05:50:06.010086
7	dealer	2025-08-27 05:50:11.616887	2025-08-27 05:50:11.616887
9	admin	2025-08-29 16:08:23.094433	2025-08-29 16:08:23.094433
10	superadmin	2025-09-04 07:51:41.59287	2025-09-04 07:51:41.59287
11	customer	2025-09-19 06:29:00.92764	2025-09-19 06:29:00.92764
13	staff	2026-05-26 07:40:26.248232	2026-05-26 07:40:26.248232
\.


--
-- Data for Name: salaries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.salaries (id, user_id, month, year, total_days, leave_days, working_days, per_day_salary, total_salary, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20250823112328
20250823114245
20250823114620
20250827114427
20250830054607
20250830055652
20250830112731
20250830113511
20250901104230
20250902060329
20250902095209
20250902111639
20250903064239
20250903092958
20250903113045
20250904180442
20250905054404
20250905091838
20250906054117
20250906061333
20250908095353
20250909105011
20250912074440
20250915085332
20250915104110
20250915105112
20250916103844
20250917051630
20250919105236
20250923062805
20250925072715
20250926121901
20251010060013
20251011052949
20251113101952
20251113102030
20251115120451
20251115193302
20251117053814
20251117085937
20251119055655
20251120110753
20251126060343
20251211101745
20251219053609
20251219053722
20251219053801
20251222084332
20251224083746
20251224180904
20251225183900
20251226052106
20251227064454
20251230055303
20251230081735
20251230083122
20251231084313
20251231084502
20260102101032
20260102133455
20260103084751
20260105063942
20260105093316
20260106063747
20260113044636
20260113065943
20260120101555
20260120114440
20260121095929
20260523061132
20260523061234
20260523061534
20260523061912
20260525105222
20260601072517
20260625094006
20260704084007
20260711115411
20260714102435
20260717114052
20260723112745
20260724090012
20260725092103
20260727110146
20260804122844
20260806100606
20260806184955
\.


--
-- Data for Name: schemes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schemes (id, scheme_name, scheme_type, commision_rate, created_at, updated_at, user_id) FROM stdin;
5	Gold	Flat	10.0	2025-08-30 07:44:33.414877	2025-08-30 07:44:33.414877	\N
17	Platinam	Percentage	7.0	2025-09-15 18:36:21.455747	2025-09-15 18:36:21.455747	\N
16	Silver	Percentage	6.0	2025-09-15 18:36:11.457301	2025-11-15 12:00:30.943099	\N
19	\N	\N	\N	2025-11-15 19:34:57.619592	2025-11-15 19:34:57.619592	\N
20	sliver	\N	10.0	2025-11-15 19:35:54.849035	2025-11-15 19:35:54.849035	104
23	test 1	Monthly	5.0	2025-11-16 17:03:57.51534	2025-11-16 18:06:35.681142	104
31	gold	Flat	10.0	2025-11-19 05:46:26.548194	2025-11-19 05:46:26.548194	103
32	ghhjhj don	Percentage	6.0	2025-11-25 05:34:17.138872	2025-11-25 07:03:51.421169	169
34	manikant	Flat	20.8	2025-11-25 07:50:16.810368	2025-11-25 08:32:13.749434	169
35	pritesh 	Percentage	2.0	2025-11-26 05:08:23.126186	2025-11-26 05:08:23.126186	169
36	Silver	Percentage	10.0	2025-11-26 06:27:00.634958	2025-11-26 06:27:00.634958	136
37	gold	Percentage	10.0	2025-11-26 07:00:26.768295	2025-11-26 07:00:26.768295	169
38	aamir khan	Percentage	12.0	2025-11-26 08:49:55.130407	2025-11-26 08:49:55.130407	169
39	aleem	Flat	10.0	2025-11-27 06:31:59.0641	2025-11-27 12:28:34.61249	169
30	platinum	Flat	10.0	2025-11-17 12:06:56.424561	2025-12-11 09:02:04.670505	104
42	mani	Percentage	\N	2025-12-25 06:29:23.174007	2025-12-25 06:29:23.174007	104
41	gold 	Flat	10.0	2025-12-12 09:16:22.886437	2025-12-27 10:17:34.969999	104
44	QUICK CRED PLATINUM ''MASTER''	Percentage	100.0	2026-05-26 12:49:09.146625	2026-05-26 12:49:09.146625	181
45	QUICK CRED GOLD ''DEALAR''	Percentage	100.0	2026-05-26 12:51:03.968545	2026-05-26 12:51:03.968545	181
46	QUICK CRED SILVER''DISTRIBUTOR''	Percentage	100.0	2026-05-26 12:51:50.379314	2026-05-26 12:52:41.280068	181
40	Gold Superadmin	Percentage	12.0	2025-11-27 17:32:24.922382	2026-05-26 13:23:12.345735	136
21	Gold Admin	Flat	10.0	2025-11-15 19:36:03.77389	2026-05-27 04:51:34.5114	104
\.


--
-- Data for Name: service_product_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_product_items (id, service_product_id, name, oprator_type, status, created_at, updated_at, operator_id) FROM stdin;
34	11	Airtel Prepaid	\N	\N	2026-05-26 13:24:16.548281	2026-05-26 13:24:16.548281	1
35	11	Jio Prepaid	\N	\N	2026-05-26 13:26:24.087426	2026-05-26 13:26:24.087426	90
36	11	Vi Prepaid	\N	\N	2026-05-26 13:27:45.003333	2026-05-26 13:27:45.003333	400
37	11	BSNL  Prepaid	\N	\N	2026-05-26 13:28:56.793465	2026-05-26 13:28:56.793465	5
38	13	Dish TV	\N	\N	2026-05-28 05:59:22.875656	2026-05-28 05:59:22.875656	16
39	13	BIG TV DTH	\N	\N	2026-05-28 06:02:59.872984	2026-05-28 06:02:59.872984	17
40	13	Tata Sky	\N	\N	2026-05-28 06:04:20.172042	2026-05-28 06:04:20.172042	20
\.


--
-- Data for Name: service_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_products (id, company_name, admin_commission, master_commission, dealer_commission, retailer_commission, category_id, created_at, updated_at) FROM stdin;
6	Water Bill	\N	\N	\N	\N	14	2025-09-09 05:04:17.791811	2025-09-09 05:04:17.791811
11	Mobile Recharge	\N	\N	\N	\N	15	2025-09-09 13:01:30.906028	2025-09-09 13:01:30.906028
12	Broadband Recharge	\N	\N	\N	\N	15	2025-09-09 13:01:45.694013	2025-09-09 13:01:45.694013
13	DTH Recharge	\N	\N	\N	\N	15	2025-09-09 13:01:56.85302	2025-09-09 13:01:56.85302
14	Loan EMI Payment	\N	\N	\N	\N	16	2025-09-09 13:02:59.61586	2025-09-09 13:02:59.61586
15	FASTag Recharge	\N	\N	\N	\N	16	2025-09-09 13:03:13.656487	2025-09-09 13:03:13.656487
16	Google Play Recharge	\N	\N	\N	\N	16	2025-09-09 13:03:29.658199	2025-09-09 13:03:29.658199
17	Credit Card Bill Payment	\N	\N	\N	\N	16	2025-09-09 13:03:41.353764	2025-09-09 13:03:41.353764
18	Rent Bill Payment	\N	\N	\N	\N	16	2025-09-09 13:03:53.033764	2025-09-09 13:03:53.033764
19	Municipal Tax	\N	\N	\N	\N	17	2025-09-09 13:04:34.037688	2025-09-09 13:04:34.037688
20	Society Maintenance	\N	\N	\N	\N	17	2025-09-09 13:04:45.989233	2025-09-09 13:04:45.989233
21	Traffic Challan	\N	\N	\N	\N	17	2025-09-09 13:04:59.070005	2025-09-09 13:04:59.070005
22	Education Fee	\N	\N	\N	\N	17	2025-09-09 13:05:11.874499	2025-09-09 13:05:11.874499
23	OTT Subscription	\N	\N	\N	\N	18	2025-09-09 13:05:50.521149	2025-09-09 13:05:50.521149
8	Electricity Bill	\N	\N	\N	\N	14	2025-09-09 12:59:13.972532	2025-09-10 06:05:59.00958
10	Gas Bill	\N	\N	\N	\N	14	2025-09-09 13:00:21.120867	2025-09-10 06:06:26.645656
24	test	\N	\N	\N	\N	20	2025-11-18 07:50:15.223698	2025-11-18 07:50:15.223698
25	Google Play Recharge	\N	\N	\N	\N	16	2025-12-27 12:38:34.575689	2025-12-27 12:38:34.575689
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, title, status, created_at, updated_at, logo, "position") FROM stdin;
2	Insurance	\N	2025-08-30 11:30:35.42947	2025-09-08 09:23:54.613638	\N	\N
13	Investment	\N	2025-09-08 09:24:30.191817	2025-09-08 09:24:30.191817	\N	\N
8	Electric Vehicle	\N	2025-09-02 10:32:29.211247	2025-09-10 05:35:38.826592	\N	\N
7	BBPS	\N	2025-09-02 10:32:03.5864	2025-09-10 05:37:38.66016	\N	1
1	Travel & Stay	\N	2025-08-30 11:29:51.960729	2025-09-10 05:37:57.448955	\N	2
4	Loan & credit	\N	2025-08-30 11:31:03.70829	2025-09-10 05:38:12.295214	\N	3
15	DMT	\N	2025-09-19 14:19:31.086059	2025-09-19 14:19:31.086059	\N	\N
18	AEPS	\N	2025-12-22 08:36:40.885558	2025-12-22 08:36:40.885558	\N	\N
\.


--
-- Data for Name: support_tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.support_tickets (id, user_id, ticket_number, full_name, email, service_type, reference_id, subject, description, status, status_updated_at, resolution_note, resolved_at, assigned_agent_id, attachment_url, parent_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (id, title, description, priority, status, task_status, deadline, user_id, department_id, assigned_to, pending_note, approved_note, note, lead_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: transaction_commissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaction_commissions (id, transaction_id, user_id, role, commission_amount, created_at, updated_at, service_product_item_id) FROM stdin;
1	262	104	0	6.0	2025-09-17 06:54:00.756407	2025-09-17 06:54:00.756407	\N
2	262	136	0	6.0	2025-09-17 06:54:00.777619	2025-09-17 06:54:00.777619	\N
3	262	134	0	3.0	2025-09-17 06:54:00.794945	2025-09-17 06:54:00.794945	\N
4	263	104	0	10.0	2025-09-17 07:20:05.692672	2025-09-17 07:20:05.692672	\N
5	263	136	0	10.0	2025-09-17 07:20:05.712628	2025-09-17 07:20:05.712628	\N
7	264	104	0	10.0	2025-09-17 07:22:58.442122	2025-09-17 07:22:58.442122	\N
8	264	136	0	10.0	2025-09-17 07:22:58.467338	2025-09-17 07:22:58.467338	\N
10	265	104	0	10.0	2025-09-17 07:23:39.619173	2025-09-17 07:23:39.619173	\N
11	265	136	0	10.0	2025-09-17 07:23:39.636901	2025-09-17 07:23:39.636901	\N
13	266	104	0	10.0	2025-09-17 07:25:57.985627	2025-09-17 07:25:57.985627	\N
14	266	136	0	10.0	2025-09-17 07:25:58.002815	2025-09-17 07:25:58.002815	\N
16	267	104	0	10.0	2025-09-17 07:27:40.882781	2025-09-17 07:27:40.882781	\N
17	267	136	0	10.0	2025-09-17 07:27:40.898656	2025-09-17 07:27:40.898656	\N
18	267	139	0	5.0	2025-09-17 07:27:40.910141	2025-09-17 07:27:40.910141	\N
19	268	104	0	10.0	2025-09-17 07:54:09.168493	2025-09-17 07:54:09.168493	\N
20	268	136	0	10.0	2025-09-17 07:54:09.1875	2025-09-17 07:54:09.1875	\N
22	269	104	0	10.0	2025-09-17 07:55:10.736533	2025-09-17 07:55:10.736533	\N
23	269	136	0	10.0	2025-09-17 07:55:10.752645	2025-09-17 07:55:10.752645	\N
25	270	104	0	0.0	2025-09-17 08:33:26.721564	2025-09-17 08:33:26.721564	\N
26	270	136	0	0.0	2025-09-17 08:33:26.737724	2025-09-17 08:33:26.737724	\N
28	271	104	0	2.0	2025-09-17 08:33:45.043765	2025-09-17 08:33:45.043765	\N
29	271	136	0	2.0	2025-09-17 08:33:45.063137	2025-09-17 08:33:45.063137	\N
31	272	104	0	2.0	2025-09-17 08:44:53.688615	2025-09-17 08:44:53.688615	\N
32	272	136	0	2.0	2025-09-17 08:44:53.711011	2025-09-17 08:44:53.711011	\N
34	274	104	0	2.0	2025-09-17 08:48:03.659955	2025-09-17 08:48:03.659955	\N
35	274	136	0	2.0	2025-09-17 08:48:03.68063	2025-09-17 08:48:03.68063	\N
37	275	104	0	6.0	2025-09-17 08:49:14.119937	2025-09-17 08:49:14.119937	\N
38	275	136	0	6.0	2025-09-17 08:49:14.13562	2025-09-17 08:49:14.13562	\N
40	276	104	0	6.0	2025-09-17 08:51:14.266306	2025-09-17 08:51:14.266306	\N
41	276	136	0	6.0	2025-09-17 08:51:14.280459	2025-09-17 08:51:14.280459	\N
43	277	104	0	0.0	2025-09-17 08:51:57.637777	2025-09-17 08:51:57.637777	\N
44	277	136	0	0.0	2025-09-17 08:51:57.649785	2025-09-17 08:51:57.649785	\N
46	278	104	0	3.0	2025-09-17 08:53:05.45421	2025-09-17 08:53:05.45421	\N
47	278	136	0	3.0	2025-09-17 08:53:05.47256	2025-09-17 08:53:05.47256	\N
49	279	104	0	2.92	2025-09-17 08:56:17.167034	2025-09-17 08:56:17.167034	\N
50	279	136	0	2.92	2025-09-17 08:56:17.182747	2025-09-17 08:56:17.182747	\N
51	279	139	0	2.92	2025-09-17 08:56:17.202606	2025-09-17 08:56:17.202606	\N
52	280	104	0	3.0	2025-09-17 08:57:43.980662	2025-09-17 08:57:43.980662	\N
53	280	136	0	3.0	2025-09-17 08:57:43.995718	2025-09-17 08:57:43.995718	\N
54	280	139	0	3.0	2025-09-17 08:57:44.0074	2025-09-17 08:57:44.0074	\N
55	281	104	0	0.15	2025-09-17 09:19:00.942087	2025-09-17 09:19:00.942087	\N
56	281	136	0	0.15	2025-09-17 09:19:00.955257	2025-09-17 09:19:00.955257	\N
58	282	104	0	4.0	2025-09-17 09:35:50.951673	2025-09-17 09:35:50.951673	\N
59	282	136	0	4.0	2025-09-17 09:35:50.966139	2025-09-17 09:35:50.966139	\N
61	283	104	0	0.1	2025-09-17 09:46:34.636874	2025-09-17 09:46:34.636874	\N
62	283	136	0	0.1	2025-09-17 09:46:34.651838	2025-09-17 09:46:34.651838	\N
64	284	104	0	1.0	2025-09-17 09:48:16.290699	2025-09-17 09:48:16.290699	\N
65	284	136	0	1.0	2025-09-17 09:48:16.304674	2025-09-17 09:48:16.304674	\N
67	285	104	0	6.0	2025-09-17 10:13:05.975461	2025-09-17 10:13:05.975461	\N
68	285	136	0	2.0	2025-09-17 10:13:06.005328	2025-09-17 10:13:06.005328	\N
70	286	104	0	1.0	2025-09-17 10:26:43.718438	2025-09-17 10:26:43.718438	\N
71	286	136	0	2.0	2025-09-17 10:26:43.732116	2025-09-17 10:26:43.732116	\N
73	295	104	0	6.0	2025-09-17 10:41:26.698608	2025-09-17 10:41:26.698608	\N
74	295	136	0	39.0	2025-09-17 10:41:26.743935	2025-09-17 10:41:26.743935	\N
76	296	104	0	0.1	2025-09-17 10:41:58.377241	2025-09-17 10:41:58.377241	\N
77	296	136	0	1.1	2025-09-17 10:41:58.472987	2025-09-17 10:41:58.472987	\N
79	297	104	0	1.2	2025-09-17 10:42:40.042242	2025-09-17 10:42:40.042242	\N
80	297	136	0	13.2	2025-09-17 10:42:40.060887	2025-09-17 10:42:40.060887	\N
82	308	104	0	6.0	2025-09-17 10:51:05.249987	2025-09-17 10:51:05.249987	\N
83	308	136	0	39.0	2025-09-17 10:51:05.274124	2025-09-17 10:51:05.274124	\N
85	309	104	0	0.0	2025-09-17 10:51:19.648853	2025-09-17 10:51:19.648853	\N
86	309	136	0	1.0	2025-09-17 10:51:19.666491	2025-09-17 10:51:19.666491	\N
88	310	104	0	0.12	2025-09-17 10:51:49.518206	2025-09-17 10:51:49.518206	\N
89	310	136	0	1.32	2025-09-17 10:51:49.538305	2025-09-17 10:51:49.538305	\N
91	311	104	0	1.0	2025-09-17 10:52:17.985026	2025-09-17 10:52:17.985026	\N
92	311	136	0	6.5	2025-09-17 10:52:18.004836	2025-09-17 10:52:18.004836	\N
94	312	104	0	6.0	2025-09-17 10:54:47.916788	2025-09-17 10:54:47.916788	\N
95	312	136	0	39.0	2025-09-17 10:54:47.947326	2025-09-17 10:54:47.947326	\N
97	313	104	0	0.02	2025-09-17 10:57:09.382441	2025-09-17 10:57:09.382441	\N
98	313	136	0	0.03	2025-09-17 10:57:09.405376	2025-09-17 10:57:09.405376	\N
100	314	104	0	0.02	2025-09-17 10:58:01.855614	2025-09-17 10:58:01.855614	\N
101	314	136	0	0.13	2025-09-17 10:58:01.879188	2025-09-17 10:58:01.879188	\N
103	315	104	0	0.02	2025-09-17 10:59:57.700488	2025-09-17 10:59:57.700488	\N
104	315	136	0	0.03	2025-09-17 10:59:57.722951	2025-09-17 10:59:57.722951	\N
106	316	104	0	6.0	2025-09-17 11:00:17.232575	2025-09-17 11:00:17.232575	\N
107	316	136	0	9.0	2025-09-17 11:00:17.258883	2025-09-17 11:00:17.258883	\N
109	317	104	0	2.0	2025-09-17 11:26:43.776033	2025-09-17 11:26:43.776033	\N
110	317	136	0	14.0	2025-09-17 11:26:43.797815	2025-09-17 11:26:43.797815	\N
112	318	104	0	0.02	2025-09-17 11:36:04.071622	2025-09-17 11:36:04.071622	\N
113	318	136	0	0.03	2025-09-17 11:36:04.108124	2025-09-17 11:36:04.108124	\N
115	319	104	0	4.0	2025-09-17 11:37:06.531907	2025-09-17 11:37:06.531907	\N
116	319	136	0	6.0	2025-09-17 11:37:06.562225	2025-09-17 11:37:06.562225	\N
118	320	104	0	4.0	2025-09-17 11:37:27.303787	2025-09-17 11:37:27.303787	\N
119	320	136	0	6.0	2025-09-17 11:37:27.328214	2025-09-17 11:37:27.328214	\N
121	321	104	0	1.0	2025-09-17 11:39:20.123529	2025-09-17 11:39:20.123529	\N
122	321	136	0	7.000000000000001	2025-09-17 11:39:20.143977	2025-09-17 11:39:20.143977	\N
124	322	104	0	2.0	2025-09-17 11:41:47.533451	2025-09-17 11:41:47.533451	\N
125	322	136	0	3.0	2025-09-17 11:41:47.557659	2025-09-17 11:41:47.557659	\N
127	323	104	0	1.0	2025-09-17 11:43:19.851087	2025-09-17 11:43:19.851087	\N
128	323	136	0	7.000000000000001	2025-09-17 11:43:19.873797	2025-09-17 11:43:19.873797	\N
130	324	104	0	2.0	2025-09-17 11:48:12.240287	2025-09-17 11:48:12.240287	\N
131	324	136	0	3.0	2025-09-17 11:48:12.257577	2025-09-17 11:48:12.257577	\N
133	325	104	0	0.0	2025-09-17 12:28:54.99915	2025-09-17 12:28:54.99915	\N
134	325	136	0	10.0	2025-09-17 12:28:55.021218	2025-09-17 12:28:55.021218	\N
136	326	104	0	16.0	2025-09-17 12:29:36.361306	2025-09-17 12:29:36.361306	\N
137	326	136	0	-6.0	2025-09-17 12:29:36.383947	2025-09-17 12:29:36.383947	\N
139	327	104	0	16.0	2025-09-17 12:31:10.374482	2025-09-17 12:31:10.374482	\N
140	327	136	0	-6.0	2025-09-17 12:31:10.392562	2025-09-17 12:31:10.392562	\N
142	328	104	0	8.0	2025-09-17 12:32:22.411307	2025-09-17 12:32:22.411307	\N
143	328	136	0	-3.0	2025-09-17 12:32:22.427943	2025-09-17 12:32:22.427943	\N
145	329	104	0	2.0	2025-09-17 13:07:40.865449	2025-09-17 13:07:40.865449	\N
146	329	136	0	3.0	2025-09-17 13:07:40.888348	2025-09-17 13:07:40.888348	\N
148	330	104	0	0.0	2025-09-17 13:21:12.860413	2025-09-17 13:21:12.860413	\N
149	330	136	0	10.0	2025-09-17 13:21:12.878353	2025-09-17 13:21:12.878353	\N
151	331	104	0	2.0	2025-09-17 13:21:37.314623	2025-09-17 13:21:37.314623	\N
152	331	136	0	14.0	2025-09-17 13:21:37.332832	2025-09-17 13:21:37.332832	\N
154	332	104	0	2.0	2025-09-17 13:27:11.719489	2025-09-17 13:27:11.719489	\N
155	332	136	0	3.0	2025-09-17 13:27:11.741367	2025-09-17 13:27:11.741367	\N
157	333	104	0	2.0	2025-09-17 13:32:55.565135	2025-09-17 13:32:55.565135	\N
158	333	136	0	3.0	2025-09-17 13:32:55.609415	2025-09-17 13:32:55.609415	\N
160	334	104	0	1.0	2025-09-17 13:56:34.172706	2025-09-17 13:56:34.172706	\N
161	334	136	0	7.000000000000001	2025-09-17 13:56:34.190328	2025-09-17 13:56:34.190328	\N
163	335	104	0	2.0	2025-09-17 13:57:11.859187	2025-09-17 13:57:11.859187	\N
164	335	136	0	3.0	2025-09-17 13:57:11.874827	2025-09-17 13:57:11.874827	\N
166	336	104	0	8.0	2025-09-18 06:55:53.734859	2025-09-18 06:55:53.734859	\N
167	336	136	0	2.0	2025-09-18 06:55:53.754771	2025-09-18 06:55:53.754771	\N
169	338	104	0	15.92	2025-09-18 07:17:06.607021	2025-09-18 07:17:06.607021	\N
170	338	136	0	3.98	2025-09-18 07:17:06.629304	2025-09-18 07:17:06.629304	\N
172	339	104	0	0.08	2025-09-18 07:23:23.786791	2025-09-18 07:23:23.786791	\N
173	339	136	0	-0.03	2025-09-18 07:23:23.805711	2025-09-18 07:23:23.805711	\N
175	340	104	0	0.08	2025-09-18 07:24:08.937225	2025-09-18 07:24:08.937225	\N
176	340	136	0	0.02	2025-09-18 07:24:08.960801	2025-09-18 07:24:08.960801	\N
178	341	104	0	0.0	2025-09-18 07:33:40.693861	2025-09-18 07:33:40.693861	\N
179	341	136	0	0.02	2025-09-18 07:33:40.715084	2025-09-18 07:33:40.715084	\N
181	342	104	0	0.03	2025-09-18 07:34:19.089978	2025-09-18 07:34:19.089978	\N
182	342	136	0	0.02	2025-09-18 07:34:19.114597	2025-09-18 07:34:19.114597	\N
184	343	104	0	0.03	2025-09-18 07:36:21.401638	2025-09-18 07:36:21.401638	\N
185	343	136	0	0.02	2025-09-18 07:36:21.433107	2025-09-18 07:36:21.433107	\N
187	344	104	0	6.0	2025-09-18 07:50:43.364086	2025-09-18 07:50:43.364086	\N
188	344	136	0	4.0	2025-09-18 07:50:43.384716	2025-09-18 07:50:43.384716	\N
190	345	104	0	0.0	2025-09-18 08:37:43.526667	2025-09-18 08:37:43.526667	\N
191	345	136	0	10.0	2025-09-18 08:37:43.546197	2025-09-18 08:37:43.546197	\N
192	345	139	0	0.0	2025-09-18 08:37:43.560503	2025-09-18 08:37:43.560503	\N
193	346	104	0	3.0	2025-09-18 11:23:48.971227	2025-09-18 11:23:48.971227	\N
194	346	136	0	2.0	2025-09-18 11:23:49.018126	2025-09-18 11:23:49.018126	\N
196	347	104	0	0.0	2025-09-18 13:10:04.678112	2025-09-18 13:10:04.678112	\N
197	347	136	0	15.0	2025-09-18 13:10:04.699788	2025-09-18 13:10:04.699788	\N
198	347	139	0	0.0	2025-09-18 13:10:04.71781	2025-09-18 13:10:04.71781	\N
974	681	181	\N	0.1539	2026-05-27 13:28:37.673591	2026-05-27 13:28:37.673591	35
975	682	104	\N	1.9359	2026-06-11 09:58:26.697682	2026-06-11 09:58:26.697682	35
976	683	104	\N	1.9359	2026-06-17 07:50:22.513303	2026-06-17 07:50:22.513303	35
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, tx_id, operator, transaction_type, account_or_mobile, amount, status, user_id, created_at, updated_at, service_product_id, consumer_name, subscriber_or_vc_number, bill_no, landline_no, std_code, tid, tds, sender_id, payment_mode_desc, totalamount, status_text, txstatus_desc, commission, mobile, vehicle_no, card_number) FROM stdin;
128	TXN756047	Airtel	ONLINE	7056858674	3.0	SUCCESS	127	2025-09-08 10:50:32.396033	2025-09-08 10:50:32.396033	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1	TXN281668	Jio	Mobile Recharge	8967896789	400.0	\N	118	2025-09-03 12:05:03.351194	2025-09-08 10:22:52.2069	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
56	TXN259615	Jio	ONLINE	9845634853	299.0	SUCCESS	127	2025-09-04 10:57:47.23236	2025-09-08 10:22:52.221127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
57	TXN625882	Jio	ONLINE	8458975789	299.0	SUCCESS	127	2025-09-04 11:01:24.17657	2025-09-08 10:22:52.223234	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
68	TXN648821	Jio	ONLINE	9987575469	299.0	SUCCESS	127	2025-09-04 13:21:22.687494	2025-09-08 10:22:52.225411	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
69	TXN627123	Jio	ONLINE	8786756756	299.0	SUCCESS	127	2025-09-04 14:00:45.73664	2025-09-08 10:22:52.227873	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
70	TXN895988	Jio	ONLINE	7656756565	199.0	SUCCESS	127	2025-09-04 14:01:34.089607	2025-09-08 10:22:52.230946	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
71	TXN862023	Jio	Mobile Recharge	9009090909	399.0	SUCCESS	142	2025-09-04 18:43:16.937956	2025-09-08 10:22:52.233913	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
72	TXN635460	Jio	Mobile Recharge	9009090909	399.0	SUCCESS	142	2025-09-04 18:46:40.329555	2025-09-08 10:22:52.237142	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
73	TXN343801	Jio	Mobile Recharge	9009090922	399.0	SUCCESS	142	2025-09-04 18:53:20.244303	2025-09-08 10:22:52.24002	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
74	TXN346260	Jio	Mobile Recharge	9009090922	399.0	SUCCESS	127	2025-09-04 18:54:51.550782	2025-09-08 10:22:52.242907	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
75	TXN711768	Jio	Mobile Recharge	9009090922	399.0	SUCCESS	127	2025-09-04 18:57:00.347102	2025-09-08 10:22:52.24524	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
76	TXN506209	Vi	ONLINE	9239878327	229.0	SUCCESS	139	2025-09-05 05:44:18.037868	2025-09-08 10:22:52.247392	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
77	TXN674407	Jio	ONLINE	9887734764	199.0	SUCCESS	139	2025-09-05 05:48:02.704505	2025-09-08 10:22:52.249639	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
78	TXN424671	Jio	ONLINE	9877636355	199.0	SUCCESS	139	2025-09-05 06:23:03.721722	2025-09-08 10:22:52.251834	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
79	TXN276375	Airtel	ONLINE	9999999998	399.0	SUCCESS	139	2025-09-05 06:25:10.37026	2025-09-08 10:22:52.254192	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
80	TXN644975	BSNL	ONLINE	9878378237	397.0	SUCCESS	139	2025-09-05 06:28:47.145921	2025-09-08 10:22:52.25682	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
81	TXN257987	Jio	ONLINE	9238942783	199.0	SUCCESS	139	2025-09-05 06:30:14.234533	2025-09-08 10:22:52.259246	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
82	TXN900769	BSNL	ONLINE	9857894576	397.0	SUCCESS	127	2025-09-05 07:13:50.99573	2025-09-08 10:22:52.261821	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
83	TXN524375	Jio	Mobile Recharge	9009090922	50.0	SUCCESS	127	2025-09-05 08:41:22.391336	2025-09-08 10:22:52.26518	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
84	TXN857294	Jio	Mobile Recharge	9009090922	50.0	SUCCESS	127	2025-09-05 08:42:16.040326	2025-09-08 10:22:52.268759	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
85	TXN204140	Jio	Mobile Recharge	9009090922	50.0	SUCCESS	127	2025-09-05 08:44:43.684339	2025-09-08 10:22:52.27196	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
86	TXN537108	Jio	Mobile Recharge	9009090922	50.0	SUCCESS	127	2025-09-05 08:45:03.448304	2025-09-08 10:22:52.27508	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
87	TXN464003	Jio	ONLINE	0878756854	50.0	SUCCESS	127	2025-09-05 08:45:52.606187	2025-09-08 10:22:52.277363	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
88	TXN222500	Jio	ONLINE	0576075896	100.0	SUCCESS	127	2025-09-05 08:46:34.81119	2025-09-08 10:22:52.279392	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
89	TXN662309	Vi	ONLINE	0960975609	379.0	SUCCESS	127	2025-09-05 08:55:37.184347	2025-09-08 10:22:52.281628	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
90	TXN447288	Airtel	ONLINE	7897485675	21.0	SUCCESS	127	2025-09-05 08:58:47.425191	2025-09-08 10:22:52.284238	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
91	TXN661745	Jio	ONLINE	9840675867	199.0	SUCCESS	127	2025-09-05 09:23:34.62912	2025-09-08 10:22:52.286774	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
92	TXN436882	Jio	ONLINE	8945867586	50.0	SUCCESS	127	2025-09-05 09:28:11.394245	2025-09-08 10:22:52.28987	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
93	TXN394010	BSNL	ONLINE	7684567857	149.0	SUCCESS	127	2025-09-05 09:39:07.585305	2025-09-08 10:22:52.293139	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
94	TXN108180	Airtel	ONLINE	9075867546	20.0	SUCCESS	127	2025-09-05 09:49:19.078264	2025-09-08 10:22:52.296696	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
95	TXN115835	Airtel	ONLINE	5654645645	2.0	SUCCESS	127	2025-09-05 11:15:30.230462	2025-09-08 10:22:52.30065	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
96	TXN494233	Jio	ONLINE	9789787878	50.0	SUCCESS	127	2025-09-05 11:16:31.28945	2025-09-08 10:22:52.303791	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
97	TXN618429	Airtel	ONLINE	9856846785	20.0	SUCCESS	127	2025-09-05 11:18:47.089867	2025-09-08 10:22:52.30624	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
98	TXN592478	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:24:44.197048	2025-09-08 10:22:52.308538	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
99	TXN482133	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:24:48.92322	2025-09-08 10:22:52.312191	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
100	TXN787813	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:24:55.301585	2025-09-08 10:22:52.314931	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
101	TXN930654	Vi	ONLINE	0945609576	10.0	SUCCESS	127	2025-09-05 11:25:44.790708	2025-09-08 10:22:52.317497	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
102	TXN385095	Vi	ONLINE	0875867567	400.0	SUCCESS	127	2025-09-05 11:26:16.087155	2025-09-08 10:22:52.319957	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
103	TXN334195	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:33:22.569956	2025-09-08 10:22:52.3223	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
104	TXN338812	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:34:24.48861	2025-09-08 10:22:52.324545	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
105	TXN269233	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:34:34.120231	2025-09-08 10:22:52.327183	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
106	TXN846137	Vi	ONLINE	7858967856	249.0	SUCCESS	127	2025-09-05 12:07:38.333002	2025-09-08 10:22:52.330655	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
107	TXN190902	Airtel	ONLINE	0878586666	87.0	SUCCESS	127	2025-09-05 12:20:42.904552	2025-09-08 10:22:52.333906	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
108	TXN169040	Jio	ONLINE	8708578954	87.0	SUCCESS	127	2025-09-05 12:21:36.303358	2025-09-08 10:22:52.33662	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
109	TXN496480	Airtel	ONLINE	0707098787	11.0	SUCCESS	127	2025-09-05 12:22:13.879889	2025-09-08 10:22:52.339104	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
110	TXN810013	Jio	ONLINE	9895671000	20.0	SUCCESS	127	2025-09-05 12:47:27.214822	2025-09-08 10:22:52.341523	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
111	TXN641850	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 13:06:22.936565	2025-09-08 10:22:52.344146	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
112	TXN912535	Airtel	ONLINE	9745489679	6.0	SUCCESS	127	2025-09-05 13:13:12.180993	2025-09-08 10:22:52.347472	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
113	TXN231637	Airtel	ONLINE	8798586488	399.0	SUCCESS	127	2025-09-05 13:16:28.43975	2025-09-08 10:22:52.353644	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
114	TXN229026	Airtel	ONLINE	8979897565	296.0	SUCCESS	127	2025-09-05 13:34:07.647398	2025-09-08 10:22:52.356519	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
115	TXN832761	Airtel	ONLINE	9998899988	5.0	SUCCESS	127	2025-09-06 11:16:32.272829	2025-09-08 10:22:52.359376	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
116	TXN475640	BSNL	ONLINE	0970870709	99.0	SUCCESS	127	2025-09-06 12:37:36.255575	2025-09-08 10:22:52.364047	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
117	TXN658998	Airtel	ONLINE	8798768967	194.0	SUCCESS	127	2025-09-06 13:03:10.251816	2025-09-08 10:22:52.367709	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
118	TXN762371	Jio	ONLINE	7867867856	299.0	SUCCESS	127	2025-09-08 04:46:48.019377	2025-09-08 10:22:52.370379	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
119	TXN431538	Airtel	ONLINE	8779878989	39.0	SUCCESS	127	2025-09-08 06:25:19.941011	2025-09-08 10:22:52.372862	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
120	TXN815653	Jio	ONLINE	9809809898	299.0	SUCCESS	134	2025-09-08 06:38:39.303612	2025-09-08 10:22:52.375543	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
121	TXN470060	Jio	ONLINE	9887273276	199.0	SUCCESS	139	2025-09-08 06:42:13.18747	2025-09-08 10:22:52.377878	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
122	TXN819087	Airtel	ONLINE	9843847847	50.0	SUCCESS	139	2025-09-08 06:48:08.879054	2025-09-08 10:22:52.380177	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
123	TXN620063	Airtel	ONLINE	9879879879	50.0	SUCCESS	134	2025-09-08 09:43:13.55077	2025-09-08 10:22:52.382613	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
124	TXN463554	Airtel	ONLINE	9098097798	70.0	SUCCESS	134	2025-09-08 09:43:30.569204	2025-09-08 10:22:52.385305	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
125	TXN854120	Jio	Mobile Recharge	9009090922	2.0	SUCCESS	134	2025-09-08 10:00:26.922384	2025-09-08 10:22:52.38799	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
126	TXN914289	Jio	ONLINE	0934085758	199.0	SUCCESS	127	2025-09-08 10:11:49.967456	2025-09-08 10:22:52.39063	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
140	TXN535305	Vi	ONLINE	2434343432	1.0	SUCCESS	134	2025-09-08 11:33:49.07642	2025-09-08 11:33:49.07642	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
141	TXN355074	Airtel	ONLINE	0987086566	20.0	SUCCESS	127	2025-09-08 12:27:39.957225	2025-09-08 12:27:39.957225	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
142	TXN151842	Vi	ONLINE	8750675867	10.0	SUCCESS	127	2025-09-08 13:14:56.993997	2025-09-08 13:14:56.993997	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
143	TXN553175	Jio	ONLINE	0857067456	10.0	SUCCESS	127	2025-09-08 13:21:49.664094	2025-09-08 13:21:49.664094	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
144	TXN234735	Airtel	ONLINE	8658567567	20.0	SUCCESS	127	2025-09-09 05:18:48.394867	2025-09-09 05:18:48.394867	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
145	TXN532198	Airtel	ONLINE	8956754765	399.0	SUCCESS	127	2025-09-09 05:24:22.449339	2025-09-09 05:24:22.449339	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
146	TXN869761	Airtel	ONLINE	8098098098	1.0	SUCCESS	134	2025-09-09 06:18:01.443742	2025-09-09 06:18:01.443742	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
147	TXN882975	Airtel	ONLINE	0988098098	1.0	SUCCESS	134	2025-09-09 06:23:20.171762	2025-09-09 06:23:20.171762	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
148	TXN588595	Jio	ONLINE	5645654645	1.0	SUCCESS	127	2025-09-09 06:23:42.38084	2025-09-09 06:23:42.38084	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
149	TXN474624	Airtel	ONLINE	5645645645	1.0	SUCCESS	127	2025-09-09 06:24:17.013129	2025-09-09 06:24:17.013129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
150	TXN259000	Airtel	ONLINE	4567546456	24.0	SUCCESS	127	2025-09-09 06:26:29.10355	2025-09-09 06:26:29.10355	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
151	TXN112533	Jio	ONLINE	7685763476	2.0	SUCCESS	127	2025-09-09 06:48:28.538808	2025-09-09 06:48:28.538808	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
152	TXN166438	Jio	ONLINE	8768456758	11.0	SUCCESS	127	2025-09-09 06:52:25.368241	2025-09-09 06:52:25.368241	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
153	TXN421433	Jio	ONLINE	9090998778	1.0	SUCCESS	127	2025-09-09 08:05:14.835729	2025-09-09 08:05:14.835729	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
154	TXN989068	Vi	ONLINE	8873743264	229.0	SUCCESS	139	2025-09-09 09:00:04.916378	2025-09-09 09:00:04.916378	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
155	TXN252515	Jio	ONLINE	7676767676	10.0	SUCCESS	127	2025-09-09 13:10:00.134472	2025-09-09 13:10:00.134472	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
156	TXN713549	Jio	ONLINE	9978787676	299.0	SUCCESS	139	2025-09-09 13:11:04.824057	2025-09-09 13:11:04.824057	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
157	TXN249751	Jio	ONLINE	7697677698	199.0	SUCCESS	127	2025-09-09 13:54:42.225975	2025-09-09 13:54:42.225975	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
158	TXN120346	Jio	ONLINE	9034984798	299.0	SUCCESS	139	2025-09-09 13:55:11.517	2025-09-09 13:55:11.517	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
159	TXN685312	Jio	ONLINE	8969767687	20.0	SUCCESS	127	2025-09-09 13:56:46.749001	2025-09-09 13:56:46.749001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
160	TXN501124	Jio	ONLINE	7897787787	1.0	SUCCESS	134	2025-09-09 14:12:39.059523	2025-09-09 14:12:39.059523	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
161	TXN639201	Jio	ONLINE	9879779787	12.0	SUCCESS	134	2025-09-09 16:38:51.449622	2025-09-09 16:38:51.449622	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
162	TXN248001	Jio	Mobile Recharge	787987778787	2.0	SUCCESS	134	2025-09-10 05:47:38.238908	2025-09-10 05:47:38.238908	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
163	TXN124168	Jio	Mobile Recharge	787987778787	2.0	SUCCESS	134	2025-09-10 05:53:43.171169	2025-09-10 05:53:43.171169	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
164	TXN668614	Jio	Mobile Recharge	787987778787	2.0	SUCCESS	134	2025-09-10 06:51:23.336111	2025-09-10 06:51:23.336111	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
165	TXN294955	Airtel	ONLINE	0978907898	2.0	SUCCESS	127	2025-09-10 06:57:55.166792	2025-09-10 06:57:55.166792	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
166	TXN212475	Jio	Mobile Recharge	787987778787	2.0	SUCCESS	134	2025-09-10 07:04:24.891643	2025-09-10 07:04:24.891643	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
167	TXN581251	Jio	Mobile Recharge	787987778787	0.5	SUCCESS	134	2025-09-10 07:54:37.976986	2025-09-10 07:54:37.976986	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
168	TXN879441	Jio	Mobile Recharge	89898877878	0.5	SUCCESS	134	2025-09-10 08:45:06.920316	2025-09-10 08:45:06.920316	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
169	TXN933030	Jio	Mobile Recharge	89898877878	0.5	SUCCESS	134	2025-09-10 08:52:55.857724	2025-09-10 08:52:55.857724	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
170	TXN931271	Jio	Mobile Recharge	89898877878	0.5	SUCCESS	134	2025-09-10 09:13:14.279833	2025-09-10 09:13:14.279833	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
171	TXN734167	Jio	Mobile Recharge	89898877878	0.5	SUCCESS	134	2025-09-10 09:34:46.744849	2025-09-10 09:34:46.744849	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
172	TXN755654	Jio	Mobile Recharge	89898977777	0.5	SUCCESS	134	2025-09-10 10:17:43.769943	2025-09-10 10:17:43.769943	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
173	TXN814227	Jio	Mobile Recharge	90900990909	0.5	SUCCESS	134	2025-09-10 10:38:27.425217	2025-09-10 10:38:27.425217	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
174	TXN228474	Airtel	\N	0988088098	2.0	SUCCESS	134	2025-09-10 12:21:21.90358	2025-09-10 12:21:21.90358	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
175	TXN203982	Airtel	\N	8765645645	22.0	SUCCESS	127	2025-09-10 12:29:34.652818	2025-09-10 12:29:34.652818	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
176	TXN889945	Jio	\N	7586758896	11.0	SUCCESS	127	2025-09-10 12:57:43.454721	2025-09-10 12:57:43.454721	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
177	TXN575336	Airtel	\N	7586758675	11.0	SUCCESS	127	2025-09-10 12:59:29.002969	2025-09-10 12:59:29.002969	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
178	TXN615156	Airtel	\N	9869869869	10.0	SUCCESS	127	2025-09-10 13:07:20.884092	2025-09-10 13:07:20.884092	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
179	TXN844985	Jio	\N	7697698689	8.0	SUCCESS	127	2025-09-10 13:11:29.503531	2025-09-10 13:11:29.503531	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
180	TXN869309	Jio	\N	5464646464	7.0	SUCCESS	127	2025-09-11 05:41:06.551229	2025-09-11 05:41:06.551229	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
181	TXN378844	Jio	\N	5765756756	1.0	SUCCESS	127	2025-09-11 06:51:20.978864	2025-09-11 06:51:20.978864	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
182	TXN328446	Jio	\N	5745756746	4.0	SUCCESS	127	2025-09-11 07:00:30.9748	2025-09-11 07:00:30.9748	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
183	TXN101178	Jio	\N	8768969869	1.0	SUCCESS	127	2025-09-11 07:03:06.255595	2025-09-11 07:03:06.255595	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
184	TXN613670	Jio	\N	7458697560	1.0	SUCCESS	127	2025-09-11 07:10:00.37594	2025-09-11 07:10:00.37594	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
185	TXN285126	Jio	\N	5464564556	1.0	SUCCESS	127	2025-09-11 07:26:50.256178	2025-09-11 07:26:50.256178	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
186	TXN451227	Vi	\N	7664567458	1.0	SUCCESS	127	2025-09-11 07:31:13.033061	2025-09-11 07:31:13.033061	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
187	TXN786844	Jio	\N	8798796986	1.0	SUCCESS	127	2025-09-11 07:35:38.454368	2025-09-11 07:35:38.454368	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
188	TXN450168	Jio	\N	7438578347	1.0	SUCCESS	127	2025-09-11 07:40:28.559514	2025-09-11 07:40:28.559514	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
189	TXN141978	Jio	\N	8756875465	1.0	SUCCESS	127	2025-09-11 07:41:36.377643	2025-09-11 07:41:36.377643	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
190	TXN730547	Jio	\N	9070979709	1.0	SUCCESS	127	2025-09-11 07:54:59.352708	2025-09-11 07:54:59.352708	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
191	TXN939768	Jio	\N	9070979709	1.0	SUCCESS	127	2025-09-11 07:56:05.821882	2025-09-11 07:56:05.821882	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
192	TXN391513	Jio	\N	9070979709	1.0	SUCCESS	127	2025-09-11 07:56:24.619032	2025-09-11 07:56:24.619032	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
193	TXN492587	Jio	\N	5565464654	1.0	SUCCESS	127	2025-09-11 08:39:25.227632	2025-09-11 08:39:25.227632	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
194	TXN397223	Jio	\N	5565464654	1.0	SUCCESS	127	2025-09-11 08:41:28.840778	2025-09-11 08:41:28.840778	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
195	TXN808869	Jio	\N	8787897878	1.0	SUCCESS	127	2025-09-11 08:44:47.812085	2025-09-11 08:44:47.812085	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
196	TXN873058	Jio	\N	8787987987	1.0	SUCCESS	127	2025-09-11 08:46:06.238012	2025-09-11 08:46:06.238012	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
197	TXN676243	Jio	\N	8787987987	1.0	SUCCESS	127	2025-09-11 08:46:33.148985	2025-09-11 08:46:33.148985	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
198	TXN521952	Jio	\N	8787987987	1.0	SUCCESS	127	2025-09-11 08:50:27.020339	2025-09-11 08:50:27.020339	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
199	TXN884495	Jio	\N	9076095807	1.0	SUCCESS	127	2025-09-11 08:51:39.268617	2025-09-11 08:51:39.268617	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
200	TXN257119	Airtel	RECHARGE	5687567567	1.0	SUCCESS	127	2025-09-11 10:58:28.876792	2025-09-11 10:58:28.876792	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
201	TXN205641	Jio	RECHARGE	6756757575	1.0	SUCCESS	127	2025-09-11 11:05:38.886778	2025-09-11 11:05:38.886778	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
202	TXN467878	Vi	RECHARGE	8778789789	19.0	SUCCESS	127	2025-09-11 12:29:53.212623	2025-09-11 12:29:53.212623	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
203	TXN482109	Jio	RECHARGE	6574657574	111.0	SUCCESS	127	2025-09-11 12:55:41.412242	2025-09-11 12:55:41.412242	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
204	TXN764000	Jio	RECHARGE	8769697677	1.0	SUCCESS	127	2025-09-11 13:33:13.689056	2025-09-11 13:33:13.689056	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
205	TXN722700	Airtel	RECHARGE	5475675757	249.0	SUCCESS	127	2025-09-11 13:51:22.509643	2025-09-11 13:51:22.509643	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
206	TXN948113	Airtel	RECHARGE	3453453535	11.0	SUCCESS	127	2025-09-12 07:06:53.361775	2025-09-12 07:06:53.361775	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
207	TXN668264	Jio	RECHARGE	8578978968	10.0	SUCCESS	127	2025-09-12 12:52:30.369447	2025-09-12 12:52:30.369447	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
208	TXN354579	Jio	RECHARGE	7999998897	78.0	SUCCESS	127	2025-09-15 05:32:09.762417	2025-09-15 05:32:09.762417	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
209	TXN134956	Airtel	RECHARGE	7989798789	249.0	SUCCESS	134	2025-09-15 17:31:19.254578	2025-09-15 17:31:19.254578	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
210	TXN722079	Jio	RECHARGE	9877987987	199.0	SUCCESS	134	2025-09-15 17:32:14.626233	2025-09-15 17:32:14.626233	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
211	TXN461921	Jio	Mobile Recharge	90900990909	0.5	SUCCESS	134	2025-09-16 11:49:52.933333	2025-09-16 11:49:52.933333	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
212	TXN787631	Jio	Mobile Recharge	90900990909	0.5	SUCCESS	134	2025-09-16 11:51:46.530596	2025-09-16 11:51:46.530596	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
214	TXN737928	Jio	Mobile Recharge	90900990909	0.5	SUCCESS	134	2025-09-16 12:14:40.142912	2025-09-16 12:14:40.142912	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
215	TXN317855	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:15:04.40333	2025-09-16 12:15:04.40333	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
216	TXN300830	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:21:57.758636	2025-09-16 12:21:57.758636	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
217	TXN645259	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:26:38.88992	2025-09-16 12:26:38.88992	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
218	TXN339807	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:34:46.87571	2025-09-16 12:34:46.87571	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
219	TXN398013	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:36:23.533953	2025-09-16 12:36:23.533953	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
222	TXN239080	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:47:18.865088	2025-09-16 12:47:18.865088	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
223	TXN519196	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:48:08.002008	2025-09-16 12:48:08.002008	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
224	TXN709457	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:49:56.624078	2025-09-16 12:49:56.624078	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
225	TXN613455	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 13:23:35.873272	2025-09-16 13:23:35.873272	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
226	TXN837690	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 13:25:41.610225	2025-09-16 13:25:41.610225	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
227	TXN226369	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-16 13:26:10.871114	2025-09-16 13:26:10.871114	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
228	TXN735894	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-16 13:26:53.523648	2025-09-16 13:26:53.523648	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
229	TXN800767	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-16 13:28:18.75625	2025-09-16 13:28:18.75625	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
230	TXN794781	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-16 13:30:11.323746	2025-09-16 13:30:11.323746	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
231	TXN534069	Airtel	RECHARGE	0567506756	300.0	SUCCESS	127	2025-09-16 13:44:22.113514	2025-09-16 13:44:22.113514	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
233	TXN713846	Jio	Mobile Recharge	90900990909	56.0	SUCCESS	127	2025-09-16 13:46:47.474368	2025-09-16 13:46:47.474368	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
234	TXN842391	Jio	RECHARGE	8758646754	300.0	SUCCESS	127	2025-09-16 13:52:52.408975	2025-09-16 13:52:52.408975	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
235	TXN704415	Jio	RECHARGE	7796769669	300.0	SUCCESS	127	2025-09-16 13:55:46.961427	2025-09-16 13:55:46.961427	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
236	TXN202588	Jio	RECHARGE	8945689456	300.0	SUCCESS	127	2025-09-16 13:57:09.975787	2025-09-16 13:57:09.975787	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
250	TXN816699	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:27:19.635547	2025-09-16 18:27:19.635547	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
251	TXN774851	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:27:28.360533	2025-09-16 18:27:28.360533	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
252	TXN617962	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:27:43.614023	2025-09-16 18:27:43.614023	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
255	TXN406027	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:37:51.654406	2025-09-16 18:37:51.654406	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
257	TXN180359	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:41:26.852442	2025-09-16 18:41:26.852442	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
258	TXN842031	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:42:35.236836	2025-09-16 18:42:35.236836	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
259	TXN882156	Jio	RECHARGE	5657567576	200.0	SUCCESS	127	2025-09-17 04:47:49.450049	2025-09-17 04:47:49.450049	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
260	TXN838072	Jio	RECHARGE	0856745769	200.0	SUCCESS	127	2025-09-17 05:04:20.218995	2025-09-17 05:04:20.218995	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
261	TXN295166	Jio	RECHARGE	0947695479	52.0	SUCCESS	127	2025-09-17 05:12:23.77691	2025-09-17 05:12:23.77691	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
262	TXN958369	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-17 06:54:00.706193	2025-09-17 06:54:00.706193	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
263	TXN833807	Jio	RECHARGE	8934589436	200.0	SUCCESS	127	2025-09-17 07:20:05.650515	2025-09-17 07:20:05.650515	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
264	TXN622002	Jio	RECHARGE	5654645645	200.0	SUCCESS	127	2025-09-17 07:22:58.424074	2025-09-17 07:22:58.424074	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
265	TXN807687	Airtel	RECHARGE	5745675467	500.0	SUCCESS	127	2025-09-17 07:23:39.606543	2025-09-17 07:23:39.606543	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
266	TXN319177	Airtel	RECHARGE	8687966796	500.0	SUCCESS	127	2025-09-17 07:25:57.970954	2025-09-17 07:25:57.970954	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
267	TXN295019	Airtel	RECHARGE	5656765756	500.0	SUCCESS	139	2025-09-17 07:27:40.871936	2025-09-17 07:27:40.871936	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
268	TXN784529	Airtel	RECHARGE	8787878978	500.0	SUCCESS	127	2025-09-17 07:54:09.134099	2025-09-17 07:54:09.134099	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
269	TXN465639	Airtel	RECHARGE	7456756756	500.0	SUCCESS	127	2025-09-17 07:55:10.723613	2025-09-17 07:55:10.723613	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
270	TXN672407	Jio	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 08:33:26.703938	2025-09-17 08:33:26.703938	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
271	TXN740032	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 08:33:45.028439	2025-09-17 08:33:45.028439	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
272	TXN258651	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 08:44:53.65969	2025-09-17 08:44:53.65969	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
274	TXN811268	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 08:48:03.601258	2025-09-17 08:48:03.601258	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
275	TXN596076	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 08:49:14.105294	2025-09-17 08:49:14.105294	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
276	TXN599264	Airtel	RECHARGE	4645654654	300.0	SUCCESS	127	2025-09-17 08:51:14.251345	2025-09-17 08:51:14.251345	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
277	TXN364943	Jio	RECHARGE	8789758675	300.0	SUCCESS	127	2025-09-17 08:51:57.624669	2025-09-17 08:51:57.624669	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
278	TXN607953	Jio	RECHARGE	8785658765	300.0	SUCCESS	127	2025-09-17 08:53:05.440148	2025-09-17 08:53:05.440148	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
279	TXN420215	Airtel	RECHARGE	8966986896	292.0	SUCCESS	139	2025-09-17 08:56:17.15513	2025-09-17 08:56:17.15513	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
280	TXN208381	Jio	RECHARGE	8697697787	300.0	SUCCESS	139	2025-09-17 08:57:43.969877	2025-09-17 08:57:43.969877	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
281	TXN834330	Jio	RECHARGE	7764567056	15.0	SUCCESS	127	2025-09-17 09:19:00.912416	2025-09-17 09:19:00.912416	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
282	TXN122653	Airtel	RECHARGE	8767867867	200.0	SUCCESS	127	2025-09-17 09:35:50.907701	2025-09-17 09:35:50.907701	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
283	TXN832440	Jio	RECHARGE	8976695656	10.0	SUCCESS	127	2025-09-17 09:46:34.617237	2025-09-17 09:46:34.617237	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
284	TXN489650	Jio	RECHARGE	7567586975	100.0	SUCCESS	127	2025-09-17 09:48:16.278247	2025-09-17 09:48:16.278247	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
285	TXN214259	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 10:13:05.935248	2025-09-17 10:13:05.935248	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
286	TXN593081	Jio	RECHARGE	3454534534	100.0	SUCCESS	127	2025-09-17 10:26:43.701329	2025-09-17 10:26:43.701329	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
295	TXN903636	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 10:41:26.622673	2025-09-17 10:41:26.622673	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
296	TXN433465	Jio	RECHARGE	5686585685	10.0	SUCCESS	127	2025-09-17 10:41:58.333323	2025-09-17 10:41:58.333323	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
297	TXN737030	Jio	RECHARGE	3423423423	120.0	SUCCESS	127	2025-09-17 10:42:39.982348	2025-09-17 10:42:39.982348	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
308	TXN722291	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 10:51:05.168523	2025-09-17 10:51:05.168523	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
309	TXN364761	Vi	RECHARGE	5654656456	10.0	SUCCESS	127	2025-09-17 10:51:19.628799	2025-09-17 10:51:19.628799	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
310	TXN315212	Jio	RECHARGE	9845867567	12.0	SUCCESS	127	2025-09-17 10:51:49.49754	2025-09-17 10:51:49.49754	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
311	TXN143694	Airtel	RECHARGE	8687658785	50.0	SUCCESS	127	2025-09-17 10:52:17.969768	2025-09-17 10:52:17.969768	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
312	TXN689981	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 10:54:47.842512	2025-09-17 10:54:47.842512	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
313	TXN258064	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-17 10:57:09.312588	2025-09-17 10:57:09.312588	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
314	TXN269648	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-17 10:58:01.783852	2025-09-17 10:58:01.783852	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
315	TXN724817	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-17 10:59:57.631788	2025-09-17 10:59:57.631788	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
316	TXN615646	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 11:00:17.213265	2025-09-17 11:00:17.213265	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
317	TXN214319	Jio	RECHARGE	0958765675	200.0	SUCCESS	127	2025-09-17 11:26:43.713611	2025-09-17 11:26:43.713611	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
318	TXN256499	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-17 11:36:04.041119	2025-09-17 11:36:04.041119	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
319	TXN159094	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-17 11:37:06.513151	2025-09-17 11:37:06.513151	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
320	TXN669987	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-17 11:37:27.281698	2025-09-17 11:37:27.281698	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
321	TXN625722	Jio	RECHARGE	9876896869	100.0	SUCCESS	127	2025-09-17 11:39:20.104412	2025-09-17 11:39:20.104412	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
322	TXN400351	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 11:41:47.51083	2025-09-17 11:41:47.51083	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
324	TXN888029	Airtel	RECHARGE	9097689768	100.0	SUCCESS	127	2025-09-17 11:48:12.222171	2025-09-17 11:48:12.222171	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
323	TXN616112	Jio	RECHARGE	7687676767	100.0	SUCCESS	127	2025-09-17 11:43:19.831598	2025-09-17 11:43:19.831598	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
325	TXN103156	Jio	RECHARGE	9789669767	100.0	SUCCESS	127	2025-09-17 12:28:54.970953	2025-09-17 12:28:54.970953	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
326	TXN609571	Airtel	RECHARGE	8784685486	200.0	SUCCESS	127	2025-09-17 12:29:36.34278	2025-09-17 12:29:36.34278	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
327	TXN564454	Airtel	RECHARGE	1000789789	200.0	SUCCESS	127	2025-09-17 12:31:10.357063	2025-09-17 12:31:10.357063	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
328	TXN399632	Airtel	RECHARGE	8968776587	100.0	SUCCESS	127	2025-09-17 12:32:22.390778	2025-09-17 12:32:22.390778	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
329	TXN806740	Airtel	RECHARGE	6796986976	100.0	SUCCESS	127	2025-09-17 13:07:40.843607	2025-09-17 13:07:40.843607	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
330	TXN956273	Vi	RECHARGE	5465464565	100.0	SUCCESS	127	2025-09-17 13:21:12.841464	2025-09-17 13:21:12.841464	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
331	TXN546292	Jio	RECHARGE	6585675675	200.0	SUCCESS	127	2025-09-17 13:21:37.296395	2025-09-17 13:21:37.296395	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
332	TXN258548	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 13:27:11.700797	2025-09-17 13:27:11.700797	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
333	TXN961809	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 13:32:55.517983	2025-09-17 13:32:55.517983	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
334	TXN381293	Jio	RECHARGE	6796786786	100.0	SUCCESS	127	2025-09-17 13:56:34.152287	2025-09-17 13:56:34.152287	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
335	TXN210593	Airtel	RECHARGE	6786786787	100.0	SUCCESS	127	2025-09-17 13:57:11.842682	2025-09-17 13:57:11.842682	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
336	TXN431514	Jio	RECHARGE	0947569697	100.0	SUCCESS	127	2025-09-18 06:55:53.673028	2025-09-18 06:55:53.673028	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
338	TXN413777	Jio	RECHARGE	4645645645	199.0	SUCCESS	127	2025-09-18 07:17:06.526147	2025-09-18 07:17:06.526147	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
339	TXN837088	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:23:23.735867	2025-09-18 07:23:23.735867	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
340	TXN275214	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:24:08.868119	2025-09-18 07:24:08.868119	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
341	TXN335281	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:33:40.636773	2025-09-18 07:33:40.636773	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
342	TXN476639	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:34:19.027779	2025-09-18 07:34:19.027779	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
343	TXN654151	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:36:21.332997	2025-09-18 07:36:21.332997	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
344	TXN557708	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-18 07:50:43.336924	2025-09-18 07:50:43.336924	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
345	TXN920846	Airtel	RECHARGE	9893738632	200.0	SUCCESS	139	2025-09-18 08:37:43.504628	2025-09-18 08:37:43.504628	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
346	TXN857094	Airtel	RECHARGE	7867876868	100.0	SUCCESS	127	2025-09-18 11:23:48.925907	2025-09-18 11:23:48.925907	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
347	TXN126455	Jio	RECHARGE	9878867676	300.0	SUCCESS	139	2025-09-18 13:10:04.597224	2025-09-18 13:10:04.597224	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
348	TXN373443	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-19 10:56:34.351964	2025-09-19 10:56:34.351964	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
349	TXN866337	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-19 11:07:44.341036	2025-09-19 11:07:44.341036	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
350	TXN581792	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-19 11:08:08.930916	2025-09-19 11:08:08.930916	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
351	TXN950125	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-19 11:12:30.625876	2025-09-19 11:12:30.625876	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
352	TXN111597	Jio	RECHARGE	8789795666	200.0	SUCCESS	127	2025-09-19 11:49:50.1497	2025-09-19 11:49:50.1497	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
353	TXN873815	Airtel	RECHARGE	6756756756	399.0	SUCCESS	127	2025-09-19 11:50:50.760418	2025-09-19 11:50:50.760418	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
354	TXN174533	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	134	2025-09-19 12:06:30.304773	2025-09-19 12:06:30.304773	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
355	TXN832000	Airtel	RECHARGE	9079675870	200.0	SUCCESS	127	2025-09-19 12:23:11.994069	2025-09-19 12:23:11.994069	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
356	TXN912606	Jio	RECHARGE	9856709480	199.0	SUCCESS	127	2025-09-19 14:06:31.428042	2025-09-19 14:06:31.428042	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
357	TXN245306	Airtel	Recharge	8797097907	11.0	SUCCESS	127	2025-10-06 09:41:41.341071	2025-10-06 09:41:41.341071	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
358	TXN231150	Airtel	Recharge	5646456456	22.0	SUCCESS	127	2025-10-06 10:39:35.422369	2025-10-06 10:39:35.422369	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
359	TXN831028	Airtel	Recharge	5646456456	22.0	SUCCESS	127	2025-10-06 10:40:08.933789	2025-10-06 10:40:08.933789	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
360	TXN745161	Vi	Recharge	7686786786	77.0	SUCCESS	127	2025-10-06 10:43:31.603325	2025-10-06 10:43:31.603325	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
361	TXN164805	Airtel	Recharge	9869869868	101.0	SUCCESS	127	2025-10-06 10:49:28.553372	2025-10-06 10:49:28.553372	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
362	TXN317123	Jio	Recharge	0878979868	33.0	SUCCESS	127	2025-10-06 10:53:49.242841	2025-10-06 10:53:49.242841	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
363	TXN818959	Airtel	Recharge	8787987899	74.0	SUCCESS	127	2025-10-06 10:56:21.434755	2025-10-06 10:56:21.434755	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
364	TXN313395	Airtel	Recharge	6756756756	19.0	SUCCESS	127	2025-10-06 10:57:28.890519	2025-10-06 10:57:28.890519	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
365	TXN578523	Jio	Recharge	8878897897	1.0	SUCCESS	127	2025-10-06 11:02:43.928536	2025-10-06 11:02:43.928536	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
366	TXN144802	Airtel	Recharge	8979878997	77.0	SUCCESS	127	2025-10-06 11:09:27.440087	2025-10-06 11:09:27.440087	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
367	TXN321619	Vi	Recharge	0789787897	74.0	SUCCESS	127	2025-10-06 12:06:40.065768	2025-10-06 12:06:40.065768	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
368	TXN114782	Airtel	Recharge	7657567567	64.0	SUCCESS	127	2025-10-06 12:27:25.446375	2025-10-06 12:27:25.446375	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
369	TXN708578	Airtel	Recharge	7657567567	64.0	SUCCESS	127	2025-10-06 12:29:21.142627	2025-10-06 12:29:21.142627	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
370	TXN816002	Airtel	Recharge	8765769585	11.0	SUCCESS	127	2025-10-06 13:57:05.318322	2025-10-06 13:57:05.318322	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
371	TXN775394	Jio	Recharge	9809979878	199.0	SUCCESS	127	2025-10-06 14:30:22.518824	2025-10-06 14:30:22.518824	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
372	TXN127209	Airtel	Recharge	6876768767	499.0	SUCCESS	127	2025-10-06 14:31:37.246665	2025-10-06 14:31:37.246665	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
373	TXN534958	Jio	Recharge	8789798789	199.0	SUCCESS	127	2025-10-08 10:49:30.749	2025-10-08 10:49:30.749	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
374	TXN587955	tatasky	Recharge	9305096443	299.0	SUCCESS	127	2025-10-08 11:38:41.244593	2025-10-08 11:38:41.244593	11	Manikant	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
375	TXN501019	tatasky	Recharge	9305096443	299.0	SUCCESS	127	2025-10-08 11:38:42.82335	2025-10-08 11:38:42.82335	11	Manikant	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
376	TXN702943	Airtel	Recharge	4543534534	10.0	SUCCESS	127	2025-10-08 11:43:35.019476	2025-10-08 11:43:35.019476	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
377	TXN222395	den	Recharge	9878796898	250.0	SUCCESS	127	2025-10-08 11:44:35.690145	2025-10-08 11:44:35.690145	11	Manikant	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
378	TXN919532	airtel	Recharge	7658767578	399.0	SUCCESS	127	2025-10-08 12:41:08.121375	2025-10-08 12:41:08.121375	11	dsgdsg	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
379	TXN848494	den	Recharge	43534534534	250.0	SUCCESS	127	2025-10-08 12:41:54.440689	2025-10-08 12:41:54.440689	11	Manikant	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
380	TXN264261	tatasky	Recharge	7658767578	299.0	SUCCESS	127	2025-10-08 13:30:56.444845	2025-10-08 13:30:56.444845	11	sid	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
381	TXN450314	tatasky	Recharge	77458734873	499.0	SUCCESS	127	2025-10-10 06:56:38.071714	2025-10-10 06:56:38.071714	11	78974389578	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
382	TXN531411	Airtel	Recharge	9867867896	67.0	SUCCESS	127	2025-10-10 13:08:42.604366	2025-10-10 13:08:42.604366	11	jjdd	\N	\N	878979898789	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
383	TXN769083	Airtel	Recharge	6575675675	121.0	SUCCESS	127	2025-10-10 13:12:23.144468	2025-10-10 13:12:23.144468	11	sdsfdsf	\N	\N	435345	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
384	TXN222169	Airtel	Recharge	3434535344	234.0	SUCCESS	127	2025-10-10 13:13:54.695201	2025-10-10 13:13:54.695201	11	fsd	\N	\N	dfg	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
385	TXN633219	Airtel	Recharge	6766876767	565.0	SUCCESS	127	2025-10-10 13:17:47.406264	2025-10-10 13:17:47.406264	11	kjgh	\N	\N	u67678	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
386	TXN823470	tatasky	Recharge	65757576657	199.0	SUCCESS	127	2025-10-31 07:51:57.251346	2025-10-31 07:51:57.251346	11	dfds	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
387	TXN897237	Airtel	Recharge	6575676575	1.0	SUCCESS	127	2025-10-31 09:08:35.116558	2025-10-31 09:08:35.116558	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
388	TXN544373	airtel	Recharge	999999999999	199.0	SUCCESS	127	2025-10-31 09:18:56.807174	2025-10-31 09:18:56.807174	11	sid	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
389	TXN180906	tatasky	Recharge	9878796898	199.0	SUCCESS	127	2025-10-31 09:36:19.173447	2025-10-31 09:36:19.173447	11	6876867867867	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
390	TXN865821	videocon	Recharge	42042099999	299.0	SUCCESS	127	2025-10-31 10:16:28.941176	2025-10-31 10:16:28.941176	11	sidwa	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
391	TXN675657	Airtel	Recharge	9879889789	600.0	SUCCESS	127	2025-10-31 10:19:36.449568	2025-10-31 10:19:36.449568	11	sdsfdsf	\N	778	43534	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
392	TXN192228	dish	Recharge	77777777777	199.0	SUCCESS	127	2025-10-31 10:24:56.575391	2025-10-31 10:24:56.575391	11	manikant	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
393	TXN896192	dish	Recharge	7554745654645645646	699.0	SUCCESS	127	2025-10-31 12:31:17.724301	2025-10-31 12:31:17.724301	11	manikant	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
394	TXN408150	Jio	Recharge	9789877977	199.0	SUCCESS	127	2025-10-31 12:37:00.438311	2025-10-31 12:37:00.438311	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
395	TXN383545	tatasky	Recharge	88778787777	699.0	SUCCESS	127	2025-10-31 12:38:23.146166	2025-10-31 12:38:23.146166	11	sid	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
396	TXN311823	Jio	recharge	9876543210	100.0	SUCCESS	139	2025-11-06 06:01:37.515123	2025-11-06 06:01:37.515123	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
397	TXN860303	jdnsj	recharge	8317082162	3.0	SUCCESS	139	2025-11-07 10:25:19.570161	2025-11-07 10:25:19.570161	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
398	TXN671334	jdnsj	recharge	8317082162	3.0	SUCCESS	139	2025-11-10 05:57:23.671294	2025-11-10 05:57:23.671294	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
399	TXN569284	jdnsj	recharge	8317082162	3.0	SUCCESS	139	2025-11-10 05:57:37.779108	2025-11-10 05:57:37.779108	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
400	TXN802653	Home Loan	recharge	7897977987	1.0	SUCCESS	139	2025-11-10 09:46:02.586631	2025-11-10 09:46:02.586631	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
401	TXN365695	Home loan	recharge	78979798979	12000.0	SUCCESS	139	2025-11-10 09:52:21.428889	2025-11-10 09:52:21.428889	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
402	TXN175393	Home loan	recharge	78979798979	12000.0	SUCCESS	139	2025-11-10 09:59:27.970947	2025-11-10 09:59:27.970947	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
403	TXN233450	formData?.loanType	recharge	formData?.mobile 	12000.0	SUCCESS	139	2025-11-10 10:24:13.509782	2025-11-10 10:24:13.509782	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
404	TXN929626	car	recharge	9787987987	12000.0	SUCCESS	139	2025-11-10 10:27:10.673668	2025-11-10 10:27:10.673668	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
405	TXN428323	car	recharge	3647832638	3.0	SUCCESS	139	2025-11-10 10:37:38.535663	2025-11-10 10:37:38.535663	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
406	TXN838168	card	recharge	8317082162	3.0	SUCCESS	139	2025-11-10 11:50:28.842065	2025-11-10 11:50:28.842065	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
407	TXN744613	card	recharge	8317082162	3.0	SUCCESS	139	2025-11-10 11:51:27.920393	2025-11-10 11:51:27.920393	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
408	TXN703110	card	recharge	8317082162	11.0	SUCCESS	139	2025-11-10 12:01:40.077196	2025-11-10 12:01:40.077196	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
409	TXN428551	card	recharge	8317082162	11.0	SUCCESS	139	2025-11-10 12:03:34.638583	2025-11-10 12:03:34.638583	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
410	TXN911165	card	recharge	8317082162	3.0	SUCCESS	139	2025-11-10 12:05:02.000793	2025-11-10 12:05:02.000793	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
411	TXN203838	card	recharge	8317082162	2.0	SUCCESS	139	2025-11-10 12:25:52.489427	2025-11-10 12:25:52.489427	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
412	TXN203856	car	recharge	5656776788	23.0	SUCCESS	139	2025-11-10 12:57:59.772418	2025-11-10 12:57:59.772418	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
413	TXN287160	card	recharge	8317082162	12.0	SUCCESS	139	2025-11-10 12:59:37.399986	2025-11-10 12:59:37.399986	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
414	TXN820098	car	recharge	8789789798	12000.0	SUCCESS	139	2025-11-11 07:26:52.465189	2025-11-11 07:26:52.465189	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
415	TXN149161	home	recharge	9878977979	19.0	SUCCESS	139	2025-11-11 07:30:18.145737	2025-11-11 07:30:18.145737	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
416	TXN927898	home	recharge	8797979797	115.0	SUCCESS	139	2025-11-11 07:39:47.341591	2025-11-11 07:39:47.341591	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
417	TXN181213	HDFC	recharge	8317082162	2.0	SUCCESS	139	2025-11-11 07:51:47.283573	2025-11-11 07:51:47.283573	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
418	TXN942586	HDFC	recharge	8317082162	13.0	SUCCESS	139	2025-11-11 08:38:34.899114	2025-11-11 08:38:34.899114	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
419	TXN222969	home	recharge	5675675656	12.0	SUCCESS	139	2025-11-11 08:40:09.782256	2025-11-11 08:40:09.782256	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
420	TXN259524	SBI	recharge	8317082162	4.0	SUCCESS	139	2025-11-11 08:42:17.798678	2025-11-11 08:42:17.798678	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
421	TXN377693	card	recharge	8317082162	11.0	SUCCESS	139	2025-11-11 08:55:35.131718	2025-11-11 08:55:35.131718	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
422	TXN108726	SBI	recharge	8317082162	22.0	SUCCESS	139	2025-11-11 08:58:37.888657	2025-11-11 08:58:37.888657	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
423	TXN201913	SBI	recharge	8317082162	22.0	SUCCESS	139	2025-11-11 08:58:39.963871	2025-11-11 08:58:39.963871	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
424	TXN492652	SBI	recharge	8317082162	22.0	SUCCESS	139	2025-11-11 08:58:50.658767	2025-11-11 08:58:50.658767	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
425	TXN368948	SBI	recharge	8317082162	22.0	SUCCESS	139	2025-11-11 09:00:55.70327	2025-11-11 09:00:55.70327	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
426	TXN339028	SBI	recharge	8317082162	20.0	SUCCESS	139	2025-11-11 09:07:52.464237	2025-11-11 09:07:52.464237	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
427	TXN630314	SBI	recharge	8317082162	20.0	SUCCESS	139	2025-11-11 09:11:25.248698	2025-11-11 09:11:25.248698	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
428	TXN802359	car	recharge	8978797979	11.0	SUCCESS	139	2025-11-11 09:28:15.35052	2025-11-11 09:28:15.35052	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
429	TXN591431	car	recharge	8317082162	10.0	SUCCESS	139	2025-11-11 09:39:51.879738	2025-11-11 09:39:51.879738	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
430	TXN851173	card	recharge	8317082162	12.0	SUCCESS	139	2025-11-11 09:41:35.676026	2025-11-11 09:41:35.676026	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
431	TXN996339	SBI	recharge	8317082162	9.0	SUCCESS	139	2025-11-11 09:46:14.714277	2025-11-11 09:46:14.714277	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
432	TXN151889	XYZ	rent_payment	8317082162	11.0	SUCCESS	139	2025-11-11 10:50:21.25823	2025-11-11 10:50:21.25823	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
433	TXN198742	XYZ	rent_payment	8317082162	11.0	SUCCESS	139	2025-11-11 10:50:51.881876	2025-11-11 10:50:51.881876	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
434	TXN133148	XYZ	rent_payment	8317082162	11.0	SUCCESS	139	2025-11-11 10:51:42.094304	2025-11-11 10:51:42.094304	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
435	TXN894008	card	recharge	8317082162	10.0	SUCCESS	139	2025-11-11 11:40:22.69323	2025-11-11 11:40:22.69323	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
436	TXN667857	car	recharge	8796767867	118.0	SUCCESS	139	2025-11-11 11:43:40.732551	2025-11-11 11:43:40.732551	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
437	TXN986792	SBI	recharge	8317082162	22.0	SUCCESS	139	2025-11-11 11:53:12.626387	2025-11-11 11:53:12.626387	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
438	TXN578982	SBI	recharge	8317082162	22.0	SUCCESS	139	2025-11-11 11:53:17.528071	2025-11-11 11:53:17.528071	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
439	TXN633737	SBI	recharge	8317082162	22.0	SUCCESS	139	2025-11-11 11:53:18.569798	2025-11-11 11:53:18.569798	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
440	TXN871563	SBI	recharge	8985662189	1111.0	SUCCESS	139	2025-11-11 12:07:30.571105	2025-11-11 12:07:30.571105	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
441	TXN362961	ICICI	recharge	8317082162	20.0	SUCCESS	139	2025-11-11 12:11:52.586012	2025-11-11 12:11:52.586012	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
442	TXN480536	ICICI	recharge	8317082162	20.0	SUCCESS	139	2025-11-11 12:12:35.201269	2025-11-11 12:12:35.201269	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
443	TXN597213	personal	recharge	4738473843	3.0	SUCCESS	139	2025-11-11 12:36:46.969909	2025-11-11 12:36:46.969909	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
444	TXN287455	education	recharge	8778787788	10.0	SUCCESS	139	2025-11-12 05:07:32.770652	2025-11-12 05:07:32.770652	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
445	TXN672392	card	recharge	8317082162	44.0	SUCCESS	139	2025-11-12 05:33:09.664706	2025-11-12 05:33:09.664706	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
446	TXN629632	card	recharge	8317082162	44.0	SUCCESS	139	2025-11-12 05:33:14.329163	2025-11-12 05:33:14.329163	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
447	TXN741425	card	recharge	8317082162	44.0	SUCCESS	139	2025-11-12 05:36:13.734323	2025-11-12 05:36:13.734323	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
448	TXN124283	card	recharge	8317082162	44.0	SUCCESS	139	2025-11-12 05:38:11.379147	2025-11-12 05:38:11.379147	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
449	TXN633644	card	recharge	8317082162	44.0	SUCCESS	139	2025-11-12 05:42:21.96207	2025-11-12 05:42:21.96207	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
450	TXN400493	card	recharge	8317082162	44.0	SUCCESS	139	2025-11-12 05:47:46.159031	2025-11-12 05:47:46.159031	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
451	TXN171210	card	recharge	8317082162	44.0	SUCCESS	139	2025-11-12 05:47:53.247499	2025-11-12 05:47:53.247499	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
452	TXN279616	card	recharge	8317082162	22.0	SUCCESS	139	2025-11-12 05:51:38.025778	2025-11-12 05:51:38.025778	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
453	TXN828738	card	recharge	8317082162	22.0	SUCCESS	139	2025-11-12 05:53:44.596112	2025-11-12 05:53:44.596112	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
454	TXN947269	card	recharge	8317082162	22.0	SUCCESS	139	2025-11-12 05:57:50.927938	2025-11-12 05:57:50.927938	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
455	TXN395394	card	recharge	8317082162	22.0	SUCCESS	139	2025-11-12 05:58:23.630456	2025-11-12 05:58:23.630456	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
456	TXN809534	card	recharge	8317082162	22.0	SUCCESS	139	2025-11-12 05:59:10.201111	2025-11-12 05:59:10.201111	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
457	TXN245757	XYZ	rent_payment	8512638972	11.0	SUCCESS	139	2025-11-12 06:00:27.250263	2025-11-12 06:00:27.250263	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
458	TXN904673	XYZ	rent_payment	8317082162	200.0	SUCCESS	139	2025-11-12 06:20:41.055514	2025-11-12 06:20:41.055514	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
459	TXN930133	XYZ	rent_payment	8317082162	200.0	SUCCESS	139	2025-11-12 06:22:30.385334	2025-11-12 06:22:30.385334	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
460	TXN212213	XYZ	rent_payment	8317082162	200.0	SUCCESS	139	2025-11-12 06:25:30.00396	2025-11-12 06:25:30.00396	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
461	TXN370417	XYZ	rent_payment	8317082162	200.0	SUCCESS	139	2025-11-12 06:26:33.178943	2025-11-12 06:26:33.178943	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
462	TXN212520	XYZ	rent_payment	8317082162	200.0	SUCCESS	139	2025-11-12 06:27:49.774947	2025-11-12 06:27:49.774947	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
463	TXN321212	XYZ	rent_payment	8317082162	100.0	SUCCESS	139	2025-11-12 06:29:34.157056	2025-11-12 06:29:34.157056	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
464	TXN186942	card	recharge	8317082162	2.0	SUCCESS	139	2025-11-12 06:34:32.202631	2025-11-12 06:34:32.202631	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
465	TXN577054	HDFC	recharge	8317082162	20.0	SUCCESS	139	2025-11-12 06:39:34.594544	2025-11-12 06:39:34.594544	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
466	TXN442825	XYZ	rent_payment	8317082162	20.0	SUCCESS	139	2025-11-12 07:50:01.109494	2025-11-12 07:50:01.109494	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
467	TXN512279	home	recharge	8888888888	111.0	SUCCESS	139	2025-11-12 10:29:25.705041	2025-11-12 10:29:25.705041	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
468	TXN186824	Jio	Recharge	5555555555	199.0	SUCCESS	139	2025-11-12 10:38:22.692393	2025-11-12 10:38:22.692393	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
469	TXN617827	Airtel	Recharge	8317082162	12.0	SUCCESS	139	2025-11-12 10:39:16.043253	2025-11-12 10:39:16.043253	14	gdgdf	\N	7899878979	7987897897879	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
470	TXN812819	tatasky	Recharge	8317082162	399.0	SUCCESS	139	2025-11-12 10:39:52.503472	2025-11-12 10:39:52.503472	14	tryryry	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
471	TXN370982	personal	recharge	5555555555	88.0	SUCCESS	139	2025-11-12 12:08:33.242922	2025-11-12 12:08:33.242922	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
472	TXN174574	car	recharge	8594622322	13.0	SUCCESS	139	2025-11-12 12:10:12.804924	2025-11-12 12:10:12.804924	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
473	TXN107610	education	recharge	8317082162	90.0	SUCCESS	139	2025-11-12 12:12:00.079841	2025-11-12 12:12:00.079841	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
474	TXN519254	HDFC	recharge	8317082162	20.0	SUCCESS	139	2025-11-12 12:12:50.614919	2025-11-12 12:12:50.614919	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
475	TXN314630	Jio	Recharge	5555555555	299.0	SUCCESS	139	2025-11-13 06:39:22.293062	2025-11-13 06:39:22.293062	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
476	TXN123610	Airtel	Recharge	8317082162	41.0	SUCCESS	139	2025-11-13 06:42:36.472648	2025-11-13 06:42:36.472648	15	gdgdf	\N	7899878979	7987897897879	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
477	TXN964079	Jio	Recharge	8317082162	11.0	SUCCESS	139	2025-11-13 06:45:23.868013	2025-11-13 06:45:23.868013	15	gdgdf	\N	7899878979	7987897897879	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
478	TXN615607	Jio	Recharge	8317082162	22.0	SUCCESS	139	2025-11-13 06:52:29.018666	2025-11-13 06:52:29.018666	15	ytyjtytjty	\N	7899878979	7987897897879	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
479	TXN431904	BSNL	Recharge	8317082162	120.0	SUCCESS	139	2025-11-13 07:34:12.213603	2025-11-13 07:34:12.213603	12	manikant	\N	122222	8888888888888888	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
480	TXN422978	Jio	Recharge	8317082162	90.0	SUCCESS	139	2025-11-13 08:52:42.539438	2025-11-13 08:52:42.539438	12	manikant	\N	7899878979	7987897897879	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
481	TXN492189	Airtel	Recharge	8317082162	200.0	SUCCESS	139	2025-11-13 08:55:51.268098	2025-11-13 08:55:51.268098	12	manikant	\N	7899878979	7987897897879	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
482	TXN367691	Jio	Recharge	8317082162	20.0	SUCCESS	139	2025-11-13 08:58:53.038026	2025-11-13 08:58:53.038026	12	manikant	\N	7899878979	7987897897879	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
483	TXN653807	home	recharge	3333333333	2.0	SUCCESS	139	2025-11-13 09:20:15.170428	2025-11-13 09:20:15.170428	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
484	TXN556877	home	recharge	5555555555	1.0	SUCCESS	139	2025-11-13 09:30:27.877339	2025-11-13 09:30:27.877339	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
485	TXN825734	tatasky	Recharge	8317082162	199.0	SUCCESS	139	2025-11-13 10:03:40.46614	2025-11-13 10:03:40.46614	13	tryryry	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
486	TXN772200	dish	Recharge	1111111	399.0	SUCCESS	139	2025-11-13 11:50:05.117442	2025-11-13 11:50:05.117442	13	amiyyyyy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
487	TXN345862	airtel	Recharge	8317082162	199.0	SUCCESS	139	2025-11-13 12:24:35.809463	2025-11-13 12:24:35.809463	13	sonam mam	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
488	TXN962589	Airtel	Recharge	2222222222	1089.54	SUCCESS	139	2025-11-14 10:12:19.392367	2025-11-14 10:12:19.392367	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
489	TXN271082	Delhi Water Board	Recharge	4443434433	1089.54	SUCCESS	139	2025-11-14 10:15:01.255815	2025-11-14 10:15:01.255815	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
490	TXN752922	Delhi Water Board	Recharge	9999999999	1089.54	SUCCESS	139	2025-11-14 10:28:23.177153	2025-11-14 10:28:23.177153	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
491	TXN145963	Delhi Water Board	Recharge	9999999999	1089.54	SUCCESS	139	2025-11-14 11:00:35.018674	2025-11-14 11:00:35.018674	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
492	TXN331405	Mumbai Water Board	Recharge	4444444444	1089.54	SUCCESS	139	2025-11-14 12:28:27.910412	2025-11-14 12:28:27.910412	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
493	TXN172156	car	recharge	8888888888	90.0	SUCCESS	139	2025-11-17 06:04:21.312931	2025-11-17 06:04:21.312931	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
494	TXN416498	SBI	recharge	9852222222	88.0	SUCCESS	139	2025-11-17 06:05:21.228172	2025-11-17 06:05:21.228172	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
495	TXN463295	card	recharge	8317082162	22.0	SUCCESS	139	2025-11-17 06:06:02.5956	2025-11-17 06:06:02.5956	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
496	TXN623942	XYZ	rent_payment	8945285621	44.0	SUCCESS	139	2025-11-17 06:07:56.974678	2025-11-17 06:07:56.974678	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
497	TXN768348	Airtel	Recharge	8888888888	749.0	SUCCESS	139	2025-11-17 06:08:25.286075	2025-11-17 06:08:25.286075	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
498	TXN441908	airtel	Recharge	87392889	199.0	SUCCESS	139	2025-11-17 06:10:01.869471	2025-11-17 06:10:01.869471	13	sjfjksdnffn	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
499	TXN797399	Tata Power	bill_payment	8888888888	1089.54	SUCCESS	139	2025-11-17 07:21:36.593397	2025-11-17 07:21:36.593397	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
500	TXN244912	Tata Power	bill_payment	8888888888	1089.54	SUCCESS	139	2025-11-17 07:21:47.219915	2025-11-17 07:21:47.219915	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
501	TXN547908	Tata Power	bill_payment	8888888888	1089.54	SUCCESS	139	2025-11-17 07:24:16.187867	2025-11-17 07:24:16.187867	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
502	TXN576929	Tata Power	bill_payment	8888888888	1089.54	SUCCESS	139	2025-11-17 07:28:57.523271	2025-11-17 07:28:57.523271	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
503	TXN581610	Tata Power	bill_payment	8888888888	1089.54	SUCCESS	139	2025-11-17 07:30:49.114077	2025-11-17 07:30:49.114077	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
504	TXN291057	Adani Power	bill_payment	8595266325	1089.54	SUCCESS	139	2025-11-17 07:34:00.514038	2025-11-17 07:34:00.514038	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
505	TXN621702	Adani Power	bill_payment	8856522222	1089.54	SUCCESS	139	2025-11-17 07:37:49.864938	2025-11-17 07:37:49.864938	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
506	TXN960554	HP Gas	bill_payment	8317082162	9.0	SUCCESS	139	2025-11-17 08:47:38.273768	2025-11-17 08:47:38.273768	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
507	TXN820981	HP Gas	bill_payment	8317082162	9.0	SUCCESS	139	2025-11-17 08:48:40.320899	2025-11-17 08:48:40.320899	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
508	TXN111267	HP Gas	bill_payment	8888888888	50.0	SUCCESS	139	2025-11-17 08:55:05.910855	2025-11-17 08:55:05.910855	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
509	TXN478695	Bharat Gas	bill_payment	8317082162	109.0	SUCCESS	139	2025-11-17 08:56:22.582039	2025-11-17 08:56:22.582039	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
510	TXN363950	HP Gas	bill_payment	5555555555	90.0	SUCCESS	139	2025-11-17 09:02:17.219832	2025-11-17 09:02:17.219832	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
511	TXN746051	Bharat Gas	bill_payment	1111111111	300.0	SUCCESS	139	2025-11-17 09:05:58.70208	2025-11-17 09:05:58.70208	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
512	TXN587757	HP Gas	bill_payment	8888888888	22.0	SUCCESS	139	2025-11-17 09:53:29.38784	2025-11-17 09:53:29.38784	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
513	TXN166682	HP Gas	bill_payment	8888888888	90.0	SUCCESS	139	2025-11-17 10:00:55.841352	2025-11-17 10:00:55.841352	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
514	TXN688012	HP Gas	bill_payment	5555555555	10.0	SUCCESS	139	2025-11-17 10:04:25.421745	2025-11-17 10:04:25.421745	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
515	TXN655578	Tata Power	bill_payment	8888888888	1089.54	SUCCESS	139	2025-11-17 10:24:36.402097	2025-11-17 10:24:36.402097	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
516	TXN176095	Tata Power	bill_payment	8888888888	1089.54	SUCCESS	139	2025-11-17 10:32:19.483256	2025-11-17 10:32:19.483256	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
517	TXN817081	HP Gas	bill_payment	8888888888	900.0	SUCCESS	139	2025-11-17 10:55:01.144051	2025-11-17 10:55:01.144051	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
518	TXN921840	HP Gas	bill_payment	8888888888	1.0	SUCCESS	139	2025-11-17 10:55:43.343212	2025-11-17 10:55:43.343212	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
519	TXN865014	Bharat Gas	bill_payment	2222222222	70.0	SUCCESS	139	2025-11-17 11:50:27.704225	2025-11-17 11:50:27.704225	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
520	TXN699094	HP Gas	bill_payment	7777777777	95.0	SUCCESS	139	2025-11-17 11:52:16.5371	2025-11-17 11:52:16.5371	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
521	TXN446522	Bharat Gas	bill_payment	8798797987	33.0	SUCCESS	139	2025-11-17 12:15:30.498343	2025-11-17 12:15:30.498343	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
522	TXN662619	Bharat Gas	bill_payment	7879797907	11.0	SUCCESS	139	2025-11-17 12:28:30.330179	2025-11-17 12:28:30.330179	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
523	TXN684338	Bharat Gas	bill_payment	8888888888	900.0	SUCCESS	139	2025-11-17 12:30:01.524978	2025-11-17 12:30:01.524978	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
524	TXN421214	BSES	bill_payment	9898980098	1089.54	SUCCESS	139	2025-11-17 12:37:28.66543	2025-11-17 12:37:28.66543	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
525	TXN937097	Tata Power	bill_payment	8888888887	1089.54	SUCCESS	139	2025-11-17 12:40:54.938583	2025-11-17 12:40:54.938583	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
526	TXN321447	HP Gas	bill_payment	8888888888	600.0	SUCCESS	139	2025-11-18 06:29:46.98075	2025-11-18 06:29:46.98075	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
527	TXN863375	BSES	bill_payment	8888888888	1089.54	SUCCESS	139	2025-11-18 06:30:25.065767	2025-11-18 06:30:25.065767	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
528	TXN282103	Tata Power	bill_payment	1111111111	1089.54	SUCCESS	139	2025-11-18 06:31:09.591211	2025-11-18 06:31:09.591211	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
529	TXN266144	Bharat Gas	bill_payment	8888888888	80.0	SUCCESS	139	2025-11-18 06:38:06.015587	2025-11-18 06:38:06.015587	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
530	TXN813688	HP Gas	bill_payment	8888888888	60.0	SUCCESS	139	2025-11-18 07:04:40.643552	2025-11-18 07:04:40.643552	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
531	TXN270392	Delhi Water Board	recharge	1234567890	1089.54	SUCCESS	139	2025-11-18 09:50:54.913027	2025-11-18 09:50:54.913027	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
532	TXN783848	N/A	recharge	5555555555	1089.54	SUCCESS	139	2025-11-18 10:09:55.129343	2025-11-18 10:09:55.129343	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
533	TXN907583	N/A	recharge	2222222222	1089.54	SUCCESS	139	2025-11-18 10:18:01.342184	2025-11-18 10:18:01.342184	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
534	TXN165845	N/A	recharge	6666666666	1089.54	SUCCESS	139	2025-11-18 10:24:04.623873	2025-11-18 10:24:04.623873	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
535	TXN905802	N/A	recharge	1212121212	1089.54	SUCCESS	139	2025-11-18 10:28:19.583559	2025-11-18 10:28:19.583559	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
536	TXN331069	Airtel	Recharge	8888888888	499.0	SUCCESS	139	2025-11-18 11:47:12.67007	2025-11-18 11:47:12.67007	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
537	TXN608638	Vi	Recharge	5555555555	229.0	SUCCESS	139	2025-11-18 11:49:41.106474	2025-11-18 11:49:41.106474	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
538	TXN934395	dish	Recharge	909090909	699.0	SUCCESS	139	2025-11-18 11:52:12.351132	2025-11-18 11:52:12.351132	13	annu devi	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
539	TXN798080	BSNL	Recharge	1212121212	499.0	SUCCESS	139	2025-11-18 12:10:18.303309	2025-11-18 12:10:18.303309	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
540	TXN314001	Vi	Recharge	1111111111	399.0	SUCCESS	139	2025-11-18 12:11:40.218454	2025-11-18 12:11:40.218454	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
541	TXN531875	Videocon D2H	Recharge	5464654646	1.0	SUCCESS	139	2025-11-26 05:50:21.897964	2025-11-26 05:50:21.897964	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
542	TXN568135	Videocon D2H	Recharge	5464654646	1.0	SUCCESS	139	2025-11-26 05:52:07.271693	2025-11-26 05:52:07.271693	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
543	TXN178312	Jio Prepaid	Recharge	\N	10.0	SUCCESS	127	2025-11-26 08:53:56.294739	2025-11-26 08:53:56.294739	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9305096443	\N	\N
544	TXN681932	Airtel Prepaid	Recharge	\N	22.0	SUCCESS	127	2025-11-26 09:02:35.579685	2025-11-26 09:02:35.579685	11	\N	\N	\N	\N	\N	3509476053	0.003564	\N	\N	\N	SUCCESS	Success	0.1782	7455915805	\N	\N
545	TXN420110	Tata Sky	Recharge	\N	1.0	SUCCESS	127	2025-11-26 12:50:13.69857	2025-11-26 12:50:13.69857	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	800990898909890	\N	\N
546	TXN744105	Jio Prepaid	Recharge	\N	10.0	SUCCESS	127	2025-11-26 12:54:27.609532	2025-11-26 12:54:27.609532	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9305098968	\N	\N
547	TXN561161	Tata Sky	Recharge	\N	1.0	SUCCESS	127	2025-11-26 12:55:37.293498	2025-11-26 12:55:37.293498	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7778889990	\N	\N
548	TXN589452	Vi Postpaid	Recharge	\N	1.0	SUCCESS	127	2025-11-26 13:01:02.336711	2025-11-26 13:01:02.336711	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8798797987	\N	\N
549	TXN456729	Hathway Digital	Recharge	\N	150.0	SUCCESS	127	2025-11-26 13:12:08.421006	2025-11-26 13:12:08.421006	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	897987897	\N	\N
550	TXN569235	Home Loan	recharge	\N	9.0	SUCCESS	127	2025-11-26 13:15:45.877739	2025-11-26 13:15:45.877739	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8789769879	\N	\N
551	TXN694504	HDFC	recharge	\N	11.0	SUCCESS	127	2025-11-26 13:17:39.397341	2025-11-26 13:17:39.397341	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9798798789	\N	\N
552	TXN744883	card	recharge	\N	11.0	SUCCESS	127	2025-11-26 13:19:10.508878	2025-11-26 13:19:10.508878	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N	\N
553	TXN562619	XYZ	rent_payment	\N	11.0	SUCCESS	127	2025-11-26 13:20:27.314451	2025-11-26 13:20:27.314451	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8778797907	\N	\N
554	TXN866809	N/A	recharge	\N	1089.54	SUCCESS	127	2025-11-26 13:21:55.545661	2025-11-26 13:21:55.545661	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8978978977	\N	\N
555	TXN404406	BSES	bill_payment	\N	1089.54	SUCCESS	127	2025-11-26 13:22:57.025661	2025-11-26 13:22:57.025661	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9890898098	\N	\N
556	TXN865251	Bharat Gas	bill_payment	\N	11.0	SUCCESS	127	2025-11-26 13:23:49.253349	2025-11-26 13:23:49.253349	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6575675675	\N	\N
557	TXN162916	N/A	recharge	\N	1089.54	SUCCESS	127	2025-11-26 13:25:36.673872	2025-11-26 13:25:36.673872	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7878789787	\N	\N
558	TXN214911	BSES	bill_payment	\N	1089.54	SUCCESS	127	2025-11-26 13:25:59.837018	2025-11-26 13:25:59.837018	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9769868978	\N	\N
559	TXN287175	Bharat Gas	bill_payment	\N	11.0	SUCCESS	127	2025-11-26 13:26:24.405884	2025-11-26 13:26:24.405884	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6575675675	\N	\N
560	TXN335443	Airtel Prepaid	Recharge	\N	1.0	SUCCESS	127	2025-11-26 13:26:57.344511	2025-11-26 13:26:57.344511	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8789798798	\N	\N
561	TXN955376	Tata Sky	Recharge	\N	1.0	SUCCESS	127	2025-11-26 13:27:32.100883	2025-11-26 13:27:32.100883	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	87987879878789	\N	\N
562	TXN560070	Hathway Digital	Recharge	\N	150.0	SUCCESS	127	2025-11-26 13:28:19.074013	2025-11-26 13:28:19.074013	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8789787889789	\N	\N
563	TXN877582	Home Loan	recharge	\N	12.0	SUCCESS	127	2025-11-26 13:28:56.873905	2025-11-26 13:28:56.873905	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7887878798	\N	\N
564	TXN272124	HDFC	recharge	\N	111.0	SUCCESS	127	2025-11-26 13:29:29.574363	2025-11-26 13:29:29.574363	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7658767578	\N	\N
565	TXN335356	card	recharge	\N	111.0	SUCCESS	127	2025-11-26 13:30:04.220991	2025-11-26 13:30:04.220991	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N	\N
566	TXN669866	XYZ	rent_payment	\N	566.0	SUCCESS	127	2025-11-26 13:31:05.781009	2025-11-26 13:31:05.781009	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8789789787	\N	\N
567	TXN644718	Airtel	Recharge	\N	11.0	SUCCESS	175	2025-11-27 09:00:50.069772	2025-11-27 09:00:50.069772	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9999999999	\N	\N
568	TXN906399	Bharat Gas	bill_payment	\N	20.0	SUCCESS	175	2025-11-27 09:54:53.095794	2025-11-27 09:54:53.095794	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7438643896	\N	\N
569	TXN171381	Airtel Prepaid	Recharge	\N	22.0	SUCCESS	127	2025-11-28 05:21:15.788551	2025-11-28 05:21:15.788551	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7455915805	\N	\N
570	TXN237505	Dish TV	Recharge	\N	1.0	SUCCESS	169	2025-12-03 08:56:39.545921	2025-12-03 08:56:39.545921	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	888888888888	\N	\N
571	TXN386955	Dish TV	Recharge	\N	1.0	SUCCESS	169	2025-12-03 08:59:17.151486	2025-12-03 08:59:17.151486	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	888888888888	\N	\N
572	TXN888118	Dish TV	Recharge	\N	1.0	SUCCESS	169	2025-12-03 08:59:47.943452	2025-12-03 08:59:47.943452	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	888888888888	\N	\N
573	TXN286775	Dish TV	Recharge	\N	1.0	SUCCESS	169	2025-12-03 09:02:00.093388	2025-12-03 09:02:00.093388	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	888888888888	\N	\N
574	TXN885519	Dish TV	Recharge	\N	1.0	SUCCESS	169	2025-12-03 12:07:46.001244	2025-12-03 12:07:46.001244	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	77777777777	\N	\N
575	TXN875422	N/A	recharge	\N	1089.54	SUCCESS	169	2025-12-05 06:56:21.364464	2025-12-05 06:56:21.364464	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2222222222	\N	\N
576	TXN499386	N/A	recharge	\N	1089.54	SUCCESS	169	2025-12-05 07:34:32.801233	2025-12-05 07:34:32.801233	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9999999999	\N	\N
577	TXN644026	Gwalior Municipal Corporation - Water	recharge	\N	1089.54	SUCCESS	169	2025-12-05 08:53:47.177214	2025-12-05 08:53:47.177214	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5555555555	\N	\N
578	TXN400085	Paul Merchants	recharge	\N	1.0	SUCCESS	169	2025-12-08 08:46:21.294183	2025-12-08 08:46:21.294183	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8585964852	\N	\N
579	TXN190825	Jio Prepaid	Recharge	\N	19.0	SUCCESS	127	2025-12-08 11:17:48.832306	2025-12-08 11:17:48.832306	11	\N	\N	\N	\N	\N	3513999670	0.003078	\N	\N	\N	SUCCESS	Success	0.1539	9305096443	\N	\N
580	TXN794269	Axis Bank Credit Card	recharge	\N	3244.04	SUCCESS	139	2025-12-09 10:16:32.23945	2025-12-09 10:16:32.23945	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
581	TXN335605	IDBI Bank Fastag	recharge	\N	1.0	SUCCESS	139	2025-12-10 09:51:32.310886	2025-12-10 09:51:32.310886	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N	\N
582	TXN635857	IDBI Bank Fastag	recharge	\N	3.0	SUCCESS	139	2025-12-11 09:35:55.131241	2025-12-11 09:35:55.131241	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9598687788	\N	\N
583	TXN692706	IDBI Bank Fastag	recharge	\N	6.0	SUCCESS	176	2025-12-11 10:01:59.893176	2025-12-11 10:01:59.893176	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9743895734	\N	\N
584	TXN504494	IDBI Bank Fastag	recharge	\N	2.0	SUCCESS	176	2025-12-11 10:21:47.277519	2025-12-11 10:21:47.277519	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9222222222	\N	\N
585	TXN400683	IDBI Bank Fastag	recharge	\N	1.0	SUCCESS	176	2025-12-11 10:23:28.178836	2025-12-11 10:23:28.178836	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8111111888	UP16EM6388	\N
586	TXN579918	IDBI Bank Fastag	recharge	\N	12.0	SUCCESS	176	2025-12-11 12:15:41.480901	2025-12-11 12:15:41.480901	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	UP16EM6388	\N
587	TXN395634	Jio Prepaid	Recharge	\N	1.0	SUCCESS	176	2025-12-12 06:07:50.153521	2025-12-12 06:07:50.153521	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N	\N
588	TXN261754	Jio Prepaid	Recharge	\N	1.0	SUCCESS	176	2025-12-12 09:52:26.613734	2025-12-12 09:52:26.613734	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N	\N
589	TXN994255	Jio Prepaid	Recharge	\N	1.0	SUCCESS	139	2025-12-12 09:57:56.93042	2025-12-12 09:57:56.93042	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N	\N
590	TXN514943	Airtel Prepaid	Recharge	\N	11.0	SUCCESS	139	2025-12-12 11:24:57.23813	2025-12-12 11:24:57.23813	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7867856868	\N	\N
591	TXN897828	Jio Prepaid	Recharge	\N	1.0	SUCCESS	177	2025-12-12 11:55:00.464033	2025-12-12 11:55:00.464033	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8888888888	\N	\N
592	TXN715862	Jio Prepaid	Recharge	\N	10.0	SUCCESS	127	2025-12-13 08:47:23.5463	2025-12-13 08:47:23.5463	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8098098798	\N	\N
593	TXN739206	Airtel Prepaid	Recharge	\N	1.0	SUCCESS	127	2025-12-13 08:53:57.200309	2025-12-13 08:53:57.200309	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8080809809	\N	\N
594	TXN400297	Jio Prepaid	Recharge	\N	10.0	SUCCESS	127	2025-12-13 09:10:01.787012	2025-12-13 09:10:01.787012	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7879797899	\N	\N
595	TXN997817	Jio Prepaid	Recharge	\N	1.0	SUCCESS	139	2025-12-18 06:29:25.520857	2025-12-18 06:29:25.520857	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N	\N
596	TXN502816	Jio Prepaid	Recharge	\N	1.0	SUCCESS	176	2025-12-18 07:23:09.550508	2025-12-18 07:23:09.550508	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N	\N
597	TXN509463	Jio Prepaid	Recharge	\N	1.0	SUCCESS	139	2025-12-25 04:40:30.219329	2025-12-25 04:40:30.219329	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
598	TXN971966	Jio Prepaid	Recharge	\N	10.0	SUCCESS	127	2025-12-25 11:46:43.42104	2025-12-25 11:46:43.42104	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
599	TXN830175	Jio Prepaid	Recharge	\N	19.0	SUCCESS	127	2025-12-25 11:49:41.653941	2025-12-25 11:49:41.653941	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9337691368	\N	\N
600	TXN406781	Jio Prepaid	Recharge	\N	10.0	SUCCESS	127	2025-12-26 06:01:30.093541	2025-12-26 06:01:30.093541	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8969878978	\N	\N
601	TXN610700	IDBI Bank Fastag	recharge	\N	1.0	SUCCESS	127	2025-12-26 06:14:25.294092	2025-12-26 06:14:25.294092	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9305096443	UP16EM6388	\N
602	TXN821199	Axis Bank Credit Card	recharge	\N	9067.65	SUCCESS	127	2025-12-26 06:16:00.02169	2025-12-26 06:16:00.02169	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
603	TXN448968	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-26 07:04:41.907186	2025-12-26 07:04:41.907186	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9787987897	\N	\N
604	TXN593633	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-26 07:08:52.294776	2025-12-26 07:08:52.294776	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8888888888	\N	\N
605	TXN503031	North Bihar Power	bill_payment	\N	100.0	SUCCESS	139	2025-12-26 11:27:51.310747	2025-12-26 11:27:51.310747	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9999999999	\N	\N
606	TXN997349	North Bihar Power	bill_payment	\N	100.0	SUCCESS	139	2025-12-26 11:43:30.157637	2025-12-26 11:43:30.157637	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9999999999	\N	\N
607	TXN549091	North Bihar Power	bill_payment	\N	100.0	SUCCESS	139	2025-12-26 11:53:18.711832	2025-12-26 11:53:18.711832	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9999999999	\N	\N
608	TXN475703	North Bihar Power	bill_payment	\N	100.0	SUCCESS	139	2025-12-26 11:58:11.046434	2025-12-26 11:58:11.046434	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9999999999	\N	\N
609	TXN609223	North Bihar Power	bill_payment	\N	100.0	SUCCESS	139	2025-12-26 12:04:31.176331	2025-12-26 12:04:31.176331	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9999999999	\N	\N
610	TXN195054	North Bihar Power	bill_payment	\N	100.0	SUCCESS	139	2025-12-26 12:06:34.860342	2025-12-26 12:06:34.860342	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9999999999	\N	\N
611	TXN778865	North Bihar Power	bill_payment	\N	100.0	SUCCESS	139	2025-12-26 12:14:42.662742	2025-12-26 12:14:42.662742	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9999999999	\N	\N
612	TXN468138	North Bihar Power	bill_payment	\N	100.0	SUCCESS	127	2025-12-27 06:11:09.073951	2025-12-27 06:11:09.073951	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9867969876	\N	\N
613	TXN840377	Indraprastha Gas	bill_payment	\N	758.76	SUCCESS	127	2025-12-27 06:16:19.019382	2025-12-27 06:16:19.019382	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7000289745	\N	\N
614	TXN233559	Dish TV	Recharge	\N	1.0	SUCCESS	139	2025-12-27 06:53:56.484953	2025-12-27 06:53:56.484953	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N	\N
615	TXN854013	BIG TV DTH	Recharge	\N	1.0	SUCCESS	139	2025-12-27 07:00:49.192102	2025-12-27 07:00:49.192102	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N	\N
616	TXN797224	Airtel DTH	Recharge	\N	1.0	SUCCESS	139	2025-12-27 07:08:11.112468	2025-12-27 07:08:11.112468	13	siddddddddd	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8888888888	\N	\N
617	TXN877552	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	139	2025-12-27 08:34:33.502824	2025-12-27 08:34:33.502824	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
620	TXN201064	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	139	2025-12-27 08:38:40.743952	2025-12-27 08:38:40.743952	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
621	TXN571237	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	139	2025-12-27 08:40:14.708989	2025-12-27 08:40:14.708989	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
622	TXN807165	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	139	2025-12-27 08:42:25.880911	2025-12-27 08:42:25.880911	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
623	TXN370120	Jio Prepaid	Recharge	\N	1.0	SUCCESS	139	2025-12-27 08:43:12.792108	2025-12-27 08:43:12.792108	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8888888888	\N	\N
624	TXN988957	Kotak Mahindra Bank Ltd.-Loans	recharge	\N	18869.73	SUCCESS	127	2025-12-27 08:44:00.878935	2025-12-27 08:44:00.878935	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7697697696	\N	\N
625	TXN107561	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	139	2025-12-27 08:48:10.899092	2025-12-27 08:48:10.899092	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
626	TXN231594	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	139	2025-12-27 08:48:42.1542	2025-12-27 08:48:42.1542	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
627	TXN564130	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	139	2025-12-27 08:49:36.528318	2025-12-27 08:49:36.528318	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
632	TXN655284	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	139	2025-12-27 08:55:29.675242	2025-12-27 08:55:29.675242	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
635	TXN478155	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	139	2025-12-27 08:57:43.693425	2025-12-27 08:57:43.693425	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
637	TXN929259	Kotak Mahindra Bank Ltd.-Loans	recharge	\N	18869.73	SUCCESS	127	2025-12-27 08:58:54.753993	2025-12-27 08:58:54.753993	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9878998797	\N	\N
638	TXN983721	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 08:59:07.563433	2025-12-27 08:59:07.563433	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
639	TXN703070	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 09:00:20.975882	2025-12-27 09:00:20.975882	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
640	TXN469821	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 09:01:56.372308	2025-12-27 09:01:56.372308	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
641	TXN345913	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 09:02:52.216839	2025-12-27 09:02:52.216839	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
642	TXN452785	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 09:11:08.952497	2025-12-27 09:11:08.952497	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
643	TXN670884	Kotak Mahindra Bank Ltd.-Loans	recharge	\N	18869.73	SUCCESS	127	2025-12-27 09:14:37.467824	2025-12-27 09:14:37.467824	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8798789789	\N	\N
644	TXN908961	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 09:16:44.932368	2025-12-27 09:16:44.932368	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
645	TXN768850	IDBI Bank Fastag	recharge	\N	10.0	SUCCESS	127	2025-12-27 09:19:39.892584	2025-12-27 09:19:39.892584	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7698689698	UP16EM6388	\N
646	TXN255029	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 09:23:13.253187	2025-12-27 09:23:13.253187	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
647	TXN796182	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 09:23:39.615716	2025-12-27 09:23:39.615716	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
648	TXN752194	IDBI Bank Fastag	recharge	\N	11.0	SUCCESS	127	2025-12-27 09:27:34.348329	2025-12-27 09:27:34.348329	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6575757665	UP16EM6388	\N
649	TXN473541	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 09:31:19.98574	2025-12-27 09:31:19.98574	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
650	TXN542163	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 09:31:54.334402	2025-12-27 09:31:54.334402	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
651	TXN642818	Axis Bank Credit Card	recharge	\N	9067.65	SUCCESS	127	2025-12-27 09:35:06.523338	2025-12-27 09:35:06.523338	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
652	TXN953674	Airtel Prepaid	Recharge	\N	11.0	SUCCESS	127	2025-12-27 09:36:46.794527	2025-12-27 09:36:46.794527	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8979878789	\N	\N
653	TXN682163	Connect Broadband	recharge	\N	1.0	SUCCESS	139	2025-12-27 09:40:31.035655	2025-12-27 09:40:31.035655	12	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7000289745	\N	\N
654	TXN558001	Vi Postpaid	Recharge	\N	650.17	SUCCESS	127	2025-12-27 09:41:23.474623	2025-12-27 09:41:23.474623	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9891770022	\N	\N
655	TXN168270	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:00:05.341515	2025-12-27 10:00:05.341515	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
656	TXN132091	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:00:42.104964	2025-12-27 10:00:42.104964	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
657	TXN830717	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:01:33.739763	2025-12-27 10:01:33.739763	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
658	TXN971283	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:04:13.812862	2025-12-27 10:04:13.812862	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
659	TXN816834	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:09:00.660658	2025-12-27 10:09:00.660658	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
660	TXN743665	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:09:48.39551	2025-12-27 10:09:48.39551	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
661	TXN160818	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:11:26.165063	2025-12-27 10:11:26.165063	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
662	TXN834517	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:14:24.276126	2025-12-27 10:14:24.276126	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
663	TXN638771	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:15:06.574958	2025-12-27 10:15:06.574958	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
664	TXN722534	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:15:57.778653	2025-12-27 10:15:57.778653	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
665	TXN272973	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:16:47.289404	2025-12-27 10:16:47.289404	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
666	TXN740773	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:17:41.692402	2025-12-27 10:17:41.692402	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
667	TXN858875	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:19:37.168882	2025-12-27 10:19:37.168882	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
668	TXN547209	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:20:56.932873	2025-12-27 10:20:56.932873	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
669	TXN123703	North Bihar Power	bill_payment	\N	100.0	SUCCESS	127	2025-12-27 10:24:28.634043	2025-12-27 10:24:28.634043	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7998789789	\N	\N
670	TXN213132	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:26:00.532967	2025-12-27 10:26:00.532967	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
671	TXN641952	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:26:40.935266	2025-12-27 10:26:40.935266	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
672	TXN825326	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:28:09.822765	2025-12-27 10:28:09.822765	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
673	TXN683355	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:28:25.815527	2025-12-27 10:28:25.815527	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
674	TXN746782	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:28:37.789856	2025-12-27 10:28:37.789856	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N	\N
675	TXN311010	Indraprastha Gas	bill_payment	\N	758.76	SUCCESS	127	2025-12-27 10:34:20.773175	2025-12-27 10:34:20.773175	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7000289745	\N	\N
676	TXN248527	Connect Broadband	recharge	\N	2.0	SUCCESS	139	2025-12-27 10:39:31.415832	2025-12-27 10:39:31.415832	12	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7000289745	\N	\N
677	TXN775297	Connect Broadband	recharge	\N	3.0	SUCCESS	139	2025-12-27 10:48:19.527961	2025-12-27 10:48:19.527961	12	manikant	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7000289745	\N	\N
678	TXN973589	Connect Broadband	recharge	\N	4.0	SUCCESS	139	2025-12-27 10:57:10.553536	2025-12-27 10:57:10.553536	12	rajjuu dalle	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7000289745	\N	\N
679	TXN204675	North Bihar Power	bill_payment	\N	100.0	SUCCESS	127	2025-12-27 11:00:21.175323	2025-12-27 11:00:21.175323	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8977987987	\N	\N
680	TXN123298	North Bihar Power	bill_payment	\N	100.0	SUCCESS	127	2025-12-27 11:05:24.812603	2025-12-27 11:05:24.812603	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9869876686	\N	\N
681	TXN571439	Jio Prepaid	Recharge	\N	19.0	SUCCESS	189	2026-05-27 13:28:37.615791	2026-05-27 13:28:37.615791	11	\N	\N	\N	\N	\N	3562227007	0.003078	\N	\N	\N	SUCCESS	Success	0.1539	9337691368	\N	\N
682	TXN557807	Jio Prepaid	Recharge	\N	239.0	SUCCESS	127	2026-06-11 09:58:26.532181	2026-06-11 09:58:26.532181	11	\N	\N	\N	\N	\N	3564345956	0.038718	\N	\N	\N	SUCCESS	Success	1.9359	8882389248	\N	\N
683	TXN362988	Jio Prepaid	Recharge	\N	239.0	SUCCESS	127	2026-06-17 07:50:22.402387	2026-06-17 07:50:22.402387	11	\N	\N	\N	\N	\N	3565200301	0.038718	\N	\N	\N	SUCCESS	Success	1.9359	9310525754	\N	\N
\.


--
-- Data for Name: user_services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_services (id, assigner_id, assignee_id, service_id, created_at, updated_at) FROM stdin;
1	104	118	1	2025-09-02 07:20:02.736088	2025-09-02 07:20:02.736088
2	104	118	2	2025-09-02 07:20:02.74618	2025-09-02 07:20:02.74618
4	104	119	1	2025-09-02 07:38:16.845599	2025-09-02 07:38:16.845599
5	104	120	1	2025-09-02 09:12:04.754181	2025-09-02 09:12:04.754181
6	104	120	2	2025-09-02 09:12:04.768069	2025-09-02 09:12:04.768069
7	104	125	1	2025-09-02 09:26:07.006615	2025-09-02 09:26:07.006615
8	104	125	2	2025-09-02 09:26:07.019803	2025-09-02 09:26:07.019803
9	104	126	1	2025-09-02 09:33:16.816745	2025-09-02 09:33:16.816745
10	104	126	2	2025-09-02 09:33:16.829728	2025-09-02 09:33:16.829728
11	104	127	1	2025-09-02 09:38:43.057328	2025-09-02 09:38:43.057328
12	104	127	2	2025-09-02 09:38:43.068864	2025-09-02 09:38:43.068864
14	104	127	4	2025-09-02 09:38:43.089523	2025-09-02 09:38:43.089523
16	104	134	2	2025-09-02 11:52:46.169279	2025-09-02 11:52:46.169279
19	104	134	1	2025-09-02 11:52:46.197359	2025-09-02 11:52:46.197359
20	104	134	4	2025-09-02 11:52:46.20663	2025-09-02 11:52:46.20663
22	104	134	7	2025-09-02 11:52:46.226589	2025-09-02 11:52:46.226589
23	104	134	8	2025-09-02 11:52:46.236134	2025-09-02 11:52:46.236134
24	104	127	7	2025-09-04 06:56:06.333176	2025-09-04 06:56:06.333176
26	136	138	1	2025-09-04 08:45:42.541177	2025-09-04 08:45:42.541177
27	136	138	4	2025-09-04 08:45:42.552069	2025-09-04 08:45:42.552069
28	136	138	8	2025-09-04 08:45:42.562555	2025-09-04 08:45:42.562555
29	136	138	2	2025-09-04 08:45:42.572578	2025-09-04 08:45:42.572578
30	136	138	7	2025-09-04 08:45:42.586653	2025-09-04 08:45:42.586653
32	138	139	1	2025-09-04 09:05:42.93893	2025-09-04 09:05:42.93893
33	138	139	4	2025-09-04 09:05:42.950946	2025-09-04 09:05:42.950946
34	138	139	2	2025-09-04 09:05:42.960377	2025-09-04 09:05:42.960377
35	138	139	7	2025-09-04 09:05:42.969305	2025-09-04 09:05:42.969305
37	136	140	1	2025-09-04 18:29:32.039959	2025-09-04 18:29:32.039959
38	136	140	4	2025-09-04 18:29:32.050901	2025-09-04 18:29:32.050901
39	136	140	2	2025-09-04 18:29:32.062535	2025-09-04 18:29:32.062535
40	136	140	7	2025-09-04 18:29:32.071386	2025-09-04 18:29:32.071386
42	136	141	1	2025-09-04 18:35:04.279798	2025-09-04 18:35:04.279798
43	136	141	4	2025-09-04 18:35:04.301142	2025-09-04 18:35:04.301142
44	136	141	2	2025-09-04 18:35:04.31442	2025-09-04 18:35:04.31442
45	136	141	7	2025-09-04 18:35:04.32646	2025-09-04 18:35:04.32646
47	141	142	1	2025-09-04 18:41:03.664784	2025-09-04 18:41:03.664784
48	141	142	4	2025-09-04 18:41:03.689181	2025-09-04 18:41:03.689181
49	141	142	2	2025-09-04 18:41:03.704711	2025-09-04 18:41:03.704711
50	141	142	7	2025-09-04 18:41:03.718926	2025-09-04 18:41:03.718926
52	104	127	13	2025-09-08 09:24:54.030865	2025-09-08 09:24:54.030865
54	104	127	15	2025-09-19 14:21:36.57837	2025-09-19 14:21:36.57837
55	152	152	7	2025-10-11 11:51:14.290072	2025-10-11 11:51:14.290072
56	152	151	7	2025-10-11 12:05:23.779737	2025-10-11 12:05:23.779737
57	104	154	1	2025-11-15 05:42:26.615242	2025-11-15 05:42:26.615242
58	104	154	2	2025-11-15 05:42:26.633917	2025-11-15 05:42:26.633917
65	104	155	7	2025-11-15 10:37:54.991226	2025-11-15 10:37:54.991226
66	104	155	15	2025-11-15 10:37:55.006463	2025-11-15 10:37:55.006463
67	104	155	1	2025-11-15 10:37:55.014474	2025-11-15 10:37:55.014474
68	136	104	8	2025-11-15 10:45:41.200484	2025-11-15 10:45:41.200484
69	136	104	7	2025-11-15 10:45:41.208867	2025-11-15 10:45:41.208867
71	136	104	4	2025-11-15 10:45:41.223683	2025-11-15 10:45:41.223683
72	136	104	15	2025-11-15 10:45:41.230723	2025-11-15 10:45:41.230723
73	104	157	7	2025-11-15 18:22:08.278241	2025-11-15 18:22:08.278241
74	104	157	15	2025-11-15 18:22:08.292329	2025-11-15 18:22:08.292329
75	104	157	1	2025-11-15 18:22:08.30682	2025-11-15 18:22:08.30682
76	104	158	1	2025-11-15 18:43:44.571935	2025-11-15 18:43:44.571935
77	104	158	7	2025-11-15 18:43:44.582866	2025-11-15 18:43:44.582866
78	104	158	15	2025-11-15 18:43:44.591158	2025-11-15 18:43:44.591158
79	104	159	1	2025-11-15 18:44:39.652665	2025-11-15 18:44:39.652665
80	104	159	7	2025-11-15 18:44:39.664368	2025-11-15 18:44:39.664368
81	104	159	15	2025-11-15 18:44:39.675145	2025-11-15 18:44:39.675145
85	136	104	1	2025-11-15 19:17:02.2899	2025-11-15 19:17:02.2899
86	104	161	8	2025-11-15 19:22:43.456012	2025-11-15 19:22:43.456012
87	104	161	1	2025-11-15 19:22:43.460475	2025-11-15 19:22:43.460475
88	104	161	7	2025-11-15 19:22:43.465408	2025-11-15 19:22:43.465408
89	104	161	4	2025-11-15 19:22:43.471241	2025-11-15 19:22:43.471241
90	104	161	15	2025-11-15 19:22:43.475794	2025-11-15 19:22:43.475794
91	104	162	8	2025-11-15 19:48:53.389844	2025-11-15 19:48:53.389844
92	104	162	1	2025-11-15 19:48:53.396254	2025-11-15 19:48:53.396254
93	104	162	7	2025-11-15 19:48:53.401602	2025-11-15 19:48:53.401602
94	104	163	8	2025-11-15 19:50:09.595728	2025-11-15 19:50:09.595728
95	104	163	1	2025-11-15 19:50:09.600035	2025-11-15 19:50:09.600035
96	104	163	7	2025-11-15 19:50:09.604262	2025-11-15 19:50:09.604262
97	104	164	8	2025-11-15 20:22:16.573276	2025-11-15 20:22:16.573276
98	104	164	1	2025-11-15 20:22:16.578726	2025-11-15 20:22:16.578726
99	104	164	4	2025-11-15 20:22:16.583915	2025-11-15 20:22:16.583915
100	104	164	7	2025-11-15 20:22:16.588163	2025-11-15 20:22:16.588163
101	104	164	15	2025-11-15 20:22:16.59312	2025-11-15 20:22:16.59312
102	104	165	8	2025-11-15 20:23:26.548899	2025-11-15 20:23:26.548899
103	104	165	1	2025-11-15 20:23:26.553139	2025-11-15 20:23:26.553139
104	104	165	4	2025-11-15 20:23:26.55877	2025-11-15 20:23:26.55877
105	104	165	7	2025-11-15 20:23:26.564115	2025-11-15 20:23:26.564115
106	104	165	15	2025-11-15 20:23:26.56835	2025-11-15 20:23:26.56835
107	104	166	8	2025-11-15 20:35:17.218201	2025-11-15 20:35:17.218201
108	104	166	1	2025-11-15 20:35:17.223068	2025-11-15 20:35:17.223068
109	104	167	8	2025-11-15 20:37:43.865342	2025-11-15 20:37:43.865342
110	104	167	7	2025-11-15 20:37:43.8767	2025-11-15 20:37:43.8767
111	104	167	4	2025-11-15 20:37:43.884223	2025-11-15 20:37:43.884223
117	104	168	7	2025-11-16 14:02:05.058115	2025-11-16 14:02:05.058115
119	104	168	15	2025-11-16 14:02:05.073227	2025-11-16 14:02:05.073227
120	104	168	1	2025-11-16 14:02:05.080526	2025-11-16 14:02:05.080526
123	104	168	4	2025-11-16 14:17:38.461059	2025-11-16 14:17:38.461059
125	136	103	7	2025-11-19 05:44:53.039132	2025-11-19 05:44:53.039132
126	136	103	8	2025-11-19 05:45:31.115221	2025-11-19 05:45:31.115221
127	136	103	1	2025-11-19 05:45:31.124255	2025-11-19 05:45:31.124255
128	136	103	4	2025-11-19 05:45:31.133607	2025-11-19 05:45:31.133607
129	136	103	15	2025-11-19 05:45:31.14138	2025-11-19 05:45:31.14138
130	136	139	15	2025-11-20 10:13:32.351962	2025-11-20 10:13:32.351962
131	104	169	7	2025-11-24 06:24:00.108186	2025-11-24 06:24:00.108186
132	104	169	15	2025-11-24 06:24:00.114119	2025-11-24 06:24:00.114119
133	169	170	7	2025-11-25 11:05:23.123976	2025-11-25 11:05:23.123976
134	169	170	15	2025-11-25 11:05:23.135016	2025-11-25 11:05:23.135016
135	169	171	7	2025-11-26 06:21:56.526795	2025-11-26 06:21:56.526795
136	169	171	15	2025-11-26 06:21:56.536646	2025-11-26 06:21:56.536646
137	169	172	7	2025-11-26 12:04:06.74259	2025-11-26 12:04:06.74259
138	169	172	15	2025-11-26 12:04:06.753557	2025-11-26 12:04:06.753557
139	169	173	7	2025-11-26 12:09:10.935163	2025-11-26 12:09:10.935163
140	169	173	15	2025-11-26 12:09:10.947522	2025-11-26 12:09:10.947522
141	169	174	7	2025-11-26 12:42:31.327308	2025-11-26 12:42:31.327308
142	169	174	15	2025-11-26 12:42:31.337748	2025-11-26 12:42:31.337748
143	169	175	7	2025-11-27 07:35:22.966214	2025-11-27 07:35:22.966214
144	169	175	15	2025-11-27 07:35:22.974121	2025-11-27 07:35:22.974121
145	104	176	7	2025-12-11 09:47:11.915075	2025-12-11 09:47:11.915075
146	104	177	15	2025-12-12 09:21:57.470617	2025-12-12 09:21:57.470617
147	104	177	7	2025-12-12 09:21:57.477905	2025-12-12 09:21:57.477905
148	103	178	7	2025-12-18 09:49:00.973618	2025-12-18 09:49:00.973618
149	103	178	15	2025-12-18 09:49:00.982666	2025-12-18 09:49:00.982666
150	104	179	7	2025-12-22 07:05:41.215586	2025-12-22 07:05:41.215586
151	104	179	15	2025-12-22 07:05:41.225053	2025-12-22 07:05:41.225053
152	104	179	1	2025-12-22 07:05:41.231081	2025-12-22 07:05:41.231081
153	136	127	18	2025-12-22 09:05:20.879486	2025-12-22 09:05:20.879486
154	136	180	7	2025-12-23 05:42:08.267085	2025-12-23 05:42:08.267085
155	136	180	18	2025-12-23 05:42:08.281875	2025-12-23 05:42:08.281875
156	136	181	2	2026-05-25 08:49:37.630514	2026-05-25 08:49:37.630514
157	136	181	13	2026-05-25 08:49:37.64217	2026-05-25 08:49:37.64217
158	136	181	7	2026-05-25 08:49:37.652108	2026-05-25 08:49:37.652108
159	136	181	1	2026-05-25 08:49:37.6619	2026-05-25 08:49:37.6619
160	136	181	4	2026-05-25 08:49:37.671404	2026-05-25 08:49:37.671404
161	136	181	15	2026-05-25 08:49:37.68106	2026-05-25 08:49:37.68106
162	136	181	18	2026-05-25 08:49:37.691067	2026-05-25 08:49:37.691067
163	181	183	2	2026-05-26 18:10:46.548249	2026-05-26 18:10:46.548249
164	181	183	7	2026-05-26 18:10:46.552143	2026-05-26 18:10:46.552143
165	181	183	4	2026-05-26 18:10:46.555938	2026-05-26 18:10:46.555938
166	181	183	15	2026-05-26 18:10:46.559717	2026-05-26 18:10:46.559717
167	181	183	1	2026-05-26 18:10:46.563543	2026-05-26 18:10:46.563543
168	181	183	13	2026-05-26 18:10:46.56756	2026-05-26 18:10:46.56756
169	181	183	18	2026-05-26 18:10:46.571427	2026-05-26 18:10:46.571427
170	181	184	13	2026-05-26 18:20:55.281038	2026-05-26 18:20:55.281038
171	181	184	2	2026-05-26 18:20:55.284918	2026-05-26 18:20:55.284918
172	181	184	7	2026-05-26 18:20:55.2885	2026-05-26 18:20:55.2885
173	181	184	1	2026-05-26 18:20:55.292178	2026-05-26 18:20:55.292178
174	181	184	4	2026-05-26 18:20:55.295909	2026-05-26 18:20:55.295909
175	181	184	15	2026-05-26 18:20:55.299598	2026-05-26 18:20:55.299598
176	181	184	18	2026-05-26 18:20:55.303366	2026-05-26 18:20:55.303366
177	104	185	4	2026-05-27 04:57:46.934032	2026-05-27 04:57:46.934032
178	104	185	8	2026-05-27 04:57:46.938499	2026-05-27 04:57:46.938499
179	104	185	7	2026-05-27 04:57:46.942421	2026-05-27 04:57:46.942421
180	104	185	15	2026-05-27 04:57:46.946248	2026-05-27 04:57:46.946248
181	104	186	8	2026-05-27 04:59:27.806378	2026-05-27 04:59:27.806378
182	104	186	4	2026-05-27 04:59:27.810823	2026-05-27 04:59:27.810823
183	104	186	15	2026-05-27 04:59:27.815116	2026-05-27 04:59:27.815116
184	104	186	7	2026-05-27 04:59:27.819285	2026-05-27 04:59:27.819285
185	104	187	8	2026-05-27 07:00:39.19894	2026-05-27 07:00:39.19894
186	104	187	4	2026-05-27 07:00:39.203783	2026-05-27 07:00:39.203783
187	104	188	8	2026-05-27 07:02:09.749391	2026-05-27 07:02:09.749391
188	104	188	1	2026-05-27 07:02:09.753527	2026-05-27 07:02:09.753527
189	104	188	4	2026-05-27 07:02:09.757567	2026-05-27 07:02:09.757567
190	181	189	2	2026-05-27 07:46:14.747574	2026-05-27 07:46:14.747574
191	181	189	7	2026-05-27 07:46:14.75186	2026-05-27 07:46:14.75186
192	181	189	4	2026-05-27 07:46:14.758725	2026-05-27 07:46:14.758725
193	181	189	15	2026-05-27 07:46:14.762642	2026-05-27 07:46:14.762642
194	181	189	1	2026-05-27 07:46:14.766628	2026-05-27 07:46:14.766628
195	181	189	13	2026-05-27 07:46:14.770505	2026-05-27 07:46:14.770505
196	181	189	18	2026-05-27 07:46:14.774552	2026-05-27 07:46:14.774552
197	104	190	8	2026-05-29 09:57:50.65524	2026-05-29 09:57:50.65524
198	104	190	7	2026-05-29 09:57:50.65985	2026-05-29 09:57:50.65985
199	104	190	15	2026-05-29 09:57:50.663832	2026-05-29 09:57:50.663832
200	104	190	4	2026-05-29 09:57:50.667929	2026-05-29 09:57:50.667929
201	104	190	1	2026-05-29 09:57:50.671753	2026-05-29 09:57:50.671753
202	104	191	8	2026-05-29 10:42:48.293342	2026-05-29 10:42:48.293342
203	104	191	4	2026-05-29 10:42:48.297595	2026-05-29 10:42:48.297595
204	104	191	1	2026-05-29 10:42:48.301339	2026-05-29 10:42:48.301339
205	104	191	15	2026-05-29 10:42:48.305735	2026-05-29 10:42:48.305735
206	104	191	7	2026-05-29 10:42:48.309738	2026-05-29 10:42:48.309738
207	104	192	15	2026-05-29 11:08:32.366476	2026-05-29 11:08:32.366476
208	104	192	7	2026-05-29 11:08:32.370808	2026-05-29 11:08:32.370808
209	181	193	2	2026-05-29 12:01:04.774849	2026-05-29 12:01:04.774849
210	181	193	7	2026-05-29 12:01:04.78071	2026-05-29 12:01:04.78071
211	181	193	4	2026-05-29 12:01:04.785483	2026-05-29 12:01:04.785483
212	181	193	18	2026-05-29 12:01:04.790575	2026-05-29 12:01:04.790575
213	181	193	15	2026-05-29 12:01:04.795701	2026-05-29 12:01:04.795701
214	181	193	1	2026-05-29 12:01:04.800861	2026-05-29 12:01:04.800861
215	181	193	13	2026-05-29 12:01:04.805449	2026-05-29 12:01:04.805449
216	140	136	18	2026-07-03 09:07:55.117794	2026-07-03 09:07:55.117794
217	104	136	18	2026-07-03 09:08:24.260135	2026-07-03 09:08:24.260135
218	136	104	18	2026-07-03 09:08:44.950143	2026-07-03 09:08:44.950143
219	104	139	18	2026-07-03 09:08:55.447461	2026-07-03 09:08:55.447461
220	181	194	2	2026-07-06 11:08:18.823871	2026-07-06 11:08:18.823871
221	181	194	7	2026-07-06 11:08:18.925443	2026-07-06 11:08:18.925443
222	181	194	4	2026-07-06 11:08:18.966592	2026-07-06 11:08:18.966592
223	181	194	18	2026-07-06 11:08:19.044897	2026-07-06 11:08:19.044897
224	181	194	13	2026-07-06 11:08:19.223657	2026-07-06 11:08:19.223657
225	181	194	1	2026-07-06 11:08:19.321474	2026-07-06 11:08:19.321474
226	181	194	15	2026-07-06 11:08:19.362054	2026-07-06 11:08:19.362054
230	104	196	18	2026-07-27 12:46:07.067789	2026-07-27 12:46:07.067789
231	104	196	15	2026-07-27 12:46:07.078746	2026-07-27 12:46:07.078746
232	104	196	7	2026-07-27 12:46:07.23044	2026-07-27 12:46:07.23044
233	104	197	7	2026-08-03 09:17:38.112896	2026-08-03 09:17:38.112896
234	104	197	15	2026-08-03 09:17:38.3411	2026-08-03 09:17:38.3411
235	104	197	18	2026-08-03 09:17:38.348759	2026-08-03 09:17:38.348759
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, first_name, last_name, email, password_digest, role, otp, verify_otp, otp_expires_at, phone_number, country_code, alternative_number, aadhaar_number, pan_card, date_of_birth, gender, business_name, business_owner_type, business_nature_type, business_registration_number, gst_number, pan_number, address, city, state, pincode, landmark, username, scheme, referred_by, bank_name, account_number, ifsc_code, account_holder_name, notes, session_token, created_at, updated_at, role_id, status, company_type, company_name, cin_number, registration_certificate, user_admin_id, confirm_password, domain_name, scheme_id, service_id, pan_card_image, aadhaar_image, passport_photo, store_shop_photo, address_proof_photo, parent_id, set_pin, confirm_pin, latitude, longitude, captured_at, last_seen_at, ip_address, location, kyc_status, kyc_method, aadhaar_front_image, aadhaar_back_image, aadhaar_otp, pan_otp, pan_status, aadhaar_status, image, kyc_verifications, kyc_verified_at, kyc_data, set_mpin, status_mpin, email_otp_status, email_otp, email_otp_verified_at, set_pin_status, email_otp_sent_at, user_code, eko_onboard_first_step, eko_profile_second_step, eko_status_otp, eko_verify_otp, eko_biometric_kyc, vendor_otp, vendor_expiry_otp, vendor_verify_status, permanent_address, permanent_landmark, permanent_postal_code, permanent_city, permanent_state, permanent_pincode, aeps_kyc, daily_aeps_kyc, aeps_service_activate, aeps_latlong, login_in_time, logout_time, ip_city, ip_location, bank_code) FROM stdin;
114	Ishu	Dhariya	ishuadmin@gmail.com	$2a$12$T/n5QlXtlBYeDotJWBdBJOVk/ijEce5jj291F/HcLEmZNhSg7kcaq	\N	\N	\N	\N	89798798783	\N	03443434334	876876876867233	JKGJGHJ688978	2025-09-04		Credit card sales	Credit Business slove	buessiness s Nature Type	Credit Business Registration Number	986857644645cddsds	\N		noida	Uttar Pradesh	201301	\N	ishu8789	\N	HGG7897897	Axis	7988757678hgg	IFDD&775655	Retailers	\N	\N	2025-09-01 08:41:59.561116	2025-09-02 06:17:34.681616	9	f	\N	\N	\N	\N	\N	ishu4748	ishu123	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
145	\N	\N	\N	\N	\N	123456	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-19 06:57:28.114985	2025-09-19 06:58:31.945025	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
148	\N	\N	\N	\N	\N	\N	1	\N	68787676676	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	DPa27Kak5BHTa3MqDcJ1j1A1	2025-09-19 13:41:38.241268	2025-09-19 13:46:45.805757	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
112	Last check Amdin	done	check@gmail.com	$2a$12$Bjh7riJIdvYTdz/sw92mCeOzCLSuKbpPJQiXJ6ORd5quezZJRN.He	\N	\N	\N	\N	79879779887987	\N	8979878798798798798	876876876867233	JKGJGHJ688978	2025-08-23	Male	lkjljkjlkjlkjlkj	lkjljkjlkjlkjlkj	lkjljkjlkjlkjlkj	lkjljkjlkjlkjlkj	76867687	\N	noida 121	noida	Uttar Pradesh	201301	\N	sidtech78678	\N	HGG7897897	Axis	7988757678hgg	IFDD96875	Sidddddddd	\N	\N	2025-08-30 12:36:49.720661	2025-09-02 06:17:35.187671	9	t	\N	\N	\N	\N	\N	123456	sam	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
113	Alim Admin3	Khan	Alimadmin@gmail.com	$2a$12$On5F4IEhPEr.PL6Fm4RTxeKFE7fv1E4dgf2.RVhBKr0fEUJWBwY4K	\N	\N	\N	\N	8908099089898	\N	+919568773855	9867676757656	JKGJGHJ68768	2025-08-21		IT LOAN SOULTION	IT BUSINES LOAN SOLUTION	Business Nature Type	989878967678dsds	986857644645cddsds	\N		noida	Uttar Pradesh	201301	\N	Amir323	\N	123223	HDFC	687687676776876	IFDD96875	Alim Admin	\N	\N	2025-08-30 13:17:19.343681	2025-09-02 06:17:33.411207	9	f	\N	\N	\N	\N	\N	232323	aalimadmin	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
120	tetdsh	jdshdkhj	jkhjds9876876@gmai.com	$2a$12$xMdDNNMXc3SVwoTbqcVFEelMsXolKH0AF/w32okDTm7EYbyQg0guW	\N	\N	\N	\N	03443434334	\N	03443434334	9867676757656	JKGJGHJ688978	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	aaisihi	\N						\N	\N	2025-09-02 09:12:04.737004	2025-09-02 09:12:04.737004	9	f	\N	\N	\N	\N	\N		namesing	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
106	Saurav	\N	saurav@gmailcom	$2a$12$wIM6HuqbUxTEFYaLY9KFgOplYERTByO98kLvtapktuQFH8NoTXvgm	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-30 06:01:17.85221	2025-09-02 06:17:35.696542	9	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
107	dsds	\N	sam@gmail.com	$2a$12$Hv.Ohx3z53IyUtDSxDAqk.TyvwDRegxSf65iMOtMTCTWBI2hT4cvO	\N	\N	\N	\N	+919568773855	\N	\N	98798798798687	\N	\N	\N	\N	\N	\N	\N	4343	HJHJK87797J	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-30 06:36:54.886138	2025-09-02 06:17:35.951099	9	f	\N	fdd	\N	dfdss	0	123	sam	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
119	alminadmin	admin	lkjkljds@gmail.com	$2a$12$vWexdLFBSIC0IQHkUQV/Eez5mK4.Mih0h9vhPrynLAm4RMa/IVbb.	\N	\N	\N	\N	90990988433	\N	03443434334	7328728367	JKGJGHJ68768	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	siddharth343443	\N	HGG7897897	Axis	687687676776876	IFDD&775655		\N	\N	2025-09-02 07:38:16.83295	2025-09-02 07:39:10.796858	5	f	\N	\N	\N	\N	\N	123456	LK	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
121	dds	dsds	ddsds@gmail.com	\N	\N	\N	\N	\N	9879798787798	\N	33232323232443	9867676757656	JKGJGHJ688978	2025-09-01	Male						\N					\N								\N	\N	2025-09-02 09:16:50.279226	2025-09-02 09:16:50.279226	6	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
117	tetdsh admin	jdshdkhj	hjkhdkjshs@gmai.com	$2a$12$CTes.77NLRMBi14MAOTzpO7xjXKzM/koG9FrjrA2noQnEgGqLCovC	\N	\N	\N	\N	03443434334	\N	+919568773855	9867676757656	dskjds	2025-10-04	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	siddharth23232	\N		Axis	7988757678hgg	IFDD96875		\N	528bfc6ca23e1aec5b80e7ee858a5cb02bf3e74c	2025-09-02 07:00:17.967209	2025-09-02 07:39:52.558184	9	t	\N	\N	\N	\N	\N	123456	LK	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
64	Siddharth	gautam	sid203191@gmail.com	$2a$12$LqHXjK1ApiWq3Hdtiz3mxuMPapt7f27NScf4vRz1eQTSPpPgtoV/a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-27 06:06:23.479823	2025-09-02 06:17:34.174339	6	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
123	Ashok kumar	sing	ashok@gmail.com	$2a$12$6Bufd22R0bN7CqzzJvsSceaKNWhFmEWcBN.EPGtc.UuHh58VotZuK	\N	\N	\N	\N	7897879879	\N	98797987979	876876876867233	JKGJGHJ688978	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	Noida, Uttar Pradesh, India	Noida	Uttar Pradesh	ds233232	\N	ashok79798	paid	HGG7897897	Axis	7988757678hgg	IFDD96875	Ashok	\N	\N	2025-09-02 09:21:22.367274	2025-09-02 09:21:22.367274	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
124	dsds	dsds	dsds1111@gmail.com	$2a$12$I7eTYPo.Ih4CecQlup87LewDGANadhCEDdUo2.eAKu/C9OmdGmE12	\N	\N	\N	\N	dsds	\N	dsds	dsds	dsds	\N	Select gender	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	sidtech78678							\N	\N	2025-09-02 09:23:42.407569	2025-09-02 09:23:42.407569	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
126	don11	kumar	don11@gmail.com	$2a$12$GLHjSzVQr78G0W9erfWnzesHakQN4bSMj3HwMyOQvwkopolO1xpNS	\N	\N	\N	\N	876876876786	\N	03443434334	986767675765622	JKGJGHJ688978	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	don11	\N		Axis	7988757678hgg	IFDD&775655	don11	\N	\N	2025-09-02 09:33:16.802674	2025-09-02 09:33:16.802674	9	f	\N	\N	\N	\N	\N	123456		5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
125	tetdsh	jdshdkhj	hjkhdkjshs@gmai.com	$2a$12$Pmx8LzTfUgrLFuvjmMugO.BDDK11lPhWZl85hHztxVBgEUaQroU4C	\N	\N	\N	\N	03443434334	\N	+919568773855		JKGJGHJ68768	\N	Female						\N					\N		\N		Axis	7988757678hgg	IFDD&775655		\N	\N	2025-09-02 09:26:06.988697	2025-09-02 09:26:06.988697	9	f	\N	\N	\N	\N	\N			\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
118	Siddharth	gautam	sidtest@gmail.com	$2a$12$bScG9DTUcClpOFLZQsW4rulxWA5d1Fpr7VysITYFhasLWn5qV/5nS	\N	\N	\N	\N	+919568773855	\N	+919568773855	9867676757656	JKGJGHJ68768	\N	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	Gawalira	Saharanpur	Uttar Pradesh	247001	\N		\N						\N	47473b45a624cbf222a2f9a0dac6877bc37326f6	2025-09-02 07:20:02.690017	2025-09-04 06:17:17.446234	5	t	\N	\N	\N	\N	\N	123456	amdin788	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
128	Deepak	Kumar	deepak@gmail.com	$2a$12$Y2XkV2FZJtmtIP7yaWTI2.8ew.bgSdhtd6BsYc.CAgepA9xhro9Ni	\N	\N	\N	\N	897988798743	\N	89798879872	897988798712	JKGJGHJ68768DD	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	Noida, Uttar Pradesh, India	Noida	Uttar Pradesh	ds233232	\N	deepak989	paid	HGG7897897	\N	\N	\N	\N		ed55c486a63ceb93078fe6db507c241a1613898e	2025-09-02 11:37:19.658725	2025-09-02 11:42:17.407239	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
141	Shek	aalam	shek@gmail.com	$2a$12$eaEveK9bW2pC14ehDryUyeDBStZ8dShiTOSolTBmEgNuChyAMvGZG	\N	\N	\N	\N	9568773855	\N	9568773855	98798798798687	JKGJGHJ68768DD	2025-09-03	Male						\N					\N	Shak344343	\N		Axis	7988757678hgg	IFDD&775655	Alim	\N	\N	2025-09-04 18:35:04.24181	2026-07-27 12:48:29.314025	9	f	\N	\N	\N	\N	\N	shak123		5	\N	\N	\N	\N	\N	\N	136	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	38130026	t	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
129	mona	singh4	mona@gmail.com	$2a$12$GjElBj/SIW.avp5470ajG.lV6BnFnlY3TQ7s7MkoO6hIVWghO2pda	\N	\N	\N	\N		\N	65656565655	9877987877787	JKGJGHJ68768	2025-09-02	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	mona7768798	paid	HGG7897897	Axis	7988757678hgg	IFDD&775655	Alim	\N	1b057f28b4e935c66ab752e3839c07afa468158e	2025-09-02 11:43:35.893844	2025-09-02 11:44:42.105716	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
142	shek khan	Retailer	shekkhan@gmail.com	$2a$12$2nrtTrbL1IIh8t/wGGEP1egNqMkPL/4/EARaLsOdF0z/V0Dmr3yeS	\N	\N	\N	\N	+919568773855	\N	+919568773855	7328728367	JKGJGHJ688978	2025-09-03	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	shekkhan123	\N		Axis	7988757678hgg			\N	14acdc9b6da431369b865cb50874268cb315a0fb	2025-09-04 18:41:03.59699	2025-09-04 18:42:56.490229	5	t	\N	\N	\N	\N	\N	123456	\N	5	\N	\N	\N	\N	\N	\N	141	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
138	Mohammad Admin	8989898989	mohammad@gmail.com	$2a$12$4jWbmFwYnqIlkWx8QC9vLuPPEmNT.UaBis5VRhtMdUAx8tHcIrQ4u	\N	\N	\N	\N	787987987988	\N	89798787783	7788978798334	JKGJGHJ68768DD	2025-09-03	Male	Credit card sales	Credit Business slove	Credit Business Nature Type	Credit Business Registration Number	798797d87ds797ds987987	\N	noida 121	noida	Uttar Pradesh	201301	\N	mohd28982	\N	HGG789789778	Axis	687687676776876	IFDD&775655	mohd787	\N	\N	2025-09-04 08:45:42.495292	2025-09-12 12:09:43.049315	9	f	\N	\N	\N	\N	\N	mohd123	mohdshek	5	\N	\N	\N	\N	\N	\N	136	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
140	admin2	gautam	admin2@gmail.com	$2a$12$9WcYcbPvfwTR8r4ns5Fi7eQQ6LnaCIUZkiUj9vQAycYH.Pv8TvD9.	\N	\N	\N	\N	89898808888	\N	89898808888	9867676757656	JKGJGHJ688978	\N	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	sidtech78678	\N		Axis				\N	\N	2025-09-04 18:29:32.002565	2025-09-04 18:29:32.002565	9	f	\N	\N	\N	\N	\N	123456		5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
147	\N	\N	\N	\N	\N	\N	1	\N	123456	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6ePqqfFnT29yH3G51Dp315mk	2025-09-19 07:09:44.153081	2025-09-19 07:14:34.989503	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
146	\N	\N	\N	\N	\N	123456	0	\N	98797979798	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-19 07:04:43.110042	2025-09-19 07:18:30.274639	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
134	Siddharth	gautam	sid20312229@gmail.com	$2a$12$lrXflu..qyuzpcCmyJ.QeuOyWbRfzWaZ4mW6a4nJ6GDK705C8smum	\N	\N	\N	\N	9568773855	\N				\N	Select gender	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	siddharth	\N		HDFC				\N	bca6e4a1a997af7cab95c78b6c22452f122e544e	2025-09-02 11:52:46.12845	2025-09-19 12:05:13.940195	5	t	\N	\N	\N	\N	\N	123456		16	\N	\N	\N	\N	\N	\N	104	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
157	Rahul	Sharma	rahul1@example.com	$2a$12$/YJFZ8pPqF4ewj2Gd1dUxuA.KOpSuS2A3mOB//TexgY.r3azgzO1S	\N	\N	\N	\N	9876543210	+91	9876500000	123412341234	ABCDE1234F	1995-06-10	male	Rahul Mobile Shop	Individual	Electronics	BRN123456	07ABCDE1234F1Z5	ABCDE1234F	Main Market	Delhi	Delhi	110001	Near Metro Station	rahulshop	\N	Admin	HDFC Bank	123456789012	HDFC0001234	Rahul Sharma	Test retailer	eX55xjXEaMhGhQKYkkWoEe7Q	2025-11-15 18:22:08.216245	2025-11-15 18:22:08.216245	5	f	Individual	Rahul Enterprises	CIN987654321	RC123456	\N	\N	rahulservices.in	5	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
151	demo		mohammadaamir2002@gmail.com	$2a$12$b1NBB/u84J1XSVn.Lw9fruxKCndRhEbI/8f4wC5c8OtIL.bPBGLFy	\N	\N	\N	\N	7458349745	\N	7458349745	35435034758347	dsaer4343e	2025-10-01	Male	ert	rt	ret	ret	ret	\N	ret	ret	ret4353	43534	\N	mohammadaamir2002@gmail.com			df	dfgfg		dfg	\N	pCdEoWfQrR96DYYdVrZ4QJ6U	2025-10-11 07:35:50.594714	2025-11-14 12:28:55.567864	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	t	\N	2025-10-16 07:04:53.878606	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
155	Rahul	Sharma	rahul@example.com	$2a$12$eDetdAwfpgh4jK.tsK/l4utfOvmMpeCXQjYR2FKrplpyRYisBEem6	\N	\N	\N	\N	9876543210	+91	9876500000	123412341234	ABCDE1234F	1995-06-10		Rahul Mobile Store	Individual	Electronics	BRN123456	07ABCDE1234F1Z5	ABCDE1234F		Delhi	Delhi	110001	Near Metro Station	rahul_shop	\N	Admin	HDFC Bank	123456789012	HDFC0001234	Rahul Sharma	Test retailer	HaJuCyydbfHSxdYQ3Ho8Tyut	2025-11-15 05:45:53.63126	2025-11-15 10:52:35.16163	9	t	Individual	Rahul Enterprises	CIN987654321	RC123456	\N	\N	rahulservices.in	5	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	t	\N	2025-11-15 06:22:55.637425	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
158	Rigel	Patel	sivivibu@mailinator.com	$2a$12$t8USyOhO8paG0wPrcQaC5usWwSUshC.FrSFZBGpWWecQaQAee8yzu	\N	\N	\N	\N	3222222222	+91	\N	277322222222	CTNPG1818G	2007-02-10	female	Richard Ford	public_limited	other	956	934	6	Est excepteur conseq	Dolor est voluptas 	Hyderabad	322222	A sit possimus laud	admin225	\N	2212122					Created from admin panel	dk6kCnroVn1AkPN2u6h9XZk5	2025-11-15 18:43:44.558833	2025-11-15 18:43:44.558833	5	f	\N	\N	\N	\N	\N	Admin@123	\N	5	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
159	Siddharth	gautam	sid20319111@gmail.com	$2a$12$mzUXcuhHOd4W6IEWlEKTVugoMo/EQrgV.OPP2EMot3.97d8ke8Yji	\N	\N	\N	\N	9568773855	+91	\N	277322222222	CTNPG1818G	2007-02-10	female	Richard Ford	public_limited	other	956	934	6	Est excepteur conseq	Dolor est voluptas 	Hyderabad	322222	A sit possimus laud	admin225	\N	2212122	Erica Blankenship	237	KKBK0000123	Burton Key	Created from admin panel	mgPLb822muNzUeRFitqsNon8	2025-11-15 18:44:39.640579	2025-11-15 18:44:39.640579	5	f	\N	\N	\N	\N	\N	Admin@123	\N	5	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
153	jon	wim	sid1221@gmail.com	$2a$12$LrNrguGpZTC.J3c7jtjh3OPL1ANv8/7Rohh9AI0eTmC5Tbuwfi95O	\N	\N	\N	\N	03443434334	\N	03443434334	876876876867233	JKGJGHJ688978	2025-11-07	Male						\N	ewew	33232		3232SDS	\N		paid						\N	KfMNj23mrFf5kirAknCBC7Js	2025-11-14 12:29:46.010104	2025-11-15 10:49:42.154381	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	t	\N	2025-11-14 12:31:56.427874	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
154	Rahul	Sharma	rahul@example.com	$2a$12$kf3CfjqaUu9gNuv1cIXY6uwYHT3pStObw6xdD1OKqJ/1LYprA/NAS	\N	\N	\N	\N	9876543210	+91	9876500000	123412341234	ABCDE1234F	1995-06-10	male	Rahul Mobile Shop	Individual	Electronics	BRN123456	07ABCDE1234F1Z5	ABCDE1234F	Main Market	Delhi	Delhi	110001	Near Metro Station	rahulshop	\N	Admin	HDFC Bank	123456789012	HDFC0001234	Rahul Sharma	Test retailer	py84gGkCwSeDHgbGqpC8TyXw	2025-11-15 05:42:26.571771	2025-11-15 12:08:13.30901	5	t	Individual	Rahul Enterprises	CIN987654321	RC123456	\N	\N	rahulservices.in	5	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
152	\N	\N	superadmin121@gmail.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	qdkR4WzSZTaEJH3dpjz35ejy	2025-10-11 11:49:43.891629	2026-05-25 08:46:24.239392	10	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
136	super admin	ssk	superadmin@gmail.com	$2a$12$n931dpsETP6h4yHNkMKtOO0DMgl4DY7yaE1Ngjl908lzXwWiawQj.	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-04 07:52:52.668874	2026-08-31 09:34:22.877707	10	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	123123	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
150	jon	wim	siddf@gmail.com	$2a$12$Rnadoy6GEya44vMXWbh/oOJT7JtH8lTpAyVHcIFdTtVxUovJwLMdy	\N	\N	\N	\N	03443434334	\N				\N	Select gender	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	Gawalira	Saharanpur	Uttar Pradesh	247001	\N	sidtech78678							\N	60b34704de45a2cfd281357ceb55ac00df75e41c	2025-10-11 05:26:21.697503	2026-07-27 12:39:33.0745	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	123456	123456	28.665400	77.439100	\N	2026-07-27 12:35:33.234974	49.47.69.240	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2026-07-27 12:35:33.241652	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	2026-07-27 12:35:33.234298	\N	Ghāziābād	Uttar Pradesh, IN	\N
161	Lacota	Mcmillan	debicuxac@mailinator.com	$2a$12$Tv8weKIiOBQkivFHz4IzIe4QxETq4gDQIuyR1LANsNzD2SiXfL1Cq	\N	\N	\N	\N	3222222222	+91	\N	243222222222	CTNPG1818G	1998-04-23	male	Anthony Pugh	proprietor	wholesale	543	684	687	Aut eos cumque debi	Officiis nihil paria	Chennai	233333	Nihil alias dolores 	bubatucu	\N	Ipsum incididunt qu	Heather Bruce	917	KKBK0000123	Dieter Kidd	Created from admin panel	7n2T2eCze49j4M5hGgZit73f	2025-11-15 19:22:43.449471	2025-11-15 19:22:43.449471	5	f	\N	\N	\N	\N	\N	Pa$$w0rd!	\N	5	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
162	Kiara	Pollard	rade@mailinator.com	$2a$12$zUeW0J/Sk3egl8KcPuCPEuBPgXpXeRyEQfQ7gDNRLtEqZWV/PKUlu	\N	\N	\N	\N	3222222222	+91	\N	943222222222	CTNPG1818G	1980-05-29	male	Kim Faulkner	limited_liability	trading	708	17	342	Dolore aliquid aut a	Blanditiis dolor rer	Other	322222	Asperiores est sed e	rabusud	\N	Sunt explicabo Impe					Created from admin panel	V2NPLHssr8Fm5Ktg7sw7VpZs	2025-11-15 19:48:53.372328	2025-11-15 19:48:53.372328	5	f	\N	\N	\N	\N	\N	Pa$$w0rd!	\N	5	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
104	admin1	\N	admin@gmail.com	$2a$12$MdSB.FvnU2oVEnPwgbWAU.d0/oQcUOHr5fHM67WhpfYgmIWiCXZlm	\N	\N	\N	\N	94434349494	\N	11123232			\N				\N			\N		\N	\N		\N	admin225	\N	\N			\N		\N	\N	2025-08-29 16:09:27.246126	2026-09-12 10:52:16.854465	9	t	\N	\N	\N	\N	\N	\N	\N	40	\N	\N	\N	\N	\N	\N	136	123456	111222	28.651900	77.231500	\N	2026-08-14 12:34:34.66208	49.47.69.153	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	f	822601	2026-09-12 11:02:16.853861	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	2026-08-14 12:34:34.658934	\N	Delhi	Delhi, IN	\N
163	Kiara	Pollard	rade11@mailinator.com	$2a$12$CTW.1rfMagfzkHkr57cPTO1OxrsBDtGhsBpYz/6Cz6kXXKaGz68Pa	\N	\N	\N	\N	3222222222	+91	\N	943222222222	CTNPG1818G	1980-05-29	male	Kim Faulkner	limited_liability	trading	708	17	342	Dolore aliquid aut a	Blanditiis dolor rer	Other	322222	Asperiores est sed e	rabusud	\N	Sunt explicabo Impe	Jade Lowe	516	KKBK0000123	Reagan Mendez	Created from admin panel	dH9mtpL1BnJwPYdyDGUPWAbW	2025-11-15 19:50:09.590021	2025-11-15 19:50:09.590021	5	f	\N	\N	\N	\N	\N	Pa$$w0rd!	\N	20	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
164	Zena	Mcpherson	nyhyretiw@mailinator.com	$2a$12$LfqzdiqfMOY9D3tjLsAoj.GFehGfLo78tdjmKHTSi6bgV3gBP64ra	\N	\N	\N	\N	3222222222	+91	\N	878332222222	CTNPG1818G	2000-01-15	female	Janna Ochoa	public_limited	retail	621	952	230	Cumque numquam atque	Adipisicing eum dolo	Hyderabad	322222	Sint ullam praesenti	hibivi	\N	Sit nihil laboriosam					Created from admin panel	XvpWJtLMGx6ZjCspBDhZNPgn	2025-11-15 20:22:16.561485	2025-11-15 20:22:16.561485	5	f	\N	\N	\N	\N	\N	Pa$$w0rd!	\N	20	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
167	Wyoming	Mcintyre	fydawy@mailinator.com	$2a$12$aEk3GF6V2xlzaYPYNIbRCeF9n35zaJr30.zjqR9/d2CsA7YP/NLxe	\N	\N	\N	\N	3222222222	+91	\N	879879879787	CTNPG1818G	2004-02-26	female	Mercedes Stokes	proprietor	manufacturing	57	223	621	Nihil autem saepe la	Error vero adipisici	Mumbai	322222	Enim aut vel facilis	xawofeqome	\N	Do id dolor sed del					Created from admin panel	yVxKb4HRBrnzxSm8RoY5ABk1	2025-11-15 20:37:43.8581	2025-11-17 11:04:14.822644	7	t	\N	\N	\N	\N	\N	Pa$$w0rd!	\N	20	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
168	sidwa	Sharma	rahul@example.com	$2a$12$/SbbbxhYvxkLcNo4hkAuk.dJxQbRjIUFK.PkD4su8QzP/HYl64N8C	\N	\N	\N	\N	9876543210	+91		322222223330	CTNPG1818G	1986-08-06	male	Rahul Mobile Store	limited_liability	retail	225	162	219	Ullamco obcaecati an	Delhi	Delhi	110001	Et nulla quis dolor 	rahul_shop	\N	Dolor rem enim illo 					Created from admin panel	P54cw7v5K3kkxyDnKf1mA74o	2025-11-16 06:58:39.287505	2025-11-17 13:41:18.858549	9	f	\N	\N	\N	\N	\N	Pa$$w0rd!	\N	20	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
165	Zena	Mcpherson	nyhyretiw22@mailinator.com	$2a$12$x5mSmMWz6WNRr8Ty.jlSGexIV2Fz2a2B7xeuqa/4D0mTOjqou85bK	\N	\N	\N	\N	3222222222	+91	\N	878332222222	CTNPG1818G	2000-01-15	female	Janna Ochoa	public_limited	retail	621	952	230	Cumque numquam atque	Adipisicing eum dolo	Hyderabad	322222	Sint ullam praesenti	hibivi	\N	Sit nihil laboriosam	Jeanette Rowland	593	KKBK0000123	David Moss	Created from admin panel	sjwAxsk56x8GuUG1FNeBTdc3	2025-11-15 20:23:26.543316	2025-11-17 11:00:21.219323	6	f	\N	\N	\N	\N	\N	Pa$$w0rd!	\N	20	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
171	manikant	 tiwari	mani3669@gmail.com	$2a$12$wDI6kFc/6.VVPTpmCwbVVuihvA6hSx7UamRcIeF/bnp0nDjmGB2Gy	\N	\N	\N	\N	8317082162	+91	\N	855296631232	ABCDE1234F	2005-12-10	male	ballu mafia	public_limited	manufacturing	57348957589	26473264389	ABCDE1234F	shivaji nagar colony, samneghat , lanka,varanasi	varanasi	Mumbai	221019	near noida one	dealer@gmail.com	\N	raju					Created from admin panel	Huw1usCN2DcxNC2HrvXZadJo	2025-11-26 06:21:56.482295	2025-11-26 06:30:30.587458	5	t	\N	\N	\N	\N	\N	Dealer@1234	\N	34	\N	\N	\N	\N	\N	\N	169	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	124485	2025-11-26 06:40:30.586628	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
170	rajuu	mishraa	raju23@gmail.com	$2a$12$qkepLk2nXarZkHJPSfMRJewvgTOmGHHym9gNJYvZHdccfnckPnQkm	\N	\N	\N	\N	9908233828	+91	\N	378243892463	ABCED1123F	2003-05-10	male	sand mafia	self	manufacturing	88888888	909091220	ABNSI2222K	noida one, noida	noida	Delhi	220122	near nokia	dealer@gmail.com	\N	77					Created from admin panel	9JU6an5cL5smtXWugq9jYvMX	2025-11-25 11:05:23.094218	2025-11-26 10:18:53.021601	5	t	\N	\N	\N	\N	\N	Dealer@1234	\N	34	\N	\N	\N	\N	\N	\N	169	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	t	\N	2025-11-26 10:18:53.020565	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
103	Master	kumar	master@gmail.com	$2a$12$/UeN5ofRoHdl30iPr1yLjOPBxHJK7yJnuVT3r1aqvKEAAT.fdULs2	\N	\N	\N	\N	77879987979	\N	78098798687	7987687576457476	JKGJGHJ688978	2025-08-22		Insurance Business	Insurance Business Ownership Type	Insurance Business Nature Type	98789798798787	986857644645cddsds	\N		noida	Uttar Pradesh	201301	\N	maste7879879	paid	HGG7897897	Axis	7988757678hgg	IFDD&775655	master	\N	\N	2025-08-29 05:50:45.95782	2025-12-18 09:32:14.583117	6	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2025-12-18 09:32:00.573391	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
172	mnaikant tiwari	tiwari	maniaknt123@gmail.com	$2a$12$1Oi/lr8MWgtNg2tOnyYcp.V54kXUQkMfWdScijEn1A.FZBfgjbhNS	\N	\N	\N	\N	1111111111	+91		222222222222	ABCDE1234F	2005-12-10	male	landlord	self	manufacturing	324324324324	4324234343	CBHPT1896J	noida one	noida	Bangalore	111111	nokia	dealer@gmail.com	\N	11					Created from admin panel	RNeSwF2nKJ7Sp3dDTVm9V39Y	2025-11-26 12:04:06.714296	2025-11-26 12:05:30.377238	5	t	\N	\N	\N	\N	\N	12345678	\N	34	\N	\N	\N	\N	\N	\N	169	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
169	Dealer	Khan	dealer@gmail.com	$2a$12$RSYHosLhNRfd20AQ2m1sI.6D/mbcITEOOTL5vAGeCJdaTlQn35lYq	\N	\N	\N	\N	9999999999	+91	\N	333333333333	DAJPC4150P	2025-11-01	male	abc	self	trading	123456	456789	CTUGE1616I	Muradnagr	Ghaziabad	Other	201206	dsf	dealer@123	\N	sid					Created from admin panel	Tx74F1bzeXQZAN4KzHyw3w9M	2025-11-24 06:24:00.075736	2025-12-18 09:14:27.032629	7	t	\N	\N	\N	\N	\N	dealer@123	\N	30	\N	\N	\N	\N	\N	\N	104	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2025-12-18 09:14:27.032229	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
166	Hillary	Riggs	maxonas@mailinator.com	$2a$12$RHr.GtvuVLQ9OWYqDrOu4e5D2wu5DRiIXObyMEIwGeFYli8N2C3QS	\N	\N	\N	\N	3222222222	+91	\N	118322222222	CTNPG1818G	2025-09-17	female	Hasad Ortega	public_limited	wholesale	183	79	122	Incididunt lorem fac	Ducimus amet incid	Other	233333	Et aut aliquid nemo 	muxija	\N	Aperiam laborum Qui					Created from admin panel	GfvD9beHhP5mXtNLGWDbpqws	2025-11-15 20:35:17.211905	2026-05-27 05:59:32.397022	6	t	\N	\N	\N	\N	\N	Pa$$w0rd!	\N	21	\N	\N	\N	\N	\N	\N	104	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2026-05-27 05:59:25.453723	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
139	Tej	singh	tej@gmail.com	$2a$12$5GhThPIzceuOy40FtudoheEJdfOXz2utRpS/hiw1ZwClVco1hlxp6	\N	159421	\N	\N	8317082162	+91	90889798798	787898779797977	JKGJGHJ688978	2025-09-02		LOAN SOULUTION	Loan Business Ownership	Loan Nature Type	328987097ds979d89787	986857644645cddsds	\N		noida	Uttar Pradesh	201301		tej88989	\N	tej87787	HDFC	687687676776876	IFDD&775655	Tej	\N	d5d18358f7769e9086dd122a0afeed5cc306e63b	2025-09-04 09:05:42.906747	2026-07-03 09:10:07.628395	5	t					\N	tej123		5	\N						104	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2026-07-03 09:05:32.590106	f	2025-12-26 11:25:39.456644	38130026	t	f	f	f	f	\N	\N	f			\N				f	f	f	\N	\N	\N	\N	\N	\N
175	udit	shah	udit11@gmail.com	$2a$12$d6dp8cjQrVHBf2AeWw0jGuB9Ul6nWr810XqtNcgv4zwu7Sc.RV3qq	\N	\N	\N	\N	9999999999	+91	\N	222222222222	ABCDE1234K	2006-12-10	male	sales man	self	wholesale	736835483574389	2878934738	CBHPT2907K	marmuraa, noida	noida	Chennai	222222	sector-59	udit11@gmail.com	\N	323					Created from admin panel	kbwgWbmngrYpffyDc9EpD8RN	2025-11-27 07:35:22.947821	2025-11-27 12:32:38.663071	5	t	\N	\N	\N	\N	\N	12309876	\N	38	\N	\N	\N	\N	\N	\N	169	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2025-11-27 12:32:38.662094	f	2025-11-27 09:09:17.96107	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
173	aleem	malik	am12@gmail.com	$2a$12$UrPo2NRvkvrasfcVAUtbDei4dJMkAGmq9yqi0/tztK2UiWHnW7gIO	\N	\N	\N	\N	1234567891	+91	\N	111111111111	ABCDE1234F	2002-12-10	male	dwejkdfbwej	proprietor	wholesale	4y8932748324	4723643289	HDSBFJEFBJ	noids	noids	Pune	738984	nfjn	dealer@gmail.com	\N	df					Created from admin panel	qiRUpKzDnnaVXxKsn2qz7eCC	2025-11-26 12:09:10.924277	2025-11-26 12:11:24.281532	5	f	\N	\N	\N	\N	\N	12344321	\N	35	\N	\N	\N	\N	\N	\N	169	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	t	\N	2025-11-26 12:10:04.553921	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
177	dabbu	don	dabbu@gmail.com	$2a$12$/QKtJFA7aB4XLRKuYfOBx.p8sQP0nfDYnwONWZIzmaeckZbauG0HO	\N	\N	\N	\N	9999999999	+91	\N	777777777777	ABCDE1233K	2004-12-10	female	wejfnrejkg	proprietor	service	278463456349856	e3874y3474	ABDHWEBHEW	werbewkjhrbewjr,ebfrebk,ewhbrfre	lankaaa	Hyderabad	221012	fbehjfbfh, fndjngfdf	dabbu@gmail.com	\N	111111					Created from admin panel	7CjitfZp3JGRwDYJk3FDofJy	2025-12-12 09:21:57.454667	2025-12-12 11:49:50.380798	5	t	\N	\N	\N	\N	\N	Dabbu@12	\N	41	\N	\N	\N	\N	\N	\N	104	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	188984	2025-12-12 11:48:49.410401	f	2025-12-12 11:59:50.379931	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
174	rohit	pandey	rohit12@gmail.com	$2a$12$EQNr81rHqpXzduJQ5SZX7OtW.1Ax042Yey8XDYPeO31zTzn5DgYGu	\N	\N	\N	\N	1234567123	+91	\N	333333333333	ABCDE1234K	2002-12-10	female	digital	self	wholesale	483927328	473284738	ABSBJSJ23B	noida 	noida	Mumbai	111111	nokia	dealer@gmail.com	\N	432432					Created from admin panel	vdrBdvWmgg82KXezfcdYmpvH	2025-11-26 12:42:31.316441	2025-11-26 12:43:47.969425	5	t	\N	\N	\N	\N	\N	12121212	\N	37	\N	\N	\N	\N	\N	\N	169	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	t	\N	2025-11-26 12:43:47.968737	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
178	ranilakxmi	bai	jyoti@gmail.com	$2a$12$TxqYaogrRKgLB73imy/WmeYVRxiAPyo5P5IAHKDbYyzcKQ9J2vmv.	\N	\N	\N	\N	9999999999	+91		754365894375	ABCDE1234G	2001-02-10	female	jferfjk	self	retail			POJYU1873O	NEW ASHOK NAGAR ROAD	New Delhi	Delhi	110096	assi	jyoti	\N	errfre					Created from admin panel	teHduoYq9sXHmWzqHsC59vLd	2025-12-18 09:49:00.962035	2025-12-18 12:33:50.934927	5	t	\N	\N	\N	\N	\N	12345678	\N	31	\N	\N	\N	\N	\N	\N	103	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2025-12-18 09:51:55.306914	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
179	Paramjyoti	Verma	paramjyoti@gmail.com	$2a$12$PEUT6TMJC2eUgGauoxEcmOUpn2PFtt3NJm9A4vWKWzn3o7rIlkAsO	\N	\N	\N	\N	7987514096	+91	\N	496301293359	BIRPV1623E	2000-02-22	female	Param	private_limited	retail	8968768769766	767868687	XGZFE7225	Sector	Greater Noida	Kolkata	201310		paramjyoti	\N	Admin					Created from admin panel	phH56EX81cxgJdqWY8Aj84gn	2025-12-22 07:05:41.201234	2025-12-22 08:40:37.805164	5	t	\N	\N	\N	\N	\N	paramjyoti123	\N	41	\N	\N	\N	\N	\N	\N	104	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2025-12-22 07:06:41.498872	f	\N	38130011	t	f	f	f	t	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
176	pritesh	babu	pritesh12@gmail.com	$2a$12$sEH7EE6Q/LTu097UN6L0cuH8.jUUZLTjQh5.72//eG9Hcc9z/0BDe	\N	\N	\N	\N	8317082162	+91	\N	888888888888	ABCDE1234H	2002-11-10	female	dsfdgdgdf	limited_liability	service	345345464566	dsfsdfd	ACDEF2233J	gfdgfghgfhfghghgf,sdggf	samneghat	Hyderabad	111111	dfsdf	pritesh12@gmail.com	\N	Admin					Created from admin panel	m7wwFtohFZazYpr1rYtXNBBo	2025-12-11 09:47:11.903644	2025-12-19 05:21:25.094237	5	t	\N	\N	\N	\N	\N	Pritesh@12	\N	23	\N	\N	\N	\N	\N	\N	104	654321	654321	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2025-12-19 05:21:25.093764	f	2025-12-11 10:01:18.387117	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
180	admin	jdshdkhj	admin@gmail.com	$2a$12$FfYMXemZhT3PnJbeJ6AjuOj6rsAWHdPu6G5WoSeu6o92m3pCQQo.q	\N	\N	\N	\N	8797989787	\N	03443434334	876876876867233	JKGJGHJ688978	2000-02-16	Male	Business Name	Business Ownership Type	Business Nature Type	Business Registration Number	986857644645cddsds	\N	Gawalira	Saharanpur	Uttar Pradesh	247001	\N	sidtech78678	\N	HGG7897897	Axis	7988757678hgg	IFDD96875	Retailers	\N	6FUWfXmacmjmpP2JhfhUXuaa	2025-12-23 05:42:08.244472	2025-12-23 05:42:08.244472	9	f	\N	\N	\N	\N	\N	123456	admin	5	\N	\N	\N	\N	\N	\N	136	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
184	kuni	sahoo	laxmikuni330@gmail.com	$2a$12$Eyk7TWnA./dS71i7r9sr4.mfb0z0xa3IUHohR.R1R5GbLj60ueWXS	\N	\N	\N	\N	9337947108	+91	\N	459862315879	DYNPM7656G	1995-04-08	female	maya csc point	other	other				unit1 bapujinagar	bhubaneswar	odisha	751014	adibasipadia	kuni@quickcred	\N	Admin	punjab nasnal bank	15452413000273	PUNB0172110	kunisahoo	Created from admin panel	GRuHYKbXig6uJb5bxni9YoKQ	2026-05-26 18:20:55.274561	2026-05-27 07:40:18.467392	7	t	\N	\N	\N	\N	\N	12345678	\N	45	\N	https://res.cloudinary.com/siddtec/image/upload/v1779819652/users/pan/fnqm4e4c6k40qlckfvza.jpg	https://res.cloudinary.com/siddtec/image/upload/v1779819650/users/aadhaar/z80bckxb8ubmirjyf813.jpg	\N	https://res.cloudinary.com/siddtec/image/upload/v1779819654/users/store/w6j0b7scf8ewgoqmqni2.jpg	\N	183	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	unit1 bapujinagar	adibasipadia	\N	bhubaneswar	odisha	751014	f	f	f	\N	\N	\N	\N	\N	\N
127	jon11	wim	jon11@gmail.com	$2a$12$EfKmDRXtu6P3e04s0kbpgelgPdJywVD482JyOoVp9v3L8au8YPMCW	\N	\N	\N	\N	323243434343	\N	03443434334	876876876867233	JKGJGHJ688978	2025-09-01		dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N		noida	Uttar Pradesh	201301	\N	lastadmin223	\N						\N	ea28c4c7c812bbb3eab7003214401a192b448f8b	2025-09-02 09:38:43.044029	2026-08-10 05:38:59.060937	5	t	\N	\N	\N	\N	\N	123456	late22	41	\N	\N	\N	\N	\N	\N	104	123456	123123	28.651900	77.231500	\N	2026-08-10 05:38:59.054479	49.47.69.153	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2026-08-10 05:38:59.060641	f	2025-11-19 13:00:37.108691	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	2026-08-10 05:38:59.05444	\N	Delhi	Delhi, IN	\N
182	\N	\N	staff@gmail.com	$2a$12$TsflxFSWnNSy1gqaLa6HaeSVZgmlDH3kC/NNyppoR067oRSJPhbiu	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6qMTu5hViGv8KQ1HpEyAnGYo	2026-05-26 07:40:57.980127	2026-05-26 08:41:17.579579	13	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2026-05-26 08:41:17.578748	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
183	gayatri 	mohanty	mamunimamunimohanty@gmail.com	$2a$12$pBmleeH3IY9KM2rbjsR1deruuA0H8jIHUbe2hUuwCwVizkdxF20VW	\N	\N	\N	\N	6372916569	+91	\N	456879123654	DYNPM7656G	1993-12-01	female	mamuni csc point	self	wholesale				baseli sahi	puri	odisha	752001	bandurga	mamuni@quickcred	\N	Admin	federal	23110200000404	FDRL0002311	prasad	Created from admin panel	CA3K5mEw7xFcB5YuxNuaeYwK	2026-05-26 18:10:46.539702	2026-05-26 18:41:28.394601	6	t	\N	\N	\N	\N	\N	12345678	\N	44	\N	https://res.cloudinary.com/siddtec/image/upload/v1779819044/users/pan/q4heq1np2k962jf1owrp.jpg	https://res.cloudinary.com/siddtec/image/upload/v1779819042/users/aadhaar/mvvpudsrbqgjrdffzirk.jpg	\N	https://res.cloudinary.com/siddtec/image/upload/v1779819045/users/store/ml2rf80p1idqyfeezenh.jpg	\N	181	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	472948	2026-05-26 18:51:28.394035	f	\N	\N	f	f	f	f	f	\N	\N	f	baseli sahi	bandurga	\N	puri	odisha	752001	f	f	f	\N	\N	\N	\N	\N	\N
185	master testing	sss	hjkhdkjshs11@gmai.com	$2a$12$TuHcmULXy7jgabRB0y4hdeDkeA3pmGxyWLxdk3R4OUbBTehXmHrJW	\N	\N	\N	\N	3443434334	+91	\N	456233333333	CTNPG1818G	1999-01-01	male	Lance Hickman	self	retail				Gawalira	Saharanpur	Uttar Pradesh	247001		Dev-User2222	\N	Admin	Kylee Pope	922010023211252	KKBK0000123	Yoshio Gordon	Created from admin panel	o1ymmn4GFhPBCYkxJtF5gkGS	2026-05-27 04:57:46.926796	2026-05-27 04:57:46.926796	6	f	\N	\N	\N	\N	\N	12345678	\N	21	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	Gawalira		\N	Saharanpur	Uttar Pradesh	247001	f	f	f	\N	\N	\N	\N	\N	\N
186	test dealer	sss	jjlkjlkjlkjlkjlk111@gmail.com	$2a$12$/wQihE7R4k1v.yUEDwK6mOwuf5GVhhOUmAp3QDAE/XASRFW9IHKHK	\N	\N	\N	\N	3443434334	+91	\N	456233333333	CTNPG1818G	2000-03-12	male	Lance Hickman	proprietor	wholesale				Gawalira	Saharanpur	Uttar Pradesh	247001		sid9568222	\N	Admin	Kylee Pope	922010023211252	KKBK0000123	Thor Gray	Created from admin panel	cpWjD88ehGNztNqZTQDtRfiL	2026-05-27 04:59:27.799011	2026-05-27 04:59:27.799011	7	f	\N	\N	\N	\N	\N	12345678	\N	21	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	Gawalira		\N	Saharanpur	Uttar Pradesh	247001	f	f	f	\N	\N	\N	\N	\N	\N
187	test delaer	sss	testtig21@gmail.com	$2a$12$klG2OHxOZGYVtsarOBtavOh9ZHnztu/hn4Utl1M/Iu7B5BblHADrK	\N	\N	\N	\N	3443434334	+91	\N	433443444334	CTNPG1818G	2017-10-19	male	Lance Hickman	self	wholesale				Gawalira	Saharanpur	Uttar Pradesh	247001		nndsmds79879	\N	Admin	Kylee Pope	9924000100007471	KKBK0000123	siddhart gautam	Created from admin panel	CYVZc7XsaDjYQDHuDsaRDfNT	2026-05-27 07:00:39.185677	2026-05-27 07:00:39.185677	7	f	\N	\N	\N	\N	\N	12345678	\N	21	\N	\N	\N	\N	\N	\N	185	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	Gawalira		\N	Saharanpur	Uttar Pradesh	247001	f	f	f	\N	\N	\N	\N	\N	\N
188	tetdsh retailer	jdshdkhj	testretaier89@gmai.com	$2a$12$Mz0qLa5qZ1JlsWq0oo1mcevmn01By7pLFm1ynkGzhxIbm0GwhuQEK	\N	\N	\N	\N	3443434334	+91	\N	434343434343	CTNPG1818G	1997-11-13	male	Lance Hickman	self	wholesale				Gawalira	Saharanpur	Uttar Pradesh	247001		sid9568233	\N	Admin	Jade Lowe	9924000100007471	KKBK0000123	Jelani Whitfield	Created from admin panel	THkRVyMP9eD8c8VSbCFp7aFw	2026-05-27 07:02:09.743007	2026-05-27 07:02:09.743007	5	f	\N	\N	\N	\N	\N	12345678	\N	21	\N	\N	\N	\N	\N	\N	187	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f	\N	\N	f	Gawalira		\N	Saharanpur	Uttar Pradesh	247001	f	f	f	\N	\N	\N	\N	\N	\N
193	priyanka	nanda	priyanka.nanda3535@gmail.com	$2a$12$.79CWYv2jmman.B6loAKuOKCLAW/J5fOviiimWJQ06XGBmn/FuVlu	\N	\N	\N	\N	8280251228	+91	\N	868168287442	CFWPN7236J	1992-04-10	female	priyanka nanda	self	retail				govindpur, tirtol	jagatsinghpur	odisha	754136		priyanka@quickcred	\N	Admin	icici bank	150001515967	ICIC0001500	priyannka nanda	Created from admin panel	EBRfGudAZg22qWDUXZBPb3hU	2026-05-29 12:01:04.765493	2026-06-29 12:12:43.574338	5	t	\N	\N	\N	\N	\N	12345678	\N	44	\N	https://res.cloudinary.com/siddtec/image/upload/v1780056061/users/pan/zhy8p2potjr1qpqvm7o3.png	https://res.cloudinary.com/siddtec/image/upload/v1780056059/users/aadhaar/qlly6cb4dkf9wpauz3le.png	\N	https://res.cloudinary.com/siddtec/image/upload/v1780056063/users/store/ewgjijnodoplj2fxdpw4.jpg	\N	184	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2026-06-29 12:12:43.573814	f	\N	38130022	t	f	f	f	f	\N	\N	f	govindpur, tirtol		\N	jagatsinghpur	odisha	754136	f	f	f	\N	\N	\N	\N	\N	\N
189	narasingh	suar	narasinghsuar@gmail.com	$2a$12$E5ZwpgRt0/dfppquBRbKouHKc8kQE0igeMJA1MAxMTbRcmDHM.ZL2	\N	\N	\N	\N	9348075033	+91		623043787444	EZTPS2125E	1993-05-02	male	Lance Hickman	self	retail				puri	puri	Odisha	752001		neel@quickcred	\N	Admin	FEDERAL BANK	23110200000412	FDRL0002311	NARASINGH SUAR	Created from admin panel	Y3mHoNLJjDfsKtyqDSWddboC	2026-05-27 07:46:14.740665	2026-07-08 06:34:47.201623	5	t					\N	12345678		44	\N	https://res.cloudinary.com/siddtec/image/upload/v1780058783/users/pan/rekvgsqqsgenfvjtgnz2.jpg	https://res.cloudinary.com/siddtec/image/upload/v1780058781/users/aadhaar/zug74hsqtnqtzctbebwo.jpg	data:image/jpeg;base64,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			184	123456	123456	20.228918	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2026-07-08 06:34:47.199737	f	\N	38130023	t	f	f	f	t	\N	\N	f	puri		\N	puri	Odisha	752001	f	f	f	20.228918,85.839855	\N	\N	\N	\N	\N
181	prasad	kumar	prasadkumahanty1995@gmail.com	$2a$12$e6Q/RahqTOOEex5LttGigOxOGp.uljQBmVhO.G4s.xbTPPgbkoDD2	\N	\N	\N	\N	03443434334	\N	03443434334	876876876867233	JKGJGHJ68768	1999-12-28	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	Noida, Uttar Pradesh, India	Noida	Uttar Pradesh	ds233232	\N	presad121	\N	123223					\N	3qovCcrVQ5ZWLqYXzNnuZ6yH	2026-05-25 08:49:37.591795	2026-08-19 12:28:15.04089	9	t	\N	\N	\N	\N	\N	123456		40	\N	\N	\N	\N	\N	\N	136	123456	123456	20.272400	85.833800	\N	2026-08-19 12:28:14.940635	49.42.178.198	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2026-08-19 12:28:15.035706	f	\N	\N	f	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	2026-08-19 12:28:14.937216	\N	Bhubaneswar	Odisha, IN	\N
191	Anshika	Chauhan	anshikabharatgrow@gmail.com	$2a$12$XwbQONQwii61lcayCH3neOZFQDJcm4azZgMbnNZ.PrZGO0vDnMOUK	\N	\N	\N	\N	7835750958	+91	\N	379232276280	CJJPC6552R	2002-07-05	female	asdf	self	wholesale	12345	43215		noida 62	Noida	Uttar Pradesh	201013		Anshika	\N	Admin	HDFC	987654321098	HDFC0001592	tanya	Created from admin panel	y6zvSXRQhjtSncofU5FUDPtp	2026-05-29 10:42:48.284674	2026-05-29 10:44:57.244768	5	t	\N	\N	\N	\N	\N	12345678	\N	21	\N	\N	\N	\N	\N	\N	187	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2026-05-29 10:44:23.614277	f	\N	38130021	t	f	f	f	f	\N	\N	f	noida 62		\N	Noida	Uttar Pradesh	201013	f	f	f	\N	\N	\N	\N	\N	\N
192	mohit	kumar	mohit212@gmail.com	$2a$12$m/VCZo3nOU30Bm7zva9TQOVh3Qshm3jdWHJVlEKk2hV5GMy6PHpZW	\N	\N	\N	\N	3443434334	+91	\N	434334343434	CTNPG1818G	2026-05-17	male	Janna Ochoa	proprietor	retail				Gawalira	Saharanpur	Uttar Pradesh	247001		mohit3311	\N	Admin	Kylee Pope	9924000100007471	KKBK0000123	siddhart gautam	Created from admin panel	o53ku4L91ejQqGDpCKzL592v	2026-05-29 11:08:32.359921	2026-05-29 11:29:47.65944	5	t	\N	\N	\N	\N	\N	12345678	\N	21	\N	\N	\N	\N	\N	\N	187	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2026-05-29 11:29:41.833111	f	\N	38130020	f	f	f	f	t	\N	\N	f	Gawalira		\N	Saharanpur	Uttar Pradesh	247001	f	f	f	\N	\N	\N	\N	\N	\N
190	siddharth 	Gautam	sid20319@gmail.com	$2a$12$SGDn7YqkzOF9BHImiON2.ecyV7B0idtq09HaUMfWQZD8VccYWGxBW	\N	\N	\N	\N	9568773855	+91	\N	215307303098	CTNPG1818G	2001-01-09	male	sid kirana	proprietor	wholesale	1234567890	9987654321		Noida 62	Noida	Uttar Pradesh	201301		sidkumar	\N	Admin	hdfc	9876543210	HDFC0001592	Sid	Created from admin panel	jo4NpwgxGYpWqFsUoCj8CbVL	2026-05-29 09:57:50.64624	2026-07-31 12:42:22.047115	5	t	\N	\N	\N	\N	\N	12345678	\N	21	\N	\N	\N	\N	\N	\N	187	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	f	837209	2026-07-31 12:52:21.820297	f	\N	38130006	t	f	f	f	f	\N	\N	f	Noida 62		\N	Noida	Uttar Pradesh	201301	f	f	f	\N	\N	\N	\N	\N	\N
197	Sachin	Kumar Gola	sachinprajapati0203@gmail.com	$2a$12$/E0wTkP9CEqoyqK2cT/J6efG8hz1MSJLOWJoM2lP4j9U/.GV9e0VS	\N	\N	\N	\N	7037075725	+91	\N	817889502113	DRXPG1423G	2002-03-02	male	tester	self	retail				sita nagar, rambagh	Agra	Uttar Pradesh	282006		sachin	\N	Admin	state bank of india	1111111111111111	SBIN0000112	Retailer R	Created from admin panel	PtMSy2JeGupmKVQZ39FEvSaJ	2026-08-03 09:17:38.105276	2026-08-21 05:55:32.768856	5	t	\N	\N	\N	\N	\N	12345678	\N	21	\N	\N	\N	\N	\N	\N	187	123456	123456	28.651900	77.231500	\N	2026-08-21 05:55:32.729425	49.47.69.153	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2026-08-21 05:55:32.768508	f	\N	205091007	t	f	f	f	f	\N	\N	f	sita nagar, rambagh		\N	Agra	Uttar Pradesh	282006	t	t	f	27.20157787577722, 78.03890321986614	2026-08-21 05:55:32.72815	\N	Delhi	Delhi, IN	SBIN
196	Siddharth	Gautam	sidd20319@gmail.com	$2a$12$DNa0BlLO77Pfj174d3B6W.4QuB14sV/HDUGuQOMOu9a7Ba635o2KG	\N	\N	\N	\N	9568773855	+91	\N	215307303098	CTNPG1818G	2000-01-09	male	chaiwala	self	retail				noida one	Noida	Uttar Pradesh	201301	noida one	siddharthg	\N	Admin	state bank of india	112233445566	SBIN0000112	Siddharth Gautam	Created from admin panel	2PV1nVNXieeftKXyVr1eNErW	2026-07-27 12:46:06.916141	2026-08-17 11:49:08.343624	5	t	\N	\N	\N	\N	\N	12345678	\N	45	\N	\N	\N	\N	\N	\N	187	112233	112233	28.651900	77.231500	\N	2026-08-17 11:49:08.08495	49.47.69.153	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2026-08-17 11:49:08.34154	f	\N	38130026	t	f	f	f	f	\N	\N	f			\N				t	t	f	27.519444293923566,77.67306047301692	2026-08-17 11:49:08.079149	\N	Delhi	Delhi, IN	UTIB
198	siddharth	Gautam	hroperations002@gmail.com	\N	\N	\N	\N	\N	9568773855	\N	\N	215307303098	CTNPG1818G	2000-01-09	\N	asd	\N	\N	\N	\N	CTNPG1818G	{"line"=>"noida", "city"=>"noida", "state"=>"Uttar Pradesh", "pincode"=>"206001", "district"=>"noida", "area"=>"noida one"}	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	HQqumXXSRmwZBV4iSjSSF1E8	2026-08-07 07:02:13.485109	2026-08-07 07:02:13.485109	6	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	38130026	t	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
200	Sachin	Kumar	sachinprajapati0203@gmail.com	\N	\N	\N	\N	\N	7037075725	\N	\N	817889502113	DRXPG1423G	2002-03-02	\N	tester	\N	\N	\N	\N	DRXPG1423G	{"line"=>"Sita Nagar Rambagh", "city"=>"Agra", "state"=>"Uttar Pradesh", "pincode"=>"282006", "district"=>"Agra", "area"=>"char khamba"}	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7ZECEKi97NFvsxi6k6adTguz	2026-08-12 10:58:21.418498	2026-08-12 10:58:21.418498	6	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	205091007	t	f	f	f	f	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
199	mohammad 	aamir	mohaamdaamir@gmail.com	\N	\N	\N	\N	\N	9305096443	\N	\N	436798545457	EEHPA5924J	2002-08-05	\N	gfdsa	\N	\N	\N	\N	EEHPA5924J	{"line"=>"noida one", "city"=>"noida", "state"=>"Uttar Pradesh", "pincode"=>"201301", "district"=>"noida", "area"=>"fdsa"}	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	SCiTXPme88HwjS7EBaNuzQAi	2026-08-07 07:36:55.328457	2026-08-07 07:37:54.644821	6	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	205091003	t	f	f	f	t	\N	\N	f	\N	\N	\N	\N	\N	\N	f	f	f	\N	\N	\N	\N	\N	\N
194	SASMITA	DAS	sd3020344@gmail.com	$2a$12$Wnp/Bw3mIVDY8uymup9kh.bys6Snha7TQuirj4xl7nJi9FBnMiWie	\N	\N	\N	\N	7846960035	+91		343807435791	LDPPD7778B	2006-03-14	female	BHAKTI SUDHA	self	retail				R J PALACE, SAMANTARAPUR	BHUBANESWAR	Odisha	751002		SD@QUICKCRED	\N	Admin	FEDERAL BANK	23110100033851	FDRL0002311	SASMITA DAS	Created from admin panel	UvXEqs6hgH8r3NhhuHsAatzz	2026-07-06 11:08:18.686185	2026-09-07 10:22:12.005311	5	t					\N	12345678		45	\N	https://res.cloudinary.com/siddtec/image/upload/v1786092100/users/pan/zhojds68ehonufiwak25.jpg	https://res.cloudinary.com/siddtec/image/upload/v1786092099/users/aadhaar/aiaxjdvpd1aipfgyj9co.jpg		https://res.cloudinary.com/siddtec/image/upload/v1786092101/users/store/ikjyshym7buv1omkgntl.jpg		184	789456	789456	22.562600	88.363000	\N	2026-09-07 10:22:11.998044	223.181.53.224	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2026-09-07 10:22:12.004876	f	\N	205091004	t	f	f	f	t	\N	\N	f	R J PALACE, SAMANTARAPUR		\N	BHUBANESWAR	Odisha	751002	t	t	t	20.229043,85.839995	2026-09-07 10:22:11.997977	\N	Kolkata	West Bengal, IN	FDRL
\.


--
-- Data for Name: vendor_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vendor_users (id, full_name, phone_number, otp, vendor_expiry_otp, vendor_verify_status, created_at, updated_at, addhar_kyc_status, user_code, sender_phone_number) FROM stdin;
1	sidd	9568773855	\N	\N	t	2026-05-29 11:30:22.495647	2026-05-29 11:31:10.381328	f	\N	\N
2	PRASAD KUMAR MOHANTY	9337691368	\N	\N	t	2026-05-29 12:54:57.877541	2026-05-29 12:55:15.155197	f	\N	\N
3	kuni sahoo	9337947108	984445	2026-06-03 08:36:54.567429	f	2026-06-03 08:24:58.613686	2026-06-03 08:26:54.56778	f	\N	\N
4	kuni sahoo	9938898580	695692	2026-06-03 08:38:29.255858	f	2026-06-03 08:27:53.182984	2026-06-03 08:28:29.256211	f	\N	\N
5	narasingh suar	9348075033	\N	\N	t	2026-06-03 08:34:40.076701	2026-06-03 08:35:08.559411	f	\N	\N
6	siddharth Gautam	9305096443	\N	\N	f	2026-08-07 08:36:18.455515	2026-08-07 08:36:18.455515	f	\N	\N
\.


--
-- Data for Name: wallet_histories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallet_histories (id, wallet_id, user_id, parent_id, amount, before_balance, after_balance, transaction_type, remark, reference_id, created_at, updated_at) FROM stdin;
1	58	136	\N	500.00	508101.45	507601.45	debit	Wallet Transfer	197	2026-05-26 09:49:35.813057	2026-05-26 09:49:35.813057
2	71	181	136	500.00	0.00	500.00	credit	Fund Request Approved	197	2026-05-26 09:49:35.820652	2026-05-26 09:49:35.820652
3	58	136	\N	4500.00	507601.45	503101.45	debit	Admin Wallet Transfer	TXN3FBC0899	2026-05-26 12:31:58.118776	2026-05-26 12:31:58.118776
4	71	181	136	4500.00	500.00	5000.00	credit	Admin Wallet Credit	TXN3FBC0899	2026-05-26 12:31:58.123935	2026-05-26 12:31:58.123935
5	71	181	136	200.00	5000.00	4800.00	debit	Admin Wallet Credit to User	TXNDD07AC7C	2026-05-27 13:22:47.45454	2026-05-27 13:22:47.45454
6	72	189	184	200.00	0.00	200.00	credit	Wallet Credit by Admin	TXNDD07AC7C	2026-05-27 13:22:47.45949	2026-05-27 13:22:47.45949
7	72	189	184	19.00	200.00	181.00	debit	Recharge Amount Deducted	TXN571439	2026-05-27 13:28:37.607007	2026-05-27 13:28:37.607007
8	71	181	136	0.15	4800.00	4800.15	credit	Recharge Commission	TXN571439	2026-05-27 13:28:37.655337	2026-05-27 13:28:37.655337
9	71	181	136	20.00	4800.15	4780.15	debit	Admin Wallet Credit to User	TXNB3BCC4D0	2026-05-29 12:11:02.213682	2026-05-29 12:11:02.213682
10	75	193	184	20.00	0.00	20.00	credit	Wallet Credit by Admin	TXNB3BCC4D0	2026-05-29 12:11:02.220452	2026-05-29 12:11:02.220452
11	72	189	184	3.00	171.00	168.00	debit	Bank Verification Fee	BANKVERIFY1780059348	2026-05-29 12:55:48.502254	2026-05-29 12:55:48.502254
12	71	181	136	200.00	4780.15	4580.15	debit	Admin Wallet Credit to User	TXN01FFD307	2026-06-03 08:23:16.321645	2026-06-03 08:23:16.321645
13	72	189	184	200.00	48.00	248.00	credit	Wallet Credit by Admin	TXN01FFD307	2026-06-03 08:23:16.379557	2026-06-03 08:23:16.379557
14	72	189	184	3.00	128.00	125.00	debit	Bank Verification Fee	BANKVERIFY1780475762	2026-06-03 08:36:02.448227	2026-06-03 08:36:02.448227
15	71	181	136	100.00	4580.15	4480.15	debit	Admin Wallet Credit to User	TXN1F8FDAF5	2026-06-07 13:50:52.710327	2026-06-07 13:50:52.710327
16	72	189	184	100.00	125.00	225.00	credit	Wallet Credit by Admin	TXN1F8FDAF5	2026-06-07 13:50:52.719812	2026-06-07 13:50:52.719812
17	8	127	104	239.00	7115.08	6876.08	debit	Recharge Amount Deducted	TXN557807	2026-06-11 09:58:26.491111	2026-06-11 09:58:26.491111
18	7	104	136	1.94	73792.29	73794.22	credit	Recharge Commission	TXN557807	2026-06-11 09:58:26.58368	2026-06-11 09:58:26.58368
19	8	127	104	239.00	6876.08	6637.08	debit	Recharge Amount Deducted	TXN362988	2026-06-17 07:50:22.374691	2026-06-17 07:50:22.374691
20	7	104	136	1.94	73794.22	73796.16	credit	Recharge Commission	TXN362988	2026-06-17 07:50:22.494774	2026-06-17 07:50:22.494774
21	71	181	136	20.00	4480.15	4460.15	debit	Admin Wallet Credit to User	TXN66EF0B99	2026-07-06 12:08:56.378785	2026-07-06 12:08:56.378785
22	76	194	184	20.00	0.00	20.00	credit	Wallet Credit by Admin	TXN66EF0B99	2026-07-06 12:08:56.44444	2026-07-06 12:08:56.44444
23	71	181	136	100.00	4460.15	4360.15	debit	Admin Wallet Credit to User	TXN11DBF814	2026-07-06 12:11:03.097327	2026-07-06 12:11:03.097327
24	76	194	184	100.00	20.00	120.00	credit	Wallet Credit by Admin	TXN11DBF814	2026-07-06 12:11:03.133207	2026-07-06 12:11:03.133207
25	76	194	184	80.00	110.00	30.00	debit	DMT Main Amount Debit	MAIN_65	2026-07-06 12:15:50.068035	2026-07-06 12:15:50.068035
26	76	194	184	60.00	30.00	90.00	credit	DMT Commission Credit	TXN842623	2026-07-06 12:15:50.154754	2026-07-06 12:15:50.154754
27	76	194	184	7.00	90.00	83.00	debit	DMT TDS	hjhd8789798	2026-07-06 12:15:50.247759	2026-07-06 12:15:50.247759
28	76	194	184	3.00	83.00	80.00	debit	Dmt Gst	707dds8	2026-07-06 12:15:50.2892	2026-07-06 12:15:50.2892
29	71	181	136	10.00	4360.15	4370.15	credit	DMT Flat Commission - ADMIN	33232dsdd	2026-07-06 12:15:50.77827	2026-07-06 12:15:50.77827
30	7	104	136	0.75	73796.16	73796.91	credit	AEPS Mini Statement Commission	1	2026-08-07 06:32:01.8022	2026-08-07 06:32:01.8022
31	7	104	136	0.75	73796.91	73797.66	credit	AEPS Mini Statement Commission	2	2026-08-07 06:34:28.99473	2026-08-07 06:34:28.99473
32	7	104	136	0.75	73797.66	73798.41	credit	AEPS Mini Statement Commission	3	2026-08-07 06:36:15.52942	2026-08-07 06:36:15.52942
33	76	194	184	21.00	80.00	59.00	debit	DMT Main Amount Debit	MAIN_68	2026-08-07 08:37:18.404249	2026-08-07 08:37:18.404249
34	76	194	184	1.00	59.00	60.00	credit	DMT Commission Credit	TXN630690	2026-08-07 08:37:18.409222	2026-08-07 08:37:18.409222
35	76	194	184	7.00	60.00	53.00	debit	DMT TDS	hjhd8789798	2026-08-07 08:37:18.412846	2026-08-07 08:37:18.412846
36	76	194	184	3.00	53.00	50.00	debit	Dmt Gst	707dds8	2026-08-07 08:37:18.417209	2026-08-07 08:37:18.417209
37	71	181	136	10.00	4370.15	4380.15	credit	DMT Flat Commission - ADMIN	33232dsdd	2026-08-07 08:37:18.458021	2026-08-07 08:37:18.458021
38	76	194	184	21.00	50.00	29.00	debit	DMT Main Amount Debit	MAIN_68	2026-08-07 08:43:45.855348	2026-08-07 08:43:45.855348
39	76	194	184	1.00	29.00	30.00	credit	DMT Commission Credit	TXN501049	2026-08-07 08:43:45.859692	2026-08-07 08:43:45.859692
40	76	194	184	7.00	30.00	23.00	debit	DMT TDS	hjhd8789798	2026-08-07 08:43:45.862905	2026-08-07 08:43:45.862905
41	76	194	184	3.00	23.00	20.00	debit	Dmt Gst	707dds8	2026-08-07 08:43:45.866018	2026-08-07 08:43:45.866018
42	76	194	184	5.00	20.00	25.00	credit	DMT Flat Commission - RETAILER	33232dsdd	2026-08-07 08:43:45.880707	2026-08-07 08:43:45.880707
43	71	181	136	5.00	4380.15	4385.15	credit	DMT Flat Commission - ADMIN	33232dsdd	2026-08-07 08:43:45.899475	2026-08-07 08:43:45.899475
44	76	194	184	21.00	25.00	4.00	debit	DMT Main Amount Debit	MAIN_68	2026-08-07 08:48:04.363555	2026-08-07 08:48:04.363555
45	76	194	184	1.00	4.00	5.00	credit	DMT Commission Credit	TXN993678	2026-08-07 08:48:04.366777	2026-08-07 08:48:04.366777
46	76	194	184	3.00	5.00	2.00	debit	Dmt Gst	707dds8	2026-08-07 08:48:04.37134	2026-08-07 08:48:04.37134
47	76	194	184	5.00	2.00	7.00	credit	DMT Flat Commission - RETAILER	33232dsdd	2026-08-07 08:48:04.386335	2026-08-07 08:48:04.386335
48	76	194	184	21.00	80.00	59.00	debit	DMT Main Amount Debit	MAIN_68	2026-08-07 08:50:31.003622	2026-08-07 08:50:31.003622
49	76	194	184	1.00	59.00	60.00	credit	DMT Commission Credit	TXN955287	2026-08-07 08:50:31.060882	2026-08-07 08:50:31.060882
50	76	194	184	7.00	60.00	53.00	debit	DMT TDS	hjhd8789798	2026-08-07 08:50:31.064781	2026-08-07 08:50:31.064781
51	76	194	184	3.00	53.00	50.00	debit	Dmt Gst	707dds8	2026-08-07 08:50:31.068197	2026-08-07 08:50:31.068197
52	76	194	184	5.00	50.00	55.00	credit	DMT Flat Commission - RETAILER	33232dsdd	2026-08-07 08:50:31.080484	2026-08-07 08:50:31.080484
53	71	181	136	0.45	4385.15	4385.60	credit	AEPS Mini Statement Commission	6	2026-08-08 06:42:33.729714	2026-08-08 06:42:33.729714
54	71	181	136	0.45	4385.60	4386.05	credit	AEPS Mini Statement Commission	7	2026-08-08 06:47:28.355478	2026-08-08 06:47:28.355478
55	71	181	136	0.45	4386.05	4386.50	credit	AEPS Mini Statement Commission	8	2026-08-18 13:49:57.630631	2026-08-18 13:49:57.630631
56	71	181	136	0.45	4386.50	4386.95	credit	AEPS Mini Statement Commission	9	2026-08-18 13:54:43.63506	2026-08-18 13:54:43.63506
57	71	181	136	0.45	4386.95	4387.40	credit	AEPS Mini Statement Commission	10	2026-08-19 05:38:26.688711	2026-08-19 05:38:26.688711
58	76	194	184	0.20	55.00	55.20	credit	AEPS Transaction Commission	20	2026-08-19 12:51:51.705242	2026-08-19 12:51:51.705242
59	71	181	136	0.45	4387.40	4387.85	credit	AEPS Mini Statement Commission	12	2026-08-29 06:29:18.521346	2026-08-29 06:29:18.521346
60	76	194	184	2.80	55.20	58.00	credit	AEPS Transaction Commission	21	2026-08-31 12:02:36.650177	2026-08-31 12:02:36.650177
\.


--
-- Data for Name: wallet_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallet_transactions (id, wallet_id, tx_id, mode, transaction_type, amount, status, description, created_at, updated_at, fund_request_id) FROM stdin;
33	7	TXN260275	credit	UPI	100.00	success	Fund request created by admin 104	2025-09-06 12:32:32.759583	2025-09-06 12:32:42.141969	36
34	7	TXN652712	credit	NEFT	100.00	success	Fund request created by admin 104	2025-09-06 12:34:04.588085	2025-09-06 12:34:09.857552	37
35	7	TXN311087	credit	UPI	100.00	success	Fund request created by admin 104	2025-09-06 12:34:52.807495	2025-09-06 12:34:57.990391	38
36	8	TXN205966	credit	NEFT	93.00	success	Fund request created by user 127	2025-09-06 12:35:37.133478	2025-09-06 12:35:43.846227	39
38	7	TXN815102	credit	UPI	1000.00	success	Fund request created by admin 104	2025-09-06 12:36:50.773044	2025-09-06 12:36:55.856664	41
37	8	TXN731009	credit	CashInBank	400.00	success	Fund request created by user 127	2025-09-06 12:36:21.973743	2025-09-06 12:37:04.573244	40
39	7	TXN657825	credit	UPI	100.00	success	Fund request created by admin 104	2025-09-06 12:50:35.924536	2025-09-06 12:50:43.761079	42
40	8	TXN741310	credit	NEFT	100.00	success	Fund request created by user 127	2025-09-06 12:52:53.435952	2025-09-06 12:53:35.352903	43
41	7	TXN216166	credit	UPI	100.00	success	Fund request created by admin 104	2025-09-06 12:59:23.060039	2025-09-06 12:59:40.814622	44
42	8	TXN921061	credit	Cheque	100.00	success	Fund request created by user 127	2025-09-06 13:02:08.890079	2025-09-06 13:02:21.415649	45
43	8	TXN278044	credit	CashInBank	1000.00	success	Fund request created by user 127	2025-09-08 04:47:39.065245	2025-09-08 04:48:00.600174	46
44	8	TXN777359	credit	IMPS	100.00	success	Fund request created by user 127	2025-09-08 05:38:42.866442	2025-09-08 05:38:48.103136	47
45	9	TXN929523	credit	NEFT	200.00	pending	Fund request created by user 139	2025-09-08 05:43:00.602515	2025-09-08 05:43:00.602515	48
46	9	TXN204726	credit	NEFT	299.00	success	Fund request created by user 139	2025-09-08 05:44:50.501907	2025-09-08 05:44:55.907098	49
47	10	TXN504986	credit	NEFT	399.00	success	Fund request created by user 134	2025-09-08 06:37:14.710744	2025-09-08 06:37:47.176799	50
48	10	TXN553011	credit	UPI	100.00	success	Fund request created by user 134	2025-09-08 07:28:53.011439	2025-09-08 07:29:22.174865	51
49	10	TXN988040	credit	NEFT	120.00	success	Fund request created by user 134	2025-09-08 07:45:11.383965	2025-09-08 07:45:20.505088	52
50	7	TXN304406	credit	NEFT	100.00	success	Fund request created by admin 104	2025-09-08 07:53:10.203717	2025-09-08 07:53:45.357626	53
51	7	TXN615493	credit	NEFT	100.00	success	Fund request created by admin 104	2025-09-08 08:30:37.311863	2025-09-08 08:30:46.83055	54
52	7	TXN129506	credit	CashInBank	100.00	success	Fund request created by admin 104	2025-09-08 08:32:27.800666	2025-09-08 08:32:37.465641	55
54	9	TXN524545	credit	Netbanking	997.00	success	Fund request created by user 139	2025-09-08 12:31:35.799431	2025-09-08 12:31:46.119127	57
55	9	TXN117497	credit	Netbanking	500.00	success	Fund request created by user 139	2025-09-08 12:34:09.596441	2025-09-08 12:34:23.76643	58
56	7	TXN906689	credit	UPI	1000.00	success	Fund request created by admin 104	2025-09-08 13:22:27.758074	2025-09-08 13:22:38.45312	59
57	8	TXN855302	credit	Cash	100.00	success	Fund request created by user 127	2025-09-10 13:31:42.363873	2025-09-11 07:35:41.520124	60
58	10	TXN973247	credit	UPI	300.00	success	Fund request created by user 134	2025-09-11 06:42:27.994446	2025-09-11 07:37:22.381013	61
59	10	TXN575575	credit	UPI	300.00	success	Fund request created by user 134	2025-09-11 07:38:16.985531	2025-09-11 07:38:35.314701	62
60	10	TXN282061	credit	UPI	300.00	success	Fund request created by user 134	2025-09-11 07:39:29.99097	2025-09-11 07:40:10.645672	63
53	7	TXN554071	credit	UPI	100.00	success	Fund request created by admin 104	2025-09-08 08:33:58.92784	2025-09-11 07:40:44.459161	56
61	10	TXN395543	credit	UPI	300.00	success	Fund request created by user 134	2025-09-11 07:40:27.474232	2025-09-11 07:41:10.807213	64
62	10	TXN263296	credit	UPI	300.00	success	Fund request created by user 134	2025-09-11 07:56:25.347379	2025-09-11 07:57:29.385367	65
63	10	TXN429176	credit	UPI	300.00	success	Fund request created by user 134	2025-09-11 08:38:21.066238	2025-09-11 08:38:50.562914	66
65	7	TXN574662	credit	UPI	300000.00	success	Fund request created by admin 104	2025-09-11 08:41:07.390151	2025-09-11 08:41:13.494075	68
64	10	TXN864120	credit	UPI	300.00	success	Fund request created by user 134	2025-09-11 08:40:14.029634	2025-09-11 08:45:43.187823	67
66	10	TXN925880	credit	UPI	300.00	success	Fund request created by user 134	2025-09-11 08:45:56.284176	2025-09-11 09:17:31.603568	69
67	7	TXN403626	credit	UPI	1000.00	success	Fund request created by admin 104	2025-09-11 09:16:03.667316	2025-09-11 09:30:58.389928	70
69	7	TXN642414	credit	UPI	100.00	success	Fund request created by admin 104	2025-09-11 09:46:31.334899	2025-09-11 09:53:51.629337	72
71	9	TXN622919	credit	UPI	10000.00	success	Fund request created by user 139	2025-09-11 09:56:48.441851	2025-09-11 09:57:09.955905	74
70	8	TXN134405	credit	UPI	10000.00	success	Fund request created by user 127	2025-09-11 09:56:48.246996	2025-09-11 09:57:32.159716	73
73	9	TXN736741	credit	Cheque	90000.00	success	Fund request created by user 139	2025-09-11 11:04:05.655865	2025-09-11 11:04:54.951083	76
74	10	TXN570781	credit	UPI	120.00	success	Fund request created by user 134	2025-09-11 12:55:29.695447	2025-09-11 12:55:54.552283	77
75	7	TXN965686	credit	UPI	100.00	success	Fund request created by admin 104	2025-09-11 12:56:20.475226	2025-09-11 12:56:39.814303	78
76	9	TXN947096	credit	Cash	333.00	success	Fund request created by user 139	2025-09-11 14:12:28.325684	2025-09-11 14:12:55.431009	79
77	7	TXN811393	credit	UPI	1089.00	success	Fund request created by admin 104	2025-09-11 14:13:40.697548	2025-09-11 14:16:24.323171	80
86	7	TXN722060	dsswefedsc	IMPS	3.00	success	Fund request created by admin 104	2025-09-12 10:45:43.832027	2025-09-12 10:46:02.708676	86
87	7	TXN498882	dsswefedsc	UPI	5.00	success	Fund request created by admin 104	2025-09-12 10:48:09.100852	2025-09-12 10:48:22.079924	87
88	7	TXN490834	dsswefedsc	UPI	5.00	success	Fund request created by admin 104	2025-09-12 10:49:33.185904	2025-09-12 10:51:01.197241	88
89	7	TXN480005	dsswefedsc	CashInBank	5.00	success	Fund request created by admin 104	2025-09-12 10:56:10.965736	2025-09-12 10:56:19.609449	89
90	9	TXN295751	credit	Cheque	44.00	success	Fund request created by user 139	2025-09-12 10:56:50.812884	2025-09-12 10:57:39.117474	90
72	8	TXN258373	credit	Netbanking	1000.00	success	Fund request created by user 127	2025-09-11 09:59:40.812424	2025-09-12 10:58:18.916405	75
91	8	TXN540327	credit	Netbanking	2000.00	success	Fund request created by user 127	2025-09-12 10:58:46.394786	2025-09-12 10:59:05.680502	91
92	7	TXN652823	dsswefedsc	NEFT	9.00	success	Fund request created by admin 104	2025-09-12 11:04:17.838631	2025-09-12 11:04:33.521854	92
93	7	TXN410031	dsswefedsc	UPI	5.00	success	Fund request created by admin 104	2025-09-12 11:07:46.11619	2025-09-12 11:08:10.921689	93
94	7	TXN567087	dsswefedsc	NEFT	5.00	success	Fund request created by admin 104	2025-09-12 11:09:37.774559	2025-09-12 11:10:34.721447	94
95	7	TXN886693	dsswefedsc	UPI	5.00	success	Fund request created by admin 104	2025-09-12 11:41:44.681578	2025-09-12 11:41:55.047594	95
96	7	TXN565285	dsswefedsc	UPI	5.00	success	Fund request created by admin 104	2025-09-12 11:44:37.185358	2025-09-12 11:45:23.947889	96
97	7	TXN323962	dsswefedsc	UPI	5.00	success	Fund request created by admin 104	2025-09-12 11:46:17.549363	2025-09-12 11:46:37.374574	97
99	59	TXN812583	dsswefedsc	IMPS	100.00	pending	Fund request created by admin 138	2025-09-12 12:06:33.559885	2025-09-12 12:06:33.559885	99
100	7	TXN124316	dsswefedsc	NEFT	5.00	success	Fund request created by admin 104	2025-09-12 12:07:09.183112	2025-09-12 12:10:01.965463	100
102	60	TXN586796	dsswefedsc	UPI	85.00	success	Fund request created by admin 141	2025-09-12 12:11:31.819465	2025-09-12 12:11:48.913497	102
101	59	TXN743709	dsswefedsc	IMPS	100.00	success	Fund request created by admin 138	2025-09-12 12:10:10.606201	2025-09-12 12:12:04.079765	101
103	60	TXN750109	dsswefedsc	Cash	90.00	success	Fund request created by admin 141	2025-09-12 12:41:03.050582	2025-09-12 12:43:28.28125	103
104	60	TXN431985	dsswefedsc	Cash	100.00	pending	Fund request created by admin 141	2025-09-12 12:47:36.205737	2025-09-12 12:47:36.205737	104
105	10	TXN365606	credit	NEFT	100.00	success	Fund request created by user 134	2025-09-15 17:29:52.918407	2025-09-15 17:30:20.993213	105
106	8	TXN929664	credit	UPI	50000.00	success	Fund request created by user 127	2025-09-18 07:03:50.192273	2025-09-18 07:04:06.024179	106
107	8	TXN695220	credit	CashInBank	2000.00	success	Fund request created by user 127	2025-09-18 07:13:36.806511	2025-09-18 07:13:48.146447	107
108	7	TXN688442	fund	IMPS	5000.00	pending	Fund request created by user 104	2025-11-17 05:38:37.426518	2025-11-17 05:38:37.426518	108
109	7	TXN905396	fund	IMPS	100.00	pending	Fund request created by user 104	2025-11-17 07:19:43.071105	2025-11-17 07:19:43.071105	109
110	7	TXN976120	fund	IMPS	100.00	success	Fund request created by user 104	2025-11-17 07:19:56.324586	2025-11-20 07:37:18.408992	110
121	7	TXN804628	fund	IMPS	100.00	pending	Fund request created by user 104	2025-11-20 11:44:38.891876	2025-11-20 11:44:38.891876	123
122	7	TXN868649	fund	IMPS	100.00	pending	Fund request created by user 104	2025-11-20 11:44:53.97895	2025-11-20 11:44:53.97895	124
123	7	TXN855068	fund	IMPS	100.00	pending	Fund request created by user 104	2025-11-20 11:45:05.861611	2025-11-20 11:45:05.861611	125
124	7	TXN383400	fund	IMPS	100.00	pending	Fund request created by user 104	2025-11-20 11:45:46.828856	2025-11-20 11:45:46.828856	126
125	7	TXN620727	fund	Cash	100.00	pending	Fund request created by user 104	2025-11-20 11:46:12.523149	2025-11-20 11:46:12.523149	127
126	7	TXN897526	fund	CashInBank	109.00	pending	Fund request created by user 104	2025-11-20 11:46:44.535361	2025-11-20 11:46:44.535361	128
127	7	TXN231446	fund	CashInBank	109.00	pending	Fund request created by user 104	2025-11-20 11:46:59.159528	2025-11-20 11:46:59.159528	129
131	9	TXN151069	fund	imps	247.00	success	Fund request created by user 139	2025-11-20 12:21:24.399653	2025-11-21 06:03:14.362644	133
132	7	TXN600149	fund	IMPS	111.00	pending	Fund request created by user 104	2025-11-21 06:14:49.20915	2025-11-21 06:14:49.20915	134
130	9	TXN929729	fund	neft	52.00	success	Fund request created by user 139	2025-11-20 12:15:14.571992	2025-11-21 06:22:46.028453	132
140	8	TXN546535	fund	NEFT	555.00	pending	Fund request created by user 127	2025-11-21 11:31:49.242408	2025-11-21 11:31:49.242408	142
141	8	TXN962955	fund	NEFT	555.00	pending	Fund request created by user 127	2025-11-21 11:32:04.811048	2025-11-21 11:32:04.811048	143
129	7	TXN136243	fund	UPI	676.00	rejected	Fund request created by user 104	2025-11-20 11:49:09.785453	2025-11-20 11:49:09.785453	131
114	9	TXN500258	fund	credit	1000.00	success	Fund request created by user 139	2025-11-20 08:56:47.383206	2025-11-21 07:06:51.504046	116
128	7	TXN914330	fund	CashInBank	109.00	rejected	Fund request created by user 104	2025-11-20 11:47:16.706393	2025-11-20 11:47:16.706393	130
142	8	TXN503604	fund	IMPS	593.00	pending	Fund request created by user 127	2025-11-21 11:32:57.865983	2025-11-21 11:32:57.865983	144
120	9	TXN590699	fund	imps	300.00	success	Fund request created by user 139	2025-11-20 10:06:15.609033	2025-11-21 07:44:14.577654	122
117	9	TXN536285	fund	credit	1000.00	rejected	Fund request created by user 139	2025-11-20 09:51:34.012561	2025-11-20 09:51:34.012561	119
68	10	TXN709876	credit	UPI	300.00	success	Fund request created by user 134	2025-09-11 09:16:37.371668	2025-11-21 07:49:32.854543	71
119	9	TXN762280	fund	neft	2000.00	rejected	Fund request created by user 139	2025-11-20 09:59:40.892312	2025-11-21 07:52:06.35838	121
113	9	TXN394102	fund	credit	1000.00	success	Fund request created by user 139	2025-11-20 08:56:38.768482	2025-11-21 10:11:03.962105	115
98	9	TXN612223	credit	Cash	85.00	rejected	Fund request created by user 139	2025-09-12 12:05:31.133304	2025-11-21 10:11:16.405549	98
133	8	TXN301206	fund	neft	32.00	pending	Fund request created by user 127	2025-11-21 10:33:38.528906	2025-11-21 10:33:38.528906	135
134	8	TXN338499	fund	UPI	222.00	pending	Fund request created by user 127	2025-11-21 10:39:59.174885	2025-11-21 10:39:59.174885	136
135	7	TXN575554	fund	dsds	567.00	pending	Fund request created by user 104	2025-11-21 10:48:56.106909	2025-11-21 10:48:56.106909	137
136	8	TXN136325	fund	NEFT	1212.00	pending	Fund request created by user 127	2025-11-21 10:55:30.206716	2025-11-21 10:55:30.206716	138
137	8	TXN538221	fund	NEFT	1212.00	pending	Fund request created by user 127	2025-11-21 10:55:37.75728	2025-11-21 10:55:37.75728	139
138	8	TXN793565	fund	NEFT	100.00	pending	Fund request created by user 127	2025-11-21 11:07:27.101748	2025-11-21 11:07:27.101748	140
139	8	TXN848917	fund	Netbanking	600.00	pending	Fund request created by user 127	2025-11-21 11:26:25.070916	2025-11-21 11:26:25.070916	141
144	8	TXN547993	fund	IMPS	66.00	rejected	Fund request created by user 127	2025-11-21 11:43:07.487195	2025-11-21 13:13:38.166916	146
143	8	TXN548709	fund	IMPS	13.00	success	Fund request created by user 127	2025-11-21 11:35:59.919482	2025-11-21 13:14:35.941727	145
146	63	TXN108368	fund	CashInBank	18.00	pending	Fund request created by user 169	2025-11-25 11:15:07.725344	2025-11-25 11:15:07.725344	148
147	63	TXN839645	fund	UPI	103.00	pending	Fund request created by user 169	2025-11-26 07:08:01.466011	2025-11-26 07:08:01.466011	149
145	62	TXN661737	fund	NEFT	58.00	rejected	Fund request created by user 170	2025-11-25 11:09:21.390097	2025-11-26 10:14:08.377926	147
148	62	TXN113948	fund	Cash	29.00	pending	Fund request created by user 170	2025-11-26 10:20:14.127064	2025-11-26 10:20:14.127064	150
149	63	TXN721413	fund	UPI	19.00	pending	Fund request created by user 169	2025-11-26 10:24:03.7076	2025-11-26 10:24:03.7076	151
150	62	TXN362401	fund	Netbanking	20.00	pending	Fund request created by user 170	2025-11-26 10:25:37.357375	2025-11-26 10:25:37.357375	152
151	7	TXN484500	fund	IMPS	11.00	pending	Fund request created by user 104	2025-11-26 10:31:41.841837	2025-11-26 10:31:41.841837	153
152	62	TXN903486	fund	CashInBank	19.00	pending	Fund request created by user 170	2025-11-26 10:48:22.372735	2025-11-26 10:48:22.372735	154
153	62	TXN268569	fund	IMPS	101.00	pending	Fund request created by user 170	2025-11-26 11:33:10.897882	2025-11-26 11:33:10.897882	155
154	63	TXN539497	fund	Netbanking	620.00	pending	Fund request created by user 169	2025-11-26 12:28:29.634029	2025-11-26 12:28:29.634029	156
155	64	TXN896837	fund	Cheque	200.00	pending	Fund request created by user 174	2025-11-26 12:44:47.037605	2025-11-26 12:44:47.037605	157
156	64	TXN509785	fund	Netbanking	5000.00	pending	Fund request created by user 174	2025-11-26 12:45:48.089257	2025-11-26 12:45:48.089257	158
157	64	TXN443275	fund	UPI	99.00	success	Fund request created by user 174	2025-11-26 12:55:08.642744	2025-11-26 12:59:12.530277	159
158	63	TXN998791	fund	Netbanking	100.00	success	Fund request created by user 169	2025-11-26 12:58:34.636199	2025-11-26 12:58:51.326935	160
159	66	TXN579040	fund	Netbanking	19.00	pending	Fund request created by user 175	2025-11-27 07:38:01.050998	2025-11-27 07:38:01.050998	161
160	66	TXN779591	fund	Cash	1.00	success	Fund request created by user 175	2025-11-27 07:39:16.221446	2025-11-27 07:39:32.925073	162
161	63	TXN930845	fund	NEFT	10000.00	success	Fund request created by user 169	2025-11-27 08:47:38.451889	2025-11-27 08:50:02.434205	163
162	67	TXN546186	fund	NEFT	11.00	success	Fund request created by user 176	2025-12-11 10:00:01.58763	2025-12-11 10:00:43.140099	164
163	67	TXN862862	fund	Netbanking	100.00	success	Fund request created by user 176	2025-12-11 12:12:19.831019	2025-12-11 12:12:37.435977	165
164	68	TXN840113	fund	NEFT	10.00	success	Fund request created by user 177	2025-12-12 11:53:39.899403	2025-12-12 11:54:13.19808	166
165	8	TXN761634	fund	NEFT	120.00	pending	Fund request created by user 127	2025-12-13 09:07:49.217418	2025-12-13 09:07:49.217418	167
166	7	TXN715838	fund	Cheque	10.00	pending	Fund request created by user 104	2025-12-16 05:26:55.80782	2025-12-16 05:26:55.80782	168
167	7	TXN915495	fund	Netbanking	3.00	pending	Fund request created by user 104	2025-12-16 06:11:54.490157	2025-12-16 06:11:54.490157	169
168	7	TXN224865	fund	Netbanking	5.00	pending	Fund request created by user 104	2025-12-16 06:21:26.897646	2025-12-16 06:21:26.897646	170
169	7	TXN640335	fund	NEFT	6.00	pending	Fund request created by user 104	2025-12-16 06:22:08.05943	2025-12-16 06:22:08.05943	171
170	7	TXN669753	fund	UPI	2.00	pending	Fund request created by user 104	2025-12-16 06:23:33.935673	2025-12-16 06:23:33.935673	172
171	7	TXN767703	fund	CashInBank	8.00	pending	Fund request created by user 104	2025-12-16 06:28:03.154548	2025-12-16 06:28:03.154548	173
172	9	TXN933607	fund	UPI	2.00	pending	Fund request created by user 139	2025-12-16 06:45:12.43861	2025-12-16 06:45:12.43861	174
173	9	TXN833016	fund	NEFT	4.00	pending	Fund request created by user 139	2025-12-16 06:58:07.491009	2025-12-16 06:58:07.491009	175
174	9	TXN729547	fund	UPI	2.00	pending	Fund request created by user 139	2025-12-16 07:00:44.084671	2025-12-16 07:00:44.084671	176
175	7	TXN891350	fund	CashInBank	3.00	pending	Fund request created by user 104	2025-12-17 12:53:35.526971	2025-12-17 12:53:35.526971	177
176	69	TXN370574	fund	UPI	200.00	pending	Fund request created by user 178	2025-12-18 09:59:40.465874	2025-12-18 09:59:40.465874	178
177	70	TXN218391	fund	Netbanking	700.00	pending	Fund request created by user 103	2025-12-18 10:01:39.832733	2025-12-18 10:01:39.832733	179
178	8	TXN471580	fund	CashInBank	10.00	pending	Fund request created by user 127	2025-12-19 08:58:03.094245	2025-12-19 08:58:03.094245	180
179	8	TXN138223	fund	NEFT	20.00	pending	Fund request created by user 127	2025-12-19 10:25:21.580733	2025-12-19 10:25:21.580733	181
180	8	TXN760451	fund	NEFT	20.00	pending	Fund request created by user 127	2025-12-19 10:25:31.431636	2025-12-19 10:25:31.431636	182
181	8	TXN811813	fund	NEFT	20.00	pending	Fund request created by user 127	2025-12-19 10:25:44.248549	2025-12-19 10:25:44.248549	183
182	8	TXN446715	fund	NEFT	12.00	pending	Fund request created by user 127	2025-12-19 10:27:40.84941	2025-12-19 10:27:40.84941	184
183	8	TXN557769	fund	NEFT	12.00	pending	Fund request created by user 127	2025-12-19 10:27:51.67473	2025-12-19 10:27:51.67473	185
184	8	TXN549484	fund	NEFT	7.00	pending	Fund request created by user 127	2025-12-19 10:29:34.309227	2025-12-19 10:29:34.309227	186
185	8	TXN236695	fund	UPI	9.00	pending	Fund request created by user 127	2025-12-19 10:30:26.041683	2025-12-19 10:30:26.041683	187
186	8	TXN490519	fund	Cash	19.00	pending	Fund request created by user 127	2025-12-19 10:37:22.174372	2025-12-19 10:37:22.174372	188
187	8	TXN889549	fund	Netbanking	45.00	pending	Fund request created by user 127	2025-12-19 10:52:38.631206	2025-12-19 10:52:38.631206	189
188	8	TXN709013	fund	Netbanking	10.00	pending	Fund request created by user 127	2025-12-19 11:24:58.628265	2025-12-19 11:24:58.628265	190
189	8	TXN602301	fund	Netbanking	10.00	pending	Fund request created by user 127	2025-12-19 11:25:42.351668	2025-12-19 11:25:42.351668	191
190	8	TXN688279	fund	Netbanking	8.00	pending	Fund request created by user 127	2025-12-19 11:27:42.359283	2025-12-19 11:27:42.359283	192
191	8	TXN990749	fund	Netbanking	8.00	pending	Fund request created by user 127	2025-12-19 11:29:07.75253	2025-12-19 11:29:07.75253	193
192	8	TXN519009	fund	Netbanking	99.00	pending	Fund request created by user 127	2025-12-19 13:03:30.382142	2025-12-19 13:03:30.382142	194
193	8	TXN809852	fund	NEFT	21.00	pending	Fund request created by user 127	2025-12-19 13:04:09.783932	2025-12-19 13:04:09.783932	195
194	7	TXN332694	fund	Cash	101.00	pending	Fund request created by user 104	2025-12-24 05:08:45.803311	2025-12-24 05:08:45.803311	196
195	7	TXN574219	fund	UPI	11.00	pending	Fund request created by user 104	2025-12-24 05:10:55.162128	2025-12-24 05:10:55.162128	197
196	8	TXN794095	fund	IMPS	100.00	pending	Fund request created by user 127	2026-05-26 05:05:17.568725	2026-05-26 05:05:17.568725	198
197	71	TXN495516	fund	IMPS	500.00	success	Fund request created by user 181	2026-05-26 08:44:57.134649	2026-05-26 09:49:35.83159	199
\.


--
-- Data for Name: wallets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallets (id, user_id, balance, created_at, updated_at) FROM stdin;
60	141	230.0	2025-09-12 12:11:31.809681	2025-09-12 12:49:13.271991
59	138	100.0	2025-09-12 12:06:33.547259	2025-09-12 12:22:20.631315
65	171	0.0	2025-11-26 12:51:20.891599	2025-11-26 12:51:20.891599
9	139	667.0	2025-09-08 05:43:00.575812	2025-12-27 10:57:10.543726
64	174	99.0	2025-11-26 12:44:46.994587	2025-11-26 12:59:12.509334
66	175	67.0	2025-11-27 07:38:01.017132	2025-11-27 12:38:48.61175
63	169	6628.38	2025-11-25 11:15:07.705043	2025-12-08 08:46:21.277387
61	145	270.0	2025-11-20 06:19:09.359179	2025-11-20 07:46:13.909998
10	134	47564.0	2025-09-08 06:37:14.67418	2025-11-21 07:49:32.843823
68	177	9.0	2025-12-12 11:53:39.860422	2025-12-12 11:55:00.447016
62	170	0.0	2025-11-25 11:09:21.348811	2025-11-25 11:09:21.348811
67	176	87.0	2025-12-11 10:00:01.558063	2025-12-18 07:23:09.543588
69	178	0.0	2025-12-18 09:59:40.450945	2025-12-18 09:59:40.450945
70	103	0.0	2025-12-18 10:01:39.815157	2025-12-18 10:01:39.815157
73	190	20.0	2026-05-29 10:02:45.672298	2026-05-29 10:02:45.672298
74	191	20.0	2026-05-29 10:43:40.323529	2026-05-29 10:43:58.597402
75	193	20.0	2026-05-29 12:11:02.171242	2026-05-29 12:11:02.217985
58	136	503121.4534	2025-09-12 10:29:25.138537	2026-06-03 08:31:12.086187
72	189	225.0	2026-05-27 13:22:47.420944	2026-06-07 13:50:52.71775
8	127	6637.08	2025-09-06 12:35:37.121371	2026-06-17 07:50:22.353197
7	104	73798.40939999999	2025-09-06 12:32:32.749727	2026-08-07 06:36:15.525764
77	196	200.0	2026-08-07 10:47:24.520755	2026-08-07 10:47:24.520755
71	181	4387.853899999998	2026-05-26 08:44:57.10555	2026-08-29 06:29:18.516072
76	194	58.0	2026-07-06 12:03:02.751883	2026-08-31 12:02:36.635779
\.


--
-- Name: account_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_transactions_id_seq', 48, true);


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 1, false);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 1, false);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 1, false);


--
-- Name: aeps_commission_slab_ranges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aeps_commission_slab_ranges_id_seq', 8, true);


--
-- Name: aeps_commission_slabs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aeps_commission_slabs_id_seq', 28, true);


--
-- Name: aeps_mini_statements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aeps_mini_statements_id_seq', 12, true);


--
-- Name: aeps_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aeps_transactions_id_seq', 21, true);


--
-- Name: aeps_wallet_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aeps_wallet_transactions_id_seq', 1, false);


--
-- Name: aeps_wallets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aeps_wallets_id_seq', 6, true);


--
-- Name: banks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.banks_id_seq', 44, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 58, true);


--
-- Name: cibil_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cibil_reports_id_seq', 1, false);


--
-- Name: commissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commissions_id_seq', 148, true);


--
-- Name: departments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departments_id_seq', 2, true);


--
-- Name: dmt_commission_slab_ranges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dmt_commission_slab_ranges_id_seq', 10, true);


--
-- Name: dmt_commission_slabs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dmt_commission_slabs_id_seq', 58, true);


--
-- Name: dmt_commissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dmt_commissions_id_seq', 10, true);


--
-- Name: dmt_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dmt_transactions_id_seq', 66, true);


--
-- Name: dmts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dmts_id_seq', 68, true);


--
-- Name: eko_banks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.eko_banks_id_seq', 701, true);


--
-- Name: enquiries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.enquiries_id_seq', 18, true);


--
-- Name: fund_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fund_requests_id_seq', 199, true);


--
-- Name: leads_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.leads_id_seq', 1, false);


--
-- Name: leave_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.leave_requests_id_seq', 1, false);


--
-- Name: refund_requests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.refund_requests_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 13, true);


--
-- Name: salaries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.salaries_id_seq', 1, false);


--
-- Name: schemes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schemes_id_seq', 46, true);


--
-- Name: service_product_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_product_items_id_seq', 40, true);


--
-- Name: service_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_products_id_seq', 25, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 18, true);


--
-- Name: support_tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.support_tickets_id_seq', 1, false);


--
-- Name: tasks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tasks_id_seq', 1, false);


--
-- Name: transaction_commissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaction_commissions_id_seq', 976, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 683, true);


--
-- Name: user_services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_services_id_seq', 235, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 200, true);


--
-- Name: vendor_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendor_users_id_seq', 6, true);


--
-- Name: wallet_histories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallet_histories_id_seq', 60, true);


--
-- Name: wallet_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallet_transactions_id_seq', 197, true);


--
-- Name: wallets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallets_id_seq', 77, true);


--
-- Name: account_transactions account_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_transactions
    ADD CONSTRAINT account_transactions_pkey PRIMARY KEY (id);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: aeps_commission_slab_ranges aeps_commission_slab_ranges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeps_commission_slab_ranges
    ADD CONSTRAINT aeps_commission_slab_ranges_pkey PRIMARY KEY (id);


--
-- Name: aeps_commission_slabs aeps_commission_slabs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeps_commission_slabs
    ADD CONSTRAINT aeps_commission_slabs_pkey PRIMARY KEY (id);


--
-- Name: aeps_mini_statements aeps_mini_statements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeps_mini_statements
    ADD CONSTRAINT aeps_mini_statements_pkey PRIMARY KEY (id);


--
-- Name: aeps_transactions aeps_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeps_transactions
    ADD CONSTRAINT aeps_transactions_pkey PRIMARY KEY (id);


--
-- Name: aeps_wallet_transactions aeps_wallet_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeps_wallet_transactions
    ADD CONSTRAINT aeps_wallet_transactions_pkey PRIMARY KEY (id);


--
-- Name: aeps_wallets aeps_wallets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeps_wallets
    ADD CONSTRAINT aeps_wallets_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: banks banks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banks
    ADD CONSTRAINT banks_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: cibil_reports cibil_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cibil_reports
    ADD CONSTRAINT cibil_reports_pkey PRIMARY KEY (id);


--
-- Name: commissions commissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commissions
    ADD CONSTRAINT commissions_pkey PRIMARY KEY (id);


--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- Name: dmt_commission_slab_ranges dmt_commission_slab_ranges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmt_commission_slab_ranges
    ADD CONSTRAINT dmt_commission_slab_ranges_pkey PRIMARY KEY (id);


--
-- Name: dmt_commission_slabs dmt_commission_slabs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmt_commission_slabs
    ADD CONSTRAINT dmt_commission_slabs_pkey PRIMARY KEY (id);


--
-- Name: dmt_commissions dmt_commissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmt_commissions
    ADD CONSTRAINT dmt_commissions_pkey PRIMARY KEY (id);


--
-- Name: dmt_transactions dmt_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmt_transactions
    ADD CONSTRAINT dmt_transactions_pkey PRIMARY KEY (id);


--
-- Name: dmts dmts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmts
    ADD CONSTRAINT dmts_pkey PRIMARY KEY (id);


--
-- Name: eko_banks eko_banks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.eko_banks
    ADD CONSTRAINT eko_banks_pkey PRIMARY KEY (id);


--
-- Name: enquiries enquiries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enquiries
    ADD CONSTRAINT enquiries_pkey PRIMARY KEY (id);


--
-- Name: fund_requests fund_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fund_requests
    ADD CONSTRAINT fund_requests_pkey PRIMARY KEY (id);


--
-- Name: leads leads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT leads_pkey PRIMARY KEY (id);


--
-- Name: leave_requests leave_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_requests
    ADD CONSTRAINT leave_requests_pkey PRIMARY KEY (id);


--
-- Name: refund_requests refund_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refund_requests
    ADD CONSTRAINT refund_requests_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: salaries salaries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaries
    ADD CONSTRAINT salaries_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: schemes schemes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schemes
    ADD CONSTRAINT schemes_pkey PRIMARY KEY (id);


--
-- Name: service_product_items service_product_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_product_items
    ADD CONSTRAINT service_product_items_pkey PRIMARY KEY (id);


--
-- Name: service_products service_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_products
    ADD CONSTRAINT service_products_pkey PRIMARY KEY (id);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: support_tickets support_tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT support_tickets_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: transaction_commissions transaction_commissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_commissions
    ADD CONSTRAINT transaction_commissions_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: user_services user_services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_services
    ADD CONSTRAINT user_services_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: vendor_users vendor_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendor_users
    ADD CONSTRAINT vendor_users_pkey PRIMARY KEY (id);


--
-- Name: wallet_histories wallet_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_histories
    ADD CONSTRAINT wallet_histories_pkey PRIMARY KEY (id);


--
-- Name: wallet_transactions wallet_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT wallet_transactions_pkey PRIMARY KEY (id);


--
-- Name: wallets wallets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_pkey PRIMARY KEY (id);


--
-- Name: idx_aeps_slab_ranges_scheme_service_amount; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_aeps_slab_ranges_scheme_service_amount ON public.aeps_commission_slab_ranges USING btree (scheme_id, service_type, min_amount, max_amount);


--
-- Name: idx_aeps_slabs_scheme_service_role_range; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_aeps_slabs_scheme_service_role_range ON public.aeps_commission_slabs USING btree (scheme_id, service_type, to_role, aeps_commission_slab_range_id);


--
-- Name: idx_on_assigner_id_assignee_id_service_id_befeb9b84f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX idx_on_assigner_id_assignee_id_service_id_befeb9b84f ON public.user_services USING btree (assigner_id, assignee_id, service_id);


--
-- Name: index_account_transactions_on_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_account_transactions_on_parent_id ON public.account_transactions USING btree (parent_id);


--
-- Name: index_account_transactions_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_account_transactions_on_user_id ON public.account_transactions USING btree (user_id);


--
-- Name: index_account_transactions_on_wallet_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_account_transactions_on_wallet_id ON public.account_transactions USING btree (wallet_id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_aeps_commission_slab_ranges_on_scheme_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_aeps_commission_slab_ranges_on_scheme_id ON public.aeps_commission_slab_ranges USING btree (scheme_id);


--
-- Name: index_aeps_mini_statements_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_aeps_mini_statements_on_user_id ON public.aeps_mini_statements USING btree (user_id);


--
-- Name: index_aeps_transactions_on_client_ref_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_aeps_transactions_on_client_ref_id ON public.aeps_transactions USING btree (client_ref_id);


--
-- Name: index_aeps_transactions_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_aeps_transactions_on_user_id ON public.aeps_transactions USING btree (user_id);


--
-- Name: index_aeps_wallet_transactions_on_aeps_wallet_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_aeps_wallet_transactions_on_aeps_wallet_id ON public.aeps_wallet_transactions USING btree (aeps_wallet_id);


--
-- Name: index_aeps_wallet_transactions_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_aeps_wallet_transactions_on_user_id ON public.aeps_wallet_transactions USING btree (user_id);


--
-- Name: index_aeps_wallets_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_aeps_wallets_on_user_id ON public.aeps_wallets USING btree (user_id);


--
-- Name: index_banks_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_banks_on_user_id ON public.banks USING btree (user_id);


--
-- Name: index_categories_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_categories_on_service_id ON public.categories USING btree (service_id);


--
-- Name: index_cibil_reports_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_cibil_reports_on_user_id ON public.cibil_reports USING btree (user_id);


--
-- Name: index_commissions_on_scheme_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_commissions_on_scheme_id ON public.commissions USING btree (scheme_id);


--
-- Name: index_commissions_on_service_product_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_commissions_on_service_product_item_id ON public.commissions USING btree (service_product_item_id);


--
-- Name: index_dmt_commission_slab_ranges_on_scheme_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_dmt_commission_slab_ranges_on_scheme_id ON public.dmt_commission_slab_ranges USING btree (scheme_id);


--
-- Name: index_dmt_commission_slabs_on_dmt_commission_slab_range_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_dmt_commission_slabs_on_dmt_commission_slab_range_id ON public.dmt_commission_slabs USING btree (dmt_commission_slab_range_id);


--
-- Name: index_dmt_commission_slabs_on_min_amount_and_max_amount; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_dmt_commission_slabs_on_min_amount_and_max_amount ON public.dmt_commission_slabs USING btree (min_amount, max_amount);


--
-- Name: index_dmt_commission_slabs_on_scheme_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_dmt_commission_slabs_on_scheme_id ON public.dmt_commission_slabs USING btree (scheme_id);


--
-- Name: index_dmts_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_dmts_on_user_id ON public.dmts USING btree (user_id);


--
-- Name: index_dmts_on_vendor_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_dmts_on_vendor_user_id ON public.dmts USING btree (vendor_user_id);


--
-- Name: index_enquiries_on_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_enquiries_on_role_id ON public.enquiries USING btree (role_id);


--
-- Name: index_fund_requests_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_fund_requests_on_user_id ON public.fund_requests USING btree (user_id);


--
-- Name: index_leads_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_leads_on_user_id ON public.leads USING btree (user_id);


--
-- Name: index_leave_requests_on_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_leave_requests_on_parent_id ON public.leave_requests USING btree (parent_id);


--
-- Name: index_leave_requests_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_leave_requests_on_user_id ON public.leave_requests USING btree (user_id);


--
-- Name: index_refund_requests_on_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_refund_requests_on_parent_id ON public.refund_requests USING btree (parent_id);


--
-- Name: index_refund_requests_on_transaction_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_refund_requests_on_transaction_id ON public.refund_requests USING btree (transaction_id);


--
-- Name: index_refund_requests_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_refund_requests_on_user_id ON public.refund_requests USING btree (user_id);


--
-- Name: index_salaries_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_salaries_on_user_id ON public.salaries USING btree (user_id);


--
-- Name: index_schemes_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_schemes_on_user_id ON public.schemes USING btree (user_id);


--
-- Name: index_service_product_items_on_operator_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_service_product_items_on_operator_id ON public.service_product_items USING btree (operator_id);


--
-- Name: index_service_product_items_on_service_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_service_product_items_on_service_product_id ON public.service_product_items USING btree (service_product_id);


--
-- Name: index_service_products_on_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_service_products_on_category_id ON public.service_products USING btree (category_id);


--
-- Name: index_support_tickets_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_support_tickets_on_user_id ON public.support_tickets USING btree (user_id);


--
-- Name: index_tasks_on_department_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_tasks_on_department_id ON public.tasks USING btree (department_id);


--
-- Name: index_tasks_on_lead_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_tasks_on_lead_id ON public.tasks USING btree (lead_id);


--
-- Name: index_tasks_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_tasks_on_user_id ON public.tasks USING btree (user_id);


--
-- Name: index_transaction_commissions_on_service_product_item_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_transaction_commissions_on_service_product_item_id ON public.transaction_commissions USING btree (service_product_item_id);


--
-- Name: index_transaction_commissions_on_transaction_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_transaction_commissions_on_transaction_id ON public.transaction_commissions USING btree (transaction_id);


--
-- Name: index_transaction_commissions_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_transaction_commissions_on_user_id ON public.transaction_commissions USING btree (user_id);


--
-- Name: index_transactions_on_service_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_transactions_on_service_product_id ON public.transactions USING btree (service_product_id);


--
-- Name: index_transactions_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_transactions_on_user_id ON public.transactions USING btree (user_id);


--
-- Name: index_user_services_on_assignee_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_user_services_on_assignee_id ON public.user_services USING btree (assignee_id);


--
-- Name: index_user_services_on_assigner_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_user_services_on_assigner_id ON public.user_services USING btree (assigner_id);


--
-- Name: index_user_services_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_user_services_on_service_id ON public.user_services USING btree (service_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_parent_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_parent_id ON public.users USING btree (parent_id);


--
-- Name: index_users_on_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_role_id ON public.users USING btree (role_id);


--
-- Name: index_users_on_scheme_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_scheme_id ON public.users USING btree (scheme_id);


--
-- Name: index_users_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_service_id ON public.users USING btree (service_id);


--
-- Name: index_vendor_users_on_phone_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_vendor_users_on_phone_number ON public.vendor_users USING btree (phone_number);


--
-- Name: index_wallet_histories_on_wallet_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_wallet_histories_on_wallet_id ON public.wallet_histories USING btree (wallet_id);


--
-- Name: index_wallet_transactions_on_fund_request_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_wallet_transactions_on_fund_request_id ON public.wallet_transactions USING btree (fund_request_id);


--
-- Name: index_wallet_transactions_on_wallet_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_wallet_transactions_on_wallet_id ON public.wallet_transactions USING btree (wallet_id);


--
-- Name: index_wallets_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_wallets_on_user_id ON public.wallets USING btree (user_id);


--
-- Name: user_services fk_rails_061e6d355b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_services
    ADD CONSTRAINT fk_rails_061e6d355b FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: aeps_wallet_transactions fk_rails_06ee9440e3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeps_wallet_transactions
    ADD CONSTRAINT fk_rails_06ee9440e3 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: users fk_rails_093eb6ba73; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_093eb6ba73 FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: cibil_reports fk_rails_0b8a683c69; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cibil_reports
    ADD CONSTRAINT fk_rails_0b8a683c69 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: aeps_wallet_transactions fk_rails_111ee8b968; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeps_wallet_transactions
    ADD CONSTRAINT fk_rails_111ee8b968 FOREIGN KEY (aeps_wallet_id) REFERENCES public.aeps_wallets(id);


--
-- Name: salaries fk_rails_127539cef3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaries
    ADD CONSTRAINT fk_rails_127539cef3 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: refund_requests fk_rails_14ceb117d8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refund_requests
    ADD CONSTRAINT fk_rails_14ceb117d8 FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: tasks fk_rails_1c1380c277; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk_rails_1c1380c277 FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- Name: leads fk_rails_1d08b36969; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT fk_rails_1d08b36969 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_services fk_rails_1e86d8b9bb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_services
    ADD CONSTRAINT fk_rails_1e86d8b9bb FOREIGN KEY (assignee_id) REFERENCES public.users(id);


--
-- Name: transaction_commissions fk_rails_29f6867058; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_commissions
    ADD CONSTRAINT fk_rails_29f6867058 FOREIGN KEY (service_product_item_id) REFERENCES public.service_product_items(id);


--
-- Name: dmt_commission_slab_ranges fk_rails_30c6fd6771; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmt_commission_slab_ranges
    ADD CONSTRAINT fk_rails_30c6fd6771 FOREIGN KEY (scheme_id) REFERENCES public.schemes(id);


--
-- Name: banks fk_rails_465b63d453; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banks
    ADD CONSTRAINT fk_rails_465b63d453 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: tasks fk_rails_4d2a9e4d7e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk_rails_4d2a9e4d7e FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: commissions fk_rails_53adc51571; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commissions
    ADD CONSTRAINT fk_rails_53adc51571 FOREIGN KEY (scheme_id) REFERENCES public.schemes(id);


--
-- Name: account_transactions fk_rails_5ab9b90923; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_transactions
    ADD CONSTRAINT fk_rails_5ab9b90923 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: schemes fk_rails_5f26bb7d01; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schemes
    ADD CONSTRAINT fk_rails_5f26bb7d01 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: transactions fk_rails_62d1c06ac1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_rails_62d1c06ac1 FOREIGN KEY (service_product_id) REFERENCES public.service_products(id);


--
-- Name: users fk_rails_642f17018b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_642f17018b FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: wallets fk_rails_732f6628c4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT fk_rails_732f6628c4 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: service_product_items fk_rails_74d0229327; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_product_items
    ADD CONSTRAINT fk_rails_74d0229327 FOREIGN KEY (service_product_id) REFERENCES public.service_products(id);


--
-- Name: wallet_transactions fk_rails_75f8c7a2b1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT fk_rails_75f8c7a2b1 FOREIGN KEY (fund_request_id) REFERENCES public.fund_requests(id);


--
-- Name: transactions fk_rails_77364e6416; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_rails_77364e6416 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: service_products fk_rails_785be14229; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.service_products
    ADD CONSTRAINT fk_rails_785be14229 FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: users fk_rails_7a9470eedc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_7a9470eedc FOREIGN KEY (scheme_id) REFERENCES public.schemes(id);


--
-- Name: fund_requests fk_rails_7b9fe539a7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fund_requests
    ADD CONSTRAINT fk_rails_7b9fe539a7 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: aeps_mini_statements fk_rails_824d8a8903; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeps_mini_statements
    ADD CONSTRAINT fk_rails_824d8a8903 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: transaction_commissions fk_rails_888daafe72; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_commissions
    ADD CONSTRAINT fk_rails_888daafe72 FOREIGN KEY (transaction_id) REFERENCES public.transactions(id);


--
-- Name: user_services fk_rails_8f67a55a7f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_services
    ADD CONSTRAINT fk_rails_8f67a55a7f FOREIGN KEY (assigner_id) REFERENCES public.users(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: leave_requests fk_rails_99d2b88b17; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_requests
    ADD CONSTRAINT fk_rails_99d2b88b17 FOREIGN KEY (parent_id) REFERENCES public.users(id);


--
-- Name: dmt_commission_slabs fk_rails_9d4e97da1c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmt_commission_slabs
    ADD CONSTRAINT fk_rails_9d4e97da1c FOREIGN KEY (dmt_commission_slab_range_id) REFERENCES public.dmt_commission_slab_ranges(id);


--
-- Name: dmts fk_rails_9ff71e1d5b; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmts
    ADD CONSTRAINT fk_rails_9ff71e1d5b FOREIGN KEY (vendor_user_id) REFERENCES public.vendor_users(id);


--
-- Name: commissions fk_rails_ab2512c4b8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commissions
    ADD CONSTRAINT fk_rails_ab2512c4b8 FOREIGN KEY (service_product_item_id) REFERENCES public.service_product_items(id);


--
-- Name: account_transactions fk_rails_acd948a9c0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_transactions
    ADD CONSTRAINT fk_rails_acd948a9c0 FOREIGN KEY (wallet_id) REFERENCES public.wallets(id);


--
-- Name: leave_requests fk_rails_ae3b26a732; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_requests
    ADD CONSTRAINT fk_rails_ae3b26a732 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: dmt_commission_slabs fk_rails_b3a8f82858; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmt_commission_slabs
    ADD CONSTRAINT fk_rails_b3a8f82858 FOREIGN KEY (scheme_id) REFERENCES public.schemes(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: transaction_commissions fk_rails_c4902f43b3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction_commissions
    ADD CONSTRAINT fk_rails_c4902f43b3 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: enquiries fk_rails_cd530b6036; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.enquiries
    ADD CONSTRAINT fk_rails_cd530b6036 FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: wallet_transactions fk_rails_d07bc24ce3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_transactions
    ADD CONSTRAINT fk_rails_d07bc24ce3 FOREIGN KEY (wallet_id) REFERENCES public.wallets(id);


--
-- Name: dmts fk_rails_d2c33b0ffc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmts
    ADD CONSTRAINT fk_rails_d2c33b0ffc FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: aeps_transactions fk_rails_d379408ac2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeps_transactions
    ADD CONSTRAINT fk_rails_d379408ac2 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: support_tickets fk_rails_d445c1f8e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT fk_rails_d445c1f8e8 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: categories fk_rails_db8b64c2f7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT fk_rails_db8b64c2f7 FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- Name: refund_requests fk_rails_e79f3cdfbe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refund_requests
    ADD CONSTRAINT fk_rails_e79f3cdfbe FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: aeps_commission_slab_ranges fk_rails_eba4f9cd15; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeps_commission_slab_ranges
    ADD CONSTRAINT fk_rails_eba4f9cd15 FOREIGN KEY (scheme_id) REFERENCES public.schemes(id);


--
-- Name: aeps_wallets fk_rails_ebf86777a4; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aeps_wallets
    ADD CONSTRAINT fk_rails_ebf86777a4 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: tasks fk_rails_ec34c29a53; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk_rails_ec34c29a53 FOREIGN KEY (lead_id) REFERENCES public.leads(id);


--
-- Name: wallet_histories fk_rails_f1a783a004; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallet_histories
    ADD CONSTRAINT fk_rails_f1a783a004 FOREIGN KEY (wallet_id) REFERENCES public.wallets(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict 0mdfHHzzCbpIpBoFBZsuDop0n6MQFnomzEn0PNHDKdZG3U6b15WI67qLzOqhrkd

