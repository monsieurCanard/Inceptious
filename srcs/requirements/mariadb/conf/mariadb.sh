#!/bin/sh


# DB_ALREADY_EXISTS=$(mysql -uroot -p"$SQL_ROOT_PASSWORD" -e "SHOW DATABASES" | grep "$SQL_DATABASE" | wc -l);

/etc/init.d/mariadb start;

# if [ "$DB_ALREADY_EXISTS" -eq 1 ]; then
# 	echo "Database already exists";
# else
	echo "Database does not exist";
	mysql_secure_installation << END
	
	n
	Y
	Y
	Y
	Y
END
wait $!

	echo "Creating database and user";
	mysql -uroot -p"$SQL_ROOT_PASSWORD" -e "ALTER USER 'root' @'localhost' IDENTIFIED BY '$SQL_ROOT_PASSWORD';"

echo "Creating database: $SQL_DATABASE";
	mysql -uroot -p"$SQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS \`$SQL_DATABASE\`;"
	
echo "Creating user: $SQL_USER";
	mysql -uroot -p"$SQL_ROOT_PASSWORD" -e "CREATE USER '$SQL_USER'@'%' IDENTIFIED BY '$SQL_PASSWORD'; GRANT ALL PRIVILEGES ON \`$SQL_DATABASE\`.* TO '$SQL_USER'@'%'; FLUSH PRIVILEGES;"

echo "Database and user created successfully";

# fi


sleep 1;

#/etc/init.d/mariadb stop;
mariadb-admin -u root --password="$SQL_ROOT_PASSWORD" shutdown;

# exec "$@";
exec mariadbd-safe