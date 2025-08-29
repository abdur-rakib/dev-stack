
#!/bin/bash
# Script to initialize environment files for development

set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color


# Always replace .env with .env.example if both exist
echo -e "${BLUE}==============================="
echo -e "   Dev Stack Setup Script"
echo -e "===============================${NC}"
echo -e "${YELLOW}Replacing .env with .env.example if both exist...${NC}"
if [ -f .env.example ] && [ -f .env ]; then
  cp .env.example .env
fi


# Always replace docker-compose.override.yml with example if both exist
echo -e "${YELLOW}Replacing docker-compose.override.yml with example if both exist...${NC}"
if [ -f docker-compose.override.example.yml ] && [ -f docker-compose.override.yml ]; then
  cp docker-compose.override.example.yml docker-compose.override.yml
fi


# Always replace service.env with service.example.env if both exist
echo -e "${YELLOW}Replacing service.env with service.example.env in .envs...${NC}"
for example in .envs/*.example.env; do
  service_env="${example/.example.env/.env}"
  if [ -f "$example" ] && [ -f "$service_env" ]; then
    cp "$example" "$service_env"
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
