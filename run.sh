#!/bin/bash
# Script to prepare dev env and run selected services

set -e

# Prepare dev env
./setup-dev-env.sh


# Service list
all_services=(redis rabbitmq mysql adminer elasticsearch kibana fluentd jenkins grafana cassandra minio sftp)

# Helper to run services
run_services() {
  local services=("$@")
  echo "Running services: ${services[*]}"
  docker-compose -f docker-compose.yml -f docker-compose.override.yml up -d ${services[*]}
}


# Menu
echo "Select an option:"
echo "1) Run all services"
echo "2) Run a single service"
echo "3) Stop all containers"
echo "4) Stop a single container"
echo "5) Stop and remove all containers"
echo "6) Stop and remove a single container"
echo "7) Remove unused images"
read -p "Enter your choice [1-7]: " choice

case $choice in
  1)
    run_services "${all_services[@]}"
    ;;
  2)
    echo "Select a service to run:"
    select service in "${all_services[@]}"; do
      if [[ -n "$service" ]]; then
        run_services "$service"
        break
      else
        echo "Invalid selection."
      fi
    done
    ;;
  3)
    echo "Stopping all containers..."
    docker-compose -f docker-compose.yml -f docker-compose.override.yml stop
    ;;
  4)
    echo "Select a service to stop:"
    select service in "${all_services[@]}"; do
      if [[ -n "$service" ]]; then
        docker-compose -f docker-compose.yml -f docker-compose.override.yml stop "$service"
        break
      else
        echo "Invalid selection."
      fi
    done
    ;;
  5)
    echo "Stopping and removing all containers..."
    docker-compose -f docker-compose.yml -f docker-compose.override.yml down
    ;;
  6)
    echo "Select a service to stop and remove:"
    select service in "${all_services[@]}"; do
      if [[ -n "$service" ]]; then
        docker-compose -f docker-compose.yml -f docker-compose.override.yml stop "$service"
        docker-compose -f docker-compose.yml -f docker-compose.override.yml rm -f "$service"
        break
      else
        echo "Invalid selection."
      fi
    done
    ;;
  7)
    echo "Removing unused images..."
    docker image prune -f
    ;;
  *)
    echo "Invalid choice."
    exit 1
    ;;
esac
