#! /bin/bash
set -eu -o pipefail

DB="${1:-fosl}"
SCHEMA="database/schema/001_create_core_tables.sql"
SEED="database/seed/001_seed_core_data.sql"

echo "==============================================="
echo "dropping $DB"
dropdb --if-exists "$DB"
echo "creating $DB"
createdb "$DB"
echo "loading schema"
psql -Xq -v ON_ERROR_STOP=1 -d "$DB" -f "$SCHEMA"
echo "stocking tables"
psql -Xq -v ON_ERROR_STOP=1 -d "$DB" -f "$SEED"
echo "$DB rebuilt"
echo "================================================"


