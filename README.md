# Eventify – Event Ticket Booking (PHP + MySQL)

## Run locally (XAMPP / WAMP)
1. Copy this folder to `htdocs/` (so the site is at http://localhost/event_ticket_booking/).
2. Start Apache + MySQL, open phpMyAdmin → Import → choose `database.sql`.
3. Visit http://localhost/event_ticket_booking/

Default DB settings (root / no password / `event_booking`) work out of the box.

## Deploy on Render
Render runs this app with the included `Dockerfile`. Render has no MySQL service,
so create a free external MySQL database (e.g. Aiven or TiDB Cloud) and set these
environment variables on the Render web service:

| Variable      | Example                         |
|---------------|---------------------------------|
| DB_HOST       | your-db-host.example.com        |
| DB_PORT       | 3306 (or the port your provider gives) |
| DB_USER       | avnadmin                        |
| DB_PASSWORD   | ********                        |
| DB_NAME       | event_booking (an existing, empty database) |
| DB_SSL        | true                            |

Tables and sample events are created automatically on first start.
Set `SEED_SAMPLE_DATA=false` to skip the sample events.
