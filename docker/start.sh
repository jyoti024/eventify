#!/bin/sh
set -e

# Make Apache listen on the port Render provides
PORT="${PORT:-10000}"
sed -i "s/Listen 80/Listen ${PORT}/" /etc/apache2/ports.conf
sed -i "s/<VirtualHost \*:80>/<VirtualHost *:${PORT}>/" /etc/apache2/sites-available/000-default.conf

# Create tables / sample data (retry a few times while the DB wakes up)
i=0
until php /var/www/html/docker/init_db.php; do
    i=$((i+1))
    if [ "$i" -ge 10 ]; then
        echo "Could not initialise the database - check DB_* environment variables." >&2
        break
    fi
    echo "Database not ready, retrying ($i/10)..."
    sleep 5
done

exec apache2-foreground
