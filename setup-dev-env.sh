
#!/bin/bash
# Script to initialize environment files for development

set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color



# Always copy .env.example to .env if .env.example exists
echo -e "${BLUE}==============================="
echo -e "   Dev Stack Setup Script"
echo -e "===============================${NC}"
echo -e "${YELLOW}Copying .env.example to .env if .env.example exists...${NC}"
if [ -f .env.example ]; then
  cp -f .env.example .env
fi



# Always copy docker-compose.override.example.yml to docker-compose.override.yml if example exists
echo -e "${YELLOW}Copying docker-compose.override.example.yml to docker-compose.override.yml if example exists...${NC}"
if [ -f docker-compose.override.example.yml ]; then
  cp -f docker-compose.override.example.yml docker-compose.override.yml
fi



# Always copy service.example.env to service.env in .envs if example exists
echo -e "${YELLOW}Copying service.example.env to service.env in .envs if example exists...${NC}"
for example in .envs/*.example.env; do
  service_env="${example/.example.env/.env}"
  if [ -f "$example" ]; then
    cp -f "$example" "$service_env"
  fi
done

# Copy all service.example.conf to service.conf in config folders
echo -e "${YELLOW}Copying service.example.conf to service.conf in config folders...${NC}"
for example_conf in config/*/*.example.conf; do
  conf_file="${example_conf/.example.conf/.conf}"
  if [ -f "$example_conf" ]; then
    cp "$example_conf" "$conf_file"
  fi
done

echo -e "${GREEN}✔ Environment initialization complete.${NC}"
