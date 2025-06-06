FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y mariadb-server tini

EXPOSE 3306

COPY ./conf/mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/mariadb.sh"]

CMD ["mysqld", "--bind-address=0.0.0.0"]