--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;
CREATE ROLE trainee;
ALTER ROLE trainee WITH NOSUPERUSER INHERIT NOCREATEROLE CREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md5e02814a24c4eb6fcacb0e4000a82ff01';






--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.0
-- Dumped by pg_dump version 12.0

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

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.0
-- Dumped by pg_dump version 12.0

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

--
-- PostgreSQL database dump complete
--

--
-- Database "training" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.0
-- Dumped by pg_dump version 12.0

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

--
-- Name: training; Type: DATABASE; Schema: -; Owner: trainee
--

CREATE DATABASE training WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE training OWNER TO trainee;

\connect training

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
-- Name: account_account; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.account_account (
    id integer NOT NULL,
    timezone character varying(100) NOT NULL,
    language character varying(10) NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.account_account OWNER TO trainee;

--
-- Name: account_account_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.account_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_account_id_seq OWNER TO trainee;

--
-- Name: account_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.account_account_id_seq OWNED BY public.account_account.id;


--
-- Name: account_accountdeletion; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.account_accountdeletion (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    date_requested timestamp with time zone NOT NULL,
    date_expunged timestamp with time zone,
    user_id integer
);


ALTER TABLE public.account_accountdeletion OWNER TO trainee;

--
-- Name: account_accountdeletion_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.account_accountdeletion_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_accountdeletion_id_seq OWNER TO trainee;

--
-- Name: account_accountdeletion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.account_accountdeletion_id_seq OWNED BY public.account_accountdeletion.id;


--
-- Name: account_emailaddress; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.account_emailaddress (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    verified boolean NOT NULL,
    "primary" boolean NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.account_emailaddress OWNER TO trainee;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.account_emailaddress_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_emailaddress_id_seq OWNER TO trainee;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.account_emailaddress_id_seq OWNED BY public.account_emailaddress.id;


--
-- Name: account_emailconfirmation; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.account_emailconfirmation (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    sent timestamp with time zone,
    key character varying(64) NOT NULL,
    email_address_id integer NOT NULL
);


ALTER TABLE public.account_emailconfirmation OWNER TO trainee;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.account_emailconfirmation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_emailconfirmation_id_seq OWNER TO trainee;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.account_emailconfirmation_id_seq OWNED BY public.account_emailconfirmation.id;


--
-- Name: account_passwordexpiry; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.account_passwordexpiry (
    id integer NOT NULL,
    expiry integer NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT account_passwordexpiry_expiry_check CHECK ((expiry >= 0))
);


ALTER TABLE public.account_passwordexpiry OWNER TO trainee;

--
-- Name: account_passwordexpiry_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.account_passwordexpiry_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_passwordexpiry_id_seq OWNER TO trainee;

--
-- Name: account_passwordexpiry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.account_passwordexpiry_id_seq OWNED BY public.account_passwordexpiry.id;


--
-- Name: account_passwordhistory; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.account_passwordhistory (
    id integer NOT NULL,
    password character varying(255) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.account_passwordhistory OWNER TO trainee;

--
-- Name: account_passwordhistory_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.account_passwordhistory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_passwordhistory_id_seq OWNER TO trainee;

--
-- Name: account_passwordhistory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.account_passwordhistory_id_seq OWNED BY public.account_passwordhistory.id;


--
-- Name: account_signupcode; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.account_signupcode (
    id integer NOT NULL,
    code character varying(64) NOT NULL,
    max_uses integer NOT NULL,
    expiry timestamp with time zone,
    email character varying(254) NOT NULL,
    notes text NOT NULL,
    sent timestamp with time zone,
    created timestamp with time zone NOT NULL,
    use_count integer NOT NULL,
    inviter_id integer,
    CONSTRAINT account_signupcode_max_uses_check CHECK ((max_uses >= 0)),
    CONSTRAINT account_signupcode_use_count_check CHECK ((use_count >= 0))
);


ALTER TABLE public.account_signupcode OWNER TO trainee;

--
-- Name: account_signupcode_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.account_signupcode_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_signupcode_id_seq OWNER TO trainee;

--
-- Name: account_signupcode_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.account_signupcode_id_seq OWNED BY public.account_signupcode.id;


--
-- Name: account_signupcoderesult; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.account_signupcoderesult (
    id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    signup_code_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.account_signupcoderesult OWNER TO trainee;

--
-- Name: account_signupcoderesult_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.account_signupcoderesult_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_signupcoderesult_id_seq OWNER TO trainee;

--
-- Name: account_signupcoderesult_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.account_signupcoderesult_id_seq OWNED BY public.account_signupcoderesult.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO trainee;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO trainee;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO trainee;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO trainee;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO trainee;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO trainee;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO trainee;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO trainee;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO trainee;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO trainee;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO trainee;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO trainee;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO trainee;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO trainee;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO trainee;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_celery_beat_clockedschedule; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.django_celery_beat_clockedschedule (
    id integer NOT NULL,
    clocked_time timestamp with time zone NOT NULL
);


ALTER TABLE public.django_celery_beat_clockedschedule OWNER TO trainee;

--
-- Name: django_celery_beat_clockedschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.django_celery_beat_clockedschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_clockedschedule_id_seq OWNER TO trainee;

--
-- Name: django_celery_beat_clockedschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.django_celery_beat_clockedschedule_id_seq OWNED BY public.django_celery_beat_clockedschedule.id;


--
-- Name: django_celery_beat_crontabschedule; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.django_celery_beat_crontabschedule (
    id integer NOT NULL,
    minute character varying(240) NOT NULL,
    hour character varying(96) NOT NULL,
    day_of_week character varying(64) NOT NULL,
    day_of_month character varying(124) NOT NULL,
    month_of_year character varying(64) NOT NULL,
    timezone character varying(63) NOT NULL
);


ALTER TABLE public.django_celery_beat_crontabschedule OWNER TO trainee;

--
-- Name: django_celery_beat_crontabschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.django_celery_beat_crontabschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_crontabschedule_id_seq OWNER TO trainee;

--
-- Name: django_celery_beat_crontabschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.django_celery_beat_crontabschedule_id_seq OWNED BY public.django_celery_beat_crontabschedule.id;


--
-- Name: django_celery_beat_intervalschedule; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.django_celery_beat_intervalschedule (
    id integer NOT NULL,
    every integer NOT NULL,
    period character varying(24) NOT NULL
);


ALTER TABLE public.django_celery_beat_intervalschedule OWNER TO trainee;

--
-- Name: django_celery_beat_intervalschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.django_celery_beat_intervalschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_intervalschedule_id_seq OWNER TO trainee;

--
-- Name: django_celery_beat_intervalschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.django_celery_beat_intervalschedule_id_seq OWNED BY public.django_celery_beat_intervalschedule.id;


--
-- Name: django_celery_beat_periodictask; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.django_celery_beat_periodictask (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    task character varying(200) NOT NULL,
    args text NOT NULL,
    kwargs text NOT NULL,
    queue character varying(200),
    exchange character varying(200),
    routing_key character varying(200),
    expires timestamp with time zone,
    enabled boolean NOT NULL,
    last_run_at timestamp with time zone,
    total_run_count integer NOT NULL,
    date_changed timestamp with time zone NOT NULL,
    description text NOT NULL,
    crontab_id integer,
    interval_id integer,
    solar_id integer,
    one_off boolean NOT NULL,
    start_time timestamp with time zone,
    priority integer,
    headers text NOT NULL,
    clocked_id integer,
    expire_seconds integer,
    CONSTRAINT django_celery_beat_periodictask_expire_seconds_check CHECK ((expire_seconds >= 0)),
    CONSTRAINT django_celery_beat_periodictask_priority_check CHECK ((priority >= 0)),
    CONSTRAINT django_celery_beat_periodictask_total_run_count_check CHECK ((total_run_count >= 0))
);


ALTER TABLE public.django_celery_beat_periodictask OWNER TO trainee;

--
-- Name: django_celery_beat_periodictask_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.django_celery_beat_periodictask_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_periodictask_id_seq OWNER TO trainee;

--
-- Name: django_celery_beat_periodictask_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.django_celery_beat_periodictask_id_seq OWNED BY public.django_celery_beat_periodictask.id;


--
-- Name: django_celery_beat_periodictasks; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.django_celery_beat_periodictasks (
    ident smallint NOT NULL,
    last_update timestamp with time zone NOT NULL
);


ALTER TABLE public.django_celery_beat_periodictasks OWNER TO trainee;

--
-- Name: django_celery_beat_solarschedule; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.django_celery_beat_solarschedule (
    id integer NOT NULL,
    event character varying(24) NOT NULL,
    latitude numeric(9,6) NOT NULL,
    longitude numeric(9,6) NOT NULL
);


ALTER TABLE public.django_celery_beat_solarschedule OWNER TO trainee;

--
-- Name: django_celery_beat_solarschedule_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.django_celery_beat_solarschedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_beat_solarschedule_id_seq OWNER TO trainee;

--
-- Name: django_celery_beat_solarschedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.django_celery_beat_solarschedule_id_seq OWNED BY public.django_celery_beat_solarschedule.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO trainee;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO trainee;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO trainee;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO trainee;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO trainee;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO trainee;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.django_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO trainee;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.django_site_id_seq OWNED BY public.django_site.id;


--
-- Name: registration_profile; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.registration_profile (
    id integer NOT NULL,
    is_confirmed boolean NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.registration_profile OWNER TO trainee;

--
-- Name: registration_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.registration_profile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.registration_profile_id_seq OWNER TO trainee;

--
-- Name: registration_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.registration_profile_id_seq OWNED BY public.registration_profile.id;


--
-- Name: trading_balance; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.trading_balance (
    id integer NOT NULL,
    amount numeric(30,3) NOT NULL,
    currency_id integer,
    user_id integer NOT NULL
);


ALTER TABLE public.trading_balance OWNER TO trainee;

--
-- Name: trading_balance_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.trading_balance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trading_balance_id_seq OWNER TO trainee;

--
-- Name: trading_balance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.trading_balance_id_seq OWNED BY public.trading_balance.id;


--
-- Name: trading_currency; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.trading_currency (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    code character varying(10) NOT NULL
);


ALTER TABLE public.trading_currency OWNER TO trainee;

--
-- Name: trading_currency_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.trading_currency_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trading_currency_id_seq OWNER TO trainee;

--
-- Name: trading_currency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.trading_currency_id_seq OWNED BY public.trading_currency.id;


--
-- Name: trading_inventory; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.trading_inventory (
    id integer NOT NULL,
    quantity integer NOT NULL,
    item_id integer NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT trading_inventory_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.trading_inventory OWNER TO trainee;

--
-- Name: trading_inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.trading_inventory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trading_inventory_id_seq OWNER TO trainee;

--
-- Name: trading_inventory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.trading_inventory_id_seq OWNED BY public.trading_inventory.id;


--
-- Name: trading_item; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.trading_item (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    code character varying(10) NOT NULL,
    price numeric(7,2) NOT NULL,
    details text,
    currency_id integer
);


ALTER TABLE public.trading_item OWNER TO trainee;

--
-- Name: trading_item_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.trading_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trading_item_id_seq OWNER TO trainee;

--
-- Name: trading_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.trading_item_id_seq OWNED BY public.trading_item.id;


--
-- Name: trading_offer; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.trading_offer (
    id integer NOT NULL,
    entry_quantity integer NOT NULL,
    quantity integer NOT NULL,
    order_type character varying(6) NOT NULL,
    price numeric(7,2) NOT NULL,
    item_id integer NOT NULL,
    user_id integer NOT NULL,
    is_active boolean NOT NULL,
    CONSTRAINT trading_offer_entry_quantity_check CHECK ((entry_quantity >= 0)),
    CONSTRAINT trading_offer_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.trading_offer OWNER TO trainee;

--
-- Name: trading_offer_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.trading_offer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trading_offer_id_seq OWNER TO trainee;

--
-- Name: trading_offer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.trading_offer_id_seq OWNED BY public.trading_offer.id;


--
-- Name: trading_price; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.trading_price (
    id integer NOT NULL,
    price numeric(7,2) NOT NULL,
    date timestamp with time zone NOT NULL,
    currency_id integer,
    item_id integer NOT NULL
);


ALTER TABLE public.trading_price OWNER TO trainee;

--
-- Name: trading_price_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.trading_price_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trading_price_id_seq OWNER TO trainee;

--
-- Name: trading_price_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.trading_price_id_seq OWNED BY public.trading_price.id;


--
-- Name: trading_trade; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.trading_trade (
    id integer NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(7,2) NOT NULL,
    description text,
    buyer_id integer,
    buyer_offer_id integer,
    item_id integer,
    seller_id integer,
    seller_offer_id integer,
    creation_time timestamp with time zone NOT NULL,
    CONSTRAINT trading_trade_quantity_check CHECK ((quantity >= 0))
);


ALTER TABLE public.trading_trade OWNER TO trainee;

--
-- Name: trading_trade_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.trading_trade_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trading_trade_id_seq OWNER TO trainee;

--
-- Name: trading_trade_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.trading_trade_id_seq OWNED BY public.trading_trade.id;


--
-- Name: trading_watchlist; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.trading_watchlist (
    id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.trading_watchlist OWNER TO trainee;

--
-- Name: trading_watchlist_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.trading_watchlist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trading_watchlist_id_seq OWNER TO trainee;

--
-- Name: trading_watchlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.trading_watchlist_id_seq OWNED BY public.trading_watchlist.id;


--
-- Name: trading_watchlist_item; Type: TABLE; Schema: public; Owner: trainee
--

CREATE TABLE public.trading_watchlist_item (
    id integer NOT NULL,
    watchlist_id integer NOT NULL,
    item_id integer NOT NULL
);


ALTER TABLE public.trading_watchlist_item OWNER TO trainee;

--
-- Name: trading_watchlist_item_id_seq; Type: SEQUENCE; Schema: public; Owner: trainee
--

CREATE SEQUENCE public.trading_watchlist_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.trading_watchlist_item_id_seq OWNER TO trainee;

--
-- Name: trading_watchlist_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: trainee
--

ALTER SEQUENCE public.trading_watchlist_item_id_seq OWNED BY public.trading_watchlist_item.id;


--
-- Name: account_account id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_account ALTER COLUMN id SET DEFAULT nextval('public.account_account_id_seq'::regclass);


--
-- Name: account_accountdeletion id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_accountdeletion ALTER COLUMN id SET DEFAULT nextval('public.account_accountdeletion_id_seq'::regclass);


--
-- Name: account_emailaddress id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_emailaddress ALTER COLUMN id SET DEFAULT nextval('public.account_emailaddress_id_seq'::regclass);


--
-- Name: account_emailconfirmation id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_emailconfirmation ALTER COLUMN id SET DEFAULT nextval('public.account_emailconfirmation_id_seq'::regclass);


--
-- Name: account_passwordexpiry id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_passwordexpiry ALTER COLUMN id SET DEFAULT nextval('public.account_passwordexpiry_id_seq'::regclass);


--
-- Name: account_passwordhistory id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_passwordhistory ALTER COLUMN id SET DEFAULT nextval('public.account_passwordhistory_id_seq'::regclass);


--
-- Name: account_signupcode id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_signupcode ALTER COLUMN id SET DEFAULT nextval('public.account_signupcode_id_seq'::regclass);


--
-- Name: account_signupcoderesult id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_signupcoderesult ALTER COLUMN id SET DEFAULT nextval('public.account_signupcoderesult_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_celery_beat_clockedschedule id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_celery_beat_clockedschedule ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_clockedschedule_id_seq'::regclass);


--
-- Name: django_celery_beat_crontabschedule id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_celery_beat_crontabschedule ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_crontabschedule_id_seq'::regclass);


--
-- Name: django_celery_beat_intervalschedule id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_celery_beat_intervalschedule ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_intervalschedule_id_seq'::regclass);


--
-- Name: django_celery_beat_periodictask id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_celery_beat_periodictask ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_periodictask_id_seq'::regclass);


--
-- Name: django_celery_beat_solarschedule id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_celery_beat_solarschedule ALTER COLUMN id SET DEFAULT nextval('public.django_celery_beat_solarschedule_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: django_site id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_site ALTER COLUMN id SET DEFAULT nextval('public.django_site_id_seq'::regclass);


--
-- Name: registration_profile id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.registration_profile ALTER COLUMN id SET DEFAULT nextval('public.registration_profile_id_seq'::regclass);


--
-- Name: trading_balance id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_balance ALTER COLUMN id SET DEFAULT nextval('public.trading_balance_id_seq'::regclass);


--
-- Name: trading_currency id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_currency ALTER COLUMN id SET DEFAULT nextval('public.trading_currency_id_seq'::regclass);


--
-- Name: trading_inventory id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_inventory ALTER COLUMN id SET DEFAULT nextval('public.trading_inventory_id_seq'::regclass);


--
-- Name: trading_item id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_item ALTER COLUMN id SET DEFAULT nextval('public.trading_item_id_seq'::regclass);


--
-- Name: trading_offer id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_offer ALTER COLUMN id SET DEFAULT nextval('public.trading_offer_id_seq'::regclass);


--
-- Name: trading_price id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_price ALTER COLUMN id SET DEFAULT nextval('public.trading_price_id_seq'::regclass);


--
-- Name: trading_trade id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_trade ALTER COLUMN id SET DEFAULT nextval('public.trading_trade_id_seq'::regclass);


--
-- Name: trading_watchlist id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_watchlist ALTER COLUMN id SET DEFAULT nextval('public.trading_watchlist_id_seq'::regclass);


--
-- Name: trading_watchlist_item id; Type: DEFAULT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_watchlist_item ALTER COLUMN id SET DEFAULT nextval('public.trading_watchlist_item_id_seq'::regclass);


--
-- Data for Name: account_account; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.account_account (id, timezone, language, user_id) FROM stdin;
\.


--
-- Data for Name: account_accountdeletion; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.account_accountdeletion (id, email, date_requested, date_expunged, user_id) FROM stdin;
\.


--
-- Data for Name: account_emailaddress; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.account_emailaddress (id, email, verified, "primary", user_id) FROM stdin;
\.


--
-- Data for Name: account_emailconfirmation; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.account_emailconfirmation (id, created, sent, key, email_address_id) FROM stdin;
\.


--
-- Data for Name: account_passwordexpiry; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.account_passwordexpiry (id, expiry, user_id) FROM stdin;
\.


--
-- Data for Name: account_passwordhistory; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.account_passwordhistory (id, password, "timestamp", user_id) FROM stdin;
\.


--
-- Data for Name: account_signupcode; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.account_signupcode (id, code, max_uses, expiry, email, notes, sent, created, use_count, inviter_id) FROM stdin;
\.


--
-- Data for Name: account_signupcoderesult; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.account_signupcoderesult (id, "timestamp", signup_code_id, user_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add price	7	add_price
26	Can change price	7	change_price
27	Can delete price	7	delete_price
28	Can view price	7	view_price
29	Can add trade	8	add_trade
30	Can change trade	8	change_trade
31	Can delete trade	8	delete_trade
32	Can view trade	8	view_trade
33	Can add item	9	add_item
34	Can change item	9	change_item
35	Can delete item	9	delete_item
36	Can view item	9	view_item
37	Can add offer	10	add_offer
38	Can change offer	10	change_offer
39	Can delete offer	10	delete_offer
40	Can view offer	10	view_offer
41	Can add balance	11	add_balance
42	Can change balance	11	change_balance
43	Can delete balance	11	delete_balance
44	Can view balance	11	view_balance
45	Can add watch list	12	add_watchlist
46	Can change watch list	12	change_watchlist
47	Can delete watch list	12	delete_watchlist
48	Can view watch list	12	view_watchlist
49	Can add inventory	13	add_inventory
50	Can change inventory	13	change_inventory
51	Can delete inventory	13	delete_inventory
52	Can view inventory	13	view_inventory
53	Can add Currency	14	add_currency
54	Can change Currency	14	change_currency
55	Can delete Currency	14	delete_currency
56	Can view Currency	14	view_currency
57	Can add Token	15	add_token
58	Can change Token	15	change_token
59	Can delete Token	15	delete_token
60	Can view Token	15	view_token
61	Can add token	16	add_tokenproxy
62	Can change token	16	change_tokenproxy
63	Can delete token	16	delete_tokenproxy
64	Can view token	16	view_tokenproxy
65	Can add crontab	17	add_crontabschedule
66	Can change crontab	17	change_crontabschedule
67	Can delete crontab	17	delete_crontabschedule
68	Can view crontab	17	view_crontabschedule
69	Can add interval	18	add_intervalschedule
70	Can change interval	18	change_intervalschedule
71	Can delete interval	18	delete_intervalschedule
72	Can view interval	18	view_intervalschedule
73	Can add periodic task	19	add_periodictask
74	Can change periodic task	19	change_periodictask
75	Can delete periodic task	19	delete_periodictask
76	Can view periodic task	19	view_periodictask
77	Can add periodic tasks	20	add_periodictasks
78	Can change periodic tasks	20	change_periodictasks
79	Can delete periodic tasks	20	delete_periodictasks
80	Can view periodic tasks	20	view_periodictasks
81	Can add solar event	21	add_solarschedule
82	Can change solar event	21	change_solarschedule
83	Can delete solar event	21	delete_solarschedule
84	Can view solar event	21	view_solarschedule
85	Can add clocked	22	add_clockedschedule
86	Can change clocked	22	change_clockedschedule
87	Can delete clocked	22	delete_clockedschedule
88	Can view clocked	22	view_clockedschedule
89	Can add site	23	add_site
90	Can change site	23	change_site
91	Can delete site	23	delete_site
92	Can view site	23	view_site
93	Can add account	24	add_account
94	Can change account	24	change_account
95	Can delete account	24	delete_account
96	Can view account	24	view_account
97	Can add account deletion	25	add_accountdeletion
98	Can change account deletion	25	change_accountdeletion
99	Can delete account deletion	25	delete_accountdeletion
100	Can view account deletion	25	view_accountdeletion
101	Can add email address	26	add_emailaddress
102	Can change email address	26	change_emailaddress
103	Can delete email address	26	delete_emailaddress
104	Can view email address	26	view_emailaddress
105	Can add email confirmation	27	add_emailconfirmation
106	Can change email confirmation	27	change_emailconfirmation
107	Can delete email confirmation	27	delete_emailconfirmation
108	Can view email confirmation	27	view_emailconfirmation
109	Can add signup code	28	add_signupcode
110	Can change signup code	28	change_signupcode
111	Can delete signup code	28	delete_signupcode
112	Can view signup code	28	view_signupcode
113	Can add signup code result	29	add_signupcoderesult
114	Can change signup code result	29	change_signupcoderesult
115	Can delete signup code result	29	delete_signupcoderesult
116	Can view signup code result	29	view_signupcoderesult
117	Can add password expiry	30	add_passwordexpiry
118	Can change password expiry	30	change_passwordexpiry
119	Can delete password expiry	30	delete_passwordexpiry
120	Can view password expiry	30	view_passwordexpiry
121	Can add password history	31	add_passwordhistory
122	Can change password history	31	change_passwordhistory
123	Can delete password history	31	delete_passwordhistory
124	Can view password history	31	view_passwordhistory
125	Can add profile	32	add_profile
126	Can change profile	32	change_profile
127	Can delete profile	32	delete_profile
128	Can view profile	32	view_profile
129	Can add ItemStat	33	add_itemstats
130	Can change ItemStat	33	change_itemstats
131	Can delete ItemStat	33	delete_itemstats
132	Can view ItemStat	33	view_itemstats
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
7	pbkdf2_sha256$216000$Mg1uFKuWFNI1$wGjj5+miKXVJjVERFLGIScr2waSaQPOKi7y9pBOxZcA=	2020-12-24 12:35:29+00	t	admin			adminmail@tradingservice.org	t	t	2020-12-24 11:31:19+00
32	adsfsd	\N	f	fkdfdk	dssfs	sdfs	example@chwer.com	f	t	2020-12-30 13:15:57.183068+00
33	pbkdf2_sha256$216000$HIUxAv67COlJ$NwCp67VP3tX2JjNQCQk/CuA4w3BihPBjtOE0U/S7eKE=	2020-12-31 08:43:00.554385+00	t	whoami				t	t	2020-12-31 08:41:23.400943+00
41	pbkdf2_sha256$216000$zQMocFnxrjyq$wjTwjxAa2Ewyie3xmAs2PEACB7LIh/IPTaQnjUJyCsw=	\N	f	01achopik	Artem		a-chopik@mail.ru	f	t	2020-12-31 10:18:05.414184+00
1	pbkdf2_sha256$216000$8Vc0EDYCqF6b$UhP0tSqtcNkJR6y2MHAp2eEQBw8/3Bi0SHyaFoqgy3g=	2021-01-01 11:18:47.052964+00	t	trainee				t	t	2020-12-16 15:19:04.805074+00
2	test1	\N	f	test				f	t	2020-12-18 17:53:13.412609+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.authtoken_token (key, created, user_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2020-12-24 11:25:24.917531+00	6	admin	3		4	1
2	2020-12-24 11:32:58.674393+00	6	Balance object (6)	3		11	1
3	2020-12-24 11:32:58.683582+00	2	Balance object (2)	3		11	1
4	2020-12-24 11:32:58.685886+00	1	Balance object (1)	3		11	1
5	2020-12-24 11:46:44.338027+00	98	Trade object (98)	3		8	1
6	2020-12-24 11:46:44.353482+00	97	Trade object (97)	3		8	1
7	2020-12-24 11:46:44.355769+00	96	Trade object (96)	3		8	1
8	2020-12-24 11:46:44.357641+00	95	Trade object (95)	3		8	1
9	2020-12-24 11:46:44.360341+00	94	Trade object (94)	3		8	1
10	2020-12-24 11:46:44.362417+00	93	Trade object (93)	3		8	1
11	2020-12-24 11:46:44.364353+00	92	Trade object (92)	3		8	1
12	2020-12-24 11:46:44.366509+00	91	Trade object (91)	3		8	1
13	2020-12-24 11:46:44.368741+00	90	Trade object (90)	3		8	1
14	2020-12-24 11:46:44.370753+00	89	Trade object (89)	3		8	1
15	2020-12-24 11:46:44.372755+00	2	Trade object (2)	3		8	1
16	2020-12-24 11:46:44.374477+00	1	Trade object (1)	3		8	1
17	2020-12-24 12:30:05.826499+00	1	SELL: AAPL	3		10	1
18	2020-12-24 12:30:26.493605+00	2	SELL: AAPL	2	[]	10	1
19	2020-12-24 12:31:01.607213+00	1	Inventory object (1)	2	[{"changed": {"fields": ["Item", "Stocks quantity"]}}]	13	1
20	2020-12-24 12:31:11.734941+00	8	Balance object (8)	2	[{"changed": {"fields": ["Amount"]}}]	11	1
21	2020-12-29 09:13:23.311245+00	8	achopik	3		4	7
22	2020-12-29 12:19:43.234715+00	9	achopik	3		4	7
23	2020-12-29 12:19:43.249692+00	10	aphopik	3		4	7
24	2020-12-29 12:19:43.2546+00	11	tsktk	3		4	7
25	2020-12-29 13:02:02.439716+00	12	achopik	3		4	7
26	2020-12-29 13:02:02.451773+00	17	dfd0d0	3		4	7
27	2020-12-29 13:02:02.454734+00	14	teewe	3		4	7
28	2020-12-29 13:02:02.45741+00	15	test01	3		4	7
29	2020-12-29 13:02:02.459881+00	16	test0232	3		4	7
30	2020-12-29 13:02:02.462395+00	13	test1	3		4	7
31	2020-12-29 14:01:28.924321+00	18	achopik	3		4	7
32	2020-12-29 14:01:28.938369+00	19	test01	3		4	7
33	2020-12-29 14:01:28.941511+00	20	test0124	3		4	7
34	2020-12-29 14:01:28.944117+00	21	test10210	3		4	7
35	2020-12-29 14:38:55.901491+00	7	admin	2	[{"changed": {"fields": ["Email address"]}}]	4	1
36	2020-12-29 14:39:12.534477+00	17	admin's profile	1	[{"added": {}}]	32	1
37	2020-12-29 14:39:24.934603+00	18	trainee's profile	1	[{"added": {}}]	32	1
38	2020-12-30 06:44:56.456269+00	24	a-chopik	3		4	7
39	2020-12-30 06:44:56.4712+00	22	achopik	3		4	7
40	2020-12-30 06:44:56.473362+00	23	achpok	3		4	7
41	2020-12-30 07:09:47.338716+00	27	achiopk	3		4	1
42	2020-12-30 07:09:47.349127+00	25	a-chopik	3		4	1
43	2020-12-30 07:09:47.351198+00	26	achopik	3		4	1
44	2020-12-30 14:02:35.025752+00	31	af-f--f	3		4	7
45	2020-12-30 14:02:35.037823+00	29	testapi	3		4	7
46	2020-12-30 14:02:35.039717+00	30	testoro	3		4	7
47	2020-12-31 08:44:01.626041+00	1	trainee	2	[{"changed": {"fields": ["password"]}}]	4	33
48	2020-12-31 09:32:55.374296+00	28	achopik	3		4	33
49	2020-12-31 09:56:42.485661+00	35	achopik2	3		4	33
50	2020-12-31 10:11:19.726865+00	34	achopik	3		4	7
51	2021-01-01 10:30:57.297438+00	1	Inventory object (1)	2	[{"changed": {"fields": ["Stocks quantity"]}}]	13	1
52	2021-01-01 10:31:09.662241+00	7	Balance object (7)	2	[]	11	1
\.


--
-- Data for Name: django_celery_beat_clockedschedule; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.django_celery_beat_clockedschedule (id, clocked_time) FROM stdin;
\.


--
-- Data for Name: django_celery_beat_crontabschedule; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.django_celery_beat_crontabschedule (id, minute, hour, day_of_week, day_of_month, month_of_year, timezone) FROM stdin;
1	0	4	*	*	*	UTC
\.


--
-- Data for Name: django_celery_beat_intervalschedule; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.django_celery_beat_intervalschedule (id, every, period) FROM stdin;
1	60	seconds
3	15	seconds
2	6000	seconds
4	6	seconds
\.


--
-- Data for Name: django_celery_beat_periodictask; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.django_celery_beat_periodictask (id, name, task, args, kwargs, queue, exchange, routing_key, expires, enabled, last_run_at, total_run_count, date_changed, description, crontab_id, interval_id, solar_id, one_off, start_time, priority, headers, clocked_id, expire_seconds) FROM stdin;
1	celery.backend_cleanup	celery.backend_cleanup	[]	{}	\N	\N	\N	\N	t	2021-01-05 10:21:24.923201+00	6	2021-01-05 17:01:20.865311+00		1	\N	\N	f	\N	\N	{}	\N	43200
4	update-item-stats-every-15-seconds	trading.tasks.update_offer_stats	[]	{}	\N	\N	\N	\N	t	2021-01-05 17:01:20.997149+00	1184	2021-01-05 17:01:21.054312+00		\N	3	\N	f	\N	\N	{}	\N	\N
3	perform-offers-every-minute	trading.tasks.search_offers	[]	{}	\N	\N	\N	\N	t	2021-01-05 17:01:27.07793+00	5	2021-01-05 17:01:29.39055+00		\N	4	\N	f	\N	\N	{}	\N	\N
2	search-offers-every-minute	trading.tasks.search_offers	[]	{}	\N	\N	\N	\N	t	2021-01-05 17:01:24.910987+00	732	2021-01-05 17:01:29.432252+00		\N	2	\N	f	\N	\N	{}	\N	\N
\.


--
-- Data for Name: django_celery_beat_periodictasks; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.django_celery_beat_periodictasks (ident, last_update) FROM stdin;
1	2021-01-05 17:01:20.911834+00
\.


--
-- Data for Name: django_celery_beat_solarschedule; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.django_celery_beat_solarschedule (id, event, latitude, longitude) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	trading	price
8	trading	trade
9	trading	item
10	trading	offer
11	trading	balance
12	trading	watchlist
13	trading	inventory
14	trading	currency
15	authtoken	token
16	authtoken	tokenproxy
17	django_celery_beat	crontabschedule
18	django_celery_beat	intervalschedule
19	django_celery_beat	periodictask
20	django_celery_beat	periodictasks
21	django_celery_beat	solarschedule
22	django_celery_beat	clockedschedule
23	sites	site
24	account	account
25	account	accountdeletion
26	account	emailaddress
27	account	emailconfirmation
28	account	signupcode
29	account	signupcoderesult
30	account	passwordexpiry
31	account	passwordhistory
32	registration	profile
33	trading	itemstats
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2020-12-16 14:08:10.719301+00
2	auth	0001_initial	2020-12-16 14:08:10.930637+00
3	admin	0001_initial	2020-12-16 14:08:11.2226+00
4	admin	0002_logentry_remove_auto_add	2020-12-16 14:08:11.267531+00
5	admin	0003_logentry_add_action_flag_choices	2020-12-16 14:08:11.28478+00
6	contenttypes	0002_remove_content_type_name	2020-12-16 14:08:11.325374+00
7	auth	0002_alter_permission_name_max_length	2020-12-16 14:08:11.340295+00
8	auth	0003_alter_user_email_max_length	2020-12-16 14:08:11.357279+00
9	auth	0004_alter_user_username_opts	2020-12-16 14:08:11.373275+00
10	auth	0005_alter_user_last_login_null	2020-12-16 14:08:11.391723+00
11	auth	0006_require_contenttypes_0002	2020-12-16 14:08:11.39717+00
12	auth	0007_alter_validators_add_error_messages	2020-12-16 14:08:11.412176+00
13	auth	0008_alter_user_username_max_length	2020-12-16 14:08:11.460562+00
14	auth	0009_alter_user_last_name_max_length	2020-12-16 14:08:11.476665+00
15	auth	0010_alter_group_name_max_length	2020-12-16 14:08:11.496839+00
16	auth	0011_update_proxy_permissions	2020-12-16 14:08:11.511241+00
17	auth	0012_alter_user_first_name_max_length	2020-12-16 14:08:11.527524+00
18	sessions	0001_initial	2020-12-16 14:08:11.572285+00
19	trading	0001_initial	2020-12-16 15:01:02.504617+00
20	trading	0002_offer_user	2020-12-17 10:11:26.597644+00
21	trading	0003_auto_20201217_1029	2020-12-17 10:29:28.470071+00
22	authtoken	0001_initial	2020-12-20 22:05:52.705607+00
23	authtoken	0002_auto_20160226_1747	2020-12-20 22:05:52.969018+00
24	authtoken	0003_tokenproxy	2020-12-20 22:05:52.97537+00
25	trading	0004_auto_20201220_2209	2020-12-20 22:09:12.040209+00
26	trading	0005_remove_offer_is_active	2020-12-21 16:01:35.360892+00
27	trading	0006_offer_is_active	2020-12-22 09:36:32.872274+00
28	trading	0007_auto_20201223_1347	2020-12-23 13:47:38.531614+00
29	django_celery_beat	0001_initial	2020-12-24 11:20:01.8389+00
30	django_celery_beat	0002_auto_20161118_0346	2020-12-24 11:20:01.954769+00
31	django_celery_beat	0003_auto_20161209_0049	2020-12-24 11:20:01.994945+00
32	django_celery_beat	0004_auto_20170221_0000	2020-12-24 11:20:02.005618+00
33	django_celery_beat	0005_add_solarschedule_events_choices	2020-12-24 11:20:02.018305+00
34	django_celery_beat	0006_auto_20180322_0932	2020-12-24 11:20:02.09575+00
35	django_celery_beat	0007_auto_20180521_0826	2020-12-24 11:20:02.11851+00
36	django_celery_beat	0008_auto_20180914_1922	2020-12-24 11:20:02.151668+00
37	django_celery_beat	0006_auto_20180210_1226	2020-12-24 11:20:02.174128+00
38	django_celery_beat	0006_periodictask_priority	2020-12-24 11:20:02.189095+00
39	django_celery_beat	0009_periodictask_headers	2020-12-24 11:20:02.204123+00
40	django_celery_beat	0010_auto_20190429_0326	2020-12-24 11:20:02.539465+00
41	django_celery_beat	0011_auto_20190508_0153	2020-12-24 11:20:02.581025+00
42	django_celery_beat	0012_periodictask_expire_seconds	2020-12-24 11:20:02.603673+00
43	django_celery_beat	0013_auto_20200609_0727	2020-12-24 11:20:02.615489+00
44	django_celery_beat	0014_remove_clockedschedule_enabled	2020-12-24 11:20:02.625636+00
45	account	0001_initial	2020-12-28 20:04:28.422187+00
46	account	0002_fix_str	2020-12-28 20:04:28.743163+00
47	account	0003_passwordexpiry_passwordhistory	2020-12-28 20:04:28.875966+00
48	account	0004_auto_20170416_1821	2020-12-28 20:04:28.94117+00
49	account	0005_update_default_language	2020-12-28 20:04:28.97536+00
50	sites	0001_initial	2020-12-28 20:04:29.008375+00
51	sites	0002_alter_domain_unique	2020-12-28 20:04:29.040166+00
52	registration	0001_initial	2020-12-29 09:10:19.425463+00
53	trading	0008_auto_20201229_1450	2020-12-29 15:00:13.056684+00
54	trading	0009_auto_20201231_0824	2020-12-31 08:27:55.177722+00
55	trading	0010_auto_20210101_1115	2021-01-01 11:16:08.074207+00
56	trading	0011_itemstats	2021-01-04 21:56:16.034511+00
57	trading	0012_auto_20210104_2231	2021-01-04 22:31:24.065945+00
58	trading	0013_delete_itemstats	2021-01-05 10:31:56.466593+00
59	trading	0014_trade_creation_time	2021-01-05 13:28:49.679014+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
bwkl9d0shcpc8ho2h6bdodgfx2e0ijx9	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kpt6X:x3IWa65ucajF-w9gXOSMebdVK4PjkddNB48AdP1uOy0	2020-12-31 13:14:01.127515+00
cjb2l9a3tsr7a6zi1xbffkpwmbdxvmbv	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kpt6d:YoLro-qf4huVfyfqBxOHBttp1IlqJizMnplkxvhf_YQ	2020-12-31 13:14:07.499212+00
jik9ncsg2rmb746435pnrt670nia28dj	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptCw:aO5r39A4KIUgRXfnkfO71zxw7Oa4hA8RoZ0sIKH8x_c	2020-12-31 13:20:38.736856+00
0vjpin3cbhw5eht9j5djtcqhmowgxghh	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptD2:Z6FPNqWYK6UThlmzZbLFJi5NLl9ww6bQbyfs-2QQGs4	2020-12-31 13:20:44.642662+00
k3svsel4e8f9k3j6kukpz8npfq854ufv	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptF2:dlXQn1P4-lnmh016UPNkXPE6TYjurgwafc7g7n4SdRs	2020-12-31 13:22:48.495324+00
6jgkwg47gv80drlf2vkxqk998nh9qkfj	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptG9:WKHIsdtZCzTvHd9GJZCnBWW7nLrjBOfo618cf0bgzrg	2020-12-31 13:23:57.53977+00
qr1swixwwm0xd8qx92ji2a8ke5yojxxf	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptGO:DRpttXBZWjRurajIIJf53jzTfYry-8AJ4H_zYS8sN2w	2020-12-31 13:24:12.024115+00
wv5fcu8d6agza3i4srx19etmagq09ma5	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptGt:EUN-namUoLG3VShG7201W4rEUi6ABWECEdpFjl3Ilig	2020-12-31 13:24:43.799209+00
78it9sn21h8wzygcsav1w456vs3l7h5u	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptIF:dieT416QvjKlkcbczEATbd8VpylhSQy45HK-OkKT2_s	2020-12-31 13:26:07.633322+00
f0ww2hn7pjuff9wquks63ux7p69fp2hk	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptIX:9V-14kBEq21hCcQcvP1gNni9Wz4pNgvPS9L20t6jvz0	2020-12-31 13:26:25.339908+00
61hdxqdaz30dvcgxvlq3917c1kpi7m4v	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptKG:40kKB99RNcVgUCH_xt5HodmFBbMkrvifYbEVtUKV4E4	2020-12-31 13:28:12.873503+00
c55v4xv8y26kqnylq9p21xkoglitx4ed	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptLt:xyCAykW4Bjzy2YNY-dwChgZo-y2q-BpCiPjblw-CdZo	2020-12-31 13:29:53.756689+00
4dzdpcbkathen1n5u6mo4ehv5mf54n54	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptNZ:YOLEv15FW0UIKL4oi7uJiQKnnESDbK939ILoZ2s-MrM	2020-12-31 13:31:37.766199+00
9kq4rzh78jin59nlix3rkg6bgzc0llj8	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptNi:n1vRX3wdJAw1zeYR1wMif9wSjzJXBCxwOYA1dos14qQ	2020-12-31 13:31:46.30829+00
dwyhdg9qa85i4qi5k7nv91orzh4tyh64	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptS7:LkTA0RX3ecLCEZTNGtIj3xQxiSHdbmlFN-dLPCAWYws	2020-12-31 13:36:19.645755+00
tgcyctalgvevvy4bklewyojc22wbwgq8	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptSK:0KVkYxBAO9qBRR3Rkrm_J-lTaustpfvLmIOhy_-Vi7c	2020-12-31 13:36:32.688718+00
o4446yzvc7lq3p74ttp88mp79b4sr2hi	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptW7:Pnr3J3SF6O5QA5gVHCSSt5YGIASkysZdO9-0fRwTkVE	2020-12-31 13:40:27.650127+00
1se16q5m8bi9gyazv3onfcl4d8up03be	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptWG:6LL_2euDulbDFuGr3wIB0qcG9FxeuOoJQRES7U-U9Vs	2020-12-31 13:40:36.595966+00
ftbze6uzguptyj3zfg483txube9x34s1	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptuE:sgT23b2N6lQC5qqn6qT5IUcb_p3XKNUgLPhEn_meOjY	2020-12-31 14:05:22.731627+00
5hrw2qcvbkta7yryfunr0hz8dwx3z5ys	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptxK:zkxmes8pq7KoIhBXFv6nA2bloPtTm5_cQ4KL24wExI8	2020-12-31 14:08:34.212698+00
4j3gl4vh3gpu811w1pu1h9rg92y8d4gp	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptxX:4GbcX3d7_65BOSwSMarYQJ22LdI0adlcn22xtdl0XZM	2020-12-31 14:08:47.874854+00
8i8vk21hi81ar0rj9yt58u570v42s9fq	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kptzS:HvFSwJ-InnPFA9ifWlj1XsN-b4J0Z48ZSXi5sN4lw80	2020-12-31 14:10:46.081816+00
lalnw2fkimc3ppueb9ir2zkk7pxyj8k9	.eJxVjMsOwiAQRf-FtSE8Zlrq0r3fQIYBpGogKe3K-O_apAvd3nPOfQlP21r81tPi5yjOQovT7xaIH6nuIN6p3prkVtdlDnJX5EG7vLaYnpfD_Tso1Mu3JmZNyhBiJrBmQgOaNKsIbgDrglI8Eg-Ao41GaeaQksEpOyTIwTjx_gDYtTeu:1kpu4N:6V7ujBZdOekwhDy-SL3CErgA5vn9BBmoPTpvKajkLSU	2020-12-31 14:15:51.740703+00
zy50lq8uegkk2e6ohss0xxr6215giou3	e30:1kqMIx:LZluhfYXvxcepVt60Y8asa8adY6zlbt5_2ZKR_34BWc	2021-01-01 20:24:47.686136+00
dbr5mu1ehizmd8ztok6vg6v3holni6it	.eJxVjMEOwiAQBf-FsyHAQgGP3v0GsrAgVQNJaU_Gf9cmPej1zcx7sYDbWsM28hJmYmcGwE6_Y8T0yG0ndMd26zz1ti5z5LvCDzr4tVN-Xg7376DiqN96EgTGKK8tadI5SnDSgJmcVc6kbJIoWJwn5QVhQgVCq-JjslJ6IVxh7w_j3jdJ:1kutYv:R9-xwkTJlDrkRE1OvJk8rPGfLucPYHygRAnTz0lGvR0	2021-01-14 08:44:01.662542+00
pgpvx0wy752vj494ridvw7tko3i9skvm	.eJxVjEEOwiAQAP_C2RAQCqxH776BLAsrVUOT0p6MfzckPeh1ZjJvEXHfatx7WeOcxUVocfplCelZ2hD5ge2-SFrats5JjkQetsvbksvrerR_g4q9jm0A63QyickY7yfWYM0ZJmb02VlNgYsNwBSQ2IBVkEE5C4gOFBYtPl_PXTeU:1kvISF:QilQl8FAeqsNdgx8QQvNgqs7PPgweFxFhUcAdgVgSH4	2021-01-15 11:18:47.056518+00
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Data for Name: registration_profile; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.registration_profile (id, is_confirmed, user_id) FROM stdin;
30	t	41
17	f	7
18	f	1
26	f	32
27	f	33
\.


--
-- Data for Name: trading_balance; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.trading_balance (id, amount, currency_id, user_id) FROM stdin;
8	0.000	1	2
9	0.000	1	7
7	1000.000	1	1
\.


--
-- Data for Name: trading_currency; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.trading_currency (id, name, code) FROM stdin;
1	American Dollar	USD
\.


--
-- Data for Name: trading_inventory; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.trading_inventory (id, quantity, item_id, user_id) FROM stdin;
2	10	1	2
3	0	1	7
1	10	1	1
\.


--
-- Data for Name: trading_item; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.trading_item (id, name, code, price, details, currency_id) FROM stdin;
1	Apple	AAPL	100.00	Lel	1
2	Tesla	TSLA	100.00	Debug	1
3	Dow Jones	DOWJ	100.00	Debug	1
\.


--
-- Data for Name: trading_offer; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.trading_offer (id, entry_quantity, quantity, order_type, price, item_id, user_id, is_active) FROM stdin;
15	5	3	SELL	100.00	1	1	t
16	5	3	SELL	100.00	1	1	t
17	5	3	SELL	100.00	1	1	t
6	100	0	SELL	100.00	1	2	f
7	100	0	SELL	100.00	1	2	t
8	2	10	SELL	100.00	1	2	t
9	2	10	SELL	100.00	1	2	t
10	2	10	SELL	100.00	1	2	t
11	5	3	SELL	100.00	1	1	t
12	5	3	SELL	100.00	1	1	f
18	5	3	SELL	100.00	1	1	f
19	10	10	SELL	100.00	1	7	f
20	10	0	SELL	100.00	1	7	f
21	10	0	SELL	100.00	1	7	f
22	10	0	SELL	100.00	1	7	f
23	10	0	SELL	100.00	1	1	f
24	9	0	SELL	100.00	1	1	f
25	10	0	BUY	100.00	1	1	f
26	10	10	BUY	100.00	1	1	f
27	10	10	BUY	100.00	1	1	f
28	10	10	BUY	100.00	1	1	f
29	10	0	BUY	100.00	1	1	f
13	5	3	SELL	100.00	1	1	f
14	5	3	SELL	100.00	1	1	f
\.


--
-- Data for Name: trading_price; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.trading_price (id, price, date, currency_id, item_id) FROM stdin;
3	100.00	2020-12-17 10:49:06.536641+00	1	1
4	100.00	2020-12-24 12:31:30.220259+00	1	1
\.


--
-- Data for Name: trading_trade; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.trading_trade (id, quantity, unit_price, description, buyer_id, buyer_offer_id, item_id, seller_id, seller_offer_id, creation_time) FROM stdin;
191	10	100.00	\N	2	\N	1	1	\N	2021-01-05 13:28:49.638411+00
\.


--
-- Data for Name: trading_watchlist; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.trading_watchlist (id, user_id) FROM stdin;
5	1
8	2
9	33
\.


--
-- Data for Name: trading_watchlist_item; Type: TABLE DATA; Schema: public; Owner: trainee
--

COPY public.trading_watchlist_item (id, watchlist_id, item_id) FROM stdin;
10	5	2
11	8	1
12	9	1
13	9	2
14	9	3
\.


--
-- Name: account_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.account_account_id_seq', 1, false);


--
-- Name: account_accountdeletion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.account_accountdeletion_id_seq', 1, false);


--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.account_emailaddress_id_seq', 1, false);


--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.account_emailconfirmation_id_seq', 1, false);


--
-- Name: account_passwordexpiry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.account_passwordexpiry_id_seq', 1, false);


--
-- Name: account_passwordhistory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.account_passwordhistory_id_seq', 1, false);


--
-- Name: account_signupcode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.account_signupcode_id_seq', 1, false);


--
-- Name: account_signupcoderesult_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.account_signupcoderesult_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 132, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 70, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 52, true);


--
-- Name: django_celery_beat_clockedschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.django_celery_beat_clockedschedule_id_seq', 1, false);


--
-- Name: django_celery_beat_crontabschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.django_celery_beat_crontabschedule_id_seq', 1, true);


--
-- Name: django_celery_beat_intervalschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.django_celery_beat_intervalschedule_id_seq', 4, true);


--
-- Name: django_celery_beat_periodictask_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.django_celery_beat_periodictask_id_seq', 4, true);


--
-- Name: django_celery_beat_solarschedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.django_celery_beat_solarschedule_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 33, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 59, true);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.django_site_id_seq', 1, true);


--
-- Name: registration_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.registration_profile_id_seq', 62, true);


--
-- Name: trading_balance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.trading_balance_id_seq', 9, true);


--
-- Name: trading_currency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.trading_currency_id_seq', 2, true);


--
-- Name: trading_inventory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.trading_inventory_id_seq', 4, true);


--
-- Name: trading_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.trading_item_id_seq', 3, true);


--
-- Name: trading_offer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.trading_offer_id_seq', 29, true);


--
-- Name: trading_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.trading_price_id_seq', 4, true);


--
-- Name: trading_trade_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.trading_trade_id_seq', 191, true);


--
-- Name: trading_watchlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.trading_watchlist_id_seq', 9, true);


--
-- Name: trading_watchlist_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: trainee
--

SELECT pg_catalog.setval('public.trading_watchlist_item_id_seq', 14, true);


--
-- Name: account_account account_account_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_account
    ADD CONSTRAINT account_account_pkey PRIMARY KEY (id);


--
-- Name: account_account account_account_user_id_key; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_account
    ADD CONSTRAINT account_account_user_id_key UNIQUE (user_id);


--
-- Name: account_accountdeletion account_accountdeletion_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_accountdeletion
    ADD CONSTRAINT account_accountdeletion_pkey PRIMARY KEY (id);


--
-- Name: account_emailaddress account_emailaddress_email_key; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_email_key UNIQUE (email);


--
-- Name: account_emailaddress account_emailaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_pkey PRIMARY KEY (id);


--
-- Name: account_emailconfirmation account_emailconfirmation_key_key; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_key_key UNIQUE (key);


--
-- Name: account_emailconfirmation account_emailconfirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_pkey PRIMARY KEY (id);


--
-- Name: account_passwordexpiry account_passwordexpiry_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_passwordexpiry
    ADD CONSTRAINT account_passwordexpiry_pkey PRIMARY KEY (id);


--
-- Name: account_passwordexpiry account_passwordexpiry_user_id_key; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_passwordexpiry
    ADD CONSTRAINT account_passwordexpiry_user_id_key UNIQUE (user_id);


--
-- Name: account_passwordhistory account_passwordhistory_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_passwordhistory
    ADD CONSTRAINT account_passwordhistory_pkey PRIMARY KEY (id);


--
-- Name: account_signupcode account_signupcode_code_key; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_signupcode
    ADD CONSTRAINT account_signupcode_code_key UNIQUE (code);


--
-- Name: account_signupcode account_signupcode_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_signupcode
    ADD CONSTRAINT account_signupcode_pkey PRIMARY KEY (id);


--
-- Name: account_signupcoderesult account_signupcoderesult_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_signupcoderesult
    ADD CONSTRAINT account_signupcoderesult_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_clockedschedule django_celery_beat_clockedschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_celery_beat_clockedschedule
    ADD CONSTRAINT django_celery_beat_clockedschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_crontabschedule django_celery_beat_crontabschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_celery_beat_crontabschedule
    ADD CONSTRAINT django_celery_beat_crontabschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_intervalschedule django_celery_beat_intervalschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_celery_beat_intervalschedule
    ADD CONSTRAINT django_celery_beat_intervalschedule_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_periodictask django_celery_beat_periodictask_name_key; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_periodictask_name_key UNIQUE (name);


--
-- Name: django_celery_beat_periodictask django_celery_beat_periodictask_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_periodictask_pkey PRIMARY KEY (id);


--
-- Name: django_celery_beat_periodictasks django_celery_beat_periodictasks_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_celery_beat_periodictasks
    ADD CONSTRAINT django_celery_beat_periodictasks_pkey PRIMARY KEY (ident);


--
-- Name: django_celery_beat_solarschedule django_celery_beat_solar_event_latitude_longitude_ba64999a_uniq; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_celery_beat_solarschedule
    ADD CONSTRAINT django_celery_beat_solar_event_latitude_longitude_ba64999a_uniq UNIQUE (event, latitude, longitude);


--
-- Name: django_celery_beat_solarschedule django_celery_beat_solarschedule_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_celery_beat_solarschedule
    ADD CONSTRAINT django_celery_beat_solarschedule_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: registration_profile registration_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.registration_profile
    ADD CONSTRAINT registration_profile_pkey PRIMARY KEY (id);


--
-- Name: registration_profile registration_profile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.registration_profile
    ADD CONSTRAINT registration_profile_user_id_key UNIQUE (user_id);


--
-- Name: trading_balance trading_balance_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_balance
    ADD CONSTRAINT trading_balance_pkey PRIMARY KEY (id);


--
-- Name: trading_currency trading_currency_code_key; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_currency
    ADD CONSTRAINT trading_currency_code_key UNIQUE (code);


--
-- Name: trading_currency trading_currency_name_key; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_currency
    ADD CONSTRAINT trading_currency_name_key UNIQUE (name);


--
-- Name: trading_currency trading_currency_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_currency
    ADD CONSTRAINT trading_currency_pkey PRIMARY KEY (id);


--
-- Name: trading_inventory trading_inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_inventory
    ADD CONSTRAINT trading_inventory_pkey PRIMARY KEY (id);


--
-- Name: trading_item trading_item_code_key; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_item
    ADD CONSTRAINT trading_item_code_key UNIQUE (code);


--
-- Name: trading_item trading_item_name_key; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_item
    ADD CONSTRAINT trading_item_name_key UNIQUE (name);


--
-- Name: trading_item trading_item_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_item
    ADD CONSTRAINT trading_item_pkey PRIMARY KEY (id);


--
-- Name: trading_offer trading_offer_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_offer
    ADD CONSTRAINT trading_offer_pkey PRIMARY KEY (id);


--
-- Name: trading_price trading_price_date_key; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_price
    ADD CONSTRAINT trading_price_date_key UNIQUE (date);


--
-- Name: trading_price trading_price_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_price
    ADD CONSTRAINT trading_price_pkey PRIMARY KEY (id);


--
-- Name: trading_trade trading_trade_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_trade
    ADD CONSTRAINT trading_trade_pkey PRIMARY KEY (id);


--
-- Name: trading_watchlist_item trading_watchlist_item_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_watchlist_item
    ADD CONSTRAINT trading_watchlist_item_pkey PRIMARY KEY (id);


--
-- Name: trading_watchlist_item trading_watchlist_item_watchlist_id_item_id_db956c08_uniq; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_watchlist_item
    ADD CONSTRAINT trading_watchlist_item_watchlist_id_item_id_db956c08_uniq UNIQUE (watchlist_id, item_id);


--
-- Name: trading_watchlist trading_watchlist_pkey; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_watchlist
    ADD CONSTRAINT trading_watchlist_pkey PRIMARY KEY (id);


--
-- Name: trading_watchlist trading_watchlist_user_id_6883fda6_uniq; Type: CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_watchlist
    ADD CONSTRAINT trading_watchlist_user_id_6883fda6_uniq UNIQUE (user_id);


--
-- Name: account_accountdeletion_user_id_c205475f; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX account_accountdeletion_user_id_c205475f ON public.account_accountdeletion USING btree (user_id);


--
-- Name: account_emailaddress_email_03be32b2_like; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX account_emailaddress_email_03be32b2_like ON public.account_emailaddress USING btree (email varchar_pattern_ops);


--
-- Name: account_emailaddress_user_id_2c513194; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX account_emailaddress_user_id_2c513194 ON public.account_emailaddress USING btree (user_id);


--
-- Name: account_emailconfirmation_email_address_id_5b7f8c58; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX account_emailconfirmation_email_address_id_5b7f8c58 ON public.account_emailconfirmation USING btree (email_address_id);


--
-- Name: account_emailconfirmation_key_f43612bd_like; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX account_emailconfirmation_key_f43612bd_like ON public.account_emailconfirmation USING btree (key varchar_pattern_ops);


--
-- Name: account_passwordhistory_user_id_dc325181; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX account_passwordhistory_user_id_dc325181 ON public.account_passwordhistory USING btree (user_id);


--
-- Name: account_signupcode_code_e34edcf8_like; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX account_signupcode_code_e34edcf8_like ON public.account_signupcode USING btree (code varchar_pattern_ops);


--
-- Name: account_signupcode_inviter_id_9706983e; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX account_signupcode_inviter_id_9706983e ON public.account_signupcode USING btree (inviter_id);


--
-- Name: account_signupcoderesult_signup_code_id_1adc486e; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX account_signupcoderesult_signup_code_id_1adc486e ON public.account_signupcoderesult USING btree (signup_code_id);


--
-- Name: account_signupcoderesult_user_id_c10dc604; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX account_signupcoderesult_user_id_c10dc604 ON public.account_signupcoderesult USING btree (user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_celery_beat_periodictask_clocked_id_47a69f82; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX django_celery_beat_periodictask_clocked_id_47a69f82 ON public.django_celery_beat_periodictask USING btree (clocked_id);


--
-- Name: django_celery_beat_periodictask_crontab_id_d3cba168; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX django_celery_beat_periodictask_crontab_id_d3cba168 ON public.django_celery_beat_periodictask USING btree (crontab_id);


--
-- Name: django_celery_beat_periodictask_interval_id_a8ca27da; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX django_celery_beat_periodictask_interval_id_a8ca27da ON public.django_celery_beat_periodictask USING btree (interval_id);


--
-- Name: django_celery_beat_periodictask_name_265a36b7_like; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX django_celery_beat_periodictask_name_265a36b7_like ON public.django_celery_beat_periodictask USING btree (name varchar_pattern_ops);


--
-- Name: django_celery_beat_periodictask_solar_id_a87ce72c; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX django_celery_beat_periodictask_solar_id_a87ce72c ON public.django_celery_beat_periodictask USING btree (solar_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX django_site_domain_a2e37b91_like ON public.django_site USING btree (domain varchar_pattern_ops);


--
-- Name: trading_balance_currency_id_9a946fb9; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_balance_currency_id_9a946fb9 ON public.trading_balance USING btree (currency_id);


--
-- Name: trading_balance_user_id_e0307b7e; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_balance_user_id_e0307b7e ON public.trading_balance USING btree (user_id);


--
-- Name: trading_currency_code_386dfef5_like; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_currency_code_386dfef5_like ON public.trading_currency USING btree (code varchar_pattern_ops);


--
-- Name: trading_currency_name_3793dfc2_like; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_currency_name_3793dfc2_like ON public.trading_currency USING btree (name varchar_pattern_ops);


--
-- Name: trading_inventory_item_id_74fe47a1; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_inventory_item_id_74fe47a1 ON public.trading_inventory USING btree (item_id);


--
-- Name: trading_inventory_user_id_a0cf8fd7; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_inventory_user_id_a0cf8fd7 ON public.trading_inventory USING btree (user_id);


--
-- Name: trading_item_code_1b5c9856_like; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_item_code_1b5c9856_like ON public.trading_item USING btree (code varchar_pattern_ops);


--
-- Name: trading_item_currency_id_86153bcd; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_item_currency_id_86153bcd ON public.trading_item USING btree (currency_id);


--
-- Name: trading_item_name_ae0c1e74_like; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_item_name_ae0c1e74_like ON public.trading_item USING btree (name varchar_pattern_ops);


--
-- Name: trading_offer_item_id_07ffb77c; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_offer_item_id_07ffb77c ON public.trading_offer USING btree (item_id);


--
-- Name: trading_offer_user_id_76c0453f; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_offer_user_id_76c0453f ON public.trading_offer USING btree (user_id);


--
-- Name: trading_price_currency_id_90656b64; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_price_currency_id_90656b64 ON public.trading_price USING btree (currency_id);


--
-- Name: trading_price_item_id_c7e66bff; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_price_item_id_c7e66bff ON public.trading_price USING btree (item_id);


--
-- Name: trading_trade_buyer_id_169500a7; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_trade_buyer_id_169500a7 ON public.trading_trade USING btree (buyer_id);


--
-- Name: trading_trade_buyer_offer_id_c98d93e8; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_trade_buyer_offer_id_c98d93e8 ON public.trading_trade USING btree (buyer_offer_id);


--
-- Name: trading_trade_item_id_831c25be; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_trade_item_id_831c25be ON public.trading_trade USING btree (item_id);


--
-- Name: trading_trade_seller_id_cf14591b; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_trade_seller_id_cf14591b ON public.trading_trade USING btree (seller_id);


--
-- Name: trading_trade_seller_offer_id_f2be1116; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_trade_seller_offer_id_f2be1116 ON public.trading_trade USING btree (seller_offer_id);


--
-- Name: trading_watchlist_item_item_id_fd67b918; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_watchlist_item_item_id_fd67b918 ON public.trading_watchlist_item USING btree (item_id);


--
-- Name: trading_watchlist_item_watchlist_id_2e38ef10; Type: INDEX; Schema: public; Owner: trainee
--

CREATE INDEX trading_watchlist_item_watchlist_id_2e38ef10 ON public.trading_watchlist_item USING btree (watchlist_id);


--
-- Name: account_account account_account_user_id_8d4f4816_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_account
    ADD CONSTRAINT account_account_user_id_8d4f4816_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_accountdeletion account_accountdeletion_user_id_c205475f_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_accountdeletion
    ADD CONSTRAINT account_accountdeletion_user_id_c205475f_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_emailaddress account_emailaddress_user_id_2c513194_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_user_id_2c513194_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_emailconfirmation account_emailconfirm_email_address_id_5b7f8c58_fk_account_e; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirm_email_address_id_5b7f8c58_fk_account_e FOREIGN KEY (email_address_id) REFERENCES public.account_emailaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_passwordexpiry account_passwordexpiry_user_id_905230ec_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_passwordexpiry
    ADD CONSTRAINT account_passwordexpiry_user_id_905230ec_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_passwordhistory account_passwordhistory_user_id_dc325181_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_passwordhistory
    ADD CONSTRAINT account_passwordhistory_user_id_dc325181_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_signupcode account_signupcode_inviter_id_9706983e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_signupcode
    ADD CONSTRAINT account_signupcode_inviter_id_9706983e_fk_auth_user_id FOREIGN KEY (inviter_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_signupcoderesult account_signupcodere_signup_code_id_1adc486e_fk_account_s; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_signupcoderesult
    ADD CONSTRAINT account_signupcodere_signup_code_id_1adc486e_fk_account_s FOREIGN KEY (signup_code_id) REFERENCES public.account_signupcode(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_signupcoderesult account_signupcoderesult_user_id_c10dc604_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.account_signupcoderesult
    ADD CONSTRAINT account_signupcoderesult_user_id_c10dc604_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_clocked_id_47a69f82_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_clocked_id_47a69f82_fk_django_ce FOREIGN KEY (clocked_id) REFERENCES public.django_celery_beat_clockedschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_crontab_id_d3cba168_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_crontab_id_d3cba168_fk_django_ce FOREIGN KEY (crontab_id) REFERENCES public.django_celery_beat_crontabschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_interval_id_a8ca27da_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_interval_id_a8ca27da_fk_django_ce FOREIGN KEY (interval_id) REFERENCES public.django_celery_beat_intervalschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_celery_beat_periodictask django_celery_beat_p_solar_id_a87ce72c_fk_django_ce; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.django_celery_beat_periodictask
    ADD CONSTRAINT django_celery_beat_p_solar_id_a87ce72c_fk_django_ce FOREIGN KEY (solar_id) REFERENCES public.django_celery_beat_solarschedule(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: registration_profile registration_profile_user_id_e133ce43_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.registration_profile
    ADD CONSTRAINT registration_profile_user_id_e133ce43_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trading_balance trading_balance_currency_id_9a946fb9_fk_trading_currency_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_balance
    ADD CONSTRAINT trading_balance_currency_id_9a946fb9_fk_trading_currency_id FOREIGN KEY (currency_id) REFERENCES public.trading_currency(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trading_balance trading_balance_user_id_e0307b7e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_balance
    ADD CONSTRAINT trading_balance_user_id_e0307b7e_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trading_inventory trading_inventory_item_id_74fe47a1_fk_trading_item_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_inventory
    ADD CONSTRAINT trading_inventory_item_id_74fe47a1_fk_trading_item_id FOREIGN KEY (item_id) REFERENCES public.trading_item(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trading_inventory trading_inventory_user_id_a0cf8fd7_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_inventory
    ADD CONSTRAINT trading_inventory_user_id_a0cf8fd7_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trading_item trading_item_currency_id_86153bcd_fk_trading_currency_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_item
    ADD CONSTRAINT trading_item_currency_id_86153bcd_fk_trading_currency_id FOREIGN KEY (currency_id) REFERENCES public.trading_currency(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trading_offer trading_offer_item_id_07ffb77c_fk_trading_item_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_offer
    ADD CONSTRAINT trading_offer_item_id_07ffb77c_fk_trading_item_id FOREIGN KEY (item_id) REFERENCES public.trading_item(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trading_offer trading_offer_user_id_76c0453f_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_offer
    ADD CONSTRAINT trading_offer_user_id_76c0453f_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trading_price trading_price_currency_id_90656b64_fk_trading_currency_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_price
    ADD CONSTRAINT trading_price_currency_id_90656b64_fk_trading_currency_id FOREIGN KEY (currency_id) REFERENCES public.trading_currency(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trading_price trading_price_item_id_c7e66bff_fk_trading_item_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_price
    ADD CONSTRAINT trading_price_item_id_c7e66bff_fk_trading_item_id FOREIGN KEY (item_id) REFERENCES public.trading_item(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trading_trade trading_trade_buyer_id_169500a7_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_trade
    ADD CONSTRAINT trading_trade_buyer_id_169500a7_fk_auth_user_id FOREIGN KEY (buyer_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trading_trade trading_trade_buyer_offer_id_c98d93e8_fk_trading_offer_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_trade
    ADD CONSTRAINT trading_trade_buyer_offer_id_c98d93e8_fk_trading_offer_id FOREIGN KEY (buyer_offer_id) REFERENCES public.trading_offer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trading_trade trading_trade_item_id_831c25be_fk_trading_item_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_trade
    ADD CONSTRAINT trading_trade_item_id_831c25be_fk_trading_item_id FOREIGN KEY (item_id) REFERENCES public.trading_item(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trading_trade trading_trade_seller_id_cf14591b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_trade
    ADD CONSTRAINT trading_trade_seller_id_cf14591b_fk_auth_user_id FOREIGN KEY (seller_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trading_trade trading_trade_seller_offer_id_f2be1116_fk_trading_offer_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_trade
    ADD CONSTRAINT trading_trade_seller_offer_id_f2be1116_fk_trading_offer_id FOREIGN KEY (seller_offer_id) REFERENCES public.trading_offer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trading_watchlist_item trading_watchlist_it_watchlist_id_2e38ef10_fk_trading_w; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_watchlist_item
    ADD CONSTRAINT trading_watchlist_it_watchlist_id_2e38ef10_fk_trading_w FOREIGN KEY (watchlist_id) REFERENCES public.trading_watchlist(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trading_watchlist_item trading_watchlist_item_item_id_fd67b918_fk_trading_item_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_watchlist_item
    ADD CONSTRAINT trading_watchlist_item_item_id_fd67b918_fk_trading_item_id FOREIGN KEY (item_id) REFERENCES public.trading_item(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: trading_watchlist trading_watchlist_user_id_6883fda6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: trainee
--

ALTER TABLE ONLY public.trading_watchlist
    ADD CONSTRAINT trading_watchlist_user_id_6883fda6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

