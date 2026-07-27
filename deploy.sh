#!/usr/bin/env bash
# Deploy local/servidor usando solo la composicion base (sin override de development).

set -euo pipefail

cd "$(dirname "$0")"

echo "==> Entorno: deploy"
echo "==> Compose: docker-compose.yml (sin override)"

if [[ ! -f .env && -f .env.example ]]; then
  echo "==> Creando .env desde .env.example"
  cp .env.example .env
fi

# Si existe override de development, no se usa en deploy.
if [[ -f docker-compose.override.yml ]]; then
  export COMPOSE_FILE=docker-compose.yml
fi

# Despliegue en background para entornos tipo servidor.
docker compose up -d --build --remove-orphans "$@"

echo "==> Deploy completado"
docker compose ps
