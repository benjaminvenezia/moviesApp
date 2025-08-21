#!/bin/bash
set -e

# Attendre que Postgres soit prêt
until PGPASSWORD=$POSTGRES_PASSWORD psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -c '\q' 2>/dev/null; do
  echo "Attente de PostgreSQL..."
  sleep 1
done

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
echo "Lancement des migrations..."
export PATH="$PATH:$HOME/go/bin"
goose up

export PGPASSWORD=$POSTGRES_PASSWORD

EXISTS=$(psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -tAc "SELECT 1 FROM movies LIMIT 1;")
if [ "$EXISTS" != "1" ]; then
    echo "Running insertions..."
    psql -h "$POSTGRES_HOST" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -f ./insertions.sql
else
    echo "Insertions already applied, skipping."
fi

# Enfin, lancer le container principal
exec "$@"
