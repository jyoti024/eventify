FROM php:8.2-apache

# mysqli for the database connection
RUN docker-php-ext-install mysqli

# Keep setup files (schema/seed/scripts) from being served over HTTP
RUN printf '<Directory /var/www/html/docker>\n    Require all denied\n</Directory>\n' \
    > /etc/apache2/conf-available/deny-docker.conf \
    && a2enconf deny-docker

WORKDIR /var/www/html
COPY . /var/www/html/
RUN chown -R www-data:www-data /var/www/html \
    && chmod +x /var/www/html/docker/start.sh

# Render sends traffic to $PORT (default 10000)
ENV PORT=10000
EXPOSE 10000

CMD ["/var/www/html/docker/start.sh"]
