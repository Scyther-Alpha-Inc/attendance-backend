--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE gctu_attendance;




--
-- Drop roles
--

DROP ROLE gctu_attendance;


--
-- Roles
--

CREATE ROLE gctu_attendance;
ALTER ROLE gctu_attendance WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:SgKWD6iP5Rzjfjialz1kTA==$ymHkBq2zrwZQW1epwBk/gFDIW7cwuC/fvB/+69odv0U=:OfCblaKvOeAk7kHKNQpF9hTYuUL1HgzwDV3nxvj1DMc=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: gctu_attendance
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO gctu_attendance;

\connect template1

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
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: gctu_attendance
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: gctu_attendance
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: gctu_attendance
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "gctu_attendance" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

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
-- Name: gctu_attendance; Type: DATABASE; Schema: -; Owner: gctu_attendance
--

CREATE DATABASE gctu_attendance WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE gctu_attendance OWNER TO gctu_attendance;

\connect gctu_attendance

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
-- Name: gctu_attendance; Type: DATABASE PROPERTIES; Schema: -; Owner: gctu_attendance
--

ALTER DATABASE gctu_attendance SET search_path TO '$user', 'public', 'topology';


\connect gctu_attendance

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: gctu_attendance
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO gctu_attendance;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: gctu_attendance
--

COMMENT ON SCHEMA public IS '';


--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: gctu_attendance
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO gctu_attendance;

--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: gctu_attendance
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: sessionenvironment; Type: TYPE; Schema: topology; Owner: gctu_attendance
--

CREATE TYPE topology.sessionenvironment AS ENUM (
    'ZOOM',
    'IN_PERSON'
);


ALTER TYPE topology.sessionenvironment OWNER TO gctu_attendance;

--
-- Name: userrole; Type: TYPE; Schema: topology; Owner: gctu_attendance
--

CREATE TYPE topology.userrole AS ENUM (
    'STUDENT',
    'LECTURER'
);


ALTER TYPE topology.userrole OWNER TO gctu_attendance;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: attendances; Type: TABLE; Schema: public; Owner: gctu_attendance
--

CREATE TABLE public.attendances (
    id uuid NOT NULL,
    enrollment_id uuid NOT NULL,
    session_id uuid NOT NULL,
    score integer NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.attendances OWNER TO gctu_attendance;

--
-- Name: courses; Type: TABLE; Schema: public; Owner: gctu_attendance
--

CREATE TABLE public.courses (
    id uuid NOT NULL,
    title character varying NOT NULL,
    code character varying NOT NULL,
    lecturer_id uuid,
    department_id uuid
);


ALTER TABLE public.courses OWNER TO gctu_attendance;

--
-- Name: departments; Type: TABLE; Schema: public; Owner: gctu_attendance
--

CREATE TABLE public.departments (
    id uuid NOT NULL,
    name character varying NOT NULL,
    code character varying NOT NULL
);


ALTER TABLE public.departments OWNER TO gctu_attendance;

--
-- Name: enrollments; Type: TABLE; Schema: public; Owner: gctu_attendance
--

CREATE TABLE public.enrollments (
    id uuid NOT NULL,
    student_id uuid NOT NULL,
    course_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.enrollments OWNER TO gctu_attendance;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: gctu_attendance
--

CREATE TABLE public.sessions (
    id uuid NOT NULL,
    session_type topology.sessionenvironment NOT NULL,
    course_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    ended_at timestamp without time zone,
    started_at timestamp without time zone,
    ref_id text
);


ALTER TABLE public.sessions OWNER TO gctu_attendance;

--
-- Name: social_auths; Type: TABLE; Schema: public; Owner: gctu_attendance
--

CREATE TABLE public.social_auths (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    oauth_id character varying NOT NULL,
    provider character varying NOT NULL,
    access_token character varying NOT NULL,
    refresh_token character varying NOT NULL
);


ALTER TABLE public.social_auths OWNER TO gctu_attendance;

--
-- Name: users; Type: TABLE; Schema: public; Owner: gctu_attendance
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    gctu_id character varying NOT NULL,
    name character varying NOT NULL,
    email character varying,
    role topology.userrole NOT NULL,
    pin character varying NOT NULL
);


ALTER TABLE public.users OWNER TO gctu_attendance;

--
-- Data for Name: attendances; Type: TABLE DATA; Schema: public; Owner: gctu_attendance
--

COPY public.attendances (id, enrollment_id, session_id, score, created_at) FROM stdin;
80196485-d895-47aa-beab-8c50f094653b	09d69243-3df1-4586-a0aa-bda7ffc9c52c	60233be1-18df-4c63-8a15-ab4ebff3b7b9	83	2025-08-19 21:55:06.398564
98b6a632-d8cb-41e3-9ffe-3daf5fb8814e	09d69243-3df1-4586-a0aa-bda7ffc9c52c	3d8d2feb-b9c3-4126-b05e-4ca356c78626	83	2025-08-20 14:46:42.931818
31b89622-97c3-4cbd-aeff-45b334fe9cd8	09d69243-3df1-4586-a0aa-bda7ffc9c52c	17ce8f22-62b9-477d-b9ed-11552d11ed62	83	2025-08-20 14:47:55.992285
9e7a142a-8df1-4643-a4ba-d1ba2c0081b3	09d69243-3df1-4586-a0aa-bda7ffc9c52c	e2acfd8a-9ea4-4a28-ad9b-00740828076b	83	2025-08-20 14:47:56.767562
\.


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: gctu_attendance
--

COPY public.courses (id, title, code, lecturer_id, department_id) FROM stdin;
bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	Information Systems Audit	CSCS422	98e33c33-7583-45b6-b60e-73c1961a4504	7a244506-3194-48f3-b71f-a041e8c6e906
8b9f5c4a-9a31-4c85-b12e-8a72c9084c77	Introduction to Artificial Intelligence	AI101	98e33c33-7583-45b6-b60e-73c1961a4504	7a244506-3194-48f3-b71f-a041e8c6e906
a3e75c90-d72d-41d4-b4fb-2ff914de2f34	Database Systems II	DB202	98e33c33-7583-45b6-b60e-73c1961a4504	7a244506-3194-48f3-b71f-a041e8c6e906
\.


--
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: gctu_attendance
--

COPY public.departments (id, name, code) FROM stdin;
7a244506-3194-48f3-b71f-a041e8c6e906	BSc Computer Science	PRG1
\.


--
-- Data for Name: enrollments; Type: TABLE DATA; Schema: public; Owner: gctu_attendance
--

COPY public.enrollments (id, student_id, course_id, created_at) FROM stdin;
09d69243-3df1-4586-a0aa-bda7ffc9c52c	4294b0c1-2c33-40f3-95b9-72aef06a7729	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 16:58:38.759627
dd917014-a4e6-4861-93e2-90a03e308ee5	9a76fdad-123b-4360-a94c-a0fa893ce9fa	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 16:58:38.759856
f6c3c9ec-3f24-45af-9700-d870bc3da5f0	7cecfc9f-def0-435c-86c6-7e70cff23954	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 16:58:38.760045
9eeb746b-b6c7-456c-bf0b-0ca6700ba6f8	55e8fdb0-442d-4e44-88dd-62d99c989cbb	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 16:58:38.760231
b804a44a-4f30-4b3e-87fe-72d7e10d0af2	881077fe-ce1f-452b-928d-2701a09e2487	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 16:58:38.760413
08d082c1-84e2-44e3-9a9d-47e9d87c1ff4	a5ea535f-7a50-4b68-bdc8-c3e890a20639	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 16:59:10.871017
6b1b5957-0886-43b0-be0d-31f887deb8c0	53f6cd6f-dcf7-482d-8e0f-7ef9df6abbae	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 16:59:10.871932
83ba48da-ef46-48c4-8204-ee254f8e61b1	dab7ef3c-51a4-449f-996a-1d54bb3bd199	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 16:59:10.872489
0b41344e-79ce-4a3f-90a3-77605887415a	e2d1f893-960b-485a-ac6f-09a55b985402	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 16:59:10.872885
9bad0147-658a-4c52-87df-791f4ba88742	c67a9b46-f097-4ddc-8e9c-004cf66aefc4	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 16:59:10.873242
359cc405-0b78-4dcb-aea5-6a61549152e8	71dabf6e-f58c-46d9-9695-9bc6b8f51516	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:07:33.454891
78fd7cda-16f4-4bd8-9d37-3aaebaf305fc	a636fe17-5c9d-4d11-81e2-d1de1f2fc9e1	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:07:33.456229
4ee681a7-fcb5-4f1e-9b33-373042c8eef4	25ecdb8b-d18b-4a2f-b555-3e8bbe87c79d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:07:33.45683
6ec44a15-d9a3-497a-979a-d339db29bfd5	63a17481-eaba-4d5c-9023-ef9d72fee582	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:07:33.457597
acbde2bf-c4e1-407d-85d4-c9a0242d1835	95fa87f9-8a9b-4fd2-afed-5153e0afeeef	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:07:33.459172
3fdda7f2-0df1-4c40-b6fe-4ec294e65ae1	118bd446-17ca-4102-8d50-5291af006752	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:07:36.640087
727b0f2f-4a31-4c66-844c-6ece34ac21bb	37d70083-9650-403a-a3b2-437ecbfeaa3a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:07:36.640492
682eea9b-103c-4fbd-97f1-7649cfa28601	66647695-9513-4378-be9b-39a2c2c30655	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:07:36.640854
6479a388-ba4f-4845-8aa7-144422b19274	eb417ff2-e332-46f3-9174-109329b14a5c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:07:36.641146
7b803e66-8782-4a05-8de6-493f6a726576	1cafcf3f-2871-4e37-84de-720a4ddb349f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:07:36.641406
6bb7ebd2-da6a-4dd9-a0ce-86063903bb57	2e452280-d4be-4d63-ac30-162bb72a4945	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:08:26.299592
addc0a31-662a-43c0-8dcf-9762dec36aa7	013f9c03-a0d0-4586-b80f-8df56730bba7	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:08:26.299891
ef9b7ee8-a9a7-4010-a4d0-693f3ef7c3de	865163fb-f90e-47ea-8221-ca6badf91156	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:08:26.300145
fd372d03-9e2e-4b36-8da7-72ac9681fd53	4fc7ebee-d392-4f31-9a01-bacf856aa7ef	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:08:26.300395
a4e322b7-5fc8-494f-8360-6263ac5e01d1	88bcf66f-c599-4d18-9766-9c1152ff6263	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:08:26.300639
8ed25ba3-abe2-4549-a6bc-b7a5457ce5bd	9e5a75ba-2a24-4094-993c-a6ec20ccf859	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:08:32.462843
9cfa7393-88a8-4cd2-98a5-b2651ae510de	46be1a38-a893-4d82-b56c-7cf2b6305889	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:08:32.463316
76750f6c-a497-4f18-a429-cab0c091b376	8d56d66e-31f4-43c1-befa-70a8dd21ddce	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:08:32.463601
f759e5be-d815-4e32-8641-6610c2819c25	1ab2074a-209b-4897-932a-fa09f03fb466	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:08:32.463906
278e344d-2cd8-4d5d-8380-c783aed73e2e	746fb592-d1c5-47b4-8b2f-2a39b399025c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:08:32.464152
16896530-0588-43a4-8cd8-09cb8bcb855e	32ce415a-c6db-478d-ae7c-442065a162d0	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:08:34.450751
5af8442e-573b-40f9-9bf4-82f2d89db835	ae175e34-3b1c-4e84-a719-19c75c5a6beb	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:08:34.450978
c2226051-8828-489a-be5f-d297406988b4	21155eda-6e3a-4c62-8617-6d14fbabb35c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:08:34.451166
2e0ea48a-68f5-48f1-83c4-21695a408ebc	9ced3d36-8194-4e55-b052-d673782b5f2b	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:08:34.45136
069cdd6b-f1ab-4af2-ae35-07edabcf8804	dffe6178-56bb-4432-ac65-154cc085c1ed	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:08:34.451546
f756865a-abc1-4c0f-b1d5-4b0d5c14bade	9753245d-f813-423f-a223-65161778e31f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:41.443021
b94ca7c6-b8ed-4a94-82f0-275369d71927	b98863df-54c5-4b28-b8bb-5d0128f25f1d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:41.443393
43c2eb77-5752-4880-8db1-08bdd200d0b3	084849ee-6515-48ad-9df3-a8191afed555	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:41.443668
452c65b6-349b-4230-8445-065f7a52df39	af6963db-fc48-4624-b5d7-b08812cc907c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:41.443949
32119605-3d50-4648-b8d0-0b2a0acc5dfa	4223f921-9b41-4301-8d11-257ce828114f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:41.44423
c54002fc-2ce5-4b55-8efe-c77b9bc9609e	3c00fcc4-3506-407c-8885-f64be1c16ca6	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:44.191603
b7d0db5b-f400-4b5a-a6ae-e4609d68dc2e	b9f9e8db-3caa-4135-93b9-3306b17b4bb3	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:44.191829
24088d07-fb03-43c3-9f46-2ad7c1e91d31	ef1388b3-98be-4e36-acb6-9454c1d13af8	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:44.192018
26409921-244b-49d2-9874-fa64cef77085	766c7c04-72e4-4101-9282-d991bcf57d2f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:44.192207
c3073a7a-bd55-4a8f-a356-39c62b5384f7	2fcdd82e-fa21-4d2c-8968-48691fc6727a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:44.192392
f8d18332-42a4-4888-9f75-881c744393a8	8f6461ad-b6b6-4b3a-91bd-15b1e3dd8d90	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:46.658201
462eb963-86df-425a-8f0f-df031fa3f360	212c9791-e5dc-4976-9b0a-bbf974093f08	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:46.658498
779d59c3-529f-4981-a863-83bc75f744f9	c94d1045-d4e3-4777-90f4-f6039a591a2c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:46.658739
4387db62-6450-4db6-a0d5-0f08c0c44dd0	e159b9df-8441-4b06-8483-553840d5d402	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:46.658979
d5105982-0099-478e-8120-42a39203f50b	6a8ed733-4b8a-40ab-b17f-8f469272d64d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:46.659221
6853b812-b838-4d04-8229-f0a6f0f7125d	31521abc-f748-43cf-b08d-21540ca28bf8	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:48.96823
67c57dc1-20b2-44f8-8160-348a37ad039c	e2434b9c-17a1-4e20-a76e-d62d03651f5f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:48.968512
2c18693c-fa65-4c38-b5a8-99df701cca18	c7dc62d4-f064-4a6c-a2ab-028e032f3ce4	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:48.968746
9517df30-6320-4f22-83f6-42b769b96678	e1198535-daca-48b9-a669-022f52b6e7e9	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:48.968989
8637ba9c-26cc-4902-87e5-e0ece05c893c	6b7272b4-b344-4f38-bb52-63d750f49dbd	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:48.969228
1f5008b3-9efd-4b27-8472-ea7d2e11062c	bb8a3cea-0860-473a-a1af-25760c24cca3	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:51.583472
57c046d1-bc57-4d91-b8d0-73f6f8aa3622	397acdfb-efa8-49b3-82f8-d14b93c421e1	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:51.584057
7318d459-4071-45f4-8a81-8e25dd5eb9b7	001e469c-ad70-4a6d-b4d5-54f20f36cd8f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:51.584585
87a5cb64-de9e-4780-8fa9-34c026a7bb80	dc81bddd-712b-491f-9379-a5987b4d8086	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:51.584849
657422a2-e446-4964-a94d-cf335ac69839	f7e66ccf-0cc4-4e1d-ac87-c61258212222	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:51.585138
0b3778a9-b9b8-46ca-bfe8-734152f9dc48	8d23be42-d457-4202-8e7d-ddc7ae56d4be	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:53.798423
208dad1c-6655-4a61-9fe1-4f1bf2c71e3c	5459618e-d861-4c06-982c-d4847df0403f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:53.798641
ad561082-0525-4945-9018-dba19fc54f58	40fe9fb4-6bdf-4916-893d-42fe136138ca	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:53.798834
814cc48d-e8d9-49d9-812b-4d08ba151a4e	f6749df3-cf9d-41b6-8903-8fd3ab153889	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:53.799036
96917eb6-dd13-4ed6-971f-d38dd125e0bb	0b07a4cf-3146-4a0b-ab82-738a04413b7f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:53.799224
94fc2382-8c6a-41e6-9cd8-4799a55d937f	30bd20f9-01bc-47fb-8bea-61ca01603d2c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:58.607865
c003ad49-ff7a-4cf6-b6e4-b90454675740	49a821f0-54d9-466a-ad0b-7415ffbf99b4	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:58.608091
a94e2a1d-3031-4725-a0f8-83b6ace46068	72cd2333-ef2c-49be-b1b4-c01ce726be00	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:58.60828
69f7fa85-abb0-4580-9eb1-a632c336a1ad	b8992f95-5287-43bf-a5b7-7cbac56987e5	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:58.60847
7d275c3f-d1bf-4aa2-b502-aee48188a03b	9df41efd-3a2a-4945-b14f-1298b024f52b	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:12:58.608657
292ef927-8149-4ef4-a3aa-79160761e0f3	79a5eda6-b066-4b00-aa06-ecaa985dc2e0	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:13:01.271388
5e975960-c3a7-49b5-a0bd-6640e29bb724	e8e00408-6fc1-449e-a6ff-17ba8bab1c51	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:13:01.271898
f202e9bd-3050-4cf3-87e7-4138e2a04229	04cf3042-8aa5-4942-84a0-020555ec38a0	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:13:01.272161
90d1510c-9441-447d-8bf2-5d70e2c78e09	b6ca0c5a-b0fc-4447-b812-b8d9b2641af7	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:13:01.272405
f2a8a006-c61c-4589-b248-4897021dbab2	34b3fa9c-b9ab-40eb-b883-4eaa9c9461e1	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:13:01.272646
f276bd0b-80db-4f2c-9759-dec2dd21015a	7100c210-6b2e-4941-8a8e-0f98f4d84e78	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:13:03.593417
4f173d18-6b6e-45c8-ac17-0b780b5fb31f	de534f1f-39fc-4976-b84e-386891a9ca71	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:13:03.593643
d792167f-9d87-4c0b-b13d-6ae8367c7da1	4e6b8b36-c57e-485d-8fa2-c1746d54bb27	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:13:03.593835
c05640ae-e535-462d-9e8b-edf2ef82e3f3	0b98b9da-17b7-4304-8fd5-1e713401ff3a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:13:03.594027
331b90d5-b91f-4913-a248-64d7b7931861	6c65a9be-7b32-4ac3-a73d-3b66925e7cf9	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:13:03.594222
e37149ad-8044-42c6-baa4-8f1f92235fce	62ed50f2-3d81-4e25-98f8-e92680b94b7e	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:13:49.631782
3c7f91e1-d013-431f-89a0-244445b5e39d	ddb11bfb-1da4-41ae-9dfd-797d6f71d141	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:13:49.632009
5ee9e0d8-8dc2-4385-a3fb-b09aa8bd1a34	2d1cf794-9936-47bc-b37a-3510906ceccc	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:13:49.632194
b87e8e75-d232-4ce1-864c-74647c428f95	011c35ee-abc2-41e6-9c2c-5c5791060b06	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:13:49.63238
e131b2bf-265d-4ccd-a59b-19c427cd0137	2fed4b0a-a13f-4453-a4a9-7b41c57d9b0b	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:13:49.632577
b8be612e-f53e-4560-884d-d194679bc57d	9815e2e7-c47c-452f-bfb6-a3eaf867f169	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:14:38.803041
7e478960-a7d4-446c-87d6-8b8d02710e8b	c9a21c08-2226-45d8-be48-a87233dabe8c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:14:38.803329
57f36221-4f15-4720-a786-46f403e6484e	3651b8d8-c163-4c23-bb3a-159a4300c3e6	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:14:38.803566
1568d7ba-bd0a-4c6a-bfec-0cbcce1a5a90	b6b88ffb-c285-440e-9ee7-684bb5f55f1d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:14:38.803806
d7d6dd67-c05d-45c3-a679-3bdc9fb96540	91ecfa38-b6b7-47fb-ae20-052cd5b80e67	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:14:38.804045
682774dd-03f5-4f41-9ecb-77f5a8618748	d551b481-e902-44e5-a85f-ef7d425ed6da	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:16:36.580905
6e299997-cb9b-4ecc-a640-3be37efd1048	29c2ef58-a224-4f63-8421-c92fa5a213e0	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:16:36.581132
24abb3c8-fc1b-4b14-9f83-511a8ee9b5c3	b1c18b8c-938f-46c7-90d0-a0f4c05d556d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:16:36.581321
f9238e8b-64b8-4013-b340-1b7cc3d75e80	cebbc917-5007-4c60-8a72-142c283cec39	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:16:36.581514
67815029-44e4-490c-a5cd-c8c3e03d52c9	b988eac2-8f2e-4cea-9239-9e2a12461f71	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:16:36.5817
c2dda327-9fcd-4699-97b3-35ab18d557b2	a6ffa07c-aa36-4e21-89ec-ca7a223e9c91	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:16:47.142642
44dca5b0-7e77-4f31-b427-36a1c015addf	59ede766-d8d3-4ec2-a5c9-300de406a83d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:16:47.142865
cd1d5ac3-44c0-4bf8-9ad6-8e04e1828580	dd337cfd-5426-4d60-9e7a-3a95c1760eae	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:16:47.143055
80a4b012-1c90-4b2b-975c-a52c37ffb129	6e897079-5144-42b6-b94d-2a2e194d284d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:16:47.143235
b678424f-7e70-44bf-97a8-aff121849f4e	96a052c9-9752-4f21-b5a5-eeb063bbed00	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:16:47.143414
b3df56d9-9c4b-4a7f-8b64-c00556b3b23b	413c01fd-054d-4f61-8c1e-47c44b1a672c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:17:07.676787
a813868f-e062-4c28-a995-934d06800dca	154905c0-3404-4bcd-bb39-fffe1900e55a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:17:07.677167
9f06dc34-145f-45cd-a6b3-7521dd00f4aa	10ec436c-a69b-4c4d-acfa-75e1429afa03	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:17:07.67746
e7cf69cd-bdc2-4e76-b0ec-67907a104520	c393c9bc-a012-48b1-9fc7-1e9d553208f3	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:17:07.677759
da18ea67-ec42-4e2a-8090-628a009fa287	08926aa9-3bb1-442e-8e8f-224940bbe6b4	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:17:07.67808
ed9a4de8-4638-4fbc-8a06-84bc058e2d46	d71d3fe4-1276-4d04-9e70-4fcaa19260f2	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:17:25.145461
2b04fa27-bb8b-4bfc-b103-e1801db92b7b	e83304e2-1273-4b1e-8f38-bc153e735f27	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:17:25.145886
565322d3-72f8-43e7-a12a-2611e0d53ffc	9e3ae4e5-e931-4c65-b0a2-e1889fbd12e0	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:17:25.146299
269ab637-0719-47f9-b84f-4b6d20e67650	522b9ce0-c005-42e0-b81a-ae924ffcb50c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:17:25.146662
ec6b9cc8-7dfd-4d4a-83b7-89c263261f8f	193e060b-01a0-4ffa-80fd-10ef7ec1277e	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:17:25.147013
0cd24243-6b56-4d2d-869e-c31840fd4057	2cc14fff-1feb-41e1-b066-b0915bc49f00	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:17:27.654791
c3fbbb41-5c41-4d48-af62-c8ca1ea440cd	de9d3753-2299-4add-bdf4-c11e5e3084ee	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:17:27.655018
fc9007e2-3662-4ac0-85d1-57f9f89970fa	a76e927e-9946-45db-8108-f93caf90efdf	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:17:27.65521
043bd7b5-5b51-496c-8941-745dc9d0e885	372b4c32-8141-4abf-a632-e843dedce506	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:17:27.655402
bfd6525b-d950-46a0-8144-60fadc73774b	d9bddadd-6474-4c35-a4b2-cfb58ff73928	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:17:27.655589
8e3943dd-3b86-4f8c-8838-2c13c387b0e0	7876f8d5-00ee-4322-8114-776861d0eb59	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:16.970173
b69f89b6-beaa-4f32-934f-e35ad7111371	359147e6-7fe3-48c0-b9bf-19c2dc8a9586	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:16.970405
b96e62b1-f351-4ef9-a1aa-6c5bdead7968	fcbbf70c-44a2-4984-b6d9-62ef54351288	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:16.970596
e11103df-13fa-4b0e-9eb8-88dec34935a6	0f61b207-647e-43ee-96f3-2fae780ff9f7	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:16.970788
fdbb825a-a181-480d-b158-7a2da7338db7	144821c2-1da6-4537-b514-a431f6f46701	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:16.970978
b14eaafa-02ed-4d73-b569-0835617ae354	d51509d9-8ce5-432c-a97c-bd5814139dd0	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:39.361943
039fd8f7-56dd-477e-8d0e-ec265e5458ec	60ee2ce5-5593-4e9b-9de8-57b750e46005	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:39.362182
7f5e7d66-5ac0-4cce-9c72-6501c9cf8e2f	8db5cbbb-a157-4767-8d20-87dbb565edc1	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:39.36238
44399379-e4e8-4918-8d79-aaaa42e793ca	afb17c66-e6aa-4bf5-8e0d-12e280d4cf44	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:39.362569
d203d1de-6776-484b-aeab-6327c34aa4cb	cf832f5d-40c2-4569-aa96-ff69c695101c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:39.362757
9180e8df-92f3-4ba8-beb7-a682e9fa7e7d	adb3e75b-ab14-48c1-a13b-e8eb9f53c447	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:41.64373
5777f990-ea60-46fc-bd17-9c9045f2063b	b5bd441d-da2e-4a70-911f-8daa41994520	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:41.644274
40157630-70ff-4a3d-9a81-6c6272a4ff48	28f9e3a7-f799-4886-b2b3-bd533d82ac36	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:41.644556
a226cef3-2c5f-4758-bc47-1b1b8de1fc75	258d9ab2-da78-4828-be69-f5c3bba8e96c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:41.644826
b7a57b7e-49f6-4d9f-924f-e8dc83fae856	1e1653f1-15f4-4506-b521-30092944d07e	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:41.645124
21da2945-bf76-40b6-acd1-bcdd66996602	31e0d5c5-0e35-4acf-ac87-7230a63b1ec5	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:47.888589
a9c9d619-b50a-44bd-a725-b500df073502	9dc45710-a3f0-498f-9b5d-15f4d1a23c37	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:47.88881
e54bc02e-5d0f-4cad-a363-ee67ee15b9c8	9c1c7d11-4d8d-4236-8b0a-7b67530b54cb	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:47.888996
70bbab6d-3358-46bf-8fdc-c4654b405c60	577d348f-391e-42b6-8934-cf916b6d3a00	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:47.889181
5e39226b-5838-47d8-9091-c9120efc3a22	8992e4d7-d165-4f4d-b404-4da83f452828	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:47.88937
60eddc84-9572-40b2-ae0e-ac59b2766a98	c8ec5ec7-9e3e-48ea-a4a8-1741b6cddcfc	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:49.992254
606e8de9-0f5b-4447-b80b-31ff7235694e	b99783ea-fa91-4e86-87cf-a4bce2610a52	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:49.992471
2e8bb8f5-442e-454a-abfb-5d24a5d7b58f	0cb967e8-ffb3-4c69-92b2-a7da94ada3a2	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:49.99266
890efd6e-e69a-4603-84fb-e61401a207a5	d7bc8e4e-190e-4a03-a001-ad7c5e8f3c5c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:49.992847
dfb8270c-731a-428a-9f62-b6a1f9353cac	819f8b8f-bba6-4767-a7f1-406381241ec3	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:18:49.993034
ae72f188-8241-483d-a98f-b0be95f1dd88	d731858d-fc41-4601-82f0-68e8def62a5a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:20:21.647925
7db4de6a-d450-447d-802b-031100acc277	146cb9c4-833f-4187-92cd-eac86cc38407	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:20:21.64815
571ac888-8b96-4dc1-8112-30d6ddd51961	2efa766b-ce7e-4b0b-89c7-f1c815aa5def	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:20:21.648335
ed0a00d4-7ed9-409a-9f9f-f5218d131c9b	6eb9d390-66f8-4c96-b001-129fece11add	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:20:21.648527
b43ff86a-08cb-41ca-ba2c-b03479a51f16	845ff3e7-02f3-4576-882a-d6ca298a609b	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:20:21.648716
812db2d4-a500-4117-ad72-79a8744355f4	5bd250de-2876-4255-98b9-dac12dd8d665	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:21:55.550868
f60a9982-b1b4-4a8f-84c8-36a237625722	ffe23b2c-b786-46b1-bfae-6418c579d339	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:21:55.551708
56da8a5a-1d9e-4783-accd-7610da76013d	cbb1e400-821c-4554-ab39-b649d6860bdf	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:21:55.553946
03c8ddcf-8025-4ce3-9f16-409dd8bf6dc4	ee84da75-1e6d-4496-a77f-12a2b053db23	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:21:55.556452
1829d6a5-e0f0-4ce8-a304-55f635010c75	749633b5-d381-43aa-9f85-743216a8c178	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:21:55.558478
61fee448-904b-4481-8e98-980f420326b0	61da18ca-fc13-441e-9fdd-8b7006fcac87	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:21:58.281296
27931d75-c741-4651-a32c-5ad6636a8d51	d9ff8af1-447a-49db-9d5a-3247b5eecfce	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:21:58.281525
35d478f4-9ebe-4b75-bf0b-a3136a772fe7	f3ac3ba6-7785-40a2-97aa-bf7b4048e405	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:21:58.281729
148f37a3-a39b-4d60-be77-f7d1d8d63540	b633c0a6-f021-46e4-a77a-f6d7b585517a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:21:58.281931
c6a1b779-314e-4984-8468-4ba1626d2960	3d3b7448-60c1-4692-a7f9-93033514fcfb	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:21:58.282157
f6291344-23ae-4456-9760-3118608770ad	03e638ad-9ca0-4b87-97a1-84444bc7427e	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:00.471677
b5e5ecff-6e8f-495f-8a5c-23f31f60e625	a356168a-a2fb-4faa-9547-61ea7d0ffcc2	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:00.471898
a8ca4e34-a85c-4f7c-be3f-36c465c20c00	12f2214d-913b-49c7-a1b7-cbd30e2b06e8	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:00.472082
04f6414c-b878-42bd-b20e-314cbfff1087	a9e404bd-c359-4592-a8eb-650351303727	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:00.472269
9efab48a-0e40-4772-9a97-fdcd16c88432	512ea456-a5a4-478c-a5e3-f1db39a5d987	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:00.472456
5f3e433a-e406-43c4-a061-f9c85a6ef9fa	10904559-fc75-4fe8-97c1-3f7e23c86024	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:41.802007
b27dacac-7a33-4d2b-ba66-13594d6d4782	a84aac1f-176e-470c-9498-895ad9afc99a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:41.802255
b91fb8df-afa6-4b87-a391-14f6ac29385c	bb5f1d09-f3d4-494e-88fd-bd08567f4541	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:41.80245
34fa2882-aeac-49d1-8e03-d7f95c772132	83dd1dc5-f25f-4db6-beba-5d189ef50ebd	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:41.802645
b4f2a2b2-e412-4b2f-a18c-27489e235448	1ab1c132-4ef0-4a1d-a282-494724f13944	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:41.802835
4b31cb75-88c2-48fd-b8ba-8ae4e3c52389	dad62297-7a6d-4b13-bebb-d17c7e92e675	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:43.902956
159e243d-efa9-4b56-b454-5d5d6f4213cc	8f7490a8-f7c2-4348-b2f8-6bd05f1f8eab	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:43.903196
b3a8c43d-0a30-4cfc-9443-546dd28a4f86	815e5a80-d800-4556-8f5f-f5edb0806175	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:43.903382
822f271b-b7fd-43fe-84d4-931bb52aee63	514425c6-9a31-4b81-929a-8589fe3c8972	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:43.903572
6821bf21-bc94-4a76-88e7-4b5afdb923a7	8a15755b-aa7d-41c5-bf04-97142646f8de	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:43.903764
1cb5984a-b58e-4f36-b868-c135b7ad6d26	3d0df38a-084c-4a3f-8b23-ff1a7f552667	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:45.951767
680ab24c-37f9-4e93-a90f-cbb51d663b5d	1c04f56d-711b-4bd3-9ebb-8f51329a0c52	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:45.952
ffc16012-2cc9-4d9d-a38e-e9609b842341	adbf2a1b-46bc-4d01-aa06-d6988934aa34	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:45.952191
3b3f78f0-cde9-4f9e-a7f3-042ca101ea9d	8e743203-767f-427f-ac4d-053aa6b8515d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:45.952378
1448b012-d3d3-42f2-a556-fa9d4faeebb5	65563d16-d17c-40da-8990-f4feecc52c43	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:22:45.952564
112ab7f4-091e-440e-b01a-a92059e2f5bd	b7b569b0-18b5-42c7-a656-1cc3e45f4dc8	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:16.235903
644120ff-e691-4da7-9d67-d436f7d31f88	882a8429-3a46-46c6-959a-c1ba75993b7d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:16.236214
215f517f-4171-4ade-ba77-de7d86842a2e	adc6e315-ef29-4431-96ea-5a2b87d771ab	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:16.236473
7e1034e0-2ec1-4328-8e1a-b49094c5b723	ba5c3802-88ca-477c-95e0-fad6ea77a6a6	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:16.236718
8ce46a8c-73fb-4d9c-8e83-a62a517b810c	59736b4e-78d2-445e-8a57-025dcf3ffcec	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:16.236964
bce8a42c-8999-4a66-8c81-8422443f750e	04fe0900-d3be-4bd6-af6e-61196eccc1f7	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:20.441483
9dcfc978-cc40-4bee-a3ca-db39e777051f	ff75c1b5-4cd8-4184-bb21-b4ab37c3191a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:20.44171
f6d4fff5-d43f-4c18-aec9-cb026c07fd12	b6925f71-ff8a-46c9-8532-02434f96382e	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:20.441909
9d187b26-cd43-4d5b-8768-fa70f5ab912f	b373d3ec-31d5-4a9c-b300-3a9d3e4f4f8f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:20.442108
3d1cedf6-60f2-480d-879f-134264eac9e4	5d3dd8cc-c028-4387-bf57-87f85c7b26ab	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:20.442294
47fb87bf-9ee4-4b35-9fd4-371f5f7c8bfe	76c0b4c3-3eb5-42c8-8216-cafe81cb19a1	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:30.453864
e45d744e-1231-49fd-93dd-56a896ea3aef	8c4fb1ac-ca28-45cf-843d-8f44e9f89a1f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:30.454108
15942faf-b07b-4e0e-830d-69ac69beed09	634b8092-f14e-46e8-bc51-8a6cf3e0e9bd	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:30.454299
4ed4d930-7479-4762-930f-8dbcd71f00a9	728272cf-2e3b-4fd2-b119-7679886e600a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:30.454483
9676d4ae-0975-48ef-8991-3c51fa78d33b	f33af8c3-3d4d-4778-b990-a003290c81d8	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:30.454665
a6c9e77f-1ce3-46d3-ad72-84005dda5e12	1b465bae-df72-4cd2-b7eb-3270e1f292de	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:32.580135
6b891f60-d268-4186-99ea-87d1fa940170	5c47a345-6bb2-4cbe-bd34-6eba52911de7	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:32.580369
ac80413d-06d1-4108-96a9-2b4eb98f2f41	218c8824-b7bc-4918-9eda-941094e3caa9	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:32.580556
b42a9dd8-314d-4e4c-94ed-5e273abb7532	aa1bfdc5-f2e4-48d2-a662-bbbe7a610a98	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:32.580736
21c47a7f-fd4f-47a8-b057-53c0d3f72c09	d044c1fc-ddb0-41ff-849b-03ae00537a59	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:32.580919
2ddbf1c3-21d5-4e29-a67d-c88da004c0f1	2e5151fc-0083-445a-9486-152c6caee76d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:40.084361
ae403363-7d25-484d-865c-731b0a0aa938	ead0c6bd-85dd-4c0a-971c-611e09365eaa	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:40.084644
a111061e-9742-4bc1-8e43-831578834ba2	747aa83a-18d9-4382-89c2-f5bdbaf73d28	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:40.084883
dc5f2bce-9f8b-4810-a04c-f77c624415cd	c58addce-cde3-4465-a660-ed4ab4e107fc	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:40.085129
a1ada191-a4eb-43d2-b027-eeba4f014cce	c7c85131-5c2a-415f-a0a9-2e83b5e83c6d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:40.08537
c8c56212-37c3-487b-b4c8-0d38a33d6f90	fcbde92b-eb14-474e-8f9e-d02eb19304e0	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:42.439133
3a06c3b9-6e85-40d9-a2e8-28bd571b03ee	8a383caa-a429-4fe3-a326-6dca556be07c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:42.439362
4cd191b7-5894-47e7-8f46-62628d852082	cb70200a-c2e4-470f-a0ca-6e1bc87ab230	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:42.439551
1c42e483-48d2-4c4a-8a29-f0b543a97f5c	4df5515f-d7ff-46f7-9f3e-7b542ea425c8	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:42.439733
8ceb09f5-ad6a-463f-adaf-1f5c39b057da	bc9755b6-17da-439a-b6c7-6d71840a668a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:42.439916
f2b7d47c-8b88-4d68-9408-8b4e5b8f8b33	ee89bc23-9933-4d90-860a-7b1573c9ecf9	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:44.525055
1b54457f-8460-43f0-8b3f-7806a4ac0746	d090c181-0b4e-464f-94f7-97625be97101	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:44.525285
1686031f-0bf6-4ef0-9bdd-81d97c64a8b6	7fde01c4-75a0-4e2b-9a17-759772944a6d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:44.525472
b1b9e863-1883-4886-9e2d-0f90b11cd498	581522e1-646d-4b88-95db-fe381f10aeaf	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:44.525652
853acf52-3971-4920-87b9-b3ef7e6d31fb	b150d279-3b24-4829-b6c9-23f89968a219	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:44.525831
5e6c55fa-0838-4724-a1ac-6ff1e17f2604	24d10189-dab0-4876-8f68-ba0c51dc1a3c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:48.684636
4743cc8b-b59e-4efa-a58a-3164f6a3d6e6	c4a4ebe9-fc17-4a07-a8be-c05076d4e5f9	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:48.684862
c662d8cb-08e2-41d1-a432-194fce119856	cfbdf8b1-3769-4589-b758-ea459c816af0	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:48.685049
86698bf5-ba1a-4ad9-9892-d8f55ffd9f35	fabdb457-8af4-490a-a5f5-5012dc9afa5e	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:48.685232
e912fdb8-566f-4d35-9692-4c12636b1414	773872fe-d4dd-4452-92e6-fd80065e7676	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:23:48.685416
47cfa3ac-975a-41bf-a48a-58c568661af2	208a0a56-4476-4c71-bd32-49c1e0e620cb	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:25:32.591478
fdf9a387-4b5e-462a-a957-fc6096120c47	ec59add9-88f6-4dee-a26f-1bee1194f879	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:25:32.591701
b5e65e2b-ffc1-40c7-b958-23208829ae7b	80332fee-f19c-460c-aace-3fb9508dcd4d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:25:32.591893
43876e8f-3e8f-4afc-80f6-e08d57a9f804	64a70c5d-e53d-45f5-96d9-76659ff1bd24	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:25:32.59208
b4e66b72-b431-4e4d-9ba2-bee159f9d07a	986d2ec1-66ad-4c77-abe4-d27820baeaf7	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:25:32.592276
38c775b5-3b23-48c4-8e59-ea454916d819	f0d6b849-5263-40a7-813f-7583777503f2	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:25:34.617944
14f69b2f-9383-461e-89d5-fc9ce5612b14	a05b3ba4-5ed1-4560-a839-f52b51716c5e	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:25:34.618176
92031e7e-2f1f-4dfb-9325-7db9c2ff9967	7d19823f-e98a-493f-89b8-ce297e3fb870	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:25:34.618364
97f3d398-0b79-40ad-a922-a07d265359df	146a7944-2909-43b5-ae28-1d653c9907f4	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:25:34.618547
a5d87917-f12a-4903-993e-b8f87a65a671	8977a4ea-044e-49f7-9301-ddee751d8833	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:25:34.618731
6d6f2d66-0e84-4b8a-b551-2682cd98d2d5	515fd863-6fc4-4ffc-9b55-9473a764096e	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:26:22.051623
71f42688-a92d-4140-9686-8935735ec271	4d8005d9-29e7-491a-830d-50cc5f7ca5cd	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:26:22.052059
2e7a8af5-a64b-4dfc-9646-001887d0dc9f	57027f60-ea6c-4bd3-870e-0a269d72e632	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:26:22.05231
73abc5ee-aa46-451f-aed6-513522db5cf3	bd7642e1-401d-428c-9778-b638654e6ecb	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:26:22.052545
e59b1df7-c771-438f-b159-d27f6aa9d6b3	d1f48038-de76-4055-ad96-2af87fe133c7	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:26:22.052804
198bdf9c-99c0-47fe-8258-80e078e22cea	6363f066-4227-421b-83ed-e2a86a7ae109	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:26:30.043889
93de7adf-4a13-4f33-8557-891ef41d5599	01d2276e-48e1-44e6-9a46-c91ce6543e4f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:26:30.044128
dbd0e0b1-4396-4e08-89f6-c6ded31e03bd	514dab71-17db-4e01-879b-c6381a98b0d1	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:26:30.044315
9b3bb68e-d011-4e59-9714-8432ca6cf4f0	a70e4e6c-0023-41e8-908c-b351a78ceb12	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:26:30.044506
fdf8d4fd-6b5b-4620-9dac-64d70c4a5b38	f9fc3cfc-7ada-428b-a7b8-6a4688887eb7	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:26:30.044692
15b0d083-9b92-4859-9d13-1164c57f7a77	6aa3267f-2371-45f5-9d28-631c3c1ce601	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:26:57.915975
fd14ffb8-3887-4ebb-bf73-a014e6e31f6b	3379b95d-62e5-481f-bd39-168ed144d846	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:26:57.916199
72ddb2c0-aa8e-4e42-a0a8-f8ba315dcf4d	7c13f389-1e30-469e-8513-6e01c5a24c1b	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:26:57.916388
d6800ca9-6d0a-4d40-94f1-d070370021f5	8263e480-6f70-4253-8a82-6ca74f9b99e2	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:26:57.916569
3fc6072a-f523-4932-ab94-ae83c88b3605	6d635f29-470d-4694-ab6b-0473a4170abf	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:26:57.916752
ec791097-3f19-468f-9015-cf51082fd690	83f3fa66-65bf-48fe-9868-a835604b51c1	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:27:05.060204
d7442e39-4e8d-4761-9c49-8bdbb0b5d512	73dd80e9-651f-4eee-880d-9e467edde9ba	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:27:05.060464
6bef0697-86f9-4caf-a186-9b17623399df	76927b88-131d-46b9-8d9b-520d379105a5	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:27:05.060703
e824b2a1-ad2d-4dcc-8d62-7100fe524730	c60f2919-6b84-42c6-af1d-0432230f9364	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:27:05.060939
39eb908e-d34b-4a10-9b4e-cb168c564c72	ea7f1baf-cc33-4e89-8bde-3dc13be7c750	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:27:05.061138
15e3a864-4530-4d0c-95a9-082be3e7232c	45492d82-251f-4d66-a59e-1d8d8f1e8e8c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:27:07.481987
688b358e-d373-4d49-8ac1-1f7b4fe22bcc	0dc4cee9-f04f-4af9-acad-f4461843b54d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:27:07.482224
2d4a7521-5d03-46b8-82b9-0e6a1ca24be6	1507f5ad-b4e2-4228-923b-385eaee29cc8	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:27:07.482414
e867eb25-51b4-4656-91a9-e4569945e516	955ec9e0-ef17-4865-9c34-4d9005683966	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:27:07.482596
09519d90-a260-41c3-ad7e-8e23bb43e744	ca375d33-4ca9-48d9-b763-4467c372faca	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:27:07.482813
a8fe6562-3456-4d32-8dfc-ac8c96024f52	661263e2-747d-4e12-ae08-71822c7c0a69	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:27:34.17064
ae0474d6-843c-4ab4-b567-bbd8d6ed4995	3c898de9-3881-49fe-a370-1f0f0fc0f6ff	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:27:34.170873
ed19388c-7cca-4d0e-9984-db666f9f65ae	5db86726-60ef-454c-9829-33d573a28135	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:27:34.171058
df80cf13-4a8d-46af-8bcc-2d5dabf48105	c4f76227-581e-45b9-9f91-7eb7a2846ddd	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:27:34.171241
6556c714-2f09-4992-b989-5e21c71ca465	e27280c4-31b7-4280-b895-c8d2a43f624d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:27:34.171428
fe44c4b9-1d55-4d87-8c6c-f20a52e15d98	efce2178-b9c5-412f-a0d7-efd2e5226cb8	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:14.184609
0384d3e9-c715-49dd-843c-6074d84c6a39	189e9db5-c0d2-42d9-bb06-e2d36a54abc9	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:14.184832
ea8416f3-be2c-4b86-9273-9e934e2dda5b	1c4d7b4a-642e-418e-af01-6dc3eef23c2b	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:14.185024
00770057-f354-48db-87f9-97d59f84c0f9	6bc05417-5abb-4c48-8220-9e43623dd38b	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:14.185209
ca3cad2a-3213-4ed2-a095-e8a8c349987f	126e2aa7-8bbb-4c6e-871e-17876e367e7e	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:14.1854
9cebbdb6-533d-4023-9057-5e85fe9180e9	14a4ad8b-4671-4391-b701-1a01a394a771	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:17.798197
62de073d-c883-4408-952f-1d0cd3b621b1	1e2f7f0d-e906-4e9a-ba63-d57eb26c82a8	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:17.798419
d6c8f91f-e081-49cf-a9d2-e05d0947cb29	cc4a6620-439b-4413-863c-3ec255e25ce2	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:17.798606
83b079c5-0e6b-4678-96eb-ebad0f17dbf5	6ac104e3-9d29-4b39-a84c-d95f6fbb94c4	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:17.798794
3d3a4154-4924-4dee-a26e-3a9e6fad708c	c105da96-4b86-42ca-ba10-154a16e86290	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:17.798976
1c5af0cd-0dd1-4a97-8df8-6289d32c5eeb	964b3205-9679-49df-bf3a-17f5e13ad4a2	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:22.099588
36436645-f7cc-4988-816b-a1f6cde0f9d6	68b16285-681f-46df-81cf-b1d4f13b2bc6	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:22.099814
c17c1a9e-bd04-45fa-bd1a-d652bbd741ca	d3fdf768-402b-49d2-ab5b-494c6f503e6e	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:22.100003
4876f8b1-4699-495d-9afa-0e626c14c6c4	a6654c04-244b-4e73-875d-807a66a6fc08	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:22.100187
b18203a2-7d79-4faa-a13e-c34d3323a2c8	9405d9c1-caae-480f-8122-ba37e20f7c1c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:22.100371
2b2c26d9-0d4d-4c8f-8461-7311c064bb21	2adb57ab-3262-4a55-ad7f-a8c9eed3beb9	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:41.581341
5edfddd4-1584-4dd2-8f72-109b1bb19a04	81ccf0d5-c895-405c-bbca-4534f8fb5502	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:41.581997
aed0e558-bbc8-4955-9b7b-686621656228	3fb10737-1a70-4a7f-9c43-ac459f922771	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:41.582484
b5c08aff-3607-47f9-9242-4965b708c6bf	57b67a22-e023-4a14-9d02-7178a64c0e3d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:41.582934
889bcdd5-0fc2-4c4f-bf5e-ff8cb2fb8eba	cc65c193-ada5-46f5-bfce-27ae15407776	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:41.583304
fa9d6cb7-95a8-41e0-9029-80ca7a870625	ff9ca4da-370e-4165-8701-60819433cfc7	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:44.128457
8458249f-f8e8-47da-bfdf-9bda9b0b3212	50b0ac25-3f5d-46a9-9b95-224401cd4f60	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:44.128736
f479efcb-01e5-43ca-97a2-41ba6a82bd86	b3a280ae-812f-450d-a21b-58ac7e579426	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:44.128994
f35be571-1f18-4078-91f4-b48cbcfef131	60e279cb-674d-4abc-a166-3bd6ef394caa	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:44.129234
7a2a058a-84d8-4cc1-a89c-d52d04a2122b	c997d9d6-18a6-4c37-b880-92f2d1c2121c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:31:44.129479
c9c98438-e904-45f8-95e5-f362ad0c54e2	4ff62187-5a40-43a2-825d-b69794192399	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:32:03.51072
0789fc2a-91ea-42f3-a9fc-5a52944abe95	c5784a76-e069-4644-946f-3d0b1825a5cf	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:32:03.511002
0cf3fa65-9f5f-4b66-bc3c-256d25ca52e1	8ba24a9c-c2d4-46b4-b361-a78836eba278	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:32:03.51124
e968990b-b242-469e-b90b-25f76066444c	3afbfc5c-411e-40ba-8cd7-6aada5c865ac	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:32:03.511475
7aaed8e5-9ea4-4640-a7e7-3e95506cf3fb	5070e582-3bb2-47fe-b827-9fb07a75ccb3	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:32:03.511723
703a0262-9718-4662-87a1-25444bd3231c	15770961-01e3-432e-8245-5b916b4bbd78	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:32:14.867264
ca7a157b-4d30-4bda-ac3f-be215882d4d7	2bf029ba-57ea-44e1-a79b-70349d832359	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:32:14.867486
ef5f6afc-bd2d-427e-b760-55ec1538370e	3d5beeec-0002-42f7-8f17-de12587e538a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:32:14.867673
e239ada1-f8ce-4231-8742-ece00d8db68a	44d2368c-1db1-4829-845b-a774bd522c5b	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:32:14.867855
31d690e6-5b39-4325-a3e8-620daff698e9	e7ef1754-98e3-4e28-841a-1e5ac83285bd	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:32:14.868098
bc0e9d12-993c-454c-8676-bf42f4d0a96b	ebd56787-4053-43f8-afe6-f1f6137183ab	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:32:18.299232
07ce8981-e3df-45ad-875c-c41be831070a	29e30255-7e38-4d32-bc3f-b1bc2870a730	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:32:18.299577
b199d134-e5e8-40d8-904c-c7bb71bdae70	6ce7141b-8f5a-463d-ab58-2a14924ba0bb	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:32:18.299905
a33ad304-4061-4ff4-9346-a3005a3df37e	2f63a4a9-6c04-433e-a06d-52979ffa3f60	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:32:18.300172
52630d5b-c129-49f6-bd42-fa8f60a82c2f	073c4680-398d-4f24-b306-e58754714cb0	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:32:18.300421
b6861d76-f372-49ac-8d81-89d369342ace	db16281c-8c1a-4ce6-880c-882698428c9c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:24.929267
7b3d3604-9f37-4695-beb9-e80b78ec8037	696d7d4c-db83-4750-8011-10b30cf6e8e6	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:24.929504
5e170a88-b00d-4f78-ad3a-56af7d174311	8009924d-4047-4b31-85ff-8eeed5d7587b	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:24.929702
41cb8caf-866d-4608-8021-06b71333254c	76bbe6ef-4f83-4d47-8095-e3599ac2457d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:24.929894
0e02b8be-0ebb-4fe9-9db0-c40ab001cabd	d90909c9-12e4-4674-90f2-6a939801638c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:24.930111
e74585b8-a6dc-43cf-a5a1-a44f7216d3d9	8d16fef3-d430-4d42-9540-c068345c3535	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:31.754985
1e89979c-4068-49ed-a4c3-e26a6c96c27f	ae4c9c70-a417-4630-a83e-b3f56a6092bd	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:31.755214
50a1cca0-2eff-420d-a5a3-d72c39e9637d	1a6e6849-be27-4466-8ba3-30b3a2ab2b67	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:31.755402
6fdc86c9-2d2b-4faf-ab7a-c1997ff8ddfa	301d582b-68dd-4527-aba1-debdb1ffd689	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:31.755593
adc35b64-e1b2-4e8c-82b5-4d2eec9d8040	b5e8abe7-2af9-4aad-ad0c-ee458b0b737e	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:31.755782
f1cab30e-596c-4b54-9c95-5cfc8e8f2940	015b6b37-2e42-4083-80bb-fe11ad644740	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:34.166321
cf87aad7-fed3-4040-bae4-33bacb09c273	d761e3c7-30b7-4e3f-afc0-4c412a1700e5	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:34.166587
f0d6d1c9-14e4-4063-af71-4e17c15c97bb	bd8cb63d-9700-43e4-bd37-0c4ce4588a6a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:34.166808
bd2ab52e-7622-4b5a-b95a-f96af115d338	26230aea-3041-4645-ab7b-23b1c0db5dfc	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:34.16702
aea0bbab-c834-44a4-b33e-db9161fd5414	aa9847f1-b709-41f3-b8d8-cb05e6951110	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:34.167236
d91ece09-7683-4c7c-b48e-701c4776f188	0c367890-d329-4448-91a0-808303b8f324	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:36.388987
d44a60be-152c-42f9-abfd-c7b8a945860d	f109c9bf-d03a-46b8-b0df-88aec6acd29c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:36.389214
a50d7ef7-9261-4c7a-a8da-c37bdc9f6c4a	5a80b8a3-b9bf-4c08-bc80-9561e37bc2c4	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:36.389404
4c7bbacc-58e8-4dcd-a31a-5d3814d957db	53e19256-e38b-4774-9995-1c9872adb443	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:36.389592
ad490cb6-4e0c-4e36-b937-ad97dd0064df	c92eb4ab-fd29-442a-87cb-6ad4753245e3	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:36.389779
cd7f078a-fe27-4df3-b447-56c327284d91	a3ab0795-0ffa-4a5b-a21b-2f8acc540d8f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:53.843113
5fed26bd-d67b-43b3-a30e-d1c3ac9cbd22	4fd385cb-f0da-4059-80e5-1ba0699e36f5	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:53.843335
470869e7-6a44-42cd-8651-ea8af30dc6b2	ff55bb86-c478-4899-92a3-e80dc0f13558	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:53.843526
4d34dfcb-36f2-40cf-9c4d-2232497ff467	51bd7aa4-4784-4a9c-bcb2-fd58032f7879	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:53.843713
f8cee1d1-52ca-4fc1-b303-03ad2a90ba1f	c3cc795e-7ac6-49c8-9c6b-50af2de46df1	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:34:53.843901
9b85c75a-4b77-4892-9157-b7c7e5821012	a5f29eb9-ab75-494f-a420-a3161487ca17	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:21.737557
a72957c0-e3dd-47e5-a692-9e571165683f	387e489a-27a0-4135-82f5-3593879cba37	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:21.737866
1e00c61a-7bb6-4ede-ba3f-cf8a4034ee0d	f9b415c7-1dc3-4101-832b-77db8ba23a1a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:21.738151
2d9d5a36-6ca3-4b77-8cc8-3b2be2e744be	9678e391-c1c2-4f25-a443-c985ad1c2003	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:21.738354
b80df30f-0503-4a9c-ada4-95aaddfda900	f497ef7c-c49f-40a4-a70e-fa0d2cd41152	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:21.73857
445dd055-e2b9-4804-9c00-4427bf8c8aec	2c1a9f22-149d-43f6-b42d-83927c5de197	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:29.431274
48c6f1e8-e85d-45d0-a903-cc1eaf43bfb2	7bbe89d0-1a97-4e3b-99af-f73f5163ed9a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:29.431586
ccd29718-e047-46fd-99e9-ea5ce394299a	c32b43db-6084-4ad0-a622-fd20cf545d77	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:29.431807
fa6bc1c1-2b6b-4295-b917-3f2cf4ea80ac	1897c90a-9bf0-41ec-b215-f2f71946cdec	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:29.43202
91b9129f-7cb9-4147-ac8e-abda7a0e015b	51622874-ce52-4c43-ba3d-10b76b8737d1	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:29.432234
d3c124bb-84e5-454d-8ecf-8c57238c261d	d9e23646-4aa9-4cc9-875f-c3f502e61d18	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:32.533373
6996fba9-cac9-4edb-9225-6e338a6b1b94	40774280-aec9-4430-b36d-e5819f02401b	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:32.533602
b7029692-6f68-46b2-86ae-8b28ed780f72	65f4fe21-2dee-494e-ad2b-056d0a3a6203	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:32.533791
ae8f782e-e33b-4e42-904d-a9bf29f0d410	64d174af-a2c1-4da9-9345-79673ba2bc10	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:32.53398
64afdafa-c81b-4bef-a6ce-842b8835b283	c18e9a2d-4b25-4f70-850d-3df93ec89822	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:32.534174
54963509-8970-4459-9332-496514aa4033	26192d94-c01c-4104-a080-88fdde8315fc	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:42.401807
a38a71d9-4513-45c0-9d14-fb3238b40352	37257cf4-71b2-4495-8830-3f4ee8e906d1	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:42.402156
7289c313-5619-461e-9de5-97f51fe9fc35	e836b9f8-398b-4d13-b417-d3561ff5dcab	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:42.402416
d6658875-1d4e-40e6-a9e4-cd74d7939d51	f5b1e5c7-224b-42f3-8523-6e9b81158ac1	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:42.402637
022c3d02-2df8-4e3e-a0c4-4610755afc4d	43fe6797-4a5b-4f62-9125-f4b288aa6b2d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:42.402871
70eca5ee-e5f1-46b9-8cae-05c1407ca03f	1441ec9d-d3e9-4a44-bb18-84f7eac71e7c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:44.51419
f2776c3b-d08f-4531-a38b-b030d4bd9ac4	22d7cf26-a196-4675-99e5-a05cecd01f05	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:44.514425
3b3f6de7-3029-4f2f-a711-d3ce3aff6eb5	66e19648-a101-4f2d-af8b-2beb41994262	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:44.514615
f1ad926e-f8c2-40ea-a54d-96057e4fe7df	4adc5d64-c49d-4800-b11c-a614733e4049	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:44.514805
3c474d37-96d2-401c-b539-242cdaae122e	44d75c88-b86f-4504-a1d9-e620400b13cb	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:44.514993
d293c752-0489-4933-bf51-3ecba2cfdf36	9701a8a9-b88a-444d-aaa2-f96290f1be1a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:53.64543
c012d29e-d951-4ee9-8927-ff451c81d198	1bb7a2a6-3294-479a-b854-61857642db9b	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:53.645673
701f13d2-78ec-4ccc-89fd-8226f5c32eda	ef0d5ae5-1349-4703-b271-090e630cb477	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:53.645869
5fa0fd58-bf9c-4b8c-8313-1213e595bcd7	b989c4ee-d69f-463a-954e-7c8791b5b5dd	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:53.646068
f95d1d1f-17f2-4e91-9ff5-cd759226a00b	10c387ee-94d6-4f75-b525-5ea9e0bb7695	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:35:53.646256
0d83847f-ee92-4cd2-8cba-994202af8ad6	87c83f14-3913-4390-a696-f4ff277d61d7	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:02.176809
216860c0-0461-49f6-912a-580beec5187f	27c92011-c90e-4352-9358-210ed9bce26f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:02.177033
7c2e5844-8da4-45e8-918e-75d4a024a585	66c84210-2942-4940-8d3a-f439cf15827d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:02.177221
7491ba8a-a177-4676-b080-ae99e0f8513e	daff8b0c-08a3-4718-aae8-842ac5449813	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:02.177407
2c0c4739-45a4-43c3-b484-5e96493bb0de	6801ab6f-58ce-499e-ad80-f6683c66ca86	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:02.177596
3f3bd77c-f7be-42c8-b770-6d75fc48c0f3	c5078755-c83e-4d38-b752-162cfdc63fa4	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:30.898636
fba25103-b706-4c03-bbb1-94c510c52689	52148261-4ccc-4679-8457-dc13729e74e6	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:30.899187
567a19c3-4a3c-4cce-b823-2f0aace213fa	4ea7e43e-87af-48e0-a778-fc685e19015f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:30.899619
cbfc82e9-62ed-4884-8be3-3559b56613fd	720dcf7b-6486-45cb-afed-f406fdc85ad4	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:30.900041
86afc663-44ae-49d7-8979-d7bbe9520c58	b7ddc54c-6cdb-4eef-a9bb-02d738a760bc	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:30.900453
3f002ecd-7f29-4695-aa5c-b8bc0a749d4b	ebf838e7-96ab-4740-9c21-6b4a70ca629f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:34.019769
6095d8f4-468f-4aaa-81fa-f765b27a3c48	db3348a5-a8bb-46c0-85cb-3281a4172cfb	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:34.02006
86c8fcf3-3b50-4e1a-9ab8-3517915b9b9c	d35386f5-d918-4c18-8277-a2727f440864	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:34.020299
568f3316-a08c-4eaa-b083-959a3a8d307a	1fbb8168-3748-45e1-b966-90104839ffbd	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:34.020553
74c573d6-30a5-4d7c-a333-b3226b3e7eb7	3e12e590-2087-49ee-b83c-a810ce776d1d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:34.020795
7583126d-e128-4f0b-9a4b-1b89107eb9a1	ef44c58e-f331-47d3-89b4-a2514b2e7de6	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:36.359132
dea2032f-a741-4bf9-90e6-2376c6c317d8	88230a5a-d678-4f59-9b52-53a82fbed365	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:36.359468
da3d0a25-23a9-43fe-88c1-b08c2cf590eb	24ad2880-2ed2-4382-bdaa-064353a537b0	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:36.359726
468c6bb8-9303-46a1-8a82-f4c4578c1c48	5881d434-021d-4854-8626-6586a80ea012	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:36.35999
b05814bc-764d-4c8c-8acb-b3af4b0152c3	2d6e5472-6fbf-43ed-8d43-1567282817b0	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:36.360326
2b0ac335-41de-448d-a0e8-06c0862bb4ab	2446a1eb-9e47-4c47-a134-4440ddb5ab8a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:38.561441
6a58da46-21c6-4425-bd1e-51045733c8aa	f2b2728b-e8d7-448d-ae91-89dcc636b799	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:38.561754
5b321700-cb27-43a4-a2b9-3bc86b09e697	b17fc20b-1353-45a8-ae31-d19d434e016e	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:38.561994
4d6cd0e4-3b67-48d2-8485-a1280e2b24a2	cd478267-7b87-470c-a7d2-28a6288877a0	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:38.562249
bc41955f-b511-4a3e-b4a8-0732298a0402	da21c437-1d36-4100-8642-2e53821387f7	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:38.562486
09c34152-b223-434c-b4bc-4bf9c8ce16af	7b76317d-cc66-4554-bb0b-972f86f915d0	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:50.053218
fbc7dc5b-e47c-4850-9469-d7aecd6fe7b1	a7f86014-ea12-49d9-8387-5e1804481fb8	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:50.053459
d62664ab-2b63-40c7-99e6-eaa87f4706a7	ce629b6b-530f-4fbf-b470-8978244dff57	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:50.053648
74c7b9e3-f806-4023-85d2-ca65edbd8c09	b49bb257-a199-452e-b406-bcded2f5acaf	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:50.05384
556a6191-3e34-422e-9420-d0c8a3ccf5a5	d2125098-182e-415f-9edd-c56f978c2b66	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:36:50.054028
e42e69a9-6b9c-4286-bbdb-120b9a901565	8efe660a-bcf3-4b87-91e2-0c9764aae629	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:37:58.174628
cad799ca-d1ea-40e3-ac46-7a55ec181272	5338654b-5a14-4692-8f3a-80ef01b504d6	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:37:58.175094
52e345d0-9b0f-4926-a3eb-44b8fee13264	97d37c9a-b83b-4760-9161-16d2d08ee069	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:37:58.175482
05669b1a-894d-4d84-b9e6-44702f9ed642	f4e0de06-afc6-4221-8a61-f4c214bf88a8	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:37:58.175853
7cbcff41-f895-4e4c-b503-c5c6ff9a60dc	9a8ad201-9875-4a0c-9add-7ffd3152b48d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:37:58.176225
ad31d7ad-adab-4817-bbb7-cc2d8fb1197d	aae61884-9cf9-4b0d-8d9f-34747fb4b268	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:00.79986
fabaec42-3707-4d8d-8e92-f59d13dc7d6a	ae453b7a-f356-4325-8bc8-9cc10145933d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:00.800089
9a70f9a9-117d-4f6b-b117-6704291ae620	5a43645e-e1f9-4654-9955-83e4847c9220	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:00.800278
1a5d7591-6647-40d6-a9e7-cd89723cd9fc	9134a034-50a5-4db2-84c7-0241f71f442b	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:00.800469
426c31cb-5758-477c-8c75-8d349bf6c643	2f536ebe-7ca9-4a95-9524-3ac527406818	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:00.800657
977dfb9b-b0b2-4af2-89f1-3c518c895768	3cc86a32-952c-4515-8c6f-61f8d12087cb	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:02.809716
af98f620-a4a0-4321-a155-805968ec84fd	0cb2dbc4-ce56-4ffa-99ac-68d32bb4040a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:02.809946
397062e9-9b98-441b-bb10-3c626a3cb58c	ae375bb0-2838-459c-8c2f-f69c0793a471	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:02.810149
ef129463-1ade-48ac-a9db-8746676f6152	35eb048b-a298-404b-9888-d75c2235dbb8	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:02.810342
0463e218-197e-49a8-9c6e-82dbbc6149d5	c00f8e5b-f632-457c-a8ae-da29a4cb196b	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:02.810531
64b19e81-d687-4287-8bce-11d506d6050e	409a29ad-f0d2-4417-8e4b-71eac467658f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:06.887189
b2a119f6-9a43-4b88-a481-97276673d1cd	407a4980-ec03-47f1-adac-672a5e3369c7	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:06.887417
866945d4-231e-41ab-84dd-e2dd5dc3d342	26558e61-2db8-45dd-89b6-3877a0974ac1	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:06.887612
eb20baa9-3539-48f6-a38c-dfb503af4f0a	a3527d3c-8976-4b94-b79e-929bd33196e9	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:06.887803
4c2ae52b-0842-47a5-a813-aece06d1f5e4	7df54830-a547-489c-af97-a44f9c104397	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:06.887993
f1655233-9d65-49a5-9f54-2239cb45f166	1803c1a3-4c40-4721-8bd9-484276d2117c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:39.357739
b399dfd2-f947-4968-8007-898e29e3a7f0	00bb41e1-8781-4d1f-8552-8ff193088674	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:39.357971
6441cf6e-77da-4b81-97c6-8ed48f943af2	99d52c89-9755-4ab3-b470-64fbcffc9fb7	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:39.358174
b9902625-8c2a-44a3-8468-48aeca462c39	6cc6bfa4-62c3-46a8-aed2-2bd5063d71a4	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:39.358365
3dfa70f4-7467-4a59-b0f5-59751d6e09da	50b33540-fe37-46e2-86ec-0b3035033b0e	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:39.358555
279d0ef3-8e81-4220-b071-63cea4a30ee5	5bb686ad-e930-4d96-aaa1-94013d0d6dd3	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:48.549886
8ad8cb58-76e8-4ab1-96bc-324a0810ba4f	4e146b51-0089-460f-9d04-9c77662ae187	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:48.550125
5e695600-7f62-49d7-ba59-729f00a39150	5b087a9a-eaee-4c72-996a-20e620ddddc4	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:48.550314
267bbbbb-9f1a-4a91-82aa-3d4e0ca07b45	6485a8e3-3883-4872-8342-4a8820de002c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:48.550502
eb1a51ca-559f-4dbe-94bf-f8afd3b44d29	9184091a-b529-418f-a907-db9eef165301	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:38:48.550687
43e39fb9-b0ee-4055-a409-748fae4d922a	b9909b53-bd4a-4e50-84d1-9ccadb5a19e2	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:39:15.114332
5d788887-fbe8-494b-afc7-3865078435f9	d33ce031-c8fb-49d8-b077-3658a408a126	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:39:15.114559
cbdeaa33-ae17-45c0-9599-64164e99012b	3d890727-2b1c-4e91-aa2e-b2f2f5517587	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:39:15.114746
ab2f35cc-6bde-4e69-a8bc-663a3295e03d	e7d70a54-dab6-4a5b-96f7-95906f4681d9	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:39:15.114927
a2d4c27a-9cac-4207-ba65-42779f725fc5	08e54d36-615a-454b-9a64-c335e8761f28	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:39:15.115109
f9ae7daa-e21a-4628-82a8-0d298d1edcef	23adba48-9b4b-48c0-8e38-983e1bec4bde	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:39:17.247128
7d87ea79-2edc-435a-91de-9bcfcd2d6458	f0fa5d83-85a4-4327-95ff-018d272112d8	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:39:17.247524
33416844-7ae3-4dfb-983a-b1215539b476	90afc728-99c2-4399-8f22-603ca4e5ce6c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:39:17.247913
36cacc61-8506-4b96-bd14-1152f3b5eb2a	e6c72315-cc4a-4cf2-95a0-4359acc7a6fb	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:39:17.248282
1f341b61-27af-436f-afd0-08ff108add7d	2865cdc8-cba5-4e9a-ac75-dcf8acc85fca	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:39:17.248651
a429b025-f3d2-46a0-bcb1-034eba5be269	ce580431-3c7d-4308-831a-bb0c9ccd12dd	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:39:27.431795
588caf18-5a05-4c2d-9c89-5b6700b4ecbf	713b4341-5f0a-4fb1-bf24-28b66d157d84	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:39:27.43211
66bab20f-0e4e-4984-9f60-6115df7406dc	1d3ab9ea-f1bf-4a19-b081-ae634a7fa4f4	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:39:27.432339
991d34aa-13c7-43b3-9635-4555e652b952	2378cafa-6c96-419c-a86c-f123b6981b88	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:39:27.432561
a8a14e93-93d9-4d17-8149-5321b36a054c	33edde42-ca22-4d93-af3a-86420a250d52	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:39:27.432782
09940dfd-9aa0-4f31-b044-b07205a6f36c	2ec31b2d-66db-4f39-9b36-89a4bf0e090a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:40:09.896818
f075dc83-bab9-40c6-a563-2ae78ff485bc	2f89e652-8c26-4074-8810-074b1d7df7e3	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:40:09.898449
ef7df904-8d69-49f9-a865-6f0030fdf118	b9f24473-bfce-4fcc-9312-dc3f94e90314	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:40:09.89941
34dbd937-32e7-4770-8b7f-082fa73def0f	0f72fc71-88ec-4cc6-a0e8-0fb17993d138	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:40:09.900108
8f921c43-e0c3-4d5b-80ef-d45263e1a1be	39d7d514-f5ea-4f2f-98eb-371237764d98	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:40:09.900503
4fc6efc2-eadf-4702-ba9b-8eac24a5e49c	a16d9c43-f366-4fd0-891a-e8ea13eedf87	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:40:23.007203
1ae34a51-9cb0-418d-83c3-6f56199c088f	3b1d6a7d-0141-45fa-a229-b010fa72f268	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:40:23.007429
2fa31307-eea6-4947-ae86-39b85d2d1058	974ce86d-e257-4dc6-ab88-17bf433d1d37	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:40:23.007616
9455e85b-fbd6-49ce-a001-0bce6f5bde34	d62069c0-a7c7-453b-bc88-dec639143512	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:40:23.007801
1e273438-3056-4467-8163-22164abe7d4c	e88cf118-b19e-481b-ae5e-d00535489f35	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:40:23.007987
53fb0de3-833a-42bc-84cb-74d95e7cab51	52540733-1346-4119-9021-de64246c30cd	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:41:49.110802
5e94354f-3b5d-46c2-9b86-b1277244bfb6	a4098819-0c9f-450b-b97e-8871a5b2e174	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:41:49.111026
2ba421bb-609d-47f5-b726-803035709e43	00e2b1bd-114d-46ae-b3d5-efe524fff108	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:41:49.111212
10cd7c6c-910a-4860-8c6e-b4eaf5e9f99b	5ee8ba31-1786-4a39-8ca4-919f673ce5e2	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:41:49.111393
2f0a9888-f357-4cfe-840e-0bbdfe971c56	59256b9f-6c0d-4ca1-8d62-14b40fd25fc2	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:41:49.111575
2d36ad4e-27c0-4c93-b90a-58cc5f7786ff	c660073e-718e-41a3-9598-b0477816d71e	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:43:13.330456
f2acd8bb-7d35-40b4-a1f5-561e7bd11ec5	dd05ceac-11a4-4c22-8d78-27a569af0f69	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:43:13.330785
82924a1e-bfcd-4fff-9ed1-0626fe3960e4	d3706cf9-a6ef-4333-a3ea-28305de9e439	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:43:13.331032
d4322bf6-08f0-4004-9be8-f0f8b51a2a84	833e7929-ade0-449c-90e9-00a0ebabadcb	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:43:13.331272
70276607-ecac-4743-b3ab-172dcebd40da	cd33bbe5-29f4-4ece-8462-3defdd2c6692	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:43:13.331514
25c24f04-29e0-4306-b0c7-434969d4baf6	ffd5e30f-daaf-4f14-8768-1bca96fab6ac	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:43:49.942477
4811b2b2-51bd-4fbb-b537-777c0c8b4acf	609ce9aa-4a8a-4540-9a77-7efdd5fc11d0	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:43:49.945269
38828e97-61e5-491f-a7e7-9a80123d1755	230bf7c7-6224-4cb3-a196-36c86206ca9c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:43:49.947516
6c9cb4ed-c784-41fd-805d-73e559251379	d0c13319-fccf-4823-bf0a-de880199b297	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:43:49.949916
f35e7dc3-9337-40a3-8ec9-08e10ee14f73	8f894ff3-77b8-47cb-a0b1-5f4bdc0d8574	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:43:49.952291
bdf4125c-4fbc-4a80-82a6-45f03ea0c6a5	2381aa53-3880-435b-bbaa-cf63df39dd85	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:43:58.261123
be411f0b-63b2-4a9e-9af5-008de8808b01	7155971d-ab71-4862-bdce-fc539f14a000	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:43:58.261625
367aa4d6-dc41-4272-b703-a709ac1308d8	b729b5c5-3176-46e1-90de-4ef61824e180	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:43:58.262042
c748e478-b032-45bf-8c60-8f791b974825	0da7f22e-0675-490a-9ce3-52c15b6bb764	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:43:58.26297
61493536-2dd7-4f81-94fa-3ae15da525fb	5139fb64-edaf-4d5a-be3a-b466fa95a1f3	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 17:43:58.265428
045a379f-1037-407e-864d-f8d2854b60ba	f476115d-f59d-48c2-9786-1ba19dad2e31	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:42.91796
3e13f8a9-20ee-4336-ab8e-8575a1578d35	754b95f1-cafa-4381-8ab5-68e884489112	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:42.918592
8e0aec71-5151-41be-9ced-f62a06b06c6f	e486d09a-9a94-4ca6-936d-fa036c75df4b	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:42.918956
b7584a5c-1be5-442d-94ce-3adbe42bc77d	26a1b973-8e66-4b4e-87d0-7b884f704347	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:42.919264
57e564ab-7a67-44d4-ada6-e436857f8c72	5caf0186-a581-4d53-903a-bcbf488475ad	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:42.919571
ba5ab0f5-4d2f-4ac4-a4ff-991521fc879c	ff567138-8442-4c1b-86ce-387f23174605	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:46.395161
782d217b-c694-4a5d-a5cf-cd7b3399e466	b42c59da-4562-456b-b9de-8137b49920c8	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:46.395382
8597e09a-1d21-4214-87e3-0cebcd85a474	92eea248-c168-43ce-a2e9-17a4a2333a6d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:46.395575
02b94ce3-3a28-4f80-8e62-200c9b875f97	5307707a-be75-4b2d-a6dc-dc9b785d2381	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:46.395763
78491b0e-dce1-4737-a8f2-9a2daea21096	d7225a6c-7917-421d-a05c-9e88f9e225db	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:46.395953
02372aa8-1752-408c-91ea-6a6518bd511b	b00d7b62-0685-4f09-b74e-c249a7b25af7	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:53.688785
c346faca-87db-4547-ae85-1af0a5871d46	9c02b613-55e1-4eea-9f4d-271d674cd8c6	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:53.689304
7aeff40e-e798-42b2-a714-b7448f729f11	8d1923dd-7ae4-49c4-bd8e-d174993b6136	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:53.689898
f933d223-9f5b-42a7-aac8-9e51420b5bcc	74b49a0a-c049-4574-aa99-546601c74710	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:53.690534
758deb13-17a1-42f4-86e1-c70aceae7bde	b9ba9baa-71cc-4587-9a2b-915e2212fff3	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:53.690957
c52a9f17-4bdb-4a91-8cf0-11979f338617	32268a8a-9aac-42b5-b13b-9c7a467fef04	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:56.884978
596c6c78-3dd8-4669-a7d9-fa270a99c6ac	eb91e76d-bc7e-43b2-95a4-be19a719a76d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:56.885211
52c03621-fff9-4fd1-9d0c-ded1eab3bdb2	16c368f1-9629-4121-9d2b-6474b0de512d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:56.885401
4f14750b-20ce-4496-9616-95f53f3f0294	e6899650-ec99-4fa1-8136-a591e728b8b4	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:56.885588
6b5121c3-1897-4874-a7cc-6b7316c83e27	8cbdc071-2baf-45e8-985a-75d2a0ee8bc8	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:56.885776
235d8586-e5b2-46f5-a7d3-b2df6ef1478c	3735bf79-ef1d-4518-aef6-64c24aff0804	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:59.253115
f6414c7f-89e2-450f-9f17-809f173f1376	d54d6ecf-876e-42f3-94bd-d183cd4bf287	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:59.25353
8924c271-62f4-484a-9f93-a3511be2a23a	2101be46-857a-4875-a251-c3d2fa6d2b87	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:59.253834
b499f4ce-a22f-4dcf-8a6f-8e4faf3a8348	db4306fc-aee8-426d-97e4-6c2e39404dc5	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:59.254195
915dc95e-ff9a-4075-81ef-20546ea27b71	5be6403d-042b-492e-a519-5c720e025437	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:05:59.254527
658df855-d624-43eb-8137-91e11d3ed551	1db35e41-01f1-4a70-ba11-78c43978af1c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:50.190166
8e940164-04d7-46bf-84a4-b39bf62e6bde	dc968dd9-1977-4d5a-8566-89ae9d690247	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:50.190551
4b861dde-e204-4fbd-8c1d-f948b5ccc2ff	11153e99-5115-48aa-94a7-d5c1852de12f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:50.190848
184d7615-d4b2-4b1a-a719-21000ac504c8	309ec4dd-6202-4f7c-b940-7d8cb97db791	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:50.191128
a4fbcb9c-25ee-4ce6-83bb-277ccf5f003f	8fbb807f-26f8-4a7b-a91c-1a6365a58136	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:50.191475
889104a6-add4-463d-9439-77417b2108e6	8a467051-a1c7-4311-930c-3c7946f58429	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:52.517683
1dd54a2d-4087-4d04-9183-343528a096e4	db5f147d-2434-4a8c-9e06-52f5b97fcca7	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:52.518213
cfddd765-5f51-45e0-b282-2ea725588310	1f27157d-989c-4d80-a753-709ed0edd58d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:52.518681
4c0d4992-e592-4952-90e6-24db5ce91ded	af75c8d9-6cfd-4947-aaff-818134a71117	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:52.519158
e5a5bcab-fe8a-4828-a67b-80a2769de777	c4c47169-7210-4624-b8f9-2b1e4c4f6f6f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:52.519593
e33fcb95-89c2-41ea-a1ed-afe2f3a17bf2	9c6ec3f9-3a2b-4eb4-a8e3-d5b2840f682b	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:54.632253
1876236d-7ff5-414e-9e33-c4372f5b04f9	a8dd44de-26d7-45a8-a91e-da93b6e16713	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:54.632479
b523f30c-1d9c-4a44-bb79-f0961cfdf64f	29b45d27-8e37-42e5-ad9d-97da15399c8e	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:54.63267
baa8221c-e560-4411-85b3-df68d57d89ce	9977c897-1fda-44eb-a6b3-193a79044e21	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:54.632857
c3df8e49-d906-4827-89b5-9bc7ec2688e2	e489e34d-3e2f-401c-b33b-2c11ed6bb4ea	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:54.633043
c3bcbab4-08fa-47b4-b8eb-35157e532af3	0741ff7d-896e-4c15-9859-fbefb20cf074	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:58.732589
46adec55-f66f-4268-b935-bdd9082fa041	4d9f498e-8002-4f7e-8ec5-a3067b446913	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:58.732922
979b934f-a6a1-4559-91a9-26fba1bb2be8	0499a154-d61f-4144-b5ab-d6cf2dbb17de	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:58.733319
7c4ed596-86fa-4dde-8f41-3dd5ab66c2d8	bc425f68-0254-497c-9031-a6be2ee9b50c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:58.733825
232a0035-f5dd-4696-8b4f-6dc80c236367	43cff434-3e25-4a80-a9de-6afd10b0538a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:07:58.734483
119ef30d-65f9-4231-904c-848bd747331e	0b4d061a-0d22-4863-80df-1f00d90dff54	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:01.266509
585a9377-4a71-4be2-8808-a2a0c87084c2	401d6808-bd9a-479c-b59c-7d92d8261324	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:01.266898
15f63e88-09da-4659-b22c-83e3c5672dfd	5bc5c91b-c5f7-4e3a-8f2b-e371c427fa8e	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:01.267196
7cd3f9d3-ccca-47c7-8218-3b5dd808d56a	1f302324-c583-4a33-9980-e7e0da72d9c4	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:01.26753
6b881183-417a-4647-8b0e-16be48937171	af1dc9c2-fef5-43b5-9e36-2592ca4900c0	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:01.267874
16370e62-868b-42af-9e3a-d8bfca043a44	4a14eabf-932a-49c7-88ac-5dc0cf78b734	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:03.606304
fe73dc86-f272-4521-88b1-71922b07934c	625dec78-297a-4052-93da-61eef3537048	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:03.606529
f27718e5-a256-4a7a-8a23-62d60c984523	2e888a5d-15e6-49db-92fc-34552608d9d7	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:03.606719
2e212d64-8e93-47fc-99ef-6677b19892b8	72819bbb-687f-4bb2-a7f7-5ae8249319ed	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:03.606907
0cf08f90-c728-43ee-be10-0ace16452857	5de5c971-1604-4592-b294-e9bb7afcebb6	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:03.607098
e37dec8a-6605-4f3d-a705-f7c44ba0b894	7b599114-e47c-402b-a90a-2a36af82a084	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:05.701139
ceabd4cb-2ed2-4c69-beba-c8056c646e53	c6ca9f7e-9afb-4a3d-81df-4d3711d0e04d	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:05.702341
844561a9-e03b-4f02-9c04-4ad587f2d06d	b6c48627-843d-4f09-97ba-47205d946321	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:05.702921
ad45ecbf-98c0-4673-8f51-dd293ff81b19	a7af1ffb-50b5-4f20-b740-72e53ff1bb96	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:05.70323
e562f95f-3d75-4592-981c-e3b5670ed154	b1521924-b1e4-483c-be4b-0caf9de9121c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:05.703511
65045a95-52a3-4cb6-8082-64f398535e60	1dfda17d-3453-4ef5-97ea-21ee7cd00201	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:17.949906
e98e21ad-2f36-46b9-9948-c060c4c7966b	54df9481-dfdb-4260-8040-2fc104c26fe2	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:17.950144
e4a0437a-a262-4009-97de-31589427d3ba	964e7273-8409-474a-baba-25986665b987	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:17.950333
42b009b3-14f3-409b-a39f-d471a03d3c45	688e3ad4-af8d-4408-93f9-4fdfcb52a721	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:17.950517
ca6384a0-0e16-4f35-ab09-b43d8c45f9c6	2754ed6d-b3ed-455f-bad4-065e93d1c27f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:17.950702
e02fcb0c-7f9c-4a9a-9ed1-5a4d7f465ae0	9787123c-e18d-4cbb-ba6c-e3fe81824a9c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:20.352449
aae32617-0784-4a9e-ab1b-b6d1378abbe7	41aa3af6-f4ef-4fa0-8ea8-0b3163f93d2a	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:20.352919
beaacda6-78bd-406b-b3e3-96d77507dde1	62469459-683f-46ae-84be-fe54a5cf17f8	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:20.353282
71743450-7879-4799-b9ce-3f239612c438	55476e87-8fbb-4d2d-8bde-ab6d38982d33	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:20.353639
282ba867-f0b9-4161-8cbc-e801f83bc9b0	30f8587b-147a-4a9a-ab34-c57ea4c77787	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:20.354002
145f4b52-7686-4b3e-a847-fb6fa6e991ab	36990da5-c0ca-429e-baf3-426840a3023f	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:23.748759
679c8584-943e-4b64-839d-a58dbe0dd879	baf4a7a8-d5fa-4a70-8ab9-b8774940acd2	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:23.748986
c98be158-1326-4513-b755-cc6ab185420e	ca2d06e0-96f8-4a09-9abf-509c7ebde2f2	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:23.749173
c823c4e5-9d78-4dfd-afd8-db070c80ac79	4a191cc8-3e71-4cb2-b16a-e951490413a4	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:23.749359
5ee70b30-1a1f-4376-85fc-f23ccf81fc66	5333e57b-3f89-4635-af90-3c15c12366c7	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:08:23.749588
a68a0737-0762-49d3-a68d-d6359652fe96	580ace34-ced8-4d09-a6cb-23c844774cbd	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:09:01.896048
0dde1380-ef9a-4cb2-be00-574827b29951	eada6944-99b3-4404-ae83-0bdc5a0faf1c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:09:01.896348
017340bd-3051-4621-884b-0d06a14eda93	244f50b8-0d60-43dc-9230-6b8a464f155e	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:09:01.896595
f94dbfac-b2ca-4e2e-83a5-05d80678df7a	b899cec1-138b-45fc-967a-bb9f59e2bc13	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:09:01.896855
cc21916f-08d0-4433-a60e-8171c4b9b30d	e01da08d-978e-428d-9ee0-1e22312285c3	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:09:01.897106
441554bc-e34c-4eee-900f-47a2e3bae315	2b2f6678-dc6a-44f9-a3df-3591334ac774	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:11:13.792528
da246d92-8c7c-4769-b3b4-839e0f5371a4	05b8d6e9-f4e1-4d27-bc47-8077d94697c2	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:11:13.792827
75d9bb87-1aa0-433e-878f-f6ffd460d0f1	9b19384b-035b-4817-a0da-02cbc2e1be7c	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:11:13.793076
716d0814-d74a-4680-a8a9-24bcf4dde1f6	54aa2f0a-02ca-45b1-bc71-c6ec09468d25	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:11:13.793319
32e90347-1039-4f74-b03b-10d371655640	8330543e-75e0-42ba-bbe2-c07e31c2c069	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:11:13.793564
04793560-d81d-4bba-83ac-b7d41053df9e	929c1e92-d26b-4b3b-b5cd-9b5ee92c00e6	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:11:21.372239
2b4a6ba5-2321-4883-94f7-4d46c4c6e5cc	9f5dab5c-b0f3-4de7-842a-9131293deb1b	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:11:21.372465
741ea1ea-692d-40ad-a6fa-51b9c9a7b0f0	0707ec75-6cf9-415a-ae89-f8afc9dfaeb3	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:11:21.372655
3fdd0e23-6d9a-418a-9291-1ce4fc76908e	c358b6d3-44c2-4577-b8de-a5aea9214f51	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:11:21.372845
b5b6082c-13d6-4ed3-95a0-fec1324095bf	1c4f158f-05b5-4215-8f82-a190e22c1b41	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:11:21.373034
383bff0f-8754-4e4f-b2de-952db7c023c8	f14d5acf-cc1f-4e4a-a301-fe284f7388b6	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:11:25.336582
bf606197-9790-4074-9c2c-a06cd6df35ad	3b81a7cb-4bd0-435e-b4ee-a72bdadbcef1	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:11:25.33692
1ddbcfb6-b269-4bec-b758-57e24ee942f8	55b0286c-624b-403a-9f33-520d12d0bfca	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:11:25.337206
b7070fd1-2526-440f-8791-2ff74b6f2e8f	251bfc7a-e7bb-4797-82b5-0a5d055812e1	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:11:25.337489
a7e2117d-927e-48fc-83e8-9a4fc5166a75	604dbbcb-1472-4064-a84d-ed745413ad55	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-18 22:11:25.337765
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: gctu_attendance
--

COPY public.sessions (id, session_type, course_id, created_at, ended_at, started_at, ref_id) FROM stdin;
60233be1-18df-4c63-8a15-ab4ebff3b7b9	IN_PERSON	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-19 21:55:06.399081	2025-08-21 12:25:06.096591	2025-08-21 12:22:18.84057	\N
3d8d2feb-b9c3-4126-b05e-4ca356c78626	IN_PERSON	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-20 14:46:42.93252	2025-08-21 12:25:06.096591	2025-08-21 12:22:18.84057	\N
17ce8f22-62b9-477d-b9ed-11552d11ed62	IN_PERSON	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-20 14:47:55.993113	2025-08-21 12:25:06.096591	2025-08-21 12:22:18.84057	\N
e2acfd8a-9ea4-4a28-ad9b-00740828076b	IN_PERSON	bc04f8b3-122a-43b8-84f6-8d152bcdf4ad	2025-08-20 14:47:56.767812	2025-08-21 12:25:06.096591	2025-08-21 12:22:18.84057	\N
\.


--
-- Data for Name: social_auths; Type: TABLE DATA; Schema: public; Owner: gctu_attendance
--

COPY public.social_auths (id, user_id, oauth_id, provider, access_token, refresh_token) FROM stdin;
bca7d0a4-dc60-4d3a-a320-5679a39a075e	98e33c33-7583-45b6-b60e-73c1961a4504	KfClSJR5RKSCJpaYNk_REA	zoom	eyJzdiI6IjAwMDAwMiIsImFsZyI6IkhTNTEyIiwidiI6IjIuMCIsImtpZCI6ImU0OTAwZTdiLTViNWMtNGI3Yy04YmQyLTBhOTVkY2ZkNGJjNyJ9.eyJhdWQiOiJodHRwczovL29hdXRoLnpvb20udXMiLCJ1aWQiOiJLZkNsU0pSNVJLU0NKcGFZTmtfUkVBIiwidmVyIjoxMCwiYXVpZCI6IjViNTViZDdlYmQ4ZjZlMTdhZmVmNjc4MDU5OWYzOTAxNTYwNDliNWVmOTFmOThiMDZkYzNmN2NhM2E4ZDgzY2EiLCJuYmYiOjE3NTU2OTYwNDcsImNvZGUiOiJ2TTRhZmwzdjRNSmxtNFo2Q0VfVFY2SUJJaTZWbTVDaGciLCJpc3MiOiJ6bTpjaWQ6X2hqMU5ueFRiZXJGU2lDRHJwU1JRIiwiZ25vIjowLCJleHAiOjE3NTU2OTk2NDcsInR5cGUiOjAsImlhdCI6MTc1NTY5NjA0NywiYWlkIjoiMlpSWHNIZWFSU0NoV1I2S09WMUp6QSJ9.Z83svEJeuQ6Q9TRBelhJdt4i9jZzr0k9oJ69NH8wvUIK4KtIf7qpzAyQQzBuZKx6Mu6aHSZhBm3u1Zn8olrkqg	eyJzdiI6IjAwMDAwMiIsImFsZyI6IkhTNTEyIiwidiI6IjIuMCIsImtpZCI6ImE5NDU1NjcxLTdjMGItNDdkYy1iMGJiLWVkYjE3NjNkODEzNSJ9.eyJhdWQiOiJodHRwczovL29hdXRoLnpvb20udXMiLCJ1aWQiOiJLZkNsU0pSNVJLU0NKcGFZTmtfUkVBIiwidmVyIjoxMCwiYXVpZCI6IjViNTViZDdlYmQ4ZjZlMTdhZmVmNjc4MDU5OWYzOTAxNTYwNDliNWVmOTFmOThiMDZkYzNmN2NhM2E4ZDgzY2EiLCJuYmYiOjE3NTU2OTYwNDcsImNvZGUiOiJ2TTRhZmwzdjRNSmxtNFo2Q0VfVFY2SUJJaTZWbTVDaGciLCJpc3MiOiJ6bTpjaWQ6X2hqMU5ueFRiZXJGU2lDRHJwU1JRIiwiZ25vIjowLCJleHAiOjE3NjM0NzIwNDcsInR5cGUiOjEsImlhdCI6MTc1NTY5NjA0NywiYWlkIjoiMlpSWHNIZWFSU0NoV1I2S09WMUp6QSJ9.HDPzZHg9mzQGALSxbzpyG3BZDWSuqhu1cMgX05QWY-G4alJ97OGpmZqW-UYqMK55nZu0XCiNzT9PtIB5hmxwLQ
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: gctu_attendance
--

COPY public.users (id, gctu_id, name, email, role, pin) FROM stdin;
98e33c33-7583-45b6-b60e-73c1961a4504	L001	Dr. Mensah	L001@live.gctu.edu.gh	LECTURER	$2b$12$bpiRnO6V0GiNd5yE.7R3/eYMjCqdCVtSLLTL1w66H533kFl/SWbba
4294b0c1-2c33-40f3-95b9-72aef06a7729	GCTU12345	Ama Mensah	GCTU12345@live.gctu.edu.gh	STUDENT	$2b$12$AkjJqXoHYvns556IW.AtOuHSxPJIHVlEkRx3QYgoYjDr1f0ZQc.4.
9a76fdad-123b-4360-a94c-a0fa893ce9fa	GCTU12346	Kofi Adjei	GCTU12346@live.gctu.edu.gh	STUDENT	$2b$12$EC2rjiCt9e6Kd6XOg3CaPuSMnCEdyuj6XHir78u1Vbl43rInIUfFu
7cecfc9f-def0-435c-86c6-7e70cff23954	GCTU12347	Yaw Owusu	GCTU12347@live.gctu.edu.gh	STUDENT	$2b$12$pqVV/1LplLrFHzYAzr2CleUfBzIY9EpHgDy5uCHjJKGHSO7nF/UfW
55e8fdb0-442d-4e44-88dd-62d99c989cbb	GCTU12348	Akosua Boateng	GCTU12348@live.gctu.edu.gh	STUDENT	$2b$12$QieSyWw4Ec6MmyP.rWt1PeaTSG53rsjHYf2a4TRsfjvMLkoRpQsVi
881077fe-ce1f-452b-928d-2701a09e2487	GCTU12349	Kwame Nkrumah	GCTU12349@live.gctu.edu.gh	STUDENT	$2b$12$y.y9kOZkFQO62AKXqjQHH.4pNIcVnhcFaLPPLxlG52fAQ8Zw.CCPy
\.


--
-- Name: attendances attendances_pkey; Type: CONSTRAINT; Schema: public; Owner: gctu_attendance
--

ALTER TABLE ONLY public.attendances
    ADD CONSTRAINT attendances_pkey PRIMARY KEY (id);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: gctu_attendance
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: gctu_attendance
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- Name: enrollments enrollments_pkey; Type: CONSTRAINT; Schema: public; Owner: gctu_attendance
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: gctu_attendance
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_ref_id_key; Type: CONSTRAINT; Schema: public; Owner: gctu_attendance
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_ref_id_key UNIQUE (ref_id);


--
-- Name: social_auths social_auths_pkey; Type: CONSTRAINT; Schema: public; Owner: gctu_attendance
--

ALTER TABLE ONLY public.social_auths
    ADD CONSTRAINT social_auths_pkey PRIMARY KEY (id);


--
-- Name: users users_gctu_id_key; Type: CONSTRAINT; Schema: public; Owner: gctu_attendance
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_gctu_id_key UNIQUE (gctu_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: gctu_attendance
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: ix_departments_code; Type: INDEX; Schema: public; Owner: gctu_attendance
--

CREATE UNIQUE INDEX ix_departments_code ON public.departments USING btree (code);


--
-- Name: ix_departments_name; Type: INDEX; Schema: public; Owner: gctu_attendance
--

CREATE UNIQUE INDEX ix_departments_name ON public.departments USING btree (name);


--
-- Name: ix_social_auths_oauth_id; Type: INDEX; Schema: public; Owner: gctu_attendance
--

CREATE UNIQUE INDEX ix_social_auths_oauth_id ON public.social_auths USING btree (oauth_id);


--
-- Name: ix_users_email; Type: INDEX; Schema: public; Owner: gctu_attendance
--

CREATE UNIQUE INDEX ix_users_email ON public.users USING btree (email);


--
-- Name: ix_users_name; Type: INDEX; Schema: public; Owner: gctu_attendance
--

CREATE INDEX ix_users_name ON public.users USING btree (name);


--
-- Name: attendances attendances_enrollment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gctu_attendance
--

ALTER TABLE ONLY public.attendances
    ADD CONSTRAINT attendances_enrollment_id_fkey FOREIGN KEY (enrollment_id) REFERENCES public.enrollments(id);


--
-- Name: attendances attendances_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gctu_attendance
--

ALTER TABLE ONLY public.attendances
    ADD CONSTRAINT attendances_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(id);


--
-- Name: courses courses_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gctu_attendance
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- Name: enrollments enrollments_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gctu_attendance
--

ALTER TABLE ONLY public.enrollments
    ADD CONSTRAINT enrollments_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: sessions sessions_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gctu_attendance
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(id);


--
-- Name: social_auths social_auths_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: gctu_attendance
--

ALTER TABLE ONLY public.social_auths
    ADD CONSTRAINT social_auths_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: gctu_attendance
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: gctu_attendance
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO gctu_attendance;

\connect postgres

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
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: gctu_attendance
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

