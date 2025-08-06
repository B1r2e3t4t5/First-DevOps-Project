#!/bin/bash
set -e

# Wait for PostgreSQL to become available
echo "Waiting for PostgreSQL..."
until pg_isready -h "$POSTGRES_HOST" -p "$POSTGRES_PORT" -U "$POSTGRES_USER"; do
  sleep 1
done

echo "PostgreSQL is ready. Running migrations..."
bundle exec rails db:prepare

echo "Starting Rails server with Puma..."
exec bundle exec puma
