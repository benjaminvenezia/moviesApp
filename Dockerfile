# Étape 1 : builder Go
FROM golang:1.25-alpine AS builder

WORKDIR /app

# Copier les fichiers de modules et télécharger les dépendances
COPY go.mod go.sum ./
RUN go mod download

# Copier le reste du code
COPY . .

# Builder l'application
RUN go build -o myapp .

# Étape 2 : image finale minimale
FROM alpine:latest

WORKDIR /app

# Copier l'exécutable depuis le builder
COPY --from=builder /app .

# Copier le fichier .env
COPY .env .env

# Installer bash si nécessaire (optionnel)
RUN apk add --no-cache bash

# Entrypoint pour l'application
<<<<<<< HEAD
<<<<<<< HEAD
ENTRYPOINT ["./entrypoint.sh"]
=======
ENTRYPOINT ["./myapp"]
>>>>>>> 31c710f (Add containerisation (app, postgres, pgadmin))
=======
ENTRYPOINT ["./entrypoint.sh"]
>>>>>>> 8a20b54 (Add containerisation (2/3))
CMD []
