#!/bin/bash

sleep 10 #let MariaDB be created

if [ -f /var/www/wordpress/wp-config.php ]
then
    echo "WordPress database already exists"

else
    echo "WordPress configuration ongoing..."
    wp config create \
        --path=/var/www/wordpress \
        --dbname=$WP_NAME \
        --dbuser=$WP_USER \
        --dbpass=$WP_PASSWORD \
        --dbhost=$WP_HOST \
        --dbprefix="wp_" \
        --allow-root

    echo -e "\e[32mwp-config.php is created\e[0m"

fi

exec /usr/sbin/php-fpm7.4 -F #-F to execute php