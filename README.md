# Dev Stack

This repository provides a professional, multi-service development stack using Docker Compose. It is designed for rapid local development, testing, and integration of popular backend technologies.

## Features

- **Service Isolation:** Each service has its own environment and data volume management.
- **Secure Environment:** Secrets and credentials are managed via `.env` and per-service env files.
- **Easy Initialization:** Automated setup and run scripts with graphical terminal UI.
- **Extensible:** Add or remove services easily.

## Included Services

- Redis
- RabbitMQ
- MySQL & Adminer
- Elasticsearch, Fluentd, Kibana (EFK stack)
- Jenkins
- Grafana
- Cassandra
- MinIO
- SFTP

## Quick Start

1. **Clone the repository:**
   ```sh
   git clone https://github.com/abdur-rakib/dev-stack.git
   cd dev-stack
   ```
2. **Initialize environment:**
   ```sh
   ./setup-dev-env.sh
   ```
3. **Start services:**
   ```sh
   ./run.sh
   ```
   Follow the interactive menu to run, stop, or remove services.

## Environment Management

- All secrets and image tags are managed in `.env` (see `.env.example`).
- Per-service environment files are in `.envs/` (see `*.example.env`).
- Custom configs (e.g., Fluentd) are in `config/` (see `*.example.conf`).
- Persistent data is stored in `data/` (empty folders tracked with `.gitkeep`).

## Service Ports

| Service       | Port(s)     | Web UI/Notes         |
| ------------- | ----------- | -------------------- |
| Redis         | 6379        |                      |
| RabbitMQ      | 5672, 15672 | Management UI: 15672 |
| MySQL         | 3306        |                      |
| Adminer       | 8080        | Web UI: 8080         |
| Elasticsearch | 9200        |                      |
| Kibana        | 5601        | Web UI: 5601         |
| Jenkins       | 8081        | Web UI: 8081         |
| Grafana       | 3000        | Web UI: 3000         |
| Cassandra     | 9042        |                      |
| MinIO         | 9000, 9001  | Web UI: 9001         |
| SFTP          | 22          |                      |

## Usage

- **Initialize/Reset Environment:**
  - `./setup-dev-env.sh` (copies example env/config files to real ones)
- **Run/Stop/Remove Services:**
  - `./run.sh` (graphical menu for all common actions)
- **Manual Compose Commands:**
  - `docker-compose -f docker-compose.yml -f docker-compose.override.yml up -d <service>`
  - `docker-compose logs <service>`
  - `docker-compose down`

## Troubleshooting

- **Platform Issues:** If you are on Apple Silicon (ARM), images are forced to `linux/amd64` for compatibility.
- **Image Not Found:** Update image tags in `.env` to valid versions from Docker Hub.
- **SFTP User Error:** Ensure `SFTP_USERS` is set in `.env` and `.envs/sftp.env`.
- **Fluentd Config Error:** Ensure `config/fluentd/fluent.conf` exists and is valid.
- **Kibana/Elasticsearch Auth:** Do not use the `elastic` superuser for Kibana; use a service account or `kibana_system` user.

## Folder Structure

```
dev-stack/
├── .env.example
├── .envs/
│   └── <service>.example.env
├── config/
│   └── <service>/<service>.example.conf
├── data/
│   └── <service>/.gitkeep
├── docker-compose.yml
├── docker-compose.override.yml
├── docker-compose.override.example.yml
├── run.sh
├── setup-dev-env.sh
└── README.md
```

## Contributing

Pull requests and suggestions are welcome! Please open issues for bugs or feature requests.

## License

MIT
