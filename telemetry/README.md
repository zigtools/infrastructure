# telemetry.zigtools.org

Backend for ZLS' opt-in telemetry. Uses Jaeger (UI, querying), Prometheus (metrics storage), Clickhouse (traces storage), the contrib OTEL Collector (ingestion), and Caddy (proxy).

## Production

`docker compose --env-file=.prod.env up [-d]`

## Development

Modify SITE_ADDRESS in `docker-compose.yml`, then `docker compose --env-file=.dev.env up`

## Testing

To ensure all aspects of Jaeger are functional as configured on localhost, I recommend invoking `test/span.py` multiple times and viewing both traces and metrics.
