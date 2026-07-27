#!/usr/bin/env bash
# Arranque explícito de desarrollo con hot reload.

set -euo pipefail

cd "$(dirname "$0")"

echo "==> Entorno: development"
echo "==> Compose: docker-compose.yml + docker-compose.override.yml"

if [[ ! -f .env && -f .env.example ]]; then
  echo "==> Creando .env desde .env.example"
  cp .env.example .env
fi

# Usa override automáticamente (hot reload habilitado).
docker compose up --build "$@"
