#!/bin/bash
# Script to prepare dev env and run selected services

set -e

# Prepare dev env
./setup-dev-env.sh


# Service list
all_services=(redis rabbitmq mysql adminer elasticsearch kibana fluentd jenkins grafana cassandra minio sftp)


# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper to run services
run_services() {
  local services=("$@")
  echo -e "${GREEN}Running services: ${services[*]}${NC}"
  docker-compose -f docker-compose.yml -f docker-compose.override.yml up -d ${services[*]}
}



# Menu
echo -e "${BLUE}==============================="
echo -e "      Dev Stack Manager"
echo -e "===============================${NC}"
echo -e "${YELLOW}Select an option:${NC}"
echo -e "${GREEN}1)${NC} Run all services"
echo -e "${GREEN}2)${NC} Run a single service"
echo -e "${GREEN}3)${NC} Stop all containers"
echo -e "${GREEN}4)${NC} Stop a single container"
echo -e "${GREEN}5)${NC} Stop and remove all containers"
echo -e "${GREEN}6)${NC} Stop and remove a single container"
echo -e "${GREEN}7)${NC} Remove unused images"
echo -e "${GREEN}8)${NC} Run Redis, MySQL, Cassandra, Adminer, RabbitMQ only"
echo -e "${BLUE}-------------------------------${NC}"
read -p "Enter your choice [1-8]: " choice

case $choice in
  8)
    run_services redis mysql cassandra adminer rabbitmq
    ;;
  1)
    run_services "${all_services[@]}"
    ;;
  2)
    echo -e "${YELLOW}Select a service to run:${NC}"
    select service in "${all_services[@]}"; do
      if [[ -n "$service" ]]; then
        run_services "$service"
        break
      else
        echo -e "${RED}Invalid selection.${NC}"
      fi
    done
    ;;
  3)
  echo -e "${YELLOW}Stopping all containers...${NC}"
  docker-compose -f docker-compose.yml -f docker-compose.override.yml stop
    ;;
  4)
    echo -e "${YELLOW}Select a service to stop:${NC}"
    select service in "${all_services[@]}"; do
      if [[ -n "$service" ]]; then
        docker-compose -f docker-compose.yml -f docker-compose.override.yml stop "$service"
        break
      else
        echo -e "${RED}Invalid selection.${NC}"
      fi
    done
    ;;
  5)
  echo -e "${YELLOW}Stopping and removing all containers...${NC}"
  docker-compose -f docker-compose.yml -f docker-compose.override.yml down
    ;;
  6)
    echo -e "${YELLOW}Select a service to stop and remove:${NC}"
    select service in "${all_services[@]}"; do
      if [[ -n "$service" ]]; then
        docker-compose -f docker-compose.yml -f docker-compose.override.yml stop "$service"
        docker-compose -f docker-compose.yml -f docker-compose.override.yml rm -f "$service"
        break
      else
        echo -e "${RED}Invalid selection.${NC}"
      fi
    done
    ;;
  7)
  echo -e "${YELLOW}Removing unused images...${NC}"
  docker image prune -f
    ;;
  *)
    echo -e "${RED}Invalid choice.${NC}"
    exit 1
    ;;
esac
