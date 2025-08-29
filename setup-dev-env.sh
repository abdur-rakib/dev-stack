#!/bin/bash
# Script to initialize environment files for development

set -e

# Copy root .env.example to .env if not exists
echo "Copying .env.example to .env..."
if [ -f .env.example ] && [ ! -f .env ]; then
  cp .env.example .env
fi

# Copy docker-compose.override.yml.example to docker-compose.override.yml if not exists
echo "Copying docker-compose.override.yml.example to docker-compose.override.yml..."
if [ -f docker-compose.override.example.yml ] && [ ! -f docker-compose.override.yml ]; then
  cp docker-compose.override.example.yml docker-compose.override.yml
fi

# Copy all service.example.env to service.env inside .envs folder
echo "Copying service.example.env to service.env in .envs..."
for example in .envs/*.example.env; do
  service_env="${example/.example.env/.env}"
  if [ -f "$example" ] && [ ! -f "$service_env" ]; then
    cp "$example" "$service_env"
  fi
done

echo "Environment initialization complete."
