FROM    debian:bullseye-slim

# RUN     apt-get update -y && apt-get upgrade -y
RUN     apt-get update -y
RUN     apt-get install -y  php7.4\
    wget \
    php-fpm\
    php-mysql\
    mariadb-client

RUN     wget https://fr.wordpress.org/wordpress-6.8-fr_FR.tar.gz -P /var/www

RUN     cd /var/www && tar -xzf wordpress-6.8-fr_FR.tar.gz && rm wordpress-6.8-fr_FR.tar.gz

RUN	    chown -R root:root /var/www/wordpress

#COPY    conf/wp-config.php /var/www/wordpress


#CLI = command line interface, text-based interface with commands to input to interact with the OS
RUN     wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN     chmod +x wp-cli.phar
RUN     mv wp-cli.phar /usr/local/bin/wp

#copy conf in php direcory
COPY    ./conf/www.conf /etc/php/7.4/fpm/pool.d

#enable php and cli script
COPY    ./conf/cli_config.sh .
RUN     chmod +x cli_config.sh
RUN     mkdir /var/run/php

EXPOSE  9000

ENTRYPOINT  ["/cli_config.sh"]