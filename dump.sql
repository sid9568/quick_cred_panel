--
-- PostgreSQL database dump
--

-- Dumped from database version 13.16 (Ubuntu 13.16-1.pgdg20.04+1)
-- Dumped by pg_dump version 13.16 (Ubuntu 13.16-1.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

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


ALTER TABLE public.account_transactions_id_seq OWNER TO postgres;

--
-- Name: account_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_transactions_id_seq OWNED BY public.account_transactions.id;


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


ALTER TABLE public.banks_id_seq OWNER TO postgres;

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


ALTER TABLE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


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
    set_for_role character varying
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


ALTER TABLE public.commissions_id_seq OWNER TO postgres;

--
-- Name: commissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commissions_id_seq OWNED BY public.commissions.id;


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


ALTER TABLE public.dmt_commission_slab_ranges_id_seq OWNER TO postgres;

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


ALTER TABLE public.dmt_commission_slabs_id_seq OWNER TO postgres;

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


ALTER TABLE public.dmt_commissions_id_seq OWNER TO postgres;

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
    updated_at timestamp(6) without time zone NOT NULL
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


ALTER TABLE public.dmt_transactions_id_seq OWNER TO postgres;

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
    bank_verify_status boolean DEFAULT false
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


ALTER TABLE public.dmts_id_seq OWNER TO postgres;

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


ALTER TABLE public.eko_banks_id_seq OWNER TO postgres;

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


ALTER TABLE public.enquiries_id_seq OWNER TO postgres;

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
    reject_note character varying
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


ALTER TABLE public.fund_requests_id_seq OWNER TO postgres;

--
-- Name: fund_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.fund_requests_id_seq OWNED BY public.fund_requests.id;


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


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


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


ALTER TABLE public.schemes_id_seq OWNER TO postgres;

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
    updated_at timestamp(6) without time zone NOT NULL
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


ALTER TABLE public.service_product_items_id_seq OWNER TO postgres;

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


ALTER TABLE public.service_products_id_seq OWNER TO postgres;

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


ALTER TABLE public.services_id_seq OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


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


ALTER TABLE public.transaction_commissions_id_seq OWNER TO postgres;

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
    vehicle_no character varying
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


ALTER TABLE public.transactions_id_seq OWNER TO postgres;

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


ALTER TABLE public.user_services_id_seq OWNER TO postgres;

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
    eko_biometric_kyc boolean DEFAULT false
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


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


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


ALTER TABLE public.wallet_transactions_id_seq OWNER TO postgres;

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


ALTER TABLE public.wallets_id_seq OWNER TO postgres;

--
-- Name: wallets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.wallets_id_seq OWNED BY public.wallets.id;


--
-- Name: account_transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_transactions ALTER COLUMN id SET DEFAULT nextval('public.account_transactions_id_seq'::regclass);


--
-- Name: banks id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banks ALTER COLUMN id SET DEFAULT nextval('public.banks_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: commissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commissions ALTER COLUMN id SET DEFAULT nextval('public.commissions_id_seq'::regclass);


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
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


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
-- Data for Name: commissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.commissions (id, commission_type, created_at, updated_at, service_product_item_id, scheme_id, value, to_role, from_role, set_by_role, set_for_role) FROM stdin;
90	\N	2025-11-26 09:44:50.390891	2025-11-26 09:44:50.390891	7	\N	\N	\N	\N	\N	\N
91	\N	2025-11-26 12:44:58.799506	2025-11-26 12:44:58.799506	8	\N	\N	\N	\N	\N	\N
92	\N	2025-11-26 13:03:40.633575	2025-11-26 13:03:40.633575	9	\N	\N	\N	\N	\N	\N
93	\N	2025-11-26 13:10:20.922998	2025-11-26 13:10:20.922998	10	\N	\N	\N	\N	\N	\N
94	\N	2025-11-26 13:12:56.641804	2025-11-26 13:12:56.641804	11	\N	\N	\N	\N	\N	\N
95	\N	2025-11-26 13:16:29.523254	2025-11-26 13:16:29.523254	12	\N	\N	\N	\N	\N	\N
96	\N	2025-11-26 13:19:07.645521	2025-11-26 13:19:07.645521	13	\N	\N	\N	\N	\N	\N
97	\N	2025-11-26 13:20:24.436412	2025-11-26 13:20:24.436412	14	\N	\N	\N	\N	\N	\N
98	\N	2025-11-26 13:21:53.27423	2025-11-26 13:21:53.27423	15	\N	\N	\N	\N	\N	\N
99	\N	2025-11-26 13:22:52.805874	2025-11-26 13:22:52.805874	16	\N	\N	\N	\N	\N	\N
100	\N	2025-11-26 13:23:46.957235	2025-11-26 13:23:46.957235	17	\N	\N	\N	\N	\N	\N
89	commission	2025-11-26 07:07:01.997006	2025-11-27 17:00:42.613604	5	36	9.0	admin	superadmin	\N	\N
102	commission	2025-11-27 17:29:55.301736	2025-11-27 17:29:55.301736	7	36	5.0	admin	superadmin	\N	\N
105	commission	2025-11-27 17:33:12.053139	2025-11-27 17:33:12.053139	1	36	1.0	retailer	superadmin	\N	\N
103	commission	2025-11-27 17:32:49.041567	2025-11-27 17:33:23.101409	1	40	7.0	admin	superadmin	\N	\N
88	commission	2025-11-26 06:49:30.249048	2025-11-27 17:42:47.275365	1	36	7.0	admin	superadmin	\N	\N
101	bbps	2025-11-27 17:21:03.137561	2025-11-27 17:50:57.580442	1	16	3.0	retailer	superadmin	\N	\N
104	commission	2025-11-27 17:32:49.058856	2025-11-27 17:54:45.521493	1	40	2.0	retailer	superadmin	\N	\N
106	\N	2025-11-28 09:41:07.340139	2025-11-28 09:41:07.340139	18	\N	\N	\N	\N	\N	\N
107	\N	2025-12-03 06:32:14.224375	2025-12-03 06:32:14.224375	19	\N	\N	\N	\N	\N	\N
108	\N	2025-12-03 08:56:33.210631	2025-12-03 08:56:33.210631	20	\N	\N	\N	\N	\N	\N
109	\N	2025-12-05 08:53:41.871371	2025-12-05 08:53:41.871371	21	\N	\N	\N	\N	\N	\N
111	\N	2025-12-05 10:34:04.495707	2025-12-05 10:34:04.495707	23	\N	\N	\N	\N	\N	\N
112	\N	2025-12-08 08:46:08.726435	2025-12-08 08:46:08.726435	24	\N	\N	\N	\N	\N	\N
113	\N	2025-12-08 10:05:23.92326	2025-12-08 10:05:23.92326	25	\N	\N	\N	\N	\N	\N
114	\N	2025-12-09 10:16:27.292657	2025-12-09 10:16:27.292657	26	\N	\N	\N	\N	\N	\N
115	commission	2025-12-26 07:06:40.574239	2025-12-26 07:06:40.56743	1	5	8.0	admin	superadmin	\N	\N
117	commission	2025-12-26 11:27:24.33306	2025-12-26 11:27:24.328198	1	20	2.0	master	admin	\N	\N
118	commission	2025-12-26 11:27:24.343888	2025-12-26 11:27:24.34035	1	20	3.0	dealer	admin	\N	\N
119	commission	2025-12-26 11:27:24.352303	2025-12-26 11:27:24.349103	1	20	2.0	retailer	admin	\N	\N
120	commission	2025-12-27 06:15:56.238841	2025-12-27 06:15:56.234318	28	5	8.0	admin	superadmin	\N	\N
121	commission	2025-12-27 07:00:43.372729	2025-12-27 07:00:43.365333	29	5	8.0	admin	superadmin	\N	\N
122	commission	2025-12-27 07:08:06.22171	2025-12-27 07:08:06.217151	30	5	8.0	admin	superadmin	\N	\N
116	commission	2025-12-26 07:07:55.597653	2025-12-27 08:42:11.45469	1	41	2.0	retailer	admin	\N	\N
123	commission	2025-12-27 08:43:51.95449	2025-12-27 08:43:51.949663	31	5	8.0	admin	superadmin	\N	\N
124	commission	2025-12-27 08:49:29.56312	2025-12-27 08:49:29.55521	1	21	3.0	retailer	admin	\N	\N
125	commission	2025-12-27 09:40:26.027332	2025-12-27 09:40:26.022458	32	5	8.0	admin	superadmin	\N	\N
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
\.


--
-- Data for Name: dmt_commissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dmt_commissions (id, dmt_id, user_id, role, commission_amount, service_product_item_id, created_at, updated_at) FROM stdin;
1	59	139	retailer	2.0000	\N	2025-12-26 12:47:43.624062	2025-12-26 12:47:43.624062
2	59	136	superadmin	10.0000	\N	2025-12-26 12:47:43.660282	2025-12-26 12:47:43.660282
\.


--
-- Data for Name: dmt_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dmt_transactions (id, dmt_id, user_id, status, txn_id, sender_mobile_number, bank_name, account_number, amount, parent_id, created_at, updated_at) FROM stdin;
1	1	127	success	TXN113F205E5643	6546456464	HDFC	888888888888888888	0.0	\N	2025-11-14 07:58:52.713944	2025-11-14 08:42:10.493849
2	2	127	success	TXN69A93DE5433D	6546456464	HDFC	888888888888888888	0.0	\N	2025-11-14 08:43:56.751506	2025-11-14 08:44:11.300888
3	3	127	pending	TXNA56FDE4F32F0	\N	Axis Bank	435345789798797	0.0	\N	2025-11-14 08:51:40.643231	2025-11-14 08:51:40.643231
4	4	127	pending	TXNFDF69AB5B2A1	6546456464	Axis Bank	435345789798797	0.0	\N	2025-11-14 09:21:13.167848	2025-11-14 09:21:13.167848
5	5	127	pending	TXN457F2FC95C8F	5675675676	Axis Bank	435345789798797	0.0	\N	2025-11-14 09:27:44.110021	2025-11-14 09:27:44.110021
6	6	127	pending	TXN63AE5C5C5BDC	\N	Axis Bank	1111111111	0.0	\N	2025-11-14 12:14:17.408636	2025-11-14 12:14:17.408636
7	7	127	success	TXNBFAF48733486	6666666677	Axis Bank	1111111111	0.0	\N	2025-11-14 12:15:21.191085	2025-11-14 12:15:44.779956
8	8	127	pending	TXN6711D3757165	9879879797	SBI	433333333333333334	0.0	\N	2025-11-22 06:32:21.565073	2025-11-22 06:32:21.565073
9	9	127	pending	TXN570874639E01	\N	Bob	1234567890	0.0	\N	2025-11-26 13:32:27.378181	2025-11-26 13:32:27.378181
10	10	127	success	TXN35FD1F2CC3D0	6546456464	Bob	1234567890	0.0	\N	2025-11-26 13:33:13.204622	2025-11-26 13:33:28.775841
11	11	139	pending	TXNA8FC896EEAEE	\N	sbi	886868886868868	0.0	\N	2025-12-16 07:13:05.234349	2025-12-16 07:13:05.234349
12	12	139	pending	TXNC70F1E901CBA	\N	Bandhan Bank	52200032996299	0.0	\N	2025-12-19 05:59:42.085815	2025-12-19 05:59:42.085815
13	14	104	pending	TXNFF779A2BAB18	\N	HDFC BANK	9999999999	5000.0	\N	2025-12-24 09:32:39.26687	2025-12-24 09:32:39.26687
14	15	104	pending	TXN16AF6B2501AF	\N	HDFC BANK	9999999999	100.0	\N	2025-12-24 09:39:23.272358	2025-12-24 09:39:23.272358
15	16	104	pending	TXN905AF86D8D97	\N	HDFC BANK	9999999999	100.0	\N	2025-12-24 10:36:10.324982	2025-12-24 10:36:10.324982
16	17	104	pending	TXN0E0CCD48DCFF	\N	HDFC BANK	9999999999	123.0	\N	2025-12-24 10:38:20.192736	2025-12-24 10:38:20.192736
17	18	104	pending	TXN99CEF5FE49F9	\N	HDFC BANK	9999999999	123.0	\N	2025-12-24 10:38:42.241276	2025-12-24 10:38:42.241276
18	19	104	pending	TXN0BC7E7D4F1A3	\N	HDFC BANK	9999999999	123.0	\N	2025-12-24 10:39:03.786241	2025-12-24 10:39:03.786241
19	20	104	pending	TXND262517995B4	\N	HDFC BANK	9999999999	123.0	\N	2025-12-24 10:39:25.171521	2025-12-24 10:39:25.171521
20	21	104	pending	TXN7E08EE5F3B27	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 10:42:05.075176	2025-12-24 10:42:05.075176
21	22	104	pending	TXN1E6C40AC9F5C	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 10:50:43.969501	2025-12-24 10:50:43.969501
22	23	104	pending	TXN1720134B692C	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:09:23.580388	2025-12-24 11:09:23.580388
23	24	104	pending	TXN94276DDCD718	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:26:35.676904	2025-12-24 11:26:35.676904
24	25	104	pending	TXN7AF6C130693A	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:27:37.895156	2025-12-24 11:27:37.895156
25	26	104	pending	TXN847FAB0DD59B	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:28:30.007575	2025-12-24 11:28:30.007575
26	27	104	pending	TXN70A5CCAF5E52	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:29:37.284937	2025-12-24 11:29:37.284937
27	28	104	pending	TXN25B30339B83B	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:30:21.586947	2025-12-24 11:30:21.586947
28	29	104	pending	TXN71456BE07026	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:32:49.666865	2025-12-24 11:32:49.666865
29	30	104	pending	TXND95F60E12697	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:33:46.928891	2025-12-24 11:33:46.928891
30	31	104	pending	TXNEA6FC4ABE07B	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:35:15.954343	2025-12-24 11:35:15.954343
31	32	104	pending	TXNE2A6246E88B3	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:38:07.802015	2025-12-24 11:38:07.802015
32	33	104	pending	TXNDD23A6B15812	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:39:55.019993	2025-12-24 11:39:55.019993
33	34	104	pending	TXN88982E970E9C	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:42:39.297314	2025-12-24 11:42:39.297314
34	35	104	pending	TXNFA4FDC87978D	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:44:39.326831	2025-12-24 11:44:39.326831
35	36	104	pending	TXN814A221D4313	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:46:08.30691	2025-12-24 11:46:08.30691
36	37	104	pending	TXN542D6A8A0965	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:49:45.479665	2025-12-24 11:49:45.479665
37	38	104	pending	TXN4682D64550BA	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 11:54:02.093703	2025-12-24 11:54:02.093703
38	39	104	pending	TXND1ED88A451BB	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 12:05:44.731779	2025-12-24 12:05:44.731779
39	40	104	pending	TXN365A2ECDEAA9	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 12:13:18.11363	2025-12-24 12:13:18.11363
40	41	104	pending	TXN4466414F080C	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 12:14:07.214043	2025-12-24 12:14:07.214043
41	42	104	pending	TXNC056B21A562F	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 12:15:55.968684	2025-12-24 12:15:55.968684
42	43	104	pending	TXND71E8F004B7D	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 12:18:45.248695	2025-12-24 12:18:45.248695
43	44	104	pending	TXNCC3E9841FCCD	\N	HDFC BANK	9999999999	118.0	\N	2025-12-24 12:28:15.501425	2025-12-24 12:28:15.501425
44	45	104	pending	TXNDC7B223B4638	\N	HDFC BANK	9999999999	104.0	\N	2025-12-24 13:34:24.978603	2025-12-24 13:34:24.978603
45	46	104	pending	TXNA8F30082D3D0	\N	HDFC BANK	9999999999	114.0	\N	2025-12-24 13:35:43.240304	2025-12-24 13:35:43.240304
46	47	104	pending	TXN99C67D8B850D	\N	HDFC BANK	9999999999	114.0	\N	2025-12-24 13:36:24.876457	2025-12-24 13:36:24.876457
47	48	104	pending	TXN9AE6C2AA7391	\N	HDFC BANK	9999999999	114.0	\N	2025-12-24 18:05:59.505581	2025-12-24 18:05:59.505581
48	49	104	pending	TXNFE23E0F35DA4	\N	HDFC BANK	9999999999	114.0	\N	2025-12-24 18:12:35.555104	2025-12-24 18:12:35.555104
51	52	104	pending	TXN6A48337F80EB	\N	HDFC BANK	9999999999	114.0	\N	2025-12-24 18:17:45.523841	2025-12-24 18:17:45.523841
52	53	104	pending	TXNB70B6491915D	\N	HDFC BANK	9999999999	114.0	\N	2025-12-24 18:26:46.411068	2025-12-24 18:26:46.411068
53	54	104	success	TXNE22C7A798C9D	\N	HDFC BANK	9999999999	114.0	\N	2025-12-24 18:33:48.464184	2025-12-24 18:54:07.403978
54	55	139	success	TXND35C9D32EDDC	\N	HDFC BANK	9999999999	100.0	\N	2025-12-24 18:59:00.286757	2025-12-24 18:59:46.98804
55	56	139	success	TXN0056B3AE0F24	\N	HDFC BANK	9999999999	100.0	\N	2025-12-24 19:19:45.365057	2025-12-24 19:29:00.653107
56	57	139	success	TXN18530AA4DA46	\N	HDFC BANK	9999999999	100.0	\N	2025-12-25 04:51:10.254033	2025-12-25 04:52:30.287816
57	58	139	pending	TXN0AC6C9994F86	\N	HDFC BANK	9999999999	100.0	\N	2025-12-26 12:29:22.931514	2025-12-26 12:29:22.931514
58	59	139	success	TXND16D52F85337	\N	HDFC BANK	9999999999	1001.0	\N	2025-12-26 12:47:00.658782	2025-12-26 12:47:43.594361
59	60	139	pending	TXNBF5DA076F764	\N	HDFC BANK	9999999999	1001.0	\N	2025-12-26 16:50:15.277761	2025-12-26 16:50:15.277761
\.


--
-- Data for Name: dmts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dmts (id, account_number, confirm_account_number, sender_mobile_number, receiver_name, receiver_mobile_number, sender_full_name, bank_name, ifsc_code, branch_name, amount, parent_id, user_id, beneficiaries_status, status, aadhaar_number_otp, aadhaar_number_otp_expiry, created_at, updated_at, customer_id, recipient_id, bank_verify_status) FROM stdin;
1	888888888888888888	888888888888888888	6546456464	Mohammad Aamir	9999999999	\N	HDFC	BARB0PANDEY	\N	500.0	104	\N	f	pending	\N	\N	2025-11-14 07:58:52.699257	2025-11-14 07:59:05.767403	\N	\N	f
2	888888888888888888	888888888888888888	6546456464	njhjhj	8979707098	\N	HDFC	BARB0PANDEY	\N	500.0	104	\N	f	pending	\N	\N	2025-11-14 08:43:56.740771	2025-11-14 08:44:02.88416	\N	\N	f
3	435345789798797	435345789798797	\N	Mohammad Aamir	9999999999	\N	Axis Bank	UTIB0001234	\N	\N	104	\N	t	pending	\N	\N	2025-11-14 08:51:40.635493	2025-11-14 08:51:40.635493	\N	\N	f
4	435345789798797	435345789798797	6546456464	Mohammad Aamir	9999999999	\N	Axis Bank	UTIB0001234	\N	500.0	104	\N	f	pending	\N	\N	2025-11-14 09:21:13.136517	2025-11-14 09:23:07.375588	\N	\N	f
5	435345789798797	435345789798797	5675675676	Mohammad Aamir	9999999999	\N	Axis Bank	UTIB0001234	\N	500.0	104	\N	f	pending	\N	\N	2025-11-14 09:27:44.080624	2025-11-14 09:27:49.858894	\N	\N	f
6	1111111111	1111111111	\N	Mohammad Aamir	8888888888	\N	Axis Bank	UTIB0001234	\N	\N	104	\N	t	pending	\N	\N	2025-11-14 12:14:17.377756	2025-11-14 12:14:17.377756	\N	\N	f
7	1111111111	1111111111	6666666677	Mohammad Aamir	8888888888	\N	Axis Bank	UTIB0001234	\N	500.0	104	\N	f	pending	\N	\N	2025-11-14 12:15:21.184784	2025-11-14 12:15:27.403668	\N	\N	f
8	433333333333333334	433333333333333334	9879879797	siddharth	9879879878	\N	SBI	UTIB0004491	\N	100.0	104	\N	f	pending	\N	\N	2025-11-22 06:32:21.521034	2025-11-22 06:32:44.213657	\N	\N	f
9	1234567890	1234567890	\N	aaa	7777777777	\N	Bob	UTIB0001234	\N	\N	104	\N	t	pending	\N	\N	2025-11-26 13:32:27.323937	2025-11-26 13:32:27.323937	\N	\N	f
10	1234567890	1234567890	6546456464	aaa	7777777777	\N	Bob	UTIB0001234	\N	500.0	104	\N	f	pending	\N	\N	2025-11-26 13:33:13.193668	2025-11-26 13:33:19.138902	\N	\N	f
11	886868886868868	886868886868868	\N	aamir	8181818181	\N	sbi	SBIN0023456	\N	\N	104	\N	t	pending	\N	\N	2025-12-16 07:13:05.181785	2025-12-16 07:13:05.181785	\N	\N	f
12	52200032996299	52200032996299	\N	SONAM GUPTA	6268075916	\N	Bandhan Bank	BDBL0001498	\N	\N	104	\N	t	recipient_added	\N	\N	2025-12-19 05:59:41.761604	2025-12-19 05:59:42.042517	\N	\N	f
13	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	5000.0	136	\N	f	pending	\N	\N	2025-12-24 09:32:05.005697	2025-12-24 09:32:05.005697	\N	\N	f
14	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	5000.0	136	\N	f	pending	\N	\N	2025-12-24 09:32:39.237286	2025-12-24 09:32:39.237286	\N	\N	f
15	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	100.0	136	\N	f	pending	\N	\N	2025-12-24 09:39:23.258417	2025-12-24 09:39:23.258417	\N	\N	f
16	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	100.0	136	\N	f	pending	\N	\N	2025-12-24 10:36:10.30045	2025-12-24 10:36:10.30045	\N	\N	f
17	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	100.0	136	\N	f	pending	\N	\N	2025-12-24 10:38:20.174428	2025-12-24 10:38:20.174428	\N	\N	f
18	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	100.0	136	\N	f	pending	\N	\N	2025-12-24 10:38:42.221644	2025-12-24 10:38:42.221644	\N	\N	f
19	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	100.0	136	\N	f	pending	\N	\N	2025-12-24 10:39:03.75083	2025-12-24 10:39:03.75083	\N	\N	f
20	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	100.0	136	\N	f	pending	\N	\N	2025-12-24 10:39:25.150411	2025-12-24 10:39:25.150411	\N	\N	f
21	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	100.0	136	\N	f	pending	\N	\N	2025-12-24 10:42:05.05475	2025-12-24 10:42:05.05475	\N	\N	f
22	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 10:50:43.949574	2025-12-24 10:50:43.949574	\N	\N	f
23	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:09:23.561014	2025-12-24 11:09:23.561014	\N	\N	f
24	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:26:35.654981	2025-12-24 11:26:35.654981	\N	\N	f
25	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:27:37.875115	2025-12-24 11:27:37.875115	\N	\N	f
26	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:28:29.978043	2025-12-24 11:28:29.978043	\N	\N	f
27	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:29:37.257193	2025-12-24 11:29:37.257193	\N	\N	f
28	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:30:21.576006	2025-12-24 11:30:21.576006	\N	\N	f
29	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:32:49.656064	2025-12-24 11:32:49.656064	\N	\N	f
30	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:33:46.918115	2025-12-24 11:33:46.918115	\N	\N	f
31	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:35:15.946487	2025-12-24 11:35:15.946487	\N	\N	f
32	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:38:07.781957	2025-12-24 11:38:07.781957	\N	\N	f
33	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:39:55.001422	2025-12-24 11:39:55.001422	\N	\N	f
34	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:42:39.27875	2025-12-24 11:42:39.27875	\N	\N	f
35	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:44:39.307075	2025-12-24 11:44:39.307075	\N	\N	f
36	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:46:08.287384	2025-12-24 11:46:08.287384	\N	\N	f
37	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:49:45.445002	2025-12-24 11:49:45.445002	\N	\N	f
38	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 11:54:02.048459	2025-12-24 11:54:02.048459	\N	\N	f
39	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 12:05:44.718444	2025-12-24 12:05:44.718444	\N	\N	f
40	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 12:13:18.081468	2025-12-24 12:13:18.081468	\N	\N	f
41	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 12:14:07.204475	2025-12-24 12:14:07.204475	\N	\N	f
42	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 12:15:55.95535	2025-12-24 12:15:55.95535	\N	\N	f
43	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 12:18:45.238437	2025-12-24 12:18:45.238437	\N	\N	f
44	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	118.0	136	\N	f	pending	\N	\N	2025-12-24 12:28:15.476688	2025-12-24 12:28:15.476688	\N	\N	f
45	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	104.0	136	\N	f	pending	\N	\N	2025-12-24 13:34:24.957961	2025-12-24 13:34:24.957961	\N	\N	f
46	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	114.0	136	\N	f	pending	\N	\N	2025-12-24 13:35:43.229431	2025-12-24 13:35:43.229431	\N	\N	f
47	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	114.0	136	\N	f	pending	\N	\N	2025-12-24 13:36:24.864124	2025-12-24 13:36:24.864124	\N	\N	f
48	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	114.0	136	\N	f	pending	\N	\N	2025-12-24 18:05:59.474001	2025-12-24 18:05:59.474001	\N	\N	f
49	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	114.0	136	\N	f	pending	\N	\N	2025-12-24 18:12:35.533859	2025-12-24 18:12:35.533859	\N	\N	f
52	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	114.0	136	\N	f	pending	\N	\N	2025-12-24 18:17:45.500469	2025-12-24 18:17:45.500469	\N	\N	f
53	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	114.0	136	\N	f	pending	\N	\N	2025-12-24 18:26:46.39481	2025-12-24 18:26:46.39481	\N	\N	f
54	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	114.0	136	\N	f	pending	\N	\N	2025-12-24 18:33:48.453674	2025-12-24 18:33:48.453674	\N	\N	f
55	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	100.0	104	\N	f	pending	\N	\N	2025-12-24 18:59:00.257493	2025-12-24 18:59:00.257493	\N	\N	f
56	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	114.0	104	\N	f	pending	\N	\N	2025-12-24 19:19:45.351641	2025-12-24 19:29:00.614443	\N	\N	f
57	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	114.0	104	\N	f	pending	\N	\N	2025-12-25 04:51:10.233111	2025-12-25 04:52:30.249599	\N	\N	f
58	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	100.0	104	\N	f	pending	\N	\N	2025-12-26 12:29:22.904098	2025-12-26 12:29:22.904098	\N	\N	f
59	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	1021.0	104	\N	f	pending	\N	\N	2025-12-26 12:47:00.605961	2025-12-26 12:47:43.52992	\N	\N	f
60	9999999999	9999999999	\N	Test name	87779879778	\N	HDFC BANK	HDFC0001234	\N	1001.0	104	\N	f	pending	\N	\N	2025-12-26 16:50:15.221296	2025-12-26 16:50:15.221296	\N	\N	f
61	3323232	32332	\N	\N	\N	\N	aaa	\N	\N	\N	104	139	\N	\N	\N	\N	2025-12-27 06:40:19.605709	2025-12-27 06:52:58.916544	\N	\N	t
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

COPY public.fund_requests (id, user_id, requested_by, amount, status, approved_by, approved_at, remark, image, transaction_type, mode, bank_reference_no, payment_mode, deposit_bank, your_bank, created_at, updated_at, account_number, reject_note) FROM stdin;
11	127	104	10.0	\N	\N	\N	test	\N	UPI	credit	879879ds787878	\N	Axis	HDFC	2025-09-06 10:53:22.238745	2025-09-06 10:53:22.238745	\N	\N
12	127	104	10.0	\N	\N	\N	test	\N	UPI	credit	879879ds787878	\N	Axis	HDFC	2025-09-06 10:58:12.306457	2025-09-06 10:58:12.306457	\N	\N
13	127	104	10.0	\N	\N	\N	test	\N	UPI	credit	879879ds787878	\N	Axis	HDFC	2025-09-06 10:58:36.043983	2025-09-06 10:58:36.043983	\N	\N
15	127	104	10.0	\N	\N	\N	bhej do bhai	null	CashInBank	credit	208987	\N	SBI	HDFC	2025-09-06 11:01:16.175689	2025-09-06 11:01:16.175689	\N	\N
16	127	104	20.0	\N	\N	\N	de do na	null	NEFT	credit	43543	\N	SBI	SBI	2025-09-06 11:08:17.288251	2025-09-06 11:08:17.288251	\N	\N
17	127	104	5.0	\N	\N	\N	dfgd	null	UPI	credit	454353435	\N	HDFC	ICICI	2025-09-06 11:10:11.793622	2025-09-06 11:10:11.793622	\N	\N
18	127	104	20.0	\N	\N	\N	de do mera paisa	null	Cheque	credit	86876876	\N	SBI	HDFC	2025-09-06 11:15:13.014605	2025-09-06 11:15:13.014605	\N	\N
19	127	104	40.0	\N	\N	\N		null	CashInBank	credit	45	\N	SBI	ICICI	2025-09-06 11:20:57.526698	2025-09-06 11:20:57.526698	\N	\N
20	127	104	400.0	\N	\N	\N		null	CashInBank	credit	86876876	\N	HDFC	HDFC	2025-09-06 11:22:08.43994	2025-09-06 11:22:08.43994	\N	\N
21	127	104	600.0	\N	\N	\N		null	Netbanking	credit	86876876	\N	SBI	SBI	2025-09-06 11:27:09.982909	2025-09-06 11:27:09.982909	\N	\N
22	127	104	1.0	\N	\N	\N		null	Cash	credit	2332	\N	HDFC	SBI	2025-09-06 11:32:10.205525	2025-09-06 11:32:10.205525	\N	\N
23	127	104	500.0	\N	\N	\N		null	Cheque	credit	897987	\N	HDFC	HDFC	2025-09-06 11:37:10.679613	2025-09-06 11:37:10.679613	\N	\N
24	127	104	500.0	\N	\N	\N		null	Cheque	credit	897987	\N	HDFC	HDFC	2025-09-06 11:37:53.467712	2025-09-06 11:37:53.467712	\N	\N
25	127	104	500.0	\N	\N	\N		null	Cheque	credit	897987	\N	HDFC	HDFC	2025-09-06 11:38:34.42233	2025-09-06 11:38:34.42233	\N	\N
26	127	104	200.0	\N	\N	\N		null	CashInBank	credit	87	\N	HDFC	AXIS	2025-09-06 11:39:25.212643	2025-09-06 11:39:25.212643	\N	\N
27	127	104	76.0	\N	\N	\N		null	NEFT	credit	769	\N	HDFC	ICICI	2025-09-06 11:57:13.457331	2025-09-06 11:57:13.457331	\N	\N
28	127	104	300.0	\N	\N	\N		null	CashInBank	credit	34534	\N	HDFC	HDFC	2025-09-06 12:03:54.839562	2025-09-06 12:03:54.839562	\N	\N
29	127	104	2.0	\N	\N	\N		null	Netbanking	credit	86876876	\N	HDFC	ICICI	2025-09-06 12:09:59.78103	2025-09-06 12:09:59.78103	\N	\N
30	127	104	1.0	\N	\N	\N		null	CashInBank	credit	86876876	\N	HDFC	SBI	2025-09-06 12:14:14.926249	2025-09-06 12:14:14.926249	\N	\N
32	127	104	31.0	\N	\N	\N	test	null	UPI	credit	ghhg566556	\N	HDFC	HDFC	2025-09-06 12:20:08.384143	2025-09-06 12:20:08.384143	\N	\N
33	127	104	35.0	\N	\N	\N		null	Cheque	credit	89698	\N	HDFC	SBI	2025-09-06 12:25:32.369262	2025-09-06 12:25:32.369262	\N	\N
34	127	104	70.0	\N	\N	\N		null	UPI	credit	233	\N	SBI	ICICI	2025-09-06 12:26:55.606828	2025-09-06 12:26:55.606828	\N	\N
35	127	104	7.0	\N	\N	\N		null	UPI	credit	233	\N	SBI	ICICI	2025-09-06 12:28:15.177185	2025-09-06 12:28:15.177185	\N	\N
39	127	104	93.0	\N	\N	\N		null	NEFT	credit	1	\N	SBI	SBI	2025-09-06 12:35:37.104368	2025-09-06 12:35:37.104368	\N	\N
40	127	104	400.0	\N	\N	\N		null	CashInBank	credit	86876876	\N	HDFC	PNB	2025-09-06 12:36:21.959471	2025-09-06 12:36:21.959471	\N	\N
43	127	104	100.0	\N	\N	\N		null	NEFT	credit	86876876	\N	SBI	HDFC	2025-09-06 12:52:53.423225	2025-09-06 12:52:53.423225	\N	\N
45	127	104	100.0	\N	\N	\N		null	Cheque	credit	86876876	\N	SBI	AXIS	2025-09-06 13:02:08.8759	2025-09-06 13:02:08.8759	\N	\N
46	127	104	1000.0	\N	\N	\N		null	CashInBank	credit	56757	\N	ICICI	AXIS	2025-09-08 04:47:39.042799	2025-09-08 04:47:39.042799	\N	\N
47	127	104	100.0	\N	\N	\N		null	IMPS	credit	4534	\N	SBI	SBI	2025-09-08 05:38:42.852321	2025-09-08 05:38:42.852321	\N	\N
48	139	\N	200.0	\N	\N	\N	malik	null	NEFT	credit	32444435	\N	SBI	HDFC	2025-09-08 05:43:00.558427	2025-09-08 05:43:00.558427	\N	\N
49	139	104	299.0	\N	\N	\N	malik	null	NEFT	credit	32444435	\N	SBI	HDFC	2025-09-08 05:44:50.488068	2025-09-08 05:44:50.488068	\N	\N
50	134	104	399.0	\N	\N	\N	test	null	NEFT	credit	100dsdddsds	\N	HDFC	ICICI	2025-09-08 06:37:14.65265	2025-09-08 06:37:14.65265	\N	\N
51	134	104	100.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	SBI	2025-09-08 07:28:52.968781	2025-09-08 07:28:52.968781	\N	\N
52	134	104	120.0	\N	\N	\N	test	null	NEFT	credit	100dsdddsds	\N	ICICI	HDFC	2025-09-08 07:45:11.344586	2025-09-08 07:45:11.344586	\N	\N
57	139	104	997.0	\N	\N	\N	malik	null	Netbanking	credit	32444435	\N	HDFC	SBI	2025-09-08 12:31:35.781488	2025-09-08 12:31:35.781488	\N	\N
58	139	104	500.0	\N	\N	\N	malik	null	Netbanking	credit	32444435	\N	SBI	SBI	2025-09-08 12:34:09.578595	2025-09-08 12:34:09.578595	\N	\N
60	127	104	100.0	\N	\N	\N		null	Cash	credit	564	\N	SBI	SBI	2025-09-10 13:31:42.342144	2025-09-10 13:31:42.342144	\N	\N
61	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 06:42:27.945305	2025-09-11 06:42:27.945305	\N	\N
62	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 07:38:16.938037	2025-09-11 07:38:16.938037	\N	\N
63	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 07:39:29.96736	2025-09-11 07:39:29.96736	\N	\N
64	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 07:40:27.444735	2025-09-11 07:40:27.444735	\N	\N
65	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 07:56:25.320924	2025-09-11 07:56:25.320924	\N	\N
66	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 08:38:21.030052	2025-09-11 08:38:21.030052	\N	\N
67	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 08:40:14.005162	2025-09-11 08:40:14.005162	\N	\N
69	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 08:45:56.258823	2025-09-11 08:45:56.258823	\N	\N
71	134	104	300.0	\N	\N	\N	test	null	UPI	credit	100dsdddsds	\N	SBI	HDFC	2025-09-11 09:16:37.343503	2025-09-11 09:16:37.343503	\N	\N
6	104	136	12.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	SBI	SBI	2025-09-06 09:24:59.568809	2025-09-12 12:43:28.294395	\N	\N
9	104	136	20.0	success	\N	\N	test	\N	UPI	credit	hjhjhdjs766868	\N	SBI	AXIS	2025-09-06 09:57:23.541551	2025-09-12 12:43:28.296918	\N	\N
73	127	104	10000.0	\N	\N	\N		null	UPI	credit	4565465465464564645	\N	SBI	SBI	2025-09-11 09:56:48.199583	2025-09-11 09:56:48.199583	\N	\N
74	139	104	10000.0	\N	\N	\N		null	UPI	credit	32444435	\N	HDFC	ICICI	2025-09-11 09:56:48.428133	2025-09-11 09:56:48.428133	\N	\N
75	127	104	1000.0	\N	\N	\N		null	Netbanking	credit	2	\N	HDFC	SBI	2025-09-11 09:59:40.800117	2025-09-11 09:59:40.800117	\N	\N
76	139	104	90000.0	\N	\N	\N		null	Cheque	credit	32444435	\N	SBI	ICICI	2025-09-11 11:04:05.638344	2025-09-11 11:04:05.638344	\N	\N
77	134	104	120.0	\N	\N	\N	test	null	UPI	credit	Upi79879897csd	\N	HDFC	ICICI	2025-09-11 12:55:29.635289	2025-09-11 12:55:29.635289	\N	\N
79	139	104	333.0	\N	\N	\N		null	Cash	credit	32444435	\N	HDFC	HDFC	2025-09-11 14:12:28.311338	2025-09-11 14:12:28.311338	\N	\N
90	139	104	44.0	\N	\N	\N		null	Cheque	credit	32444435	\N	HDFC	SBI	2025-09-12 10:56:50.797145	2025-09-12 10:56:50.797145	\N	\N
91	127	104	2000.0	\N	\N	\N		null	Netbanking	credit	d	\N	SBI	SBI	2025-09-12 10:58:46.382606	2025-09-12 10:58:46.382606	\N	\N
99	138	\N	100.0	pending	\N	\N		\N	IMPS	\N	87	\N	SBI	SBI	2025-09-12 12:06:33.52371	2025-09-12 12:06:33.52371	\N	\N
31	104	136	30.0	success	\N	\N	test	\N	NEFT	credit	hjkh978787879879	\N	SBI	HDFC	2025-09-06 12:19:01.760776	2025-09-12 12:43:28.299106	\N	\N
36	104	136	100.0	success	\N	\N	test	\N	UPI	credit	lkjdshd79887687	\N	SBI	SBI	2025-09-06 12:32:32.729136	2025-09-12 12:43:28.301199	\N	\N
37	104	136	100.0	success	\N	\N	test	\N	NEFT	credit	jjdsh7686887	\N	SBI	SBI	2025-09-06 12:34:04.571712	2025-09-12 12:43:28.303474	\N	\N
38	104	136	100.0	success	\N	\N	test	\N	UPI	credit	sdsdsds	\N	SBI	HDFC	2025-09-06 12:34:52.777219	2025-09-12 12:43:28.305685	\N	\N
41	104	136	1000.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	HDFC	HDFC	2025-09-06 12:36:50.754006	2025-09-12 12:43:28.308021	\N	\N
42	104	136	100.0	success	\N	\N	Test	\N	UPI	credit	jHJKJHH787987	\N	HDFC	PNB	2025-09-06 12:50:35.90369	2025-09-12 12:43:28.31011	\N	\N
44	104	136	100.0	success	\N	\N	test	\N	UPI	credit	UPI95687586867	\N	SBI	SBI	2025-09-06 12:59:23.04227	2025-09-12 12:43:28.312366	\N	\N
53	104	136	100.0	success	\N	\N	test	\N	NEFT	credit	33232332	\N	SBI	SBI	2025-09-08 07:53:10.183143	2025-09-12 12:43:28.314382	\N	\N
54	104	136	100.0	success	\N	\N	test	\N	NEFT	credit	hjkh978787879879	\N	ICICI	HDFC	2025-09-08 08:30:37.275921	2025-09-12 12:43:28.316729	\N	\N
55	104	136	100.0	success	\N	\N	test	\N	CashInBank	credit	hjkh9787878798792222	\N	ICICI	HDFC	2025-09-08 08:32:27.761322	2025-09-12 12:43:28.319255	\N	\N
56	104	136	100.0	success	\N	\N	test	\N	UPI	credit	hjkh9787878798792222	\N	ICICI	ICICI	2025-09-08 08:33:58.913333	2025-09-12 12:43:28.321487	\N	\N
59	104	136	1000.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	ICICI	ICICI	2025-09-08 13:22:27.727574	2025-09-12 12:43:28.323919	\N	\N
68	104	136	300000.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	SBI	SBI	2025-09-11 08:41:07.372091	2025-09-12 12:43:28.327345	\N	\N
70	104	136	1000.0	success	\N	\N	test	\N	UPI	credit	jjkjds89809	\N	SBI	HDFC	2025-09-11 09:16:03.652824	2025-09-12 12:43:28.33054	\N	\N
72	104	136	100.0	success	\N	\N	test	\N	UPI	credit	hjkh978787879879	\N	HDFC	AXIS	2025-09-11 09:46:31.307035	2025-09-12 12:43:28.333577	\N	\N
78	104	136	100.0	success	\N	\N	test	\N	UPI	credit	Appim77987n	\N	SBI	HDFC	2025-09-11 12:56:20.453078	2025-09-12 12:43:28.336067	\N	\N
80	104	136	1089.0	success	\N	\N	test	\N	UPI	credit	SSid89897676	\N	HDFC	HDFC	2025-09-11 14:13:40.673541	2025-09-12 12:43:28.338282	\N	\N
81	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	SBI	SBI	2025-09-12 10:33:14.196391	2025-09-12 12:43:28.340767	\N	\N
82	104	136	5.0	success	\N	\N	test	\N	NEFT	\N	hjkh978787879879	\N	HDFC	HDFC	2025-09-12 10:35:42.102839	2025-09-12 12:43:28.343657	\N	\N
83	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	HDFC	SBI	2025-09-12 10:36:44.718712	2025-09-12 12:43:28.346525	\N	\N
84	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	SBI	HDFC	2025-09-12 10:39:31.020996	2025-09-12 12:43:28.3496	\N	\N
85	104	136	1.0	success	\N	\N		\N	NEFT	\N	hjkh978787879879	\N	SBI	SBI	2025-09-12 10:42:38.385524	2025-09-12 12:43:28.352403	\N	\N
86	104	136	3.0	success	\N	\N		\N	IMPS	\N	hjkh978787879879	\N	SBI	HDFC	2025-09-12 10:45:43.800779	2025-09-12 12:43:28.355145	\N	\N
87	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	ICICI	AXIS	2025-09-12 10:48:09.017809	2025-09-12 12:43:28.357609	\N	\N
88	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	HDFC	ICICI	2025-09-12 10:49:33.146204	2025-09-12 12:43:28.360077	\N	\N
89	104	136	5.0	success	\N	\N	test	\N	CashInBank	\N	hjkh978787879879	\N	HDFC	SBI	2025-09-12 10:56:10.923195	2025-09-12 12:43:28.362274	\N	\N
92	104	136	9.0	success	\N	\N	test	\N	NEFT	\N	33232332	\N	SBI	HDFC	2025-09-12 11:04:17.82122	2025-09-12 12:43:28.364573	\N	\N
93	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	SBI	SBI	2025-09-12 11:07:46.064179	2025-09-12 12:43:28.36684	\N	\N
94	104	136	5.0	success	\N	\N	test	\N	NEFT	\N	hjkh978787879879	\N	HDFC	HDFC	2025-09-12 11:09:37.755661	2025-09-12 12:43:28.368906	\N	\N
95	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh9787878798792222	\N	HDFC	HDFC	2025-09-12 11:41:44.662777	2025-09-12 12:43:28.372248	\N	\N
96	104	136	5.0	success	\N	\N	test	\N	UPI	\N	ddd	\N	HDFC	HDFC	2025-09-12 11:44:37.158235	2025-09-12 12:43:28.374441	\N	\N
97	104	136	5.0	success	\N	\N	test	\N	UPI	\N	hjkh978787879879	\N	ICICI	HDFC	2025-09-12 11:46:17.530108	2025-09-12 12:43:28.376855	\N	\N
100	104	136	5.0	success	\N	\N		\N	NEFT	\N	hjkh978787879879	\N	HDFC	HDFC	2025-09-12 12:07:09.153851	2025-09-12 12:43:28.379102	\N	\N
101	138	136	100.0	success	\N	\N		\N	IMPS	\N	1	\N	SBI	SBI	2025-09-12 12:10:10.589275	2025-09-12 12:43:28.381597	\N	\N
102	141	136	85.0	success	\N	\N	...	\N	UPI	\N	8888	\N	HDFC	HDFC	2025-09-12 12:11:31.792498	2025-09-12 12:43:28.383783	\N	\N
103	141	136	90.0	success	\N	\N	mm	\N	Cash	\N	8888	\N	HDFC	AXIS	2025-09-12 12:41:03.003884	2025-09-12 12:43:28.385955	\N	\N
104	141	136	100.0	pending	\N	\N	malik	\N	Cash	\N	8888	\N	HDFC	AXIS	2025-09-12 12:47:36.187494	2025-09-12 12:47:36.187494	\N	\N
105	134	104	100.0	\N	\N	\N	test	null	NEFT	credit	Upi79879897csd	\N	SBI	HDFC	2025-09-15 17:29:52.85102	2025-09-15 17:29:52.85102	\N	\N
106	127	104	50000.0	\N	\N	\N	ret	null	UPI	credit	34534	\N	HDFC	HDFC	2025-09-18 07:03:50.157983	2025-09-18 07:03:50.157983	\N	\N
107	127	104	2000.0	\N	\N	\N	dfg	null	CashInBank	credit	345	\N	SBI	HDFC	2025-09-18 07:13:36.791823	2025-09-18 07:13:36.791823	\N	\N
108	104	136	5000.0	pending	\N	\N	Adding funds via IMPS	base64-image-or-file-url	IMPS	fund	REF123456789	\N	HDFC Bank	ICICI Bank	2025-11-17 05:38:37.381261	2025-11-17 05:38:37.381261	123456789012	\N
109	104	136	100.0	pending	\N	\N	dedo	\N	IMPS	fund	86876876	\N	Axis	SBI	2025-11-17 07:19:43.038443	2025-11-17 07:19:43.038443	779776876567576576	\N
110	104	136	100.0	success	\N	\N	dedo	\N	IMPS	fund	86876876	\N	Axis	SBI	2025-11-17 07:19:56.29324	2025-11-20 07:37:18.39239	779776876567576576	\N
111	139	104	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-20 08:49:59.696654	2025-11-20 08:49:59.696654	\N	\N
112	139	104	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-11-20 08:50:07.590631	2025-11-20 08:50:07.590631	\N	\N
118	139	104	1000.0	\N	\N	\N	\N	\N	credit	\N	REF123456	\N	HDFC Bank	ICICI Bank	2025-11-20 09:51:18.357788	2025-11-20 09:51:18.357788	\N	\N
123	104	136	100.0	pending	\N	\N	plz dedo	\N	IMPS	fund	43543	\N	Axis	SBI	2025-11-20 11:44:38.854776	2025-11-20 11:44:38.854776	779776876567576576	\N
124	104	136	100.0	pending	\N	\N	plz dedo	\N	IMPS	fund	43543	\N	Axis	SBI	2025-11-20 11:44:53.961234	2025-11-20 11:44:53.961234	779776876567576576	\N
125	104	136	100.0	pending	\N	\N	plz dedo	\N	IMPS	fund	43543	\N	Axis	SBI	2025-11-20 11:45:05.835729	2025-11-20 11:45:05.835729	779776876567576576	\N
126	104	136	100.0	pending	\N	\N	plz dedo	\N	IMPS	fund	43543	\N	Axis	SBI	2025-11-20 11:45:46.809058	2025-11-20 11:45:46.809058	779776876567576576	\N
127	104	136	100.0	pending	\N	\N	45	\N	Cash	fund	86876876	\N	Axis	AXIS	2025-11-20 11:46:12.493231	2025-11-20 11:46:12.493231	779776876567576576	\N
128	104	136	109.0	pending	\N	\N	dff	\N	CashInBank	fund	86876876	\N	Axis	HDFC	2025-11-20 11:46:44.51557	2025-11-20 11:46:44.51557	779776876567576576	\N
129	104	136	109.0	pending	\N	\N	dff	\N	CashInBank	fund	86876876	\N	Axis	HDFC	2025-11-20 11:46:59.106506	2025-11-20 11:46:59.106506	779776876567576576	\N
133	139	104	247.0	success	\N	\N	hiii	\N	imps	fund	44	\N	5	sbi	2025-11-20 12:21:24.360853	2025-11-21 06:03:14.357622	\N	\N
134	104	136	111.0	pending	\N	\N		\N	IMPS	fund	86876876	\N	Axis	HDFC	2025-11-21 06:14:49.192253	2025-11-21 06:14:49.192253	779776876567576576	\N
132	139	104	52.0	success	\N	\N	55555	\N	neft	fund	8755	\N	5	sbi	2025-11-20 12:15:14.534103	2025-11-21 06:22:46.010117	\N	\N
131	104	136	676.0	rejected	104	2025-11-21 06:26:15.923408	dds	\N	UPI	fund	86876876	\N	Axis	HDFC	2025-11-20 11:49:09.764333	2025-11-21 06:26:15.925519	779776876567576576	nikal
117	139	104	1000.0	rejected	104	2025-11-21 07:10:49.558027	\N	\N	credit	\N	REF123456	\N	HDFC Bank	ICICI Bank	2025-11-20 09:51:03.299687	2025-11-21 07:10:49.558578	\N	s
114	139	104	1000.0	rejected	104	2025-11-21 06:36:35.343481	\N	\N	credit	\N	BRN123456	\N	HDFC Bank	SBI Bank	2025-11-20 08:54:55.512819	2025-11-21 06:36:35.34421	\N	e
116	139	104	1000.0	success	\N	\N	\N	\N	credit	fund	BRN123456	\N	HDFC Bank	SBI Bank	2025-11-20 08:56:47.366876	2025-11-21 07:06:51.494837	\N	\N
119	139	104	1000.0	rejected	104	2025-11-21 07:48:54.236857	\N	\N	credit	fund	REF123456	\N	HDFC Bank	ICICI Bank	2025-11-20 09:51:33.993931	2025-11-21 07:48:54.237633	\N	j
113	139	104	1000.0	rejected	104	2025-11-21 07:11:20.126097	\N	\N	credit	\N	BRN123456	\N	HDFC Bank	SBI Bank	2025-11-20 08:52:47.779826	2025-11-21 07:11:20.126547	\N	1
130	104	136	109.0	rejected	104	2025-11-21 07:13:07.467433	dff	\N	CashInBank	fund	86876876	\N	Axis	HDFC	2025-11-20 11:47:16.677366	2025-11-21 07:13:07.468015	779776876567576576	1
120	139	104	2000.0	rejected	104	2025-11-21 07:43:13.742043	hi	\N	neft	\N	88888888	\N	5	sbi	2025-11-20 09:58:54.76747	2025-11-21 07:43:13.742505	\N	d
122	139	104	300.0	success	\N	\N	uuiqui	\N	imps	fund	777777	\N	5	sbi	2025-11-20 10:06:15.584176	2025-11-21 07:44:14.568894	\N	\N
121	139	104	2000.0	rejected	104	2025-11-21 07:52:06.342883	hi	\N	neft	fund	88888888	\N	5	sbi	2025-11-20 09:59:40.858795	2025-11-21 07:52:06.343383	\N	a
115	139	104	1000.0	success	\N	\N	\N	\N	credit	fund	BRN123456	\N	HDFC Bank	SBI Bank	2025-11-20 08:56:38.752089	2025-11-21 10:11:03.950216	\N	\N
98	139	104	85.0	rejected	104	2025-11-21 10:11:16.393192		null	Cash	credit	32444435	\N	SBI	ICICI	2025-09-12 12:05:31.001945	2025-11-21 10:11:16.393624	\N	w
135	127	104	32.0	\N	\N	\N	dedo	\N	neft	fund	8978789	\N	5	sbi	2025-11-21 10:33:38.478658	2025-11-21 10:33:38.478658	\N	\N
136	127	104	222.0	\N	\N	\N		\N	UPI	fund	87878798978	\N	HDFC Bank	SBI	2025-11-21 10:39:59.156349	2025-11-21 10:39:59.156349	\N	\N
137	104	136	567.0	\N	\N	\N	\N	https://res.cloudinary.com/siddtec/image/upload/v1763722135/pxtg7wby2xiivqglimlo.png	dsds	fund	343434	\N	dssd	fsdf	2025-11-21 10:48:56.071919	2025-11-21 10:48:56.071919	\N	\N
138	127	104	1212.0	\N	\N	\N	sda	\N	NEFT	fund	9878	\N	HDFC Bank	SBI	2025-11-21 10:55:30.179233	2025-11-21 10:55:30.179233	\N	\N
139	127	104	1212.0	\N	\N	\N	sda	\N	NEFT	fund	9878	\N	HDFC Bank	SBI	2025-11-21 10:55:37.737552	2025-11-21 10:55:37.737552	\N	\N
140	127	104	100.0	\N	\N	\N	fds	\N	NEFT	fund	2332	\N	HDFC Bank	ICICI	2025-11-21 11:07:27.084109	2025-11-21 11:07:27.084109	\N	\N
141	127	104	600.0	\N	\N	\N	aaa	\N	Netbanking	fund	34534	\N	HDFC Bank	HDFC	2025-11-21 11:26:25.050729	2025-11-21 11:26:25.050729	\N	\N
142	127	104	555.0	\N	\N	\N	ss	\N	NEFT	fund	8977	\N	5	HDFC	2025-11-21 11:31:49.22377	2025-11-21 11:31:49.22377	\N	\N
143	127	104	555.0	\N	\N	\N	ss	\N	NEFT	fund	8977	\N	5	HDFC	2025-11-21 11:32:04.79385	2025-11-21 11:32:04.79385	\N	\N
144	127	104	593.0	\N	\N	\N	ss	\N	IMPS	fund	43543	\N	HDFC Bank	SBI	2025-11-21 11:32:57.816084	2025-11-21 11:32:57.816084	\N	\N
146	127	104	66.0	rejected	104	2025-11-21 13:13:38.148636	77	https://res.cloudinary.com/siddtec/image/upload/v1763725387/qespzpmuder6vlxh3usm.png	IMPS	fund	43543	\N	HDFC Bank	SBI	2025-11-21 11:43:07.470339	2025-11-21 13:13:38.149545	\N	q
145	127	104	13.0	success	\N	\N	22	\N	IMPS	fund	22	\N	HDFC Bank	SBI	2025-11-21 11:35:59.897118	2025-11-21 13:14:35.937	\N	\N
148	169	104	18.0	pending	\N	\N	bhbhm	\N	CashInBank	fund	88	\N	HDFC Bank	HDFC	2025-11-25 11:15:07.669155	2025-11-25 11:15:07.669155	123456789012	\N
149	169	104	103.0	pending	\N	\N	56756	\N	UPI	fund	56676767	\N	HDFC Bank	ICICI	2025-11-26 07:08:01.413502	2025-11-26 07:08:01.413502	123456789012	\N
147	170	169	58.0	rejected	169	2025-11-26 10:14:08.352595	hhhhh	https://res.cloudinary.com/siddtec/image/upload/v1764068960/ezveg3800tnsga1wuscg.jpg	NEFT	fund	78678	\N	State Bank of India	HDFC	2025-11-25 11:09:21.313239	2025-11-26 10:14:08.353231	\N	fake
150	170	169	29.0	\N	\N	\N	sjeioeu	https://res.cloudinary.com/siddtec/image/upload/v1764152413/wynbz1bxqsak8lqeibnj.jpg	Cash	fund	5894375983	\N	State Bank of India	HDFC	2025-11-26 10:20:14.101307	2025-11-26 10:20:14.101307	\N	\N
151	169	104	19.0	pending	\N	\N	njk	\N	UPI	fund	u8989080	\N	HDFC Bank	SBI	2025-11-26 10:24:03.645654	2025-11-26 10:24:03.645654	123456789012	\N
152	170	169	20.0	pending	\N	\N	t876t788	https://res.cloudinary.com/siddtec/image/upload/v1764152735/y2lawtrg88qyccbtwffy.jpg	Netbanking	fund	gfhg	\N	State Bank of India	HDFC	2025-11-26 10:25:37.299687	2025-11-26 10:25:37.299687	\N	\N
153	104	136	11.0	pending	\N	\N	saad	\N	IMPS	fund	96789	\N	Axis	HDFC	2025-11-26 10:31:41.816082	2025-11-26 10:31:41.816082	779776876567576576	\N
154	170	169	19.0	pending	\N	\N	sndfjsdk	https://res.cloudinary.com/siddtec/image/upload/v1764154101/zrvkg0h9wwhfebnlesis.jpg	CashInBank	fund	389748932	\N	State Bank of India	ICICI	2025-11-26 10:48:22.348371	2025-11-26 10:48:22.348371	\N	\N
155	170	169	101.0	pending	\N	\N	ghvhj	https://res.cloudinary.com/siddtec/image/upload/v1764156790/ogmdy2xpkaakgdla8n2r.jpg	IMPS	fund	57656567	\N	kotak mahindra	HDFC	2025-11-26 11:33:10.869349	2025-11-26 11:33:10.869349	\N	\N
156	169	104	620.0	pending	\N	\N	fkjerbj	\N	Netbanking	fund	4757894375834	\N	HDFC Bank	AXIS	2025-11-26 12:28:29.608622	2025-11-26 12:28:29.608622	123456789012	\N
157	174	169	200.0	pending	\N	\N	hwdjke	https://res.cloudinary.com/siddtec/image/upload/v1764161085/rconjnskn3olodcuxf8b.jpg	Cheque	fund	6234823949	\N	kotak mahindra	HDFC	2025-11-26 12:44:46.968637	2025-11-26 12:44:46.968637	\N	\N
158	174	169	5000.0	pending	\N	\N	jhewjk	https://res.cloudinary.com/siddtec/image/upload/v1764161147/n5kczlnfqnuoohzuwymp.jpg	Netbanking	fund	623493264	\N	kotak mahindra	ICICI	2025-11-26 12:45:48.064614	2025-11-26 12:45:48.064614	\N	\N
160	169	104	100.0	success	\N	\N	7ghj	\N	Netbanking	fund	y7y7y	\N	HDFC Bank	SBI	2025-11-26 12:58:34.614409	2025-11-26 12:58:51.313893	123456789012	\N
159	174	169	99.0	success	\N	\N	jjnnjk	https://res.cloudinary.com/siddtec/image/upload/v1764161707/xpm4jruc8x05euhaps1o.jpg	UPI	fund	555	\N	State Bank of India	HDFC	2025-11-26 12:55:08.616837	2025-11-26 12:59:12.522881	\N	\N
161	175	169	19.0	pending	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1764229080/qhwfs33jrmzrejgepu1i.jpg	Netbanking	fund	6778678	\N	kotak mahindra	SBI	2025-11-27 07:38:00.991865	2025-11-27 07:38:00.991865	\N	\N
162	175	169	1.0	success	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1764229155/h2rudfdqxamefahsp0uk.jpg	Cash	fund	87778789	\N	ds fb sd	SBI	2025-11-27 07:39:16.199122	2025-11-27 07:39:32.909226	\N	\N
163	169	104	10000.0	success	\N	\N	fyffhg	\N	NEFT	fund	ctgfgfg	\N	HDFC Bank	SBI	2025-11-27 08:47:38.427454	2025-11-27 08:50:02.428031	123456789012	\N
164	176	104	11.0	success	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1765447200/brriw8oc9hwpwn77tvps.jpg	NEFT	fund	4324343454345	\N	HDFC Bank	SBI	2025-12-11 10:00:01.523561	2025-12-11 10:00:43.129608	\N	\N
165	176	104	100.0	success	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1765455139/iuwdl4jhx6diuu6bunn3.jpg	Netbanking	fund	6666666666666788	\N	HDFC Bank	SBI	2025-12-11 12:12:19.780305	2025-12-11 12:12:37.4171	\N	\N
166	177	104	10.0	success	\N	\N	hjhjj	https://res.cloudinary.com/siddtec/image/upload/v1765540418/jmxhlvmrgcosn7jw9vba.jpg	NEFT	fund	5425625245245245425	\N	HDFC Bank	HDFC	2025-12-12 11:53:39.839689	2025-12-12 11:54:13.17972	\N	\N
167	127	104	120.0	pending	\N	\N	test	\N	NEFT	fund	100dsdddsds	\N	HDFC Bank	SBI	2025-12-13 09:07:49.176117	2025-12-13 09:07:49.176117	\N	\N
168	104	136	10.0	pending	\N	\N		\N	Cheque	fund	4324343454345	\N	Axis	HDFC	2025-12-16 05:26:55.742194	2025-12-16 05:26:55.742194	779776876567576576	\N
169	104	136	3.0	pending	\N	\N		\N	Netbanking	fund	6666666666666788	\N	Axis	HDFC	2025-12-16 06:11:54.448787	2025-12-16 06:11:54.448787	779776876567576576	\N
170	104	136	5.0	pending	\N	\N		\N	Netbanking	fund	4324343454345	\N	Axis	HDFC	2025-12-16 06:21:26.851039	2025-12-16 06:21:26.851039	779776876567576576	\N
171	104	136	6.0	pending	\N	\N		\N	NEFT	fund	4324343454345	\N	Axis	HDFC	2025-12-16 06:22:08.041546	2025-12-16 06:22:08.041546	779776876567576576	\N
172	104	136	2.0	pending	\N	\N		\N	UPI	fund	4324343454345	\N	Axis	HDFC	2025-12-16 06:23:33.91004	2025-12-16 06:23:33.91004	779776876567576576	\N
173	104	136	8.0	pending	\N	\N		\N	CashInBank	fund	4324343454345	\N	Axis	SBI	2025-12-16 06:28:03.135171	2025-12-16 06:28:03.135171	779776876567576576	\N
174	139	104	2.0	pending	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1765867511/bkijkiftkxdbvyp2fz5q.png	UPI	fund	436432648732647	\N	HDFC Bank	ICICI	2025-12-16 06:45:12.388451	2025-12-16 06:45:12.388451	\N	\N
175	139	104	4.0	pending	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1765868286/yuwoo8v68uumv33asgc3.png	NEFT	fund	3243454345546546	\N	HDFC Bank	ICICI	2025-12-16 06:58:07.455297	2025-12-16 06:58:07.455297	\N	\N
176	139	104	2.0	pending	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1765868443/vpfjrxpto08tr6q3rwp7.png	UPI	fund	454586954685	\N	HDFC Bank	HDFC	2025-12-16 07:00:44.04457	2025-12-16 07:00:44.04457	\N	\N
177	104	136	3.0	pending	\N	\N		\N	CashInBank	fund	4324343454345	\N	Axis	HDFC	2025-12-17 12:53:35.467604	2025-12-17 12:53:35.467604	779776876567576576	\N
178	178	103	200.0	pending	\N	\N	nfmgnf	https://res.cloudinary.com/siddtec/image/upload/v1766051979/e1cosm613ikfvr3jreza.png	UPI	fund	34723947237	\N	state bank of india	HDFC	2025-12-18 09:59:40.43253	2025-12-18 09:59:40.43253	\N	\N
179	103	\N	700.0	pending	\N	\N		\N	Netbanking	fund	4324343454345	\N	Axis	ICICI	2025-12-18 10:01:39.796022	2025-12-18 10:01:39.796022	779776876567576576	\N
180	127	104	10.0	pending	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1766134682/kwrsypibpgkykxxxdc1y.png	CashInBank	fund	7656756	\N	HDFC Bank	SBI	2025-12-19 08:58:03.066599	2025-12-19 08:58:03.066599	\N	\N
181	127	104	20.0	pending	\N	\N	\N	https://res.cloudinary.com/siddtec/image/upload/v1766139921/cfcel8lrq8dgodcbif32.png	NEFT	fund	857485743	\N	HDFC Bank	SBI	2025-12-19 10:25:21.544126	2025-12-19 10:25:21.544126	\N	\N
182	127	104	20.0	pending	\N	\N	\N	https://res.cloudinary.com/siddtec/image/upload/v1766139930/vg0tpzst3gnp03jj2nl4.png	NEFT	fund	857485743	\N	HDFC Bank	SBI	2025-12-19 10:25:31.37215	2025-12-19 10:25:31.37215	\N	\N
183	127	104	20.0	pending	\N	\N	\N	https://res.cloudinary.com/siddtec/image/upload/v1766139943/ujyjyvdtukd1ufrrd9yz.png	NEFT	fund	857485743	\N	HDFC Bank	SBI	2025-12-19 10:25:44.174838	2025-12-19 10:25:44.174838	\N	\N
184	127	104	12.0	pending	\N	\N	\N	https://res.cloudinary.com/siddtec/image/upload/v1766140060/yc3pok9fwvexhczrlxc0.png	NEFT	fund	58437583457	\N	HDFC Bank	SBI	2025-12-19 10:27:40.812298	2025-12-19 10:27:40.812298	\N	\N
185	127	104	12.0	pending	\N	\N	\N	https://res.cloudinary.com/siddtec/image/upload/v1766140070/jjywrggmztovxuqjxyrd.png	NEFT	fund	58437583457	\N	HDFC Bank	SBI	2025-12-19 10:27:51.657635	2025-12-19 10:27:51.657635	\N	\N
186	127	104	7.0	pending	\N	\N	\N	https://res.cloudinary.com/siddtec/image/upload/v1766140173/sk8spnqpqfv9fzftdytm.png	NEFT	fund	786786	\N	HDFC Bank	AXIS	2025-12-19 10:29:34.274748	2025-12-19 10:29:34.274748	\N	\N
187	127	104	9.0	pending	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1766140225/asjqlgt017kbrrbpgikp.png	UPI	fund	9843243276439	\N	HDFC Bank	HDFC	2025-12-19 10:30:26.011638	2025-12-19 10:30:26.011638	\N	\N
188	127	104	19.0	pending	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1766140641/lotop1o6z7buqljx1f3s.png	Cash	fund	7867689	\N	HDFC Bank	ICICI	2025-12-19 10:37:22.155918	2025-12-19 10:37:22.155918	\N	\N
189	127	104	45.0	pending	\N	\N	yyuiyu	https://res.cloudinary.com/siddtec/image/upload/v1766141558/uzhf3mqnccofj3tfxxqt.png	Netbanking	fund	8767678978	\N	HDFC Bank	SBI	2025-12-19 10:52:38.616691	2025-12-19 10:52:38.616691	\N	\N
190	127	104	10.0	pending	\N	\N	erggf	https://res.cloudinary.com/siddtec/image/upload/v1766143497/rp3stlpc5akpemkmwsss.png	Netbanking	fund	t54657y	\N	HDFC Bank	ICICI	2025-12-19 11:24:58.580833	2025-12-19 11:24:58.580833	\N	\N
191	127	104	10.0	pending	\N	\N	erggf	https://res.cloudinary.com/siddtec/image/upload/v1766143541/za3dt59zcbzgxxoqii5q.png	Netbanking	fund	t54657y	\N	HDFC Bank	ICICI	2025-12-19 11:25:42.312284	2025-12-19 11:25:42.312284	\N	\N
192	127	104	8.0	pending	\N	\N	4t32yewgr	https://res.cloudinary.com/siddtec/image/upload/v1766143661/bj1ggihpg8jvjedsmiyw.png	Netbanking	fund	2374632974	\N	HDFC Bank	AXIS	2025-12-19 11:27:42.290114	2025-12-19 11:27:42.290114	\N	\N
193	127	104	8.0	pending	\N	\N	4t32yewgr	https://res.cloudinary.com/siddtec/image/upload/v1766143747/vqeb5vl6cunbqmuaz4tt.png	Netbanking	fund	2374632974	\N	HDFC Bank	AXIS	2025-12-19 11:29:07.733416	2025-12-19 11:29:07.733416	\N	\N
194	127	104	99.0	pending	\N	\N	jhhjbh	\N	Netbanking	fund	76567565	\N	HDFC Bank	AXIS	2025-12-19 13:03:30.355383	2025-12-19 13:03:30.355383	\N	\N
195	127	104	21.0	pending	\N	\N		https://res.cloudinary.com/siddtec/image/upload/v1766149449/cg6hbqlr8erqttc0werd.png	NEFT	fund	767867867678	\N	HDFC Bank	ICICI	2025-12-19 13:04:09.747293	2025-12-19 13:04:09.747293	\N	\N
196	104	136	101.0	pending	\N	\N		\N	Cash	fund	4324343776556	\N	Axis	ICICI	2025-12-24 05:08:45.755301	2025-12-24 05:08:45.755301	779776876567576576	\N
197	104	136	11.0	pending	\N	\N		\N	UPI	fund	5425625245245245425	\N	Axis	HDFC	2025-12-24 05:10:55.139346	2025-12-24 05:10:55.139346	779776876567576576	\N
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
40	Gold	Percentage	12.0	2025-11-27 17:32:24.922382	2025-11-27 17:32:24.922382	136
30	platinum	Flat	10.0	2025-11-17 12:06:56.424561	2025-12-11 09:02:04.670505	104
21	Gold	Flat	10.0	2025-11-15 19:36:03.77389	2025-12-11 09:02:16.792496	104
42	mani	Percentage	\N	2025-12-25 06:29:23.174007	2025-12-25 06:29:23.174007	104
41	gold 	Flat	10.0	2025-12-12 09:16:22.886437	2025-12-27 10:17:34.969999	104
\.


--
-- Data for Name: service_product_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.service_product_items (id, service_product_id, name, oprator_type, status, created_at, updated_at) FROM stdin;
1	11	Airtel Prepaid	Prepaid	\N	2025-09-15 18:11:48.643332	2025-11-26 05:54:47.176685
5	11	Jio Prepaid	\N	\N	2025-11-18 06:58:54.901953	2025-11-26 05:54:58.514652
7	11	Vi Postpaid	\N	\N	2025-11-26 09:44:50.368077	2025-11-26 09:44:50.368077
8	13	Tata Sky	\N	\N	2025-11-26 12:44:58.768256	2025-11-26 12:44:58.768256
9	12	Airtel	\N	\N	2025-11-26 13:03:40.614801	2025-11-26 13:03:40.614801
10	13	Hathway Digital	\N	\N	2025-11-26 13:10:20.916214	2025-11-26 13:10:20.916214
11	14	Home Loan	\N	\N	2025-11-26 13:12:56.632751	2025-11-26 13:12:56.632751
12	15	HDFC	\N	\N	2025-11-26 13:16:29.515508	2025-11-26 13:16:39.710467
13	17	card	\N	\N	2025-11-26 13:19:07.639157	2025-11-26 13:19:07.639157
14	18	XYZ	\N	\N	2025-11-26 13:20:24.423949	2025-11-26 13:20:24.423949
15	6	N/A	\N	\N	2025-11-26 13:21:53.265813	2025-11-26 13:21:53.265813
16	8	BSES	\N	\N	2025-11-26 13:22:52.799674	2025-11-26 13:22:52.799674
17	10	Bharat Gas	\N	\N	2025-11-26 13:23:46.948817	2025-11-26 13:23:46.948817
18	8	North Bihar Power	\N	\N	2025-11-28 09:41:07.303263	2025-11-28 09:41:07.303263
19	13	Tata Sky	\N	\N	2025-12-03 06:32:14.213067	2025-12-03 06:32:14.213067
20	13	Dish TV	\N	\N	2025-12-03 08:56:33.203225	2025-12-03 08:56:33.203225
21	6	Gwalior Municipal Corporation - Water	\N	\N	2025-12-05 08:53:41.844398	2025-12-05 08:53:41.844398
23	6	Delhi Jal Board	\N	\N	2025-12-05 10:34:04.48944	2025-12-05 10:34:04.48944
24	15	Paul Merchants	\N	\N	2025-12-08 08:46:08.71416	2025-12-08 08:46:08.71416
25	15	IDBI Bank Fastag	\N	\N	2025-12-08 10:05:23.916986	2025-12-08 10:05:23.916986
26	17	Axis Bank Credit Card	\N	\N	2025-12-09 10:16:27.251259	2025-12-09 10:16:27.251259
27	6	Uttarakhand Jal Sansthan	\N	\N	2025-12-17 11:25:25.704467	2025-12-17 11:25:25.704467
28	10	Indraprastha Gas	\N	\N	2025-12-27 06:15:56.223335	2025-12-27 06:15:56.223335
29	13	BIG TV DTH	\N	\N	2025-12-27 07:00:43.345024	2025-12-27 07:00:43.345024
30	13	Airtel DTH	\N	\N	2025-12-27 07:08:06.206662	2025-12-27 07:08:06.206662
31	14	Kotak Mahindra Bank Ltd.-Loans	\N	\N	2025-12-27 08:43:51.936937	2025-12-27 08:43:51.936937
32	12	Connect Broadband	\N	\N	2025-12-27 09:40:26.012089	2025-12-27 09:40:26.012089
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
199	348	104	0	6.0	2025-09-19 10:56:34.432637	2025-09-19 10:56:34.432637	1
200	348	136	0	4.0	2025-09-19 10:56:34.457974	2025-09-19 10:56:34.457974	1
202	349	104	0	6.0	2025-09-19 11:07:44.423616	2025-09-19 11:07:44.423616	1
203	349	136	0	4.0	2025-09-19 11:07:44.456632	2025-09-19 11:07:44.456632	1
205	350	104	0	6.0	2025-09-19 11:08:08.974241	2025-09-19 11:08:08.974241	1
206	350	136	0	4.0	2025-09-19 11:08:09.015665	2025-09-19 11:08:09.015665	1
208	351	104	0	6.0	2025-09-19 11:12:30.701089	2025-09-19 11:12:30.701089	1
209	351	136	0	4.0	2025-09-19 11:12:30.726126	2025-09-19 11:12:30.726126	1
211	352	104	0	6.0	2025-09-19 11:49:50.227056	2025-09-19 11:49:50.227056	1
212	352	136	0	4.0	2025-09-19 11:49:50.247777	2025-09-19 11:49:50.247777	1
213	352	127	0	0.0	2025-09-19 11:49:50.26609	2025-09-19 11:49:50.26609	1
214	353	104	0	11.96999999999999	2025-09-19 11:50:50.78489	2025-09-19 11:50:50.78489	1
215	353	136	0	7.98	2025-09-19 11:50:50.810948	2025-09-19 11:50:50.810948	1
216	353	127	0	19.95	2025-09-19 11:50:50.82812	2025-09-19 11:50:50.82812	1
217	354	104	0	0.0	2025-09-19 12:06:30.411115	2025-09-19 12:06:30.411115	1
218	354	136	0	10.0	2025-09-19 12:06:30.455102	2025-09-19 12:06:30.455102	1
219	354	134	0	0.0	2025-09-19 12:06:30.485716	2025-09-19 12:06:30.485716	1
220	355	104	0	6.0	2025-09-19 12:23:12.01258	2025-09-19 12:23:12.01258	1
221	355	136	0	4.0	2025-09-19 12:23:12.034006	2025-09-19 12:23:12.034006	1
222	355	127	0	10.0	2025-09-19 12:23:12.050474	2025-09-19 12:23:12.050474	1
223	356	104	0	5.97	2025-09-19 14:06:31.489469	2025-09-19 14:06:31.489469	1
224	356	136	0	3.98	2025-09-19 14:06:31.509015	2025-09-19 14:06:31.509015	1
226	357	104	0	0.3299999999999999	2025-10-06 09:41:41.412989	2025-10-06 09:41:41.412989	1
227	357	136	0	0.22	2025-10-06 09:41:41.436232	2025-10-06 09:41:41.436232	1
228	357	127	0	0.55	2025-10-06 09:41:41.458301	2025-10-06 09:41:41.458301	1
229	358	104	0	0.6599999999999999	2025-10-06 10:39:35.495337	2025-10-06 10:39:35.495337	1
230	358	136	0	0.44	2025-10-06 10:39:35.514943	2025-10-06 10:39:35.514943	1
231	358	127	0	1.1	2025-10-06 10:39:35.530434	2025-10-06 10:39:35.530434	1
232	359	104	0	0.6599999999999999	2025-10-06 10:40:08.951702	2025-10-06 10:40:08.951702	1
233	359	136	0	0.44	2025-10-06 10:40:08.977559	2025-10-06 10:40:08.977559	1
234	359	127	0	1.1	2025-10-06 10:40:08.995906	2025-10-06 10:40:08.995906	1
235	360	104	0	0.0	2025-10-06 10:43:31.627151	2025-10-06 10:43:31.627151	1
236	360	136	0	7.7	2025-10-06 10:43:31.646974	2025-10-06 10:43:31.646974	1
237	360	127	0	0.0	2025-10-06 10:43:31.663978	2025-10-06 10:43:31.663978	1
238	361	104	0	3.03	2025-10-06 10:49:28.573429	2025-10-06 10:49:28.573429	1
239	361	136	0	2.02	2025-10-06 10:49:28.599744	2025-10-06 10:49:28.599744	1
240	361	127	0	5.050000000000001	2025-10-06 10:49:28.620526	2025-10-06 10:49:28.620526	1
241	362	104	0	0.0	2025-10-06 10:53:49.262017	2025-10-06 10:53:49.262017	1
242	362	136	0	3.3	2025-10-06 10:53:49.283632	2025-10-06 10:53:49.283632	1
243	362	127	0	0.0	2025-10-06 10:53:49.303952	2025-10-06 10:53:49.303952	1
244	363	104	0	2.219999999999999	2025-10-06 10:56:21.450794	2025-10-06 10:56:21.450794	1
245	363	136	0	1.48	2025-10-06 10:56:21.472316	2025-10-06 10:56:21.472316	1
246	363	127	0	3.7	2025-10-06 10:56:21.485641	2025-10-06 10:56:21.485641	1
247	364	104	0	0.57	2025-10-06 10:57:28.908373	2025-10-06 10:57:28.908373	1
248	364	136	0	0.38	2025-10-06 10:57:28.927363	2025-10-06 10:57:28.927363	1
249	364	127	0	0.9500000000000001	2025-10-06 10:57:28.940173	2025-10-06 10:57:28.940173	1
250	365	104	0	0.0	2025-10-06 11:02:43.944416	2025-10-06 11:02:43.944416	1
251	365	136	0	0.1	2025-10-06 11:02:43.962693	2025-10-06 11:02:43.962693	1
252	365	127	0	0.0	2025-10-06 11:02:43.976101	2025-10-06 11:02:43.976101	1
253	366	104	0	2.31	2025-10-06 11:09:27.466283	2025-10-06 11:09:27.466283	1
254	366	136	0	1.54	2025-10-06 11:09:27.491726	2025-10-06 11:09:27.491726	1
255	366	127	0	3.85	2025-10-06 11:09:27.512457	2025-10-06 11:09:27.512457	1
256	367	104	0	0.0	2025-10-06 12:06:40.09109	2025-10-06 12:06:40.09109	1
257	367	136	0	7.4	2025-10-06 12:06:40.111983	2025-10-06 12:06:40.111983	1
258	367	127	0	0.0	2025-10-06 12:06:40.124367	2025-10-06 12:06:40.124367	1
259	368	104	0	1.92	2025-10-06 12:27:25.466557	2025-10-06 12:27:25.466557	1
260	368	136	0	1.28	2025-10-06 12:27:25.489149	2025-10-06 12:27:25.489149	1
261	368	127	0	3.2	2025-10-06 12:27:25.506171	2025-10-06 12:27:25.506171	1
262	369	104	0	1.92	2025-10-06 12:29:21.157882	2025-10-06 12:29:21.157882	1
263	369	136	0	1.28	2025-10-06 12:29:21.175792	2025-10-06 12:29:21.175792	1
264	369	127	0	3.2	2025-10-06 12:29:21.189583	2025-10-06 12:29:21.189583	1
265	370	104	0	0.3299999999999999	2025-10-06 13:57:05.335332	2025-10-06 13:57:05.335332	1
266	370	136	0	0.22	2025-10-06 13:57:05.353294	2025-10-06 13:57:05.353294	1
267	370	127	0	0.55	2025-10-06 13:57:05.369433	2025-10-06 13:57:05.369433	1
268	371	104	0	0.0	2025-10-06 14:30:22.539614	2025-10-06 14:30:22.539614	1
269	371	136	0	19.9	2025-10-06 14:30:22.559018	2025-10-06 14:30:22.559018	1
270	371	127	0	0.0	2025-10-06 14:30:22.576991	2025-10-06 14:30:22.576991	1
271	372	104	0	14.96999999999999	2025-10-06 14:31:37.266425	2025-10-06 14:31:37.266425	1
272	372	136	0	9.98	2025-10-06 14:31:37.286554	2025-10-06 14:31:37.286554	1
273	372	127	0	24.95	2025-10-06 14:31:37.299842	2025-10-06 14:31:37.299842	1
274	373	104	0	0.0	2025-10-08 10:49:30.827905	2025-10-08 10:49:30.827905	1
275	373	136	0	19.9	2025-10-08 10:49:30.852186	2025-10-08 10:49:30.852186	1
276	373	127	0	0.0	2025-10-08 10:49:30.873936	2025-10-08 10:49:30.873936	1
277	374	104	0	0.0	2025-10-08 11:38:41.308355	2025-10-08 11:38:41.308355	1
278	374	136	0	29.9	2025-10-08 11:38:41.337404	2025-10-08 11:38:41.337404	1
279	374	127	0	0.0	2025-10-08 11:38:41.355222	2025-10-08 11:38:41.355222	1
280	375	104	0	0.0	2025-10-08 11:38:42.840562	2025-10-08 11:38:42.840562	1
281	375	136	0	29.9	2025-10-08 11:38:42.856912	2025-10-08 11:38:42.856912	1
282	375	127	0	0.0	2025-10-08 11:38:42.870261	2025-10-08 11:38:42.870261	1
283	376	104	0	0.3	2025-10-08 11:43:35.037652	2025-10-08 11:43:35.037652	1
284	376	136	0	0.2	2025-10-08 11:43:35.055707	2025-10-08 11:43:35.055707	1
285	376	127	0	0.5	2025-10-08 11:43:35.069717	2025-10-08 11:43:35.069717	1
286	377	104	0	0.0	2025-10-08 11:44:35.71668	2025-10-08 11:44:35.71668	1
287	377	136	0	25.0	2025-10-08 11:44:35.751727	2025-10-08 11:44:35.751727	1
288	377	127	0	0.0	2025-10-08 11:44:35.773595	2025-10-08 11:44:35.773595	1
289	378	104	0	0.0	2025-10-08 12:41:08.145593	2025-10-08 12:41:08.145593	1
290	378	136	0	39.9	2025-10-08 12:41:08.165405	2025-10-08 12:41:08.165405	1
291	378	127	0	0.0	2025-10-08 12:41:08.184861	2025-10-08 12:41:08.184861	1
292	379	104	0	0.0	2025-10-08 12:41:54.464551	2025-10-08 12:41:54.464551	1
293	379	136	0	25.0	2025-10-08 12:41:54.485992	2025-10-08 12:41:54.485992	1
294	379	127	0	0.0	2025-10-08 12:41:54.503331	2025-10-08 12:41:54.503331	1
295	380	104	0	0.0	2025-10-08 13:30:56.528955	2025-10-08 13:30:56.528955	1
296	380	136	0	29.9	2025-10-08 13:30:56.550489	2025-10-08 13:30:56.550489	1
297	380	127	0	0.0	2025-10-08 13:30:56.5693	2025-10-08 13:30:56.5693	1
298	381	104	0	0.0	2025-10-10 06:56:38.148948	2025-10-10 06:56:38.148948	1
299	381	136	0	49.9	2025-10-10 06:56:38.17583	2025-10-10 06:56:38.17583	1
300	381	127	0	0.0	2025-10-10 06:56:38.190872	2025-10-10 06:56:38.190872	1
301	382	104	0	2.01	2025-10-10 13:08:42.670241	2025-10-10 13:08:42.670241	1
302	382	136	0	1.34	2025-10-10 13:08:42.689464	2025-10-10 13:08:42.689464	1
303	382	127	0	3.35	2025-10-10 13:08:42.703363	2025-10-10 13:08:42.703363	1
304	383	104	0	3.63	2025-10-10 13:12:23.169953	2025-10-10 13:12:23.169953	1
305	383	136	0	2.42	2025-10-10 13:12:23.190713	2025-10-10 13:12:23.190713	1
306	383	127	0	6.050000000000001	2025-10-10 13:12:23.207899	2025-10-10 13:12:23.207899	1
307	384	104	0	7.02	2025-10-10 13:13:54.714729	2025-10-10 13:13:54.714729	1
308	384	136	0	4.68	2025-10-10 13:13:54.738236	2025-10-10 13:13:54.738236	1
309	384	127	0	11.7	2025-10-10 13:13:54.756685	2025-10-10 13:13:54.756685	1
310	385	104	0	16.95	2025-10-10 13:17:47.425393	2025-10-10 13:17:47.425393	1
311	385	136	0	11.3	2025-10-10 13:17:47.444235	2025-10-10 13:17:47.444235	1
312	385	127	0	28.25	2025-10-10 13:17:47.458015	2025-10-10 13:17:47.458015	1
313	386	104	0	0.0	2025-10-31 07:51:57.36211	2025-10-31 07:51:57.36211	1
314	386	136	0	19.9	2025-10-31 07:51:57.396755	2025-10-31 07:51:57.396755	1
315	386	127	0	0.0	2025-10-31 07:51:57.42334	2025-10-31 07:51:57.42334	1
316	387	104	0	0.03	2025-10-31 09:08:35.140036	2025-10-31 09:08:35.140036	1
317	387	136	0	0.02	2025-10-31 09:08:35.164125	2025-10-31 09:08:35.164125	1
318	387	127	0	0.05	2025-10-31 09:08:35.181314	2025-10-31 09:08:35.181314	1
319	388	104	0	0.0	2025-10-31 09:18:56.825104	2025-10-31 09:18:56.825104	1
320	388	136	0	19.9	2025-10-31 09:18:56.845961	2025-10-31 09:18:56.845961	1
321	388	127	0	0.0	2025-10-31 09:18:56.862327	2025-10-31 09:18:56.862327	1
322	389	104	0	0.0	2025-10-31 09:36:19.200403	2025-10-31 09:36:19.200403	1
323	389	136	0	19.9	2025-10-31 09:36:19.233613	2025-10-31 09:36:19.233613	1
324	389	127	0	0.0	2025-10-31 09:36:19.25609	2025-10-31 09:36:19.25609	1
325	390	104	0	0.0	2025-10-31 10:16:28.971939	2025-10-31 10:16:28.971939	1
326	390	136	0	29.9	2025-10-31 10:16:28.997883	2025-10-31 10:16:28.997883	1
327	390	127	0	0.0	2025-10-31 10:16:29.020981	2025-10-31 10:16:29.020981	1
328	391	104	0	18.0	2025-10-31 10:19:36.481441	2025-10-31 10:19:36.481441	1
329	391	136	0	12.0	2025-10-31 10:19:36.561398	2025-10-31 10:19:36.561398	1
330	391	127	0	30.0	2025-10-31 10:19:36.576015	2025-10-31 10:19:36.576015	1
331	392	104	0	0.0	2025-10-31 10:24:56.592771	2025-10-31 10:24:56.592771	1
332	392	136	0	19.9	2025-10-31 10:24:56.609244	2025-10-31 10:24:56.609244	1
333	392	127	0	0.0	2025-10-31 10:24:56.626953	2025-10-31 10:24:56.626953	1
334	393	104	0	0.0	2025-10-31 12:31:17.787993	2025-10-31 12:31:17.787993	1
335	393	136	0	69.9	2025-10-31 12:31:17.810009	2025-10-31 12:31:17.810009	1
336	393	127	0	0.0	2025-10-31 12:31:17.828017	2025-10-31 12:31:17.828017	1
337	394	104	0	0.0	2025-10-31 12:37:00.459004	2025-10-31 12:37:00.459004	1
338	394	136	0	19.9	2025-10-31 12:37:00.479435	2025-10-31 12:37:00.479435	1
339	394	127	0	0.0	2025-10-31 12:37:00.49487	2025-10-31 12:37:00.49487	1
340	395	104	0	0.0	2025-10-31 12:38:23.171591	2025-10-31 12:38:23.171591	1
341	395	136	0	69.9	2025-10-31 12:38:23.191084	2025-10-31 12:38:23.191084	1
342	395	127	0	0.0	2025-10-31 12:38:23.210301	2025-10-31 12:38:23.210301	1
343	396	104	0	0.0	2025-11-06 06:01:37.615403	2025-11-06 06:01:37.615403	1
344	396	136	0	5.0	2025-11-06 06:01:37.637585	2025-11-06 06:01:37.637585	1
345	396	139	0	0.0	2025-11-06 06:01:37.652369	2025-11-06 06:01:37.652369	1
346	397	104	0	0.0	2025-11-07 10:25:19.671735	2025-11-07 10:25:19.671735	1
347	397	136	0	0.15	2025-11-07 10:25:19.698013	2025-11-07 10:25:19.698013	1
348	397	139	0	0.0	2025-11-07 10:25:19.714744	2025-11-07 10:25:19.714744	1
349	398	104	0	0.0	2025-11-10 05:57:23.749905	2025-11-10 05:57:23.749905	1
350	398	136	0	0.15	2025-11-10 05:57:23.777283	2025-11-10 05:57:23.777283	1
351	398	139	0	0.0	2025-11-10 05:57:23.792641	2025-11-10 05:57:23.792641	1
352	399	104	0	0.0	2025-11-10 05:57:37.797854	2025-11-10 05:57:37.797854	1
353	399	136	0	0.15	2025-11-10 05:57:37.815651	2025-11-10 05:57:37.815651	1
354	399	139	0	0.0	2025-11-10 05:57:37.829233	2025-11-10 05:57:37.829233	1
355	400	104	0	0.0	2025-11-10 09:46:02.680706	2025-11-10 09:46:02.680706	1
356	400	136	0	0.05	2025-11-10 09:46:02.711821	2025-11-10 09:46:02.711821	1
357	400	139	0	0.0	2025-11-10 09:46:02.734227	2025-11-10 09:46:02.734227	1
358	401	104	0	0.0	2025-11-10 09:52:21.453001	2025-11-10 09:52:21.453001	1
359	401	136	0	600.0	2025-11-10 09:52:21.474686	2025-11-10 09:52:21.474686	1
360	401	139	0	0.0	2025-11-10 09:52:21.496729	2025-11-10 09:52:21.496729	1
361	402	104	0	0.0	2025-11-10 09:59:27.993747	2025-11-10 09:59:27.993747	1
362	402	136	0	600.0	2025-11-10 09:59:28.012946	2025-11-10 09:59:28.012946	1
363	402	139	0	0.0	2025-11-10 09:59:28.030264	2025-11-10 09:59:28.030264	1
364	403	104	0	0.0	2025-11-10 10:24:13.534436	2025-11-10 10:24:13.534436	1
365	403	136	0	600.0	2025-11-10 10:24:13.556598	2025-11-10 10:24:13.556598	1
366	403	139	0	0.0	2025-11-10 10:24:13.574394	2025-11-10 10:24:13.574394	1
367	404	104	0	0.0	2025-11-10 10:27:10.692853	2025-11-10 10:27:10.692853	1
368	404	136	0	600.0	2025-11-10 10:27:10.711291	2025-11-10 10:27:10.711291	1
369	404	139	0	0.0	2025-11-10 10:27:10.731122	2025-11-10 10:27:10.731122	1
370	405	104	0	0.0	2025-11-10 10:37:38.571547	2025-11-10 10:37:38.571547	1
371	405	136	0	0.15	2025-11-10 10:37:38.600424	2025-11-10 10:37:38.600424	1
372	405	139	0	0.0	2025-11-10 10:37:38.625971	2025-11-10 10:37:38.625971	1
373	406	104	0	0.0	2025-11-10 11:50:28.867152	2025-11-10 11:50:28.867152	1
374	406	136	0	0.15	2025-11-10 11:50:28.900698	2025-11-10 11:50:28.900698	1
375	406	139	0	0.0	2025-11-10 11:50:28.917028	2025-11-10 11:50:28.917028	1
376	407	104	0	0.0	2025-11-10 11:51:27.94887	2025-11-10 11:51:27.94887	1
377	407	136	0	0.15	2025-11-10 11:51:27.978524	2025-11-10 11:51:27.978524	1
378	407	139	0	0.0	2025-11-10 11:51:27.998666	2025-11-10 11:51:27.998666	1
379	408	104	0	0.0	2025-11-10 12:01:40.199942	2025-11-10 12:01:40.199942	1
380	408	136	0	0.55	2025-11-10 12:01:40.229388	2025-11-10 12:01:40.229388	1
381	408	139	0	0.0	2025-11-10 12:01:40.256388	2025-11-10 12:01:40.256388	1
382	409	104	0	0.0	2025-11-10 12:03:34.683627	2025-11-10 12:03:34.683627	1
383	409	136	0	0.55	2025-11-10 12:03:34.713096	2025-11-10 12:03:34.713096	1
384	409	139	0	0.0	2025-11-10 12:03:34.739966	2025-11-10 12:03:34.739966	1
385	410	104	0	0.0	2025-11-10 12:05:02.046873	2025-11-10 12:05:02.046873	1
386	410	136	0	0.15	2025-11-10 12:05:02.089283	2025-11-10 12:05:02.089283	1
387	410	139	0	0.0	2025-11-10 12:05:02.134006	2025-11-10 12:05:02.134006	1
388	411	104	0	0.0	2025-11-10 12:25:52.524712	2025-11-10 12:25:52.524712	1
389	411	136	0	0.1	2025-11-10 12:25:52.5561	2025-11-10 12:25:52.5561	1
390	411	139	0	0.0	2025-11-10 12:25:52.582454	2025-11-10 12:25:52.582454	1
391	412	104	0	0.0	2025-11-10 12:57:59.808543	2025-11-10 12:57:59.808543	1
392	412	136	0	1.15	2025-11-10 12:57:59.84378	2025-11-10 12:57:59.84378	1
393	412	139	0	0.0	2025-11-10 12:57:59.870932	2025-11-10 12:57:59.870932	1
394	413	104	0	0.0	2025-11-10 12:59:37.444858	2025-11-10 12:59:37.444858	1
395	413	136	0	0.6000000000000001	2025-11-10 12:59:37.492361	2025-11-10 12:59:37.492361	1
396	413	139	0	0.0	2025-11-10 12:59:37.535303	2025-11-10 12:59:37.535303	1
397	414	104	0	0.0	2025-11-11 07:26:52.532776	2025-11-11 07:26:52.532776	1
398	414	136	0	600.0	2025-11-11 07:26:52.557957	2025-11-11 07:26:52.557957	1
399	414	139	0	0.0	2025-11-11 07:26:52.577138	2025-11-11 07:26:52.577138	1
400	415	104	0	0.0	2025-11-11 07:30:18.170474	2025-11-11 07:30:18.170474	1
401	415	136	0	0.9500000000000001	2025-11-11 07:30:18.189604	2025-11-11 07:30:18.189604	1
402	415	139	0	0.0	2025-11-11 07:30:18.206749	2025-11-11 07:30:18.206749	1
403	416	104	0	0.0	2025-11-11 07:39:47.365118	2025-11-11 07:39:47.365118	1
404	416	136	0	5.75	2025-11-11 07:39:47.387142	2025-11-11 07:39:47.387142	1
405	416	139	0	0.0	2025-11-11 07:39:47.403589	2025-11-11 07:39:47.403589	1
406	417	104	0	0.0	2025-11-11 07:51:47.348191	2025-11-11 07:51:47.348191	1
407	417	136	0	0.1	2025-11-11 07:51:47.369683	2025-11-11 07:51:47.369683	1
408	417	139	0	0.0	2025-11-11 07:51:47.386593	2025-11-11 07:51:47.386593	1
409	418	104	0	0.0	2025-11-11 08:38:34.922374	2025-11-11 08:38:34.922374	1
410	418	136	0	0.65	2025-11-11 08:38:34.94321	2025-11-11 08:38:34.94321	1
411	418	139	0	0.0	2025-11-11 08:38:34.962208	2025-11-11 08:38:34.962208	1
412	419	104	0	0.0	2025-11-11 08:40:09.803849	2025-11-11 08:40:09.803849	1
413	419	136	0	0.6000000000000001	2025-11-11 08:40:09.822271	2025-11-11 08:40:09.822271	1
414	419	139	0	0.0	2025-11-11 08:40:09.837408	2025-11-11 08:40:09.837408	1
415	420	104	0	0.0	2025-11-11 08:42:17.817088	2025-11-11 08:42:17.817088	1
416	420	136	0	0.2	2025-11-11 08:42:17.835512	2025-11-11 08:42:17.835512	1
417	420	139	0	0.0	2025-11-11 08:42:17.852865	2025-11-11 08:42:17.852865	1
418	421	104	0	0.0	2025-11-11 08:55:35.154686	2025-11-11 08:55:35.154686	1
419	421	136	0	0.55	2025-11-11 08:55:35.172197	2025-11-11 08:55:35.172197	1
420	421	139	0	0.0	2025-11-11 08:55:35.187826	2025-11-11 08:55:35.187826	1
421	422	104	0	0.0	2025-11-11 08:58:37.90864	2025-11-11 08:58:37.90864	1
422	422	136	0	1.1	2025-11-11 08:58:37.924077	2025-11-11 08:58:37.924077	1
423	422	139	0	0.0	2025-11-11 08:58:37.940439	2025-11-11 08:58:37.940439	1
424	423	104	0	0.0	2025-11-11 08:58:39.985572	2025-11-11 08:58:39.985572	1
425	423	136	0	1.1	2025-11-11 08:58:40.003789	2025-11-11 08:58:40.003789	1
426	423	139	0	0.0	2025-11-11 08:58:40.018517	2025-11-11 08:58:40.018517	1
427	424	104	0	0.0	2025-11-11 08:58:50.690544	2025-11-11 08:58:50.690544	1
428	424	136	0	1.1	2025-11-11 08:58:50.716677	2025-11-11 08:58:50.716677	1
429	424	139	0	0.0	2025-11-11 08:58:50.74248	2025-11-11 08:58:50.74248	1
430	425	104	0	0.0	2025-11-11 09:00:55.722996	2025-11-11 09:00:55.722996	1
431	425	136	0	1.1	2025-11-11 09:00:55.746752	2025-11-11 09:00:55.746752	1
432	425	139	0	0.0	2025-11-11 09:00:55.765897	2025-11-11 09:00:55.765897	1
433	426	104	0	0.0	2025-11-11 09:07:52.524325	2025-11-11 09:07:52.524325	1
434	426	136	0	1.0	2025-11-11 09:07:52.551641	2025-11-11 09:07:52.551641	1
435	426	139	0	0.0	2025-11-11 09:07:52.566676	2025-11-11 09:07:52.566676	1
436	427	104	0	0.0	2025-11-11 09:11:25.267837	2025-11-11 09:11:25.267837	1
437	427	136	0	1.0	2025-11-11 09:11:25.288321	2025-11-11 09:11:25.288321	1
438	427	139	0	0.0	2025-11-11 09:11:25.303443	2025-11-11 09:11:25.303443	1
439	428	104	0	0.0	2025-11-11 09:28:15.39093	2025-11-11 09:28:15.39093	1
440	428	136	0	0.55	2025-11-11 09:28:15.421597	2025-11-11 09:28:15.421597	1
441	428	139	0	0.0	2025-11-11 09:28:15.442269	2025-11-11 09:28:15.442269	1
442	429	104	0	0.0	2025-11-11 09:39:51.939166	2025-11-11 09:39:51.939166	1
443	429	136	0	0.5	2025-11-11 09:39:51.989143	2025-11-11 09:39:51.989143	1
444	429	139	0	0.0	2025-11-11 09:39:52.008944	2025-11-11 09:39:52.008944	1
445	430	104	0	0.0	2025-11-11 09:41:35.691421	2025-11-11 09:41:35.691421	1
446	430	136	0	0.6000000000000001	2025-11-11 09:41:35.709279	2025-11-11 09:41:35.709279	1
447	430	139	0	0.0	2025-11-11 09:41:35.723918	2025-11-11 09:41:35.723918	1
448	431	104	0	0.0	2025-11-11 09:46:14.730955	2025-11-11 09:46:14.730955	1
449	431	136	0	0.45	2025-11-11 09:46:14.748035	2025-11-11 09:46:14.748035	1
450	431	139	0	0.0	2025-11-11 09:46:14.761477	2025-11-11 09:46:14.761477	1
451	432	104	0	0.0	2025-11-11 10:50:21.304278	2025-11-11 10:50:21.304278	1
452	432	136	0	0.55	2025-11-11 10:50:21.36713	2025-11-11 10:50:21.36713	1
453	432	139	0	0.0	2025-11-11 10:50:21.380797	2025-11-11 10:50:21.380797	1
454	433	104	0	0.0	2025-11-11 10:50:51.902763	2025-11-11 10:50:51.902763	1
455	433	136	0	0.55	2025-11-11 10:50:51.924163	2025-11-11 10:50:51.924163	1
456	433	139	0	0.0	2025-11-11 10:50:51.940772	2025-11-11 10:50:51.940772	1
457	434	104	0	0.0	2025-11-11 10:51:42.114959	2025-11-11 10:51:42.114959	1
458	434	136	0	0.55	2025-11-11 10:51:42.138998	2025-11-11 10:51:42.138998	1
459	434	139	0	0.0	2025-11-11 10:51:42.1555	2025-11-11 10:51:42.1555	1
460	435	104	0	0.0	2025-11-11 11:40:22.803368	2025-11-11 11:40:22.803368	1
461	435	136	0	0.5	2025-11-11 11:40:22.830053	2025-11-11 11:40:22.830053	1
462	435	139	0	0.0	2025-11-11 11:40:22.852965	2025-11-11 11:40:22.852965	1
463	436	104	0	0.0	2025-11-11 11:43:40.751993	2025-11-11 11:43:40.751993	1
464	436	136	0	5.9	2025-11-11 11:43:40.768261	2025-11-11 11:43:40.768261	1
465	436	139	0	0.0	2025-11-11 11:43:40.783362	2025-11-11 11:43:40.783362	1
466	437	104	0	0.0	2025-11-11 11:53:12.644228	2025-11-11 11:53:12.644228	1
467	437	136	0	1.1	2025-11-11 11:53:12.661844	2025-11-11 11:53:12.661844	1
468	437	139	0	0.0	2025-11-11 11:53:12.676683	2025-11-11 11:53:12.676683	1
469	438	104	0	0.0	2025-11-11 11:53:17.54482	2025-11-11 11:53:17.54482	1
470	438	136	0	1.1	2025-11-11 11:53:17.559873	2025-11-11 11:53:17.559873	1
471	438	139	0	0.0	2025-11-11 11:53:17.573245	2025-11-11 11:53:17.573245	1
472	439	104	0	0.0	2025-11-11 11:53:18.60598	2025-11-11 11:53:18.60598	1
473	439	136	0	1.1	2025-11-11 11:53:18.639286	2025-11-11 11:53:18.639286	1
474	439	139	0	0.0	2025-11-11 11:53:18.665655	2025-11-11 11:53:18.665655	1
475	440	104	0	0.0	2025-11-11 12:07:30.587709	2025-11-11 12:07:30.587709	1
476	440	136	0	55.55	2025-11-11 12:07:30.603758	2025-11-11 12:07:30.603758	1
477	440	139	0	0.0	2025-11-11 12:07:30.61628	2025-11-11 12:07:30.61628	1
478	441	104	0	0.0	2025-11-11 12:11:52.606945	2025-11-11 12:11:52.606945	1
479	441	136	0	1.0	2025-11-11 12:11:52.625219	2025-11-11 12:11:52.625219	1
480	441	139	0	0.0	2025-11-11 12:11:52.639384	2025-11-11 12:11:52.639384	1
481	442	104	0	0.0	2025-11-11 12:12:35.226847	2025-11-11 12:12:35.226847	1
482	442	136	0	1.0	2025-11-11 12:12:35.249091	2025-11-11 12:12:35.249091	1
483	442	139	0	0.0	2025-11-11 12:12:35.269009	2025-11-11 12:12:35.269009	1
484	443	104	0	0.0	2025-11-11 12:36:47.00881	2025-11-11 12:36:47.00881	1
485	443	136	0	0.15	2025-11-11 12:36:47.029194	2025-11-11 12:36:47.029194	1
486	443	139	0	0.0	2025-11-11 12:36:47.048984	2025-11-11 12:36:47.048984	1
487	444	104	0	0.0	2025-11-12 05:07:32.792568	2025-11-12 05:07:32.792568	1
488	444	136	0	0.5	2025-11-12 05:07:32.809127	2025-11-12 05:07:32.809127	1
489	444	139	0	0.0	2025-11-12 05:07:32.822972	2025-11-12 05:07:32.822972	1
490	445	104	0	0.0	2025-11-12 05:33:09.760045	2025-11-12 05:33:09.760045	1
491	445	136	0	2.2	2025-11-12 05:33:09.78474	2025-11-12 05:33:09.78474	1
492	445	139	0	0.0	2025-11-12 05:33:09.802216	2025-11-12 05:33:09.802216	1
493	446	104	0	0.0	2025-11-12 05:33:14.352505	2025-11-12 05:33:14.352505	1
494	446	136	0	2.2	2025-11-12 05:33:14.388323	2025-11-12 05:33:14.388323	1
495	446	139	0	0.0	2025-11-12 05:33:14.406618	2025-11-12 05:33:14.406618	1
496	447	104	0	0.0	2025-11-12 05:36:13.767179	2025-11-12 05:36:13.767179	1
497	447	136	0	2.2	2025-11-12 05:36:13.796909	2025-11-12 05:36:13.796909	1
498	447	139	0	0.0	2025-11-12 05:36:13.821564	2025-11-12 05:36:13.821564	1
499	448	104	0	0.0	2025-11-12 05:38:11.395271	2025-11-12 05:38:11.395271	1
500	448	136	0	2.2	2025-11-12 05:38:11.410969	2025-11-12 05:38:11.410969	1
501	448	139	0	0.0	2025-11-12 05:38:11.423688	2025-11-12 05:38:11.423688	1
502	449	104	0	0.0	2025-11-12 05:42:21.981036	2025-11-12 05:42:21.981036	1
503	449	136	0	2.2	2025-11-12 05:42:22.004382	2025-11-12 05:42:22.004382	1
504	449	139	0	0.0	2025-11-12 05:42:22.025544	2025-11-12 05:42:22.025544	1
505	450	104	0	0.0	2025-11-12 05:47:46.184873	2025-11-12 05:47:46.184873	1
506	450	136	0	2.2	2025-11-12 05:47:46.206211	2025-11-12 05:47:46.206211	1
507	450	139	0	0.0	2025-11-12 05:47:46.220721	2025-11-12 05:47:46.220721	1
508	451	104	0	0.0	2025-11-12 05:47:53.286933	2025-11-12 05:47:53.286933	1
509	451	136	0	2.2	2025-11-12 05:47:53.316735	2025-11-12 05:47:53.316735	1
510	451	139	0	0.0	2025-11-12 05:47:53.342902	2025-11-12 05:47:53.342902	1
511	452	104	0	0.0	2025-11-12 05:51:38.058818	2025-11-12 05:51:38.058818	1
512	452	136	0	1.1	2025-11-12 05:51:38.088905	2025-11-12 05:51:38.088905	1
513	452	139	0	0.0	2025-11-12 05:51:38.131741	2025-11-12 05:51:38.131741	1
514	453	104	0	0.0	2025-11-12 05:53:44.704898	2025-11-12 05:53:44.704898	1
515	453	136	0	1.1	2025-11-12 05:53:44.731534	2025-11-12 05:53:44.731534	1
516	453	139	0	0.0	2025-11-12 05:53:44.838435	2025-11-12 05:53:44.838435	1
517	454	104	0	0.0	2025-11-12 05:57:50.968799	2025-11-12 05:57:50.968799	1
518	454	136	0	1.1	2025-11-12 05:57:51.075993	2025-11-12 05:57:51.075993	1
519	454	139	0	0.0	2025-11-12 05:57:51.122061	2025-11-12 05:57:51.122061	1
520	455	104	0	0.0	2025-11-12 05:58:23.733463	2025-11-12 05:58:23.733463	1
521	455	136	0	1.1	2025-11-12 05:58:23.920535	2025-11-12 05:58:23.920535	1
522	455	139	0	0.0	2025-11-12 05:58:24.036	2025-11-12 05:58:24.036	1
523	456	104	0	0.0	2025-11-12 05:59:10.255989	2025-11-12 05:59:10.255989	1
524	456	136	0	1.1	2025-11-12 05:59:10.297659	2025-11-12 05:59:10.297659	1
525	456	139	0	0.0	2025-11-12 05:59:10.326742	2025-11-12 05:59:10.326742	1
526	457	104	0	0.0	2025-11-12 06:00:27.772487	2025-11-12 06:00:27.772487	1
527	457	136	0	0.55	2025-11-12 06:00:27.807563	2025-11-12 06:00:27.807563	1
528	457	139	0	0.0	2025-11-12 06:00:27.828114	2025-11-12 06:00:27.828114	1
529	458	104	0	0.0	2025-11-12 06:20:41.121992	2025-11-12 06:20:41.121992	1
530	458	136	0	10.0	2025-11-12 06:20:41.142011	2025-11-12 06:20:41.142011	1
531	458	139	0	0.0	2025-11-12 06:20:41.157531	2025-11-12 06:20:41.157531	1
532	459	104	0	0.0	2025-11-12 06:22:30.419085	2025-11-12 06:22:30.419085	1
533	459	136	0	10.0	2025-11-12 06:22:30.455312	2025-11-12 06:22:30.455312	1
534	459	139	0	0.0	2025-11-12 06:22:30.505586	2025-11-12 06:22:30.505586	1
535	460	104	0	0.0	2025-11-12 06:25:30.028935	2025-11-12 06:25:30.028935	1
536	460	136	0	10.0	2025-11-12 06:25:30.058617	2025-11-12 06:25:30.058617	1
537	460	139	0	0.0	2025-11-12 06:25:30.076557	2025-11-12 06:25:30.076557	1
538	461	104	0	0.0	2025-11-12 06:26:33.195713	2025-11-12 06:26:33.195713	1
539	461	136	0	10.0	2025-11-12 06:26:33.214465	2025-11-12 06:26:33.214465	1
540	461	139	0	0.0	2025-11-12 06:26:33.233414	2025-11-12 06:26:33.233414	1
541	462	104	0	0.0	2025-11-12 06:27:49.790378	2025-11-12 06:27:49.790378	1
542	462	136	0	10.0	2025-11-12 06:27:49.806576	2025-11-12 06:27:49.806576	1
543	462	139	0	0.0	2025-11-12 06:27:49.824894	2025-11-12 06:27:49.824894	1
544	463	104	0	0.0	2025-11-12 06:29:34.200922	2025-11-12 06:29:34.200922	1
545	463	136	0	5.0	2025-11-12 06:29:34.234389	2025-11-12 06:29:34.234389	1
546	463	139	0	0.0	2025-11-12 06:29:34.270277	2025-11-12 06:29:34.270277	1
547	464	104	0	0.0	2025-11-12 06:34:32.22319	2025-11-12 06:34:32.22319	1
548	464	136	0	0.1	2025-11-12 06:34:32.23988	2025-11-12 06:34:32.23988	1
549	464	139	0	0.0	2025-11-12 06:34:32.254475	2025-11-12 06:34:32.254475	1
550	465	104	0	0.0	2025-11-12 06:39:34.624687	2025-11-12 06:39:34.624687	1
551	465	136	0	1.0	2025-11-12 06:39:34.652165	2025-11-12 06:39:34.652165	1
552	465	139	0	0.0	2025-11-12 06:39:34.679285	2025-11-12 06:39:34.679285	1
553	466	104	0	0.0	2025-11-12 07:50:01.149883	2025-11-12 07:50:01.149883	1
554	466	136	0	1.0	2025-11-12 07:50:01.176854	2025-11-12 07:50:01.176854	1
555	466	139	0	0.0	2025-11-12 07:50:01.199231	2025-11-12 07:50:01.199231	1
556	467	104	0	0.0	2025-11-12 10:29:25.726897	2025-11-12 10:29:25.726897	1
557	467	136	0	5.550000000000001	2025-11-12 10:29:25.749784	2025-11-12 10:29:25.749784	1
558	467	139	0	0.0	2025-11-12 10:29:25.764325	2025-11-12 10:29:25.764325	1
559	468	104	0	0.0	2025-11-12 10:38:22.712808	2025-11-12 10:38:22.712808	1
560	468	136	0	9.950000000000001	2025-11-12 10:38:22.730974	2025-11-12 10:38:22.730974	1
561	468	139	0	0.0	2025-11-12 10:38:22.747254	2025-11-12 10:38:22.747254	1
562	469	104	0	0.0	2025-11-12 10:39:16.066281	2025-11-12 10:39:16.066281	1
563	469	136	0	0.6000000000000001	2025-11-12 10:39:16.088747	2025-11-12 10:39:16.088747	1
564	469	139	0	0.0	2025-11-12 10:39:16.114952	2025-11-12 10:39:16.114952	1
565	470	104	0	0.0	2025-11-12 10:39:52.522828	2025-11-12 10:39:52.522828	1
566	470	136	0	19.95	2025-11-12 10:39:52.549421	2025-11-12 10:39:52.549421	1
567	470	139	0	0.0	2025-11-12 10:39:52.566353	2025-11-12 10:39:52.566353	1
568	471	104	0	0.0	2025-11-12 12:08:33.331136	2025-11-12 12:08:33.331136	1
569	471	136	0	4.4	2025-11-12 12:08:33.354939	2025-11-12 12:08:33.354939	1
570	471	139	0	0.0	2025-11-12 12:08:33.375846	2025-11-12 12:08:33.375846	1
571	472	104	0	0.0	2025-11-12 12:10:12.826548	2025-11-12 12:10:12.826548	1
572	472	136	0	0.65	2025-11-12 12:10:12.84458	2025-11-12 12:10:12.84458	1
573	472	139	0	0.0	2025-11-12 12:10:12.860762	2025-11-12 12:10:12.860762	1
574	473	104	0	0.0	2025-11-12 12:12:00.108963	2025-11-12 12:12:00.108963	1
575	473	136	0	4.5	2025-11-12 12:12:00.144347	2025-11-12 12:12:00.144347	1
576	473	139	0	0.0	2025-11-12 12:12:00.166813	2025-11-12 12:12:00.166813	1
577	474	104	0	0.0	2025-11-12 12:12:50.631376	2025-11-12 12:12:50.631376	1
578	474	136	0	1.0	2025-11-12 12:12:50.648427	2025-11-12 12:12:50.648427	1
579	474	139	0	0.0	2025-11-12 12:12:50.662752	2025-11-12 12:12:50.662752	1
580	475	104	0	0.0	2025-11-13 06:39:22.379069	2025-11-13 06:39:22.379069	1
581	475	136	0	14.95	2025-11-13 06:39:22.405904	2025-11-13 06:39:22.405904	1
582	475	139	0	0.0	2025-11-13 06:39:22.422483	2025-11-13 06:39:22.422483	1
583	476	104	0	0.0	2025-11-13 06:42:36.501886	2025-11-13 06:42:36.501886	1
584	476	136	0	2.05	2025-11-13 06:42:36.529331	2025-11-13 06:42:36.529331	1
585	476	139	0	0.0	2025-11-13 06:42:36.553605	2025-11-13 06:42:36.553605	1
586	477	104	0	0.0	2025-11-13 06:45:23.885264	2025-11-13 06:45:23.885264	1
587	477	136	0	0.55	2025-11-13 06:45:23.900432	2025-11-13 06:45:23.900432	1
588	477	139	0	0.0	2025-11-13 06:45:23.916513	2025-11-13 06:45:23.916513	1
589	478	104	0	0.0	2025-11-13 06:52:29.037786	2025-11-13 06:52:29.037786	1
590	478	136	0	1.1	2025-11-13 06:52:29.056107	2025-11-13 06:52:29.056107	1
591	478	139	0	0.0	2025-11-13 06:52:29.072311	2025-11-13 06:52:29.072311	1
592	479	104	0	0.0	2025-11-13 07:34:12.23461	2025-11-13 07:34:12.23461	1
593	479	136	0	6.0	2025-11-13 07:34:12.254807	2025-11-13 07:34:12.254807	1
594	479	139	0	0.0	2025-11-13 07:34:12.269952	2025-11-13 07:34:12.269952	1
595	480	104	0	0.0	2025-11-13 08:52:42.564053	2025-11-13 08:52:42.564053	1
596	480	136	0	4.5	2025-11-13 08:52:42.584878	2025-11-13 08:52:42.584878	1
597	480	139	0	0.0	2025-11-13 08:52:42.599617	2025-11-13 08:52:42.599617	1
598	481	104	0	0.0	2025-11-13 08:55:51.288126	2025-11-13 08:55:51.288126	1
599	481	136	0	10.0	2025-11-13 08:55:51.307007	2025-11-13 08:55:51.307007	1
600	481	139	0	0.0	2025-11-13 08:55:51.321636	2025-11-13 08:55:51.321636	1
601	482	104	0	0.0	2025-11-13 08:58:53.05712	2025-11-13 08:58:53.05712	1
602	482	136	0	1.0	2025-11-13 08:58:53.077277	2025-11-13 08:58:53.077277	1
603	482	139	0	0.0	2025-11-13 08:58:53.092731	2025-11-13 08:58:53.092731	1
604	483	104	0	0.0	2025-11-13 09:20:15.208358	2025-11-13 09:20:15.208358	1
605	483	136	0	0.1	2025-11-13 09:20:15.24375	2025-11-13 09:20:15.24375	1
606	483	139	0	0.0	2025-11-13 09:20:15.271833	2025-11-13 09:20:15.271833	1
607	484	104	0	0.0	2025-11-13 09:30:27.896478	2025-11-13 09:30:27.896478	1
608	484	136	0	0.05	2025-11-13 09:30:27.913968	2025-11-13 09:30:27.913968	1
609	484	139	0	0.0	2025-11-13 09:30:27.932412	2025-11-13 09:30:27.932412	1
610	485	104	0	0.0	2025-11-13 10:03:40.491534	2025-11-13 10:03:40.491534	1
611	485	136	0	9.950000000000001	2025-11-13 10:03:40.513836	2025-11-13 10:03:40.513836	1
612	485	139	0	0.0	2025-11-13 10:03:40.532913	2025-11-13 10:03:40.532913	1
613	486	104	0	0.0	2025-11-13 11:50:05.271349	2025-11-13 11:50:05.271349	1
614	486	136	0	19.95	2025-11-13 11:50:05.291511	2025-11-13 11:50:05.291511	1
615	486	139	0	0.0	2025-11-13 11:50:05.329752	2025-11-13 11:50:05.329752	1
616	487	104	0	0.0	2025-11-13 12:24:35.8803	2025-11-13 12:24:35.8803	1
617	487	136	0	9.950000000000001	2025-11-13 12:24:35.899125	2025-11-13 12:24:35.899125	1
618	487	139	0	0.0	2025-11-13 12:24:35.912601	2025-11-13 12:24:35.912601	1
619	488	104	0	0.0	2025-11-14 10:12:19.495303	2025-11-14 10:12:19.495303	1
620	488	136	0	54.477	2025-11-14 10:12:19.522889	2025-11-14 10:12:19.522889	1
621	488	139	0	0.0	2025-11-14 10:12:19.537326	2025-11-14 10:12:19.537326	1
622	489	104	0	0.0	2025-11-14 10:15:01.281484	2025-11-14 10:15:01.281484	1
623	489	136	0	54.477	2025-11-14 10:15:01.301792	2025-11-14 10:15:01.301792	1
624	489	139	0	0.0	2025-11-14 10:15:01.317575	2025-11-14 10:15:01.317575	1
625	490	104	0	0.0	2025-11-14 10:28:23.262464	2025-11-14 10:28:23.262464	1
626	490	136	0	54.477	2025-11-14 10:28:23.285581	2025-11-14 10:28:23.285581	1
627	490	139	0	0.0	2025-11-14 10:28:23.303858	2025-11-14 10:28:23.303858	1
628	491	104	0	0.0	2025-11-14 11:00:35.079145	2025-11-14 11:00:35.079145	1
629	491	136	0	54.477	2025-11-14 11:00:35.09924	2025-11-14 11:00:35.09924	1
630	491	139	0	0.0	2025-11-14 11:00:35.115633	2025-11-14 11:00:35.115633	1
631	492	104	0	0.0	2025-11-14 12:28:27.986775	2025-11-14 12:28:27.986775	1
632	492	136	0	54.477	2025-11-14 12:28:28.007122	2025-11-14 12:28:28.007122	1
633	492	139	0	0.0	2025-11-14 12:28:28.021618	2025-11-14 12:28:28.021618	1
634	493	104	0	0.0	2025-11-17 06:04:21.411313	2025-11-17 06:04:21.411313	1
635	493	136	0	5.399999999999999	2025-11-17 06:04:21.432097	2025-11-17 06:04:21.432097	1
636	493	139	0	0.0	2025-11-17 06:04:21.449819	2025-11-17 06:04:21.449819	1
637	494	104	0	0.0	2025-11-17 06:05:21.255453	2025-11-17 06:05:21.255453	1
638	494	136	0	5.279999999999999	2025-11-17 06:05:21.283148	2025-11-17 06:05:21.283148	1
639	494	139	0	0.0	2025-11-17 06:05:21.298509	2025-11-17 06:05:21.298509	1
640	495	104	0	0.0	2025-11-17 06:06:02.613368	2025-11-17 06:06:02.613368	1
641	495	136	0	1.319999999999999	2025-11-17 06:06:02.629593	2025-11-17 06:06:02.629593	1
642	495	139	0	0.0	2025-11-17 06:06:02.644511	2025-11-17 06:06:02.644511	1
643	496	104	0	0.0	2025-11-17 06:07:56.990931	2025-11-17 06:07:56.990931	1
644	496	136	0	2.639999999999999	2025-11-17 06:07:57.007363	2025-11-17 06:07:57.007363	1
645	496	139	0	0.0	2025-11-17 06:07:57.022486	2025-11-17 06:07:57.022486	1
646	497	104	0	0.0	2025-11-17 06:08:25.303452	2025-11-17 06:08:25.303452	1
647	497	136	0	44.94	2025-11-17 06:08:25.321014	2025-11-17 06:08:25.321014	1
648	497	139	0	0.0	2025-11-17 06:08:25.33809	2025-11-17 06:08:25.33809	1
649	498	104	0	0.0	2025-11-17 06:10:01.893464	2025-11-17 06:10:01.893464	1
650	498	136	0	11.94	2025-11-17 06:10:01.918778	2025-11-17 06:10:01.918778	1
651	498	139	0	0.0	2025-11-17 06:10:01.939089	2025-11-17 06:10:01.939089	1
652	499	104	0	0.0	2025-11-17 07:21:36.792684	2025-11-17 07:21:36.792684	1
653	499	136	0	65.3724	2025-11-17 07:21:36.831059	2025-11-17 07:21:36.831059	1
654	499	139	0	0.0	2025-11-17 07:21:36.857326	2025-11-17 07:21:36.857326	1
655	500	104	0	0.0	2025-11-17 07:21:47.245373	2025-11-17 07:21:47.245373	1
656	500	136	0	65.3724	2025-11-17 07:21:47.270273	2025-11-17 07:21:47.270273	1
657	500	139	0	0.0	2025-11-17 07:21:47.291823	2025-11-17 07:21:47.291823	1
658	501	104	0	0.0	2025-11-17 07:24:16.258256	2025-11-17 07:24:16.258256	1
659	501	136	0	65.3724	2025-11-17 07:24:16.277868	2025-11-17 07:24:16.277868	1
660	501	139	0	0.0	2025-11-17 07:24:16.291666	2025-11-17 07:24:16.291666	1
661	502	104	0	0.0	2025-11-17 07:28:57.588551	2025-11-17 07:28:57.588551	1
662	502	136	0	65.3724	2025-11-17 07:28:57.605624	2025-11-17 07:28:57.605624	1
663	502	139	0	0.0	2025-11-17 07:28:57.620085	2025-11-17 07:28:57.620085	1
664	503	104	0	0.0	2025-11-17 07:30:49.182431	2025-11-17 07:30:49.182431	1
665	503	136	0	65.3724	2025-11-17 07:30:49.203242	2025-11-17 07:30:49.203242	1
666	503	139	0	0.0	2025-11-17 07:30:49.218205	2025-11-17 07:30:49.218205	1
667	504	104	0	0.0	2025-11-17 07:34:00.584645	2025-11-17 07:34:00.584645	1
668	504	136	0	65.3724	2025-11-17 07:34:00.601953	2025-11-17 07:34:00.601953	1
669	504	139	0	0.0	2025-11-17 07:34:00.615758	2025-11-17 07:34:00.615758	1
670	505	104	0	0.0	2025-11-17 07:37:49.925033	2025-11-17 07:37:49.925033	1
671	505	136	0	65.3724	2025-11-17 07:37:49.941508	2025-11-17 07:37:49.941508	1
672	505	139	0	0.0	2025-11-17 07:37:49.958202	2025-11-17 07:37:49.958202	1
673	506	104	0	0.0	2025-11-17 08:47:38.334562	2025-11-17 08:47:38.334562	1
674	506	136	0	0.54	2025-11-17 08:47:38.352352	2025-11-17 08:47:38.352352	1
675	506	139	0	0.0	2025-11-17 08:47:38.367444	2025-11-17 08:47:38.367444	1
676	507	104	0	0.0	2025-11-17 08:48:40.338842	2025-11-17 08:48:40.338842	1
677	507	136	0	0.54	2025-11-17 08:48:40.355971	2025-11-17 08:48:40.355971	1
678	507	139	0	0.0	2025-11-17 08:48:40.371554	2025-11-17 08:48:40.371554	1
679	508	104	0	0.0	2025-11-17 08:55:05.964412	2025-11-17 08:55:05.964412	1
680	508	136	0	3.0	2025-11-17 08:55:06.004568	2025-11-17 08:55:06.004568	1
681	508	139	0	0.0	2025-11-17 08:55:06.028701	2025-11-17 08:55:06.028701	1
682	509	104	0	0.0	2025-11-17 08:56:22.601226	2025-11-17 08:56:22.601226	1
683	509	136	0	6.54	2025-11-17 08:56:22.622248	2025-11-17 08:56:22.622248	1
684	509	139	0	0.0	2025-11-17 08:56:22.63925	2025-11-17 08:56:22.63925	1
685	510	104	0	0.0	2025-11-17 09:02:17.358262	2025-11-17 09:02:17.358262	1
686	510	136	0	5.399999999999999	2025-11-17 09:02:17.38038	2025-11-17 09:02:17.38038	1
687	510	139	0	0.0	2025-11-17 09:02:17.395274	2025-11-17 09:02:17.395274	1
688	511	104	0	0.0	2025-11-17 09:05:58.730259	2025-11-17 09:05:58.730259	1
689	511	136	0	18.0	2025-11-17 09:05:58.747957	2025-11-17 09:05:58.747957	1
690	511	139	0	0.0	2025-11-17 09:05:58.765873	2025-11-17 09:05:58.765873	1
691	512	104	0	0.0	2025-11-17 09:53:29.448322	2025-11-17 09:53:29.448322	1
692	512	136	0	1.319999999999999	2025-11-17 09:53:29.469175	2025-11-17 09:53:29.469175	1
693	512	139	0	0.0	2025-11-17 09:53:29.48253	2025-11-17 09:53:29.48253	1
694	513	104	0	0.0	2025-11-17 10:00:55.913288	2025-11-17 10:00:55.913288	1
695	513	136	0	5.399999999999999	2025-11-17 10:00:55.933018	2025-11-17 10:00:55.933018	1
696	513	139	0	0.0	2025-11-17 10:00:55.960055	2025-11-17 10:00:55.960055	1
697	514	104	0	0.0	2025-11-17 10:04:25.442959	2025-11-17 10:04:25.442959	1
698	514	136	0	0.6	2025-11-17 10:04:25.463089	2025-11-17 10:04:25.463089	1
699	514	139	0	0.0	2025-11-17 10:04:25.481773	2025-11-17 10:04:25.481773	1
700	515	104	0	0.0	2025-11-17 10:24:36.429786	2025-11-17 10:24:36.429786	1
701	515	136	0	65.3724	2025-11-17 10:24:36.476112	2025-11-17 10:24:36.476112	1
702	515	139	0	0.0	2025-11-17 10:24:36.516769	2025-11-17 10:24:36.516769	1
703	516	104	0	0.0	2025-11-17 10:32:19.502321	2025-11-17 10:32:19.502321	1
704	516	136	0	65.3724	2025-11-17 10:32:19.523273	2025-11-17 10:32:19.523273	1
705	516	139	0	0.0	2025-11-17 10:32:19.537325	2025-11-17 10:32:19.537325	1
706	517	104	0	0.0	2025-11-17 10:55:01.166461	2025-11-17 10:55:01.166461	1
707	517	136	0	54.0	2025-11-17 10:55:01.192572	2025-11-17 10:55:01.192572	1
708	517	139	0	0.0	2025-11-17 10:55:01.21279	2025-11-17 10:55:01.21279	1
709	518	104	0	0.0	2025-11-17 10:55:43.361469	2025-11-17 10:55:43.361469	1
710	518	136	0	0.06	2025-11-17 10:55:43.381525	2025-11-17 10:55:43.381525	1
711	518	139	0	0.0	2025-11-17 10:55:43.395394	2025-11-17 10:55:43.395394	1
712	519	104	0	0.0	2025-11-17 11:50:27.765548	2025-11-17 11:50:27.765548	1
713	519	136	0	4.2	2025-11-17 11:50:27.784417	2025-11-17 11:50:27.784417	1
714	519	139	0	0.0	2025-11-17 11:50:27.800147	2025-11-17 11:50:27.800147	1
715	520	104	0	0.0	2025-11-17 11:52:16.555256	2025-11-17 11:52:16.555256	1
716	520	136	0	5.7	2025-11-17 11:52:16.571327	2025-11-17 11:52:16.571327	1
717	520	139	0	0.0	2025-11-17 11:52:16.584986	2025-11-17 11:52:16.584986	1
718	521	104	0	0.0	2025-11-17 12:15:30.517111	2025-11-17 12:15:30.517111	1
719	521	136	0	1.98	2025-11-17 12:15:30.534815	2025-11-17 12:15:30.534815	1
720	521	139	0	0.0	2025-11-17 12:15:30.548085	2025-11-17 12:15:30.548085	1
721	522	104	0	0.0	2025-11-17 12:28:30.360681	2025-11-17 12:28:30.360681	1
722	522	136	0	0.6599999999999999	2025-11-17 12:28:30.387869	2025-11-17 12:28:30.387869	1
723	522	139	0	0.0	2025-11-17 12:28:30.405174	2025-11-17 12:28:30.405174	1
724	523	104	0	0.0	2025-11-17 12:30:01.555977	2025-11-17 12:30:01.555977	1
725	523	136	0	54.0	2025-11-17 12:30:01.583005	2025-11-17 12:30:01.583005	1
726	523	139	0	0.0	2025-11-17 12:30:01.604829	2025-11-17 12:30:01.604829	1
727	524	104	0	0.0	2025-11-17 12:37:28.708319	2025-11-17 12:37:28.708319	1
728	524	136	0	65.3724	2025-11-17 12:37:28.734799	2025-11-17 12:37:28.734799	1
729	524	139	0	0.0	2025-11-17 12:37:28.760791	2025-11-17 12:37:28.760791	1
730	525	104	0	0.0	2025-11-17 12:40:54.956065	2025-11-17 12:40:54.956065	1
731	525	136	0	65.3724	2025-11-17 12:40:54.973453	2025-11-17 12:40:54.973453	1
732	525	139	0	0.0	2025-11-17 12:40:54.987773	2025-11-17 12:40:54.987773	1
733	526	104	0	0.0	2025-11-18 06:29:47.0758	2025-11-18 06:29:47.0758	1
734	526	136	0	36.0	2025-11-18 06:29:47.099305	2025-11-18 06:29:47.099305	1
735	526	139	0	0.0	2025-11-18 06:29:47.115133	2025-11-18 06:29:47.115133	1
736	527	104	0	0.0	2025-11-18 06:30:25.086384	2025-11-18 06:30:25.086384	1
737	527	136	0	65.3724	2025-11-18 06:30:25.104863	2025-11-18 06:30:25.104863	1
738	527	139	0	0.0	2025-11-18 06:30:25.124798	2025-11-18 06:30:25.124798	1
739	528	104	0	0.0	2025-11-18 06:31:09.608877	2025-11-18 06:31:09.608877	1
740	528	136	0	65.3724	2025-11-18 06:31:09.625927	2025-11-18 06:31:09.625927	1
741	528	139	0	0.0	2025-11-18 06:31:09.639224	2025-11-18 06:31:09.639224	1
742	529	104	0	0.0	2025-11-18 06:38:06.052231	2025-11-18 06:38:06.052231	1
743	529	136	0	4.8	2025-11-18 06:38:06.085892	2025-11-18 06:38:06.085892	1
744	529	139	0	0.0	2025-11-18 06:38:06.101575	2025-11-18 06:38:06.101575	1
745	530	104	0	0.0	2025-11-18 07:04:40.702907	2025-11-18 07:04:40.702907	1
746	530	136	0	3.599999999999999	2025-11-18 07:04:40.720118	2025-11-18 07:04:40.720118	1
747	530	139	0	0.0	2025-11-18 07:04:40.736083	2025-11-18 07:04:40.736083	1
748	531	104	0	0.0	2025-11-18 09:50:54.977993	2025-11-18 09:50:54.977993	1
749	531	136	0	65.3724	2025-11-18 09:50:54.999601	2025-11-18 09:50:54.999601	1
750	531	139	0	0.0	2025-11-18 09:50:55.017956	2025-11-18 09:50:55.017956	1
751	532	104	0	0.0	2025-11-18 10:09:55.155424	2025-11-18 10:09:55.155424	1
752	532	136	0	65.3724	2025-11-18 10:09:55.17554	2025-11-18 10:09:55.17554	1
753	532	139	0	0.0	2025-11-18 10:09:55.192092	2025-11-18 10:09:55.192092	1
754	533	104	0	0.0	2025-11-18 10:18:01.397302	2025-11-18 10:18:01.397302	1
755	533	136	0	65.3724	2025-11-18 10:18:01.416068	2025-11-18 10:18:01.416068	1
756	533	139	0	0.0	2025-11-18 10:18:01.432355	2025-11-18 10:18:01.432355	1
757	534	104	0	0.0	2025-11-18 10:24:04.650206	2025-11-18 10:24:04.650206	1
758	534	136	0	65.3724	2025-11-18 10:24:04.672335	2025-11-18 10:24:04.672335	1
759	534	139	0	0.0	2025-11-18 10:24:04.6897	2025-11-18 10:24:04.6897	1
760	535	104	0	0.0	2025-11-18 10:28:19.607662	2025-11-18 10:28:19.607662	1
761	535	136	0	65.3724	2025-11-18 10:28:19.639934	2025-11-18 10:28:19.639934	1
762	535	139	0	0.0	2025-11-18 10:28:19.669055	2025-11-18 10:28:19.669055	1
763	536	104	0	0.0	2025-11-18 11:47:12.692563	2025-11-18 11:47:12.692563	1
764	536	136	0	29.93999999999999	2025-11-18 11:47:12.710612	2025-11-18 11:47:12.710612	1
765	536	139	0	0.0	2025-11-18 11:47:12.730703	2025-11-18 11:47:12.730703	1
766	537	104	0	0.0	2025-11-18 11:49:41.12709	2025-11-18 11:49:41.12709	1
767	537	136	0	13.74	2025-11-18 11:49:41.14436	2025-11-18 11:49:41.14436	1
768	537	139	0	0.0	2025-11-18 11:49:41.162061	2025-11-18 11:49:41.162061	1
769	538	104	0	0.0	2025-11-18 11:52:12.369984	2025-11-18 11:52:12.369984	1
770	538	136	0	41.94	2025-11-18 11:52:12.386356	2025-11-18 11:52:12.386356	1
771	538	139	0	0.0	2025-11-18 11:52:12.40585	2025-11-18 11:52:12.40585	1
772	539	104	0	0.0	2025-11-18 12:10:18.323875	2025-11-18 12:10:18.323875	1
773	539	136	0	29.93999999999999	2025-11-18 12:10:18.342696	2025-11-18 12:10:18.342696	1
774	539	139	0	0.0	2025-11-18 12:10:18.361641	2025-11-18 12:10:18.361641	1
775	540	104	0	0.0	2025-11-18 12:11:40.240118	2025-11-18 12:11:40.240118	1
776	540	136	0	23.93999999999999	2025-11-18 12:11:40.2576	2025-11-18 12:11:40.2576	1
777	540	139	0	0.0	2025-11-18 12:11:40.277509	2025-11-18 12:11:40.277509	1
778	541	104	0	0.0	2025-11-26 05:50:22.046315	2025-11-26 05:50:22.046315	1
779	541	136	0	0.06	2025-11-26 05:50:22.080943	2025-11-26 05:50:22.080943	1
780	541	139	0	0.0	2025-11-26 05:50:22.106416	2025-11-26 05:50:22.106416	1
781	542	104	0	0.0	2025-11-26 05:52:07.304412	2025-11-26 05:52:07.304412	1
782	542	136	0	0.06	2025-11-26 05:52:07.334387	2025-11-26 05:52:07.334387	1
783	542	139	0	0.0	2025-11-26 05:52:07.359037	2025-11-26 05:52:07.359037	1
784	543	136	\N	1.0	2025-11-26 08:53:56.383099	2025-11-26 08:53:56.383099	5
785	544	136	\N	2.2	2025-11-26 09:02:35.664874	2025-11-26 09:02:35.664874	1
786	545	136	\N	0.1	2025-11-26 12:50:13.789504	2025-11-26 12:50:13.789504	8
787	546	136	\N	1.0	2025-11-26 12:54:27.643348	2025-11-26 12:54:27.643348	5
788	547	136	\N	0.1	2025-11-26 12:55:37.331285	2025-11-26 12:55:37.331285	8
789	548	136	\N	0.1	2025-11-26 13:01:02.404599	2025-11-26 13:01:02.404599	7
790	549	136	\N	15.0	2025-11-26 13:12:08.457298	2025-11-26 13:12:08.457298	10
791	550	136	\N	0.9	2025-11-26 13:15:45.911917	2025-11-26 13:15:45.911917	11
792	551	136	\N	1.1	2025-11-26 13:17:39.431918	2025-11-26 13:17:39.431918	12
793	552	136	\N	1.1	2025-11-26 13:19:10.541402	2025-11-26 13:19:10.541402	13
794	553	136	\N	1.1	2025-11-26 13:20:27.347665	2025-11-26 13:20:27.347665	14
795	554	136	\N	108.954	2025-11-26 13:21:55.582146	2025-11-26 13:21:55.582146	15
796	555	136	\N	108.954	2025-11-26 13:22:57.064143	2025-11-26 13:22:57.064143	16
797	556	136	\N	1.1	2025-11-26 13:23:49.285884	2025-11-26 13:23:49.285884	17
798	557	136	\N	108.954	2025-11-26 13:25:36.707685	2025-11-26 13:25:36.707685	15
799	558	136	\N	108.954	2025-11-26 13:25:59.872408	2025-11-26 13:25:59.872408	16
800	559	136	\N	1.1	2025-11-26 13:26:24.442449	2025-11-26 13:26:24.442449	17
801	560	136	\N	0.1	2025-11-26 13:26:57.380617	2025-11-26 13:26:57.380617	1
802	561	136	\N	0.1	2025-11-26 13:27:32.132335	2025-11-26 13:27:32.132335	8
803	562	136	\N	15.0	2025-11-26 13:28:19.110102	2025-11-26 13:28:19.110102	10
804	563	136	\N	1.2	2025-11-26 13:28:56.907448	2025-11-26 13:28:56.907448	11
805	564	136	\N	11.1	2025-11-26 13:29:29.608306	2025-11-26 13:29:29.608306	12
806	565	136	\N	11.1	2025-11-26 13:30:04.256406	2025-11-26 13:30:04.256406	13
807	566	136	\N	56.6	2025-11-26 13:31:05.819343	2025-11-26 13:31:05.819343	14
808	567	136	\N	1.319999999999999	2025-11-27 09:00:50.156773	2025-11-27 09:00:50.156773	9
809	568	136	\N	2.4	2025-11-27 09:54:53.143142	2025-11-27 09:54:53.143142	17
810	569	136	\N	2.2	2025-11-28 05:21:15.886479	2025-11-28 05:21:15.886479	1
811	570	136	\N	0.1	2025-12-03 08:56:39.619824	2025-12-03 08:56:39.619824	20
812	571	136	\N	0.1	2025-12-03 08:59:17.184131	2025-12-03 08:59:17.184131	20
813	572	136	\N	0.1	2025-12-03 08:59:47.976394	2025-12-03 08:59:47.976394	20
814	573	136	\N	0.1	2025-12-03 09:02:00.143229	2025-12-03 09:02:00.143229	20
815	574	136	\N	0.1	2025-12-03 12:07:46.074675	2025-12-03 12:07:46.074675	20
816	575	136	\N	108.954	2025-12-05 06:56:21.466885	2025-12-05 06:56:21.466885	15
817	576	136	\N	108.954	2025-12-05 07:34:32.91647	2025-12-05 07:34:32.91647	15
818	577	136	\N	108.954	2025-12-05 08:53:47.215856	2025-12-05 08:53:47.215856	21
819	578	136	\N	0.1	2025-12-08 08:46:21.355763	2025-12-08 08:46:21.355763	24
820	579	136	\N	1.9	2025-12-08 11:17:48.986878	2025-12-08 11:17:48.986878	5
821	580	136	\N	194.6423999999999	2025-12-09 10:16:32.306971	2025-12-09 10:16:32.306971	26
822	581	136	\N	0.06	2025-12-10 09:51:32.385559	2025-12-10 09:51:32.385559	25
823	582	136	\N	0.18	2025-12-11 09:35:55.185952	2025-12-11 09:35:55.185952	25
824	583	136	\N	0.3	2025-12-11 10:01:59.957417	2025-12-11 10:01:59.957417	25
825	584	136	\N	0.1	2025-12-11 10:21:47.426852	2025-12-11 10:21:47.426852	25
826	585	136	\N	0.05	2025-12-11 10:23:28.241266	2025-12-11 10:23:28.241266	25
827	586	136	\N	0.6000000000000001	2025-12-11 12:15:41.541701	2025-12-11 12:15:41.541701	25
828	587	136	\N	0.05	2025-12-12 06:07:50.270433	2025-12-12 06:07:50.270433	5
829	588	136	\N	0.05	2025-12-12 09:52:26.658349	2025-12-12 09:52:26.658349	5
830	589	136	\N	0.06	2025-12-12 09:57:56.955936	2025-12-12 09:57:56.955936	5
831	590	136	\N	0.6599999999999999	2025-12-12 11:24:57.259746	2025-12-12 11:24:57.259746	1
832	592	136	\N	1.0	2025-12-13 08:47:23.603736	2025-12-13 08:47:23.603736	5
833	593	136	\N	0.1	2025-12-13 08:53:57.231276	2025-12-13 08:53:57.231276	1
834	594	136	\N	1.0	2025-12-13 09:10:01.848515	2025-12-13 09:10:01.848515	5
835	595	136	\N	0.06	2025-12-18 06:29:25.667177	2025-12-18 06:29:25.667177	5
836	596	136	\N	0.05	2025-12-18 07:23:09.568452	2025-12-18 07:23:09.568452	5
837	597	136	\N	0.1	2025-12-25 04:40:30.292926	2025-12-25 04:40:30.292926	5
838	598	136	\N	1.0	2025-12-25 11:46:43.500983	2025-12-25 11:46:43.500983	5
839	599	136	\N	1.9	2025-12-25 11:49:41.706849	2025-12-25 11:49:41.706849	5
840	600	136	\N	1.0	2025-12-26 06:01:30.139574	2025-12-26 06:01:30.139574	5
841	601	136	\N	0.1	2025-12-26 06:14:25.338037	2025-12-26 06:14:25.338037	25
842	602	136	\N	906.765	2025-12-26 06:16:00.042832	2025-12-26 06:16:00.042832	26
843	603	136	\N	10.0	2025-12-26 07:04:41.966148	2025-12-26 07:04:41.966148	1
844	604	104	\N	8.0	2025-12-26 07:08:52.315608	2025-12-26 07:08:52.315608	1
845	604	136	\N	2.0	2025-12-26 07:08:52.342031	2025-12-26 07:08:52.342031	1
846	605	136	\N	10.0	2025-12-26 11:27:51.388663	2025-12-26 11:27:51.388663	18
847	606	136	\N	10.0	2025-12-26 11:43:30.20456	2025-12-26 11:43:30.20456	18
848	607	136	\N	10.0	2025-12-26 11:53:18.735603	2025-12-26 11:53:18.735603	18
849	608	136	\N	10.0	2025-12-26 11:58:11.094446	2025-12-26 11:58:11.094446	18
850	609	136	\N	10.0	2025-12-26 12:04:31.22557	2025-12-26 12:04:31.22557	18
851	610	136	\N	10.0	2025-12-26 12:06:34.910864	2025-12-26 12:06:34.910864	18
852	611	136	\N	10.0	2025-12-26 12:14:42.708117	2025-12-26 12:14:42.708117	18
853	612	136	\N	10.0	2025-12-27 06:11:09.126993	2025-12-27 06:11:09.126993	18
854	613	104	\N	60.7008	2025-12-27 06:16:19.049722	2025-12-27 06:16:19.049722	28
855	613	136	\N	15.1752	2025-12-27 06:16:19.064575	2025-12-27 06:16:19.064575	28
856	614	136	\N	0.1	2025-12-27 06:53:56.631903	2025-12-27 06:53:56.631903	20
857	615	104	\N	0.08	2025-12-27 07:00:49.225645	2025-12-27 07:00:49.225645	29
858	615	136	\N	0.02	2025-12-27 07:00:49.246782	2025-12-27 07:00:49.246782	29
859	616	104	\N	0.08	2025-12-27 07:08:11.140993	2025-12-27 07:08:11.140993	30
860	616	136	\N	0.02	2025-12-27 07:08:11.156429	2025-12-27 07:08:11.156429	30
861	617	104	\N	8.0	2025-12-27 08:34:33.547421	2025-12-27 08:34:33.547421	1
862	617	136	\N	2.0	2025-12-27 08:34:33.566345	2025-12-27 08:34:33.566345	1
863	620	104	\N	8.0	2025-12-27 08:38:40.843744	2025-12-27 08:38:40.843744	1
864	620	136	\N	2.0	2025-12-27 08:38:40.864692	2025-12-27 08:38:40.864692	1
865	621	104	\N	8.0	2025-12-27 08:40:14.789731	2025-12-27 08:40:14.789731	1
866	621	136	\N	2.0	2025-12-27 08:40:14.810536	2025-12-27 08:40:14.810536	1
867	622	104	\N	8.0	2025-12-27 08:42:25.931713	2025-12-27 08:42:25.931713	1
868	622	136	\N	2.0	2025-12-27 08:42:25.952429	2025-12-27 08:42:25.952429	1
869	623	136	\N	0.1	2025-12-27 08:43:12.868547	2025-12-27 08:43:12.868547	5
870	624	104	\N	1509.5784	2025-12-27 08:44:00.923243	2025-12-27 08:44:00.923243	31
871	624	136	\N	377.3946	2025-12-27 08:44:00.941201	2025-12-27 08:44:00.941201	31
872	625	104	\N	8.0	2025-12-27 08:48:10.977767	2025-12-27 08:48:10.977767	1
873	625	136	\N	2.0	2025-12-27 08:48:11.002052	2025-12-27 08:48:11.002052	1
874	626	104	\N	8.0	2025-12-27 08:48:42.247109	2025-12-27 08:48:42.247109	1
875	626	136	\N	2.0	2025-12-27 08:48:42.268912	2025-12-27 08:48:42.268912	1
876	627	104	\N	8.0	2025-12-27 08:49:36.575682	2025-12-27 08:49:36.575682	1
877	627	136	\N	2.0	2025-12-27 08:49:36.594837	2025-12-27 08:49:36.594837	1
878	632	104	\N	8.0	2025-12-27 08:55:29.763529	2025-12-27 08:55:29.763529	1
879	632	136	\N	2.0	2025-12-27 08:55:29.821107	2025-12-27 08:55:29.821107	1
880	635	104	\N	8.0	2025-12-27 08:57:43.769278	2025-12-27 08:57:43.769278	1
881	635	136	\N	2.0	2025-12-27 08:57:43.789735	2025-12-27 08:57:43.789735	1
882	637	104	\N	1509.5784	2025-12-27 08:58:54.834022	2025-12-27 08:58:54.834022	31
883	638	104	\N	8.0	2025-12-27 08:59:07.607372	2025-12-27 08:59:07.607372	1
884	639	127	\N	2.0	2025-12-27 09:00:21.072329	2025-12-27 09:00:21.072329	1
885	639	104	\N	8.0	2025-12-27 09:00:21.101917	2025-12-27 09:00:21.101917	1
886	640	127	\N	2.0	2025-12-27 09:01:56.455605	2025-12-27 09:01:56.455605	1
887	640	104	\N	8.0	2025-12-27 09:01:56.475672	2025-12-27 09:01:56.475672	1
888	641	127	\N	2.0	2025-12-27 09:02:52.300865	2025-12-27 09:02:52.300865	1
889	641	104	\N	0.8	2025-12-27 09:02:52.32024	2025-12-27 09:02:52.32024	1
890	642	127	\N	0.2	2025-12-27 09:11:09.054309	2025-12-27 09:11:09.054309	1
891	642	104	\N	0.8	2025-12-27 09:11:09.076624	2025-12-27 09:11:09.076624	1
892	643	127	\N	0.2	2025-12-27 09:14:37.509471	2025-12-27 09:14:37.509471	31
893	643	104	\N	0.8	2025-12-27 09:14:37.525156	2025-12-27 09:14:37.525156	31
894	644	127	\N	0.2	2025-12-27 09:16:44.998962	2025-12-27 09:16:44.998962	1
895	644	104	\N	0.8	2025-12-27 09:16:45.019136	2025-12-27 09:16:45.019136	1
896	645	127	\N	0.2	2025-12-27 09:19:39.93036	2025-12-27 09:19:39.93036	25
897	646	127	\N	0.2	2025-12-27 09:23:13.313717	2025-12-27 09:23:13.313717	1
898	646	104	\N	0.8	2025-12-27 09:23:13.335944	2025-12-27 09:23:13.335944	1
899	647	127	\N	0.2	2025-12-27 09:23:39.654441	2025-12-27 09:23:39.654441	1
900	647	104	\N	0.8	2025-12-27 09:23:39.680822	2025-12-27 09:23:39.680822	1
901	648	127	\N	0.2	2025-12-27 09:27:34.433173	2025-12-27 09:27:34.433173	25
902	649	127	\N	0.2	2025-12-27 09:31:20.060519	2025-12-27 09:31:20.060519	1
903	649	104	\N	0.8	2025-12-27 09:31:20.084389	2025-12-27 09:31:20.084389	1
904	650	127	\N	0.2	2025-12-27 09:31:54.425271	2025-12-27 09:31:54.425271	1
905	650	104	\N	0.8	2025-12-27 09:31:54.445296	2025-12-27 09:31:54.445296	1
906	651	127	\N	0.2	2025-12-27 09:35:06.589016	2025-12-27 09:35:06.589016	26
907	652	127	\N	0.2	2025-12-27 09:36:46.864638	2025-12-27 09:36:46.864638	1
908	652	104	\N	0.8	2025-12-27 09:36:46.879411	2025-12-27 09:36:46.879411	1
909	653	104	\N	0.8	2025-12-27 09:40:31.170339	2025-12-27 09:40:31.170339	32
910	653	136	\N	0.2	2025-12-27 09:40:31.206279	2025-12-27 09:40:31.206279	32
911	654	127	\N	0.2	2025-12-27 09:41:23.509344	2025-12-27 09:41:23.509344	7
912	655	127	\N	0.2	2025-12-27 10:00:05.433803	2025-12-27 10:00:05.433803	1
913	655	104	\N	0.8	2025-12-27 10:00:05.46266	2025-12-27 10:00:05.46266	1
914	656	127	\N	0.2	2025-12-27 10:00:42.14869	2025-12-27 10:00:42.14869	1
915	656	104	\N	0.8	2025-12-27 10:00:42.168485	2025-12-27 10:00:42.168485	1
916	657	127	\N	0.06	2025-12-27 10:01:33.819141	2025-12-27 10:01:33.819141	1
917	657	104	\N	0.24	2025-12-27 10:01:33.840923	2025-12-27 10:01:33.840923	1
918	658	127	\N	0.06	2025-12-27 10:04:13.87247	2025-12-27 10:04:13.87247	1
919	658	104	\N	0.24	2025-12-27 10:04:13.908344	2025-12-27 10:04:13.908344	1
920	659	127	\N	0.06	2025-12-27 10:09:00.741555	2025-12-27 10:09:00.741555	1
921	659	104	\N	0.24	2025-12-27 10:09:00.765872	2025-12-27 10:09:00.765872	1
922	660	127	\N	0.06	2025-12-27 10:09:48.497223	2025-12-27 10:09:48.497223	1
923	660	104	\N	0.24	2025-12-27 10:09:48.52252	2025-12-27 10:09:48.52252	1
924	661	127	\N	0.06	2025-12-27 10:11:26.247872	2025-12-27 10:11:26.247872	1
925	661	104	\N	0.24	2025-12-27 10:11:26.264637	2025-12-27 10:11:26.264637	1
926	661	136	\N	2.76	2025-12-27 10:11:26.284525	2025-12-27 10:11:26.284525	1
927	662	127	\N	0.06	2025-12-27 10:14:24.368678	2025-12-27 10:14:24.368678	1
928	662	104	\N	0.24	2025-12-27 10:14:24.411569	2025-12-27 10:14:24.411569	1
929	663	127	\N	0.06	2025-12-27 10:15:06.654715	2025-12-27 10:15:06.654715	1
930	663	104	\N	0.24	2025-12-27 10:15:06.675166	2025-12-27 10:15:06.675166	1
931	664	127	\N	0.06	2025-12-27 10:15:57.989992	2025-12-27 10:15:57.989992	1
932	664	104	\N	0.24	2025-12-27 10:15:58.011227	2025-12-27 10:15:58.011227	1
933	665	127	\N	0.06	2025-12-27 10:16:47.366801	2025-12-27 10:16:47.366801	1
934	665	104	\N	0.24	2025-12-27 10:16:47.387348	2025-12-27 10:16:47.387348	1
935	666	127	\N	0.06	2025-12-27 10:17:41.736073	2025-12-27 10:17:41.736073	1
936	666	104	\N	0.24	2025-12-27 10:17:41.771391	2025-12-27 10:17:41.771391	1
937	666	136	\N	9.76	2025-12-27 10:17:41.794466	2025-12-27 10:17:41.794466	1
938	667	127	\N	0.06	2025-12-27 10:19:37.246445	2025-12-27 10:19:37.246445	1
939	667	104	\N	0.24	2025-12-27 10:19:37.265554	2025-12-27 10:19:37.265554	1
940	667	136	\N	0.06	2025-12-27 10:19:37.284644	2025-12-27 10:19:37.284644	1
941	668	127	\N	0.06	2025-12-27 10:20:56.988099	2025-12-27 10:20:56.988099	1
942	668	104	\N	0.24	2025-12-27 10:20:57.014364	2025-12-27 10:20:57.014364	1
943	668	136	\N	0.06	2025-12-27 10:20:57.05124	2025-12-27 10:20:57.05124	1
944	669	127	\N	0.06	2025-12-27 10:24:28.673163	2025-12-27 10:24:28.673163	18
945	669	136	\N	0.3	2025-12-27 10:24:28.693963	2025-12-27 10:24:28.693963	18
946	670	127	\N	0.06	2025-12-27 10:26:00.584064	2025-12-27 10:26:00.584064	1
947	670	104	\N	0.24	2025-12-27 10:26:00.606773	2025-12-27 10:26:00.606773	1
948	670	136	\N	0.06	2025-12-27 10:26:00.631304	2025-12-27 10:26:00.631304	1
949	671	127	\N	0.06	2025-12-27 10:26:40.974508	2025-12-27 10:26:40.974508	1
950	671	104	\N	0.24	2025-12-27 10:26:40.995744	2025-12-27 10:26:40.995744	1
951	671	136	\N	0.06	2025-12-27 10:26:41.018111	2025-12-27 10:26:41.018111	1
952	672	127	\N	0.06	2025-12-27 10:28:09.870605	2025-12-27 10:28:09.870605	1
953	672	104	\N	0.24	2025-12-27 10:28:09.890702	2025-12-27 10:28:09.890702	1
954	672	136	\N	0.06	2025-12-27 10:28:09.906881	2025-12-27 10:28:09.906881	1
955	673	127	\N	0.06	2025-12-27 10:28:25.855103	2025-12-27 10:28:25.855103	1
956	673	104	\N	0.24	2025-12-27 10:28:25.873592	2025-12-27 10:28:25.873592	1
957	673	136	\N	0.06	2025-12-27 10:28:25.897734	2025-12-27 10:28:25.897734	1
958	674	127	\N	0.06	2025-12-27 10:28:37.827207	2025-12-27 10:28:37.827207	1
959	674	104	\N	0.24	2025-12-27 10:28:37.844767	2025-12-27 10:28:37.844767	1
960	674	136	\N	0.06	2025-12-27 10:28:37.86379	2025-12-27 10:28:37.86379	1
961	675	127	\N	0.06	2025-12-27 10:34:20.821548	2025-12-27 10:34:20.821548	28
962	675	104	\N	0.24	2025-12-27 10:34:20.841119	2025-12-27 10:34:20.841119	28
963	675	136	\N	0.06	2025-12-27 10:34:20.860991	2025-12-27 10:34:20.860991	28
964	676	104	\N	0.24	2025-12-27 10:39:31.504924	2025-12-27 10:39:31.504924	32
965	676	136	\N	0.06	2025-12-27 10:39:31.528064	2025-12-27 10:39:31.528064	32
966	677	104	\N	0.24	2025-12-27 10:48:19.586494	2025-12-27 10:48:19.586494	32
967	677	136	\N	0.06	2025-12-27 10:48:19.612855	2025-12-27 10:48:19.612855	32
968	678	104	\N	0.24	2025-12-27 10:57:10.61208	2025-12-27 10:57:10.61208	32
969	678	136	\N	0.06	2025-12-27 10:57:10.631318	2025-12-27 10:57:10.631318	32
970	679	127	\N	0.06	2025-12-27 11:00:21.218812	2025-12-27 11:00:21.218812	18
971	679	136	\N	0.3	2025-12-27 11:00:21.242753	2025-12-27 11:00:21.242753	18
972	680	127	\N	0.06	2025-12-27 11:05:24.870829	2025-12-27 11:05:24.870829	18
973	680	136	\N	0.3	2025-12-27 11:05:24.902608	2025-12-27 11:05:24.902608	18
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, tx_id, operator, transaction_type, account_or_mobile, amount, status, user_id, created_at, updated_at, service_product_id, consumer_name, subscriber_or_vc_number, bill_no, landline_no, std_code, tid, tds, sender_id, payment_mode_desc, totalamount, status_text, txstatus_desc, commission, mobile, vehicle_no) FROM stdin;
128	TXN756047	Airtel	ONLINE	7056858674	3.0	SUCCESS	127	2025-09-08 10:50:32.396033	2025-09-08 10:50:32.396033	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1	TXN281668	Jio	Mobile Recharge	8967896789	400.0	\N	118	2025-09-03 12:05:03.351194	2025-09-08 10:22:52.2069	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
56	TXN259615	Jio	ONLINE	9845634853	299.0	SUCCESS	127	2025-09-04 10:57:47.23236	2025-09-08 10:22:52.221127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
57	TXN625882	Jio	ONLINE	8458975789	299.0	SUCCESS	127	2025-09-04 11:01:24.17657	2025-09-08 10:22:52.223234	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
68	TXN648821	Jio	ONLINE	9987575469	299.0	SUCCESS	127	2025-09-04 13:21:22.687494	2025-09-08 10:22:52.225411	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
69	TXN627123	Jio	ONLINE	8786756756	299.0	SUCCESS	127	2025-09-04 14:00:45.73664	2025-09-08 10:22:52.227873	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
70	TXN895988	Jio	ONLINE	7656756565	199.0	SUCCESS	127	2025-09-04 14:01:34.089607	2025-09-08 10:22:52.230946	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
71	TXN862023	Jio	Mobile Recharge	9009090909	399.0	SUCCESS	142	2025-09-04 18:43:16.937956	2025-09-08 10:22:52.233913	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
72	TXN635460	Jio	Mobile Recharge	9009090909	399.0	SUCCESS	142	2025-09-04 18:46:40.329555	2025-09-08 10:22:52.237142	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
73	TXN343801	Jio	Mobile Recharge	9009090922	399.0	SUCCESS	142	2025-09-04 18:53:20.244303	2025-09-08 10:22:52.24002	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
74	TXN346260	Jio	Mobile Recharge	9009090922	399.0	SUCCESS	127	2025-09-04 18:54:51.550782	2025-09-08 10:22:52.242907	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
75	TXN711768	Jio	Mobile Recharge	9009090922	399.0	SUCCESS	127	2025-09-04 18:57:00.347102	2025-09-08 10:22:52.24524	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
76	TXN506209	Vi	ONLINE	9239878327	229.0	SUCCESS	139	2025-09-05 05:44:18.037868	2025-09-08 10:22:52.247392	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
77	TXN674407	Jio	ONLINE	9887734764	199.0	SUCCESS	139	2025-09-05 05:48:02.704505	2025-09-08 10:22:52.249639	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
78	TXN424671	Jio	ONLINE	9877636355	199.0	SUCCESS	139	2025-09-05 06:23:03.721722	2025-09-08 10:22:52.251834	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
79	TXN276375	Airtel	ONLINE	9999999998	399.0	SUCCESS	139	2025-09-05 06:25:10.37026	2025-09-08 10:22:52.254192	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
80	TXN644975	BSNL	ONLINE	9878378237	397.0	SUCCESS	139	2025-09-05 06:28:47.145921	2025-09-08 10:22:52.25682	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
81	TXN257987	Jio	ONLINE	9238942783	199.0	SUCCESS	139	2025-09-05 06:30:14.234533	2025-09-08 10:22:52.259246	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
82	TXN900769	BSNL	ONLINE	9857894576	397.0	SUCCESS	127	2025-09-05 07:13:50.99573	2025-09-08 10:22:52.261821	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
83	TXN524375	Jio	Mobile Recharge	9009090922	50.0	SUCCESS	127	2025-09-05 08:41:22.391336	2025-09-08 10:22:52.26518	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
84	TXN857294	Jio	Mobile Recharge	9009090922	50.0	SUCCESS	127	2025-09-05 08:42:16.040326	2025-09-08 10:22:52.268759	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
85	TXN204140	Jio	Mobile Recharge	9009090922	50.0	SUCCESS	127	2025-09-05 08:44:43.684339	2025-09-08 10:22:52.27196	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
86	TXN537108	Jio	Mobile Recharge	9009090922	50.0	SUCCESS	127	2025-09-05 08:45:03.448304	2025-09-08 10:22:52.27508	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
87	TXN464003	Jio	ONLINE	0878756854	50.0	SUCCESS	127	2025-09-05 08:45:52.606187	2025-09-08 10:22:52.277363	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
88	TXN222500	Jio	ONLINE	0576075896	100.0	SUCCESS	127	2025-09-05 08:46:34.81119	2025-09-08 10:22:52.279392	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
89	TXN662309	Vi	ONLINE	0960975609	379.0	SUCCESS	127	2025-09-05 08:55:37.184347	2025-09-08 10:22:52.281628	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
90	TXN447288	Airtel	ONLINE	7897485675	21.0	SUCCESS	127	2025-09-05 08:58:47.425191	2025-09-08 10:22:52.284238	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
91	TXN661745	Jio	ONLINE	9840675867	199.0	SUCCESS	127	2025-09-05 09:23:34.62912	2025-09-08 10:22:52.286774	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
92	TXN436882	Jio	ONLINE	8945867586	50.0	SUCCESS	127	2025-09-05 09:28:11.394245	2025-09-08 10:22:52.28987	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
93	TXN394010	BSNL	ONLINE	7684567857	149.0	SUCCESS	127	2025-09-05 09:39:07.585305	2025-09-08 10:22:52.293139	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
94	TXN108180	Airtel	ONLINE	9075867546	20.0	SUCCESS	127	2025-09-05 09:49:19.078264	2025-09-08 10:22:52.296696	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
95	TXN115835	Airtel	ONLINE	5654645645	2.0	SUCCESS	127	2025-09-05 11:15:30.230462	2025-09-08 10:22:52.30065	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
96	TXN494233	Jio	ONLINE	9789787878	50.0	SUCCESS	127	2025-09-05 11:16:31.28945	2025-09-08 10:22:52.303791	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
97	TXN618429	Airtel	ONLINE	9856846785	20.0	SUCCESS	127	2025-09-05 11:18:47.089867	2025-09-08 10:22:52.30624	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
98	TXN592478	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:24:44.197048	2025-09-08 10:22:52.308538	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
99	TXN482133	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:24:48.92322	2025-09-08 10:22:52.312191	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
100	TXN787813	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:24:55.301585	2025-09-08 10:22:52.314931	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
101	TXN930654	Vi	ONLINE	0945609576	10.0	SUCCESS	127	2025-09-05 11:25:44.790708	2025-09-08 10:22:52.317497	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
102	TXN385095	Vi	ONLINE	0875867567	400.0	SUCCESS	127	2025-09-05 11:26:16.087155	2025-09-08 10:22:52.319957	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
103	TXN334195	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:33:22.569956	2025-09-08 10:22:52.3223	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
104	TXN338812	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:34:24.48861	2025-09-08 10:22:52.324545	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
105	TXN269233	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 11:34:34.120231	2025-09-08 10:22:52.327183	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
106	TXN846137	Vi	ONLINE	7858967856	249.0	SUCCESS	127	2025-09-05 12:07:38.333002	2025-09-08 10:22:52.330655	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
107	TXN190902	Airtel	ONLINE	0878586666	87.0	SUCCESS	127	2025-09-05 12:20:42.904552	2025-09-08 10:22:52.333906	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
108	TXN169040	Jio	ONLINE	8708578954	87.0	SUCCESS	127	2025-09-05 12:21:36.303358	2025-09-08 10:22:52.33662	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
109	TXN496480	Airtel	ONLINE	0707098787	11.0	SUCCESS	127	2025-09-05 12:22:13.879889	2025-09-08 10:22:52.339104	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
110	TXN810013	Jio	ONLINE	9895671000	20.0	SUCCESS	127	2025-09-05 12:47:27.214822	2025-09-08 10:22:52.341523	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
111	TXN641850	Jio	Mobile Recharge	9009090922	299.0	SUCCESS	127	2025-09-05 13:06:22.936565	2025-09-08 10:22:52.344146	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
112	TXN912535	Airtel	ONLINE	9745489679	6.0	SUCCESS	127	2025-09-05 13:13:12.180993	2025-09-08 10:22:52.347472	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
113	TXN231637	Airtel	ONLINE	8798586488	399.0	SUCCESS	127	2025-09-05 13:16:28.43975	2025-09-08 10:22:52.353644	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
114	TXN229026	Airtel	ONLINE	8979897565	296.0	SUCCESS	127	2025-09-05 13:34:07.647398	2025-09-08 10:22:52.356519	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
115	TXN832761	Airtel	ONLINE	9998899988	5.0	SUCCESS	127	2025-09-06 11:16:32.272829	2025-09-08 10:22:52.359376	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
116	TXN475640	BSNL	ONLINE	0970870709	99.0	SUCCESS	127	2025-09-06 12:37:36.255575	2025-09-08 10:22:52.364047	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
117	TXN658998	Airtel	ONLINE	8798768967	194.0	SUCCESS	127	2025-09-06 13:03:10.251816	2025-09-08 10:22:52.367709	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
118	TXN762371	Jio	ONLINE	7867867856	299.0	SUCCESS	127	2025-09-08 04:46:48.019377	2025-09-08 10:22:52.370379	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
119	TXN431538	Airtel	ONLINE	8779878989	39.0	SUCCESS	127	2025-09-08 06:25:19.941011	2025-09-08 10:22:52.372862	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
120	TXN815653	Jio	ONLINE	9809809898	299.0	SUCCESS	134	2025-09-08 06:38:39.303612	2025-09-08 10:22:52.375543	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
121	TXN470060	Jio	ONLINE	9887273276	199.0	SUCCESS	139	2025-09-08 06:42:13.18747	2025-09-08 10:22:52.377878	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
122	TXN819087	Airtel	ONLINE	9843847847	50.0	SUCCESS	139	2025-09-08 06:48:08.879054	2025-09-08 10:22:52.380177	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
123	TXN620063	Airtel	ONLINE	9879879879	50.0	SUCCESS	134	2025-09-08 09:43:13.55077	2025-09-08 10:22:52.382613	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
124	TXN463554	Airtel	ONLINE	9098097798	70.0	SUCCESS	134	2025-09-08 09:43:30.569204	2025-09-08 10:22:52.385305	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
125	TXN854120	Jio	Mobile Recharge	9009090922	2.0	SUCCESS	134	2025-09-08 10:00:26.922384	2025-09-08 10:22:52.38799	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
126	TXN914289	Jio	ONLINE	0934085758	199.0	SUCCESS	127	2025-09-08 10:11:49.967456	2025-09-08 10:22:52.39063	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
140	TXN535305	Vi	ONLINE	2434343432	1.0	SUCCESS	134	2025-09-08 11:33:49.07642	2025-09-08 11:33:49.07642	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
141	TXN355074	Airtel	ONLINE	0987086566	20.0	SUCCESS	127	2025-09-08 12:27:39.957225	2025-09-08 12:27:39.957225	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
142	TXN151842	Vi	ONLINE	8750675867	10.0	SUCCESS	127	2025-09-08 13:14:56.993997	2025-09-08 13:14:56.993997	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
143	TXN553175	Jio	ONLINE	0857067456	10.0	SUCCESS	127	2025-09-08 13:21:49.664094	2025-09-08 13:21:49.664094	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
144	TXN234735	Airtel	ONLINE	8658567567	20.0	SUCCESS	127	2025-09-09 05:18:48.394867	2025-09-09 05:18:48.394867	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
145	TXN532198	Airtel	ONLINE	8956754765	399.0	SUCCESS	127	2025-09-09 05:24:22.449339	2025-09-09 05:24:22.449339	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
146	TXN869761	Airtel	ONLINE	8098098098	1.0	SUCCESS	134	2025-09-09 06:18:01.443742	2025-09-09 06:18:01.443742	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
147	TXN882975	Airtel	ONLINE	0988098098	1.0	SUCCESS	134	2025-09-09 06:23:20.171762	2025-09-09 06:23:20.171762	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
148	TXN588595	Jio	ONLINE	5645654645	1.0	SUCCESS	127	2025-09-09 06:23:42.38084	2025-09-09 06:23:42.38084	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
149	TXN474624	Airtel	ONLINE	5645645645	1.0	SUCCESS	127	2025-09-09 06:24:17.013129	2025-09-09 06:24:17.013129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
150	TXN259000	Airtel	ONLINE	4567546456	24.0	SUCCESS	127	2025-09-09 06:26:29.10355	2025-09-09 06:26:29.10355	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
151	TXN112533	Jio	ONLINE	7685763476	2.0	SUCCESS	127	2025-09-09 06:48:28.538808	2025-09-09 06:48:28.538808	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
152	TXN166438	Jio	ONLINE	8768456758	11.0	SUCCESS	127	2025-09-09 06:52:25.368241	2025-09-09 06:52:25.368241	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
153	TXN421433	Jio	ONLINE	9090998778	1.0	SUCCESS	127	2025-09-09 08:05:14.835729	2025-09-09 08:05:14.835729	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
154	TXN989068	Vi	ONLINE	8873743264	229.0	SUCCESS	139	2025-09-09 09:00:04.916378	2025-09-09 09:00:04.916378	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
155	TXN252515	Jio	ONLINE	7676767676	10.0	SUCCESS	127	2025-09-09 13:10:00.134472	2025-09-09 13:10:00.134472	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
156	TXN713549	Jio	ONLINE	9978787676	299.0	SUCCESS	139	2025-09-09 13:11:04.824057	2025-09-09 13:11:04.824057	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
157	TXN249751	Jio	ONLINE	7697677698	199.0	SUCCESS	127	2025-09-09 13:54:42.225975	2025-09-09 13:54:42.225975	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
158	TXN120346	Jio	ONLINE	9034984798	299.0	SUCCESS	139	2025-09-09 13:55:11.517	2025-09-09 13:55:11.517	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
159	TXN685312	Jio	ONLINE	8969767687	20.0	SUCCESS	127	2025-09-09 13:56:46.749001	2025-09-09 13:56:46.749001	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
160	TXN501124	Jio	ONLINE	7897787787	1.0	SUCCESS	134	2025-09-09 14:12:39.059523	2025-09-09 14:12:39.059523	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
161	TXN639201	Jio	ONLINE	9879779787	12.0	SUCCESS	134	2025-09-09 16:38:51.449622	2025-09-09 16:38:51.449622	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
162	TXN248001	Jio	Mobile Recharge	787987778787	2.0	SUCCESS	134	2025-09-10 05:47:38.238908	2025-09-10 05:47:38.238908	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
163	TXN124168	Jio	Mobile Recharge	787987778787	2.0	SUCCESS	134	2025-09-10 05:53:43.171169	2025-09-10 05:53:43.171169	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
164	TXN668614	Jio	Mobile Recharge	787987778787	2.0	SUCCESS	134	2025-09-10 06:51:23.336111	2025-09-10 06:51:23.336111	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
165	TXN294955	Airtel	ONLINE	0978907898	2.0	SUCCESS	127	2025-09-10 06:57:55.166792	2025-09-10 06:57:55.166792	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
166	TXN212475	Jio	Mobile Recharge	787987778787	2.0	SUCCESS	134	2025-09-10 07:04:24.891643	2025-09-10 07:04:24.891643	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
167	TXN581251	Jio	Mobile Recharge	787987778787	0.5	SUCCESS	134	2025-09-10 07:54:37.976986	2025-09-10 07:54:37.976986	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
168	TXN879441	Jio	Mobile Recharge	89898877878	0.5	SUCCESS	134	2025-09-10 08:45:06.920316	2025-09-10 08:45:06.920316	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
169	TXN933030	Jio	Mobile Recharge	89898877878	0.5	SUCCESS	134	2025-09-10 08:52:55.857724	2025-09-10 08:52:55.857724	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
170	TXN931271	Jio	Mobile Recharge	89898877878	0.5	SUCCESS	134	2025-09-10 09:13:14.279833	2025-09-10 09:13:14.279833	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
171	TXN734167	Jio	Mobile Recharge	89898877878	0.5	SUCCESS	134	2025-09-10 09:34:46.744849	2025-09-10 09:34:46.744849	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
172	TXN755654	Jio	Mobile Recharge	89898977777	0.5	SUCCESS	134	2025-09-10 10:17:43.769943	2025-09-10 10:17:43.769943	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
173	TXN814227	Jio	Mobile Recharge	90900990909	0.5	SUCCESS	134	2025-09-10 10:38:27.425217	2025-09-10 10:38:27.425217	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
174	TXN228474	Airtel	\N	0988088098	2.0	SUCCESS	134	2025-09-10 12:21:21.90358	2025-09-10 12:21:21.90358	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
175	TXN203982	Airtel	\N	8765645645	22.0	SUCCESS	127	2025-09-10 12:29:34.652818	2025-09-10 12:29:34.652818	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
176	TXN889945	Jio	\N	7586758896	11.0	SUCCESS	127	2025-09-10 12:57:43.454721	2025-09-10 12:57:43.454721	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
177	TXN575336	Airtel	\N	7586758675	11.0	SUCCESS	127	2025-09-10 12:59:29.002969	2025-09-10 12:59:29.002969	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
178	TXN615156	Airtel	\N	9869869869	10.0	SUCCESS	127	2025-09-10 13:07:20.884092	2025-09-10 13:07:20.884092	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
179	TXN844985	Jio	\N	7697698689	8.0	SUCCESS	127	2025-09-10 13:11:29.503531	2025-09-10 13:11:29.503531	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
180	TXN869309	Jio	\N	5464646464	7.0	SUCCESS	127	2025-09-11 05:41:06.551229	2025-09-11 05:41:06.551229	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
181	TXN378844	Jio	\N	5765756756	1.0	SUCCESS	127	2025-09-11 06:51:20.978864	2025-09-11 06:51:20.978864	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
182	TXN328446	Jio	\N	5745756746	4.0	SUCCESS	127	2025-09-11 07:00:30.9748	2025-09-11 07:00:30.9748	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
183	TXN101178	Jio	\N	8768969869	1.0	SUCCESS	127	2025-09-11 07:03:06.255595	2025-09-11 07:03:06.255595	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
184	TXN613670	Jio	\N	7458697560	1.0	SUCCESS	127	2025-09-11 07:10:00.37594	2025-09-11 07:10:00.37594	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
185	TXN285126	Jio	\N	5464564556	1.0	SUCCESS	127	2025-09-11 07:26:50.256178	2025-09-11 07:26:50.256178	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
186	TXN451227	Vi	\N	7664567458	1.0	SUCCESS	127	2025-09-11 07:31:13.033061	2025-09-11 07:31:13.033061	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
187	TXN786844	Jio	\N	8798796986	1.0	SUCCESS	127	2025-09-11 07:35:38.454368	2025-09-11 07:35:38.454368	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
188	TXN450168	Jio	\N	7438578347	1.0	SUCCESS	127	2025-09-11 07:40:28.559514	2025-09-11 07:40:28.559514	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
189	TXN141978	Jio	\N	8756875465	1.0	SUCCESS	127	2025-09-11 07:41:36.377643	2025-09-11 07:41:36.377643	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
190	TXN730547	Jio	\N	9070979709	1.0	SUCCESS	127	2025-09-11 07:54:59.352708	2025-09-11 07:54:59.352708	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
191	TXN939768	Jio	\N	9070979709	1.0	SUCCESS	127	2025-09-11 07:56:05.821882	2025-09-11 07:56:05.821882	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
192	TXN391513	Jio	\N	9070979709	1.0	SUCCESS	127	2025-09-11 07:56:24.619032	2025-09-11 07:56:24.619032	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
193	TXN492587	Jio	\N	5565464654	1.0	SUCCESS	127	2025-09-11 08:39:25.227632	2025-09-11 08:39:25.227632	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
194	TXN397223	Jio	\N	5565464654	1.0	SUCCESS	127	2025-09-11 08:41:28.840778	2025-09-11 08:41:28.840778	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
195	TXN808869	Jio	\N	8787897878	1.0	SUCCESS	127	2025-09-11 08:44:47.812085	2025-09-11 08:44:47.812085	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
196	TXN873058	Jio	\N	8787987987	1.0	SUCCESS	127	2025-09-11 08:46:06.238012	2025-09-11 08:46:06.238012	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
197	TXN676243	Jio	\N	8787987987	1.0	SUCCESS	127	2025-09-11 08:46:33.148985	2025-09-11 08:46:33.148985	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
198	TXN521952	Jio	\N	8787987987	1.0	SUCCESS	127	2025-09-11 08:50:27.020339	2025-09-11 08:50:27.020339	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
199	TXN884495	Jio	\N	9076095807	1.0	SUCCESS	127	2025-09-11 08:51:39.268617	2025-09-11 08:51:39.268617	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
200	TXN257119	Airtel	RECHARGE	5687567567	1.0	SUCCESS	127	2025-09-11 10:58:28.876792	2025-09-11 10:58:28.876792	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
201	TXN205641	Jio	RECHARGE	6756757575	1.0	SUCCESS	127	2025-09-11 11:05:38.886778	2025-09-11 11:05:38.886778	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
202	TXN467878	Vi	RECHARGE	8778789789	19.0	SUCCESS	127	2025-09-11 12:29:53.212623	2025-09-11 12:29:53.212623	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
203	TXN482109	Jio	RECHARGE	6574657574	111.0	SUCCESS	127	2025-09-11 12:55:41.412242	2025-09-11 12:55:41.412242	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
204	TXN764000	Jio	RECHARGE	8769697677	1.0	SUCCESS	127	2025-09-11 13:33:13.689056	2025-09-11 13:33:13.689056	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
205	TXN722700	Airtel	RECHARGE	5475675757	249.0	SUCCESS	127	2025-09-11 13:51:22.509643	2025-09-11 13:51:22.509643	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
206	TXN948113	Airtel	RECHARGE	3453453535	11.0	SUCCESS	127	2025-09-12 07:06:53.361775	2025-09-12 07:06:53.361775	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
207	TXN668264	Jio	RECHARGE	8578978968	10.0	SUCCESS	127	2025-09-12 12:52:30.369447	2025-09-12 12:52:30.369447	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
208	TXN354579	Jio	RECHARGE	7999998897	78.0	SUCCESS	127	2025-09-15 05:32:09.762417	2025-09-15 05:32:09.762417	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
209	TXN134956	Airtel	RECHARGE	7989798789	249.0	SUCCESS	134	2025-09-15 17:31:19.254578	2025-09-15 17:31:19.254578	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
210	TXN722079	Jio	RECHARGE	9877987987	199.0	SUCCESS	134	2025-09-15 17:32:14.626233	2025-09-15 17:32:14.626233	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
211	TXN461921	Jio	Mobile Recharge	90900990909	0.5	SUCCESS	134	2025-09-16 11:49:52.933333	2025-09-16 11:49:52.933333	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
212	TXN787631	Jio	Mobile Recharge	90900990909	0.5	SUCCESS	134	2025-09-16 11:51:46.530596	2025-09-16 11:51:46.530596	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
214	TXN737928	Jio	Mobile Recharge	90900990909	0.5	SUCCESS	134	2025-09-16 12:14:40.142912	2025-09-16 12:14:40.142912	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
215	TXN317855	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:15:04.40333	2025-09-16 12:15:04.40333	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
216	TXN300830	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:21:57.758636	2025-09-16 12:21:57.758636	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
217	TXN645259	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:26:38.88992	2025-09-16 12:26:38.88992	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
218	TXN339807	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:34:46.87571	2025-09-16 12:34:46.87571	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
219	TXN398013	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:36:23.533953	2025-09-16 12:36:23.533953	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
222	TXN239080	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:47:18.865088	2025-09-16 12:47:18.865088	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
223	TXN519196	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:48:08.002008	2025-09-16 12:48:08.002008	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
224	TXN709457	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 12:49:56.624078	2025-09-16 12:49:56.624078	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
225	TXN613455	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 13:23:35.873272	2025-09-16 13:23:35.873272	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
226	TXN837690	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 13:25:41.610225	2025-09-16 13:25:41.610225	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
227	TXN226369	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-16 13:26:10.871114	2025-09-16 13:26:10.871114	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
228	TXN735894	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-16 13:26:53.523648	2025-09-16 13:26:53.523648	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
229	TXN800767	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-16 13:28:18.75625	2025-09-16 13:28:18.75625	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
230	TXN794781	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-16 13:30:11.323746	2025-09-16 13:30:11.323746	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
231	TXN534069	Airtel	RECHARGE	0567506756	300.0	SUCCESS	127	2025-09-16 13:44:22.113514	2025-09-16 13:44:22.113514	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
233	TXN713846	Jio	Mobile Recharge	90900990909	56.0	SUCCESS	127	2025-09-16 13:46:47.474368	2025-09-16 13:46:47.474368	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
234	TXN842391	Jio	RECHARGE	8758646754	300.0	SUCCESS	127	2025-09-16 13:52:52.408975	2025-09-16 13:52:52.408975	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
235	TXN704415	Jio	RECHARGE	7796769669	300.0	SUCCESS	127	2025-09-16 13:55:46.961427	2025-09-16 13:55:46.961427	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
236	TXN202588	Jio	RECHARGE	8945689456	300.0	SUCCESS	127	2025-09-16 13:57:09.975787	2025-09-16 13:57:09.975787	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
250	TXN816699	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:27:19.635547	2025-09-16 18:27:19.635547	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
251	TXN774851	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:27:28.360533	2025-09-16 18:27:28.360533	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
252	TXN617962	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:27:43.614023	2025-09-16 18:27:43.614023	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
255	TXN406027	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:37:51.654406	2025-09-16 18:37:51.654406	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
257	TXN180359	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:41:26.852442	2025-09-16 18:41:26.852442	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
258	TXN842031	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-16 18:42:35.236836	2025-09-16 18:42:35.236836	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
259	TXN882156	Jio	RECHARGE	5657567576	200.0	SUCCESS	127	2025-09-17 04:47:49.450049	2025-09-17 04:47:49.450049	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
260	TXN838072	Jio	RECHARGE	0856745769	200.0	SUCCESS	127	2025-09-17 05:04:20.218995	2025-09-17 05:04:20.218995	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
261	TXN295166	Jio	RECHARGE	0947695479	52.0	SUCCESS	127	2025-09-17 05:12:23.77691	2025-09-17 05:12:23.77691	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
262	TXN958369	Jio	Mobile Recharge	90900990909	300.0	SUCCESS	134	2025-09-17 06:54:00.706193	2025-09-17 06:54:00.706193	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
263	TXN833807	Jio	RECHARGE	8934589436	200.0	SUCCESS	127	2025-09-17 07:20:05.650515	2025-09-17 07:20:05.650515	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
264	TXN622002	Jio	RECHARGE	5654645645	200.0	SUCCESS	127	2025-09-17 07:22:58.424074	2025-09-17 07:22:58.424074	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
265	TXN807687	Airtel	RECHARGE	5745675467	500.0	SUCCESS	127	2025-09-17 07:23:39.606543	2025-09-17 07:23:39.606543	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
266	TXN319177	Airtel	RECHARGE	8687966796	500.0	SUCCESS	127	2025-09-17 07:25:57.970954	2025-09-17 07:25:57.970954	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
267	TXN295019	Airtel	RECHARGE	5656765756	500.0	SUCCESS	139	2025-09-17 07:27:40.871936	2025-09-17 07:27:40.871936	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
268	TXN784529	Airtel	RECHARGE	8787878978	500.0	SUCCESS	127	2025-09-17 07:54:09.134099	2025-09-17 07:54:09.134099	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
269	TXN465639	Airtel	RECHARGE	7456756756	500.0	SUCCESS	127	2025-09-17 07:55:10.723613	2025-09-17 07:55:10.723613	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
270	TXN672407	Jio	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 08:33:26.703938	2025-09-17 08:33:26.703938	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
271	TXN740032	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 08:33:45.028439	2025-09-17 08:33:45.028439	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
272	TXN258651	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 08:44:53.65969	2025-09-17 08:44:53.65969	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
274	TXN811268	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 08:48:03.601258	2025-09-17 08:48:03.601258	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
275	TXN596076	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 08:49:14.105294	2025-09-17 08:49:14.105294	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
276	TXN599264	Airtel	RECHARGE	4645654654	300.0	SUCCESS	127	2025-09-17 08:51:14.251345	2025-09-17 08:51:14.251345	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
277	TXN364943	Jio	RECHARGE	8789758675	300.0	SUCCESS	127	2025-09-17 08:51:57.624669	2025-09-17 08:51:57.624669	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
278	TXN607953	Jio	RECHARGE	8785658765	300.0	SUCCESS	127	2025-09-17 08:53:05.440148	2025-09-17 08:53:05.440148	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
279	TXN420215	Airtel	RECHARGE	8966986896	292.0	SUCCESS	139	2025-09-17 08:56:17.15513	2025-09-17 08:56:17.15513	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
280	TXN208381	Jio	RECHARGE	8697697787	300.0	SUCCESS	139	2025-09-17 08:57:43.969877	2025-09-17 08:57:43.969877	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
281	TXN834330	Jio	RECHARGE	7764567056	15.0	SUCCESS	127	2025-09-17 09:19:00.912416	2025-09-17 09:19:00.912416	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
282	TXN122653	Airtel	RECHARGE	8767867867	200.0	SUCCESS	127	2025-09-17 09:35:50.907701	2025-09-17 09:35:50.907701	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
283	TXN832440	Jio	RECHARGE	8976695656	10.0	SUCCESS	127	2025-09-17 09:46:34.617237	2025-09-17 09:46:34.617237	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
284	TXN489650	Jio	RECHARGE	7567586975	100.0	SUCCESS	127	2025-09-17 09:48:16.278247	2025-09-17 09:48:16.278247	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
285	TXN214259	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 10:13:05.935248	2025-09-17 10:13:05.935248	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
286	TXN593081	Jio	RECHARGE	3454534534	100.0	SUCCESS	127	2025-09-17 10:26:43.701329	2025-09-17 10:26:43.701329	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
295	TXN903636	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 10:41:26.622673	2025-09-17 10:41:26.622673	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
296	TXN433465	Jio	RECHARGE	5686585685	10.0	SUCCESS	127	2025-09-17 10:41:58.333323	2025-09-17 10:41:58.333323	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
297	TXN737030	Jio	RECHARGE	3423423423	120.0	SUCCESS	127	2025-09-17 10:42:39.982348	2025-09-17 10:42:39.982348	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
308	TXN722291	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 10:51:05.168523	2025-09-17 10:51:05.168523	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
309	TXN364761	Vi	RECHARGE	5654656456	10.0	SUCCESS	127	2025-09-17 10:51:19.628799	2025-09-17 10:51:19.628799	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
310	TXN315212	Jio	RECHARGE	9845867567	12.0	SUCCESS	127	2025-09-17 10:51:49.49754	2025-09-17 10:51:49.49754	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
311	TXN143694	Airtel	RECHARGE	8687658785	50.0	SUCCESS	127	2025-09-17 10:52:17.969768	2025-09-17 10:52:17.969768	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
312	TXN689981	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 10:54:47.842512	2025-09-17 10:54:47.842512	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
313	TXN258064	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-17 10:57:09.312588	2025-09-17 10:57:09.312588	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
314	TXN269648	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-17 10:58:01.783852	2025-09-17 10:58:01.783852	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
315	TXN724817	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-17 10:59:57.631788	2025-09-17 10:59:57.631788	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
316	TXN615646	Airtel	Mobile Recharge	90900990909	300.0	SUCCESS	127	2025-09-17 11:00:17.213265	2025-09-17 11:00:17.213265	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
317	TXN214319	Jio	RECHARGE	0958765675	200.0	SUCCESS	127	2025-09-17 11:26:43.713611	2025-09-17 11:26:43.713611	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
318	TXN256499	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-17 11:36:04.041119	2025-09-17 11:36:04.041119	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
319	TXN159094	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-17 11:37:06.513151	2025-09-17 11:37:06.513151	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
320	TXN669987	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-17 11:37:27.281698	2025-09-17 11:37:27.281698	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
321	TXN625722	Jio	RECHARGE	9876896869	100.0	SUCCESS	127	2025-09-17 11:39:20.104412	2025-09-17 11:39:20.104412	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
322	TXN400351	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 11:41:47.51083	2025-09-17 11:41:47.51083	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
324	TXN888029	Airtel	RECHARGE	9097689768	100.0	SUCCESS	127	2025-09-17 11:48:12.222171	2025-09-17 11:48:12.222171	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
323	TXN616112	Jio	RECHARGE	7687676767	100.0	SUCCESS	127	2025-09-17 11:43:19.831598	2025-09-17 11:43:19.831598	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
325	TXN103156	Jio	RECHARGE	9789669767	100.0	SUCCESS	127	2025-09-17 12:28:54.970953	2025-09-17 12:28:54.970953	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
326	TXN609571	Airtel	RECHARGE	8784685486	200.0	SUCCESS	127	2025-09-17 12:29:36.34278	2025-09-17 12:29:36.34278	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
327	TXN564454	Airtel	RECHARGE	1000789789	200.0	SUCCESS	127	2025-09-17 12:31:10.357063	2025-09-17 12:31:10.357063	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
328	TXN399632	Airtel	RECHARGE	8968776587	100.0	SUCCESS	127	2025-09-17 12:32:22.390778	2025-09-17 12:32:22.390778	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
329	TXN806740	Airtel	RECHARGE	6796986976	100.0	SUCCESS	127	2025-09-17 13:07:40.843607	2025-09-17 13:07:40.843607	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
330	TXN956273	Vi	RECHARGE	5465464565	100.0	SUCCESS	127	2025-09-17 13:21:12.841464	2025-09-17 13:21:12.841464	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
331	TXN546292	Jio	RECHARGE	6585675675	200.0	SUCCESS	127	2025-09-17 13:21:37.296395	2025-09-17 13:21:37.296395	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
332	TXN258548	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 13:27:11.700797	2025-09-17 13:27:11.700797	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
333	TXN961809	Airtel	Mobile Recharge	90900990909	100.0	SUCCESS	127	2025-09-17 13:32:55.517983	2025-09-17 13:32:55.517983	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
334	TXN381293	Jio	RECHARGE	6796786786	100.0	SUCCESS	127	2025-09-17 13:56:34.152287	2025-09-17 13:56:34.152287	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
335	TXN210593	Airtel	RECHARGE	6786786787	100.0	SUCCESS	127	2025-09-17 13:57:11.842682	2025-09-17 13:57:11.842682	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
336	TXN431514	Jio	RECHARGE	0947569697	100.0	SUCCESS	127	2025-09-18 06:55:53.673028	2025-09-18 06:55:53.673028	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
338	TXN413777	Jio	RECHARGE	4645645645	199.0	SUCCESS	127	2025-09-18 07:17:06.526147	2025-09-18 07:17:06.526147	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
339	TXN837088	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:23:23.735867	2025-09-18 07:23:23.735867	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
340	TXN275214	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:24:08.868119	2025-09-18 07:24:08.868119	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
341	TXN335281	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:33:40.636773	2025-09-18 07:33:40.636773	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
342	TXN476639	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:34:19.027779	2025-09-18 07:34:19.027779	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
343	TXN654151	Airtel	Mobile Recharge	90900990909	1.0	SUCCESS	127	2025-09-18 07:36:21.332997	2025-09-18 07:36:21.332997	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
344	TXN557708	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-18 07:50:43.336924	2025-09-18 07:50:43.336924	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
345	TXN920846	Airtel	RECHARGE	9893738632	200.0	SUCCESS	139	2025-09-18 08:37:43.504628	2025-09-18 08:37:43.504628	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
346	TXN857094	Airtel	RECHARGE	7867876868	100.0	SUCCESS	127	2025-09-18 11:23:48.925907	2025-09-18 11:23:48.925907	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
347	TXN126455	Jio	RECHARGE	9878867676	300.0	SUCCESS	139	2025-09-18 13:10:04.597224	2025-09-18 13:10:04.597224	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
348	TXN373443	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-19 10:56:34.351964	2025-09-19 10:56:34.351964	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
349	TXN866337	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-19 11:07:44.341036	2025-09-19 11:07:44.341036	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
350	TXN581792	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-19 11:08:08.930916	2025-09-19 11:08:08.930916	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
351	TXN950125	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	127	2025-09-19 11:12:30.625876	2025-09-19 11:12:30.625876	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
352	TXN111597	Jio	RECHARGE	8789795666	200.0	SUCCESS	127	2025-09-19 11:49:50.1497	2025-09-19 11:49:50.1497	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
353	TXN873815	Airtel	RECHARGE	6756756756	399.0	SUCCESS	127	2025-09-19 11:50:50.760418	2025-09-19 11:50:50.760418	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
354	TXN174533	Airtel	Mobile Recharge	90900990909	200.0	SUCCESS	134	2025-09-19 12:06:30.304773	2025-09-19 12:06:30.304773	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
355	TXN832000	Airtel	RECHARGE	9079675870	200.0	SUCCESS	127	2025-09-19 12:23:11.994069	2025-09-19 12:23:11.994069	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
356	TXN912606	Jio	RECHARGE	9856709480	199.0	SUCCESS	127	2025-09-19 14:06:31.428042	2025-09-19 14:06:31.428042	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
357	TXN245306	Airtel	Recharge	8797097907	11.0	SUCCESS	127	2025-10-06 09:41:41.341071	2025-10-06 09:41:41.341071	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
358	TXN231150	Airtel	Recharge	5646456456	22.0	SUCCESS	127	2025-10-06 10:39:35.422369	2025-10-06 10:39:35.422369	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
359	TXN831028	Airtel	Recharge	5646456456	22.0	SUCCESS	127	2025-10-06 10:40:08.933789	2025-10-06 10:40:08.933789	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
360	TXN745161	Vi	Recharge	7686786786	77.0	SUCCESS	127	2025-10-06 10:43:31.603325	2025-10-06 10:43:31.603325	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
361	TXN164805	Airtel	Recharge	9869869868	101.0	SUCCESS	127	2025-10-06 10:49:28.553372	2025-10-06 10:49:28.553372	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
362	TXN317123	Jio	Recharge	0878979868	33.0	SUCCESS	127	2025-10-06 10:53:49.242841	2025-10-06 10:53:49.242841	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
363	TXN818959	Airtel	Recharge	8787987899	74.0	SUCCESS	127	2025-10-06 10:56:21.434755	2025-10-06 10:56:21.434755	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
364	TXN313395	Airtel	Recharge	6756756756	19.0	SUCCESS	127	2025-10-06 10:57:28.890519	2025-10-06 10:57:28.890519	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
365	TXN578523	Jio	Recharge	8878897897	1.0	SUCCESS	127	2025-10-06 11:02:43.928536	2025-10-06 11:02:43.928536	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
366	TXN144802	Airtel	Recharge	8979878997	77.0	SUCCESS	127	2025-10-06 11:09:27.440087	2025-10-06 11:09:27.440087	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
367	TXN321619	Vi	Recharge	0789787897	74.0	SUCCESS	127	2025-10-06 12:06:40.065768	2025-10-06 12:06:40.065768	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
368	TXN114782	Airtel	Recharge	7657567567	64.0	SUCCESS	127	2025-10-06 12:27:25.446375	2025-10-06 12:27:25.446375	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
369	TXN708578	Airtel	Recharge	7657567567	64.0	SUCCESS	127	2025-10-06 12:29:21.142627	2025-10-06 12:29:21.142627	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
370	TXN816002	Airtel	Recharge	8765769585	11.0	SUCCESS	127	2025-10-06 13:57:05.318322	2025-10-06 13:57:05.318322	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
371	TXN775394	Jio	Recharge	9809979878	199.0	SUCCESS	127	2025-10-06 14:30:22.518824	2025-10-06 14:30:22.518824	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
372	TXN127209	Airtel	Recharge	6876768767	499.0	SUCCESS	127	2025-10-06 14:31:37.246665	2025-10-06 14:31:37.246665	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
373	TXN534958	Jio	Recharge	8789798789	199.0	SUCCESS	127	2025-10-08 10:49:30.749	2025-10-08 10:49:30.749	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
374	TXN587955	tatasky	Recharge	9305096443	299.0	SUCCESS	127	2025-10-08 11:38:41.244593	2025-10-08 11:38:41.244593	11	Manikant	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
375	TXN501019	tatasky	Recharge	9305096443	299.0	SUCCESS	127	2025-10-08 11:38:42.82335	2025-10-08 11:38:42.82335	11	Manikant	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
376	TXN702943	Airtel	Recharge	4543534534	10.0	SUCCESS	127	2025-10-08 11:43:35.019476	2025-10-08 11:43:35.019476	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
377	TXN222395	den	Recharge	9878796898	250.0	SUCCESS	127	2025-10-08 11:44:35.690145	2025-10-08 11:44:35.690145	11	Manikant	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
378	TXN919532	airtel	Recharge	7658767578	399.0	SUCCESS	127	2025-10-08 12:41:08.121375	2025-10-08 12:41:08.121375	11	dsgdsg	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
379	TXN848494	den	Recharge	43534534534	250.0	SUCCESS	127	2025-10-08 12:41:54.440689	2025-10-08 12:41:54.440689	11	Manikant	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
380	TXN264261	tatasky	Recharge	7658767578	299.0	SUCCESS	127	2025-10-08 13:30:56.444845	2025-10-08 13:30:56.444845	11	sid	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
381	TXN450314	tatasky	Recharge	77458734873	499.0	SUCCESS	127	2025-10-10 06:56:38.071714	2025-10-10 06:56:38.071714	11	78974389578	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
382	TXN531411	Airtel	Recharge	9867867896	67.0	SUCCESS	127	2025-10-10 13:08:42.604366	2025-10-10 13:08:42.604366	11	jjdd	\N	\N	878979898789	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
383	TXN769083	Airtel	Recharge	6575675675	121.0	SUCCESS	127	2025-10-10 13:12:23.144468	2025-10-10 13:12:23.144468	11	sdsfdsf	\N	\N	435345	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
384	TXN222169	Airtel	Recharge	3434535344	234.0	SUCCESS	127	2025-10-10 13:13:54.695201	2025-10-10 13:13:54.695201	11	fsd	\N	\N	dfg	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
385	TXN633219	Airtel	Recharge	6766876767	565.0	SUCCESS	127	2025-10-10 13:17:47.406264	2025-10-10 13:17:47.406264	11	kjgh	\N	\N	u67678	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
386	TXN823470	tatasky	Recharge	65757576657	199.0	SUCCESS	127	2025-10-31 07:51:57.251346	2025-10-31 07:51:57.251346	11	dfds	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
387	TXN897237	Airtel	Recharge	6575676575	1.0	SUCCESS	127	2025-10-31 09:08:35.116558	2025-10-31 09:08:35.116558	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
388	TXN544373	airtel	Recharge	999999999999	199.0	SUCCESS	127	2025-10-31 09:18:56.807174	2025-10-31 09:18:56.807174	11	sid	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
389	TXN180906	tatasky	Recharge	9878796898	199.0	SUCCESS	127	2025-10-31 09:36:19.173447	2025-10-31 09:36:19.173447	11	6876867867867	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
390	TXN865821	videocon	Recharge	42042099999	299.0	SUCCESS	127	2025-10-31 10:16:28.941176	2025-10-31 10:16:28.941176	11	sidwa	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
391	TXN675657	Airtel	Recharge	9879889789	600.0	SUCCESS	127	2025-10-31 10:19:36.449568	2025-10-31 10:19:36.449568	11	sdsfdsf	\N	778	43534	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
392	TXN192228	dish	Recharge	77777777777	199.0	SUCCESS	127	2025-10-31 10:24:56.575391	2025-10-31 10:24:56.575391	11	manikant	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
393	TXN896192	dish	Recharge	7554745654645645646	699.0	SUCCESS	127	2025-10-31 12:31:17.724301	2025-10-31 12:31:17.724301	11	manikant	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
394	TXN408150	Jio	Recharge	9789877977	199.0	SUCCESS	127	2025-10-31 12:37:00.438311	2025-10-31 12:37:00.438311	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
395	TXN383545	tatasky	Recharge	88778787777	699.0	SUCCESS	127	2025-10-31 12:38:23.146166	2025-10-31 12:38:23.146166	11	sid	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
396	TXN311823	Jio	recharge	9876543210	100.0	SUCCESS	139	2025-11-06 06:01:37.515123	2025-11-06 06:01:37.515123	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
397	TXN860303	jdnsj	recharge	8317082162	3.0	SUCCESS	139	2025-11-07 10:25:19.570161	2025-11-07 10:25:19.570161	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
398	TXN671334	jdnsj	recharge	8317082162	3.0	SUCCESS	139	2025-11-10 05:57:23.671294	2025-11-10 05:57:23.671294	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
399	TXN569284	jdnsj	recharge	8317082162	3.0	SUCCESS	139	2025-11-10 05:57:37.779108	2025-11-10 05:57:37.779108	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
400	TXN802653	Home Loan	recharge	7897977987	1.0	SUCCESS	139	2025-11-10 09:46:02.586631	2025-11-10 09:46:02.586631	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
401	TXN365695	Home loan	recharge	78979798979	12000.0	SUCCESS	139	2025-11-10 09:52:21.428889	2025-11-10 09:52:21.428889	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
402	TXN175393	Home loan	recharge	78979798979	12000.0	SUCCESS	139	2025-11-10 09:59:27.970947	2025-11-10 09:59:27.970947	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
403	TXN233450	formData?.loanType	recharge	formData?.mobile 	12000.0	SUCCESS	139	2025-11-10 10:24:13.509782	2025-11-10 10:24:13.509782	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
404	TXN929626	car	recharge	9787987987	12000.0	SUCCESS	139	2025-11-10 10:27:10.673668	2025-11-10 10:27:10.673668	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
405	TXN428323	car	recharge	3647832638	3.0	SUCCESS	139	2025-11-10 10:37:38.535663	2025-11-10 10:37:38.535663	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
406	TXN838168	card	recharge	8317082162	3.0	SUCCESS	139	2025-11-10 11:50:28.842065	2025-11-10 11:50:28.842065	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
407	TXN744613	card	recharge	8317082162	3.0	SUCCESS	139	2025-11-10 11:51:27.920393	2025-11-10 11:51:27.920393	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
408	TXN703110	card	recharge	8317082162	11.0	SUCCESS	139	2025-11-10 12:01:40.077196	2025-11-10 12:01:40.077196	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
409	TXN428551	card	recharge	8317082162	11.0	SUCCESS	139	2025-11-10 12:03:34.638583	2025-11-10 12:03:34.638583	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
410	TXN911165	card	recharge	8317082162	3.0	SUCCESS	139	2025-11-10 12:05:02.000793	2025-11-10 12:05:02.000793	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
411	TXN203838	card	recharge	8317082162	2.0	SUCCESS	139	2025-11-10 12:25:52.489427	2025-11-10 12:25:52.489427	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
412	TXN203856	car	recharge	5656776788	23.0	SUCCESS	139	2025-11-10 12:57:59.772418	2025-11-10 12:57:59.772418	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
413	TXN287160	card	recharge	8317082162	12.0	SUCCESS	139	2025-11-10 12:59:37.399986	2025-11-10 12:59:37.399986	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
414	TXN820098	car	recharge	8789789798	12000.0	SUCCESS	139	2025-11-11 07:26:52.465189	2025-11-11 07:26:52.465189	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
415	TXN149161	home	recharge	9878977979	19.0	SUCCESS	139	2025-11-11 07:30:18.145737	2025-11-11 07:30:18.145737	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
416	TXN927898	home	recharge	8797979797	115.0	SUCCESS	139	2025-11-11 07:39:47.341591	2025-11-11 07:39:47.341591	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
417	TXN181213	HDFC	recharge	8317082162	2.0	SUCCESS	139	2025-11-11 07:51:47.283573	2025-11-11 07:51:47.283573	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
418	TXN942586	HDFC	recharge	8317082162	13.0	SUCCESS	139	2025-11-11 08:38:34.899114	2025-11-11 08:38:34.899114	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
419	TXN222969	home	recharge	5675675656	12.0	SUCCESS	139	2025-11-11 08:40:09.782256	2025-11-11 08:40:09.782256	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
420	TXN259524	SBI	recharge	8317082162	4.0	SUCCESS	139	2025-11-11 08:42:17.798678	2025-11-11 08:42:17.798678	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
421	TXN377693	card	recharge	8317082162	11.0	SUCCESS	139	2025-11-11 08:55:35.131718	2025-11-11 08:55:35.131718	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
422	TXN108726	SBI	recharge	8317082162	22.0	SUCCESS	139	2025-11-11 08:58:37.888657	2025-11-11 08:58:37.888657	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
423	TXN201913	SBI	recharge	8317082162	22.0	SUCCESS	139	2025-11-11 08:58:39.963871	2025-11-11 08:58:39.963871	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
424	TXN492652	SBI	recharge	8317082162	22.0	SUCCESS	139	2025-11-11 08:58:50.658767	2025-11-11 08:58:50.658767	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
425	TXN368948	SBI	recharge	8317082162	22.0	SUCCESS	139	2025-11-11 09:00:55.70327	2025-11-11 09:00:55.70327	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
426	TXN339028	SBI	recharge	8317082162	20.0	SUCCESS	139	2025-11-11 09:07:52.464237	2025-11-11 09:07:52.464237	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
427	TXN630314	SBI	recharge	8317082162	20.0	SUCCESS	139	2025-11-11 09:11:25.248698	2025-11-11 09:11:25.248698	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
428	TXN802359	car	recharge	8978797979	11.0	SUCCESS	139	2025-11-11 09:28:15.35052	2025-11-11 09:28:15.35052	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
429	TXN591431	car	recharge	8317082162	10.0	SUCCESS	139	2025-11-11 09:39:51.879738	2025-11-11 09:39:51.879738	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
430	TXN851173	card	recharge	8317082162	12.0	SUCCESS	139	2025-11-11 09:41:35.676026	2025-11-11 09:41:35.676026	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
431	TXN996339	SBI	recharge	8317082162	9.0	SUCCESS	139	2025-11-11 09:46:14.714277	2025-11-11 09:46:14.714277	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
432	TXN151889	XYZ	rent_payment	8317082162	11.0	SUCCESS	139	2025-11-11 10:50:21.25823	2025-11-11 10:50:21.25823	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
433	TXN198742	XYZ	rent_payment	8317082162	11.0	SUCCESS	139	2025-11-11 10:50:51.881876	2025-11-11 10:50:51.881876	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
434	TXN133148	XYZ	rent_payment	8317082162	11.0	SUCCESS	139	2025-11-11 10:51:42.094304	2025-11-11 10:51:42.094304	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
435	TXN894008	card	recharge	8317082162	10.0	SUCCESS	139	2025-11-11 11:40:22.69323	2025-11-11 11:40:22.69323	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
436	TXN667857	car	recharge	8796767867	118.0	SUCCESS	139	2025-11-11 11:43:40.732551	2025-11-11 11:43:40.732551	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
437	TXN986792	SBI	recharge	8317082162	22.0	SUCCESS	139	2025-11-11 11:53:12.626387	2025-11-11 11:53:12.626387	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
438	TXN578982	SBI	recharge	8317082162	22.0	SUCCESS	139	2025-11-11 11:53:17.528071	2025-11-11 11:53:17.528071	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
439	TXN633737	SBI	recharge	8317082162	22.0	SUCCESS	139	2025-11-11 11:53:18.569798	2025-11-11 11:53:18.569798	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
440	TXN871563	SBI	recharge	8985662189	1111.0	SUCCESS	139	2025-11-11 12:07:30.571105	2025-11-11 12:07:30.571105	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
441	TXN362961	ICICI	recharge	8317082162	20.0	SUCCESS	139	2025-11-11 12:11:52.586012	2025-11-11 12:11:52.586012	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
442	TXN480536	ICICI	recharge	8317082162	20.0	SUCCESS	139	2025-11-11 12:12:35.201269	2025-11-11 12:12:35.201269	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
443	TXN597213	personal	recharge	4738473843	3.0	SUCCESS	139	2025-11-11 12:36:46.969909	2025-11-11 12:36:46.969909	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
444	TXN287455	education	recharge	8778787788	10.0	SUCCESS	139	2025-11-12 05:07:32.770652	2025-11-12 05:07:32.770652	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
445	TXN672392	card	recharge	8317082162	44.0	SUCCESS	139	2025-11-12 05:33:09.664706	2025-11-12 05:33:09.664706	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
446	TXN629632	card	recharge	8317082162	44.0	SUCCESS	139	2025-11-12 05:33:14.329163	2025-11-12 05:33:14.329163	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
447	TXN741425	card	recharge	8317082162	44.0	SUCCESS	139	2025-11-12 05:36:13.734323	2025-11-12 05:36:13.734323	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
448	TXN124283	card	recharge	8317082162	44.0	SUCCESS	139	2025-11-12 05:38:11.379147	2025-11-12 05:38:11.379147	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
449	TXN633644	card	recharge	8317082162	44.0	SUCCESS	139	2025-11-12 05:42:21.96207	2025-11-12 05:42:21.96207	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
450	TXN400493	card	recharge	8317082162	44.0	SUCCESS	139	2025-11-12 05:47:46.159031	2025-11-12 05:47:46.159031	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
451	TXN171210	card	recharge	8317082162	44.0	SUCCESS	139	2025-11-12 05:47:53.247499	2025-11-12 05:47:53.247499	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
452	TXN279616	card	recharge	8317082162	22.0	SUCCESS	139	2025-11-12 05:51:38.025778	2025-11-12 05:51:38.025778	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
453	TXN828738	card	recharge	8317082162	22.0	SUCCESS	139	2025-11-12 05:53:44.596112	2025-11-12 05:53:44.596112	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
454	TXN947269	card	recharge	8317082162	22.0	SUCCESS	139	2025-11-12 05:57:50.927938	2025-11-12 05:57:50.927938	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
455	TXN395394	card	recharge	8317082162	22.0	SUCCESS	139	2025-11-12 05:58:23.630456	2025-11-12 05:58:23.630456	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
456	TXN809534	card	recharge	8317082162	22.0	SUCCESS	139	2025-11-12 05:59:10.201111	2025-11-12 05:59:10.201111	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
457	TXN245757	XYZ	rent_payment	8512638972	11.0	SUCCESS	139	2025-11-12 06:00:27.250263	2025-11-12 06:00:27.250263	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
458	TXN904673	XYZ	rent_payment	8317082162	200.0	SUCCESS	139	2025-11-12 06:20:41.055514	2025-11-12 06:20:41.055514	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
459	TXN930133	XYZ	rent_payment	8317082162	200.0	SUCCESS	139	2025-11-12 06:22:30.385334	2025-11-12 06:22:30.385334	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
460	TXN212213	XYZ	rent_payment	8317082162	200.0	SUCCESS	139	2025-11-12 06:25:30.00396	2025-11-12 06:25:30.00396	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
461	TXN370417	XYZ	rent_payment	8317082162	200.0	SUCCESS	139	2025-11-12 06:26:33.178943	2025-11-12 06:26:33.178943	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
462	TXN212520	XYZ	rent_payment	8317082162	200.0	SUCCESS	139	2025-11-12 06:27:49.774947	2025-11-12 06:27:49.774947	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
463	TXN321212	XYZ	rent_payment	8317082162	100.0	SUCCESS	139	2025-11-12 06:29:34.157056	2025-11-12 06:29:34.157056	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
464	TXN186942	card	recharge	8317082162	2.0	SUCCESS	139	2025-11-12 06:34:32.202631	2025-11-12 06:34:32.202631	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
465	TXN577054	HDFC	recharge	8317082162	20.0	SUCCESS	139	2025-11-12 06:39:34.594544	2025-11-12 06:39:34.594544	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
466	TXN442825	XYZ	rent_payment	8317082162	20.0	SUCCESS	139	2025-11-12 07:50:01.109494	2025-11-12 07:50:01.109494	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
467	TXN512279	home	recharge	8888888888	111.0	SUCCESS	139	2025-11-12 10:29:25.705041	2025-11-12 10:29:25.705041	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
468	TXN186824	Jio	Recharge	5555555555	199.0	SUCCESS	139	2025-11-12 10:38:22.692393	2025-11-12 10:38:22.692393	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
469	TXN617827	Airtel	Recharge	8317082162	12.0	SUCCESS	139	2025-11-12 10:39:16.043253	2025-11-12 10:39:16.043253	14	gdgdf	\N	7899878979	7987897897879	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
470	TXN812819	tatasky	Recharge	8317082162	399.0	SUCCESS	139	2025-11-12 10:39:52.503472	2025-11-12 10:39:52.503472	14	tryryry	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
471	TXN370982	personal	recharge	5555555555	88.0	SUCCESS	139	2025-11-12 12:08:33.242922	2025-11-12 12:08:33.242922	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
472	TXN174574	car	recharge	8594622322	13.0	SUCCESS	139	2025-11-12 12:10:12.804924	2025-11-12 12:10:12.804924	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
473	TXN107610	education	recharge	8317082162	90.0	SUCCESS	139	2025-11-12 12:12:00.079841	2025-11-12 12:12:00.079841	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
474	TXN519254	HDFC	recharge	8317082162	20.0	SUCCESS	139	2025-11-12 12:12:50.614919	2025-11-12 12:12:50.614919	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
475	TXN314630	Jio	Recharge	5555555555	299.0	SUCCESS	139	2025-11-13 06:39:22.293062	2025-11-13 06:39:22.293062	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
476	TXN123610	Airtel	Recharge	8317082162	41.0	SUCCESS	139	2025-11-13 06:42:36.472648	2025-11-13 06:42:36.472648	15	gdgdf	\N	7899878979	7987897897879	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
477	TXN964079	Jio	Recharge	8317082162	11.0	SUCCESS	139	2025-11-13 06:45:23.868013	2025-11-13 06:45:23.868013	15	gdgdf	\N	7899878979	7987897897879	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
478	TXN615607	Jio	Recharge	8317082162	22.0	SUCCESS	139	2025-11-13 06:52:29.018666	2025-11-13 06:52:29.018666	15	ytyjtytjty	\N	7899878979	7987897897879	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
479	TXN431904	BSNL	Recharge	8317082162	120.0	SUCCESS	139	2025-11-13 07:34:12.213603	2025-11-13 07:34:12.213603	12	manikant	\N	122222	8888888888888888	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
480	TXN422978	Jio	Recharge	8317082162	90.0	SUCCESS	139	2025-11-13 08:52:42.539438	2025-11-13 08:52:42.539438	12	manikant	\N	7899878979	7987897897879	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
481	TXN492189	Airtel	Recharge	8317082162	200.0	SUCCESS	139	2025-11-13 08:55:51.268098	2025-11-13 08:55:51.268098	12	manikant	\N	7899878979	7987897897879	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
482	TXN367691	Jio	Recharge	8317082162	20.0	SUCCESS	139	2025-11-13 08:58:53.038026	2025-11-13 08:58:53.038026	12	manikant	\N	7899878979	7987897897879	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
483	TXN653807	home	recharge	3333333333	2.0	SUCCESS	139	2025-11-13 09:20:15.170428	2025-11-13 09:20:15.170428	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
484	TXN556877	home	recharge	5555555555	1.0	SUCCESS	139	2025-11-13 09:30:27.877339	2025-11-13 09:30:27.877339	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
485	TXN825734	tatasky	Recharge	8317082162	199.0	SUCCESS	139	2025-11-13 10:03:40.46614	2025-11-13 10:03:40.46614	13	tryryry	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
486	TXN772200	dish	Recharge	1111111	399.0	SUCCESS	139	2025-11-13 11:50:05.117442	2025-11-13 11:50:05.117442	13	amiyyyyy	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
487	TXN345862	airtel	Recharge	8317082162	199.0	SUCCESS	139	2025-11-13 12:24:35.809463	2025-11-13 12:24:35.809463	13	sonam mam	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
488	TXN962589	Airtel	Recharge	2222222222	1089.54	SUCCESS	139	2025-11-14 10:12:19.392367	2025-11-14 10:12:19.392367	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
489	TXN271082	Delhi Water Board	Recharge	4443434433	1089.54	SUCCESS	139	2025-11-14 10:15:01.255815	2025-11-14 10:15:01.255815	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
490	TXN752922	Delhi Water Board	Recharge	9999999999	1089.54	SUCCESS	139	2025-11-14 10:28:23.177153	2025-11-14 10:28:23.177153	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
491	TXN145963	Delhi Water Board	Recharge	9999999999	1089.54	SUCCESS	139	2025-11-14 11:00:35.018674	2025-11-14 11:00:35.018674	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
492	TXN331405	Mumbai Water Board	Recharge	4444444444	1089.54	SUCCESS	139	2025-11-14 12:28:27.910412	2025-11-14 12:28:27.910412	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
493	TXN172156	car	recharge	8888888888	90.0	SUCCESS	139	2025-11-17 06:04:21.312931	2025-11-17 06:04:21.312931	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
494	TXN416498	SBI	recharge	9852222222	88.0	SUCCESS	139	2025-11-17 06:05:21.228172	2025-11-17 06:05:21.228172	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
495	TXN463295	card	recharge	8317082162	22.0	SUCCESS	139	2025-11-17 06:06:02.5956	2025-11-17 06:06:02.5956	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
496	TXN623942	XYZ	rent_payment	8945285621	44.0	SUCCESS	139	2025-11-17 06:07:56.974678	2025-11-17 06:07:56.974678	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
497	TXN768348	Airtel	Recharge	8888888888	749.0	SUCCESS	139	2025-11-17 06:08:25.286075	2025-11-17 06:08:25.286075	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
498	TXN441908	airtel	Recharge	87392889	199.0	SUCCESS	139	2025-11-17 06:10:01.869471	2025-11-17 06:10:01.869471	13	sjfjksdnffn	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
499	TXN797399	Tata Power	bill_payment	8888888888	1089.54	SUCCESS	139	2025-11-17 07:21:36.593397	2025-11-17 07:21:36.593397	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
500	TXN244912	Tata Power	bill_payment	8888888888	1089.54	SUCCESS	139	2025-11-17 07:21:47.219915	2025-11-17 07:21:47.219915	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
501	TXN547908	Tata Power	bill_payment	8888888888	1089.54	SUCCESS	139	2025-11-17 07:24:16.187867	2025-11-17 07:24:16.187867	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
502	TXN576929	Tata Power	bill_payment	8888888888	1089.54	SUCCESS	139	2025-11-17 07:28:57.523271	2025-11-17 07:28:57.523271	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
503	TXN581610	Tata Power	bill_payment	8888888888	1089.54	SUCCESS	139	2025-11-17 07:30:49.114077	2025-11-17 07:30:49.114077	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
504	TXN291057	Adani Power	bill_payment	8595266325	1089.54	SUCCESS	139	2025-11-17 07:34:00.514038	2025-11-17 07:34:00.514038	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
505	TXN621702	Adani Power	bill_payment	8856522222	1089.54	SUCCESS	139	2025-11-17 07:37:49.864938	2025-11-17 07:37:49.864938	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
506	TXN960554	HP Gas	bill_payment	8317082162	9.0	SUCCESS	139	2025-11-17 08:47:38.273768	2025-11-17 08:47:38.273768	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
507	TXN820981	HP Gas	bill_payment	8317082162	9.0	SUCCESS	139	2025-11-17 08:48:40.320899	2025-11-17 08:48:40.320899	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
508	TXN111267	HP Gas	bill_payment	8888888888	50.0	SUCCESS	139	2025-11-17 08:55:05.910855	2025-11-17 08:55:05.910855	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
509	TXN478695	Bharat Gas	bill_payment	8317082162	109.0	SUCCESS	139	2025-11-17 08:56:22.582039	2025-11-17 08:56:22.582039	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
510	TXN363950	HP Gas	bill_payment	5555555555	90.0	SUCCESS	139	2025-11-17 09:02:17.219832	2025-11-17 09:02:17.219832	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
511	TXN746051	Bharat Gas	bill_payment	1111111111	300.0	SUCCESS	139	2025-11-17 09:05:58.70208	2025-11-17 09:05:58.70208	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
512	TXN587757	HP Gas	bill_payment	8888888888	22.0	SUCCESS	139	2025-11-17 09:53:29.38784	2025-11-17 09:53:29.38784	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
513	TXN166682	HP Gas	bill_payment	8888888888	90.0	SUCCESS	139	2025-11-17 10:00:55.841352	2025-11-17 10:00:55.841352	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
514	TXN688012	HP Gas	bill_payment	5555555555	10.0	SUCCESS	139	2025-11-17 10:04:25.421745	2025-11-17 10:04:25.421745	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
515	TXN655578	Tata Power	bill_payment	8888888888	1089.54	SUCCESS	139	2025-11-17 10:24:36.402097	2025-11-17 10:24:36.402097	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
516	TXN176095	Tata Power	bill_payment	8888888888	1089.54	SUCCESS	139	2025-11-17 10:32:19.483256	2025-11-17 10:32:19.483256	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
517	TXN817081	HP Gas	bill_payment	8888888888	900.0	SUCCESS	139	2025-11-17 10:55:01.144051	2025-11-17 10:55:01.144051	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
518	TXN921840	HP Gas	bill_payment	8888888888	1.0	SUCCESS	139	2025-11-17 10:55:43.343212	2025-11-17 10:55:43.343212	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
519	TXN865014	Bharat Gas	bill_payment	2222222222	70.0	SUCCESS	139	2025-11-17 11:50:27.704225	2025-11-17 11:50:27.704225	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
520	TXN699094	HP Gas	bill_payment	7777777777	95.0	SUCCESS	139	2025-11-17 11:52:16.5371	2025-11-17 11:52:16.5371	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
521	TXN446522	Bharat Gas	bill_payment	8798797987	33.0	SUCCESS	139	2025-11-17 12:15:30.498343	2025-11-17 12:15:30.498343	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
522	TXN662619	Bharat Gas	bill_payment	7879797907	11.0	SUCCESS	139	2025-11-17 12:28:30.330179	2025-11-17 12:28:30.330179	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
523	TXN684338	Bharat Gas	bill_payment	8888888888	900.0	SUCCESS	139	2025-11-17 12:30:01.524978	2025-11-17 12:30:01.524978	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
524	TXN421214	BSES	bill_payment	9898980098	1089.54	SUCCESS	139	2025-11-17 12:37:28.66543	2025-11-17 12:37:28.66543	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
525	TXN937097	Tata Power	bill_payment	8888888887	1089.54	SUCCESS	139	2025-11-17 12:40:54.938583	2025-11-17 12:40:54.938583	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
526	TXN321447	HP Gas	bill_payment	8888888888	600.0	SUCCESS	139	2025-11-18 06:29:46.98075	2025-11-18 06:29:46.98075	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
527	TXN863375	BSES	bill_payment	8888888888	1089.54	SUCCESS	139	2025-11-18 06:30:25.065767	2025-11-18 06:30:25.065767	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
528	TXN282103	Tata Power	bill_payment	1111111111	1089.54	SUCCESS	139	2025-11-18 06:31:09.591211	2025-11-18 06:31:09.591211	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
529	TXN266144	Bharat Gas	bill_payment	8888888888	80.0	SUCCESS	139	2025-11-18 06:38:06.015587	2025-11-18 06:38:06.015587	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
530	TXN813688	HP Gas	bill_payment	8888888888	60.0	SUCCESS	139	2025-11-18 07:04:40.643552	2025-11-18 07:04:40.643552	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
531	TXN270392	Delhi Water Board	recharge	1234567890	1089.54	SUCCESS	139	2025-11-18 09:50:54.913027	2025-11-18 09:50:54.913027	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
532	TXN783848	N/A	recharge	5555555555	1089.54	SUCCESS	139	2025-11-18 10:09:55.129343	2025-11-18 10:09:55.129343	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
533	TXN907583	N/A	recharge	2222222222	1089.54	SUCCESS	139	2025-11-18 10:18:01.342184	2025-11-18 10:18:01.342184	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
534	TXN165845	N/A	recharge	6666666666	1089.54	SUCCESS	139	2025-11-18 10:24:04.623873	2025-11-18 10:24:04.623873	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
535	TXN905802	N/A	recharge	1212121212	1089.54	SUCCESS	139	2025-11-18 10:28:19.583559	2025-11-18 10:28:19.583559	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
536	TXN331069	Airtel	Recharge	8888888888	499.0	SUCCESS	139	2025-11-18 11:47:12.67007	2025-11-18 11:47:12.67007	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
537	TXN608638	Vi	Recharge	5555555555	229.0	SUCCESS	139	2025-11-18 11:49:41.106474	2025-11-18 11:49:41.106474	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
538	TXN934395	dish	Recharge	909090909	699.0	SUCCESS	139	2025-11-18 11:52:12.351132	2025-11-18 11:52:12.351132	13	annu devi	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
539	TXN798080	BSNL	Recharge	1212121212	499.0	SUCCESS	139	2025-11-18 12:10:18.303309	2025-11-18 12:10:18.303309	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
540	TXN314001	Vi	Recharge	1111111111	399.0	SUCCESS	139	2025-11-18 12:11:40.218454	2025-11-18 12:11:40.218454	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
541	TXN531875	Videocon D2H	Recharge	5464654646	1.0	SUCCESS	139	2025-11-26 05:50:21.897964	2025-11-26 05:50:21.897964	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
542	TXN568135	Videocon D2H	Recharge	5464654646	1.0	SUCCESS	139	2025-11-26 05:52:07.271693	2025-11-26 05:52:07.271693	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
543	TXN178312	Jio Prepaid	Recharge	\N	10.0	SUCCESS	127	2025-11-26 08:53:56.294739	2025-11-26 08:53:56.294739	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9305096443	\N
544	TXN681932	Airtel Prepaid	Recharge	\N	22.0	SUCCESS	127	2025-11-26 09:02:35.579685	2025-11-26 09:02:35.579685	11	\N	\N	\N	\N	\N	3509476053	0.003564	\N	\N	\N	SUCCESS	Success	0.1782	7455915805	\N
545	TXN420110	Tata Sky	Recharge	\N	1.0	SUCCESS	127	2025-11-26 12:50:13.69857	2025-11-26 12:50:13.69857	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	800990898909890	\N
546	TXN744105	Jio Prepaid	Recharge	\N	10.0	SUCCESS	127	2025-11-26 12:54:27.609532	2025-11-26 12:54:27.609532	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9305098968	\N
547	TXN561161	Tata Sky	Recharge	\N	1.0	SUCCESS	127	2025-11-26 12:55:37.293498	2025-11-26 12:55:37.293498	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7778889990	\N
548	TXN589452	Vi Postpaid	Recharge	\N	1.0	SUCCESS	127	2025-11-26 13:01:02.336711	2025-11-26 13:01:02.336711	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8798797987	\N
549	TXN456729	Hathway Digital	Recharge	\N	150.0	SUCCESS	127	2025-11-26 13:12:08.421006	2025-11-26 13:12:08.421006	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	897987897	\N
550	TXN569235	Home Loan	recharge	\N	9.0	SUCCESS	127	2025-11-26 13:15:45.877739	2025-11-26 13:15:45.877739	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8789769879	\N
551	TXN694504	HDFC	recharge	\N	11.0	SUCCESS	127	2025-11-26 13:17:39.397341	2025-11-26 13:17:39.397341	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9798798789	\N
552	TXN744883	card	recharge	\N	11.0	SUCCESS	127	2025-11-26 13:19:10.508878	2025-11-26 13:19:10.508878	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N
553	TXN562619	XYZ	rent_payment	\N	11.0	SUCCESS	127	2025-11-26 13:20:27.314451	2025-11-26 13:20:27.314451	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8778797907	\N
554	TXN866809	N/A	recharge	\N	1089.54	SUCCESS	127	2025-11-26 13:21:55.545661	2025-11-26 13:21:55.545661	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8978978977	\N
555	TXN404406	BSES	bill_payment	\N	1089.54	SUCCESS	127	2025-11-26 13:22:57.025661	2025-11-26 13:22:57.025661	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9890898098	\N
556	TXN865251	Bharat Gas	bill_payment	\N	11.0	SUCCESS	127	2025-11-26 13:23:49.253349	2025-11-26 13:23:49.253349	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6575675675	\N
557	TXN162916	N/A	recharge	\N	1089.54	SUCCESS	127	2025-11-26 13:25:36.673872	2025-11-26 13:25:36.673872	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7878789787	\N
558	TXN214911	BSES	bill_payment	\N	1089.54	SUCCESS	127	2025-11-26 13:25:59.837018	2025-11-26 13:25:59.837018	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9769868978	\N
559	TXN287175	Bharat Gas	bill_payment	\N	11.0	SUCCESS	127	2025-11-26 13:26:24.405884	2025-11-26 13:26:24.405884	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6575675675	\N
560	TXN335443	Airtel Prepaid	Recharge	\N	1.0	SUCCESS	127	2025-11-26 13:26:57.344511	2025-11-26 13:26:57.344511	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8789798798	\N
561	TXN955376	Tata Sky	Recharge	\N	1.0	SUCCESS	127	2025-11-26 13:27:32.100883	2025-11-26 13:27:32.100883	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	87987879878789	\N
562	TXN560070	Hathway Digital	Recharge	\N	150.0	SUCCESS	127	2025-11-26 13:28:19.074013	2025-11-26 13:28:19.074013	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8789787889789	\N
563	TXN877582	Home Loan	recharge	\N	12.0	SUCCESS	127	2025-11-26 13:28:56.873905	2025-11-26 13:28:56.873905	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7887878798	\N
564	TXN272124	HDFC	recharge	\N	111.0	SUCCESS	127	2025-11-26 13:29:29.574363	2025-11-26 13:29:29.574363	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7658767578	\N
565	TXN335356	card	recharge	\N	111.0	SUCCESS	127	2025-11-26 13:30:04.220991	2025-11-26 13:30:04.220991	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N
566	TXN669866	XYZ	rent_payment	\N	566.0	SUCCESS	127	2025-11-26 13:31:05.781009	2025-11-26 13:31:05.781009	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8789789787	\N
567	TXN644718	Airtel	Recharge	\N	11.0	SUCCESS	175	2025-11-27 09:00:50.069772	2025-11-27 09:00:50.069772	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9999999999	\N
568	TXN906399	Bharat Gas	bill_payment	\N	20.0	SUCCESS	175	2025-11-27 09:54:53.095794	2025-11-27 09:54:53.095794	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7438643896	\N
569	TXN171381	Airtel Prepaid	Recharge	\N	22.0	SUCCESS	127	2025-11-28 05:21:15.788551	2025-11-28 05:21:15.788551	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7455915805	\N
570	TXN237505	Dish TV	Recharge	\N	1.0	SUCCESS	169	2025-12-03 08:56:39.545921	2025-12-03 08:56:39.545921	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	888888888888	\N
571	TXN386955	Dish TV	Recharge	\N	1.0	SUCCESS	169	2025-12-03 08:59:17.151486	2025-12-03 08:59:17.151486	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	888888888888	\N
572	TXN888118	Dish TV	Recharge	\N	1.0	SUCCESS	169	2025-12-03 08:59:47.943452	2025-12-03 08:59:47.943452	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	888888888888	\N
573	TXN286775	Dish TV	Recharge	\N	1.0	SUCCESS	169	2025-12-03 09:02:00.093388	2025-12-03 09:02:00.093388	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	888888888888	\N
574	TXN885519	Dish TV	Recharge	\N	1.0	SUCCESS	169	2025-12-03 12:07:46.001244	2025-12-03 12:07:46.001244	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	77777777777	\N
575	TXN875422	N/A	recharge	\N	1089.54	SUCCESS	169	2025-12-05 06:56:21.364464	2025-12-05 06:56:21.364464	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2222222222	\N
576	TXN499386	N/A	recharge	\N	1089.54	SUCCESS	169	2025-12-05 07:34:32.801233	2025-12-05 07:34:32.801233	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9999999999	\N
577	TXN644026	Gwalior Municipal Corporation - Water	recharge	\N	1089.54	SUCCESS	169	2025-12-05 08:53:47.177214	2025-12-05 08:53:47.177214	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5555555555	\N
578	TXN400085	Paul Merchants	recharge	\N	1.0	SUCCESS	169	2025-12-08 08:46:21.294183	2025-12-08 08:46:21.294183	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8585964852	\N
579	TXN190825	Jio Prepaid	Recharge	\N	19.0	SUCCESS	127	2025-12-08 11:17:48.832306	2025-12-08 11:17:48.832306	11	\N	\N	\N	\N	\N	3513999670	0.003078	\N	\N	\N	SUCCESS	Success	0.1539	9305096443	\N
580	TXN794269	Axis Bank Credit Card	recharge	\N	3244.04	SUCCESS	139	2025-12-09 10:16:32.23945	2025-12-09 10:16:32.23945	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
581	TXN335605	IDBI Bank Fastag	recharge	\N	1.0	SUCCESS	139	2025-12-10 09:51:32.310886	2025-12-10 09:51:32.310886	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N
582	TXN635857	IDBI Bank Fastag	recharge	\N	3.0	SUCCESS	139	2025-12-11 09:35:55.131241	2025-12-11 09:35:55.131241	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9598687788	\N
583	TXN692706	IDBI Bank Fastag	recharge	\N	6.0	SUCCESS	176	2025-12-11 10:01:59.893176	2025-12-11 10:01:59.893176	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9743895734	\N
584	TXN504494	IDBI Bank Fastag	recharge	\N	2.0	SUCCESS	176	2025-12-11 10:21:47.277519	2025-12-11 10:21:47.277519	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9222222222	\N
585	TXN400683	IDBI Bank Fastag	recharge	\N	1.0	SUCCESS	176	2025-12-11 10:23:28.178836	2025-12-11 10:23:28.178836	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8111111888	UP16EM6388
586	TXN579918	IDBI Bank Fastag	recharge	\N	12.0	SUCCESS	176	2025-12-11 12:15:41.480901	2025-12-11 12:15:41.480901	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	UP16EM6388
587	TXN395634	Jio Prepaid	Recharge	\N	1.0	SUCCESS	176	2025-12-12 06:07:50.153521	2025-12-12 06:07:50.153521	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N
588	TXN261754	Jio Prepaid	Recharge	\N	1.0	SUCCESS	176	2025-12-12 09:52:26.613734	2025-12-12 09:52:26.613734	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N
589	TXN994255	Jio Prepaid	Recharge	\N	1.0	SUCCESS	139	2025-12-12 09:57:56.93042	2025-12-12 09:57:56.93042	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N
590	TXN514943	Airtel Prepaid	Recharge	\N	11.0	SUCCESS	139	2025-12-12 11:24:57.23813	2025-12-12 11:24:57.23813	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7867856868	\N
591	TXN897828	Jio Prepaid	Recharge	\N	1.0	SUCCESS	177	2025-12-12 11:55:00.464033	2025-12-12 11:55:00.464033	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8888888888	\N
592	TXN715862	Jio Prepaid	Recharge	\N	10.0	SUCCESS	127	2025-12-13 08:47:23.5463	2025-12-13 08:47:23.5463	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8098098798	\N
593	TXN739206	Airtel Prepaid	Recharge	\N	1.0	SUCCESS	127	2025-12-13 08:53:57.200309	2025-12-13 08:53:57.200309	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8080809809	\N
594	TXN400297	Jio Prepaid	Recharge	\N	10.0	SUCCESS	127	2025-12-13 09:10:01.787012	2025-12-13 09:10:01.787012	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7879797899	\N
595	TXN997817	Jio Prepaid	Recharge	\N	1.0	SUCCESS	139	2025-12-18 06:29:25.520857	2025-12-18 06:29:25.520857	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N
596	TXN502816	Jio Prepaid	Recharge	\N	1.0	SUCCESS	176	2025-12-18 07:23:09.550508	2025-12-18 07:23:09.550508	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N
597	TXN509463	Jio Prepaid	Recharge	\N	1.0	SUCCESS	139	2025-12-25 04:40:30.219329	2025-12-25 04:40:30.219329	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
598	TXN971966	Jio Prepaid	Recharge	\N	10.0	SUCCESS	127	2025-12-25 11:46:43.42104	2025-12-25 11:46:43.42104	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
599	TXN830175	Jio Prepaid	Recharge	\N	19.0	SUCCESS	127	2025-12-25 11:49:41.653941	2025-12-25 11:49:41.653941	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9337691368	\N
600	TXN406781	Jio Prepaid	Recharge	\N	10.0	SUCCESS	127	2025-12-26 06:01:30.093541	2025-12-26 06:01:30.093541	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8969878978	\N
601	TXN610700	IDBI Bank Fastag	recharge	\N	1.0	SUCCESS	127	2025-12-26 06:14:25.294092	2025-12-26 06:14:25.294092	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9305096443	UP16EM6388
602	TXN821199	Axis Bank Credit Card	recharge	\N	9067.65	SUCCESS	127	2025-12-26 06:16:00.02169	2025-12-26 06:16:00.02169	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
603	TXN448968	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-26 07:04:41.907186	2025-12-26 07:04:41.907186	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9787987897	\N
604	TXN593633	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-26 07:08:52.294776	2025-12-26 07:08:52.294776	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8888888888	\N
605	TXN503031	North Bihar Power	bill_payment	\N	100.0	SUCCESS	139	2025-12-26 11:27:51.310747	2025-12-26 11:27:51.310747	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9999999999	\N
606	TXN997349	North Bihar Power	bill_payment	\N	100.0	SUCCESS	139	2025-12-26 11:43:30.157637	2025-12-26 11:43:30.157637	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9999999999	\N
607	TXN549091	North Bihar Power	bill_payment	\N	100.0	SUCCESS	139	2025-12-26 11:53:18.711832	2025-12-26 11:53:18.711832	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9999999999	\N
608	TXN475703	North Bihar Power	bill_payment	\N	100.0	SUCCESS	139	2025-12-26 11:58:11.046434	2025-12-26 11:58:11.046434	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9999999999	\N
609	TXN609223	North Bihar Power	bill_payment	\N	100.0	SUCCESS	139	2025-12-26 12:04:31.176331	2025-12-26 12:04:31.176331	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9999999999	\N
610	TXN195054	North Bihar Power	bill_payment	\N	100.0	SUCCESS	139	2025-12-26 12:06:34.860342	2025-12-26 12:06:34.860342	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9999999999	\N
611	TXN778865	North Bihar Power	bill_payment	\N	100.0	SUCCESS	139	2025-12-26 12:14:42.662742	2025-12-26 12:14:42.662742	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9999999999	\N
612	TXN468138	North Bihar Power	bill_payment	\N	100.0	SUCCESS	127	2025-12-27 06:11:09.073951	2025-12-27 06:11:09.073951	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9867969876	\N
613	TXN840377	Indraprastha Gas	bill_payment	\N	758.76	SUCCESS	127	2025-12-27 06:16:19.019382	2025-12-27 06:16:19.019382	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7000289745	\N
614	TXN233559	Dish TV	Recharge	\N	1.0	SUCCESS	139	2025-12-27 06:53:56.484953	2025-12-27 06:53:56.484953	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N
615	TXN854013	BIG TV DTH	Recharge	\N	1.0	SUCCESS	139	2025-12-27 07:00:49.192102	2025-12-27 07:00:49.192102	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8317082162	\N
616	TXN797224	Airtel DTH	Recharge	\N	1.0	SUCCESS	139	2025-12-27 07:08:11.112468	2025-12-27 07:08:11.112468	13	siddddddddd	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8888888888	\N
617	TXN877552	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	139	2025-12-27 08:34:33.502824	2025-12-27 08:34:33.502824	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
620	TXN201064	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	139	2025-12-27 08:38:40.743952	2025-12-27 08:38:40.743952	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
621	TXN571237	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	139	2025-12-27 08:40:14.708989	2025-12-27 08:40:14.708989	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
622	TXN807165	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	139	2025-12-27 08:42:25.880911	2025-12-27 08:42:25.880911	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
623	TXN370120	Jio Prepaid	Recharge	\N	1.0	SUCCESS	139	2025-12-27 08:43:12.792108	2025-12-27 08:43:12.792108	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8888888888	\N
624	TXN988957	Kotak Mahindra Bank Ltd.-Loans	recharge	\N	18869.73	SUCCESS	127	2025-12-27 08:44:00.878935	2025-12-27 08:44:00.878935	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7697697696	\N
625	TXN107561	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	139	2025-12-27 08:48:10.899092	2025-12-27 08:48:10.899092	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
626	TXN231594	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	139	2025-12-27 08:48:42.1542	2025-12-27 08:48:42.1542	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
627	TXN564130	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	139	2025-12-27 08:49:36.528318	2025-12-27 08:49:36.528318	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
632	TXN655284	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	139	2025-12-27 08:55:29.675242	2025-12-27 08:55:29.675242	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
635	TXN478155	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	139	2025-12-27 08:57:43.693425	2025-12-27 08:57:43.693425	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
637	TXN929259	Kotak Mahindra Bank Ltd.-Loans	recharge	\N	18869.73	SUCCESS	127	2025-12-27 08:58:54.753993	2025-12-27 08:58:54.753993	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9878998797	\N
638	TXN983721	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 08:59:07.563433	2025-12-27 08:59:07.563433	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
639	TXN703070	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 09:00:20.975882	2025-12-27 09:00:20.975882	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
640	TXN469821	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 09:01:56.372308	2025-12-27 09:01:56.372308	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
641	TXN345913	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 09:02:52.216839	2025-12-27 09:02:52.216839	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
642	TXN452785	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 09:11:08.952497	2025-12-27 09:11:08.952497	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
643	TXN670884	Kotak Mahindra Bank Ltd.-Loans	recharge	\N	18869.73	SUCCESS	127	2025-12-27 09:14:37.467824	2025-12-27 09:14:37.467824	14	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8798789789	\N
644	TXN908961	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 09:16:44.932368	2025-12-27 09:16:44.932368	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
645	TXN768850	IDBI Bank Fastag	recharge	\N	10.0	SUCCESS	127	2025-12-27 09:19:39.892584	2025-12-27 09:19:39.892584	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7698689698	UP16EM6388
646	TXN255029	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 09:23:13.253187	2025-12-27 09:23:13.253187	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
647	TXN796182	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 09:23:39.615716	2025-12-27 09:23:39.615716	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
648	TXN752194	IDBI Bank Fastag	recharge	\N	11.0	SUCCESS	127	2025-12-27 09:27:34.348329	2025-12-27 09:27:34.348329	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6575757665	UP16EM6388
649	TXN473541	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 09:31:19.98574	2025-12-27 09:31:19.98574	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
650	TXN542163	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 09:31:54.334402	2025-12-27 09:31:54.334402	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
651	TXN642818	Axis Bank Credit Card	recharge	\N	9067.65	SUCCESS	127	2025-12-27 09:35:06.523338	2025-12-27 09:35:06.523338	17	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
652	TXN953674	Airtel Prepaid	Recharge	\N	11.0	SUCCESS	127	2025-12-27 09:36:46.794527	2025-12-27 09:36:46.794527	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8979878789	\N
653	TXN682163	Connect Broadband	recharge	\N	1.0	SUCCESS	139	2025-12-27 09:40:31.035655	2025-12-27 09:40:31.035655	12	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7000289745	\N
654	TXN558001	Vi Postpaid	Recharge	\N	650.17	SUCCESS	127	2025-12-27 09:41:23.474623	2025-12-27 09:41:23.474623	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9891770022	\N
655	TXN168270	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:00:05.341515	2025-12-27 10:00:05.341515	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
656	TXN132091	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:00:42.104964	2025-12-27 10:00:42.104964	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
657	TXN830717	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:01:33.739763	2025-12-27 10:01:33.739763	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
658	TXN971283	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:04:13.812862	2025-12-27 10:04:13.812862	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
659	TXN816834	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:09:00.660658	2025-12-27 10:09:00.660658	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
660	TXN743665	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:09:48.39551	2025-12-27 10:09:48.39551	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
661	TXN160818	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:11:26.165063	2025-12-27 10:11:26.165063	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
662	TXN834517	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:14:24.276126	2025-12-27 10:14:24.276126	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
663	TXN638771	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:15:06.574958	2025-12-27 10:15:06.574958	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
664	TXN722534	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:15:57.778653	2025-12-27 10:15:57.778653	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
665	TXN272973	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:16:47.289404	2025-12-27 10:16:47.289404	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
666	TXN740773	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:17:41.692402	2025-12-27 10:17:41.692402	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
667	TXN858875	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:19:37.168882	2025-12-27 10:19:37.168882	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
668	TXN547209	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:20:56.932873	2025-12-27 10:20:56.932873	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
669	TXN123703	North Bihar Power	bill_payment	\N	100.0	SUCCESS	127	2025-12-27 10:24:28.634043	2025-12-27 10:24:28.634043	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7998789789	\N
670	TXN213132	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:26:00.532967	2025-12-27 10:26:00.532967	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
671	TXN641952	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:26:40.935266	2025-12-27 10:26:40.935266	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
672	TXN825326	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:28:09.822765	2025-12-27 10:28:09.822765	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
673	TXN683355	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:28:25.815527	2025-12-27 10:28:25.815527	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
674	TXN746782	Airtel Prepaid	Recharge	\N	100.0	SUCCESS	127	2025-12-27 10:28:37.789856	2025-12-27 10:28:37.789856	13	Sumit Kumar	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9568773855	\N
675	TXN311010	Indraprastha Gas	bill_payment	\N	758.76	SUCCESS	127	2025-12-27 10:34:20.773175	2025-12-27 10:34:20.773175	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7000289745	\N
676	TXN248527	Connect Broadband	recharge	\N	2.0	SUCCESS	139	2025-12-27 10:39:31.415832	2025-12-27 10:39:31.415832	12	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7000289745	\N
677	TXN775297	Connect Broadband	recharge	\N	3.0	SUCCESS	139	2025-12-27 10:48:19.527961	2025-12-27 10:48:19.527961	12	manikant	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7000289745	\N
678	TXN973589	Connect Broadband	recharge	\N	4.0	SUCCESS	139	2025-12-27 10:57:10.553536	2025-12-27 10:57:10.553536	12	rajjuu dalle	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7000289745	\N
679	TXN204675	North Bihar Power	bill_payment	\N	100.0	SUCCESS	127	2025-12-27 11:00:21.175323	2025-12-27 11:00:21.175323	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	8977987987	\N
680	TXN123298	North Bihar Power	bill_payment	\N	100.0	SUCCESS	127	2025-12-27 11:05:24.812603	2025-12-27 11:05:24.812603	8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	9869876686	\N
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
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, first_name, last_name, email, password_digest, role, otp, verify_otp, otp_expires_at, phone_number, country_code, alternative_number, aadhaar_number, pan_card, date_of_birth, gender, business_name, business_owner_type, business_nature_type, business_registration_number, gst_number, pan_number, address, city, state, pincode, landmark, username, scheme, referred_by, bank_name, account_number, ifsc_code, account_holder_name, notes, session_token, created_at, updated_at, role_id, status, company_type, company_name, cin_number, registration_certificate, user_admin_id, confirm_password, domain_name, scheme_id, service_id, pan_card_image, aadhaar_image, passport_photo, store_shop_photo, address_proof_photo, parent_id, set_pin, confirm_pin, latitude, longitude, captured_at, last_seen_at, ip_address, location, kyc_status, kyc_method, aadhaar_front_image, aadhaar_back_image, aadhaar_otp, pan_otp, pan_status, aadhaar_status, image, kyc_verifications, kyc_verified_at, kyc_data, set_mpin, status_mpin, email_otp_status, email_otp, email_otp_verified_at, set_pin_status, email_otp_sent_at, user_code, eko_onboard_first_step, eko_profile_second_step, eko_status_otp, eko_verify_otp, eko_biometric_kyc) FROM stdin;
114	Ishu	Dhariya	ishuadmin@gmail.com	$2a$12$T/n5QlXtlBYeDotJWBdBJOVk/ijEce5jj291F/HcLEmZNhSg7kcaq	\N	\N	\N	\N	89798798783	\N	03443434334	876876876867233	JKGJGHJ688978	2025-09-04		Credit card sales	Credit Business slove	buessiness s Nature Type	Credit Business Registration Number	986857644645cddsds	\N		noida	Uttar Pradesh	201301	\N	ishu8789	\N	HGG7897897	Axis	7988757678hgg	IFDD&775655	Retailers	\N	\N	2025-09-01 08:41:59.561116	2025-09-02 06:17:34.681616	9	f	\N	\N	\N	\N	\N	ishu4748	ishu123	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
145	\N	\N	\N	\N	\N	123456	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-19 06:57:28.114985	2025-09-19 06:58:31.945025	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
148	\N	\N	\N	\N	\N	\N	1	\N	68787676676	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	DPa27Kak5BHTa3MqDcJ1j1A1	2025-09-19 13:41:38.241268	2025-09-19 13:46:45.805757	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
112	Last check Amdin	done	check@gmail.com	$2a$12$Bjh7riJIdvYTdz/sw92mCeOzCLSuKbpPJQiXJ6ORd5quezZJRN.He	\N	\N	\N	\N	79879779887987	\N	8979878798798798798	876876876867233	JKGJGHJ688978	2025-08-23	Male	lkjljkjlkjlkjlkj	lkjljkjlkjlkjlkj	lkjljkjlkjlkjlkj	lkjljkjlkjlkjlkj	76867687	\N	noida 121	noida	Uttar Pradesh	201301	\N	sidtech78678	\N	HGG7897897	Axis	7988757678hgg	IFDD96875	Sidddddddd	\N	\N	2025-08-30 12:36:49.720661	2025-09-02 06:17:35.187671	9	t	\N	\N	\N	\N	\N	123456	sam	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
63	Siddharth	gautam	sid20319@gmail.com	$2a$12$JO8REGKj60NcWybSym0soe/g4XTaretunZjlatQtzicy5OgcnnoUi	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-27 05:58:33.297504	2025-09-02 06:17:35.442908	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
113	Alim Admin3	Khan	Alimadmin@gmail.com	$2a$12$On5F4IEhPEr.PL6Fm4RTxeKFE7fv1E4dgf2.RVhBKr0fEUJWBwY4K	\N	\N	\N	\N	8908099089898	\N	+919568773855	9867676757656	JKGJGHJ68768	2025-08-21		IT LOAN SOULTION	IT BUSINES LOAN SOLUTION	Business Nature Type	989878967678dsds	986857644645cddsds	\N		noida	Uttar Pradesh	201301	\N	Amir323	\N	123223	HDFC	687687676776876	IFDD96875	Alim Admin	\N	\N	2025-08-30 13:17:19.343681	2025-09-02 06:17:33.411207	9	f	\N	\N	\N	\N	\N	232323	aalimadmin	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
120	tetdsh	jdshdkhj	jkhjds9876876@gmai.com	$2a$12$xMdDNNMXc3SVwoTbqcVFEelMsXolKH0AF/w32okDTm7EYbyQg0guW	\N	\N	\N	\N	03443434334	\N	03443434334	9867676757656	JKGJGHJ688978	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	aaisihi	\N						\N	\N	2025-09-02 09:12:04.737004	2025-09-02 09:12:04.737004	9	f	\N	\N	\N	\N	\N		namesing	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
106	Saurav	\N	saurav@gmailcom	$2a$12$wIM6HuqbUxTEFYaLY9KFgOplYERTByO98kLvtapktuQFH8NoTXvgm	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-30 06:01:17.85221	2025-09-02 06:17:35.696542	9	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
107	dsds	\N	sam@gmail.com	$2a$12$Hv.Ohx3z53IyUtDSxDAqk.TyvwDRegxSf65iMOtMTCTWBI2hT4cvO	\N	\N	\N	\N	+919568773855	\N	\N	98798798798687	\N	\N	\N	\N	\N	\N	\N	4343	HJHJK87797J	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-30 06:36:54.886138	2025-09-02 06:17:35.951099	9	f	\N	fdd	\N	dfdss	0	123	sam	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
119	alminadmin	admin	lkjkljds@gmail.com	$2a$12$vWexdLFBSIC0IQHkUQV/Eez5mK4.Mih0h9vhPrynLAm4RMa/IVbb.	\N	\N	\N	\N	90990988433	\N	03443434334	7328728367	JKGJGHJ68768	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	siddharth343443	\N	HGG7897897	Axis	687687676776876	IFDD&775655		\N	\N	2025-09-02 07:38:16.83295	2025-09-02 07:39:10.796858	5	f	\N	\N	\N	\N	\N	123456	LK	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
121	dds	dsds	ddsds@gmail.com	\N	\N	\N	\N	\N	9879798787798	\N	33232323232443	9867676757656	JKGJGHJ688978	2025-09-01	Male						\N					\N								\N	\N	2025-09-02 09:16:50.279226	2025-09-02 09:16:50.279226	6	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
117	tetdsh admin	jdshdkhj	hjkhdkjshs@gmai.com	$2a$12$CTes.77NLRMBi14MAOTzpO7xjXKzM/koG9FrjrA2noQnEgGqLCovC	\N	\N	\N	\N	03443434334	\N	+919568773855	9867676757656	dskjds	2025-10-04	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	siddharth23232	\N		Axis	7988757678hgg	IFDD96875		\N	528bfc6ca23e1aec5b80e7ee858a5cb02bf3e74c	2025-09-02 07:00:17.967209	2025-09-02 07:39:52.558184	9	t	\N	\N	\N	\N	\N	123456	LK	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
64	Siddharth	gautam	sid203191@gmail.com	$2a$12$LqHXjK1ApiWq3Hdtiz3mxuMPapt7f27NScf4vRz1eQTSPpPgtoV/a	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-08-27 06:06:23.479823	2025-09-02 06:17:34.174339	6	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
115	Siddharth	gautam	sid20319@gmail.com	$2a$12$vgdMQ.nVQ3v5Opf7PO.MKe9Ir9F2vKLvWk/.u.hW7jw6OPDEyl8xm	\N	\N	\N	\N	+919568773855	\N	+919568773855	876876876867233	JKGJGHJ68768	2025-09-05	Select gender						\N					\N								\N	\N	2025-09-01 12:11:36.6599	2025-09-02 06:17:34.428781	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
123	Ashok kumar	sing	ashok@gmail.com	$2a$12$6Bufd22R0bN7CqzzJvsSceaKNWhFmEWcBN.EPGtc.UuHh58VotZuK	\N	\N	\N	\N	7897879879	\N	98797987979	876876876867233	JKGJGHJ688978	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	Noida, Uttar Pradesh, India	Noida	Uttar Pradesh	ds233232	\N	ashok79798	paid	HGG7897897	Axis	7988757678hgg	IFDD96875	Ashok	\N	\N	2025-09-02 09:21:22.367274	2025-09-02 09:21:22.367274	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
124	dsds	dsds	dsds1111@gmail.com	$2a$12$I7eTYPo.Ih4CecQlup87LewDGANadhCEDdUo2.eAKu/C9OmdGmE12	\N	\N	\N	\N	dsds	\N	dsds	dsds	dsds	\N	Select gender	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	sidtech78678							\N	\N	2025-09-02 09:23:42.407569	2025-09-02 09:23:42.407569	5	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
126	don11	kumar	don11@gmail.com	$2a$12$GLHjSzVQr78G0W9erfWnzesHakQN4bSMj3HwMyOQvwkopolO1xpNS	\N	\N	\N	\N	876876876786	\N	03443434334	986767675765622	JKGJGHJ688978	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	don11	\N		Axis	7988757678hgg	IFDD&775655	don11	\N	\N	2025-09-02 09:33:16.802674	2025-09-02 09:33:16.802674	9	f	\N	\N	\N	\N	\N	123456		5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
125	tetdsh	jdshdkhj	hjkhdkjshs@gmai.com	$2a$12$Pmx8LzTfUgrLFuvjmMugO.BDDK11lPhWZl85hHztxVBgEUaQroU4C	\N	\N	\N	\N	03443434334	\N	+919568773855		JKGJGHJ68768	\N	Female						\N					\N		\N		Axis	7988757678hgg	IFDD&775655		\N	\N	2025-09-02 09:26:06.988697	2025-09-02 09:26:06.988697	9	f	\N	\N	\N	\N	\N			\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
118	Siddharth	gautam	sidtest@gmail.com	$2a$12$bScG9DTUcClpOFLZQsW4rulxWA5d1Fpr7VysITYFhasLWn5qV/5nS	\N	\N	\N	\N	+919568773855	\N	+919568773855	9867676757656	JKGJGHJ68768	\N	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	Gawalira	Saharanpur	Uttar Pradesh	247001	\N		\N						\N	47473b45a624cbf222a2f9a0dac6877bc37326f6	2025-09-02 07:20:02.690017	2025-09-04 06:17:17.446234	5	t	\N	\N	\N	\N	\N	123456	amdin788	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
141	Shek	aalam	shek@gmail.com	$2a$12$eaEveK9bW2pC14ehDryUyeDBStZ8dShiTOSolTBmEgNuChyAMvGZG	\N	\N	\N	\N	9568773855	\N	9568773855	98798798798687	JKGJGHJ68768DD	2025-09-03	Male						\N					\N	Shak344343	\N		Axis	7988757678hgg	IFDD&775655	Alim	\N	\N	2025-09-04 18:35:04.24181	2025-09-04 18:37:01.728801	9	f	\N	\N	\N	\N	\N	shak123		5	\N	\N	\N	\N	\N	\N	136	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
128	Deepak	Kumar	deepak@gmail.com	$2a$12$Y2XkV2FZJtmtIP7yaWTI2.8ew.bgSdhtd6BsYc.CAgepA9xhro9Ni	\N	\N	\N	\N	897988798743	\N	89798879872	897988798712	JKGJGHJ68768DD	2025-09-01	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	Noida, Uttar Pradesh, India	Noida	Uttar Pradesh	ds233232	\N	deepak989	paid	HGG7897897	\N	\N	\N	\N		ed55c486a63ceb93078fe6db507c241a1613898e	2025-09-02 11:37:19.658725	2025-09-02 11:42:17.407239	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
122	Siddharth	gautam	sid20319@gmail.com	\N	\N	\N	\N	\N	+919568773855	\N	03443434334			\N	Select gender						\N					\N								\N	\N	2025-09-02 09:17:38.186319	2025-10-11 05:25:32.841258	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
116	Siddharth admin	gautam	sid20319@gmail.com	$2a$12$oipaiZHpfbOVAw21Vbx0CuiLKB.Jr2Dao1PT5hO8mQ8sUxGbG2kcy	\N	\N	\N	\N	+919568773855	\N	03443434334	98798798798687	JKGJGHJ688978	\N	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N	noida 121	noida	Uttar Pradesh	201301	\N	sidtech78678	\N	HGG7897897					\N	\N	2025-09-02 06:57:13.265005	2025-11-15 10:53:09.865057	9	t	\N	\N	\N	\N	\N	123456	sidadmin	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
136	super admin	ssk	superadmin@gmail.com	$2a$12$Aq6Gos2uA34SdxcFMuqDd.5pUzX2fupUpb4Uwfqrn4h7xE0/J7KXC	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-04 07:52:52.668874	2025-12-23 05:26:11.737322	10	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	123123	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
129	mona	singh4	mona@gmail.com	$2a$12$GjElBj/SIW.avp5470ajG.lV6BnFnlY3TQ7s7MkoO6hIVWghO2pda	\N	\N	\N	\N		\N	65656565655	9877987877787	JKGJGHJ68768	2025-09-02	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	mona7768798	paid	HGG7897897	Axis	7988757678hgg	IFDD&775655	Alim	\N	1b057f28b4e935c66ab752e3839c07afa468158e	2025-09-02 11:43:35.893844	2025-09-02 11:44:42.105716	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
142	shek khan	Retailer	shekkhan@gmail.com	$2a$12$2nrtTrbL1IIh8t/wGGEP1egNqMkPL/4/EARaLsOdF0z/V0Dmr3yeS	\N	\N	\N	\N	+919568773855	\N	+919568773855	7328728367	JKGJGHJ688978	2025-09-03	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	shekkhan123	\N		Axis	7988757678hgg			\N	14acdc9b6da431369b865cb50874268cb315a0fb	2025-09-04 18:41:03.59699	2025-09-04 18:42:56.490229	5	t	\N	\N	\N	\N	\N	123456	\N	5	\N	\N	\N	\N	\N	\N	141	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
138	Mohammad Admin	8989898989	mohammad@gmail.com	$2a$12$4jWbmFwYnqIlkWx8QC9vLuPPEmNT.UaBis5VRhtMdUAx8tHcIrQ4u	\N	\N	\N	\N	787987987988	\N	89798787783	7788978798334	JKGJGHJ68768DD	2025-09-03	Male	Credit card sales	Credit Business slove	Credit Business Nature Type	Credit Business Registration Number	798797d87ds797ds987987	\N	noida 121	noida	Uttar Pradesh	201301	\N	mohd28982	\N	HGG789789778	Axis	687687676776876	IFDD&775655	mohd787	\N	\N	2025-09-04 08:45:42.495292	2025-09-12 12:09:43.049315	9	f	\N	\N	\N	\N	\N	mohd123	mohdshek	5	\N	\N	\N	\N	\N	\N	136	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
140	admin2	gautam	admin2@gmail.com	$2a$12$9WcYcbPvfwTR8r4ns5Fi7eQQ6LnaCIUZkiUj9vQAycYH.Pv8TvD9.	\N	\N	\N	\N	89898808888	\N	89898808888	9867676757656	JKGJGHJ688978	\N	Male	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	sidtech78678	\N		Axis				\N	\N	2025-09-04 18:29:32.002565	2025-09-04 18:29:32.002565	9	f	\N	\N	\N	\N	\N	123456		5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
147	\N	\N	\N	\N	\N	\N	1	\N	123456	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6ePqqfFnT29yH3G51Dp315mk	2025-09-19 07:09:44.153081	2025-09-19 07:14:34.989503	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
146	\N	\N	\N	\N	\N	123456	0	\N	98797979798	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-09-19 07:04:43.110042	2025-09-19 07:18:30.274639	11	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
134	Siddharth	gautam	sid20312229@gmail.com	$2a$12$lrXflu..qyuzpcCmyJ.QeuOyWbRfzWaZ4mW6a4nJ6GDK705C8smum	\N	\N	\N	\N	9568773855	\N				\N	Select gender	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	noida 121	noida	Uttar Pradesh	201301	\N	siddharth	\N		HDFC				\N	bca6e4a1a997af7cab95c78b6c22452f122e544e	2025-09-02 11:52:46.12845	2025-09-19 12:05:13.940195	5	t	\N	\N	\N	\N	\N	123456		16	\N	\N	\N	\N	\N	\N	104	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
152	\N	\N	superadmin@gmail.com	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	qdkR4WzSZTaEJH3dpjz35ejy	2025-10-11 11:49:43.891629	2025-10-11 11:49:43.891629	10	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
150	jon	wim	sidd20319@gmail.com	$2a$12$Rnadoy6GEya44vMXWbh/oOJT7JtH8lTpAyVHcIFdTtVxUovJwLMdy	\N	\N	\N	\N	03443434334	\N				\N	Select gender	dddfdffd	dddfdffd	dddfdffd	dddfdffd		\N	Gawalira	Saharanpur	Uttar Pradesh	247001	\N	sidtech78678							\N	60b34704de45a2cfd281357ceb55ac00df75e41c	2025-10-11 05:26:21.697503	2025-10-11 06:21:24.174187	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	t	\N	2025-10-11 06:21:24.173516	f	\N	\N	f	f	f	f	f
104	admin1	\N	admin@gmail.com	$2a$12$MdSB.FvnU2oVEnPwgbWAU.d0/oQcUOHr5fHM67WhpfYgmIWiCXZlm	\N	\N	\N	\N	94434349494	\N	11123232			\N				\N			\N		\N	\N		\N	admin225	\N	\N			\N		\N	\N	2025-08-29 16:09:27.246126	2025-12-27 08:33:50.302708	9	t	\N	\N	\N	\N	\N	\N	\N	5	\N	\N	\N	\N	\N	\N	136	123456	111222	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2025-12-27 08:33:50.300966	f	\N	\N	f	f	f	f	f
157	Rahul	Sharma	rahul1@example.com	$2a$12$/YJFZ8pPqF4ewj2Gd1dUxuA.KOpSuS2A3mOB//TexgY.r3azgzO1S	\N	\N	\N	\N	9876543210	+91	9876500000	123412341234	ABCDE1234F	1995-06-10	male	Rahul Mobile Shop	Individual	Electronics	BRN123456	07ABCDE1234F1Z5	ABCDE1234F	Main Market	Delhi	Delhi	110001	Near Metro Station	rahulshop	\N	Admin	HDFC Bank	123456789012	HDFC0001234	Rahul Sharma	Test retailer	eX55xjXEaMhGhQKYkkWoEe7Q	2025-11-15 18:22:08.216245	2025-11-15 18:22:08.216245	5	f	Individual	Rahul Enterprises	CIN987654321	RC123456	\N	\N	rahulservices.in	5	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
151	demo		mohammadaamir2002@gmail.com	$2a$12$b1NBB/u84J1XSVn.Lw9fruxKCndRhEbI/8f4wC5c8OtIL.bPBGLFy	\N	\N	\N	\N	7458349745	\N	7458349745	35435034758347	dsaer4343e	2025-10-01	Male	ert	rt	ret	ret	ret	\N	ret	ret	ret4353	43534	\N	mohammadaamir2002@gmail.com			df	dfgfg		dfg	\N	pCdEoWfQrR96DYYdVrZ4QJ6U	2025-10-11 07:35:50.594714	2025-11-14 12:28:55.567864	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	t	\N	2025-10-16 07:04:53.878606	f	\N	\N	f	f	f	f	f
155	Rahul	Sharma	rahul@example.com	$2a$12$eDetdAwfpgh4jK.tsK/l4utfOvmMpeCXQjYR2FKrplpyRYisBEem6	\N	\N	\N	\N	9876543210	+91	9876500000	123412341234	ABCDE1234F	1995-06-10		Rahul Mobile Store	Individual	Electronics	BRN123456	07ABCDE1234F1Z5	ABCDE1234F		Delhi	Delhi	110001	Near Metro Station	rahul_shop	\N	Admin	HDFC Bank	123456789012	HDFC0001234	Rahul Sharma	Test retailer	HaJuCyydbfHSxdYQ3Ho8Tyut	2025-11-15 05:45:53.63126	2025-11-15 10:52:35.16163	9	t	Individual	Rahul Enterprises	CIN987654321	RC123456	\N	\N	rahulservices.in	5	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	t	\N	2025-11-15 06:22:55.637425	f	\N	\N	f	f	f	f	f
158	Rigel	Patel	sivivibu@mailinator.com	$2a$12$t8USyOhO8paG0wPrcQaC5usWwSUshC.FrSFZBGpWWecQaQAee8yzu	\N	\N	\N	\N	3222222222	+91	\N	277322222222	CTNPG1818G	2007-02-10	female	Richard Ford	public_limited	other	956	934	6	Est excepteur conseq	Dolor est voluptas 	Hyderabad	322222	A sit possimus laud	admin225	\N	2212122					Created from admin panel	dk6kCnroVn1AkPN2u6h9XZk5	2025-11-15 18:43:44.558833	2025-11-15 18:43:44.558833	5	f	\N	\N	\N	\N	\N	Admin@123	\N	5	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
159	Siddharth	gautam	sid20319111@gmail.com	$2a$12$mzUXcuhHOd4W6IEWlEKTVugoMo/EQrgV.OPP2EMot3.97d8ke8Yji	\N	\N	\N	\N	9568773855	+91	\N	277322222222	CTNPG1818G	2007-02-10	female	Richard Ford	public_limited	other	956	934	6	Est excepteur conseq	Dolor est voluptas 	Hyderabad	322222	A sit possimus laud	admin225	\N	2212122	Erica Blankenship	237	KKBK0000123	Burton Key	Created from admin panel	mgPLb822muNzUeRFitqsNon8	2025-11-15 18:44:39.640579	2025-11-15 18:44:39.640579	5	f	\N	\N	\N	\N	\N	Admin@123	\N	5	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
153	jon	wim	sid1221@gmail.com	$2a$12$LrNrguGpZTC.J3c7jtjh3OPL1ANv8/7Rohh9AI0eTmC5Tbuwfi95O	\N	\N	\N	\N	03443434334	\N	03443434334	876876876867233	JKGJGHJ688978	2025-11-07	Male						\N	ewew	33232		3232SDS	\N		paid						\N	KfMNj23mrFf5kirAknCBC7Js	2025-11-14 12:29:46.010104	2025-11-15 10:49:42.154381	5	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	t	\N	2025-11-14 12:31:56.427874	f	\N	\N	f	f	f	f	f
154	Rahul	Sharma	rahul@example.com	$2a$12$kf3CfjqaUu9gNuv1cIXY6uwYHT3pStObw6xdD1OKqJ/1LYprA/NAS	\N	\N	\N	\N	9876543210	+91	9876500000	123412341234	ABCDE1234F	1995-06-10	male	Rahul Mobile Shop	Individual	Electronics	BRN123456	07ABCDE1234F1Z5	ABCDE1234F	Main Market	Delhi	Delhi	110001	Near Metro Station	rahulshop	\N	Admin	HDFC Bank	123456789012	HDFC0001234	Rahul Sharma	Test retailer	py84gGkCwSeDHgbGqpC8TyXw	2025-11-15 05:42:26.571771	2025-11-15 12:08:13.30901	5	t	Individual	Rahul Enterprises	CIN987654321	RC123456	\N	\N	rahulservices.in	5	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
127	jon11	wim	jon11@gmail.com	$2a$12$EfKmDRXtu6P3e04s0kbpgelgPdJywVD482JyOoVp9v3L8au8YPMCW	\N	\N	\N	\N	323243434343	\N	03443434334	876876876867233	JKGJGHJ688978	2025-09-01		dddfdffd	dddfdffd	dddfdffd	dddfdffd	986857644645cddsds	\N		noida	Uttar Pradesh	201301	\N	lastadmin223	\N						\N	ea28c4c7c812bbb3eab7003214401a192b448f8b	2025-09-02 09:38:43.044029	2025-12-27 11:36:21.818596	5	t	\N	\N	\N	\N	\N	123456	late22	41	\N	\N	\N	\N	\N	\N	104	123456	123123	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2025-12-27 11:36:21.81753	f	2025-11-19 13:00:37.108691	\N	f	f	f	f	f
161	Lacota	Mcmillan	debicuxac@mailinator.com	$2a$12$Tv8weKIiOBQkivFHz4IzIe4QxETq4gDQIuyR1LANsNzD2SiXfL1Cq	\N	\N	\N	\N	3222222222	+91	\N	243222222222	CTNPG1818G	1998-04-23	male	Anthony Pugh	proprietor	wholesale	543	684	687	Aut eos cumque debi	Officiis nihil paria	Chennai	233333	Nihil alias dolores 	bubatucu	\N	Ipsum incididunt qu	Heather Bruce	917	KKBK0000123	Dieter Kidd	Created from admin panel	7n2T2eCze49j4M5hGgZit73f	2025-11-15 19:22:43.449471	2025-11-15 19:22:43.449471	5	f	\N	\N	\N	\N	\N	Pa$$w0rd!	\N	5	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
162	Kiara	Pollard	rade@mailinator.com	$2a$12$zUeW0J/Sk3egl8KcPuCPEuBPgXpXeRyEQfQ7gDNRLtEqZWV/PKUlu	\N	\N	\N	\N	3222222222	+91	\N	943222222222	CTNPG1818G	1980-05-29	male	Kim Faulkner	limited_liability	trading	708	17	342	Dolore aliquid aut a	Blanditiis dolor rer	Other	322222	Asperiores est sed e	rabusud	\N	Sunt explicabo Impe					Created from admin panel	V2NPLHssr8Fm5Ktg7sw7VpZs	2025-11-15 19:48:53.372328	2025-11-15 19:48:53.372328	5	f	\N	\N	\N	\N	\N	Pa$$w0rd!	\N	5	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
163	Kiara	Pollard	rade11@mailinator.com	$2a$12$CTW.1rfMagfzkHkr57cPTO1OxrsBDtGhsBpYz/6Cz6kXXKaGz68Pa	\N	\N	\N	\N	3222222222	+91	\N	943222222222	CTNPG1818G	1980-05-29	male	Kim Faulkner	limited_liability	trading	708	17	342	Dolore aliquid aut a	Blanditiis dolor rer	Other	322222	Asperiores est sed e	rabusud	\N	Sunt explicabo Impe	Jade Lowe	516	KKBK0000123	Reagan Mendez	Created from admin panel	dH9mtpL1BnJwPYdyDGUPWAbW	2025-11-15 19:50:09.590021	2025-11-15 19:50:09.590021	5	f	\N	\N	\N	\N	\N	Pa$$w0rd!	\N	20	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
164	Zena	Mcpherson	nyhyretiw@mailinator.com	$2a$12$LfqzdiqfMOY9D3tjLsAoj.GFehGfLo78tdjmKHTSi6bgV3gBP64ra	\N	\N	\N	\N	3222222222	+91	\N	878332222222	CTNPG1818G	2000-01-15	female	Janna Ochoa	public_limited	retail	621	952	230	Cumque numquam atque	Adipisicing eum dolo	Hyderabad	322222	Sint ullam praesenti	hibivi	\N	Sit nihil laboriosam					Created from admin panel	XvpWJtLMGx6ZjCspBDhZNPgn	2025-11-15 20:22:16.561485	2025-11-15 20:22:16.561485	5	f	\N	\N	\N	\N	\N	Pa$$w0rd!	\N	20	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
166	Hillary	Riggs	maxonas@mailinator.com	$2a$12$mZOY.ml9Xgte6VjVcS8/L.Tsl7bX.cGCsA9S2KXH/LJWHOyHB9x3O	\N	\N	\N	\N	3222222222	+91	\N	118322222222	CTNPG1818G	2025-09-17	female	Hasad Ortega	public_limited	wholesale	183	79	122	Incididunt lorem fac	Ducimus amet incid	Other	233333	Et aut aliquid nemo 	muxija	\N	Aperiam laborum Qui					Created from admin panel	GfvD9beHhP5mXtNLGWDbpqws	2025-11-15 20:35:17.211905	2025-11-17 11:01:20.815954	6	t	\N	\N	\N	\N	\N	Pa$$w0rd!	\N	21	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
167	Wyoming	Mcintyre	fydawy@mailinator.com	$2a$12$aEk3GF6V2xlzaYPYNIbRCeF9n35zaJr30.zjqR9/d2CsA7YP/NLxe	\N	\N	\N	\N	3222222222	+91	\N	879879879787	CTNPG1818G	2004-02-26	female	Mercedes Stokes	proprietor	manufacturing	57	223	621	Nihil autem saepe la	Error vero adipisici	Mumbai	322222	Enim aut vel facilis	xawofeqome	\N	Do id dolor sed del					Created from admin panel	yVxKb4HRBrnzxSm8RoY5ABk1	2025-11-15 20:37:43.8581	2025-11-17 11:04:14.822644	7	t	\N	\N	\N	\N	\N	Pa$$w0rd!	\N	20	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
168	sidwa	Sharma	rahul@example.com	$2a$12$/SbbbxhYvxkLcNo4hkAuk.dJxQbRjIUFK.PkD4su8QzP/HYl64N8C	\N	\N	\N	\N	9876543210	+91		322222223330	CTNPG1818G	1986-08-06	male	Rahul Mobile Store	limited_liability	retail	225	162	219	Ullamco obcaecati an	Delhi	Delhi	110001	Et nulla quis dolor 	rahul_shop	\N	Dolor rem enim illo 					Created from admin panel	P54cw7v5K3kkxyDnKf1mA74o	2025-11-16 06:58:39.287505	2025-11-17 13:41:18.858549	9	f	\N	\N	\N	\N	\N	Pa$$w0rd!	\N	20	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
165	Zena	Mcpherson	nyhyretiw22@mailinator.com	$2a$12$x5mSmMWz6WNRr8Ty.jlSGexIV2Fz2a2B7xeuqa/4D0mTOjqou85bK	\N	\N	\N	\N	3222222222	+91	\N	878332222222	CTNPG1818G	2000-01-15	female	Janna Ochoa	public_limited	retail	621	952	230	Cumque numquam atque	Adipisicing eum dolo	Hyderabad	322222	Sint ullam praesenti	hibivi	\N	Sit nihil laboriosam	Jeanette Rowland	593	KKBK0000123	David Moss	Created from admin panel	sjwAxsk56x8GuUG1FNeBTdc3	2025-11-15 20:23:26.543316	2025-11-17 11:00:21.219323	6	f	\N	\N	\N	\N	\N	Pa$$w0rd!	\N	20	\N	\N	\N	\N	\N	\N	104	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
171	manikant	 tiwari	mani3669@gmail.com	$2a$12$wDI6kFc/6.VVPTpmCwbVVuihvA6hSx7UamRcIeF/bnp0nDjmGB2Gy	\N	\N	\N	\N	8317082162	+91	\N	855296631232	ABCDE1234F	2005-12-10	male	ballu mafia	public_limited	manufacturing	57348957589	26473264389	ABCDE1234F	shivaji nagar colony, samneghat , lanka,varanasi	varanasi	Mumbai	221019	near noida one	dealer@gmail.com	\N	raju					Created from admin panel	Huw1usCN2DcxNC2HrvXZadJo	2025-11-26 06:21:56.482295	2025-11-26 06:30:30.587458	5	t	\N	\N	\N	\N	\N	Dealer@1234	\N	34	\N	\N	\N	\N	\N	\N	169	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	124485	2025-11-26 06:40:30.586628	f	\N	\N	f	f	f	f	f
170	rajuu	mishraa	raju23@gmail.com	$2a$12$qkepLk2nXarZkHJPSfMRJewvgTOmGHHym9gNJYvZHdccfnckPnQkm	\N	\N	\N	\N	9908233828	+91	\N	378243892463	ABCED1123F	2003-05-10	male	sand mafia	self	manufacturing	88888888	909091220	ABNSI2222K	noida one, noida	noida	Delhi	220122	near nokia	dealer@gmail.com	\N	77					Created from admin panel	9JU6an5cL5smtXWugq9jYvMX	2025-11-25 11:05:23.094218	2025-11-26 10:18:53.021601	5	t	\N	\N	\N	\N	\N	Dealer@1234	\N	34	\N	\N	\N	\N	\N	\N	169	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	t	\N	2025-11-26 10:18:53.020565	f	\N	\N	f	f	f	f	f
103	Master	kumar	master@gmail.com	$2a$12$/UeN5ofRoHdl30iPr1yLjOPBxHJK7yJnuVT3r1aqvKEAAT.fdULs2	\N	\N	\N	\N	77879987979	\N	78098798687	7987687576457476	JKGJGHJ688978	2025-08-22		Insurance Business	Insurance Business Ownership Type	Insurance Business Nature Type	98789798798787	986857644645cddsds	\N		noida	Uttar Pradesh	201301	\N	maste7879879	paid	HGG7897897	Axis	7988757678hgg	IFDD&775655	master	\N	\N	2025-08-29 05:50:45.95782	2025-12-18 09:32:14.583117	6	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2025-12-18 09:32:00.573391	f	\N	\N	f	f	f	f	f
172	mnaikant tiwari	tiwari	maniaknt123@gmail.com	$2a$12$1Oi/lr8MWgtNg2tOnyYcp.V54kXUQkMfWdScijEn1A.FZBfgjbhNS	\N	\N	\N	\N	1111111111	+91		222222222222	ABCDE1234F	2005-12-10	male	landlord	self	manufacturing	324324324324	4324234343	CBHPT1896J	noida one	noida	Bangalore	111111	nokia	dealer@gmail.com	\N	11					Created from admin panel	RNeSwF2nKJ7Sp3dDTVm9V39Y	2025-11-26 12:04:06.714296	2025-11-26 12:05:30.377238	5	t	\N	\N	\N	\N	\N	12345678	\N	34	\N	\N	\N	\N	\N	\N	169	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
169	Dealer	Khan	dealer@gmail.com	$2a$12$RSYHosLhNRfd20AQ2m1sI.6D/mbcITEOOTL5vAGeCJdaTlQn35lYq	\N	\N	\N	\N	9999999999	+91	\N	333333333333	DAJPC4150P	2025-11-01	male	abc	self	trading	123456	456789	CTUGE1616I	Muradnagr	Ghaziabad	Other	201206	dsf	dealer@123	\N	sid					Created from admin panel	Tx74F1bzeXQZAN4KzHyw3w9M	2025-11-24 06:24:00.075736	2025-12-18 09:14:27.032629	7	t	\N	\N	\N	\N	\N	dealer@123	\N	30	\N	\N	\N	\N	\N	\N	104	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2025-12-18 09:14:27.032229	f	\N	\N	f	f	f	f	f
139	Tej	singh	tej@gmail.com	$2a$12$5GhThPIzceuOy40FtudoheEJdfOXz2utRpS/hiw1ZwClVco1hlxp6	\N	159421	\N	\N	8317082162	\N	90889798798	787898779797977	JKGJGHJ688978	2025-09-02		LOAN SOULUTION	Loan Business Ownership	Loan Nature Type	328987097ds979d89787	986857644645cddsds	\N		noida	Uttar Pradesh	201301	\N	tej88989	\N	tej87787	HDFC	687687676776876	IFDD&775655	Tej	\N	d5d18358f7769e9086dd122a0afeed5cc306e63b	2025-09-04 09:05:42.906747	2025-12-27 11:24:12.323044	5	t	\N	\N	\N	\N	\N	tej123	\N	5	\N	\N	\N	\N	\N	\N	104	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2025-12-27 11:24:12.322192	f	2025-12-26 11:25:39.456644	38130008	f	f	f	f	f
175	udit	shah	udit11@gmail.com	$2a$12$d6dp8cjQrVHBf2AeWw0jGuB9Ul6nWr810XqtNcgv4zwu7Sc.RV3qq	\N	\N	\N	\N	9999999999	+91	\N	222222222222	ABCDE1234K	2006-12-10	male	sales man	self	wholesale	736835483574389	2878934738	CBHPT2907K	marmuraa, noida	noida	Chennai	222222	sector-59	udit11@gmail.com	\N	323					Created from admin panel	kbwgWbmngrYpffyDc9EpD8RN	2025-11-27 07:35:22.947821	2025-11-27 12:32:38.663071	5	t	\N	\N	\N	\N	\N	12309876	\N	38	\N	\N	\N	\N	\N	\N	169	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2025-11-27 12:32:38.662094	f	2025-11-27 09:09:17.96107	\N	f	f	f	f	f
173	aleem	malik	am12@gmail.com	$2a$12$UrPo2NRvkvrasfcVAUtbDei4dJMkAGmq9yqi0/tztK2UiWHnW7gIO	\N	\N	\N	\N	1234567891	+91	\N	111111111111	ABCDE1234F	2002-12-10	male	dwejkdfbwej	proprietor	wholesale	4y8932748324	4723643289	HDSBFJEFBJ	noids	noids	Pune	738984	nfjn	dealer@gmail.com	\N	df					Created from admin panel	qiRUpKzDnnaVXxKsn2qz7eCC	2025-11-26 12:09:10.924277	2025-11-26 12:11:24.281532	5	f	\N	\N	\N	\N	\N	12344321	\N	35	\N	\N	\N	\N	\N	\N	169	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	t	\N	2025-11-26 12:10:04.553921	f	\N	\N	f	f	f	f	f
177	dabbu	don	dabbu@gmail.com	$2a$12$/QKtJFA7aB4XLRKuYfOBx.p8sQP0nfDYnwONWZIzmaeckZbauG0HO	\N	\N	\N	\N	9999999999	+91	\N	777777777777	ABCDE1233K	2004-12-10	female	wejfnrejkg	proprietor	service	278463456349856	e3874y3474	ABDHWEBHEW	werbewkjhrbewjr,ebfrebk,ewhbrfre	lankaaa	Hyderabad	221012	fbehjfbfh, fndjngfdf	dabbu@gmail.com	\N	111111					Created from admin panel	7CjitfZp3JGRwDYJk3FDofJy	2025-12-12 09:21:57.454667	2025-12-12 11:49:50.380798	5	t	\N	\N	\N	\N	\N	Dabbu@12	\N	41	\N	\N	\N	\N	\N	\N	104	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	188984	2025-12-12 11:48:49.410401	f	2025-12-12 11:59:50.379931	\N	f	f	f	f	f
174	rohit	pandey	rohit12@gmail.com	$2a$12$EQNr81rHqpXzduJQ5SZX7OtW.1Ax042Yey8XDYPeO31zTzn5DgYGu	\N	\N	\N	\N	1234567123	+91	\N	333333333333	ABCDE1234K	2002-12-10	female	digital	self	wholesale	483927328	473284738	ABSBJSJ23B	noida 	noida	Mumbai	111111	nokia	dealer@gmail.com	\N	432432					Created from admin panel	vdrBdvWmgg82KXezfcdYmpvH	2025-11-26 12:42:31.316441	2025-11-26 12:43:47.969425	5	t	\N	\N	\N	\N	\N	12121212	\N	37	\N	\N	\N	\N	\N	\N	169	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	t	\N	2025-11-26 12:43:47.968737	f	\N	\N	f	f	f	f	f
178	ranilakxmi	bai	jyoti@gmail.com	$2a$12$TxqYaogrRKgLB73imy/WmeYVRxiAPyo5P5IAHKDbYyzcKQ9J2vmv.	\N	\N	\N	\N	9999999999	+91		754365894375	ABCDE1234G	2001-02-10	female	jferfjk	self	retail			POJYU1873O	NEW ASHOK NAGAR ROAD	New Delhi	Delhi	110096	assi	jyoti	\N	errfre					Created from admin panel	teHduoYq9sXHmWzqHsC59vLd	2025-12-18 09:49:00.962035	2025-12-18 12:33:50.934927	5	t	\N	\N	\N	\N	\N	12345678	\N	31	\N	\N	\N	\N	\N	\N	103	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2025-12-18 09:51:55.306914	f	\N	\N	f	f	f	f	f
179	Paramjyoti	Verma	paramjyoti@gmail.com	$2a$12$PEUT6TMJC2eUgGauoxEcmOUpn2PFtt3NJm9A4vWKWzn3o7rIlkAsO	\N	\N	\N	\N	7987514096	+91	\N	496301293359	BIRPV1623E	2000-02-22	female	Param	private_limited	retail	8968768769766	767868687	XGZFE7225	Sector	Greater Noida	Kolkata	201310		paramjyoti	\N	Admin					Created from admin panel	phH56EX81cxgJdqWY8Aj84gn	2025-12-22 07:05:41.201234	2025-12-22 08:40:37.805164	5	t	\N	\N	\N	\N	\N	paramjyoti123	\N	41	\N	\N	\N	\N	\N	\N	104	123456	123456	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2025-12-22 07:06:41.498872	f	\N	38130011	t	f	f	f	t
176	pritesh	babu	pritesh12@gmail.com	$2a$12$sEH7EE6Q/LTu097UN6L0cuH8.jUUZLTjQh5.72//eG9Hcc9z/0BDe	\N	\N	\N	\N	8317082162	+91	\N	888888888888	ABCDE1234H	2002-11-10	female	dsfdgdgdf	limited_liability	service	345345464566	dsfsdfd	ACDEF2233J	gfdgfghgfhfghghgf,sdggf	samneghat	Hyderabad	111111	dfsdf	pritesh12@gmail.com	\N	Admin					Created from admin panel	m7wwFtohFZazYpr1rYtXNBBo	2025-12-11 09:47:11.903644	2025-12-19 05:21:25.094237	5	t	\N	\N	\N	\N	\N	Pritesh@12	\N	23	\N	\N	\N	\N	\N	\N	104	654321	654321	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	t	t	\N	2025-12-19 05:21:25.093764	f	2025-12-11 10:01:18.387117	\N	f	f	f	f	f
180	admin	jdshdkhj	admin@gmail.com	$2a$12$FfYMXemZhT3PnJbeJ6AjuOj6rsAWHdPu6G5WoSeu6o92m3pCQQo.q	\N	\N	\N	\N	8797989787	\N	03443434334	876876876867233	JKGJGHJ688978	2000-02-16	Male	Business Name	Business Ownership Type	Business Nature Type	Business Registration Number	986857644645cddsds	\N	Gawalira	Saharanpur	Uttar Pradesh	247001	\N	sidtech78678	\N	HGG7897897	Axis	7988757678hgg	IFDD96875	Retailers	\N	6FUWfXmacmjmpP2JhfhUXuaa	2025-12-23 05:42:08.244472	2025-12-23 05:42:08.244472	9	f	\N	\N	\N	\N	\N	123456	admin	5	\N	\N	\N	\N	\N	\N	136	\N	\N	\N	\N	\N	\N	\N	\N	not_started	\N	\N	\N	\N	\N	not_started	not_started	\N	f	\N	{}	\N	\N	f	\N	\N	f	\N	\N	f	f	f	f	f
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
\.


--
-- Data for Name: wallets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallets (id, user_id, balance, created_at, updated_at) FROM stdin;
60	141	230.0	2025-09-12 12:11:31.809681	2025-09-12 12:49:13.271991
59	138	100.0	2025-09-12 12:06:33.547259	2025-09-12 12:22:20.631315
65	171	0.0	2025-11-26 12:51:20.891599	2025-11-26 12:51:20.891599
9	139	667.0	2025-09-08 05:43:00.575812	2025-12-27 10:57:10.543726
7	104	73792.2876	2025-09-06 12:32:32.749727	2025-12-27 10:57:10.600942
64	174	99.0	2025-11-26 12:44:46.994587	2025-11-26 12:59:12.509334
8	127	7115.08	2025-09-06 12:35:37.121371	2025-12-27 11:05:24.847468
58	136	508101.453399999999899	2025-09-12 10:29:25.138537	2025-12-27 11:05:24.889424
66	175	67.0	2025-11-27 07:38:01.017132	2025-11-27 12:38:48.61175
63	169	6628.38	2025-11-25 11:15:07.705043	2025-12-08 08:46:21.277387
61	145	270.0	2025-11-20 06:19:09.359179	2025-11-20 07:46:13.909998
10	134	47564.0	2025-09-08 06:37:14.67418	2025-11-21 07:49:32.843823
68	177	9.0	2025-12-12 11:53:39.860422	2025-12-12 11:55:00.447016
62	170	0.0	2025-11-25 11:09:21.348811	2025-11-25 11:09:21.348811
67	176	87.0	2025-12-11 10:00:01.558063	2025-12-18 07:23:09.543588
69	178	0.0	2025-12-18 09:59:40.450945	2025-12-18 09:59:40.450945
70	103	0.0	2025-12-18 10:01:39.815157	2025-12-18 10:01:39.815157
\.


--
-- Name: account_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_transactions_id_seq', 41, true);


--
-- Name: banks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.banks_id_seq', 38, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 58, true);


--
-- Name: commissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commissions_id_seq', 125, true);


--
-- Name: dmt_commission_slab_ranges_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dmt_commission_slab_ranges_id_seq', 10, true);


--
-- Name: dmt_commission_slabs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dmt_commission_slabs_id_seq', 52, true);


--
-- Name: dmt_commissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dmt_commissions_id_seq', 2, true);


--
-- Name: dmt_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dmt_transactions_id_seq', 59, true);


--
-- Name: dmts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dmts_id_seq', 63, true);


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

SELECT pg_catalog.setval('public.fund_requests_id_seq', 197, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 12, true);


--
-- Name: schemes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schemes_id_seq', 42, true);


--
-- Name: service_product_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_product_items_id_seq', 32, true);


--
-- Name: service_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.service_products_id_seq', 25, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 18, true);


--
-- Name: transaction_commissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaction_commissions_id_seq', 973, true);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 680, true);


--
-- Name: user_services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_services_id_seq', 155, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 180, true);


--
-- Name: wallet_transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallet_transactions_id_seq', 195, true);


--
-- Name: wallets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.wallets_id_seq', 70, true);


--
-- Name: account_transactions account_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_transactions
    ADD CONSTRAINT account_transactions_pkey PRIMARY KEY (id);


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
-- Name: commissions commissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commissions
    ADD CONSTRAINT commissions_pkey PRIMARY KEY (id);


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
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


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
-- Name: index_banks_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_banks_on_user_id ON public.banks USING btree (user_id);


--
-- Name: index_categories_on_service_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_categories_on_service_id ON public.categories USING btree (service_id);


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
-- Name: index_enquiries_on_role_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_enquiries_on_role_id ON public.enquiries USING btree (role_id);


--
-- Name: index_fund_requests_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_fund_requests_on_user_id ON public.fund_requests USING btree (user_id);


--
-- Name: index_schemes_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_schemes_on_user_id ON public.schemes USING btree (user_id);


--
-- Name: index_service_product_items_on_service_product_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_service_product_items_on_service_product_id ON public.service_product_items USING btree (service_product_id);


--
-- Name: index_service_products_on_category_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_service_products_on_category_id ON public.service_products USING btree (category_id);


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
-- Name: users fk_rails_093eb6ba73; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_093eb6ba73 FOREIGN KEY (service_id) REFERENCES public.services(id);


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
-- Name: dmt_commission_slabs fk_rails_9d4e97da1c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmt_commission_slabs
    ADD CONSTRAINT fk_rails_9d4e97da1c FOREIGN KEY (dmt_commission_slab_range_id) REFERENCES public.dmt_commission_slab_ranges(id);


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
-- Name: dmt_commission_slabs fk_rails_b3a8f82858; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dmt_commission_slabs
    ADD CONSTRAINT fk_rails_b3a8f82858 FOREIGN KEY (scheme_id) REFERENCES public.schemes(id);


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
-- Name: categories fk_rails_db8b64c2f7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT fk_rails_db8b64c2f7 FOREIGN KEY (service_id) REFERENCES public.services(id);


--
-- PostgreSQL database dump complete
--

