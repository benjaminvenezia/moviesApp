# MoviesApp

A simple Go web service for browsing movies backed by PostgreSQL. It exposes a small REST API and serves a static frontend from the `public` directory.

- API endpoints:
  - GET `/api/movies/top` — top movies by popularity
  - GET `/api/movies/random` — random movies
- Static site: `http://localhost:8080/` (served from `public/`)

## Tech stack
- Go 1.25
- PostgreSQL 17
- Docker / Docker Compose
- Goose (DB migrations)
- Air (optional, for live-reload in dev container)

## Quick start (Docker Compose)
This is the recommended way to run locally.

1. Ensure Docker and Docker Compose are installed.
2. Copy and adjust environment variables if needed (a default `.env` already exists):
   - Important variables in `.env`:
     - `DATABASE_URL` (used by the app)
     - `POSTGRES_*` (used for the DB container)
     - `GOOSE_*` (used by migrations)
3. Start the stack:
   - PowerShell: `docker compose up --build`  
     (older Docker: `docker-compose up --build`)
4. Services:
   - App: http://localhost:8080
   - PgAdmin: http://localhost:8081 (login from `.env`)
5. On first run, the `entrypoint.sh` will:
   - Wait for Postgres
   - Run database migrations with Goose (`migrations/`)
   - Seed initial data from `insertions.sql` (only if the movies table is empty)

## Installation and build (without Docker)
If you prefer running the Go app directly on your machine:

Prerequisites:
- Go 1.25+
- PostgreSQL 14+ (or compatible)

Steps:
1. Set environment variables (PowerShell example):
   - `$env:DATABASE_URL = "postgres://admin:admin@localhost:5432/movies?sslmode=disable"`
2. Install dependencies:
   - `go mod download`
3. Build:
   - `go build -o moviesapp .`
4. Run:
   - `./moviesapp` (PowerShell: `./moviesapp.exe` on Windows if built as exe)

API will listen on `:8080` by default (see `main.go`).

## Database migrations
Migrations are managed by Goose and run automatically in the Docker dev setup via `entrypoint.sh`.

To run them manually on your host:
1. Install Goose: `go install github.com/pressly/goose/v3/cmd/goose@latest`
2. Export envs (PowerShell examples):
   - `$env:GOOSE_DRIVER = "postgres"`
   - `$env:GOOSE_DBSTRING = $env:DATABASE_URL`
   - `$env:GOOSE_MIGRATION_DIR = "./migrations"`
3. Apply migrations:
   - `goose up`
4. Optional: seed data
   - `psql "${env:DATABASE_URL}" -f .\insertions.sql`

## Environment variables
From `.env` (used by Docker) and for local runs:
- `DATABASE_URL` — Postgres connection string the app uses.
- `POSTGRES_HOST`, `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB` — DB container settings.
- `GOOSE_DRIVER`, `GOOSE_DBSTRING`, `GOOSE_MIGRATION_DIR` — Goose migration configuration.
- `PGADMIN_DEFAULT_EMAIL`, `PGADMIN_DEFAULT_PASSWORD` — PgAdmin credentials.

## Logging
The app writes logs to `movies.log` (see `logger/logger.go`). Common server and error messages are logged.

## Endpoints
- GET `/api/movies/top`
- GET `/api/movies/random`
Both return JSON arrays of movies with fields defined in `models/movie.go` (id, tmdb_id, title, tagline, release_year, overview, score, popularity, language, poster_url, trailer_url).

## Troubleshooting
- Cannot connect to DB: check `DATABASE_URL` and that Postgres is reachable. In Docker, the hostname is `postgres_db` as set in `.env`.
- Migrations not running: ensure `GOOSE_MIGRATION_DIR` matches the repository path (Docker uses `/app/migrations`).
- Port already in use: change the `8080:8080` mapping in `docker-compose.yml`.
- Windows quoting: prefer PowerShell examples provided above.

## FAQ
- Are you based on ChatGPT?
  - No. This project itself is a Go application and does not depend on ChatGPT. The assistant used to help automate edits to this repository (Junie) is powered by the gpt-5-2025-08-07 model, not ChatGPT.
