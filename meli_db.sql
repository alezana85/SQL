--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (PGlite 0.2.0)
-- Dumped by pg_dump version 16.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = off;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET escape_string_warning = off;
SET row_security = off;

--
-- Name: meta; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA meta;


ALTER SCHEMA meta OWNER TO postgres;

--
-- Name: vector; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA public;


--
-- Name: EXTENSION vector; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION vector IS 'vector data type and ivfflat and hnsw access methods';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: embeddings; Type: TABLE; Schema: meta; Owner: postgres
--

CREATE TABLE meta.embeddings (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    content text NOT NULL,
    embedding public.vector(384) NOT NULL
);


ALTER TABLE meta.embeddings OWNER TO postgres;

--
-- Name: embeddings_id_seq; Type: SEQUENCE; Schema: meta; Owner: postgres
--

ALTER TABLE meta.embeddings ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME meta.embeddings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: migrations; Type: TABLE; Schema: meta; Owner: postgres
--

CREATE TABLE meta.migrations (
    version text NOT NULL,
    name text,
    applied_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE meta.migrations OWNER TO postgres;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    nombre text NOT NULL
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.categories ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    usuario_id bigint,
    fecha timestamp with time zone DEFAULT now(),
    total numeric(10,2) NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.orders ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    nombre text NOT NULL,
    descripcion text,
    precio numeric(10,2) NOT NULL,
    categoria_id bigint,
    vendedor_id bigint
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.products ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    id bigint NOT NULL,
    producto_id bigint,
    usuario_id bigint,
    calificacion integer,
    comentario text,
    fecha timestamp with time zone DEFAULT now(),
    CONSTRAINT reviews_calificacion_check CHECK (((calificacion >= 1) AND (calificacion <= 5)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.reviews ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.reviews_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    nombre text NOT NULL,
    correo_electronico text NOT NULL,
    "contraseña" text NOT NULL,
    fecha_registro timestamp with time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: embeddings; Type: TABLE DATA; Schema: meta; Owner: postgres
--



--
-- Data for Name: migrations; Type: TABLE DATA; Schema: meta; Owner: postgres
--

INSERT INTO meta.migrations VALUES ('202407160001', 'embeddings', '2025-02-23 01:52:38.519+00');


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categories OVERRIDING SYSTEM VALUE VALUES (1, 'Electrónica');
INSERT INTO public.categories OVERRIDING SYSTEM VALUE VALUES (2, 'Hogar y Cocina');
INSERT INTO public.categories OVERRIDING SYSTEM VALUE VALUES (3, 'Ropa y Accesorios');
INSERT INTO public.categories OVERRIDING SYSTEM VALUE VALUES (4, 'Libros');
INSERT INTO public.categories OVERRIDING SYSTEM VALUE VALUES (5, 'Juguetes');


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.orders OVERRIDING SYSTEM VALUE VALUES (1, 1, '2025-02-23 02:39:13.499+00', 729.98);
INSERT INTO public.orders OVERRIDING SYSTEM VALUE VALUES (2, 2, '2025-02-23 02:39:13.499+00', 299.99);
INSERT INTO public.orders OVERRIDING SYSTEM VALUE VALUES (3, 3, '2025-02-23 02:39:13.499+00', 29.99);
INSERT INTO public.orders OVERRIDING SYSTEM VALUE VALUES (4, 4, '2025-02-23 02:39:13.499+00', 19.99);
INSERT INTO public.orders OVERRIDING SYSTEM VALUE VALUES (5, 5, '2025-02-23 02:39:13.499+00', 159.99);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (1, 'Smartphone Samsung Galaxy', 'Último modelo con pantalla AMOLED', 699.99, 1, 1);
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (2, 'Aspiradora Dyson', 'Aspiradora sin cable con gran potencia de succión', 299.99, 2, 2);
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (3, 'Camiseta Nike', 'Camiseta deportiva de alta calidad', 29.99, 3, 3);
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (4, 'Libro: El Quijote', 'Edición especial del clásico de Cervantes', 19.99, 4, 4);
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (5, 'Lego Star Wars', 'Set de construcción de la Estrella de la Muerte', 159.99, 5, 5);


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reviews OVERRIDING SYSTEM VALUE VALUES (1, 1, 2, 5, 'Excelente smartphone, muy rápido y con buena cámara.', '2025-02-23 02:39:13.499+00');
INSERT INTO public.reviews OVERRIDING SYSTEM VALUE VALUES (2, 2, 3, 4, 'Buena aspiradora, aunque un poco cara.', '2025-02-23 02:39:13.499+00');
INSERT INTO public.reviews OVERRIDING SYSTEM VALUE VALUES (3, 3, 4, 5, 'Camiseta muy cómoda y de buena calidad.', '2025-02-23 02:39:13.499+00');
INSERT INTO public.reviews OVERRIDING SYSTEM VALUE VALUES (4, 4, 5, 5, 'Un clásico que todos deberían leer.', '2025-02-23 02:39:13.499+00');
INSERT INTO public.reviews OVERRIDING SYSTEM VALUE VALUES (5, 5, 1, 4, 'Gran set de Lego, pero las instrucciones son complicadas.', '2025-02-23 02:39:13.499+00');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (1, 'Juan Pérez', 'juan.perez@example.com', 'password123', '2025-02-23 02:39:13.499+00');
INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (2, 'María López', 'maria.lopez@example.com', 'securepass', '2025-02-23 02:39:13.499+00');
INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (3, 'Carlos García', 'carlos.garcia@example.com', 'mypassword', '2025-02-23 02:39:13.499+00');
INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (4, 'Ana Torres', 'ana.torres@example.com', 'anapass', '2025-02-23 02:39:13.499+00');
INSERT INTO public.users OVERRIDING SYSTEM VALUE VALUES (5, 'Luis Fernández', 'luis.fernandez@example.com', 'luispass', '2025-02-23 02:39:13.499+00');


--
-- Name: embeddings_id_seq; Type: SEQUENCE SET; Schema: meta; Owner: postgres
--

SELECT pg_catalog.setval('meta.embeddings_id_seq', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 5, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_id_seq', 5, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_id_seq', 5, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_id_seq', 5, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: embeddings embeddings_pkey; Type: CONSTRAINT; Schema: meta; Owner: postgres
--

ALTER TABLE ONLY meta.embeddings
    ADD CONSTRAINT embeddings_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: meta; Owner: postgres
--

ALTER TABLE ONLY meta.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (version);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: users users_correo_electronico_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_correo_electronico_key UNIQUE (correo_electronico);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: orders orders_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.users(id);


--
-- Name: products products_categoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_categoria_id_fkey FOREIGN KEY (categoria_id) REFERENCES public.categories(id);


--
-- Name: products products_vendedor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_vendedor_id_fkey FOREIGN KEY (vendedor_id) REFERENCES public.users(id);


--
-- Name: reviews reviews_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.products(id);


--
-- Name: reviews reviews_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

