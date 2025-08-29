#!/bin/bash
# Script to prepare dev env and run selected services

set -e

# Prepare dev env
./setup-dev-env.sh

# Service groups
efk_services=(elasticsearch kibana fluentd)
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
echo "2) Run EFK stack (elasticsearch, fluentd, kibana)"
echo "3) Run a single service"
read -p "Enter your choice [1-3]: " choice

case $choice in
  1)
    run_services "${all_services[@]}"
    ;;
  2)
    run_services "${efk_services[@]}"
    ;;
  3)
    echo "Available services:"
    for s in "${all_services[@]}"; do
      echo "- $s"
    done
    read -p "Enter the service name: " service
    run_services "$service"
    ;;
  *)
    echo "Invalid choice."
    exit 1
    ;;
esac
