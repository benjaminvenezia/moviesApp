-- +goose Up
-- +goose StatementBegin
DROP TABLE IF EXISTS "public"."actors";

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS actors_id_seq;

-- Table Definition
CREATE TABLE "public"."actors" (
    "id" int4 NOT NULL DEFAULT nextval('actors_id_seq'::regclass),
    "first_name" text NOT NULL,
    "last_name" text NOT NULL,
    "image_url" text,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."genres";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS genres_id_seq;

-- Table Definition
CREATE TABLE "public"."genres" (
    "id" int4 NOT NULL DEFAULT nextval('genres_id_seq'::regclass),
    "name" text NOT NULL,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."keywords";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS keywords_id_seq;

-- Table Definition
CREATE TABLE "public"."keywords" (
    "id" int4 NOT NULL DEFAULT nextval('keywords_id_seq'::regclass),
    "word" text NOT NULL,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."movie_cast";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."movie_cast" (
    "movie_id" int4 NOT NULL,
    "actor_id" int4 NOT NULL,
    PRIMARY KEY ("movie_id","actor_id")
);

DROP TABLE IF EXISTS "public"."movie_genres";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."movie_genres" (
    "movie_id" int4 NOT NULL,
    "genre_id" int4 NOT NULL,
    PRIMARY KEY ("movie_id","genre_id")
);

DROP TABLE IF EXISTS "public"."movie_keywords";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."movie_keywords" (
    "movie_id" int4 NOT NULL,
    "keyword_id" int4 NOT NULL,
    PRIMARY KEY ("movie_id","keyword_id")
);

DROP TABLE IF EXISTS "public"."movies";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS movies_id_seq;

-- Table Definition
CREATE TABLE "public"."movies" (
    "id" int4 NOT NULL DEFAULT nextval('movies_id_seq'::regclass),
    "tmdb_id" int4,
    "title" text NOT NULL,
    "tagline" text,
    "release_year" int4,
    "overview" text,
    "score" float4,
    "popularity" float4,
    "language" text,
    "poster_url" text,
    "trailer_url" text,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."user_movies";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."user_movies" (
    "user_id" int4 NOT NULL,
    "movie_id" int4 NOT NULL,
    "relation_type" text NOT NULL CHECK (relation_type = ANY (ARRAY['favorite'::text, 'watchlist'::text])),
    "time_added" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("user_id","movie_id","relation_type")
);

DROP TABLE IF EXISTS "public"."users";
-- This script only contains the table creation statements and does not fully represent the table in the database. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS users_id_seq;

-- Table Definition
CREATE TABLE "public"."users" (
    "id" int4 NOT NULL DEFAULT nextval('users_id_seq'::regclass),
    "name" text NOT NULL,
    "email" text NOT NULL,
    "password_hashed" text NOT NULL,
    "last_login" timestamp,
    "time_created" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "time_confirmed" timestamp,
    "time_deleted" timestamp,
    PRIMARY KEY ("id")
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
SELECT 'down SQL query';
-- +goose StatementEnd
