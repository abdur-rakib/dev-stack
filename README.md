# Dev Stack

This project provides a professional development stack using Docker Compose, including:

- Redis
- RabbitMQ
- MySQL & Adminer
- EFK stack (Elasticsearch, Fluentd, Kibana)
- Jenkins
- Grafana
- Cassandra
- MinIO
- SFTP

## Setup

1. Copy `.env.example` to `.env` and update secrets.
2. Run `docker-compose up -d` to start all services.
3. Access web UIs as documented below.

## Environment Management

- All secrets and config are managed via `.env`.
- Custom configs can be placed in `config/`.
- Persistent data is stored in `data/`.

## Service Ports

| Service       | Port(s)     |
| ------------- | ----------- |
| Redis         | 6379        |
| RabbitMQ      | 5672, 15672 |
| MySQL         | 3306        |
| Adminer       | 8080        |
| Elasticsearch | 9200        |
| Kibana        | 5601        |
| Jenkins       | 8081        |
| Grafana       | 3000        |
| Cassandra     | 9042        |
| MinIO         | 9000, 9001  |
| SFTP          | 22          |

## Troubleshooting

- Check logs with `docker-compose logs <service>`
- For persistent issues, remove volumes and restart.
