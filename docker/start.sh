#!/usr/bin/env sh

echo "Installing dependencies ================================="
mix deps.get

# echo "Creating Database ======================================="
# mix ecto.create

# echo "Migrating Database ======================================"
# mix ecto.migrate

# echo "Installing node packages ================================"
# npm --prefix assets install

# echo "Starting iex terminal with mix =========================="
# iex -S mix

echo "Starting application with mix run --no-halt ==============="
mix run --no-halt
