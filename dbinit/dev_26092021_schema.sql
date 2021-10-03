--
-- PostgreSQL database dump
--
-- Dumped from database version 12.8 (Ubuntu 12.8-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.8 (Ubuntu 12.8-0ubuntu0.20.04.1)
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
-- Name: tablename_colname_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE IF NOT EXISTS public.tablename_colname_seq START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER TABLE public.tablename_colname_seq OWNER TO postgres;
SET default_tablespace = '';
SET default_table_access_method = heap;
--
-- Name: task_list; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE IF NOT EXISTS public.task_list (
    list_id integer NOT NULL,
    user_id integer NOT NULL,
    description text NOT NULL,
    status_tag text DEFAULT 'Todo'::text,
    is_email_pushed smallint DEFAULT 0,
    is_phone_pushed smallint DEFAULT 0,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE public.task_list OWNER TO postgres;
--
-- Name: task_list_list_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE IF NOT EXISTS public.task_list_list_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER TABLE public.task_list_list_id_seq OWNER TO postgres;
--
-- Name: task_list_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--
ALTER SEQUENCE public.task_list_list_id_seq OWNED BY public.task_list.list_id;
--
-- Name: user_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE IF NOT EXISTS public.user_notifications_id_seq START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER TABLE public.user_notifications_id_seq OWNER TO postgres;
--
-- Name: user_notifications; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE IF NOT EXISTS public.user_notifications (
    id integer DEFAULT nextval('public.user_notifications_id_seq'::regclass) NOT NULL,
    event_type text,
    description text NOT NULL,
    user_id integer NOT NULL,
    read_flag smallint DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE public.user_notifications OWNER TO postgres;
--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--
CREATE TABLE IF NOT EXISTS public.users (
    user_id integer NOT NULL,
    username text NOT NULL,
    password character varying(100),
    firstname text,
    lastname text,
    email text,
    phone text,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE public.users OWNER TO postgres;
--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--
CREATE SEQUENCE IF NOT EXISTS public.users_user_id_seq AS integer START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE CACHE 1;
ALTER TABLE public.users_user_id_seq OWNER TO postgres;
--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--
ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
--
-- Name: task_list list_id; Type: DEFAULT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY public.task_list
ALTER COLUMN list_id
SET DEFAULT nextval('public.task_list_list_id_seq'::regclass);
--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--
ALTER TABLE ONLY public.users
ALTER COLUMN user_id
SET DEFAULT nextval('public.users_user_id_seq'::regclass);
--
-- Name: task_list task_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE public.task_list DROP CONSTRAINT IF EXISTS task_list_pkey;
ALTER TABLE ONLY public.task_list
ADD CONSTRAINT task_list_pkey PRIMARY KEY (list_id);
--
-- Name: user_notifications user_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE public.user_notifications DROP CONSTRAINT IF EXISTS user_notifications_pkey;
ALTER TABLE ONLY public.user_notifications
ADD CONSTRAINT user_notifications_pkey PRIMARY KEY (id);
--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--
ALTER TABLE public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE ONLY public.users
ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
--
-- PostgreSQL database dump complete
--