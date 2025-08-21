#!/bin/bash
set -e

# Attendre que Postgres soit prêt
<<<<<<< HEAD
<<<<<<< HEAD
until PGPASSWORD=$POSTGRES_PASSWORD psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c '\q' 2>/dev/null; do
=======
until pg_isready -h "$POSTGRES_HOST" -U "$POSTGRES_USER"; do
>>>>>>> 31c710f (Add containerisation (app, postgres, pgadmin))
=======
until PGPASSWORD=$POSTGRES_PASSWORD psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c '\q' 2>/dev/null; do
>>>>>>> 8a20b54 (Add containerisation (2/3))
  echo "Attente de PostgreSQL..."
  sleep 1
done

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 8a20b54 (Add containerisation (2/3))
# Vérifier que Goose est bien installé
export PATH="$PATH:$HOME/go/bin"
echo "Goose binaire trouvé dans : $(which goose)"
goose --version


# Debug: Afficher les variables d'environnement
echo "GOOSE_DRIVER: $GOOSE_DRIVER"
echo "GOOSE_DBSTRING: $GOOSE_DBSTRING"
echo "GOOSE_MIGRATION_DIR: $GOOSE_MIGRATION_DIR"

# Vérifier que le répertoire de migrations existe
if [ ! -d "$GOOSE_MIGRATION_DIR" ]; then
    echo "ERREUR: Le répertoire de migrations $GOOSE_MIGRATION_DIR n'existe pas"
    exit 1
fi

# Lancer les migrations Goose
<<<<<<< HEAD
=======

>>>>>>> 31c710f (Add containerisation (app, postgres, pgadmin))
=======
>>>>>>> 8a20b54 (Add containerisation (2/3))
echo "Lancement des migrations..."
export PATH="$PATH:$HOME/go/bin"
goose up

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 8a20b54 (Add containerisation (2/3))

    echo "Exécution des insertions..."
    export PGPASSWORD=$POSTGRES_PASSWORD
    psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f ./insertions.sql
<<<<<<< HEAD
=======
# Puis exécuter insertions.sql
echo "Exécution des insertions..."
psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f /docker-entrypoint-initdb.d/insertions.sql
>>>>>>> 31c710f (Add containerisation (app, postgres, pgadmin))
=======
>>>>>>> 8a20b54 (Add containerisation (2/3))

# Enfin, lancer le container principal
exec "$@"
