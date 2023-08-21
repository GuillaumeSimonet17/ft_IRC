#!/bin/bash

wordpress_dir="/var/www/html/wordpress"

# Check if the WordPress directory already exists
# if [ -d "$wordpress_dir" ]; then
#   echo "WordPress is already installed in $wordpress_dir. Skipping installation."
# else
  # Change directory to where the wordpress file will be downloaded
  cd "$wordpress_dir"

  # Download wordpress files
  wp core download --path="$wordpress_dir" --allow-root

  # Generate and configure wp-config.php - Including database connection info
  wp config create --path="$wordpress_dir" --allow-root --dbname="$DB_DATABASE" --dbuser="$DB_USER" --dbpass="$DB_USER_PASSWORD" --dbhost="$DB_HOST" --dbprefix=wp_

  # Install wordpress - configure URL / Title / Admin info
  # Also creates wordpress tables in the database
  wp core install --path="$wordpress_dir" --allow-root --url="$DOMAIN_NAME" --title="$WP_SITE_TITLE" --admin_user="$WP_ADMIN" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL"

  wp plugin update --allow-root --all

  # Create a new user
  wp user create --path="$wordpress_dir" --allow-root "$WP_USER" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASSWORD"

  # Permissions to WWW-DATA for the upload directory | -R EXECUTE ROOT
  chown www-data:www-data "$wordpress_dir/wp-content/uploads" -R

# LAUNCH PHP-FPM
mkdir -p /run/php/
php-fpm7.3 -F