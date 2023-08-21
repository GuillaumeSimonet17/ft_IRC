FROM debian:buster

RUN apt update
RUN apt upgrade
RUN apt install mariadb-server -y

ENV DOMAIN_NAME=gusimone.42.fr

ENV DB_DATABASE=wordpress
ENV DB_ROOT_PASSWORD=gusimone
ENV DB_USER=gusimone
ENV DB_USER_PASSWORD=gusimone

RUN service mysql start && mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_DATABASE; \
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD'; \
    GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD'; \
    FLUSH PRIVILEGES;"

COPY ./conf/mariadb.conf ./etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

CMD ["mysqld", "--bind-address=0.0.0.0"]