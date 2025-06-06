#!/bin/sh

/etc/init.d/mariadb start;

DB_ALREADY_EXISTS=$(mysql -uroot -p$SQL_ROOT_PASSWORD -e "SHOW DATABASES" | grep $SQL_DATABASE | wc -l);

if [ $DB_ALREADY_EXISTS -eq 1 ]; then
	echo "Database already exists";
else
	echo "Database does not exist";
	mysql_secure_installation << END
Y
$SQL_ROOT_PASSWORD
$SQL_ROOT_PASSWORD
Y
Y
Y
Y
END


mysql -uroot -p$SQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $SQL_DATABASE;"

mysql -uroot -p$SQL_ROOT_PASSWORD -e "CREATE USER '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD'; GRANT ALL PRIVILEGES ON $SQL_DATABASE.* TO '$SQL_USER'@'%'; FLUSH PRIVILEGES;";

fi

sleep 1;

/etc/init.d/mariadb stop;

exec "$@";