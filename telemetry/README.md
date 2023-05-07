# telemetry.zigtools.org

## Production

`docker-compose up [-d]`

## Development

Modify SITE_ADDRESS in `docker-compose.yml`, then `docker-compose up`

## Testing

To ensure all aspects of Jaeger are functional as configured on localhost, I recommend invoking `test/span.py` multiple times and viewing both traces and metrics.
