#!/usr/bin/env bash
# Script de Despliegue en Producción (GCP VM) con Nginx y SSL Certbot
set -euo pipefail

cd "$(dirname "$0")"

DOMINIO="${NEXT_PUBLIC_MAIN_DOMAIN:-dmhub.fun}"
EMAIL="${CERTBOT_EMAIL:-admin@${DOMINIO}}"

echo "=========================================="
echo "==> Entorno: Deploy Producción GCP VM"
echo "==> Dominio: ${DOMINIO}"
echo "=========================================="

# 1. Asegurar archivo .env
if [[ ! -f .env && -f .env.example ]]; then
  echo "==> Creando .env desde .env.example"
  cp .env.example .env
fi

# 2. Crear directorios necesarios para Certbot y Nginx
CERT_DIR="./certbot/conf/live/${DOMINIO}"
mkdir -p "${CERT_DIR}"
mkdir -p "./certbot/www"

# 3. Si no existe un certificado SSL previo, generar un certificado autofirmado temporal
# Esto permite que Nginx arranque correctamente en el puerto 443 antes de ejecutar Certbot.
if [[ ! -f "${CERT_DIR}/fullchain.pem" ]]; then
  echo "==> Generando certificado SSL inicial de prueba para arranque de Nginx..."
  openssl req -x509 -nodes -newkey rsa:2048 -days 1 \
    -keyout "${CERT_DIR}/privkey.pem" \
    -out "${CERT_DIR}/fullchain.pem" \
    -subj "/CN=${DOMINIO}" 2>/dev/null || true
fi

# 4. Forzar el uso exclusivo de docker-compose.yml en producción (sin override dev)
export COMPOSE_FILE=docker-compose.yml

echo "==> Desplegando servicios con Docker Compose (Puerto 80/443 expuestos)..."
docker compose --profile production up -d --build --remove-orphans "$@"

# 5. Obtener / Renovar certificado SSL con Certbot mediante desafío HTTP-01
echo "==> Solicitando/Verificando certificado SSL Let's Encrypt con Certbot..."
if command -v certbot &> /dev/null; then
  certbot certonly --webroot -w ./certbot/www \
    -d "${DOMINIO}" -d "www.${DOMINIO}" \
    --agree-tos --email "${EMAIL}" --non-interactive \
    --keep-until-expiring || true

  if [[ -d "/etc/letsencrypt/live/${DOMINIO}" ]]; then
    cp -rL /etc/letsencrypt/live/${DOMINIO}/* "${CERT_DIR}/" 2>/dev/null || true
  fi
else
  echo "==> Certbot local no detectado. Ejecutando Certbot mediante contenedor Docker..."
  docker run --rm \
    -v "$(pwd)/certbot/conf:/etc/letsencrypt" \
    -v "$(pwd)/certbot/www:/var/www/certbot" \
    certbot/certbot certonly --webroot -w /var/www/certbot \
    -d "${DOMINIO}" -d "www.${DOMINIO}" \
    --agree-tos --email "${EMAIL}" --non-interactive \
    --keep-until-expiring || true
fi

# 6. Recargar Nginx para aplicar certificados reales
echo "==> Recargando Nginx con certificados SSL activos..."
docker compose --profile production exec nginx nginx -s reload || true

echo "=========================================="
echo "==> Deploy completado exitosamente!"
echo "=========================================="
docker compose ps
