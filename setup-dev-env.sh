#!/bin/bash
# Script to initialize environment files for development

set -e


# Always replace .env with .env.example if both exist
echo "Replacing .env with .env.example if both exist..."
if [ -f .env.example ] && [ -f .env ]; then
  cp .env.example .env
fi


# Always replace docker-compose.override.yml with example if both exist
echo "Replacing docker-compose.override.yml with example if both exist..."
if [ -f docker-compose.override.example.yml ] && [ -f docker-compose.override.yml ]; then
  cp docker-compose.override.example.yml docker-compose.override.yml
fi


# Always replace service.env with service.example.env if both exist
echo "Replacing service.env with service.example.env in .envs..."
for example in .envs/*.example.env; do
  service_env="${example/.example.env/.env}"
  if [ -f "$example" ] && [ -f "$service_env" ]; then
    cp "$example" "$service_env"
  fi
done

echo "Environment initialization complete."
