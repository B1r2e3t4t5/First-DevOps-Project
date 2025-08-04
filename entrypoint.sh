#!/bin/bash
set -e

# Wait for PostgreSQL to become available
echo "Waiting for PostgreSQL..."
until pg_isready -h "$POSTGRES_HOST" -p "$POSTGRES_PORT" -U "$POSTGRES_USER"; do
  sleep 1
done

echo "PostgreSQL is ready. Running migrations..."
bundle exec rails db:prepare

echo "Starting Rails server..."
# exec bundle exec rails server -b 0.0.0.0 -p 3000

# Modified to start Puma with SSL binding
exec bundle exec puma -b "ssl://0.0.0.0:3000?cert=config/ssl/server.crt&key=config/ssl/server.key&verify_mode=none"
